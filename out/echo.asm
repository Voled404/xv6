
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
  27:	48 c7 c1 4e 0b 00 00 	mov    $0xb4e,%rcx
  2e:	eb 07                	jmp    37 <main+0x37>
  30:	48 c7 c1 50 0b 00 00 	mov    $0xb50,%rcx
  37:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3a:	48 98                	cltq
  3c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  43:	00 
  44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  48:	48 01 d0             	add    %rdx,%rax
  4b:	48 8b 00             	mov    (%rax),%rax
  4e:	48 89 c2             	mov    %rax,%rdx
  51:	48 c7 c6 52 0b 00 00 	mov    $0xb52,%rsi
  58:	bf 01 00 00 00       	mov    $0x1,%edi
  5d:	b8 00 00 00 00       	mov    $0x0,%eax
  62:	e8 d2 04 00 00       	call   539 <printf>
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

0000000000000447 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 447:	f3 0f 1e fa          	endbr64
 44b:	55                   	push   %rbp
 44c:	48 89 e5             	mov    %rsp,%rbp
 44f:	48 83 ec 10          	sub    $0x10,%rsp
 453:	89 7d fc             	mov    %edi,-0x4(%rbp)
 456:	89 f0                	mov    %esi,%eax
 458:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 45b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 45f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 462:	ba 01 00 00 00       	mov    $0x1,%edx
 467:	48 89 ce             	mov    %rcx,%rsi
 46a:	89 c7                	mov    %eax,%edi
 46c:	e8 3e ff ff ff       	call   3af <write>
}
 471:	90                   	nop
 472:	c9                   	leave
 473:	c3                   	ret

0000000000000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 474:	f3 0f 1e fa          	endbr64
 478:	55                   	push   %rbp
 479:	48 89 e5             	mov    %rsp,%rbp
 47c:	48 83 ec 30          	sub    $0x30,%rsp
 480:	89 7d dc             	mov    %edi,-0x24(%rbp)
 483:	89 75 d8             	mov    %esi,-0x28(%rbp)
 486:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 489:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 48c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 493:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 497:	74 17                	je     4b0 <printint+0x3c>
 499:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 49d:	79 11                	jns    4b0 <printint+0x3c>
    neg = 1;
 49f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4a6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4a9:	f7 d8                	neg    %eax
 4ab:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ae:	eb 06                	jmp    4b6 <printint+0x42>
  } else {
    x = xx;
 4b0:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4bd:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4c0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4c3:	ba 00 00 00 00       	mov    $0x0,%edx
 4c8:	f7 f6                	div    %esi
 4ca:	89 d1                	mov    %edx,%ecx
 4cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4cf:	8d 50 01             	lea    0x1(%rax),%edx
 4d2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4d5:	89 ca                	mov    %ecx,%edx
 4d7:	0f b6 92 a0 0d 00 00 	movzbl 0xda0(%rdx),%edx
 4de:	48 98                	cltq
 4e0:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4e4:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4ea:	ba 00 00 00 00       	mov    $0x0,%edx
 4ef:	f7 f7                	div    %edi
 4f1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4f8:	75 c3                	jne    4bd <printint+0x49>
  if(neg)
 4fa:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4fe:	74 2b                	je     52b <printint+0xb7>
    buf[i++] = '-';
 500:	8b 45 fc             	mov    -0x4(%rbp),%eax
 503:	8d 50 01             	lea    0x1(%rax),%edx
 506:	89 55 fc             	mov    %edx,-0x4(%rbp)
 509:	48 98                	cltq
 50b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 510:	eb 19                	jmp    52b <printint+0xb7>
    putc(fd, buf[i]);
 512:	8b 45 fc             	mov    -0x4(%rbp),%eax
 515:	48 98                	cltq
 517:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 51c:	0f be d0             	movsbl %al,%edx
 51f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 522:	89 d6                	mov    %edx,%esi
 524:	89 c7                	mov    %eax,%edi
 526:	e8 1c ff ff ff       	call   447 <putc>
  while(--i >= 0)
 52b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 52f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 533:	79 dd                	jns    512 <printint+0x9e>
}
 535:	90                   	nop
 536:	90                   	nop
 537:	c9                   	leave
 538:	c3                   	ret

