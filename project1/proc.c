#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
  struct proc *lockproc;
  struct queue L[3];
} ptable;

static struct proc *initproc; 

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

extern uint mlfqticks;
extern struct spinlock mlfqtickslock;

static void wakeup1(void *chan);

void
pinit(void)
{
  int i;

  initlock(&ptable.lock, "ptable");

  ptable.lockproc = 0; // locked by no process

  for (i = 0; i < 3; i++){
    ptable.L[i].size = 0; // queue size
    ptable.L[i].timequantum = 2*i+4; // queue time quantum
  }  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->priority = 3; // set to 3 in first
  p->usedtime = 0;
  p->level = 0; // put in L0 queue

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  enqueue(&ptable.L[p->level], p); // enqueue when runnable

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  enqueue(&ptable.L[np->level], np); // enqueue when runnable

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;

  if(ptable.lockproc){
    ptable.lockproc = 0;
  }
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  mlfqscheduler();
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  struct proc *p = myproc();

  acquire(&ptable.lock);  //DOC: yieldlock

  // when lock process execute yield, don't execute context switch
  if(ptable.lockproc){
    if(ptable.lockproc->pid == p->pid){ 
      release(&ptable.lock);
      return;
    }
  }

  p->state = RUNNABLE;

  enqueue(&ptable.L[p->level], p); // enqueue when runnable
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan){
      p->state = RUNNABLE;
      enqueue(&ptable.L[p->level], p); // enqueue when runnable
    }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
        p->state = RUNNABLE;
        enqueue(&ptable.L[p->level], p); // enqueue when runnable
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

// [System Calls]

// Get level of queue where the process is in
int
getLevel(void)
{
  return myproc()->level;
}

// Set priority of the process whose pid is pid
void
setPriority(int pid, int priority)
{
  struct proc *p;

  // don't do setPriority if priority is invalid
  if(priority < 0 || priority > 3){
    cprintf("[!] invalid priority in setPriority");
    return;
  }
  
  // find proc and set new priority
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->pid == pid){
      p->priority = priority;
      return;
    }
  
  cprintf("[!] cannot find process\n");
}

// Lock mlfq scheduler
void
schedulerLock(int password)
{
  struct proc *p = myproc();

  // invalid password
  if(password != PASSWORD){
    cprintf("[!] invalid password in schedulerLock - pid: %d, timequantum: %d, level: %d\n", p->pid, p->usedtime, p->level);
    exit();
  }

  acquire(&ptable.lock);

  if(ptable.lockproc){
    // locked by this process
    if(ptable.lockproc->pid == p->pid){
      cprintf("[!] scheduler is already locked by this process\n");
      release(&ptable.lock);
      return;
    }
    // locked by another process
    else{
      cprintf("[!] shceudler is already locked by another process\n");
      release(&ptable.lock);
      return;
    }
  }

  // perfome locking mlfq
  ptable.lockproc = p;

  release(&ptable.lock);

  // reset global ticks
  acquire(&mlfqtickslock);
  mlfqticks = 0;
  release(&mlfqtickslock);
}

// Unlock mlfq scheduler
void
schedulerUnlock(int password)
{
  struct proc *p = myproc();

  // invalid password
  if(password != PASSWORD){
    cprintf("[!] invalid password in schedulerUnlock - pid: %d, timequantum: %d, level: %d\n", p->pid, p->usedtime, p->level);
    exit();
  }

  acquire(&ptable.lock);

  // not locked
  if(ptable.lockproc == 0){
    cprintf("[!] scheduler is not locked\n");
    release(&ptable.lock);
    return;
  }

  // locked by another process
  if(ptable.lockproc->pid != p->pid){
    cprintf("[!] scheduler is locked by another process\n");
    release(&ptable.lock);
    return;
  }

  // reset process values
  ptable.lockproc = 0;
  p->level = 0;
  p->usedtime = 0;
  p->priority = 3;

  // input in front of L0 queue
  p->state = RUNNABLE;
  insertqueue(&ptable.L[0], p);

  // call sched for going to scheduler again
  sched();

  release(&ptable.lock);
}

// [mlfq functions]

// Enqueues proc
void
enqueue(struct queue* q, struct proc* proc)
{
  if (q->size < NPROC){
    q->procs[q->size] = proc;
    q->size++;
  }
}

// Dequeues proc
void
dequeue(struct queue* q)
{
  int i;

  if (q->size > 0){
    for (i = 0; i < q->size-1; i++){
      q->procs[i] = q->procs[i+1];
    }
    q->size--;
  }
}

void remove(struct queue* q, int pid){
  int i;
  struct proc *p;

  // find proc to remove
  for(i = 0; i < q->size; i++){
    p = q->procs[i];
    if(p->pid == pid){
      break;
    }
  }
  
  // pull procs
  if(i < q->size){
    for(; i < (q->size)-1; i++){
      q->procs[i] = q->procs[i+1];
    }
    q->size--;
  }
}

void insertqueue(struct queue* q, struct proc* p){
  int i;

  if(q->size < NPROC){
    for(i = q->size; i > 0; i--){
      q->procs[i] = q->procs[i-1];
    }
    // insert into front of queue
    q->procs[0] = p;
    q->size++;
  }
}

// New scheduler with mlfq
void
mlfqscheduler(void)
{
  int i;
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;

  for(;;){
    sti();

    acquire(&ptable.lock);

    p = 0; // reset to process that will be scheduled

    // find process to run from L0 to L2
    for(i = 0; i < 3; i++)
      if(ptable.L[i].size > 0){
        p = ptable.L[i].procs[0];
        break;
      }

    // perfome context switching
    if(p){

      if(p->level == 2){
        for(i = 1; i < ptable.L[2].size; i++){
          if(ptable.L[2].procs[i]->priority < p->priority)
            p = ptable.L[2].procs[i];
        }
      }

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      if(p->level == 2)
        remove(&ptable.L[2], p->pid);
      else
        dequeue(&ptable.L[p->level]);

      // increase time quantum
      p->usedtime++;

      if(p->usedtime >= ptable.L[p->level].timequantum){
        if(p->level < 2){ // in L0 and L1 queue
          p->usedtime = 0;
          p->level++; // will be enqueued in next queue later
        }
        else{ // in L2 queue
          p->usedtime = 0;
          if(p->priority > 0)
            p->priority--;
        }
      }

      // context switch to p
      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;
    }

    release(&ptable.lock);
  }
}

// Execute priority boosting
void
priorityboosting(void)
{
  int i, s;
  struct proc *p;
   
  acquire(&ptable.lock);

  for(i = 0; i < 3; i++)
    for(s = 0; s < ptable.L[i].size; s++){
      p = ptable.L[i].procs[0]; // get front
      p->priority = 3;
      p->usedtime = 0;
      p->level = 0;
      if(i > 0){ // except in L0 queue
        dequeue(&ptable.L[i]);  
        enqueue(&ptable.L[0], p);
      }
    }

  if(ptable.lockproc){
    p = ptable.lockproc;
    ptable.lockproc = 0;
    p->level = 0;
    p->usedtime = 0;
    p->priority = 3;
  }

  release(&ptable.lock);
}
