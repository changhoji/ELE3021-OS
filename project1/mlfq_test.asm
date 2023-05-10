
_mlfq_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
  while (wait() != -1);
}

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	56                   	push   %esi
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  int count[MAX_LEVEL] = {0};
  17:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  25:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
//  int child;

  parent = getpid();
  2c:	e8 02 05 00 00       	call   533 <getpid>

  printf(1, "MLFQ test start\n");
  31:	83 ec 08             	sub    $0x8,%esp
  34:	68 98 09 00 00       	push   $0x998
  39:	6a 01                	push   $0x1
  parent = getpid();
  3b:	a3 64 0d 00 00       	mov    %eax,0xd64
  printf(1, "MLFQ test start\n");
  40:	e8 eb 05 00 00       	call   630 <printf>

  printf(1, "[Test 1] default\n");
  45:	5e                   	pop    %esi
  46:	58                   	pop    %eax
  47:	68 a9 09 00 00       	push   $0x9a9
  4c:	6a 01                	push   $0x1
  4e:	e8 dd 05 00 00       	call   630 <printf>
  pid = fork_children2();
  53:	e8 e8 00 00 00       	call   140 <fork_children2>

  if (pid != parent)
  58:	83 c4 10             	add    $0x10,%esp
  5b:	39 05 64 0d 00 00    	cmp    %eax,0xd64
  61:	74 65                	je     c8 <main+0xc8>
  63:	89 c6                	mov    %eax,%esi
  65:	bb a0 86 01 00       	mov    $0x186a0,%ebx
  6a:	eb 0e                	jmp    7a <main+0x7a>
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (x < 0 || x > 2)
      {
        printf(1, "Wrong level: %d\n", x);
        exit();
      }
      count[x]++;
  70:	83 44 85 dc 01       	addl   $0x1,-0x24(%ebp,%eax,4)
    for (i = 0; i < NUM_LOOP; i++)
  75:	83 eb 01             	sub    $0x1,%ebx
  78:	74 1f                	je     99 <main+0x99>
      int x = getLevel();
  7a:	e8 dc 04 00 00       	call   55b <getLevel>
      if (x < 0 || x > 2)
  7f:	83 f8 02             	cmp    $0x2,%eax
  82:	76 ec                	jbe    70 <main+0x70>
        printf(1, "Wrong level: %d\n", x);
  84:	83 ec 04             	sub    $0x4,%esp
  87:	50                   	push   %eax
  88:	68 bb 09 00 00       	push   $0x9bb
  8d:	6a 01                	push   $0x1
  8f:	e8 9c 05 00 00       	call   630 <printf>
        exit();
  94:	e8 1a 04 00 00       	call   4b3 <exit>
    }
    printf(1, "Process %d\n", pid);
  99:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
  9a:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
  9c:	56                   	push   %esi
  9d:	68 cc 09 00 00       	push   $0x9cc
  a2:	6a 01                	push   $0x1
  a4:	e8 87 05 00 00       	call   630 <printf>
  a9:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
  ac:	ff 74 9d dc          	pushl  -0x24(%ebp,%ebx,4)
  b0:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
  b1:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
  b4:	68 d8 09 00 00       	push   $0x9d8
  b9:	6a 01                	push   $0x1
  bb:	e8 70 05 00 00       	call   630 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
  c0:	83 c4 10             	add    $0x10,%esp
  c3:	83 fb 03             	cmp    $0x3,%ebx
  c6:	75 e4                	jne    ac <main+0xac>
  }
  exit_children();
  c8:	e8 43 01 00 00       	call   210 <exit_children>
  printf(1, "[Test 1] finished\n");
  cd:	50                   	push   %eax
  ce:	50                   	push   %eax
  cf:	68 e1 09 00 00       	push   $0x9e1
  d4:	6a 01                	push   $0x1
  d6:	e8 55 05 00 00       	call   630 <printf>
  printf(1, "done\n");
  db:	5a                   	pop    %edx
  dc:	59                   	pop    %ecx
  dd:	68 f4 09 00 00       	push   $0x9f4
  e2:	6a 01                	push   $0x1
  e4:	e8 47 05 00 00       	call   630 <printf>
  exit();
  e9:	e8 c5 03 00 00       	call   4b3 <exit>
  ee:	66 90                	xchg   %ax,%ax

