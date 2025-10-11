
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
  19:	48 c7 c6 62 0b 00 00 	mov    $0xb62,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 1e 05 00 00       	call   54d <printf>
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

0000000000000453 <killrandom>:
SYSCALL(killrandom)
 453:	b8 1f 00 00 00       	mov    $0x1f,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

000000000000045b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45b:	f3 0f 1e fa          	endbr64
 45f:	55                   	push   %rbp
 460:	48 89 e5             	mov    %rsp,%rbp
 463:	48 83 ec 10          	sub    $0x10,%rsp
 467:	89 7d fc             	mov    %edi,-0x4(%rbp)
 46a:	89 f0                	mov    %esi,%eax
 46c:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 46f:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 473:	8b 45 fc             	mov    -0x4(%rbp),%eax
 476:	ba 01 00 00 00       	mov    $0x1,%edx
 47b:	48 89 ce             	mov    %rcx,%rsi
 47e:	89 c7                	mov    %eax,%edi
 480:	e8 26 ff ff ff       	call   3ab <write>
}
 485:	90                   	nop
 486:	c9                   	leave
 487:	c3                   	ret

0000000000000488 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 488:	f3 0f 1e fa          	endbr64
 48c:	55                   	push   %rbp
 48d:	48 89 e5             	mov    %rsp,%rbp
 490:	48 83 ec 30          	sub    $0x30,%rsp
 494:	89 7d dc             	mov    %edi,-0x24(%rbp)
 497:	89 75 d8             	mov    %esi,-0x28(%rbp)
 49a:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 49d:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4a7:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4ab:	74 17                	je     4c4 <printint+0x3c>
 4ad:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4b1:	79 11                	jns    4c4 <printint+0x3c>
    neg = 1;
 4b3:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4ba:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4bd:	f7 d8                	neg    %eax
 4bf:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4c2:	eb 06                	jmp    4ca <printint+0x42>
  } else {
    x = xx;
 4c4:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c7:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4d1:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4d7:	ba 00 00 00 00       	mov    $0x0,%edx
 4dc:	f7 f6                	div    %esi
 4de:	89 d1                	mov    %edx,%ecx
 4e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e3:	8d 50 01             	lea    0x1(%rax),%edx
 4e6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e9:	89 ca                	mov    %ecx,%edx
 4eb:	0f b6 92 c0 0d 00 00 	movzbl 0xdc0(%rdx),%edx
 4f2:	48 98                	cltq
 4f4:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4f8:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4fb:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4fe:	ba 00 00 00 00       	mov    $0x0,%edx
 503:	f7 f7                	div    %edi
 505:	89 45 f4             	mov    %eax,-0xc(%rbp)
 508:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 50c:	75 c3                	jne    4d1 <printint+0x49>
  if(neg)
 50e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 512:	74 2b                	je     53f <printint+0xb7>
    buf[i++] = '-';
 514:	8b 45 fc             	mov    -0x4(%rbp),%eax
 517:	8d 50 01             	lea    0x1(%rax),%edx
 51a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 51d:	48 98                	cltq
 51f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 524:	eb 19                	jmp    53f <printint+0xb7>
    putc(fd, buf[i]);
 526:	8b 45 fc             	mov    -0x4(%rbp),%eax
 529:	48 98                	cltq
 52b:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 530:	0f be d0             	movsbl %al,%edx
 533:	8b 45 dc             	mov    -0x24(%rbp),%eax
 536:	89 d6                	mov    %edx,%esi
 538:	89 c7                	mov    %eax,%edi
 53a:	e8 1c ff ff ff       	call   45b <putc>
  while(--i >= 0)
 53f:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 543:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 547:	79 dd                	jns    526 <printint+0x9e>
}
 549:	90                   	nop
 54a:	90                   	nop
 54b:	c9                   	leave
 54c:	c3                   	ret