0000000000000539 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 539:	f3 0f 1e fa          	endbr64
 53d:	55                   	push   %rbp
 53e:	48 89 e5             	mov    %rsp,%rbp
 541:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 548:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 54e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 555:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 55c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 563:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 56a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 571:	84 c0                	test   %al,%al
 573:	74 20                	je     595 <printf+0x5c>
 575:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 579:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 57d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 581:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 585:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 589:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 58d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 591:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 595:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 59c:	00 00 00 
 59f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5a6:	00 00 00 
 5a9:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5ad:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5b4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5bb:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5c2:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5c9:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5cc:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5d3:	00 00 00 
 5d6:	e9 a8 02 00 00       	jmp    883 <printf+0x34a>
    c = fmt[i] & 0xff;
 5db:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5e1:	48 63 d0             	movslq %eax,%rdx
 5e4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5eb:	48 01 d0             	add    %rdx,%rax
 5ee:	0f b6 00             	movzbl (%rax),%eax
 5f1:	0f be c0             	movsbl %al,%eax
 5f4:	25 ff 00 00 00       	and    $0xff,%eax
 5f9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5ff:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 606:	75 35                	jne    63d <printf+0x104>
      if(c == '%'){
 608:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 60f:	75 0f                	jne    620 <printf+0xe7>
        state = '%';
 611:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 618:	00 00 00 
 61b:	e9 5c 02 00 00       	jmp    87c <printf+0x343>
      } else {
        putc(fd, c);
 620:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 626:	0f be d0             	movsbl %al,%edx
 629:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 62f:	89 d6                	mov    %edx,%esi
 631:	89 c7                	mov    %eax,%edi
 633:	e8 0f fe ff ff       	call   447 <putc>
 638:	e9 3f 02 00 00       	jmp    87c <printf+0x343>
      }
    } else if(state == '%'){
 63d:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 644:	0f 85 32 02 00 00    	jne    87c <printf+0x343>
      if(c == 'd'){
 64a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 651:	75 5e                	jne    6b1 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 653:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 659:	83 f8 2f             	cmp    $0x2f,%eax
 65c:	77 23                	ja     681 <printf+0x148>
 65e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 665:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 66b:	89 d2                	mov    %edx,%edx
 66d:	48 01 d0             	add    %rdx,%rax
 670:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 676:	83 c2 08             	add    $0x8,%edx
 679:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 67f:	eb 12                	jmp    693 <printf+0x15a>
 681:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 688:	48 8d 50 08          	lea    0x8(%rax),%rdx
 68c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 693:	8b 30                	mov    (%rax),%esi
 695:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 69b:	b9 01 00 00 00       	mov    $0x1,%ecx
 6a0:	ba 0a 00 00 00       	mov    $0xa,%edx
 6a5:	89 c7                	mov    %eax,%edi
 6a7:	e8 c8 fd ff ff       	call   474 <printint>
 6ac:	e9 c1 01 00 00       	jmp    872 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6b1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6b8:	74 09                	je     6c3 <printf+0x18a>
 6ba:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6c1:	75 5e                	jne    721 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6c3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6c9:	83 f8 2f             	cmp    $0x2f,%eax
 6cc:	77 23                	ja     6f1 <printf+0x1b8>
 6ce:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6d5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6db:	89 d2                	mov    %edx,%edx
 6dd:	48 01 d0             	add    %rdx,%rax
 6e0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6e6:	83 c2 08             	add    $0x8,%edx
 6e9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6ef:	eb 12                	jmp    703 <printf+0x1ca>
 6f1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6f8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6fc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 703:	8b 30                	mov    (%rax),%esi
 705:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 70b:	b9 00 00 00 00       	mov    $0x0,%ecx
 710:	ba 10 00 00 00       	mov    $0x10,%edx
 715:	89 c7                	mov    %eax,%edi
 717:	e8 58 fd ff ff       	call   474 <printint>
 71c:	e9 51 01 00 00       	jmp    872 <printf+0x339>
      } else if(c == 's'){
 721:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 728:	0f 85 98 00 00 00    	jne    7c6 <printf+0x28d>
        s = va_arg(ap, char*);
 72e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 734:	83 f8 2f             	cmp    $0x2f,%eax
 737:	77 23                	ja     75c <printf+0x223>
 739:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 740:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 746:	89 d2                	mov    %edx,%edx
 748:	48 01 d0             	add    %rdx,%rax
 74b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 751:	83 c2 08             	add    $0x8,%edx
 754:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 75a:	eb 12                	jmp    76e <printf+0x235>
 75c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 763:	48 8d 50 08          	lea    0x8(%rax),%rdx
 767:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 76e:	48 8b 00             	mov    (%rax),%rax
 771:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 778:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 77f:	00 
 780:	75 31                	jne    7b3 <printf+0x27a>
          s = "(null)";
 782:	48 c7 85 48 ff ff ff 	movq   $0xb57,-0xb8(%rbp)
 789:	57 0b 00 00 
        while(*s != 0){
 78d:	eb 24                	jmp    7b3 <printf+0x27a>
          putc(fd, *s);
 78f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 796:	0f b6 00             	movzbl (%rax),%eax
 799:	0f be d0             	movsbl %al,%edx
 79c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7a2:	89 d6                	mov    %edx,%esi
 7a4:	89 c7                	mov    %eax,%edi
 7a6:	e8 9c fc ff ff       	call   447 <putc>
          s++;
 7ab:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7b2:	01 
        while(*s != 0){
 7b3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ba:	0f b6 00             	movzbl (%rax),%eax
 7bd:	84 c0                	test   %al,%al
 7bf:	75 ce                	jne    78f <printf+0x256>
 7c1:	e9 ac 00 00 00       	jmp    872 <printf+0x339>
        }
      } else if(c == 'c'){
 7c6:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7cd:	75 56                	jne    825 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7cf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7d5:	83 f8 2f             	cmp    $0x2f,%eax
 7d8:	77 23                	ja     7fd <printf+0x2c4>
 7da:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e7:	89 d2                	mov    %edx,%edx
 7e9:	48 01 d0             	add    %rdx,%rax
 7ec:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f2:	83 c2 08             	add    $0x8,%edx
 7f5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7fb:	eb 12                	jmp    80f <printf+0x2d6>
 7fd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 804:	48 8d 50 08          	lea    0x8(%rax),%rdx
 808:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 80f:	8b 00                	mov    (%rax),%eax
 811:	0f be d0             	movsbl %al,%edx
 814:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 81a:	89 d6                	mov    %edx,%esi
 81c:	89 c7                	mov    %eax,%edi
 81e:	e8 24 fc ff ff       	call   447 <putc>
 823:	eb 4d                	jmp    872 <printf+0x339>
      } else if(c == '%'){
 825:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 82c:	75 1a                	jne    848 <printf+0x30f>
        putc(fd, c);
 82e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 834:	0f be d0             	movsbl %al,%edx
 837:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 83d:	89 d6                	mov    %edx,%esi
 83f:	89 c7                	mov    %eax,%edi
 841:	e8 01 fc ff ff       	call   447 <putc>
 846:	eb 2a                	jmp    872 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 848:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 84e:	be 25 00 00 00       	mov    $0x25,%esi
 853:	89 c7                	mov    %eax,%edi
 855:	e8 ed fb ff ff       	call   447 <putc>
        putc(fd, c);
 85a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 860:	0f be d0             	movsbl %al,%edx
 863:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 869:	89 d6                	mov    %edx,%esi
 86b:	89 c7                	mov    %eax,%edi
 86d:	e8 d5 fb ff ff       	call   447 <putc>
      }
      state = 0;
 872:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 879:	00 00 00 
  for(i = 0; fmt[i]; i++){
 87c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 883:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 889:	48 63 d0             	movslq %eax,%rdx
 88c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 893:	48 01 d0             	add    %rdx,%rax
 896:	0f b6 00             	movzbl (%rax),%eax
 899:	84 c0                	test   %al,%al
 89b:	0f 85 3a fd ff ff    	jne    5db <printf+0xa2>
    }
  }
}
 8a1:	90                   	nop
 8a2:	90                   	nop
 8a3:	c9                   	leave
 8a4:	c3                   	ret

