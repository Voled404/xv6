
fs/echo:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 1; i < argc; i++)
  13:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  1a:	eb 4f                	jmp    6b <main+0x6b>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1f:	83 c0 01             	add    $0x1,%eax
  22:	39 45 ec             	cmp    %eax,-0x14(%rbp)
  25:	7e 09                	jle    30 <main+0x30>
  27:	48 c7 c1 66 0b 00 00 	mov    $0xb66,%rcx
  2e:	eb 07                	jmp    37 <main+0x37>
  30:	48 c7 c1 68 0b 00 00 	mov    $0xb68,%rcx
  37:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3a:	48 98                	cltq
  3c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  43:	00 
  44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  48:	48 01 d0             	add    %rdx,%rax
  4b:	48 8b 00             	mov    (%rax),%rax
  4e:	48 89 c2             	mov    %rax,%rdx
  51:	48 c7 c6 6a 0b 00 00 	mov    $0xb6a,%rsi
  58:	bf 01 00 00 00       	mov    $0x1,%edi
  5d:	b8 00 00 00 00       	mov    $0x0,%eax
  62:	e8 ea 04 00 00       	call   551 <printf>
  for(i = 1; i < argc; i++)
  67:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  6b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  6e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  71:	7c a9                	jl     1c <main+0x1c>
  exit();
  73:	e8 17 03 00 00       	call   38f <exit>

0000000000000078 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  78:	55                   	push   %rbp
  79:	48 89 e5             	mov    %rsp,%rbp
  7c:	48 83 ec 10          	sub    $0x10,%rsp
  80:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  84:	89 75 f4             	mov    %esi,-0xc(%rbp)
  87:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  8a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8e:	8b 55 f0             	mov    -0x10(%rbp),%edx
  91:	8b 45 f4             	mov    -0xc(%rbp),%eax
  94:	48 89 ce             	mov    %rcx,%rsi
  97:	48 89 f7             	mov    %rsi,%rdi
  9a:	89 d1                	mov    %edx,%ecx
  9c:	fc                   	cld
  9d:	f3 aa                	rep stos %al,%es:(%rdi)
  9f:	89 ca                	mov    %ecx,%edx
  a1:	48 89 fe             	mov    %rdi,%rsi
  a4:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  a8:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  ab:	90                   	nop
  ac:	c9                   	leave
  ad:	c3                   	ret

00000000000000ae <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  ae:	f3 0f 1e fa          	endbr64
  b2:	55                   	push   %rbp
  b3:	48 89 e5             	mov    %rsp,%rbp
  b6:	48 83 ec 20          	sub    $0x20,%rsp
  ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  be:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  ca:	90                   	nop
  cb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  cf:	48 8d 42 01          	lea    0x1(%rdx),%rax
  d3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  db:	48 8d 48 01          	lea    0x1(%rax),%rcx
  df:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  e3:	0f b6 12             	movzbl (%rdx),%edx
  e6:	88 10                	mov    %dl,(%rax)
  e8:	0f b6 00             	movzbl (%rax),%eax
  eb:	84 c0                	test   %al,%al
  ed:	75 dc                	jne    cb <strcpy+0x1d>
    ;
  return os;
  ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  f3:	c9                   	leave
  f4:	c3                   	ret

00000000000000f5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f5:	f3 0f 1e fa          	endbr64
  f9:	55                   	push   %rbp
  fa:	48 89 e5             	mov    %rsp,%rbp
  fd:	48 83 ec 10          	sub    $0x10,%rsp
 101:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 105:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 109:	eb 0a                	jmp    115 <strcmp+0x20>
    p++, q++;
 10b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 110:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 115:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 119:	0f b6 00             	movzbl (%rax),%eax
 11c:	84 c0                	test   %al,%al
 11e:	74 12                	je     132 <strcmp+0x3d>
 120:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 124:	0f b6 10             	movzbl (%rax),%edx
 127:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 12b:	0f b6 00             	movzbl (%rax),%eax
 12e:	38 c2                	cmp    %al,%dl
 130:	74 d9                	je     10b <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 132:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 136:	0f b6 00             	movzbl (%rax),%eax
 139:	0f b6 d0             	movzbl %al,%edx
 13c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 140:	0f b6 00             	movzbl (%rax),%eax
 143:	0f b6 c0             	movzbl %al,%eax
 146:	29 c2                	sub    %eax,%edx
 148:	89 d0                	mov    %edx,%eax
}
 14a:	c9                   	leave
 14b:	c3                   	ret

