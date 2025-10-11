
fs/kill:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 1){
  13:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  17:	7f 1b                	jg     34 <main+0x34>
    printf(2, "usage: kill pid...\n");
  19:	48 c7 c6 5a 0b 00 00 	mov    $0xb5a,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 16 05 00 00       	call   545 <printf>
    exit();
  2f:	e8 57 03 00 00       	call   38b <exit>
  }
  for(i=1; i<argc; i++)
  34:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  3b:	eb 2a                	jmp    67 <main+0x67>
    kill(atoi(argv[i]));
  3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  40:	48 98                	cltq
  42:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  49:	00 
  4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  4e:	48 01 d0             	add    %rdx,%rax
  51:	48 8b 00             	mov    (%rax),%rax
  54:	48 89 c7             	mov    %rax,%rdi
  57:	e8 72 02 00 00       	call   2ce <atoi>
  5c:	89 c7                	mov    %eax,%edi
  5e:	e8 58 03 00 00       	call   3bb <kill>
  for(i=1; i<argc; i++)
  63:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  6a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  6d:	7c ce                	jl     3d <main+0x3d>
  exit();
  6f:	e8 17 03 00 00       	call   38b <exit>

0000000000000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %rbp
  75:	48 89 e5             	mov    %rsp,%rbp
  78:	48 83 ec 10          	sub    $0x10,%rsp
  7c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80:	89 75 f4             	mov    %esi,-0xc(%rbp)
  83:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  86:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8a:	8b 55 f0             	mov    -0x10(%rbp),%edx
  8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  90:	48 89 ce             	mov    %rcx,%rsi
  93:	48 89 f7             	mov    %rsi,%rdi
  96:	89 d1                	mov    %edx,%ecx
  98:	fc                   	cld
  99:	f3 aa                	rep stos %al,%es:(%rdi)
  9b:	89 ca                	mov    %ecx,%edx
  9d:	48 89 fe             	mov    %rdi,%rsi
  a0:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  a4:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a7:	90                   	nop
  a8:	c9                   	leave
  a9:	c3                   	ret

00000000000000aa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  aa:	f3 0f 1e fa          	endbr64
  ae:	55                   	push   %rbp
  af:	48 89 e5             	mov    %rsp,%rbp
  b2:	48 83 ec 20          	sub    $0x20,%rsp
  b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  c6:	90                   	nop
  c7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  cb:	48 8d 42 01          	lea    0x1(%rdx),%rax
  cf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  d7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  db:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  df:	0f b6 12             	movzbl (%rdx),%edx
  e2:	88 10                	mov    %dl,(%rax)
  e4:	0f b6 00             	movzbl (%rax),%eax
  e7:	84 c0                	test   %al,%al
  e9:	75 dc                	jne    c7 <strcpy+0x1d>
    ;
  return os;
  eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  ef:	c9                   	leave
  f0:	c3                   	ret

00000000000000f1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f1:	f3 0f 1e fa          	endbr64
  f5:	55                   	push   %rbp
  f6:	48 89 e5             	mov    %rsp,%rbp
  f9:	48 83 ec 10          	sub    $0x10,%rsp
  fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 101:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 105:	eb 0a                	jmp    111 <strcmp+0x20>
    p++, q++;
 107:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 10c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 111:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 115:	0f b6 00             	movzbl (%rax),%eax
 118:	84 c0                	test   %al,%al
 11a:	74 12                	je     12e <strcmp+0x3d>
 11c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 120:	0f b6 10             	movzbl (%rax),%edx
 123:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 127:	0f b6 00             	movzbl (%rax),%eax
 12a:	38 c2                	cmp    %al,%dl
 12c:	74 d9                	je     107 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 12e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 132:	0f b6 00             	movzbl (%rax),%eax
 135:	0f b6 d0             	movzbl %al,%edx
 138:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 13c:	0f b6 00             	movzbl (%rax),%eax
 13f:	0f b6 c0             	movzbl %al,%eax
 142:	29 c2                	sub    %eax,%edx
 144:	89 d0                	mov    %edx,%eax
}
 146:	c9                   	leave
 147:	c3                   	ret

0000000000000148 <strlen>:

