#include "types.h"
#include "user.h"

#define NTHD 3

void* hello(void * arg){
    printf(1, "Hello Thread! %d\n", (int)arg);
    sleep(100);
    thread_exit(0);
    exit();
    return 0;
}

int
main(int argc, char *argv[])
{   
    thread_t t[NTHD];
    for(int i = 0; i < NTHD; i++){
        thread_create(&t[i], hello, (void*)i);
        printf(1, "thread created: [%d]\n", t[i]);
    }
    for(int i = 0; i < NTHD; i++){
        thread_join(t[i], 0);
        printf(1, "thread join: [%d]\n", i);
    }
    exit();
}