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
  int disabled; // mlfq scheduler lock
  struct queue L[3];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);
extern struct mlfq mlfq;

static void wakeup1(void *chan);

void
pinit(void)
{
  int i;

  initlock(&ptable.lock, "ptable");

  acquire(&ptable.lock);

  ptable.disabled = 0;

  for (i = 0; i < 3; i++){
    ptable.L[i].size = 0;
    ptable.L[i].timequantum = 2*i+4;
  }

  release(&ptable.lock);
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
  enqueue(&(ptable.L[0]), p);

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
  int flag = 1;
  if (flag)
    mlfqscheduler();
  else{

  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
    
  }
  }
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
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
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
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
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
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
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

// Get level of queue where the process is in
int
getLevel(void)
{
  struct proc *p = myproc();

  return p->level;
}

// Set priority of the process whose pid is pid
void
setPriority(int pid, int priority)
{
  struct proc *p;
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->pid == pid)
      p->priority = priority;
}

// Lock mlfq scheduler
void
schedulerLock(int password)
{
  int i;
  struct proc *p = myproc();

  if(password != PASSWORD){
    cprintf("invalid password in schedulerLock - pid: %d, timequantum: %d, level: %d\n", p->pid, p->usedtime, p->level);
    exit();
  }

  acquire(&ptable.lock);
  acquire(&tickslock);

  ptable.disabled = 1;

  // insert to L0 queue to scheduling first
  for(i = ptable.L[0].size; i > 0; i--){
    ptable.L[0].procs[i] = ptable.L[0].procs[i-1];
  }
  ptable.L[0].procs[0] = p;
  ptable.L[0].size++;

  ticks = 0; // reset global ticks

  release(&tickslock);
  release(&ptable.lock);
}

// Unlock mlfq scheduler
void
schedulerUnlock(int password)
{
  struct proc *p = myproc();

  if(password == PASSWORD){
    cprintf("invalid password in schedulerUnlock - pid: %d, timequantum: %d, level: %d\n", p->pid, p->usedtime, p->level);
    exit();
  }

  acquire(&ptable.lock);

  ptable.disabled = 0;
  p->usedtime = 0;
  p->priority = 3;

  release(&ptable.lock);
}


// mlfq functions

// Enqueues proc
void
enqueue(struct queue* q, struct proc* proc)
{
  // cprintf("enqueue! - %s (%d) (state=%d)\n", proc->name, proc->pid, proc->state);
  if (q->size < QUEUESIZE){
    q->procs[q->size] = proc;
  }
  (q->size)++;
}

// Dequeues proc
void
dequeue(struct queue* q)
{
  int i;
  // cprintf("dequeue!\n");

  if (q->size > 0){
    for (i = 0; i < q->size-1; i++){
      q->procs[i] = q->procs[i+1];
    }
  }
  // size = 4
  // 0 1 2 3
  // ls

  (q->size)--;
}

// Get front of queue
struct proc* front(struct queue* q)
{
  if (q->size <= 0) return 0;
  return q->procs[0];
}

void remove(struct queue* q, int pid){
  int i;
  struct proc *p;

  for(i = 0; i < q->size; i++){
    p = q->procs[i];
    if(p->pid == pid){
      break;
    }
  }

  if(i < q->size){
    for(; i < (q->size)-1; i++){
      q->procs[i] = q->procs[i+1];
    }
  }
}

// New scheduler with mlfq
void
mlfqscheduler(void)
{
  int i;
  int runned;
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;

  for(;;){
    sti();


    acquire(&ptable.lock);

    // if(ticks == 0)
    //   printqueue(&(ptable.L[0]));

    // scheduling in L0

    runned = 0; // check in L0 if a process worked

    for(i = 0; i < ptable.L[0].size; i++){
      p = front(&ptable.L[0]); // get front of queue

      // if the process is non runnable, dequeue and enqueue
      if(p->state != RUNNABLE){
        dequeue(&ptable.L[0]);
        if(p->state != ZOMBIE && p->state != UNUSED) //when zombie or unused, don't enqueue again
          enqueue(&ptable.L[0], p);
  
        continue;
      }

      // perfome context switching

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;

      // increase usedtime
      p->usedtime++;

      if(ptable.disabled)
        break;

      dequeue(&ptable.L[0]);

      // enqueue again if there is more time to can use,
      // else enqueue in next queue
    if(p->usedtime < ptable.L[0].timequantum)
        enqueue(&ptable.L[0], p);
      else{
        p->level = 1;
        p->usedtime = 0;
        enqueue(&ptable.L[1], p);
      }

      runned = 1;
      break;
    }
    // if runned, re-run scheduler
    if (runned){
      release(&ptable.lock);
      continue;
    }

    // scheduling in L1

    runned = 0;
    for(i = 0; i < ptable.L[1].size; i++){
      p = front(&ptable.L[1]);

      if(p->state  != RUNNABLE){
        dequeue(&ptable.L[1]);
        if(p->state != ZOMBIE && p->state != UNUSED)
          enqueue(&ptable.L[1], p);

        continue;
      }

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;
      
      // increase usedtime
      p->usedtime++;

      dequeue(&ptable.L[1]);

      if(p->usedtime < ptable.L[0].timequantum)
        enqueue(&ptable.L[1], p);
      else{
        p->level = 2;
        p->usedtime = 0;
        enqueue(&ptable.L[2], p);
      }

      runned = 1;
      break;
    }

    if (runned){
      release(&ptable.lock);
      continue;
    }

    // scheduling in L2

    runned = 0; // used to check is there existing runnable process in L2 queue

    for(i = 0; i < ptable.L[2].size; i++){
      p = ptable.L[2].procs[i];
      if(p->state == ZOMBIE || p->state == UNUSED){
        remove(&ptable.L[2], p->pid);
        i++;
      }
      if(p->state == RUNNABLE){
        runned = 1;
        i++;
        break;
      }
    }
  
    if(runned){ // can run process in L2 queue
      for(; i < ptable.L[2].size; i++){
        if(p->priority > ptable.L[2].procs[i]->priority){
          p = ptable.L[2].procs[i];
        }
      }

      if(p->state != RUNNABLE){
        release(&ptable.lock);
        continue;
      }

      // cprintf("pid: %d\n", p->pid);

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;

      p->usedtime++;
      
      if(p->usedtime >= ptable.L[2].timequantum){
        p->usedtime = 0;
        if(p->priority >= 1)
          p->priority--;
      }
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

  // enable mlfq scheduling
  ptable.disabled = 0;

  for(i = 0; i < 3; i++){
    for(s = 0; s < ptable.L[i].size; s++){
      p = ptable.L[i].procs[0];
      p->priority = 3;
      p->usedtime = 0;
      p->level = 0;
      if(i != 0){ // in L0 queue
        dequeue(&ptable.L[i]);  
        enqueue(&ptable.L[0], p);
      }
    }
  }

  release(&ptable.lock);
}

void 
printqueue(struct queue* q){
  
  
  // cprintf("\n");
}