00000000000008a5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a5:	f3 0f 1e fa          	endbr64
 8a9:	55                   	push   %rbp
 8aa:	48 89 e5             	mov    %rsp,%rbp
 8ad:	48 83 ec 18          	sub    $0x18,%rsp
 8b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8b9:	48 83 e8 10          	sub    $0x10,%rax
 8bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c1:	48 8b 05 08 05 00 00 	mov    0x508(%rip),%rax        # dd0 <freep>
 8c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8cc:	eb 2f                	jmp    8fd <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d2:	48 8b 00             	mov    (%rax),%rax
 8d5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d9:	72 17                	jb     8f2 <free+0x4d>
 8db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8df:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e3:	72 2f                	jb     914 <free+0x6f>
 8e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e9:	48 8b 00             	mov    (%rax),%rax
 8ec:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8f0:	72 22                	jb     914 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f6:	48 8b 00             	mov    (%rax),%rax
 8f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 901:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 905:	73 c7                	jae    8ce <free+0x29>
 907:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90b:	48 8b 00             	mov    (%rax),%rax
 90e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 912:	73 ba                	jae    8ce <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 914:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 918:	8b 40 08             	mov    0x8(%rax),%eax
 91b:	89 c0                	mov    %eax,%eax
 91d:	48 c1 e0 04          	shl    $0x4,%rax
 921:	48 89 c2             	mov    %rax,%rdx
 924:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 928:	48 01 c2             	add    %rax,%rdx
 92b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92f:	48 8b 00             	mov    (%rax),%rax
 932:	48 39 c2             	cmp    %rax,%rdx
 935:	75 2d                	jne    964 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 937:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93b:	8b 50 08             	mov    0x8(%rax),%edx
 93e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 942:	48 8b 00             	mov    (%rax),%rax
 945:	8b 40 08             	mov    0x8(%rax),%eax
 948:	01 c2                	add    %eax,%edx
 94a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 951:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 955:	48 8b 00             	mov    (%rax),%rax
 958:	48 8b 10             	mov    (%rax),%rdx
 95b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95f:	48 89 10             	mov    %rdx,(%rax)
 962:	eb 0e                	jmp    972 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 964:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 968:	48 8b 10             	mov    (%rax),%rdx
 96b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 972:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 976:	8b 40 08             	mov    0x8(%rax),%eax
 979:	89 c0                	mov    %eax,%eax
 97b:	48 c1 e0 04          	shl    $0x4,%rax
 97f:	48 89 c2             	mov    %rax,%rdx
 982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 986:	48 01 d0             	add    %rdx,%rax
 989:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 98d:	75 27                	jne    9b6 <free+0x111>
    p->s.size += bp->s.size;
 98f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 993:	8b 50 08             	mov    0x8(%rax),%edx
 996:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99a:	8b 40 08             	mov    0x8(%rax),%eax
 99d:	01 c2                	add    %eax,%edx
 99f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9aa:	48 8b 10             	mov    (%rax),%rdx
 9ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b1:	48 89 10             	mov    %rdx,(%rax)
 9b4:	eb 0b                	jmp    9c1 <free+0x11c>
  } else
    p->s.ptr = bp;
 9b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9be:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c5:	48 89 05 04 04 00 00 	mov    %rax,0x404(%rip)        # dd0 <freep>
}
 9cc:	90                   	nop
 9cd:	c9                   	leave
 9ce:	c3                   	ret