000000000000054d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 54d:	f3 0f 1e fa          	endbr64
 551:	55                   	push   %rbp
 552:	48 89 e5             	mov    %rsp,%rbp
 555:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 55c:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 562:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 569:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 570:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 577:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 57e:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 585:	84 c0                	test   %al,%al
 587:	74 20                	je     5a9 <printf+0x5c>
 589:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 58d:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 591:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 595:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 599:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 59d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5a1:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a5:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5a9:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5b0:	00 00 00 
 5b3:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5ba:	00 00 00 
 5bd:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5c1:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5c8:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5cf:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5d6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5dd:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5e0:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5e7:	00 00 00 
 5ea:	e9 a8 02 00 00       	jmp    897 <printf+0x34a>
    c = fmt[i] & 0xff;
 5ef:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f5:	48 63 d0             	movslq %eax,%rdx
 5f8:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5ff:	48 01 d0             	add    %rdx,%rax
 602:	0f b6 00             	movzbl (%rax),%eax
 605:	0f be c0             	movsbl %al,%eax
 608:	25 ff 00 00 00       	and    $0xff,%eax
 60d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 613:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 61a:	75 35                	jne    651 <printf+0x104>
      if(c == '%'){
 61c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 623:	75 0f                	jne    634 <printf+0xe7>
        state = '%';
 625:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 62c:	00 00 00 
 62f:	e9 5c 02 00 00       	jmp    890 <printf+0x343>
      } else {
        putc(fd, c);
 634:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 63a:	0f be d0             	movsbl %al,%edx
 63d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 643:	89 d6                	mov    %edx,%esi
 645:	89 c7                	mov    %eax,%edi
 647:	e8 0f fe ff ff       	call   45b <putc>
 64c:	e9 3f 02 00 00       	jmp    890 <printf+0x343>
      }
    } else if(state == '%'){
 651:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 658:	0f 85 32 02 00 00    	jne    890 <printf+0x343>
      if(c == 'd'){
 65e:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 665:	75 5e                	jne    6c5 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 667:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 66d:	83 f8 2f             	cmp    $0x2f,%eax
 670:	77 23                	ja     695 <printf+0x148>
 672:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 679:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67f:	89 d2                	mov    %edx,%edx
 681:	48 01 d0             	add    %rdx,%rax
 684:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68a:	83 c2 08             	add    $0x8,%edx
 68d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 693:	eb 12                	jmp    6a7 <printf+0x15a>
 695:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 69c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6a0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6a7:	8b 30                	mov    (%rax),%esi
 6a9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6af:	b9 01 00 00 00       	mov    $0x1,%ecx
 6b4:	ba 0a 00 00 00       	mov    $0xa,%edx
 6b9:	89 c7                	mov    %eax,%edi
 6bb:	e8 c8 fd ff ff       	call   488 <printint>
 6c0:	e9 c1 01 00 00       	jmp    886 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c5:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6cc:	74 09                	je     6d7 <printf+0x18a>
 6ce:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d5:	75 5e                	jne    735 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6d7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6dd:	83 f8 2f             	cmp    $0x2f,%eax
 6e0:	77 23                	ja     705 <printf+0x1b8>
 6e2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ef:	89 d2                	mov    %edx,%edx
 6f1:	48 01 d0             	add    %rdx,%rax
 6f4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fa:	83 c2 08             	add    $0x8,%edx
 6fd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 703:	eb 12                	jmp    717 <printf+0x1ca>
 705:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 70c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 710:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 717:	8b 30                	mov    (%rax),%esi
 719:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 71f:	b9 00 00 00 00       	mov    $0x0,%ecx
 724:	ba 10 00 00 00       	mov    $0x10,%edx
 729:	89 c7                	mov    %eax,%edi
 72b:	e8 58 fd ff ff       	call   488 <printint>
 730:	e9 51 01 00 00       	jmp    886 <printf+0x339>
      } else if(c == 's'){
 735:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 73c:	0f 85 98 00 00 00    	jne    7da <printf+0x28d>
        s = va_arg(ap, char*);
 742:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 748:	83 f8 2f             	cmp    $0x2f,%eax
 74b:	77 23                	ja     770 <printf+0x223>
 74d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 754:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75a:	89 d2                	mov    %edx,%edx
 75c:	48 01 d0             	add    %rdx,%rax
 75f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 765:	83 c2 08             	add    $0x8,%edx
 768:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 76e:	eb 12                	jmp    782 <printf+0x235>
 770:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 777:	48 8d 50 08          	lea    0x8(%rax),%rdx
 77b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 782:	48 8b 00             	mov    (%rax),%rax
 785:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 78c:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 793:	00 
 794:	75 31                	jne    7c7 <printf+0x27a>
          s = "(null)";
 796:	48 c7 85 48 ff ff ff 	movq   $0xb76,-0xb8(%rbp)
 79d:	76 0b 00 00 
        while(*s != 0){
 7a1:	eb 24                	jmp    7c7 <printf+0x27a>
          putc(fd, *s);
 7a3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7aa:	0f b6 00             	movzbl (%rax),%eax
 7ad:	0f be d0             	movsbl %al,%edx
 7b0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b6:	89 d6                	mov    %edx,%esi
 7b8:	89 c7                	mov    %eax,%edi
 7ba:	e8 9c fc ff ff       	call   45b <putc>
          s++;
 7bf:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7c6:	01 
        while(*s != 0){
 7c7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ce:	0f b6 00             	movzbl (%rax),%eax
 7d1:	84 c0                	test   %al,%al
 7d3:	75 ce                	jne    7a3 <printf+0x256>
 7d5:	e9 ac 00 00 00       	jmp    886 <printf+0x339>
        }
      } else if(c == 'c'){
 7da:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7e1:	75 56                	jne    839 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7e3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7e9:	83 f8 2f             	cmp    $0x2f,%eax
 7ec:	77 23                	ja     811 <printf+0x2c4>
 7ee:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7fb:	89 d2                	mov    %edx,%edx
 7fd:	48 01 d0             	add    %rdx,%rax
 800:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 806:	83 c2 08             	add    $0x8,%edx
 809:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 80f:	eb 12                	jmp    823 <printf+0x2d6>
 811:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 818:	48 8d 50 08          	lea    0x8(%rax),%rdx
 81c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 823:	8b 00                	mov    (%rax),%eax
 825:	0f be d0             	movsbl %al,%edx
 828:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 82e:	89 d6                	mov    %edx,%esi
 830:	89 c7                	mov    %eax,%edi
 832:	e8 24 fc ff ff       	call   45b <putc>
 837:	eb 4d                	jmp    886 <printf+0x339>
      } else if(c == '%'){
 839:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 840:	75 1a                	jne    85c <printf+0x30f>
        putc(fd, c);
 842:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 848:	0f be d0             	movsbl %al,%edx
 84b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 851:	89 d6                	mov    %edx,%esi
 853:	89 c7                	mov    %eax,%edi
 855:	e8 01 fc ff ff       	call   45b <putc>
 85a:	eb 2a                	jmp    886 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 85c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 862:	be 25 00 00 00       	mov    $0x25,%esi
 867:	89 c7                	mov    %eax,%edi
 869:	e8 ed fb ff ff       	call   45b <putc>
        putc(fd, c);
 86e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 874:	0f be d0             	movsbl %al,%edx
 877:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 87d:	89 d6                	mov    %edx,%esi
 87f:	89 c7                	mov    %eax,%edi
 881:	e8 d5 fb ff ff       	call   45b <putc>
      }
      state = 0;
 886:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 88d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 890:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 897:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 89d:	48 63 d0             	movslq %eax,%rdx
 8a0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8a7:	48 01 d0             	add    %rdx,%rax
 8aa:	0f b6 00             	movzbl (%rax),%eax
 8ad:	84 c0                	test   %al,%al
 8af:	0f 85 3a fd ff ff    	jne    5ef <printf+0xa2>
    }
  }
}
 8b5:	90                   	nop
 8b6:	90                   	nop
 8b7:	c9                   	leave
 8b8:	c3                   	ret

