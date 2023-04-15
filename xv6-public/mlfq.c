#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "mlfq.h"

struct mlfq mlfq;

// Init MultiLevel Feedback Queue
void
mlfqinit(void)
{
  int i;

  for (i = 0; i < 3; i++){
    mlfq.L[i].size = 0;
    mlfq.L[i].timequantum = 2*i+4;
  }
  mlfq.locked = 0;
}

// Enqueues proc
void
enqueue(struct queue* q, struct proc* proc)
{
  if (q->size < QUEUESIZE){
    q->procs[(q->size)++] = proc;
  }
}

// Dequeues proc
void
dequeue(struct queue* q, struct proc* proc)
{
  int i;

  if (q->size >= 0){
    for (i = 0; i < q->size-1; i++){
      q->procs[i] = q->procs[i+1];
    }
  }

  (q->size)--;
}

// Get front of queue
struct proc* front(struct queue* q)
{
  if (q->size <= 0) return 0;
  return q->procs[0];
}

// New scheduler with mlfq
void
mlfqscheduler(void)
{
}

// Execute priority boosting
void
priorityboosting(void)
{
}