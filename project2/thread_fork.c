#include "types.h"
#include "user.h"

void* 
thread_func(void *arg)
{
  int i = 1;
  printf(1, "thread in start_routine\n");
  printf(1, "\targ: %d\n", (int)arg);
  if (fork() == 0){
    printf(1, "child of thread, i=%d\n", i);
    exit();
  }
  wait();
  thread_exit((void*)200);
  exit();
}

int
main(int argc, char *argv[])
{   
  thread_t thread;
  int arg = 123;
  thread_create(&thread, thread_func, (void *)arg);

  void *retval;
  thread_join(thread, &retval);
  printf(1, "join retval: %d\n", (int)retval);

  exit();
}