00000000000008b9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b9:	f3 0f 1e fa          	endbr64
 8bd:	55                   	push   %rbp
 8be:	48 89 e5             	mov    %rsp,%rbp
 8c1:	48 83 ec 18          	sub    $0x18,%rsp
 8c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8cd:	48 83 e8 10          	sub    $0x10,%rax
 8d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d5:	48 8b 05 14 05 00 00 	mov    0x514(%rip),%rax        # df0 <freep>
 8dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8e0:	eb 2f                	jmp    911 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e6:	48 8b 00             	mov    (%rax),%rax
 8e9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ed:	72 17                	jb     906 <free+0x4d>
 8ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f7:	72 2f                	jb     928 <free+0x6f>
 8f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fd:	48 8b 00             	mov    (%rax),%rax
 900:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 904:	72 22                	jb     928 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 906:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90a:	48 8b 00             	mov    (%rax),%rax
 90d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 911:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 915:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 919:	73 c7                	jae    8e2 <free+0x29>
 91b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91f:	48 8b 00             	mov    (%rax),%rax
 922:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 926:	73 ba                	jae    8e2 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92c:	8b 40 08             	mov    0x8(%rax),%eax
 92f:	89 c0                	mov    %eax,%eax
 931:	48 c1 e0 04          	shl    $0x4,%rax
 935:	48 89 c2             	mov    %rax,%rdx
 938:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93c:	48 01 c2             	add    %rax,%rdx
 93f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 943:	48 8b 00             	mov    (%rax),%rax
 946:	48 39 c2             	cmp    %rax,%rdx
 949:	75 2d                	jne    978 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 94b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94f:	8b 50 08             	mov    0x8(%rax),%edx
 952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 956:	48 8b 00             	mov    (%rax),%rax
 959:	8b 40 08             	mov    0x8(%rax),%eax
 95c:	01 c2                	add    %eax,%edx
 95e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 962:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 965:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 969:	48 8b 00             	mov    (%rax),%rax
 96c:	48 8b 10             	mov    (%rax),%rdx
 96f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 973:	48 89 10             	mov    %rdx,(%rax)
 976:	eb 0e                	jmp    986 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 978:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97c:	48 8b 10             	mov    (%rax),%rdx
 97f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 983:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98a:	8b 40 08             	mov    0x8(%rax),%eax
 98d:	89 c0                	mov    %eax,%eax
 98f:	48 c1 e0 04          	shl    $0x4,%rax
 993:	48 89 c2             	mov    %rax,%rdx
 996:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99a:	48 01 d0             	add    %rdx,%rax
 99d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9a1:	75 27                	jne    9ca <free+0x111>
    p->s.size += bp->s.size;
 9a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a7:	8b 50 08             	mov    0x8(%rax),%edx
 9aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ae:	8b 40 08             	mov    0x8(%rax),%eax
 9b1:	01 c2                	add    %eax,%edx
 9b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b7:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9be:	48 8b 10             	mov    (%rax),%rdx
 9c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c5:	48 89 10             	mov    %rdx,(%rax)
 9c8:	eb 0b                	jmp    9d5 <free+0x11c>
  } else
    p->s.ptr = bp;
 9ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9d2:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d9:	48 89 05 10 04 00 00 	mov    %rax,0x410(%rip)        # df0 <freep>
}
 9e0:	90                   	nop
 9e1:	c9                   	leave
 9e2:	c3                   	ret

