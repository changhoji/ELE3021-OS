
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define password 2021035487

int parent;

int main(int argc, char* argv[])
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
  14:	83 ec 0c             	sub    $0xc,%esp
  17:	8b 59 04             	mov    0x4(%ecx),%ebx
  parent = getpid();
  1a:	e8 94 05 00 00       	call   5b3 <getpid>

  printf(1, "\nMLFQ test start\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 18 0a 00 00       	push   $0xa18
  27:	6a 01                	push   $0x1
  parent = getpid();
  29:	a3 8c 0d 00 00       	mov    %eax,0xd8c
  printf(1, "\nMLFQ test start\n");
  2e:	e8 7d 06 00 00       	call   6b0 <printf>
  int pid = 0;
  char cmd = argv[1][0];
  33:	8b 43 04             	mov    0x4(%ebx),%eax

  switch (cmd) {
  36:	83 c4 10             	add    $0x10,%esp
  char cmd = argv[1][0];
  39:	0f b6 00             	movzbl (%eax),%eax
  switch (cmd) {
  3c:	3c 32                	cmp    $0x32,%al
  3e:	74 34                	je     74 <main+0x74>
  40:	3c 33                	cmp    $0x33,%al
  42:	0f 84 f5 00 00 00    	je     13d <main+0x13d>
  48:	3c 31                	cmp    $0x31,%al
  4a:	0f 84 ad 00 00 00    	je     fd <main+0xfd>
        }
        exit();
      }
      break;
  default:
    printf(1, "WRONG CMD\n");
  50:	52                   	push   %edx
  51:	52                   	push   %edx
  52:	68 b6 0a 00 00       	push   $0xab6
  57:	6a 01                	push   $0x1
  59:	e8 52 06 00 00       	call   6b0 <printf>
    break;
  5e:	83 c4 10             	add    $0x10,%esp
  }


  printf(1, "done\n\n");
  61:	50                   	push   %eax
  62:	50                   	push   %eax
  63:	68 c1 0a 00 00       	push   $0xac1
  68:	6a 01                	push   $0x1
  6a:	e8 41 06 00 00       	call   6b0 <printf>
  exit();
  6f:	e8 bf 04 00 00       	call   533 <exit>
      printf(1, "test - lock\n\n");
  74:	50                   	push   %eax
  75:	50                   	push   %eax
  76:	68 67 0a 00 00       	push   $0xa67
  7b:	6a 01                	push   $0x1
  7d:	e8 2e 06 00 00       	call   6b0 <printf>
      if((pid = fork()) != 0){
  82:	e8 a4 04 00 00       	call   52b <fork>
  87:	83 c4 10             	add    $0x10,%esp
  8a:	89 c3                	mov    %eax,%ebx
  8c:	85 c0                	test   %eax,%eax
  8e:	0f 84 69 01 00 00    	je     1fd <main+0x1fd>
        printf(1, "in parent, lock!\n");
  94:	50                   	push   %eax
        for(int i = 0; i < 10000; i++){
  95:	31 db                	xor    %ebx,%ebx
        printf(1, "in parent, lock!\n");
  97:	50                   	push   %eax
  98:	68 75 0a 00 00       	push   $0xa75
  9d:	6a 01                	push   $0x1
  9f:	e8 0c 06 00 00       	call   6b0 <printf>
        schedulerLock(password);
  a4:	c7 04 24 df 8d 76 78 	movl   $0x78768ddf,(%esp)
  ab:	e8 3b 05 00 00       	call   5eb <schedulerLock>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b7:	90                   	nop
          printf(1, " %d", i);
  b8:	83 ec 04             	sub    $0x4,%esp
  bb:	53                   	push   %ebx
  bc:	68 87 0a 00 00       	push   $0xa87
  c1:	6a 01                	push   $0x1
  c3:	e8 e8 05 00 00       	call   6b0 <printf>
  c8:	69 c3 29 5c 8f c2    	imul   $0xc28f5c29,%ebx,%eax
  ce:	83 c4 10             	add    $0x10,%esp
  d1:	d1 c8                	ror    %eax
          if (i % 50 == 0)printf(1, "\n");
  d3:	3d 51 b8 1e 05       	cmp    $0x51eb851,%eax
  d8:	0f 86 b2 01 00 00    	jbe    290 <main+0x290>
          if (i == 1000) schedulerUnlock(password);
  de:	8d 73 01             	lea    0x1(%ebx),%esi
  e1:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  e7:	0f 84 c4 01 00 00    	je     2b1 <main+0x2b1>
        for(int i = 0; i < 10000; i++){
  ed:	81 fe 10 27 00 00    	cmp    $0x2710,%esi
  f3:	0f 84 5b 01 00 00    	je     254 <main+0x254>
  f9:	89 f3                	mov    %esi,%ebx
  fb:	eb bb                	jmp    b8 <main+0xb8>
      printf(1, "test - yield\n\n");
  fd:	51                   	push   %ecx
  fe:	51                   	push   %ecx
  ff:	68 2a 0a 00 00       	push   $0xa2a
 104:	6a 01                	push   $0x1
 106:	e8 a5 05 00 00       	call   6b0 <printf>
      if((pid = fork()) != 0){ // parent
 10b:	e8 1b 04 00 00       	call   52b <fork>
 110:	83 c4 10             	add    $0x10,%esp
 113:	89 c3                	mov    %eax,%ebx
 115:	85 c0                	test   %eax,%eax
 117:	0f 85 41 01 00 00    	jne    25e <main+0x25e>
          printf(1, "child %d\n", i);
 11d:	83 ec 04             	sub    $0x4,%esp
 120:	53                   	push   %ebx
        for(int i = 0; i < 5; i++){
 121:	83 c3 01             	add    $0x1,%ebx
          printf(1, "child %d\n", i);
 124:	68 5d 0a 00 00       	push   $0xa5d
 129:	6a 01                	push   $0x1
 12b:	e8 80 05 00 00       	call   6b0 <printf>
        for(int i = 0; i < 5; i++){
 130:	83 c4 10             	add    $0x10,%esp
 133:	83 fb 05             	cmp    $0x5,%ebx
 136:	75 e5                	jne    11d <main+0x11d>
        exit();
 138:	e8 f6 03 00 00       	call   533 <exit>
      printf(1, "test - setpriority\n\n");
 13d:	53                   	push   %ebx
 13e:	53                   	push   %ebx
 13f:	68 97 0a 00 00       	push   $0xa97
 144:	6a 01                	push   $0x1
 146:	e8 65 05 00 00       	call   6b0 <printf>
      if((pid = fork()) != 0){
 14b:	e8 db 03 00 00       	call   52b <fork>
 150:	83 c4 10             	add    $0x10,%esp
 153:	89 c3                	mov    %eax,%ebx
 155:	85 c0                	test   %eax,%eax
 157:	0f 84 7c 00 00 00    	je     1d9 <main+0x1d9>
        setPriority(pid, 0);
 15d:	51                   	push   %ecx
        for(int i = 0; i < 2000; i++){
 15e:	31 db                	xor    %ebx,%ebx
        setPriority(pid, 0);
 160:	51                   	push   %ecx
 161:	6a 00                	push   $0x0
 163:	50                   	push   %eax
 164:	e8 7a 04 00 00       	call   5e3 <setPriority>
 169:	83 c4 10             	add    $0x10,%esp
 16c:	eb 11                	jmp    17f <main+0x17f>
 16e:	66 90                	xchg   %ax,%ax
        for(int i = 0; i < 2000; i++){
 170:	83 c3 01             	add    $0x1,%ebx
 173:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
 179:	0f 84 d5 00 00 00    	je     254 <main+0x254>
          printf(1, " p%d", i);
 17f:	83 ec 04             	sub    $0x4,%esp
 182:	53                   	push   %ebx
 183:	68 ac 0a 00 00       	push   $0xaac
 188:	6a 01                	push   $0x1
 18a:	e8 21 05 00 00       	call   6b0 <printf>
 18f:	69 c3 ef ee ee ee    	imul   $0xeeeeeeef,%ebx,%eax
 195:	83 c4 10             	add    $0x10,%esp
 198:	d1 c8                	ror    %eax
          if (i % 30 == 0) printf(1, "\n");
 19a:	3d 88 88 88 08       	cmp    $0x8888888,%eax
 19f:	77 cf                	ja     170 <main+0x170>
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	68 37 0a 00 00       	push   $0xa37
 1a9:	6a 01                	push   $0x1
 1ab:	e8 00 05 00 00       	call   6b0 <printf>
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	eb bb                	jmp    170 <main+0x170>
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
          if (i % 30 == 0) printf(1, "\n");
 1b8:	83 ec 08             	sub    $0x8,%esp
 1bb:	68 37 0a 00 00       	push   $0xa37
 1c0:	6a 01                	push   $0x1
 1c2:	e8 e9 04 00 00       	call   6b0 <printf>
 1c7:	83 c4 10             	add    $0x10,%esp
        for(int i = 0; i < 2000; i++){
 1ca:	83 c3 01             	add    $0x1,%ebx
 1cd:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
 1d3:	0f 84 5f ff ff ff    	je     138 <main+0x138>
          printf(1, " c%d", i);
 1d9:	83 ec 04             	sub    $0x4,%esp
 1dc:	53                   	push   %ebx
 1dd:	68 b1 0a 00 00       	push   $0xab1
 1e2:	6a 01                	push   $0x1
 1e4:	e8 c7 04 00 00       	call   6b0 <printf>
 1e9:	69 c3 ef ee ee ee    	imul   $0xeeeeeeef,%ebx,%eax
 1ef:	83 c4 10             	add    $0x10,%esp
 1f2:	d1 c8                	ror    %eax
          if (i % 30 == 0) printf(1, "\n");
 1f4:	3d 88 88 88 08       	cmp    $0x8888888,%eax
 1f9:	77 cf                	ja     1ca <main+0x1ca>
 1fb:	eb bb                	jmp    1b8 <main+0x1b8>
        printf(1, "child..\n");
 1fd:	56                   	push   %esi
 1fe:	56                   	push   %esi
 1ff:	68 8b 0a 00 00       	push   $0xa8b
 204:	6a 01                	push   $0x1
 206:	e8 a5 04 00 00       	call   6b0 <printf>
 20b:	83 c4 10             	add    $0x10,%esp
 20e:	eb 0f                	jmp    21f <main+0x21f>
        for(int i = 0; i < 10000; i++){
 210:	83 c3 01             	add    $0x1,%ebx
 213:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
 219:	0f 84 19 ff ff ff    	je     138 <main+0x138>
          printf(1, " #");
 21f:	83 ec 08             	sub    $0x8,%esp
 222:	68 94 0a 00 00       	push   $0xa94
 227:	6a 01                	push   $0x1
 229:	e8 82 04 00 00       	call   6b0 <printf>
 22e:	69 c3 29 5c 8f c2    	imul   $0xc28f5c29,%ebx,%eax
 234:	83 c4 10             	add    $0x10,%esp
 237:	d1 c8                	ror    %eax
          if (i % 50 == 0)printf(1, "\n");
 239:	3d 51 b8 1e 05       	cmp    $0x51eb851,%eax
 23e:	77 d0                	ja     210 <main+0x210>
 240:	83 ec 08             	sub    $0x8,%esp
 243:	68 37 0a 00 00       	push   $0xa37
 248:	6a 01                	push   $0x1
 24a:	e8 61 04 00 00       	call   6b0 <printf>
 24f:	83 c4 10             	add    $0x10,%esp
 252:	eb bc                	jmp    210 <main+0x210>
        wait();
 254:	e8 e2 02 00 00       	call   53b <wait>
      break;
 259:	e9 03 fe ff ff       	jmp    61 <main+0x61>
        printf(1, "in parent, call yield\n");
 25e:	50                   	push   %eax
 25f:	50                   	push   %eax
 260:	68 39 0a 00 00       	push   $0xa39
 265:	6a 01                	push   $0x1
 267:	e8 44 04 00 00       	call   6b0 <printf>
        yield();
 26c:	e8 62 03 00 00       	call   5d3 <yield>
        printf(1, "hello world\n");
 271:	58                   	pop    %eax
 272:	5a                   	pop    %edx
 273:	68 50 0a 00 00       	push   $0xa50
 278:	6a 01                	push   $0x1
 27a:	e8 31 04 00 00       	call   6b0 <printf>
        wait();
 27f:	e8 b7 02 00 00       	call   53b <wait>
      break;
 284:	83 c4 10             	add    $0x10,%esp
 287:	e9 d5 fd ff ff       	jmp    61 <main+0x61>
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          if (i % 50 == 0)printf(1, "\n");
 290:	83 ec 08             	sub    $0x8,%esp
 293:	8d 73 01             	lea    0x1(%ebx),%esi
 296:	68 37 0a 00 00       	push   $0xa37
 29b:	6a 01                	push   $0x1
 29d:	e8 0e 04 00 00       	call   6b0 <printf>
 2a2:	83 c4 10             	add    $0x10,%esp
          if (i == 1000) schedulerUnlock(password);
 2a5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
 2ab:	0f 85 3c fe ff ff    	jne    ed <main+0xed>
 2b1:	83 ec 0c             	sub    $0xc,%esp
        for(int i = 0; i < 10000; i++){
 2b4:	89 f3                	mov    %esi,%ebx
          if (i == 1000) schedulerUnlock(password);
 2b6:	68 df 8d 76 78       	push   $0x78768ddf
 2bb:	e8 33 03 00 00       	call   5f3 <schedulerUnlock>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	e9 f0 fd ff ff       	jmp    b8 <main+0xb8>
 2c8:	66 90                	xchg   %ax,%ax
 2ca:	66 90                	xchg   %ax,%ax
 2cc:	66 90                	xchg   %ax,%ax
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d5:	31 c0                	xor    %eax,%eax
{
 2d7:	89 e5                	mov    %esp,%ebp
 2d9:	53                   	push   %ebx
 2da:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2dd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 2e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2e7:	83 c0 01             	add    $0x1,%eax
 2ea:	84 d2                	test   %dl,%dl
 2ec:	75 f2                	jne    2e0 <strcpy+0x10>
    ;
  return os;
}
 2ee:	89 c8                	mov    %ecx,%eax
 2f0:	5b                   	pop    %ebx
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	53                   	push   %ebx
 308:	8b 4d 08             	mov    0x8(%ebp),%ecx
 30b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 30e:	0f b6 01             	movzbl (%ecx),%eax
 311:	0f b6 1a             	movzbl (%edx),%ebx
 314:	84 c0                	test   %al,%al
 316:	75 19                	jne    331 <strcmp+0x31>
 318:	eb 26                	jmp    340 <strcmp+0x40>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 320:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 324:	83 c1 01             	add    $0x1,%ecx
 327:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 32a:	0f b6 1a             	movzbl (%edx),%ebx
 32d:	84 c0                	test   %al,%al
 32f:	74 0f                	je     340 <strcmp+0x40>
 331:	38 d8                	cmp    %bl,%al
 333:	74 eb                	je     320 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 335:	29 d8                	sub    %ebx,%eax
}
 337:	5b                   	pop    %ebx
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 340:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 342:	29 d8                	sub    %ebx,%eax
}
 344:	5b                   	pop    %ebx
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34e:	66 90                	xchg   %ax,%ax

00000350 <strlen>:

uint
strlen(const char *s)
{
 350:	f3 0f 1e fb          	endbr32 
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 35a:	80 3a 00             	cmpb   $0x0,(%edx)
 35d:	74 21                	je     380 <strlen+0x30>
 35f:	31 c0                	xor    %eax,%eax
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 368:	83 c0 01             	add    $0x1,%eax
 36b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 36f:	89 c1                	mov    %eax,%ecx
 371:	75 f5                	jne    368 <strlen+0x18>
    ;
  return n;
}
 373:	89 c8                	mov    %ecx,%eax
 375:	5d                   	pop    %ebp
 376:	c3                   	ret    
 377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 380:	31 c9                	xor    %ecx,%ecx
}
 382:	5d                   	pop    %ebp
 383:	89 c8                	mov    %ecx,%eax
 385:	c3                   	ret    
 386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38d:	8d 76 00             	lea    0x0(%esi),%esi

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	f3 0f 1e fb          	endbr32 
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
 397:	57                   	push   %edi
 398:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 39b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	89 d7                	mov    %edx,%edi
 3a3:	fc                   	cld    
 3a4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	5f                   	pop    %edi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    
 3ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3af:	90                   	nop

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	f3 0f 1e fb          	endbr32 
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ba:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3be:	0f b6 10             	movzbl (%eax),%edx
 3c1:	84 d2                	test   %dl,%dl
 3c3:	75 16                	jne    3db <strchr+0x2b>
 3c5:	eb 21                	jmp    3e8 <strchr+0x38>
 3c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ce:	66 90                	xchg   %ax,%ax
 3d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3d4:	83 c0 01             	add    $0x1,%eax
 3d7:	84 d2                	test   %dl,%dl
 3d9:	74 0d                	je     3e8 <strchr+0x38>
    if(*s == c)
 3db:	38 d1                	cmp    %dl,%cl
 3dd:	75 f1                	jne    3d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret    
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3e8:	31 c0                	xor    %eax,%eax
}
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <gets>:

char*
gets(char *buf, int max)
{
 3f0:	f3 0f 1e fb          	endbr32 
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	57                   	push   %edi
 3f8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f9:	31 f6                	xor    %esi,%esi
{
 3fb:	53                   	push   %ebx
 3fc:	89 f3                	mov    %esi,%ebx
 3fe:	83 ec 1c             	sub    $0x1c,%esp
 401:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 404:	eb 33                	jmp    439 <gets+0x49>
 406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 410:	83 ec 04             	sub    $0x4,%esp
 413:	8d 45 e7             	lea    -0x19(%ebp),%eax
 416:	6a 01                	push   $0x1
 418:	50                   	push   %eax
 419:	6a 00                	push   $0x0
 41b:	e8 2b 01 00 00       	call   54b <read>
    if(cc < 1)
 420:	83 c4 10             	add    $0x10,%esp
 423:	85 c0                	test   %eax,%eax
 425:	7e 1c                	jle    443 <gets+0x53>
      break;
    buf[i++] = c;
 427:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 42b:	83 c7 01             	add    $0x1,%edi
 42e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 431:	3c 0a                	cmp    $0xa,%al
 433:	74 23                	je     458 <gets+0x68>
 435:	3c 0d                	cmp    $0xd,%al
 437:	74 1f                	je     458 <gets+0x68>
  for(i=0; i+1 < max; ){
 439:	83 c3 01             	add    $0x1,%ebx
 43c:	89 fe                	mov    %edi,%esi
 43e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 441:	7c cd                	jl     410 <gets+0x20>
 443:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 445:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 448:	c6 03 00             	movb   $0x0,(%ebx)
}
 44b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44e:	5b                   	pop    %ebx
 44f:	5e                   	pop    %esi
 450:	5f                   	pop    %edi
 451:	5d                   	pop    %ebp
 452:	c3                   	ret    
 453:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 457:	90                   	nop
 458:	8b 75 08             	mov    0x8(%ebp),%esi
 45b:	8b 45 08             	mov    0x8(%ebp),%eax
 45e:	01 de                	add    %ebx,%esi
 460:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 462:	c6 03 00             	movb   $0x0,(%ebx)
}
 465:	8d 65 f4             	lea    -0xc(%ebp),%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi

00000470 <stat>:

int
stat(const char *n, struct stat *st)
{
 470:	f3 0f 1e fb          	endbr32 
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	56                   	push   %esi
 478:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	6a 00                	push   $0x0
 47e:	ff 75 08             	pushl  0x8(%ebp)
 481:	e8 ed 00 00 00       	call   573 <open>
  if(fd < 0)
 486:	83 c4 10             	add    $0x10,%esp
 489:	85 c0                	test   %eax,%eax
 48b:	78 2b                	js     4b8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 48d:	83 ec 08             	sub    $0x8,%esp
 490:	ff 75 0c             	pushl  0xc(%ebp)
 493:	89 c3                	mov    %eax,%ebx
 495:	50                   	push   %eax
 496:	e8 f0 00 00 00       	call   58b <fstat>
  close(fd);
 49b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 49e:	89 c6                	mov    %eax,%esi
  close(fd);
 4a0:	e8 b6 00 00 00       	call   55b <close>
  return r;
 4a5:	83 c4 10             	add    $0x10,%esp
}
 4a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4ab:	89 f0                	mov    %esi,%eax
 4ad:	5b                   	pop    %ebx
 4ae:	5e                   	pop    %esi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret    
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 4b8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4bd:	eb e9                	jmp    4a8 <stat+0x38>
 4bf:	90                   	nop

000004c0 <atoi>:

int
atoi(const char *s)
{
 4c0:	f3 0f 1e fb          	endbr32 
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	53                   	push   %ebx
 4c8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4cb:	0f be 02             	movsbl (%edx),%eax
 4ce:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4d1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4d4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4d9:	77 1a                	ja     4f5 <atoi+0x35>
 4db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4df:	90                   	nop
    n = n*10 + *s++ - '0';
 4e0:	83 c2 01             	add    $0x1,%edx
 4e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4ea:	0f be 02             	movsbl (%edx),%eax
 4ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4f0:	80 fb 09             	cmp    $0x9,%bl
 4f3:	76 eb                	jbe    4e0 <atoi+0x20>
  return n;
}
 4f5:	89 c8                	mov    %ecx,%eax
 4f7:	5b                   	pop    %ebx
 4f8:	5d                   	pop    %ebp
 4f9:	c3                   	ret    
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000500 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 500:	f3 0f 1e fb          	endbr32 
 504:	55                   	push   %ebp
 505:	89 e5                	mov    %esp,%ebp
 507:	57                   	push   %edi
 508:	8b 45 10             	mov    0x10(%ebp),%eax
 50b:	8b 55 08             	mov    0x8(%ebp),%edx
 50e:	56                   	push   %esi
 50f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 512:	85 c0                	test   %eax,%eax
 514:	7e 0f                	jle    525 <memmove+0x25>
 516:	01 d0                	add    %edx,%eax
  dst = vdst;
 518:	89 d7                	mov    %edx,%edi
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 520:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 521:	39 f8                	cmp    %edi,%eax
 523:	75 fb                	jne    520 <memmove+0x20>
  return vdst;
}
 525:	5e                   	pop    %esi
 526:	89 d0                	mov    %edx,%eax
 528:	5f                   	pop    %edi
 529:	5d                   	pop    %ebp
 52a:	c3                   	ret    

0000052b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 52b:	b8 01 00 00 00       	mov    $0x1,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <exit>:
SYSCALL(exit)
 533:	b8 02 00 00 00       	mov    $0x2,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <wait>:
SYSCALL(wait)
 53b:	b8 03 00 00 00       	mov    $0x3,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <pipe>:
SYSCALL(pipe)
 543:	b8 04 00 00 00       	mov    $0x4,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <read>:
SYSCALL(read)
 54b:	b8 05 00 00 00       	mov    $0x5,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <write>:
SYSCALL(write)
 553:	b8 10 00 00 00       	mov    $0x10,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <close>:
SYSCALL(close)
 55b:	b8 15 00 00 00       	mov    $0x15,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <kill>:
SYSCALL(kill)
 563:	b8 06 00 00 00       	mov    $0x6,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <exec>:
SYSCALL(exec)
 56b:	b8 07 00 00 00       	mov    $0x7,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <open>:
SYSCALL(open)
 573:	b8 0f 00 00 00       	mov    $0xf,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <mknod>:
SYSCALL(mknod)
 57b:	b8 11 00 00 00       	mov    $0x11,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <unlink>:
SYSCALL(unlink)
 583:	b8 12 00 00 00       	mov    $0x12,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <fstat>:
SYSCALL(fstat)
 58b:	b8 08 00 00 00       	mov    $0x8,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <link>:
SYSCALL(link)
 593:	b8 13 00 00 00       	mov    $0x13,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <mkdir>:
SYSCALL(mkdir)
 59b:	b8 14 00 00 00       	mov    $0x14,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <chdir>:
SYSCALL(chdir)
 5a3:	b8 09 00 00 00       	mov    $0x9,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <dup>:
SYSCALL(dup)
 5ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <getpid>:
SYSCALL(getpid)
 5b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <sbrk>:
SYSCALL(sbrk)
 5bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <sleep>:
SYSCALL(sleep)
 5c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <uptime>:
SYSCALL(uptime)
 5cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <yield>:

SYSCALL(yield)
 5d3:	b8 16 00 00 00       	mov    $0x16,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <getLevel>:
SYSCALL(getLevel)
 5db:	b8 17 00 00 00       	mov    $0x17,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <setPriority>:
SYSCALL(setPriority)
 5e3:	b8 18 00 00 00       	mov    $0x18,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <schedulerLock>:
SYSCALL(schedulerLock)
 5eb:	b8 19 00 00 00       	mov    $0x19,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <schedulerUnlock>:
 5f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    
 5fb:	66 90                	xchg   %ax,%ax
 5fd:	66 90                	xchg   %ax,%ax
 5ff:	90                   	nop

00000600 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 3c             	sub    $0x3c,%esp
 609:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 60c:	89 d1                	mov    %edx,%ecx
{
 60e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 611:	85 d2                	test   %edx,%edx
 613:	0f 89 7f 00 00 00    	jns    698 <printint+0x98>
 619:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 61d:	74 79                	je     698 <printint+0x98>
    neg = 1;
 61f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 626:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 628:	31 db                	xor    %ebx,%ebx
 62a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 62d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 630:	89 c8                	mov    %ecx,%eax
 632:	31 d2                	xor    %edx,%edx
 634:	89 cf                	mov    %ecx,%edi
 636:	f7 75 c4             	divl   -0x3c(%ebp)
 639:	0f b6 92 d0 0a 00 00 	movzbl 0xad0(%edx),%edx
 640:	89 45 c0             	mov    %eax,-0x40(%ebp)
 643:	89 d8                	mov    %ebx,%eax
 645:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 648:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 64b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 64e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 651:	76 dd                	jbe    630 <printint+0x30>
  if(neg)
 653:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 656:	85 c9                	test   %ecx,%ecx
 658:	74 0c                	je     666 <printint+0x66>
    buf[i++] = '-';
 65a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 65f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 661:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 666:	8b 7d b8             	mov    -0x48(%ebp),%edi
 669:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 66d:	eb 07                	jmp    676 <printint+0x76>
 66f:	90                   	nop
 670:	0f b6 13             	movzbl (%ebx),%edx
 673:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 676:	83 ec 04             	sub    $0x4,%esp
 679:	88 55 d7             	mov    %dl,-0x29(%ebp)
 67c:	6a 01                	push   $0x1
 67e:	56                   	push   %esi
 67f:	57                   	push   %edi
 680:	e8 ce fe ff ff       	call   553 <write>
  while(--i >= 0)
 685:	83 c4 10             	add    $0x10,%esp
 688:	39 de                	cmp    %ebx,%esi
 68a:	75 e4                	jne    670 <printint+0x70>
    putc(fd, buf[i]);
}
 68c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 698:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 69f:	eb 87                	jmp    628 <printint+0x28>
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop

000006b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6b0:	f3 0f 1e fb          	endbr32 
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	57                   	push   %edi
 6b8:	56                   	push   %esi
 6b9:	53                   	push   %ebx
 6ba:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 6c0:	0f b6 1e             	movzbl (%esi),%ebx
 6c3:	84 db                	test   %bl,%bl
 6c5:	0f 84 b4 00 00 00    	je     77f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 6cb:	8d 45 10             	lea    0x10(%ebp),%eax
 6ce:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 6d4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 6d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6d9:	eb 33                	jmp    70e <printf+0x5e>
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
 6e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6e8:	83 f8 25             	cmp    $0x25,%eax
 6eb:	74 17                	je     704 <printf+0x54>
  write(fd, &c, 1);
 6ed:	83 ec 04             	sub    $0x4,%esp
 6f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6f3:	6a 01                	push   $0x1
 6f5:	57                   	push   %edi
 6f6:	ff 75 08             	pushl  0x8(%ebp)
 6f9:	e8 55 fe ff ff       	call   553 <write>
 6fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 701:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 704:	0f b6 1e             	movzbl (%esi),%ebx
 707:	83 c6 01             	add    $0x1,%esi
 70a:	84 db                	test   %bl,%bl
 70c:	74 71                	je     77f <printf+0xcf>
    c = fmt[i] & 0xff;
 70e:	0f be cb             	movsbl %bl,%ecx
 711:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 714:	85 d2                	test   %edx,%edx
 716:	74 c8                	je     6e0 <printf+0x30>
      }
    } else if(state == '%'){
 718:	83 fa 25             	cmp    $0x25,%edx
 71b:	75 e7                	jne    704 <printf+0x54>
      if(c == 'd'){
 71d:	83 f8 64             	cmp    $0x64,%eax
 720:	0f 84 9a 00 00 00    	je     7c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 726:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 72c:	83 f9 70             	cmp    $0x70,%ecx
 72f:	74 5f                	je     790 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 731:	83 f8 73             	cmp    $0x73,%eax
 734:	0f 84 d6 00 00 00    	je     810 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 73a:	83 f8 63             	cmp    $0x63,%eax
 73d:	0f 84 8d 00 00 00    	je     7d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 743:	83 f8 25             	cmp    $0x25,%eax
 746:	0f 84 b4 00 00 00    	je     800 <printf+0x150>
  write(fd, &c, 1);
 74c:	83 ec 04             	sub    $0x4,%esp
 74f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 753:	6a 01                	push   $0x1
 755:	57                   	push   %edi
 756:	ff 75 08             	pushl  0x8(%ebp)
 759:	e8 f5 fd ff ff       	call   553 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 75e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 761:	83 c4 0c             	add    $0xc,%esp
 764:	6a 01                	push   $0x1
 766:	83 c6 01             	add    $0x1,%esi
 769:	57                   	push   %edi
 76a:	ff 75 08             	pushl  0x8(%ebp)
 76d:	e8 e1 fd ff ff       	call   553 <write>
  for(i = 0; fmt[i]; i++){
 772:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 776:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 779:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 77b:	84 db                	test   %bl,%bl
 77d:	75 8f                	jne    70e <printf+0x5e>
    }
  }
}
 77f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 782:	5b                   	pop    %ebx
 783:	5e                   	pop    %esi
 784:	5f                   	pop    %edi
 785:	5d                   	pop    %ebp
 786:	c3                   	ret    
 787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 790:	83 ec 0c             	sub    $0xc,%esp
 793:	b9 10 00 00 00       	mov    $0x10,%ecx
 798:	6a 00                	push   $0x0
 79a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 79d:	8b 45 08             	mov    0x8(%ebp),%eax
 7a0:	8b 13                	mov    (%ebx),%edx
 7a2:	e8 59 fe ff ff       	call   600 <printint>
        ap++;
 7a7:	89 d8                	mov    %ebx,%eax
 7a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7ac:	31 d2                	xor    %edx,%edx
        ap++;
 7ae:	83 c0 04             	add    $0x4,%eax
 7b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7b4:	e9 4b ff ff ff       	jmp    704 <printf+0x54>
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7c8:	6a 01                	push   $0x1
 7ca:	eb ce                	jmp    79a <printf+0xea>
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 7d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 7d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 7d8:	6a 01                	push   $0x1
        ap++;
 7da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 7dd:	57                   	push   %edi
 7de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 7e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7e4:	e8 6a fd ff ff       	call   553 <write>
        ap++;
 7e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 7ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7ef:	31 d2                	xor    %edx,%edx
 7f1:	e9 0e ff ff ff       	jmp    704 <printf+0x54>
 7f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 800:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 803:	83 ec 04             	sub    $0x4,%esp
 806:	e9 59 ff ff ff       	jmp    764 <printf+0xb4>
 80b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 80f:	90                   	nop
        s = (char*)*ap;
 810:	8b 45 d0             	mov    -0x30(%ebp),%eax
 813:	8b 18                	mov    (%eax),%ebx
        ap++;
 815:	83 c0 04             	add    $0x4,%eax
 818:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 81b:	85 db                	test   %ebx,%ebx
 81d:	74 17                	je     836 <printf+0x186>
        while(*s != 0){
 81f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 822:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 824:	84 c0                	test   %al,%al
 826:	0f 84 d8 fe ff ff    	je     704 <printf+0x54>
 82c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 82f:	89 de                	mov    %ebx,%esi
 831:	8b 5d 08             	mov    0x8(%ebp),%ebx
 834:	eb 1a                	jmp    850 <printf+0x1a0>
          s = "(null)";
 836:	bb c8 0a 00 00       	mov    $0xac8,%ebx
        while(*s != 0){
 83b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 83e:	b8 28 00 00 00       	mov    $0x28,%eax
 843:	89 de                	mov    %ebx,%esi
 845:	8b 5d 08             	mov    0x8(%ebp),%ebx
 848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84f:	90                   	nop
  write(fd, &c, 1);
 850:	83 ec 04             	sub    $0x4,%esp
          s++;
 853:	83 c6 01             	add    $0x1,%esi
 856:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 859:	6a 01                	push   $0x1
 85b:	57                   	push   %edi
 85c:	53                   	push   %ebx
 85d:	e8 f1 fc ff ff       	call   553 <write>
        while(*s != 0){
 862:	0f b6 06             	movzbl (%esi),%eax
 865:	83 c4 10             	add    $0x10,%esp
 868:	84 c0                	test   %al,%al
 86a:	75 e4                	jne    850 <printf+0x1a0>
 86c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 86f:	31 d2                	xor    %edx,%edx
 871:	e9 8e fe ff ff       	jmp    704 <printf+0x54>
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	f3 0f 1e fb          	endbr32 
 884:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 885:	a1 80 0d 00 00       	mov    0xd80,%eax
{
 88a:	89 e5                	mov    %esp,%ebp
 88c:	57                   	push   %edi
 88d:	56                   	push   %esi
 88e:	53                   	push   %ebx
 88f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 892:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 894:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 897:	39 c8                	cmp    %ecx,%eax
 899:	73 15                	jae    8b0 <free+0x30>
 89b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 89f:	90                   	nop
 8a0:	39 d1                	cmp    %edx,%ecx
 8a2:	72 14                	jb     8b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a4:	39 d0                	cmp    %edx,%eax
 8a6:	73 10                	jae    8b8 <free+0x38>
{
 8a8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8aa:	8b 10                	mov    (%eax),%edx
 8ac:	39 c8                	cmp    %ecx,%eax
 8ae:	72 f0                	jb     8a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	39 d0                	cmp    %edx,%eax
 8b2:	72 f4                	jb     8a8 <free+0x28>
 8b4:	39 d1                	cmp    %edx,%ecx
 8b6:	73 f0                	jae    8a8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8be:	39 fa                	cmp    %edi,%edx
 8c0:	74 1e                	je     8e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8c5:	8b 50 04             	mov    0x4(%eax),%edx
 8c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8cb:	39 f1                	cmp    %esi,%ecx
 8cd:	74 28                	je     8f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 8d1:	5b                   	pop    %ebx
  freep = p;
 8d2:	a3 80 0d 00 00       	mov    %eax,0xd80
}
 8d7:	5e                   	pop    %esi
 8d8:	5f                   	pop    %edi
 8d9:	5d                   	pop    %ebp
 8da:	c3                   	ret    
 8db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8df:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 8e0:	03 72 04             	add    0x4(%edx),%esi
 8e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	8b 10                	mov    (%eax),%edx
 8e8:	8b 12                	mov    (%edx),%edx
 8ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ed:	8b 50 04             	mov    0x4(%eax),%edx
 8f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8f3:	39 f1                	cmp    %esi,%ecx
 8f5:	75 d8                	jne    8cf <free+0x4f>
    p->s.size += bp->s.size;
 8f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8fa:	a3 80 0d 00 00       	mov    %eax,0xd80
    p->s.size += bp->s.size;
 8ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 902:	8b 53 f8             	mov    -0x8(%ebx),%edx
 905:	89 10                	mov    %edx,(%eax)
}
 907:	5b                   	pop    %ebx
 908:	5e                   	pop    %esi
 909:	5f                   	pop    %edi
 90a:	5d                   	pop    %ebp
 90b:	c3                   	ret    
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	f3 0f 1e fb          	endbr32 
 914:	55                   	push   %ebp
 915:	89 e5                	mov    %esp,%ebp
 917:	57                   	push   %edi
 918:	56                   	push   %esi
 919:	53                   	push   %ebx
 91a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 91d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 920:	8b 3d 80 0d 00 00    	mov    0xd80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 926:	8d 70 07             	lea    0x7(%eax),%esi
 929:	c1 ee 03             	shr    $0x3,%esi
 92c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 92f:	85 ff                	test   %edi,%edi
 931:	0f 84 a9 00 00 00    	je     9e0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 937:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 939:	8b 48 04             	mov    0x4(%eax),%ecx
 93c:	39 f1                	cmp    %esi,%ecx
 93e:	73 6d                	jae    9ad <malloc+0x9d>
 940:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 946:	bb 00 10 00 00       	mov    $0x1000,%ebx
 94b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 94e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 955:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 958:	eb 17                	jmp    971 <malloc+0x61>
 95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 960:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 962:	8b 4a 04             	mov    0x4(%edx),%ecx
 965:	39 f1                	cmp    %esi,%ecx
 967:	73 4f                	jae    9b8 <malloc+0xa8>
 969:	8b 3d 80 0d 00 00    	mov    0xd80,%edi
 96f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 971:	39 c7                	cmp    %eax,%edi
 973:	75 eb                	jne    960 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 975:	83 ec 0c             	sub    $0xc,%esp
 978:	ff 75 e4             	pushl  -0x1c(%ebp)
 97b:	e8 3b fc ff ff       	call   5bb <sbrk>
  if(p == (char*)-1)
 980:	83 c4 10             	add    $0x10,%esp
 983:	83 f8 ff             	cmp    $0xffffffff,%eax
 986:	74 1b                	je     9a3 <malloc+0x93>
  hp->s.size = nu;
 988:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 98b:	83 ec 0c             	sub    $0xc,%esp
 98e:	83 c0 08             	add    $0x8,%eax
 991:	50                   	push   %eax
 992:	e8 e9 fe ff ff       	call   880 <free>
  return freep;
 997:	a1 80 0d 00 00       	mov    0xd80,%eax
      if((p = morecore(nunits)) == 0)
 99c:	83 c4 10             	add    $0x10,%esp
 99f:	85 c0                	test   %eax,%eax
 9a1:	75 bd                	jne    960 <malloc+0x50>
        return 0;
  }
}
 9a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9a6:	31 c0                	xor    %eax,%eax
}
 9a8:	5b                   	pop    %ebx
 9a9:	5e                   	pop    %esi
 9aa:	5f                   	pop    %edi
 9ab:	5d                   	pop    %ebp
 9ac:	c3                   	ret    
    if(p->s.size >= nunits){
 9ad:	89 c2                	mov    %eax,%edx
 9af:	89 f8                	mov    %edi,%eax
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9b8:	39 ce                	cmp    %ecx,%esi
 9ba:	74 54                	je     a10 <malloc+0x100>
        p->s.size -= nunits;
 9bc:	29 f1                	sub    %esi,%ecx
 9be:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 9c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 9c4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 9c7:	a3 80 0d 00 00       	mov    %eax,0xd80
}
 9cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9cf:	8d 42 08             	lea    0x8(%edx),%eax
}
 9d2:	5b                   	pop    %ebx
 9d3:	5e                   	pop    %esi
 9d4:	5f                   	pop    %edi
 9d5:	5d                   	pop    %ebp
 9d6:	c3                   	ret    
 9d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9de:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 9e0:	c7 05 80 0d 00 00 84 	movl   $0xd84,0xd80
 9e7:	0d 00 00 
    base.s.size = 0;
 9ea:	bf 84 0d 00 00       	mov    $0xd84,%edi
    base.s.ptr = freep = prevp = &base;
 9ef:	c7 05 84 0d 00 00 84 	movl   $0xd84,0xd84
 9f6:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 9fb:	c7 05 88 0d 00 00 00 	movl   $0x0,0xd88
 a02:	00 00 00 
    if(p->s.size >= nunits){
 a05:	e9 36 ff ff ff       	jmp    940 <malloc+0x30>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a10:	8b 0a                	mov    (%edx),%ecx
 a12:	89 08                	mov    %ecx,(%eax)
 a14:	eb b1                	jmp    9c7 <malloc+0xb7>