000000000000014c <strlen>:

uint
strlen(char *s)
{
 14c:	f3 0f 1e fa          	endbr64
 150:	55                   	push   %rbp
 151:	48 89 e5             	mov    %rsp,%rbp
 154:	48 83 ec 18          	sub    $0x18,%rsp
 158:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 15c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 163:	eb 04                	jmp    169 <strlen+0x1d>
 165:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 169:	8b 45 fc             	mov    -0x4(%rbp),%eax
 16c:	48 63 d0             	movslq %eax,%rdx
 16f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 173:	48 01 d0             	add    %rdx,%rax
 176:	0f b6 00             	movzbl (%rax),%eax
 179:	84 c0                	test   %al,%al
 17b:	75 e8                	jne    165 <strlen+0x19>
    ;
  return n;
 17d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 180:	c9                   	leave
 181:	c3                   	ret

0000000000000182 <memset>:

void*
memset(void *dst, int c, uint n)
{
 182:	f3 0f 1e fa          	endbr64
 186:	55                   	push   %rbp
 187:	48 89 e5             	mov    %rsp,%rbp
 18a:	48 83 ec 10          	sub    $0x10,%rsp
 18e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 192:	89 75 f4             	mov    %esi,-0xc(%rbp)
 195:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 198:	8b 55 f0             	mov    -0x10(%rbp),%edx
 19b:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 19e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a2:	89 ce                	mov    %ecx,%esi
 1a4:	48 89 c7             	mov    %rax,%rdi
 1a7:	e8 cc fe ff ff       	call   78 <stosb>
  return dst;
 1ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1b0:	c9                   	leave
 1b1:	c3                   	ret

00000000000001b2 <strchr>:

char*
strchr(const char *s, char c)
{
 1b2:	f3 0f 1e fa          	endbr64
 1b6:	55                   	push   %rbp
 1b7:	48 89 e5             	mov    %rsp,%rbp
 1ba:	48 83 ec 10          	sub    $0x10,%rsp
 1be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1c2:	89 f0                	mov    %esi,%eax
 1c4:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1c7:	eb 17                	jmp    1e0 <strchr+0x2e>
    if(*s == c)
 1c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1cd:	0f b6 00             	movzbl (%rax),%eax
 1d0:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1d3:	75 06                	jne    1db <strchr+0x29>
      return (char*)s;
 1d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d9:	eb 15                	jmp    1f0 <strchr+0x3e>
  for(; *s; s++)
 1db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e4:	0f b6 00             	movzbl (%rax),%eax
 1e7:	84 c0                	test   %al,%al
 1e9:	75 de                	jne    1c9 <strchr+0x17>
  return 0;
 1eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1f0:	c9                   	leave
 1f1:	c3                   	ret

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	f3 0f 1e fa          	endbr64
 1f6:	55                   	push   %rbp
 1f7:	48 89 e5             	mov    %rsp,%rbp
 1fa:	48 83 ec 20          	sub    $0x20,%rsp
 1fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 202:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 205:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 20c:	eb 48                	jmp    256 <gets+0x64>
    cc = read(0, &c, 1);
 20e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 212:	ba 01 00 00 00       	mov    $0x1,%edx
 217:	48 89 c6             	mov    %rax,%rsi
 21a:	bf 00 00 00 00       	mov    $0x0,%edi
 21f:	e8 83 01 00 00       	call   3a7 <read>
 224:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 227:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 22b:	7e 36                	jle    263 <gets+0x71>
      break;
    buf[i++] = c;
 22d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 230:	8d 50 01             	lea    0x1(%rax),%edx
 233:	89 55 fc             	mov    %edx,-0x4(%rbp)
 236:	48 63 d0             	movslq %eax,%rdx
 239:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 23d:	48 01 c2             	add    %rax,%rdx
 240:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 244:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 246:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 24a:	3c 0a                	cmp    $0xa,%al
 24c:	74 16                	je     264 <gets+0x72>
 24e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 252:	3c 0d                	cmp    $0xd,%al
 254:	74 0e                	je     264 <gets+0x72>
  for(i=0; i+1 < max; ){
 256:	8b 45 fc             	mov    -0x4(%rbp),%eax
 259:	83 c0 01             	add    $0x1,%eax
 25c:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 25f:	7f ad                	jg     20e <gets+0x1c>
 261:	eb 01                	jmp    264 <gets+0x72>
      break;
 263:	90                   	nop
      break;
  }
  buf[i] = '\0';
 264:	8b 45 fc             	mov    -0x4(%rbp),%eax
 267:	48 63 d0             	movslq %eax,%rdx
 26a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 26e:	48 01 d0             	add    %rdx,%rax
 271:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 274:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 278:	c9                   	leave
 279:	c3                   	ret

000000000000027a <stat>:

int
stat(char *n, struct stat *st)
{
 27a:	f3 0f 1e fa          	endbr64
 27e:	55                   	push   %rbp
 27f:	48 89 e5             	mov    %rsp,%rbp
 282:	48 83 ec 20          	sub    $0x20,%rsp
 286:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 28a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 292:	be 00 00 00 00       	mov    $0x0,%esi
 297:	48 89 c7             	mov    %rax,%rdi
 29a:	e8 30 01 00 00       	call   3cf <open>
 29f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 2a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2a6:	79 07                	jns    2af <stat+0x35>
    return -1;
 2a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ad:	eb 21                	jmp    2d0 <stat+0x56>
  r = fstat(fd, st);
 2af:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2b6:	48 89 d6             	mov    %rdx,%rsi
 2b9:	89 c7                	mov    %eax,%edi
 2bb:	e8 27 01 00 00       	call   3e7 <fstat>
 2c0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2c6:	89 c7                	mov    %eax,%edi
 2c8:	e8 ea 00 00 00       	call   3b7 <close>
  return r;
 2cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2d0:	c9                   	leave
 2d1:	c3                   	ret

00000000000002d2 <atoi>:

int
atoi(const char *s)
{
 2d2:	f3 0f 1e fa          	endbr64
 2d6:	55                   	push   %rbp
 2d7:	48 89 e5             	mov    %rsp,%rbp
 2da:	48 83 ec 18          	sub    $0x18,%rsp
 2de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2e9:	eb 28                	jmp    313 <atoi+0x41>
    n = n*10 + *s++ - '0';
 2eb:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2ee:	89 d0                	mov    %edx,%eax
 2f0:	c1 e0 02             	shl    $0x2,%eax
 2f3:	01 d0                	add    %edx,%eax
 2f5:	01 c0                	add    %eax,%eax
 2f7:	89 c1                	mov    %eax,%ecx
 2f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fd:	48 8d 50 01          	lea    0x1(%rax),%rdx
 301:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 305:	0f b6 00             	movzbl (%rax),%eax
 308:	0f be c0             	movsbl %al,%eax
 30b:	01 c8                	add    %ecx,%eax
 30d:	83 e8 30             	sub    $0x30,%eax
 310:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 313:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 317:	0f b6 00             	movzbl (%rax),%eax
 31a:	3c 2f                	cmp    $0x2f,%al
 31c:	7e 0b                	jle    329 <atoi+0x57>
 31e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 322:	0f b6 00             	movzbl (%rax),%eax
 325:	3c 39                	cmp    $0x39,%al
 327:	7e c2                	jle    2eb <atoi+0x19>
  return n;
 329:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 32c:	c9                   	leave
 32d:	c3                   	ret

000000000000032e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32e:	f3 0f 1e fa          	endbr64
 332:	55                   	push   %rbp
 333:	48 89 e5             	mov    %rsp,%rbp
 336:	48 83 ec 28          	sub    $0x28,%rsp
 33a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 33e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 342:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 345:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 349:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 34d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 351:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 355:	eb 1d                	jmp    374 <memmove+0x46>
    *dst++ = *src++;
 357:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 35b:	48 8d 42 01          	lea    0x1(%rdx),%rax
 35f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 367:	48 8d 48 01          	lea    0x1(%rax),%rcx
 36b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 36f:	0f b6 12             	movzbl (%rdx),%edx
 372:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 374:	8b 45 dc             	mov    -0x24(%rbp),%eax
 377:	8d 50 ff             	lea    -0x1(%rax),%edx
 37a:	89 55 dc             	mov    %edx,-0x24(%rbp)
 37d:	85 c0                	test   %eax,%eax
 37f:	7f d6                	jg     357 <memmove+0x29>
  return vdst;
 381:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 385:	c9                   	leave
 386:	c3                   	ret

0000000000000387 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 387:	b8 01 00 00 00       	mov    $0x1,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <exit>:
SYSCALL(exit)
 38f:	b8 02 00 00 00       	mov    $0x2,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <wait>:
SYSCALL(wait)
 397:	b8 03 00 00 00       	mov    $0x3,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <pipe>:
SYSCALL(pipe)
 39f:	b8 04 00 00 00       	mov    $0x4,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <read>:
SYSCALL(read)
 3a7:	b8 05 00 00 00       	mov    $0x5,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <write>:
SYSCALL(write)
 3af:	b8 10 00 00 00       	mov    $0x10,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <close>:
SYSCALL(close)
 3b7:	b8 15 00 00 00       	mov    $0x15,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <kill>:
SYSCALL(kill)
 3bf:	b8 06 00 00 00       	mov    $0x6,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <exec>:
SYSCALL(exec)
 3c7:	b8 07 00 00 00       	mov    $0x7,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <open>:
SYSCALL(open)
 3cf:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <mknod>:
SYSCALL(mknod)
 3d7:	b8 11 00 00 00       	mov    $0x11,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <unlink>:
SYSCALL(unlink)
 3df:	b8 12 00 00 00       	mov    $0x12,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <fstat>:
SYSCALL(fstat)
 3e7:	b8 08 00 00 00       	mov    $0x8,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <link>:
SYSCALL(link)
 3ef:	b8 13 00 00 00       	mov    $0x13,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <mkdir>:
SYSCALL(mkdir)
 3f7:	b8 14 00 00 00       	mov    $0x14,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <chdir>:
SYSCALL(chdir)
 3ff:	b8 09 00 00 00       	mov    $0x9,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <dup>:
SYSCALL(dup)
 407:	b8 0a 00 00 00       	mov    $0xa,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

000000000000040f <getpid>:
SYSCALL(getpid)
 40f:	b8 0b 00 00 00       	mov    $0xb,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <sbrk>:
SYSCALL(sbrk)
 417:	b8 0c 00 00 00       	mov    $0xc,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <sleep>:
SYSCALL(sleep)
 41f:	b8 0d 00 00 00       	mov    $0xd,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

0000000000000427 <uptime>:
SYSCALL(uptime)
 427:	b8 0e 00 00 00       	mov    $0xe,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

000000000000042f <getpinfo>:
SYSCALL(getpinfo)
 42f:	b8 18 00 00 00       	mov    $0x18,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

0000000000000437 <settickets>:
SYSCALL(settickets)
 437:	b8 1b 00 00 00       	mov    $0x1b,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

000000000000043f <getfavnum>:
SYSCALL(getfavnum)
 43f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret

0000000000000447 <halt>:
SYSCALL(halt)
 447:	b8 1d 00 00 00       	mov    $0x1d,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret

000000000000044f <getcount>:
SYSCALL(getcount)
 44f:	b8 1e 00 00 00       	mov    $0x1e,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret

0000000000000457 <killrandom>:
SYSCALL(killrandom)
 457:	b8 1f 00 00 00       	mov    $0x1f,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret

000000000000045f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45f:	f3 0f 1e fa          	endbr64
 463:	55                   	push   %rbp
 464:	48 89 e5             	mov    %rsp,%rbp
 467:	48 83 ec 10          	sub    $0x10,%rsp
 46b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 46e:	89 f0                	mov    %esi,%eax
 470:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 473:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 477:	8b 45 fc             	mov    -0x4(%rbp),%eax
 47a:	ba 01 00 00 00       	mov    $0x1,%edx
 47f:	48 89 ce             	mov    %rcx,%rsi
 482:	89 c7                	mov    %eax,%edi
 484:	e8 26 ff ff ff       	call   3af <write>
}
 489:	90                   	nop
 48a:	c9                   	leave
 48b:	c3                   	ret

000000000000048c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 48c:	f3 0f 1e fa          	endbr64
 490:	55                   	push   %rbp
 491:	48 89 e5             	mov    %rsp,%rbp
 494:	48 83 ec 30          	sub    $0x30,%rsp
 498:	89 7d dc             	mov    %edi,-0x24(%rbp)
 49b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 49e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4a1:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4ab:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4af:	74 17                	je     4c8 <printint+0x3c>
 4b1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4b5:	79 11                	jns    4c8 <printint+0x3c>
    neg = 1;
 4b7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4be:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c1:	f7 d8                	neg    %eax
 4c3:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4c6:	eb 06                	jmp    4ce <printint+0x42>
  } else {
    x = xx;
 4c8:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4cb:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4d5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4db:	ba 00 00 00 00       	mov    $0x0,%edx
 4e0:	f7 f6                	div    %esi
 4e2:	89 d1                	mov    %edx,%ecx
 4e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e7:	8d 50 01             	lea    0x1(%rax),%edx
 4ea:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ed:	89 ca                	mov    %ecx,%edx
 4ef:	0f b6 92 b0 0d 00 00 	movzbl 0xdb0(%rdx),%edx
 4f6:	48 98                	cltq
 4f8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4fc:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4ff:	8b 45 f4             	mov    -0xc(%rbp),%eax
 502:	ba 00 00 00 00       	mov    $0x0,%edx
 507:	f7 f7                	div    %edi
 509:	89 45 f4             	mov    %eax,-0xc(%rbp)
 50c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 510:	75 c3                	jne    4d5 <printint+0x49>
  if(neg)
 512:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 516:	74 2b                	je     543 <printint+0xb7>
    buf[i++] = '-';
 518:	8b 45 fc             	mov    -0x4(%rbp),%eax
 51b:	8d 50 01             	lea    0x1(%rax),%edx
 51e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 521:	48 98                	cltq
 523:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 528:	eb 19                	jmp    543 <printint+0xb7>
    putc(fd, buf[i]);
 52a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 52d:	48 98                	cltq
 52f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 534:	0f be d0             	movsbl %al,%edx
 537:	8b 45 dc             	mov    -0x24(%rbp),%eax
 53a:	89 d6                	mov    %edx,%esi
 53c:	89 c7                	mov    %eax,%edi
 53e:	e8 1c ff ff ff       	call   45f <putc>
  while(--i >= 0)
 543:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 547:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 54b:	79 dd                	jns    52a <printint+0x9e>
}
 54d:	90                   	nop
 54e:	90                   	nop
 54f:	c9                   	leave
 550:	c3                   	ret

0000000000000551 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 551:	f3 0f 1e fa          	endbr64
 555:	55                   	push   %rbp
 556:	48 89 e5             	mov    %rsp,%rbp
 559:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 560:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 566:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 56d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 574:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 57b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 582:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 589:	84 c0                	test   %al,%al
 58b:	74 20                	je     5ad <printf+0x5c>
 58d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 591:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 595:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 599:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 59d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5a1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5a5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5ad:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5b4:	00 00 00 
 5b7:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5be:	00 00 00 
 5c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5c5:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5cc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5d3:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5da:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5e1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5e4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5eb:	00 00 00 
 5ee:	e9 a8 02 00 00       	jmp    89b <printf+0x34a>
    c = fmt[i] & 0xff;
 5f3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f9:	48 63 d0             	movslq %eax,%rdx
 5fc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 603:	48 01 d0             	add    %rdx,%rax
 606:	0f b6 00             	movzbl (%rax),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	25 ff 00 00 00       	and    $0xff,%eax
 611:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 617:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 61e:	75 35                	jne    655 <printf+0x104>
      if(c == '%'){
 620:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 627:	75 0f                	jne    638 <printf+0xe7>
        state = '%';
 629:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 630:	00 00 00 
 633:	e9 5c 02 00 00       	jmp    894 <printf+0x343>
      } else {
        putc(fd, c);
 638:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 63e:	0f be d0             	movsbl %al,%edx
 641:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 647:	89 d6                	mov    %edx,%esi
 649:	89 c7                	mov    %eax,%edi
 64b:	e8 0f fe ff ff       	call   45f <putc>
 650:	e9 3f 02 00 00       	jmp    894 <printf+0x343>
      }
    } else if(state == '%'){
 655:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 65c:	0f 85 32 02 00 00    	jne    894 <printf+0x343>
      if(c == 'd'){
 662:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 669:	75 5e                	jne    6c9 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 66b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 671:	83 f8 2f             	cmp    $0x2f,%eax
 674:	77 23                	ja     699 <printf+0x148>
 676:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 67d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 683:	89 d2                	mov    %edx,%edx
 685:	48 01 d0             	add    %rdx,%rax
 688:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68e:	83 c2 08             	add    $0x8,%edx
 691:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 697:	eb 12                	jmp    6ab <printf+0x15a>
 699:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ab:	8b 30                	mov    (%rax),%esi
 6ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b3:	b9 01 00 00 00       	mov    $0x1,%ecx
 6b8:	ba 0a 00 00 00       	mov    $0xa,%edx
 6bd:	89 c7                	mov    %eax,%edi
 6bf:	e8 c8 fd ff ff       	call   48c <printint>
 6c4:	e9 c1 01 00 00       	jmp    88a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c9:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6d0:	74 09                	je     6db <printf+0x18a>
 6d2:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d9:	75 5e                	jne    739 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e1:	83 f8 2f             	cmp    $0x2f,%eax
 6e4:	77 23                	ja     709 <printf+0x1b8>
 6e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f3:	89 d2                	mov    %edx,%edx
 6f5:	48 01 d0             	add    %rdx,%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	83 c2 08             	add    $0x8,%edx
 701:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 707:	eb 12                	jmp    71b <printf+0x1ca>
 709:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 710:	48 8d 50 08          	lea    0x8(%rax),%rdx
 714:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 71b:	8b 30                	mov    (%rax),%esi
 71d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 723:	b9 00 00 00 00       	mov    $0x0,%ecx
 728:	ba 10 00 00 00       	mov    $0x10,%edx
 72d:	89 c7                	mov    %eax,%edi
 72f:	e8 58 fd ff ff       	call   48c <printint>
 734:	e9 51 01 00 00       	jmp    88a <printf+0x339>
      } else if(c == 's'){
 739:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 740:	0f 85 98 00 00 00    	jne    7de <printf+0x28d>
        s = va_arg(ap, char*);
 746:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74c:	83 f8 2f             	cmp    $0x2f,%eax
 74f:	77 23                	ja     774 <printf+0x223>
 751:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 758:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75e:	89 d2                	mov    %edx,%edx
 760:	48 01 d0             	add    %rdx,%rax
 763:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 769:	83 c2 08             	add    $0x8,%edx
 76c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 772:	eb 12                	jmp    786 <printf+0x235>
 774:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 77f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 786:	48 8b 00             	mov    (%rax),%rax
 789:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 790:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 797:	00 
 798:	75 31                	jne    7cb <printf+0x27a>
          s = "(null)";
 79a:	48 c7 85 48 ff ff ff 	movq   $0xb6f,-0xb8(%rbp)
 7a1:	6f 0b 00 00 
        while(*s != 0){
 7a5:	eb 24                	jmp    7cb <printf+0x27a>
          putc(fd, *s);
 7a7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ae:	0f b6 00             	movzbl (%rax),%eax
 7b1:	0f be d0             	movsbl %al,%edx
 7b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ba:	89 d6                	mov    %edx,%esi
 7bc:	89 c7                	mov    %eax,%edi
 7be:	e8 9c fc ff ff       	call   45f <putc>
          s++;
 7c3:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7ca:	01 
        while(*s != 0){
 7cb:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7d2:	0f b6 00             	movzbl (%rax),%eax
 7d5:	84 c0                	test   %al,%al
 7d7:	75 ce                	jne    7a7 <printf+0x256>
 7d9:	e9 ac 00 00 00       	jmp    88a <printf+0x339>
        }
      } else if(c == 'c'){
 7de:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7e5:	75 56                	jne    83d <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7e7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ed:	83 f8 2f             	cmp    $0x2f,%eax
 7f0:	77 23                	ja     815 <printf+0x2c4>
 7f2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ff:	89 d2                	mov    %edx,%edx
 801:	48 01 d0             	add    %rdx,%rax
 804:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 80a:	83 c2 08             	add    $0x8,%edx
 80d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 813:	eb 12                	jmp    827 <printf+0x2d6>
 815:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 81c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 820:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 827:	8b 00                	mov    (%rax),%eax
 829:	0f be d0             	movsbl %al,%edx
 82c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 832:	89 d6                	mov    %edx,%esi
 834:	89 c7                	mov    %eax,%edi
 836:	e8 24 fc ff ff       	call   45f <putc>
 83b:	eb 4d                	jmp    88a <printf+0x339>
      } else if(c == '%'){
 83d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 844:	75 1a                	jne    860 <printf+0x30f>
        putc(fd, c);
 846:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 84c:	0f be d0             	movsbl %al,%edx
 84f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 855:	89 d6                	mov    %edx,%esi
 857:	89 c7                	mov    %eax,%edi
 859:	e8 01 fc ff ff       	call   45f <putc>
 85e:	eb 2a                	jmp    88a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 860:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 866:	be 25 00 00 00       	mov    $0x25,%esi
 86b:	89 c7                	mov    %eax,%edi
 86d:	e8 ed fb ff ff       	call   45f <putc>
        putc(fd, c);
 872:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 878:	0f be d0             	movsbl %al,%edx
 87b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 881:	89 d6                	mov    %edx,%esi
 883:	89 c7                	mov    %eax,%edi
 885:	e8 d5 fb ff ff       	call   45f <putc>
      }
      state = 0;
 88a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 891:	00 00 00 
  for(i = 0; fmt[i]; i++){
 894:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 89b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8a1:	48 63 d0             	movslq %eax,%rdx
 8a4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8ab:	48 01 d0             	add    %rdx,%rax
 8ae:	0f b6 00             	movzbl (%rax),%eax
 8b1:	84 c0                	test   %al,%al
 8b3:	0f 85 3a fd ff ff    	jne    5f3 <printf+0xa2>
    }
  }
}
 8b9:	90                   	nop
 8ba:	90                   	nop
 8bb:	c9                   	leave
 8bc:	c3                   	ret

00000000000008bd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8bd:	f3 0f 1e fa          	endbr64
 8c1:	55                   	push   %rbp
 8c2:	48 89 e5             	mov    %rsp,%rbp
 8c5:	48 83 ec 18          	sub    $0x18,%rsp
 8c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8d1:	48 83 e8 10          	sub    $0x10,%rax
 8d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d9:	48 8b 05 00 05 00 00 	mov    0x500(%rip),%rax        # de0 <freep>
 8e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8e4:	eb 2f                	jmp    915 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ea:	48 8b 00             	mov    (%rax),%rax
 8ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f1:	72 17                	jb     90a <free+0x4d>
 8f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8fb:	72 2f                	jb     92c <free+0x6f>
 8fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 901:	48 8b 00             	mov    (%rax),%rax
 904:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 908:	72 22                	jb     92c <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90e:	48 8b 00             	mov    (%rax),%rax
 911:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 915:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 919:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 91d:	73 c7                	jae    8e6 <free+0x29>
 91f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 923:	48 8b 00             	mov    (%rax),%rax
 926:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 92a:	73 ba                	jae    8e6 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 92c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 930:	8b 40 08             	mov    0x8(%rax),%eax
 933:	89 c0                	mov    %eax,%eax
 935:	48 c1 e0 04          	shl    $0x4,%rax
 939:	48 89 c2             	mov    %rax,%rdx
 93c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 940:	48 01 c2             	add    %rax,%rdx
 943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 947:	48 8b 00             	mov    (%rax),%rax
 94a:	48 39 c2             	cmp    %rax,%rdx
 94d:	75 2d                	jne    97c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 94f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 953:	8b 50 08             	mov    0x8(%rax),%edx
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 8b 00             	mov    (%rax),%rax
 95d:	8b 40 08             	mov    0x8(%rax),%eax
 960:	01 c2                	add    %eax,%edx
 962:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 966:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 8b 00             	mov    (%rax),%rax
 970:	48 8b 10             	mov    (%rax),%rdx
 973:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 977:	48 89 10             	mov    %rdx,(%rax)
 97a:	eb 0e                	jmp    98a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 97c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 980:	48 8b 10             	mov    (%rax),%rdx
 983:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 987:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 98a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98e:	8b 40 08             	mov    0x8(%rax),%eax
 991:	89 c0                	mov    %eax,%eax
 993:	48 c1 e0 04          	shl    $0x4,%rax
 997:	48 89 c2             	mov    %rax,%rdx
 99a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99e:	48 01 d0             	add    %rdx,%rax
 9a1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9a5:	75 27                	jne    9ce <free+0x111>
    p->s.size += bp->s.size;
 9a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ab:	8b 50 08             	mov    0x8(%rax),%edx
 9ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b2:	8b 40 08             	mov    0x8(%rax),%eax
 9b5:	01 c2                	add    %eax,%edx
 9b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bb:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c2:	48 8b 10             	mov    (%rax),%rdx
 9c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c9:	48 89 10             	mov    %rdx,(%rax)
 9cc:	eb 0b                	jmp    9d9 <free+0x11c>
  } else
    p->s.ptr = bp;
 9ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9d6:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 89 05 fc 03 00 00 	mov    %rax,0x3fc(%rip)        # de0 <freep>
}
 9e4:	90                   	nop
 9e5:	c9                   	leave
 9e6:	c3                   	ret

