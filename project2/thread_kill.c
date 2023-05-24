#include "types.h"
#include "user.h"

void *
threadfunc(void *arg)
{
  printf(1, "thread created [%d]\n", (int)arg);
  while(1){}

  return 0;
}

int
main(int argc, char **argv)
{
  int i;
  thread_t t[3];
  
  for(i = 0; i < 3; i++){
    thread_create(&t[i], threadfunc, (void*)i);
  }
  for(i = 0; i < 3; i++){
    int retval;
    thread_join(t[i], (void **)&retval);
  }
  exit();
}