000000f0 <fork_children>:
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	83 ec 08             	sub    $0x8,%esp
    if ((p = fork()) == 0)
  fa:	e8 ac 03 00 00       	call   4ab <fork>
  ff:	85 c0                	test   %eax,%eax
 101:	74 1d                	je     120 <fork_children+0x30>
 103:	e8 a3 03 00 00       	call   4ab <fork>
 108:	85 c0                	test   %eax,%eax
 10a:	74 14                	je     120 <fork_children+0x30>
 10c:	e8 9a 03 00 00       	call   4ab <fork>
 111:	85 c0                	test   %eax,%eax
 113:	74 0b                	je     120 <fork_children+0x30>
}
 115:	a1 64 0d 00 00       	mov    0xd64,%eax
 11a:	c9                   	leave  
 11b:	c3                   	ret    
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(10);
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	6a 0a                	push   $0xa
 125:	e8 19 04 00 00       	call   543 <sleep>
      return getpid();
 12a:	83 c4 10             	add    $0x10,%esp
}
 12d:	c9                   	leave  
      return getpid();
 12e:	e9 00 04 00 00       	jmp    533 <getpid>
 133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000140 <fork_children2>:
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++)
 148:	31 db                	xor    %ebx,%ebx
{
 14a:	83 ec 04             	sub    $0x4,%esp
    if ((p = fork()) == 0)
 14d:	e8 59 03 00 00       	call   4ab <fork>
 152:	85 c0                	test   %eax,%eax
 154:	74 22                	je     178 <fork_children2+0x38>
      setPriority(p, i);
 156:	83 ec 08             	sub    $0x8,%esp
 159:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++)
 15a:	83 c3 01             	add    $0x1,%ebx
      setPriority(p, i);
 15d:	50                   	push   %eax
 15e:	e8 00 04 00 00       	call   563 <setPriority>
  for (i = 0; i < NUM_THREAD; i++)
 163:	83 c4 10             	add    $0x10,%esp
 166:	83 fb 03             	cmp    $0x3,%ebx
 169:	75 e2                	jne    14d <fork_children2+0xd>
}
 16b:	a1 64 0d 00 00       	mov    0xd64,%eax
 170:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 173:	c9                   	leave  
 174:	c3                   	ret    
 175:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(300);
 178:	83 ec 0c             	sub    $0xc,%esp
 17b:	68 2c 01 00 00       	push   $0x12c
 180:	e8 be 03 00 00       	call   543 <sleep>
}
 185:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return getpid();
 188:	83 c4 10             	add    $0x10,%esp
}
 18b:	c9                   	leave  
      return getpid();
 18c:	e9 a2 03 00 00       	jmp    533 <getpid>
 191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <fork_children3>:
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	83 ec 04             	sub    $0x4,%esp
    if ((p = fork()) == 0)
 1ab:	e8 fb 02 00 00       	call   4ab <fork>
 1b0:	89 c3                	mov    %eax,%ebx
 1b2:	85 c0                	test   %eax,%eax
 1b4:	74 2f                	je     1e5 <fork_children3+0x45>
 1b6:	e8 f0 02 00 00       	call   4ab <fork>
 1bb:	85 c0                	test   %eax,%eax
 1bd:	74 21                	je     1e0 <fork_children3+0x40>
 1bf:	e8 e7 02 00 00       	call   4ab <fork>
  for (i = 0; i < NUM_THREAD; i++)
 1c4:	bb 02 00 00 00       	mov    $0x2,%ebx
    if ((p = fork()) == 0)
 1c9:	85 c0                	test   %eax,%eax
 1cb:	74 18                	je     1e5 <fork_children3+0x45>
}
 1cd:	a1 64 0d 00 00       	mov    0xd64,%eax
 1d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax
  for (i = 0; i < NUM_THREAD; i++)
 1e0:	bb 01 00 00 00       	mov    $0x1,%ebx
      sleep(10);
 1e5:	83 ec 0c             	sub    $0xc,%esp
 1e8:	6a 0a                	push   $0xa
 1ea:	e8 54 03 00 00       	call   543 <sleep>
      max_level = i;
 1ef:	89 1d 68 0d 00 00    	mov    %ebx,0xd68
      return getpid();
 1f5:	83 c4 10             	add    $0x10,%esp
}
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave  
      return getpid();
 1fc:	e9 32 03 00 00       	jmp    533 <getpid>
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20f:	90                   	nop

00000210 <exit_children>:
{
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	83 ec 08             	sub    $0x8,%esp
  if (getpid() != parent)
 21a:	e8 14 03 00 00       	call   533 <getpid>
 21f:	3b 05 64 0d 00 00    	cmp    0xd64,%eax
 225:	75 15                	jne    23c <exit_children+0x2c>
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax
  while (wait() != -1);
 230:	e8 86 02 00 00       	call   4bb <wait>
 235:	83 f8 ff             	cmp    $0xffffffff,%eax
 238:	75 f6                	jne    230 <exit_children+0x20>
}
 23a:	c9                   	leave  
 23b:	c3                   	ret    
    exit();
 23c:	e8 72 02 00 00       	call   4b3 <exit>
 241:	66 90                	xchg   %ax,%ax
 243:	66 90                	xchg   %ax,%ax
 245:	66 90                	xchg   %ax,%ax
 247:	66 90                	xchg   %ax,%ax
 249:	66 90                	xchg   %ax,%ax
 24b:	66 90                	xchg   %ax,%ax
 24d:	66 90                	xchg   %ax,%ax
 24f:	90                   	nop