uint
strlen(char *s)
{
 148:	f3 0f 1e fa          	endbr64
 14c:	55                   	push   %rbp
 14d:	48 89 e5             	mov    %rsp,%rbp
 150:	48 83 ec 18          	sub    $0x18,%rsp
 154:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 158:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 15f:	eb 04                	jmp    165 <strlen+0x1d>
 161:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 165:	8b 45 fc             	mov    -0x4(%rbp),%eax
 168:	48 63 d0             	movslq %eax,%rdx
 16b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 16f:	48 01 d0             	add    %rdx,%rax
 172:	0f b6 00             	movzbl (%rax),%eax
 175:	84 c0                	test   %al,%al
 177:	75 e8                	jne    161 <strlen+0x19>
    ;
  return n;
 179:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 17c:	c9                   	leave
 17d:	c3                   	ret

000000000000017e <memset>:

void*
memset(void *dst, int c, uint n)
{
 17e:	f3 0f 1e fa          	endbr64
 182:	55                   	push   %rbp
 183:	48 89 e5             	mov    %rsp,%rbp
 186:	48 83 ec 10          	sub    $0x10,%rsp
 18a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 18e:	89 75 f4             	mov    %esi,-0xc(%rbp)
 191:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 194:	8b 55 f0             	mov    -0x10(%rbp),%edx
 197:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 19a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 19e:	89 ce                	mov    %ecx,%esi
 1a0:	48 89 c7             	mov    %rax,%rdi
 1a3:	e8 cc fe ff ff       	call   74 <stosb>
  return dst;
 1a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1ac:	c9                   	leave
 1ad:	c3                   	ret

00000000000001ae <strchr>:

char*
strchr(const char *s, char c)
{
 1ae:	f3 0f 1e fa          	endbr64
 1b2:	55                   	push   %rbp
 1b3:	48 89 e5             	mov    %rsp,%rbp
 1b6:	48 83 ec 10          	sub    $0x10,%rsp
 1ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1be:	89 f0                	mov    %esi,%eax
 1c0:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1c3:	eb 17                	jmp    1dc <strchr+0x2e>
    if(*s == c)
 1c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c9:	0f b6 00             	movzbl (%rax),%eax
 1cc:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1cf:	75 06                	jne    1d7 <strchr+0x29>
      return (char*)s;
 1d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d5:	eb 15                	jmp    1ec <strchr+0x3e>
  for(; *s; s++)
 1d7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e0:	0f b6 00             	movzbl (%rax),%eax
 1e3:	84 c0                	test   %al,%al
 1e5:	75 de                	jne    1c5 <strchr+0x17>
  return 0;
 1e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ec:	c9                   	leave
 1ed:	c3                   	ret

00000000000001ee <gets>:

char*
gets(char *buf, int max)
{
 1ee:	f3 0f 1e fa          	endbr64
 1f2:	55                   	push   %rbp
 1f3:	48 89 e5             	mov    %rsp,%rbp
 1f6:	48 83 ec 20          	sub    $0x20,%rsp
 1fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1fe:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 201:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 208:	eb 48                	jmp    252 <gets+0x64>
    cc = read(0, &c, 1);
 20a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 20e:	ba 01 00 00 00       	mov    $0x1,%edx
 213:	48 89 c6             	mov    %rax,%rsi
 216:	bf 00 00 00 00       	mov    $0x0,%edi
 21b:	e8 83 01 00 00       	call   3a3 <read>
 220:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 223:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 227:	7e 36                	jle    25f <gets+0x71>
      break;
    buf[i++] = c;
 229:	8b 45 fc             	mov    -0x4(%rbp),%eax
 22c:	8d 50 01             	lea    0x1(%rax),%edx
 22f:	89 55 fc             	mov    %edx,-0x4(%rbp)
 232:	48 63 d0             	movslq %eax,%rdx
 235:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 239:	48 01 c2             	add    %rax,%rdx
 23c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 240:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 242:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 246:	3c 0a                	cmp    $0xa,%al
 248:	74 16                	je     260 <gets+0x72>
 24a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 24e:	3c 0d                	cmp    $0xd,%al
 250:	74 0e                	je     260 <gets+0x72>
  for(i=0; i+1 < max; ){
 252:	8b 45 fc             	mov    -0x4(%rbp),%eax
 255:	83 c0 01             	add    $0x1,%eax
 258:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 25b:	7f ad                	jg     20a <gets+0x1c>
 25d:	eb 01                	jmp    260 <gets+0x72>
      break;
 25f:	90                   	nop
      break;
  }
  buf[i] = '\0';
 260:	8b 45 fc             	mov    -0x4(%rbp),%eax
 263:	48 63 d0             	movslq %eax,%rdx
 266:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 26a:	48 01 d0             	add    %rdx,%rax
 26d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 274:	c9                   	leave
 275:	c3                   	ret

0000000000000276 <stat>:

int
stat(char *n, struct stat *st)
{
 276:	f3 0f 1e fa          	endbr64
 27a:	55                   	push   %rbp
 27b:	48 89 e5             	mov    %rsp,%rbp
 27e:	48 83 ec 20          	sub    $0x20,%rsp
 282:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 286:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 28e:	be 00 00 00 00       	mov    $0x0,%esi
 293:	48 89 c7             	mov    %rax,%rdi
 296:	e8 30 01 00 00       	call   3cb <open>
 29b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 29e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2a2:	79 07                	jns    2ab <stat+0x35>
    return -1;
 2a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a9:	eb 21                	jmp    2cc <stat+0x56>
  r = fstat(fd, st);
 2ab:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2b2:	48 89 d6             	mov    %rdx,%rsi
 2b5:	89 c7                	mov    %eax,%edi
 2b7:	e8 27 01 00 00       	call   3e3 <fstat>
 2bc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2c2:	89 c7                	mov    %eax,%edi
 2c4:	e8 ea 00 00 00       	call   3b3 <close>
  return r;
 2c9:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2cc:	c9                   	leave
 2cd:	c3                   	ret

00000000000002ce <atoi>:

int
atoi(const char *s)
{
 2ce:	f3 0f 1e fa          	endbr64
 2d2:	55                   	push   %rbp
 2d3:	48 89 e5             	mov    %rsp,%rbp
 2d6:	48 83 ec 18          	sub    $0x18,%rsp
 2da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2e5:	eb 28                	jmp    30f <atoi+0x41>
    n = n*10 + *s++ - '0';
 2e7:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2ea:	89 d0                	mov    %edx,%eax
 2ec:	c1 e0 02             	shl    $0x2,%eax
 2ef:	01 d0                	add    %edx,%eax
 2f1:	01 c0                	add    %eax,%eax
 2f3:	89 c1                	mov    %eax,%ecx
 2f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f9:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2fd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 301:	0f b6 00             	movzbl (%rax),%eax
 304:	0f be c0             	movsbl %al,%eax
 307:	01 c8                	add    %ecx,%eax
 309:	83 e8 30             	sub    $0x30,%eax
 30c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 30f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 313:	0f b6 00             	movzbl (%rax),%eax
 316:	3c 2f                	cmp    $0x2f,%al
 318:	7e 0b                	jle    325 <atoi+0x57>
 31a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31e:	0f b6 00             	movzbl (%rax),%eax
 321:	3c 39                	cmp    $0x39,%al
 323:	7e c2                	jle    2e7 <atoi+0x19>
  return n;
 325:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 328:	c9                   	leave
 329:	c3                   	ret

000000000000032a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32a:	f3 0f 1e fa          	endbr64
 32e:	55                   	push   %rbp
 32f:	48 89 e5             	mov    %rsp,%rbp
 332:	48 83 ec 28          	sub    $0x28,%rsp
 336:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 33a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 33e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 341:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 345:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 349:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 34d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 351:	eb 1d                	jmp    370 <memmove+0x46>
    *dst++ = *src++;
 353:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 357:	48 8d 42 01          	lea    0x1(%rdx),%rax
 35b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 35f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 363:	48 8d 48 01          	lea    0x1(%rax),%rcx
 367:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 36b:	0f b6 12             	movzbl (%rdx),%edx
 36e:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 370:	8b 45 dc             	mov    -0x24(%rbp),%eax
 373:	8d 50 ff             	lea    -0x1(%rax),%edx
 376:	89 55 dc             	mov    %edx,-0x24(%rbp)
 379:	85 c0                	test   %eax,%eax
 37b:	7f d6                	jg     353 <memmove+0x29>
  return vdst;
 37d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 381:	c9                   	leave
 382:	c3                   	ret

0000000000000383 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 383:	b8 01 00 00 00       	mov    $0x1,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

000000000000038b <exit>:
SYSCALL(exit)
 38b:	b8 02 00 00 00       	mov    $0x2,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

0000000000000393 <wait>:
SYSCALL(wait)
 393:	b8 03 00 00 00       	mov    $0x3,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

000000000000039b <pipe>:
SYSCALL(pipe)
 39b:	b8 04 00 00 00       	mov    $0x4,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

00000000000003a3 <read>:
SYSCALL(read)
 3a3:	b8 05 00 00 00       	mov    $0x5,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

00000000000003ab <write>:
SYSCALL(write)
 3ab:	b8 10 00 00 00       	mov    $0x10,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

00000000000003b3 <close>:
SYSCALL(close)
 3b3:	b8 15 00 00 00       	mov    $0x15,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

00000000000003bb <kill>:
SYSCALL(kill)
 3bb:	b8 06 00 00 00       	mov    $0x6,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

00000000000003c3 <exec>:
SYSCALL(exec)
 3c3:	b8 07 00 00 00       	mov    $0x7,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

00000000000003cb <open>:
SYSCALL(open)
 3cb:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

00000000000003d3 <mknod>:
SYSCALL(mknod)
 3d3:	b8 11 00 00 00       	mov    $0x11,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

00000000000003db <unlink>:
SYSCALL(unlink)
 3db:	b8 12 00 00 00       	mov    $0x12,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

00000000000003e3 <fstat>:
SYSCALL(fstat)
 3e3:	b8 08 00 00 00       	mov    $0x8,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

00000000000003eb <link>:
SYSCALL(link)
 3eb:	b8 13 00 00 00       	mov    $0x13,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

00000000000003f3 <mkdir>:
SYSCALL(mkdir)
 3f3:	b8 14 00 00 00       	mov    $0x14,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

00000000000003fb <chdir>:
SYSCALL(chdir)
 3fb:	b8 09 00 00 00       	mov    $0x9,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

0000000000000403 <dup>:
SYSCALL(dup)
 403:	b8 0a 00 00 00       	mov    $0xa,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

000000000000040b <getpid>:
SYSCALL(getpid)
 40b:	b8 0b 00 00 00       	mov    $0xb,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

0000000000000413 <sbrk>:
SYSCALL(sbrk)
 413:	b8 0c 00 00 00       	mov    $0xc,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

000000000000041b <sleep>:
SYSCALL(sleep)
 41b:	b8 0d 00 00 00       	mov    $0xd,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

0000000000000423 <uptime>:
SYSCALL(uptime)
 423:	b8 0e 00 00 00       	mov    $0xe,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

000000000000042b <getpinfo>:
SYSCALL(getpinfo)
 42b:	b8 18 00 00 00       	mov    $0x18,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

0000000000000433 <settickets>:
SYSCALL(settickets)
 433:	b8 1b 00 00 00       	mov    $0x1b,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

000000000000043b <getfavnum>:
SYSCALL(getfavnum)
 43b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

0000000000000443 <halt>:
SYSCALL(halt)
 443:	b8 1d 00 00 00       	mov    $0x1d,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

000000000000044b <getcount>:
SYSCALL(getcount)
 44b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

0000000000000453 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 453:	f3 0f 1e fa          	endbr64
 457:	55                   	push   %rbp
 458:	48 89 e5             	mov    %rsp,%rbp
 45b:	48 83 ec 10          	sub    $0x10,%rsp
 45f:	89 7d fc             	mov    %edi,-0x4(%rbp)
 462:	89 f0                	mov    %esi,%eax
 464:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 467:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 46b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 46e:	ba 01 00 00 00       	mov    $0x1,%edx
 473:	48 89 ce             	mov    %rcx,%rsi
 476:	89 c7                	mov    %eax,%edi
 478:	e8 2e ff ff ff       	call   3ab <write>
}
 47d:	90                   	nop
 47e:	c9                   	leave
 47f:	c3                   	ret

0000000000000480 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	f3 0f 1e fa          	endbr64
 484:	55                   	push   %rbp
 485:	48 89 e5             	mov    %rsp,%rbp
 488:	48 83 ec 30          	sub    $0x30,%rsp
 48c:	89 7d dc             	mov    %edi,-0x24(%rbp)
 48f:	89 75 d8             	mov    %esi,-0x28(%rbp)
 492:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 495:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 498:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 49f:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4a3:	74 17                	je     4bc <printint+0x3c>
 4a5:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4a9:	79 11                	jns    4bc <printint+0x3c>
    neg = 1;
 4ab:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4b2:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b5:	f7 d8                	neg    %eax
 4b7:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ba:	eb 06                	jmp    4c2 <printint+0x42>
  } else {
    x = xx;
 4bc:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4bf:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4c9:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4cc:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4cf:	ba 00 00 00 00       	mov    $0x0,%edx
 4d4:	f7 f6                	div    %esi
 4d6:	89 d1                	mov    %edx,%ecx
 4d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4db:	8d 50 01             	lea    0x1(%rax),%edx
 4de:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e1:	89 ca                	mov    %ecx,%edx
 4e3:	0f b6 92 b0 0d 00 00 	movzbl 0xdb0(%rdx),%edx
 4ea:	48 98                	cltq
 4ec:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4f0:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4f6:	ba 00 00 00 00       	mov    $0x0,%edx
 4fb:	f7 f7                	div    %edi
 4fd:	89 45 f4             	mov    %eax,-0xc(%rbp)
 500:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 504:	75 c3                	jne    4c9 <printint+0x49>
  if(neg)
 506:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 50a:	74 2b                	je     537 <printint+0xb7>
    buf[i++] = '-';
 50c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 50f:	8d 50 01             	lea    0x1(%rax),%edx
 512:	89 55 fc             	mov    %edx,-0x4(%rbp)
 515:	48 98                	cltq
 517:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 51c:	eb 19                	jmp    537 <printint+0xb7>
    putc(fd, buf[i]);
 51e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 521:	48 98                	cltq
 523:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 528:	0f be d0             	movsbl %al,%edx
 52b:	8b 45 dc             	mov    -0x24(%rbp),%eax
 52e:	89 d6                	mov    %edx,%esi
 530:	89 c7                	mov    %eax,%edi
 532:	e8 1c ff ff ff       	call   453 <putc>
  while(--i >= 0)
 537:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 53b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 53f:	79 dd                	jns    51e <printint+0x9e>
}
 541:	90                   	nop
 542:	90                   	nop
 543:	c9                   	leave
 544:	c3                   	ret

0000000000000545 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 545:	f3 0f 1e fa          	endbr64
 549:	55                   	push   %rbp
 54a:	48 89 e5             	mov    %rsp,%rbp
 54d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 554:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 55a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 561:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 568:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 56f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 576:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 57d:	84 c0                	test   %al,%al
 57f:	74 20                	je     5a1 <printf+0x5c>
 581:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 585:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 589:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 58d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 591:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 595:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 599:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 59d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5a1:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5a8:	00 00 00 
 5ab:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5b2:	00 00 00 
 5b5:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5b9:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5c0:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5c7:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5ce:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5d5:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5d8:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5df:	00 00 00 
 5e2:	e9 a8 02 00 00       	jmp    88f <printf+0x34a>
    c = fmt[i] & 0xff;
 5e7:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5ed:	48 63 d0             	movslq %eax,%rdx
 5f0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5f7:	48 01 d0             	add    %rdx,%rax
 5fa:	0f b6 00             	movzbl (%rax),%eax
 5fd:	0f be c0             	movsbl %al,%eax
 600:	25 ff 00 00 00       	and    $0xff,%eax
 605:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 60b:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 612:	75 35                	jne    649 <printf+0x104>
      if(c == '%'){
 614:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 61b:	75 0f                	jne    62c <printf+0xe7>
        state = '%';
 61d:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 624:	00 00 00 
 627:	e9 5c 02 00 00       	jmp    888 <printf+0x343>
      } else {
        putc(fd, c);
 62c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 632:	0f be d0             	movsbl %al,%edx
 635:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 63b:	89 d6                	mov    %edx,%esi
 63d:	89 c7                	mov    %eax,%edi
 63f:	e8 0f fe ff ff       	call   453 <putc>
 644:	e9 3f 02 00 00       	jmp    888 <printf+0x343>
      }
    } else if(state == '%'){
 649:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 650:	0f 85 32 02 00 00    	jne    888 <printf+0x343>
      if(c == 'd'){
 656:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 65d:	75 5e                	jne    6bd <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 65f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 665:	83 f8 2f             	cmp    $0x2f,%eax
 668:	77 23                	ja     68d <printf+0x148>
 66a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 671:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 677:	89 d2                	mov    %edx,%edx
 679:	48 01 d0             	add    %rdx,%rax
 67c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 682:	83 c2 08             	add    $0x8,%edx
 685:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 68b:	eb 12                	jmp    69f <printf+0x15a>
 68d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 694:	48 8d 50 08          	lea    0x8(%rax),%rdx
 698:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 69f:	8b 30                	mov    (%rax),%esi
 6a1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6a7:	b9 01 00 00 00       	mov    $0x1,%ecx
 6ac:	ba 0a 00 00 00       	mov    $0xa,%edx
 6b1:	89 c7                	mov    %eax,%edi
 6b3:	e8 c8 fd ff ff       	call   480 <printint>
 6b8:	e9 c1 01 00 00       	jmp    87e <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6bd:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6c4:	74 09                	je     6cf <printf+0x18a>
 6c6:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6cd:	75 5e                	jne    72d <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6cf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d5:	83 f8 2f             	cmp    $0x2f,%eax
 6d8:	77 23                	ja     6fd <printf+0x1b8>
 6da:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6e7:	89 d2                	mov    %edx,%edx
 6e9:	48 01 d0             	add    %rdx,%rax
 6ec:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f2:	83 c2 08             	add    $0x8,%edx
 6f5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6fb:	eb 12                	jmp    70f <printf+0x1ca>
 6fd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 704:	48 8d 50 08          	lea    0x8(%rax),%rdx
 708:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 70f:	8b 30                	mov    (%rax),%esi
 711:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 717:	b9 00 00 00 00       	mov    $0x0,%ecx
 71c:	ba 10 00 00 00       	mov    $0x10,%edx
 721:	89 c7                	mov    %eax,%edi
 723:	e8 58 fd ff ff       	call   480 <printint>
 728:	e9 51 01 00 00       	jmp    87e <printf+0x339>
      } else if(c == 's'){
 72d:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 734:	0f 85 98 00 00 00    	jne    7d2 <printf+0x28d>
        s = va_arg(ap, char*);
 73a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 740:	83 f8 2f             	cmp    $0x2f,%eax
 743:	77 23                	ja     768 <printf+0x223>
 745:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 74c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 752:	89 d2                	mov    %edx,%edx
 754:	48 01 d0             	add    %rdx,%rax
 757:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75d:	83 c2 08             	add    $0x8,%edx
 760:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 766:	eb 12                	jmp    77a <printf+0x235>
 768:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 76f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 773:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 77a:	48 8b 00             	mov    (%rax),%rax
 77d:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 784:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 78b:	00 
 78c:	75 31                	jne    7bf <printf+0x27a>
          s = "(null)";
 78e:	48 c7 85 48 ff ff ff 	movq   $0xb6e,-0xb8(%rbp)
 795:	6e 0b 00 00 
        while(*s != 0){
 799:	eb 24                	jmp    7bf <printf+0x27a>
          putc(fd, *s);
 79b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7a2:	0f b6 00             	movzbl (%rax),%eax
 7a5:	0f be d0             	movsbl %al,%edx
 7a8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ae:	89 d6                	mov    %edx,%esi
 7b0:	89 c7                	mov    %eax,%edi
 7b2:	e8 9c fc ff ff       	call   453 <putc>
          s++;
 7b7:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7be:	01 
        while(*s != 0){
 7bf:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7c6:	0f b6 00             	movzbl (%rax),%eax
 7c9:	84 c0                	test   %al,%al
 7cb:	75 ce                	jne    79b <printf+0x256>
 7cd:	e9 ac 00 00 00       	jmp    87e <printf+0x339>
        }
      } else if(c == 'c'){
 7d2:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7d9:	75 56                	jne    831 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7e1:	83 f8 2f             	cmp    $0x2f,%eax
 7e4:	77 23                	ja     809 <printf+0x2c4>
 7e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f3:	89 d2                	mov    %edx,%edx
 7f5:	48 01 d0             	add    %rdx,%rax
 7f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7fe:	83 c2 08             	add    $0x8,%edx
 801:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 807:	eb 12                	jmp    81b <printf+0x2d6>
 809:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 810:	48 8d 50 08          	lea    0x8(%rax),%rdx
 814:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 81b:	8b 00                	mov    (%rax),%eax
 81d:	0f be d0             	movsbl %al,%edx
 820:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 826:	89 d6                	mov    %edx,%esi
 828:	89 c7                	mov    %eax,%edi
 82a:	e8 24 fc ff ff       	call   453 <putc>
 82f:	eb 4d                	jmp    87e <printf+0x339>
      } else if(c == '%'){
 831:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 838:	75 1a                	jne    854 <printf+0x30f>
        putc(fd, c);
 83a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 840:	0f be d0             	movsbl %al,%edx
 843:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 849:	89 d6                	mov    %edx,%esi
 84b:	89 c7                	mov    %eax,%edi
 84d:	e8 01 fc ff ff       	call   453 <putc>
 852:	eb 2a                	jmp    87e <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 854:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85a:	be 25 00 00 00       	mov    $0x25,%esi
 85f:	89 c7                	mov    %eax,%edi
 861:	e8 ed fb ff ff       	call   453 <putc>
        putc(fd, c);
 866:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 86c:	0f be d0             	movsbl %al,%edx
 86f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 875:	89 d6                	mov    %edx,%esi
 877:	89 c7                	mov    %eax,%edi
 879:	e8 d5 fb ff ff       	call   453 <putc>
      }
      state = 0;
 87e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 885:	00 00 00 
  for(i = 0; fmt[i]; i++){
 888:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 88f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 895:	48 63 d0             	movslq %eax,%rdx
 898:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 89f:	48 01 d0             	add    %rdx,%rax
 8a2:	0f b6 00             	movzbl (%rax),%eax
 8a5:	84 c0                	test   %al,%al
 8a7:	0f 85 3a fd ff ff    	jne    5e7 <printf+0xa2>
    }
  }
}
 8ad:	90                   	nop
 8ae:	90                   	nop
 8af:	c9                   	leave
 8b0:	c3                   	ret

00000000000008b1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b1:	f3 0f 1e fa          	endbr64
 8b5:	55                   	push   %rbp
 8b6:	48 89 e5             	mov    %rsp,%rbp
 8b9:	48 83 ec 18          	sub    $0x18,%rsp
 8bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8c5:	48 83 e8 10          	sub    $0x10,%rax
 8c9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cd:	48 8b 05 0c 05 00 00 	mov    0x50c(%rip),%rax        # de0 <freep>
 8d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d8:	eb 2f                	jmp    909 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8de:	48 8b 00             	mov    (%rax),%rax
 8e1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e5:	72 17                	jb     8fe <free+0x4d>
 8e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8eb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ef:	72 2f                	jb     920 <free+0x6f>
 8f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f5:	48 8b 00             	mov    (%rax),%rax
 8f8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8fc:	72 22                	jb     920 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 902:	48 8b 00             	mov    (%rax),%rax
 905:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 909:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 911:	73 c7                	jae    8da <free+0x29>
 913:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 917:	48 8b 00             	mov    (%rax),%rax
 91a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 91e:	73 ba                	jae    8da <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 920:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 924:	8b 40 08             	mov    0x8(%rax),%eax
 927:	89 c0                	mov    %eax,%eax
 929:	48 c1 e0 04          	shl    $0x4,%rax
 92d:	48 89 c2             	mov    %rax,%rdx
 930:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 934:	48 01 c2             	add    %rax,%rdx
 937:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93b:	48 8b 00             	mov    (%rax),%rax
 93e:	48 39 c2             	cmp    %rax,%rdx
 941:	75 2d                	jne    970 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 943:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 947:	8b 50 08             	mov    0x8(%rax),%edx
 94a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94e:	48 8b 00             	mov    (%rax),%rax
 951:	8b 40 08             	mov    0x8(%rax),%eax
 954:	01 c2                	add    %eax,%edx
 956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95a:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 95d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 961:	48 8b 00             	mov    (%rax),%rax
 964:	48 8b 10             	mov    (%rax),%rdx
 967:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96b:	48 89 10             	mov    %rdx,(%rax)
 96e:	eb 0e                	jmp    97e <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 970:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 974:	48 8b 10             	mov    (%rax),%rdx
 977:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97b:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 97e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 982:	8b 40 08             	mov    0x8(%rax),%eax
 985:	89 c0                	mov    %eax,%eax
 987:	48 c1 e0 04          	shl    $0x4,%rax
 98b:	48 89 c2             	mov    %rax,%rdx
 98e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 992:	48 01 d0             	add    %rdx,%rax
 995:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 999:	75 27                	jne    9c2 <free+0x111>
    p->s.size += bp->s.size;
 99b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99f:	8b 50 08             	mov    0x8(%rax),%edx
 9a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a6:	8b 40 08             	mov    0x8(%rax),%eax
 9a9:	01 c2                	add    %eax,%edx
 9ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9af:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b6:	48 8b 10             	mov    (%rax),%rdx
 9b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bd:	48 89 10             	mov    %rdx,(%rax)
 9c0:	eb 0b                	jmp    9cd <free+0x11c>
  } else
    p->s.ptr = bp;
 9c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9ca:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d1:	48 89 05 08 04 00 00 	mov    %rax,0x408(%rip)        # de0 <freep>
}
 9d8:	90                   	nop
 9d9:	c9                   	leave
 9da:	c3                   	ret

00000000000009db <morecore>:

static Header*
morecore(uint nu)
{
 9db:	f3 0f 1e fa          	endbr64
 9df:	55                   	push   %rbp
 9e0:	48 89 e5             	mov    %rsp,%rbp
 9e3:	48 83 ec 20          	sub    $0x20,%rsp
 9e7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9ea:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9f1:	77 07                	ja     9fa <morecore+0x1f>
    nu = 4096;
 9f3:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9fd:	c1 e0 04             	shl    $0x4,%eax
 a00:	89 c7                	mov    %eax,%edi
 a02:	e8 0c fa ff ff       	call   413 <sbrk>
 a07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a0b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a10:	75 07                	jne    a19 <morecore+0x3e>
    return 0;
 a12:	b8 00 00 00 00       	mov    $0x0,%eax
 a17:	eb 29                	jmp    a42 <morecore+0x67>
  hp = (Header*)p;
 a19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a25:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a28:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2f:	48 83 c0 10          	add    $0x10,%rax
 a33:	48 89 c7             	mov    %rax,%rdi
 a36:	e8 76 fe ff ff       	call   8b1 <free>
  return freep;
 a3b:	48 8b 05 9e 03 00 00 	mov    0x39e(%rip),%rax        # de0 <freep>
}
 a42:	c9                   	leave
 a43:	c3                   	ret

0000000000000a44 <malloc>:

void*
malloc(uint nbytes)
{
 a44:	f3 0f 1e fa          	endbr64
 a48:	55                   	push   %rbp
 a49:	48 89 e5             	mov    %rsp,%rbp
 a4c:	48 83 ec 30          	sub    $0x30,%rsp
 a50:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a53:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a56:	48 83 c0 0f          	add    $0xf,%rax
 a5a:	48 c1 e8 04          	shr    $0x4,%rax
 a5e:	83 c0 01             	add    $0x1,%eax
 a61:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a64:	48 8b 05 75 03 00 00 	mov    0x375(%rip),%rax        # de0 <freep>
 a6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a6f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a74:	75 2b                	jne    aa1 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a76:	48 c7 45 f0 d0 0d 00 	movq   $0xdd0,-0x10(%rbp)
 a7d:	00 
 a7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a82:	48 89 05 57 03 00 00 	mov    %rax,0x357(%rip)        # de0 <freep>
 a89:	48 8b 05 50 03 00 00 	mov    0x350(%rip),%rax        # de0 <freep>
 a90:	48 89 05 39 03 00 00 	mov    %rax,0x339(%rip)        # dd0 <base>
    base.s.size = 0;
 a97:	c7 05 37 03 00 00 00 	movl   $0x0,0x337(%rip)        # dd8 <base+0x8>
 a9e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa5:	48 8b 00             	mov    (%rax),%rax
 aa8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	8b 40 08             	mov    0x8(%rax),%eax
 ab3:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ab6:	72 5f                	jb     b17 <malloc+0xd3>
      if(p->s.size == nunits)
 ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abc:	8b 40 08             	mov    0x8(%rax),%eax
 abf:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ac2:	75 10                	jne    ad4 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	48 8b 10             	mov    (%rax),%rdx
 acb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 acf:	48 89 10             	mov    %rdx,(%rax)
 ad2:	eb 2e                	jmp    b02 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad8:	8b 40 08             	mov    0x8(%rax),%eax
 adb:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ade:	89 c2                	mov    %eax,%edx
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aeb:	8b 40 08             	mov    0x8(%rax),%eax
 aee:	89 c0                	mov    %eax,%eax
 af0:	48 c1 e0 04          	shl    $0x4,%rax
 af4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 af8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afc:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aff:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b06:	48 89 05 d3 02 00 00 	mov    %rax,0x2d3(%rip)        # de0 <freep>
      return (void*)(p + 1);
 b0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b11:	48 83 c0 10          	add    $0x10,%rax
 b15:	eb 41                	jmp    b58 <malloc+0x114>
    }
    if(p == freep)
 b17:	48 8b 05 c2 02 00 00 	mov    0x2c2(%rip),%rax        # de0 <freep>
 b1e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b22:	75 1c                	jne    b40 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b24:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b27:	89 c7                	mov    %eax,%edi
 b29:	e8 ad fe ff ff       	call   9db <morecore>
 b2e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b32:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b37:	75 07                	jne    b40 <malloc+0xfc>
        return 0;
 b39:	b8 00 00 00 00       	mov    $0x0,%eax
 b3e:	eb 18                	jmp    b58 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4c:	48 8b 00             	mov    (%rax),%rax
 b4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b53:	e9 54 ff ff ff       	jmp    aac <malloc+0x68>
  }
}
 b58:	c9                   	leave
 b59:	c3                   	ret