00000000000009cf <morecore>:

static Header*
morecore(uint nu)
{
 9cf:	f3 0f 1e fa          	endbr64
 9d3:	55                   	push   %rbp
 9d4:	48 89 e5             	mov    %rsp,%rbp
 9d7:	48 83 ec 20          	sub    $0x20,%rsp
 9db:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9de:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9e5:	77 07                	ja     9ee <morecore+0x1f>
    nu = 4096;
 9e7:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9f1:	c1 e0 04             	shl    $0x4,%eax
 9f4:	89 c7                	mov    %eax,%edi
 9f6:	e8 1c fa ff ff       	call   417 <sbrk>
 9fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9ff:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a04:	75 07                	jne    a0d <morecore+0x3e>
    return 0;
 a06:	b8 00 00 00 00       	mov    $0x0,%eax
 a0b:	eb 29                	jmp    a36 <morecore+0x67>
  hp = (Header*)p;
 a0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a11:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a19:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a1c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a23:	48 83 c0 10          	add    $0x10,%rax
 a27:	48 89 c7             	mov    %rax,%rdi
 a2a:	e8 76 fe ff ff       	call   8a5 <free>
  return freep;
 a2f:	48 8b 05 9a 03 00 00 	mov    0x39a(%rip),%rax        # dd0 <freep>
}
 a36:	c9                   	leave
 a37:	c3                   	ret