00000250 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 255:	31 c0                	xor    %eax,%eax
{
 257:	89 e5                	mov    %esp,%ebp
 259:	53                   	push   %ebx
 25a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 25d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 260:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 264:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 267:	83 c0 01             	add    $0x1,%eax
 26a:	84 d2                	test   %dl,%dl
 26c:	75 f2                	jne    260 <strcpy+0x10>
    ;
  return os;
}
 26e:	89 c8                	mov    %ecx,%eax
 270:	5b                   	pop    %ebx
 271:	5d                   	pop    %ebp
 272:	c3                   	ret    
 273:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 280:	f3 0f 1e fb          	endbr32 
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	53                   	push   %ebx
 288:	8b 4d 08             	mov    0x8(%ebp),%ecx
 28b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 28e:	0f b6 01             	movzbl (%ecx),%eax
 291:	0f b6 1a             	movzbl (%edx),%ebx
 294:	84 c0                	test   %al,%al
 296:	75 19                	jne    2b1 <strcmp+0x31>
 298:	eb 26                	jmp    2c0 <strcmp+0x40>
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 2a4:	83 c1 01             	add    $0x1,%ecx
 2a7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2aa:	0f b6 1a             	movzbl (%edx),%ebx
 2ad:	84 c0                	test   %al,%al
 2af:	74 0f                	je     2c0 <strcmp+0x40>
 2b1:	38 d8                	cmp    %bl,%al
 2b3:	74 eb                	je     2a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 2b5:	29 d8                	sub    %ebx,%eax
}
 2b7:	5b                   	pop    %ebx
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2c2:	29 d8                	sub    %ebx,%eax
}
 2c4:	5b                   	pop    %ebx
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 2da:	80 3a 00             	cmpb   $0x0,(%edx)
 2dd:	74 21                	je     300 <strlen+0x30>
 2df:	31 c0                	xor    %eax,%eax
 2e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e8:	83 c0 01             	add    $0x1,%eax
 2eb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2ef:	89 c1                	mov    %eax,%ecx
 2f1:	75 f5                	jne    2e8 <strlen+0x18>
    ;
  return n;
}
 2f3:	89 c8                	mov    %ecx,%eax
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 300:	31 c9                	xor    %ecx,%ecx
}
 302:	5d                   	pop    %ebp
 303:	89 c8                	mov    %ecx,%eax
 305:	c3                   	ret    
 306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	f3 0f 1e fb          	endbr32 
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	57                   	push   %edi
 318:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 31b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31e:	8b 45 0c             	mov    0xc(%ebp),%eax
 321:	89 d7                	mov    %edx,%edi
 323:	fc                   	cld    
 324:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 326:	89 d0                	mov    %edx,%eax
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret    
 32b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 32f:	90                   	nop

00000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	f3 0f 1e fb          	endbr32 
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 33e:	0f b6 10             	movzbl (%eax),%edx
 341:	84 d2                	test   %dl,%dl
 343:	75 16                	jne    35b <strchr+0x2b>
 345:	eb 21                	jmp    368 <strchr+0x38>
 347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34e:	66 90                	xchg   %ax,%ax
 350:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 354:	83 c0 01             	add    $0x1,%eax
 357:	84 d2                	test   %dl,%dl
 359:	74 0d                	je     368 <strchr+0x38>
    if(*s == c)
 35b:	38 d1                	cmp    %dl,%cl
 35d:	75 f1                	jne    350 <strchr+0x20>
      return (char*)s;
  return 0;
}
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 368:	31 c0                	xor    %eax,%eax
}
 36a:	5d                   	pop    %ebp
 36b:	c3                   	ret    
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000370 <gets>:

char*
gets(char *buf, int max)
{
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	57                   	push   %edi
 378:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 379:	31 f6                	xor    %esi,%esi
{
 37b:	53                   	push   %ebx
 37c:	89 f3                	mov    %esi,%ebx
 37e:	83 ec 1c             	sub    $0x1c,%esp
 381:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 384:	eb 33                	jmp    3b9 <gets+0x49>
 386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 390:	83 ec 04             	sub    $0x4,%esp
 393:	8d 45 e7             	lea    -0x19(%ebp),%eax
 396:	6a 01                	push   $0x1
 398:	50                   	push   %eax
 399:	6a 00                	push   $0x0
 39b:	e8 2b 01 00 00       	call   4cb <read>
    if(cc < 1)
 3a0:	83 c4 10             	add    $0x10,%esp
 3a3:	85 c0                	test   %eax,%eax
 3a5:	7e 1c                	jle    3c3 <gets+0x53>
      break;
    buf[i++] = c;
 3a7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3ab:	83 c7 01             	add    $0x1,%edi
 3ae:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 3b1:	3c 0a                	cmp    $0xa,%al
 3b3:	74 23                	je     3d8 <gets+0x68>
 3b5:	3c 0d                	cmp    $0xd,%al
 3b7:	74 1f                	je     3d8 <gets+0x68>
  for(i=0; i+1 < max; ){
 3b9:	83 c3 01             	add    $0x1,%ebx
 3bc:	89 fe                	mov    %edi,%esi
 3be:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3c1:	7c cd                	jl     390 <gets+0x20>
 3c3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3c5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 3c8:	c6 03 00             	movb   $0x0,(%ebx)
}
 3cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ce:	5b                   	pop    %ebx
 3cf:	5e                   	pop    %esi
 3d0:	5f                   	pop    %edi
 3d1:	5d                   	pop    %ebp
 3d2:	c3                   	ret    
 3d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d7:	90                   	nop
 3d8:	8b 75 08             	mov    0x8(%ebp),%esi
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
 3de:	01 de                	add    %ebx,%esi
 3e0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 3e2:	c6 03 00             	movb   $0x0,(%ebx)
}
 3e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e8:	5b                   	pop    %ebx
 3e9:	5e                   	pop    %esi
 3ea:	5f                   	pop    %edi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f0:	f3 0f 1e fb          	endbr32 
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	56                   	push   %esi
 3f8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f9:	83 ec 08             	sub    $0x8,%esp
 3fc:	6a 00                	push   $0x0
 3fe:	ff 75 08             	pushl  0x8(%ebp)
 401:	e8 ed 00 00 00       	call   4f3 <open>
  if(fd < 0)
 406:	83 c4 10             	add    $0x10,%esp
 409:	85 c0                	test   %eax,%eax
 40b:	78 2b                	js     438 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 40d:	83 ec 08             	sub    $0x8,%esp
 410:	ff 75 0c             	pushl  0xc(%ebp)
 413:	89 c3                	mov    %eax,%ebx
 415:	50                   	push   %eax
 416:	e8 f0 00 00 00       	call   50b <fstat>
  close(fd);
 41b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 41e:	89 c6                	mov    %eax,%esi
  close(fd);
 420:	e8 b6 00 00 00       	call   4db <close>
  return r;
 425:	83 c4 10             	add    $0x10,%esp
}
 428:	8d 65 f8             	lea    -0x8(%ebp),%esp
 42b:	89 f0                	mov    %esi,%eax
 42d:	5b                   	pop    %ebx
 42e:	5e                   	pop    %esi
 42f:	5d                   	pop    %ebp
 430:	c3                   	ret    
 431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 438:	be ff ff ff ff       	mov    $0xffffffff,%esi
 43d:	eb e9                	jmp    428 <stat+0x38>
 43f:	90                   	nop

00000440 <atoi>:

int
atoi(const char *s)
{
 440:	f3 0f 1e fb          	endbr32 
 444:	55                   	push   %ebp
 445:	89 e5                	mov    %esp,%ebp
 447:	53                   	push   %ebx
 448:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 44b:	0f be 02             	movsbl (%edx),%eax
 44e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 451:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 454:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 459:	77 1a                	ja     475 <atoi+0x35>
 45b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop
    n = n*10 + *s++ - '0';
 460:	83 c2 01             	add    $0x1,%edx
 463:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 466:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 46a:	0f be 02             	movsbl (%edx),%eax
 46d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 470:	80 fb 09             	cmp    $0x9,%bl
 473:	76 eb                	jbe    460 <atoi+0x20>
  return n;
}
 475:	89 c8                	mov    %ecx,%eax
 477:	5b                   	pop    %ebx
 478:	5d                   	pop    %ebp
 479:	c3                   	ret    
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000480 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 480:	f3 0f 1e fb          	endbr32 
 484:	55                   	push   %ebp
 485:	89 e5                	mov    %esp,%ebp
 487:	57                   	push   %edi
 488:	8b 45 10             	mov    0x10(%ebp),%eax
 48b:	8b 55 08             	mov    0x8(%ebp),%edx
 48e:	56                   	push   %esi
 48f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 492:	85 c0                	test   %eax,%eax
 494:	7e 0f                	jle    4a5 <memmove+0x25>
 496:	01 d0                	add    %edx,%eax
  dst = vdst;
 498:	89 d7                	mov    %edx,%edi
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 4a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 4a1:	39 f8                	cmp    %edi,%eax
 4a3:	75 fb                	jne    4a0 <memmove+0x20>
  return vdst;
}
 4a5:	5e                   	pop    %esi
 4a6:	89 d0                	mov    %edx,%eax
 4a8:	5f                   	pop    %edi
 4a9:	5d                   	pop    %ebp
 4aa:	c3                   	ret    

