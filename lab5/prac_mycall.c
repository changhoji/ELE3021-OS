#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

void
mycall(void)
{
  cprintf("user inerrupt 128 called\n");
}