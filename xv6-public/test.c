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

  printf(1, "MLFQ test start\n");
  int pid = 0;
  char cmd = argv[1][0];

  switch (cmd) {
    case '1':
      printf(1, "test - yield");
      if((pid = fork()) != 0){ // parent
        printf(1, "in parent, call yield\n");
        yield();
        wait();
      }
      else{ // child
        for(int i = 0; i < 10; i++){
          printf(1, "child %d\n", i);
        }
        exit();
      }
      break;

    case '2':
      break;
    case '3':
      break;
  default:
    printf(1, "WRONG CMD\n");
    break;
  }


  printf(1, "done\n");
  exit();
}

