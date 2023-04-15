// struct queue that contains procs
struct queue {
  struct proc *procs[QUEUESIZE];
  int size;
  int timequantum;
};

// struct mlfq that contains queues
struct mlfq {
  struct queue L[3];
  int locked;  // 1 if scheduler is locked else 0
};