000004ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ab:	b8 01 00 00 00       	mov    $0x1,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <exit>:
SYSCALL(exit)
 4b3:	b8 02 00 00 00       	mov    $0x2,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <wait>:
SYSCALL(wait)
 4bb:	b8 03 00 00 00       	mov    $0x3,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <pipe>:
SYSCALL(pipe)
 4c3:	b8 04 00 00 00       	mov    $0x4,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <read>:
SYSCALL(read)
 4cb:	b8 05 00 00 00       	mov    $0x5,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <write>:
SYSCALL(write)
 4d3:	b8 10 00 00 00       	mov    $0x10,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <close>:
SYSCALL(close)
 4db:	b8 15 00 00 00       	mov    $0x15,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <kill>:
SYSCALL(kill)
 4e3:	b8 06 00 00 00       	mov    $0x6,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <exec>:
SYSCALL(exec)
 4eb:	b8 07 00 00 00       	mov    $0x7,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <open>:
SYSCALL(open)
 4f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <mknod>:
SYSCALL(mknod)
 4fb:	b8 11 00 00 00       	mov    $0x11,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <unlink>:
SYSCALL(unlink)
 503:	b8 12 00 00 00       	mov    $0x12,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <fstat>:
SYSCALL(fstat)
 50b:	b8 08 00 00 00       	mov    $0x8,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <link>:
SYSCALL(link)
 513:	b8 13 00 00 00       	mov    $0x13,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <mkdir>:
SYSCALL(mkdir)
 51b:	b8 14 00 00 00       	mov    $0x14,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <chdir>:
SYSCALL(chdir)
 523:	b8 09 00 00 00       	mov    $0x9,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <dup>:
SYSCALL(dup)
 52b:	b8 0a 00 00 00       	mov    $0xa,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <getpid>:
SYSCALL(getpid)
 533:	b8 0b 00 00 00       	mov    $0xb,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <sbrk>:
SYSCALL(sbrk)
 53b:	b8 0c 00 00 00       	mov    $0xc,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <sleep>:
SYSCALL(sleep)
 543:	b8 0d 00 00 00       	mov    $0xd,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <uptime>:
SYSCALL(uptime)
 54b:	b8 0e 00 00 00       	mov    $0xe,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <yield>:

SYSCALL(yield)
 553:	b8 16 00 00 00       	mov    $0x16,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <getLevel>:
SYSCALL(getLevel)
 55b:	b8 17 00 00 00       	mov    $0x17,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <setPriority>:
SYSCALL(setPriority)
 563:	b8 18 00 00 00       	mov    $0x18,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <schedulerLock>:
SYSCALL(schedulerLock)
 56b:	b8 19 00 00 00       	mov    $0x19,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <schedulerUnlock>:
 573:	b8 1a 00 00 00       	mov    $0x1a,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    
 57b:	66 90                	xchg   %ax,%ax
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 3c             	sub    $0x3c,%esp
 589:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 58c:	89 d1                	mov    %edx,%ecx
{
 58e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 591:	85 d2                	test   %edx,%edx
 593:	0f 89 7f 00 00 00    	jns    618 <printint+0x98>
 599:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 59d:	74 79                	je     618 <printint+0x98>
    neg = 1;
 59f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 5a6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 5a8:	31 db                	xor    %ebx,%ebx
 5aa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5b0:	89 c8                	mov    %ecx,%eax
 5b2:	31 d2                	xor    %edx,%edx
 5b4:	89 cf                	mov    %ecx,%edi
 5b6:	f7 75 c4             	divl   -0x3c(%ebp)
 5b9:	0f b6 92 04 0a 00 00 	movzbl 0xa04(%edx),%edx
 5c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 5c3:	89 d8                	mov    %ebx,%eax
 5c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 5c8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 5cb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 5ce:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 5d1:	76 dd                	jbe    5b0 <printint+0x30>
  if(neg)
 5d3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 5d6:	85 c9                	test   %ecx,%ecx
 5d8:	74 0c                	je     5e6 <printint+0x66>
    buf[i++] = '-';
 5da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 5df:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 5e1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 5e6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 5e9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 5ed:	eb 07                	jmp    5f6 <printint+0x76>
 5ef:	90                   	nop
 5f0:	0f b6 13             	movzbl (%ebx),%edx
 5f3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 5f6:	83 ec 04             	sub    $0x4,%esp
 5f9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 5fc:	6a 01                	push   $0x1
 5fe:	56                   	push   %esi
 5ff:	57                   	push   %edi
 600:	e8 ce fe ff ff       	call   4d3 <write>
  while(--i >= 0)
 605:	83 c4 10             	add    $0x10,%esp
 608:	39 de                	cmp    %ebx,%esi
 60a:	75 e4                	jne    5f0 <printint+0x70>
    putc(fd, buf[i]);
}
 60c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60f:	5b                   	pop    %ebx
 610:	5e                   	pop    %esi
 611:	5f                   	pop    %edi
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 618:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 61f:	eb 87                	jmp    5a8 <printint+0x28>
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop

00000630 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 630:	f3 0f 1e fb          	endbr32 
 634:	55                   	push   %ebp
 635:	89 e5                	mov    %esp,%ebp
 637:	57                   	push   %edi
 638:	56                   	push   %esi
 639:	53                   	push   %ebx
 63a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63d:	8b 75 0c             	mov    0xc(%ebp),%esi
 640:	0f b6 1e             	movzbl (%esi),%ebx
 643:	84 db                	test   %bl,%bl
 645:	0f 84 b4 00 00 00    	je     6ff <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 64b:	8d 45 10             	lea    0x10(%ebp),%eax
 64e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 651:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 654:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 656:	89 45 d0             	mov    %eax,-0x30(%ebp)
 659:	eb 33                	jmp    68e <printf+0x5e>
 65b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
 660:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 663:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 668:	83 f8 25             	cmp    $0x25,%eax
 66b:	74 17                	je     684 <printf+0x54>
  write(fd, &c, 1);
 66d:	83 ec 04             	sub    $0x4,%esp
 670:	88 5d e7             	mov    %bl,-0x19(%ebp)
 673:	6a 01                	push   $0x1
 675:	57                   	push   %edi
 676:	ff 75 08             	pushl  0x8(%ebp)
 679:	e8 55 fe ff ff       	call   4d3 <write>
 67e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 681:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 684:	0f b6 1e             	movzbl (%esi),%ebx
 687:	83 c6 01             	add    $0x1,%esi
 68a:	84 db                	test   %bl,%bl
 68c:	74 71                	je     6ff <printf+0xcf>
    c = fmt[i] & 0xff;
 68e:	0f be cb             	movsbl %bl,%ecx
 691:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 694:	85 d2                	test   %edx,%edx
 696:	74 c8                	je     660 <printf+0x30>
      }
    } else if(state == '%'){
 698:	83 fa 25             	cmp    $0x25,%edx
 69b:	75 e7                	jne    684 <printf+0x54>
      if(c == 'd'){
 69d:	83 f8 64             	cmp    $0x64,%eax
 6a0:	0f 84 9a 00 00 00    	je     740 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6a6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6ac:	83 f9 70             	cmp    $0x70,%ecx
 6af:	74 5f                	je     710 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6b1:	83 f8 73             	cmp    $0x73,%eax
 6b4:	0f 84 d6 00 00 00    	je     790 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ba:	83 f8 63             	cmp    $0x63,%eax
 6bd:	0f 84 8d 00 00 00    	je     750 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6c3:	83 f8 25             	cmp    $0x25,%eax
 6c6:	0f 84 b4 00 00 00    	je     780 <printf+0x150>
  write(fd, &c, 1);
 6cc:	83 ec 04             	sub    $0x4,%esp
 6cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6d3:	6a 01                	push   $0x1
 6d5:	57                   	push   %edi
 6d6:	ff 75 08             	pushl  0x8(%ebp)
 6d9:	e8 f5 fd ff ff       	call   4d3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6de:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6e1:	83 c4 0c             	add    $0xc,%esp
 6e4:	6a 01                	push   $0x1
 6e6:	83 c6 01             	add    $0x1,%esi
 6e9:	57                   	push   %edi
 6ea:	ff 75 08             	pushl  0x8(%ebp)
 6ed:	e8 e1 fd ff ff       	call   4d3 <write>
  for(i = 0; fmt[i]; i++){
 6f2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 6f6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 6fb:	84 db                	test   %bl,%bl
 6fd:	75 8f                	jne    68e <printf+0x5e>
    }
  }
}
 6ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 702:	5b                   	pop    %ebx
 703:	5e                   	pop    %esi
 704:	5f                   	pop    %edi
 705:	5d                   	pop    %ebp
 706:	c3                   	ret    
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 10 00 00 00       	mov    $0x10,%ecx
 718:	6a 00                	push   $0x0
 71a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
 720:	8b 13                	mov    (%ebx),%edx
 722:	e8 59 fe ff ff       	call   580 <printint>
        ap++;
 727:	89 d8                	mov    %ebx,%eax
 729:	83 c4 10             	add    $0x10,%esp
      state = 0;
 72c:	31 d2                	xor    %edx,%edx
        ap++;
 72e:	83 c0 04             	add    $0x4,%eax
 731:	89 45 d0             	mov    %eax,-0x30(%ebp)
 734:	e9 4b ff ff ff       	jmp    684 <printf+0x54>
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 740:	83 ec 0c             	sub    $0xc,%esp
 743:	b9 0a 00 00 00       	mov    $0xa,%ecx
 748:	6a 01                	push   $0x1
 74a:	eb ce                	jmp    71a <printf+0xea>
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 750:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 753:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 756:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 758:	6a 01                	push   $0x1
        ap++;
 75a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 75d:	57                   	push   %edi
 75e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 761:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 764:	e8 6a fd ff ff       	call   4d3 <write>
        ap++;
 769:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 76c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 76f:	31 d2                	xor    %edx,%edx
 771:	e9 0e ff ff ff       	jmp    684 <printf+0x54>
 776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 780:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 783:	83 ec 04             	sub    $0x4,%esp
 786:	e9 59 ff ff ff       	jmp    6e4 <printf+0xb4>
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
        s = (char*)*ap;
 790:	8b 45 d0             	mov    -0x30(%ebp),%eax
 793:	8b 18                	mov    (%eax),%ebx
        ap++;
 795:	83 c0 04             	add    $0x4,%eax
 798:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 79b:	85 db                	test   %ebx,%ebx
 79d:	74 17                	je     7b6 <printf+0x186>
        while(*s != 0){
 79f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 7a2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 7a4:	84 c0                	test   %al,%al
 7a6:	0f 84 d8 fe ff ff    	je     684 <printf+0x54>
 7ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7af:	89 de                	mov    %ebx,%esi
 7b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7b4:	eb 1a                	jmp    7d0 <printf+0x1a0>
          s = "(null)";
 7b6:	bb fa 09 00 00       	mov    $0x9fa,%ebx
        while(*s != 0){
 7bb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7be:	b8 28 00 00 00       	mov    $0x28,%eax
 7c3:	89 de                	mov    %ebx,%esi
 7c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7d3:	83 c6 01             	add    $0x1,%esi
 7d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7d9:	6a 01                	push   $0x1
 7db:	57                   	push   %edi
 7dc:	53                   	push   %ebx
 7dd:	e8 f1 fc ff ff       	call   4d3 <write>
        while(*s != 0){
 7e2:	0f b6 06             	movzbl (%esi),%eax
 7e5:	83 c4 10             	add    $0x10,%esp
 7e8:	84 c0                	test   %al,%al
 7ea:	75 e4                	jne    7d0 <printf+0x1a0>
 7ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 7ef:	31 d2                	xor    %edx,%edx
 7f1:	e9 8e fe ff ff       	jmp    684 <printf+0x54>
 7f6:	66 90                	xchg   %ax,%ax
 7f8:	66 90                	xchg   %ax,%ax
 7fa:	66 90                	xchg   %ax,%ax
 7fc:	66 90                	xchg   %ax,%ax
 7fe:	66 90                	xchg   %ax,%ax

00000800 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 800:	f3 0f 1e fb          	endbr32 
 804:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 805:	a1 58 0d 00 00       	mov    0xd58,%eax
{
 80a:	89 e5                	mov    %esp,%ebp
 80c:	57                   	push   %edi
 80d:	56                   	push   %esi
 80e:	53                   	push   %ebx
 80f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 812:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 814:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 817:	39 c8                	cmp    %ecx,%eax
 819:	73 15                	jae    830 <free+0x30>
 81b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 81f:	90                   	nop
 820:	39 d1                	cmp    %edx,%ecx
 822:	72 14                	jb     838 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 824:	39 d0                	cmp    %edx,%eax
 826:	73 10                	jae    838 <free+0x38>
{
 828:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82a:	8b 10                	mov    (%eax),%edx
 82c:	39 c8                	cmp    %ecx,%eax
 82e:	72 f0                	jb     820 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 830:	39 d0                	cmp    %edx,%eax
 832:	72 f4                	jb     828 <free+0x28>
 834:	39 d1                	cmp    %edx,%ecx
 836:	73 f0                	jae    828 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 838:	8b 73 fc             	mov    -0x4(%ebx),%esi
 83b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 83e:	39 fa                	cmp    %edi,%edx
 840:	74 1e                	je     860 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 842:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 845:	8b 50 04             	mov    0x4(%eax),%edx
 848:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 84b:	39 f1                	cmp    %esi,%ecx
 84d:	74 28                	je     877 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 84f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 851:	5b                   	pop    %ebx
  freep = p;
 852:	a3 58 0d 00 00       	mov    %eax,0xd58
}
 857:	5e                   	pop    %esi
 858:	5f                   	pop    %edi
 859:	5d                   	pop    %ebp
 85a:	c3                   	ret    
 85b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 85f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 860:	03 72 04             	add    0x4(%edx),%esi
 863:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 866:	8b 10                	mov    (%eax),%edx
 868:	8b 12                	mov    (%edx),%edx
 86a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 86d:	8b 50 04             	mov    0x4(%eax),%edx
 870:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 873:	39 f1                	cmp    %esi,%ecx
 875:	75 d8                	jne    84f <free+0x4f>
    p->s.size += bp->s.size;
 877:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 87a:	a3 58 0d 00 00       	mov    %eax,0xd58
    p->s.size += bp->s.size;
 87f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 882:	8b 53 f8             	mov    -0x8(%ebx),%edx
 885:	89 10                	mov    %edx,(%eax)
}
 887:	5b                   	pop    %ebx
 888:	5e                   	pop    %esi
 889:	5f                   	pop    %edi
 88a:	5d                   	pop    %ebp
 88b:	c3                   	ret    
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000890 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 890:	f3 0f 1e fb          	endbr32 
 894:	55                   	push   %ebp
 895:	89 e5                	mov    %esp,%ebp
 897:	57                   	push   %edi
 898:	56                   	push   %esi
 899:	53                   	push   %ebx
 89a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 89d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8a0:	8b 3d 58 0d 00 00    	mov    0xd58,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a6:	8d 70 07             	lea    0x7(%eax),%esi
 8a9:	c1 ee 03             	shr    $0x3,%esi
 8ac:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 8af:	85 ff                	test   %edi,%edi
 8b1:	0f 84 a9 00 00 00    	je     960 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 8b9:	8b 48 04             	mov    0x4(%eax),%ecx
 8bc:	39 f1                	cmp    %esi,%ecx
 8be:	73 6d                	jae    92d <malloc+0x9d>
 8c0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 8c6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8cb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 8ce:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 8d5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 8d8:	eb 17                	jmp    8f1 <malloc+0x61>
 8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 8e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 8e5:	39 f1                	cmp    %esi,%ecx
 8e7:	73 4f                	jae    938 <malloc+0xa8>
 8e9:	8b 3d 58 0d 00 00    	mov    0xd58,%edi
 8ef:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f1:	39 c7                	cmp    %eax,%edi
 8f3:	75 eb                	jne    8e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 8f5:	83 ec 0c             	sub    $0xc,%esp
 8f8:	ff 75 e4             	pushl  -0x1c(%ebp)
 8fb:	e8 3b fc ff ff       	call   53b <sbrk>
  if(p == (char*)-1)
 900:	83 c4 10             	add    $0x10,%esp
 903:	83 f8 ff             	cmp    $0xffffffff,%eax
 906:	74 1b                	je     923 <malloc+0x93>
  hp->s.size = nu;
 908:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 90b:	83 ec 0c             	sub    $0xc,%esp
 90e:	83 c0 08             	add    $0x8,%eax
 911:	50                   	push   %eax
 912:	e8 e9 fe ff ff       	call   800 <free>
  return freep;
 917:	a1 58 0d 00 00       	mov    0xd58,%eax
      if((p = morecore(nunits)) == 0)
 91c:	83 c4 10             	add    $0x10,%esp
 91f:	85 c0                	test   %eax,%eax
 921:	75 bd                	jne    8e0 <malloc+0x50>
        return 0;
  }
}
 923:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 926:	31 c0                	xor    %eax,%eax
}
 928:	5b                   	pop    %ebx
 929:	5e                   	pop    %esi
 92a:	5f                   	pop    %edi
 92b:	5d                   	pop    %ebp
 92c:	c3                   	ret    
    if(p->s.size >= nunits){
 92d:	89 c2                	mov    %eax,%edx
 92f:	89 f8                	mov    %edi,%eax
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 938:	39 ce                	cmp    %ecx,%esi
 93a:	74 54                	je     990 <malloc+0x100>
        p->s.size -= nunits;
 93c:	29 f1                	sub    %esi,%ecx
 93e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 941:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 944:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 947:	a3 58 0d 00 00       	mov    %eax,0xd58
}
 94c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 94f:	8d 42 08             	lea    0x8(%edx),%eax
}
 952:	5b                   	pop    %ebx
 953:	5e                   	pop    %esi
 954:	5f                   	pop    %edi
 955:	5d                   	pop    %ebp
 956:	c3                   	ret    
 957:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 95e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 960:	c7 05 58 0d 00 00 5c 	movl   $0xd5c,0xd58
 967:	0d 00 00 
    base.s.size = 0;
 96a:	bf 5c 0d 00 00       	mov    $0xd5c,%edi
    base.s.ptr = freep = prevp = &base;
 96f:	c7 05 5c 0d 00 00 5c 	movl   $0xd5c,0xd5c
 976:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 979:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 97b:	c7 05 60 0d 00 00 00 	movl   $0x0,0xd60
 982:	00 00 00 
    if(p->s.size >= nunits){
 985:	e9 36 ff ff ff       	jmp    8c0 <malloc+0x30>
 98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 990:	8b 0a                	mov    (%edx),%ecx
 992:	89 08                	mov    %ecx,(%eax)
 994:	eb b1                	jmp    947 <malloc+0xb7>
