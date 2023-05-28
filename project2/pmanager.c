#include "types.h"
#include "user.h"

int cnt = 0;
char *argv[] = {};

int
getcmd(char *buf, int nbuf)
{
  printf(2, "& ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
  if(buf[nbuf-1] != 0) // buffer size over
    return -1;

  buf[strlen(buf)-1] = '\0';
  return 0;
}

char*
getword(char *buf, char *word, int nword){
  if(*buf == '\0')
    return 0;

  memset(word, 0, nword);
  while(1){
    if(*buf == '\0'){
      *word = '\0';
      break;
    }
    if(*buf == ' '){
      buf++;
      *word = '\0';
      break;
    }
    *word = *buf;
    buf++, word++;
  }

  return buf;
}

int
stoi(char *str, int *res){
  int result = 0;
  
  while(*str != '\0'){
    if(*str < '0' || *str > '9')
      return -1;
    result *= 10;
    result += (*str - '0');

    str++;    
  }

  *res = result;
  return 0;
}


void*
test(void* a)
{
  int flag = 0;
  cnt++;
  printf(2, "Hello, World\n");
  while(1){
    if (uptime()%100 == 0 && flag){
      printf(2, "hi! [%d]\n", cnt);
      flag = 0;
    }
    else if(uptime()%100 != 0)
      flag = 1;
  }
  return 0;
}

void*
test2(void* a)
{
  printf(2, "Hello, World2\n");
  while(1){}
  return 0;
}

int
main(void)
{
  static char buf[100];
  char cmd[100], arg0[100], arg1[100];
  char *bufp;
  int pid, stacksize, limit;
  char *argv[2] = { 0,};
  
  while(getcmd(buf, sizeof(buf)) >= 0){
    bufp = buf;
    bufp = getword(bufp, cmd, sizeof(cmd)); // read command
    // list command
    if(!strcmp(cmd, "list")){
      showprocs();
    } 
    // kill command
    else if(!strcmp(cmd, "kill")){
      if((bufp = getword(bufp, arg0, sizeof(arg0))) == 0){
        printf(2, "invalid pid\n");
        continue;
      }
      if(stoi(arg0, &pid) < 0){
        printf(2, "invalid pid\n");
        continue;
      }
      if(kill(pid) == 0){
        printf(2, "kill success\n");
      } 
      else{
        printf(2, "kill failed\n");
      }
    } 
    // execute command
    else if(!strcmp(cmd, "execute")){
      if((bufp = getword(bufp, arg0, sizeof(arg0))) == 0 || (bufp = getword(bufp, arg1, sizeof(arg1))) == 0){
        printf(2, "invalid option\n");
        continue;
      }
      if(stoi(arg1, &stacksize) < 0){
        printf(2, "invalid stacksize\n");
        continue;
      }

      if(fork() == 0){
        if(fork() == 0){ // exec in grandchild (parent is exited)
          exec2(arg0, argv, stacksize);
          printf(2, "exec failed\n");
          exit();
        }
        else{
          exit(); // exit child of pmanager
        }
      }
    } 
    // memlim command
    else if(!strcmp(cmd, "memlim")){
      if((bufp = getword(bufp, arg0, sizeof(arg0))) == 0 || (bufp = getword(bufp, arg1, sizeof(arg1))) == 0){
        printf(2, "invalid option\n");
        continue;
      }
      if(stoi(arg0, &pid) < 0 || stoi(arg1, &limit) < 0){
        printf(2, "invalid option\n");
        continue;
      }

      if(setmemorylimit(pid, limit) < 0){
        printf(2, "setmemorylimit failed\n");
        continue;
      }
      printf(2, "setmemorylimit success\n");
    } 
    // exit command
    else if(!strcmp(cmd, "exit")){
      printf(2, "terminate pmanager\n");
      exit();
    } 
    // undefined command
    else{
      printf(2, "undefined command\n");
    }
  }
  exit();
}
