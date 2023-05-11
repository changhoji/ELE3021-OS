#include "types.h"
#include "stat.h"
#include "user.h"

#define NUM_LOOP 100000
#define NUM_YIELD 20000
#define NUM_SLEEP 500

#define NUM_THREAD 4
#define MAX_LEVEL 3 // 3
#define password 2021035487

int parent;

int main(int argc, char* argv[])
{
  parent = getpid();

  printf(1, "\nMLFQ test start\n");
  int pid = 0;
  char cmd = argv[1][0];

  switch (cmd) {
    case '1':
      printf(1, "test - yield\n\n");

      if((pid = fork()) != 0){ // parent
        printf(1, "in parent, call yield\n");
        yield();
        printf(1, "hello world\n");
        wait();
      }
      else{ // child
        for(int i = 0; i < 5; i++){
          printf(1, "child %d\n", i);
        }
        exit();
      }
      break;

    case '2':
      printf(1, "test - lock\n\n");

      if((pid = fork()) != 0){
        printf(1, "in parent, lock!\n");
        schedulerLock(password);
        for(int i = 0; i < 10000; i++){
          printf(1, " %d", i);
          if (i % 50 == 0)printf(1, "\n");
          if (i == 1000) schedulerUnlock(password);
        }
        wait();
      }
      else{
        printf(1, "child..\n");
        for(int i = 0; i < 10000; i++){
          printf(1, " #");
          if (i % 50 == 0)printf(1, "\n");
        }
        exit();
      }
      break;
    case '3':
      printf(1, "test - setpriority\n\n");
      if((pid = fork()) != 0){
        setPriority(pid, 0);
        for(int i = 0; i < 2000; i++){
          printf(1, " p%d", i);
          if (i % 30 == 0) printf(1, "\n");
        }
        wait();
      }
      else{
        for(int i = 0; i < 2000; i++){
          printf(1, " c%d", i);
          if (i % 30 == 0) printf(1, "\n");
        }
        exit();
      }
      break;
  default:
    printf(1, "WRONG CMD\n");
    break;
  }


  printf(1, "done\n\n");
  exit();
}