00000000000009e3 <morecore>:

static Header*
morecore(uint nu)
{
 9e3:	f3 0f 1e fa          	endbr64
 9e7:	55                   	push   %rbp
 9e8:	48 89 e5             	mov    %rsp,%rbp
 9eb:	48 83 ec 20          	sub    $0x20,%rsp
 9ef:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9f2:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9f9:	77 07                	ja     a02 <morecore+0x1f>
    nu = 4096;
 9fb:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a02:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a05:	c1 e0 04             	shl    $0x4,%eax
 a08:	89 c7                	mov    %eax,%edi
 a0a:	e8 04 fa ff ff       	call   413 <sbrk>
 a0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a13:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a18:	75 07                	jne    a21 <morecore+0x3e>
    return 0;
 a1a:	b8 00 00 00 00       	mov    $0x0,%eax
 a1f:	eb 29                	jmp    a4a <morecore+0x67>
  hp = (Header*)p;
 a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a25:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a30:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a37:	48 83 c0 10          	add    $0x10,%rax
 a3b:	48 89 c7             	mov    %rax,%rdi
 a3e:	e8 76 fe ff ff       	call   8b9 <free>
  return freep;
 a43:	48 8b 05 a6 03 00 00 	mov    0x3a6(%rip),%rax        # df0 <freep>
}
 a4a:	c9                   	leave
 a4b:	c3                   	ret

