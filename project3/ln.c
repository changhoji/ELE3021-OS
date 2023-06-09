#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc != 3 && argc != 4){
    printf(2, "Usage: ln -[h|s] old new\n");
    exit();
  }

  if(argc == 3){
    if(link(argv[1], argv[2]) < 0)
      printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  }
  else{
    if(strlen(argv[1]) != 2){
      printf(2, "invalid option\n");
      exit();
    }
    if(!strcmp(argv[1], "-h")){
      if(link(argv[2], argv[3]) < 0)
        printf(2, "link %s %s %s: failed\n", argv[1], argv[2], argv[3]);
    }
    else if(!strcmp(argv[1], "-s")){
      if(slink(argv[2], argv[3]) < 0)
        printf(2, "link %s %s %s: failed\n", argv[1], argv[2], argv[3]);
    }
    else{
      printf(2, "invalid option\n");
      exit();
    }
  }
  
  exit();
}
