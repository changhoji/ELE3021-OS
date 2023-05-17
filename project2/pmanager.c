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
  if(buf[nbuf-1] != 0) // buffer size over
    return -1;

  buf[strlen(buf)-1] = '\0';
  return 0;
}

/// @brief parse each word in command
/// @param buf cmd line has taken by user
/// @param word string for saving each word
/// @param nword word size
/// @return use to update buf loc
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

/// @brief 
/// @param str 
/// @param res stoi result
/// @return -1 if error
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

    if(!strcmp(cmd, "list")){
      showprocs();
    } 
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
        if(fork() == 0){
          exec2(arg0, argv, stacksize);
          exit();
        }
        else{
          wait();
        }
      }
    } 
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
    else if(!strcmp(cmd, "exit")){
      printf(2, "terminate pmanager\n");
      exit();
    } 
    else{
      printf(2, "undefined command\n");
    }
  }
  exit();
}