00000000000009e7 <morecore>:

static Header*
morecore(uint nu)
{
 9e7:	f3 0f 1e fa          	endbr64
 9eb:	55                   	push   %rbp
 9ec:	48 89 e5             	mov    %rsp,%rbp
 9ef:	48 83 ec 20          	sub    $0x20,%rsp
 9f3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9f6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9fd:	77 07                	ja     a06 <morecore+0x1f>
    nu = 4096;
 9ff:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a06:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a09:	c1 e0 04             	shl    $0x4,%eax
 a0c:	89 c7                	mov    %eax,%edi
 a0e:	e8 04 fa ff ff       	call   417 <sbrk>
 a13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a17:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a1c:	75 07                	jne    a25 <morecore+0x3e>
    return 0;
 a1e:	b8 00 00 00 00       	mov    $0x0,%eax
 a23:	eb 29                	jmp    a4e <morecore+0x67>
  hp = (Header*)p;
 a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a31:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a34:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3b:	48 83 c0 10          	add    $0x10,%rax
 a3f:	48 89 c7             	mov    %rax,%rdi
 a42:	e8 76 fe ff ff       	call   8bd <free>
  return freep;
 a47:	48 8b 05 92 03 00 00 	mov    0x392(%rip),%rax        # de0 <freep>
}
 a4e:	c9                   	leave
 a4f:	c3                   	ret

