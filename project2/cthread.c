#include "types.h"
#include "user.h"

#define NTHD 3

int cnt = 0;

void* hello(void * arg){
    printf(1, "Hello Thread!\n");
    sleep(100);
    thread_exit(0);
    return 0;
}

int
main(int argc, char *argv[])
{   
    thread_t t[NTHD];
    for(int i = 0; i < NTHD; i++){
        thread_create(&t[i], hello, 0);
        printf(1, "thread created: [%d]\n", t[i]);
    }
    for(int i = 0; i < NTHD; i++){
       printf(1, "thread join: %s\n", thread_join(t[i], 0) ? "success" : "failed");
    }
    printf(1, "thread exit!\n");
    exit();
}