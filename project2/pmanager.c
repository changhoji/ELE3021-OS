#include "types.h"
#include "user.h"

int
getcmd(char *buf, int nbuf)
{
  printf(2, "& ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
  buf[strlen(buf)-1] = 0;
  return 0;
}

int
main(void)
{
  static char buf[100];
  
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(!strcmp(buf, "list")){
      showprocs();
    }
    else if(!strcmp(buf, "exit")){
      printf(2, "terminate pmanager\n");
      exit();
    }
  }
}