0000000000000a38 <malloc>:

void*
malloc(uint nbytes)
{
 a38:	f3 0f 1e fa          	endbr64
 a3c:	55                   	push   %rbp
 a3d:	48 89 e5             	mov    %rsp,%rbp
 a40:	48 83 ec 30          	sub    $0x30,%rsp
 a44:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a47:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a4a:	48 83 c0 0f          	add    $0xf,%rax
 a4e:	48 c1 e8 04          	shr    $0x4,%rax
 a52:	83 c0 01             	add    $0x1,%eax
 a55:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a58:	48 8b 05 71 03 00 00 	mov    0x371(%rip),%rax        # dd0 <freep>
 a5f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a63:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a68:	75 2b                	jne    a95 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a6a:	48 c7 45 f0 c0 0d 00 	movq   $0xdc0,-0x10(%rbp)
 a71:	00 
 a72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a76:	48 89 05 53 03 00 00 	mov    %rax,0x353(%rip)        # dd0 <freep>
 a7d:	48 8b 05 4c 03 00 00 	mov    0x34c(%rip),%rax        # dd0 <freep>
 a84:	48 89 05 35 03 00 00 	mov    %rax,0x335(%rip)        # dc0 <base>
    base.s.size = 0;
 a8b:	c7 05 33 03 00 00 00 	movl   $0x0,0x333(%rip)        # dc8 <base+0x8>
 a92:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a99:	48 8b 00             	mov    (%rax),%rax
 a9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa4:	8b 40 08             	mov    0x8(%rax),%eax
 aa7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aaa:	72 5f                	jb     b0b <malloc+0xd3>
      if(p->s.size == nunits)
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	8b 40 08             	mov    0x8(%rax),%eax
 ab3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ab6:	75 10                	jne    ac8 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abc:	48 8b 10             	mov    (%rax),%rdx
 abf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac3:	48 89 10             	mov    %rdx,(%rax)
 ac6:	eb 2e                	jmp    af6 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ac8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acc:	8b 40 08             	mov    0x8(%rax),%eax
 acf:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ad2:	89 c2                	mov    %eax,%edx
 ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad8:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 adb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adf:	8b 40 08             	mov    0x8(%rax),%eax
 ae2:	89 c0                	mov    %eax,%eax
 ae4:	48 c1 e0 04          	shl    $0x4,%rax
 ae8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 af3:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 af6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 afa:	48 89 05 cf 02 00 00 	mov    %rax,0x2cf(%rip)        # dd0 <freep>
      return (void*)(p + 1);
 b01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b05:	48 83 c0 10          	add    $0x10,%rax
 b09:	eb 41                	jmp    b4c <malloc+0x114>
    }
    if(p == freep)
 b0b:	48 8b 05 be 02 00 00 	mov    0x2be(%rip),%rax        # dd0 <freep>
 b12:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b16:	75 1c                	jne    b34 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b18:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b1b:	89 c7                	mov    %eax,%edi
 b1d:	e8 ad fe ff ff       	call   9cf <morecore>
 b22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b26:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b2b:	75 07                	jne    b34 <malloc+0xfc>
        return 0;
 b2d:	b8 00 00 00 00       	mov    $0x0,%eax
 b32:	eb 18                	jmp    b4c <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b38:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b40:	48 8b 00             	mov    (%rax),%rax
 b43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b47:	e9 54 ff ff ff       	jmp    aa0 <malloc+0x68>
  }
}
 b4c:	c9                   	leave
 b4d:	c3                   	ret