0000000000000a4c <malloc>:

void*
malloc(uint nbytes)
{
 a4c:	f3 0f 1e fa          	endbr64
 a50:	55                   	push   %rbp
 a51:	48 89 e5             	mov    %rsp,%rbp
 a54:	48 83 ec 30          	sub    $0x30,%rsp
 a58:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5b:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a5e:	48 83 c0 0f          	add    $0xf,%rax
 a62:	48 c1 e8 04          	shr    $0x4,%rax
 a66:	83 c0 01             	add    $0x1,%eax
 a69:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a6c:	48 8b 05 7d 03 00 00 	mov    0x37d(%rip),%rax        # df0 <freep>
 a73:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a77:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a7c:	75 2b                	jne    aa9 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a7e:	48 c7 45 f0 e0 0d 00 	movq   $0xde0,-0x10(%rbp)
 a85:	00 
 a86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8a:	48 89 05 5f 03 00 00 	mov    %rax,0x35f(%rip)        # df0 <freep>
 a91:	48 8b 05 58 03 00 00 	mov    0x358(%rip),%rax        # df0 <freep>
 a98:	48 89 05 41 03 00 00 	mov    %rax,0x341(%rip)        # de0 <base>
    base.s.size = 0;
 a9f:	c7 05 3f 03 00 00 00 	movl   $0x0,0x33f(%rip)        # de8 <base+0x8>
 aa6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aad:	48 8b 00             	mov    (%rax),%rax
 ab0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	8b 40 08             	mov    0x8(%rax),%eax
 abb:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 abe:	72 5f                	jb     b1f <malloc+0xd3>
      if(p->s.size == nunits)
 ac0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac4:	8b 40 08             	mov    0x8(%rax),%eax
 ac7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 aca:	75 10                	jne    adc <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad0:	48 8b 10             	mov    (%rax),%rdx
 ad3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad7:	48 89 10             	mov    %rdx,(%rax)
 ada:	eb 2e                	jmp    b0a <malloc+0xbe>
      else {
        p->s.size -= nunits;
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	8b 40 08             	mov    0x8(%rax),%eax
 ae3:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ae6:	89 c2                	mov    %eax,%edx
 ae8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aec:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af3:	8b 40 08             	mov    0x8(%rax),%eax
 af6:	89 c0                	mov    %eax,%eax
 af8:	48 c1 e0 04          	shl    $0x4,%rax
 afc:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b04:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b07:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b0e:	48 89 05 db 02 00 00 	mov    %rax,0x2db(%rip)        # df0 <freep>
      return (void*)(p + 1);
 b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b19:	48 83 c0 10          	add    $0x10,%rax
 b1d:	eb 41                	jmp    b60 <malloc+0x114>
    }
    if(p == freep)
 b1f:	48 8b 05 ca 02 00 00 	mov    0x2ca(%rip),%rax        # df0 <freep>
 b26:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b2a:	75 1c                	jne    b48 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b2f:	89 c7                	mov    %eax,%edi
 b31:	e8 ad fe ff ff       	call   9e3 <morecore>
 b36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b3a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b3f:	75 07                	jne    b48 <malloc+0xfc>
        return 0;
 b41:	b8 00 00 00 00       	mov    $0x0,%eax
 b46:	eb 18                	jmp    b60 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b54:	48 8b 00             	mov    (%rax),%rax
 b57:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b5b:	e9 54 ff ff ff       	jmp    ab4 <malloc+0x68>
  }
}
 b60:	c9                   	leave
 b61:	c3                   	ret