0000000000000a50 <malloc>:

void*
malloc(uint nbytes)
{
 a50:	f3 0f 1e fa          	endbr64
 a54:	55                   	push   %rbp
 a55:	48 89 e5             	mov    %rsp,%rbp
 a58:	48 83 ec 30          	sub    $0x30,%rsp
 a5c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a62:	48 83 c0 0f          	add    $0xf,%rax
 a66:	48 c1 e8 04          	shr    $0x4,%rax
 a6a:	83 c0 01             	add    $0x1,%eax
 a6d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a70:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # de0 <freep>
 a77:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a7b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a80:	75 2b                	jne    aad <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a82:	48 c7 45 f0 d0 0d 00 	movq   $0xdd0,-0x10(%rbp)
 a89:	00 
 a8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8e:	48 89 05 4b 03 00 00 	mov    %rax,0x34b(%rip)        # de0 <freep>
 a95:	48 8b 05 44 03 00 00 	mov    0x344(%rip),%rax        # de0 <freep>
 a9c:	48 89 05 2d 03 00 00 	mov    %rax,0x32d(%rip)        # dd0 <base>
    base.s.size = 0;
 aa3:	c7 05 2b 03 00 00 00 	movl   $0x0,0x32b(%rip)        # dd8 <base+0x8>
 aaa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab1:	48 8b 00             	mov    (%rax),%rax
 ab4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abc:	8b 40 08             	mov    0x8(%rax),%eax
 abf:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ac2:	72 5f                	jb     b23 <malloc+0xd3>
      if(p->s.size == nunits)
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	8b 40 08             	mov    0x8(%rax),%eax
 acb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ace:	75 10                	jne    ae0 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad4:	48 8b 10             	mov    (%rax),%rdx
 ad7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 adb:	48 89 10             	mov    %rdx,(%rax)
 ade:	eb 2e                	jmp    b0e <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	8b 40 08             	mov    0x8(%rax),%eax
 ae7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aea:	89 c2                	mov    %eax,%edx
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 af3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af7:	8b 40 08             	mov    0x8(%rax),%eax
 afa:	89 c0                	mov    %eax,%eax
 afc:	48 c1 e0 04          	shl    $0x4,%rax
 b00:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b0b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b12:	48 89 05 c7 02 00 00 	mov    %rax,0x2c7(%rip)        # de0 <freep>
      return (void*)(p + 1);
 b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1d:	48 83 c0 10          	add    $0x10,%rax
 b21:	eb 41                	jmp    b64 <malloc+0x114>
    }
    if(p == freep)
 b23:	48 8b 05 b6 02 00 00 	mov    0x2b6(%rip),%rax        # de0 <freep>
 b2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b2e:	75 1c                	jne    b4c <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b30:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b33:	89 c7                	mov    %eax,%edi
 b35:	e8 ad fe ff ff       	call   9e7 <morecore>
 b3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b3e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b43:	75 07                	jne    b4c <malloc+0xfc>
        return 0;
 b45:	b8 00 00 00 00       	mov    $0x0,%eax
 b4a:	eb 18                	jmp    b64 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b58:	48 8b 00             	mov    (%rax),%rax
 b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b5f:	e9 54 ff ff ff       	jmp    ab8 <malloc+0x68>
  }
}
 b64:	c9                   	leave
 b65:	c3                   	ret
