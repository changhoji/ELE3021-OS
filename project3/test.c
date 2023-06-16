#include "types.h"
#include "user.h"
#include "stat.h"

#define BUFFERSIZE 1024

int
main(int argc, char *argv[])
{
  int datasize = 16*1024*1024;
  int flag = 0;
  uint written = 0;
  char buf[BUFFERSIZE];
  int fd = open("double.txt", 0x200 | 0x002);

  if(fd == -1){
    printf(2, "failed to open file\n");
    exit();
  }

  int cnt = 0;
  int time = uptime();
  while(written < datasize){
    uint temp = write(fd, buf, BUFFERSIZE);
    if(temp == -1){
      printf(2, "failed to write file\n");
      flag = 1;
      break;
    }
    written += temp;
    cnt++;
    if(cnt % 50 == 0)
      printf(1, "write success: + %d.. => %d\n", temp, written);
  }

  if(flag){
    printf(2, "test failed\n");
    exit();
  }

  printf(1, "written = %d bytes | taken time: %d ticks\n", written, uptime()-time);

  if(close(fd) == -1){
    printf(2, "failed to close file\n");
    exit();
  }

  printf(1, "test success\n"); 
  exit();
}