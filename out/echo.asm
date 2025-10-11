
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
  27:	48 c7 c1 56 0b 00 00 	mov    $0xb56,%rcx
  2e:	eb 07                	jmp    37 <main+0x37>
  30:	48 c7 c1 58 0b 00 00 	mov    $0xb58,%rcx
  37:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3a:	48 98                	cltq
  3c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  43:	00 
  44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  48:	48 01 d0             	add    %rdx,%rax
  4b:	48 8b 00             	mov    (%rax),%rax
  4e:	48 89 c2             	mov    %rax,%rdx
  51:	48 c7 c6 5a 0b 00 00 	mov    $0xb5a,%rsi
  58:	bf 01 00 00 00       	mov    $0x1,%edi
  5d:	b8 00 00 00 00       	mov    $0x0,%eax
  62:	e8 da 04 00 00       	call   541 <printf>
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

000000000000044f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 44f:	f3 0f 1e fa          	endbr64
 453:	55                   	push   %rbp
 454:	48 89 e5             	mov    %rsp,%rbp
 457:	48 83 ec 10          	sub    $0x10,%rsp
 45b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 45e:	89 f0                	mov    %esi,%eax
 460:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 463:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 467:	8b 45 fc             	mov    -0x4(%rbp),%eax
 46a:	ba 01 00 00 00       	mov    $0x1,%edx
 46f:	48 89 ce             	mov    %rcx,%rsi
 472:	89 c7                	mov    %eax,%edi
 474:	e8 36 ff ff ff       	call   3af <write>
}
 479:	90                   	nop
 47a:	c9                   	leave
 47b:	c3                   	ret

000000000000047c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 47c:	f3 0f 1e fa          	endbr64
 480:	55                   	push   %rbp
 481:	48 89 e5             	mov    %rsp,%rbp
 484:	48 83 ec 30          	sub    $0x30,%rsp
 488:	89 7d dc             	mov    %edi,-0x24(%rbp)
 48b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 48e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 491:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 494:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 49b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 49f:	74 17                	je     4b8 <printint+0x3c>
 4a1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4a5:	79 11                	jns    4b8 <printint+0x3c>
    neg = 1;
 4a7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4ae:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b1:	f7 d8                	neg    %eax
 4b3:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b6:	eb 06                	jmp    4be <printint+0x42>
  } else {
    x = xx;
 4b8:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4bb:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4c5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4cb:	ba 00 00 00 00       	mov    $0x0,%edx
 4d0:	f7 f6                	div    %esi
 4d2:	89 d1                	mov    %edx,%ecx
 4d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d7:	8d 50 01             	lea    0x1(%rax),%edx
 4da:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4dd:	89 ca                	mov    %ecx,%edx
 4df:	0f b6 92 a0 0d 00 00 	movzbl 0xda0(%rdx),%edx
 4e6:	48 98                	cltq
 4e8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4ec:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4f2:	ba 00 00 00 00       	mov    $0x0,%edx
 4f7:	f7 f7                	div    %edi
 4f9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 500:	75 c3                	jne    4c5 <printint+0x49>
  if(neg)
 502:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 506:	74 2b                	je     533 <printint+0xb7>
    buf[i++] = '-';
 508:	8b 45 fc             	mov    -0x4(%rbp),%eax
 50b:	8d 50 01             	lea    0x1(%rax),%edx
 50e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 511:	48 98                	cltq
 513:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 518:	eb 19                	jmp    533 <printint+0xb7>
    putc(fd, buf[i]);
 51a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 51d:	48 98                	cltq
 51f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 524:	0f be d0             	movsbl %al,%edx
 527:	8b 45 dc             	mov    -0x24(%rbp),%eax
 52a:	89 d6                	mov    %edx,%esi
 52c:	89 c7                	mov    %eax,%edi
 52e:	e8 1c ff ff ff       	call   44f <putc>
  while(--i >= 0)
 533:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 537:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 53b:	79 dd                	jns    51a <printint+0x9e>
}
 53d:	90                   	nop
 53e:	90                   	nop
 53f:	c9                   	leave
 540:	c3                   	ret

0000000000000541 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 541:	f3 0f 1e fa          	endbr64
 545:	55                   	push   %rbp
 546:	48 89 e5             	mov    %rsp,%rbp
 549:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 550:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 556:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 55d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 564:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 56b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 572:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 579:	84 c0                	test   %al,%al
 57b:	74 20                	je     59d <printf+0x5c>
 57d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 581:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 585:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 589:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 58d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 591:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 595:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 599:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 59d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5a4:	00 00 00 
 5a7:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5ae:	00 00 00 
 5b1:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5b5:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5bc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5c3:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5ca:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5d1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5d4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5db:	00 00 00 
 5de:	e9 a8 02 00 00       	jmp    88b <printf+0x34a>
    c = fmt[i] & 0xff;
 5e3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5e9:	48 63 d0             	movslq %eax,%rdx
 5ec:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5f3:	48 01 d0             	add    %rdx,%rax
 5f6:	0f b6 00             	movzbl (%rax),%eax
 5f9:	0f be c0             	movsbl %al,%eax
 5fc:	25 ff 00 00 00       	and    $0xff,%eax
 601:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 607:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 60e:	75 35                	jne    645 <printf+0x104>
      if(c == '%'){
 610:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 617:	75 0f                	jne    628 <printf+0xe7>
        state = '%';
 619:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 620:	00 00 00 
 623:	e9 5c 02 00 00       	jmp    884 <printf+0x343>
      } else {
        putc(fd, c);
 628:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 62e:	0f be d0             	movsbl %al,%edx
 631:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 637:	89 d6                	mov    %edx,%esi
 639:	89 c7                	mov    %eax,%edi
 63b:	e8 0f fe ff ff       	call   44f <putc>
 640:	e9 3f 02 00 00       	jmp    884 <printf+0x343>
      }
    } else if(state == '%'){
 645:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 64c:	0f 85 32 02 00 00    	jne    884 <printf+0x343>
      if(c == 'd'){
 652:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 659:	75 5e                	jne    6b9 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 65b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 661:	83 f8 2f             	cmp    $0x2f,%eax
 664:	77 23                	ja     689 <printf+0x148>
 666:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 66d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 673:	89 d2                	mov    %edx,%edx
 675:	48 01 d0             	add    %rdx,%rax
 678:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67e:	83 c2 08             	add    $0x8,%edx
 681:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 687:	eb 12                	jmp    69b <printf+0x15a>
 689:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 690:	48 8d 50 08          	lea    0x8(%rax),%rdx
 694:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 69b:	8b 30                	mov    (%rax),%esi
 69d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6a3:	b9 01 00 00 00       	mov    $0x1,%ecx
 6a8:	ba 0a 00 00 00       	mov    $0xa,%edx
 6ad:	89 c7                	mov    %eax,%edi
 6af:	e8 c8 fd ff ff       	call   47c <printint>
 6b4:	e9 c1 01 00 00       	jmp    87a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6b9:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6c0:	74 09                	je     6cb <printf+0x18a>
 6c2:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6c9:	75 5e                	jne    729 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6cb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d1:	83 f8 2f             	cmp    $0x2f,%eax
 6d4:	77 23                	ja     6f9 <printf+0x1b8>
 6d6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6dd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6e3:	89 d2                	mov    %edx,%edx
 6e5:	48 01 d0             	add    %rdx,%rax
 6e8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ee:	83 c2 08             	add    $0x8,%edx
 6f1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6f7:	eb 12                	jmp    70b <printf+0x1ca>
 6f9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 700:	48 8d 50 08          	lea    0x8(%rax),%rdx
 704:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 70b:	8b 30                	mov    (%rax),%esi
 70d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 713:	b9 00 00 00 00       	mov    $0x0,%ecx
 718:	ba 10 00 00 00       	mov    $0x10,%edx
 71d:	89 c7                	mov    %eax,%edi
 71f:	e8 58 fd ff ff       	call   47c <printint>
 724:	e9 51 01 00 00       	jmp    87a <printf+0x339>
      } else if(c == 's'){
 729:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 730:	0f 85 98 00 00 00    	jne    7ce <printf+0x28d>
        s = va_arg(ap, char*);
 736:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 73c:	83 f8 2f             	cmp    $0x2f,%eax
 73f:	77 23                	ja     764 <printf+0x223>
 741:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 748:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 74e:	89 d2                	mov    %edx,%edx
 750:	48 01 d0             	add    %rdx,%rax
 753:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 759:	83 c2 08             	add    $0x8,%edx
 75c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 762:	eb 12                	jmp    776 <printf+0x235>
 764:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 76b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 76f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 776:	48 8b 00             	mov    (%rax),%rax
 779:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 780:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 787:	00 
 788:	75 31                	jne    7bb <printf+0x27a>
          s = "(null)";
 78a:	48 c7 85 48 ff ff ff 	movq   $0xb5f,-0xb8(%rbp)
 791:	5f 0b 00 00 
        while(*s != 0){
 795:	eb 24                	jmp    7bb <printf+0x27a>
          putc(fd, *s);
 797:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 79e:	0f b6 00             	movzbl (%rax),%eax
 7a1:	0f be d0             	movsbl %al,%edx
 7a4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7aa:	89 d6                	mov    %edx,%esi
 7ac:	89 c7                	mov    %eax,%edi
 7ae:	e8 9c fc ff ff       	call   44f <putc>
          s++;
 7b3:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7ba:	01 
        while(*s != 0){
 7bb:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7c2:	0f b6 00             	movzbl (%rax),%eax
 7c5:	84 c0                	test   %al,%al
 7c7:	75 ce                	jne    797 <printf+0x256>
 7c9:	e9 ac 00 00 00       	jmp    87a <printf+0x339>
        }
      } else if(c == 'c'){
 7ce:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7d5:	75 56                	jne    82d <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7d7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7dd:	83 f8 2f             	cmp    $0x2f,%eax
 7e0:	77 23                	ja     805 <printf+0x2c4>
 7e2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ef:	89 d2                	mov    %edx,%edx
 7f1:	48 01 d0             	add    %rdx,%rax
 7f4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7fa:	83 c2 08             	add    $0x8,%edx
 7fd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 803:	eb 12                	jmp    817 <printf+0x2d6>
 805:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 80c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 810:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 817:	8b 00                	mov    (%rax),%eax
 819:	0f be d0             	movsbl %al,%edx
 81c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 822:	89 d6                	mov    %edx,%esi
 824:	89 c7                	mov    %eax,%edi
 826:	e8 24 fc ff ff       	call   44f <putc>
 82b:	eb 4d                	jmp    87a <printf+0x339>
      } else if(c == '%'){
 82d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 834:	75 1a                	jne    850 <printf+0x30f>
        putc(fd, c);
 836:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 83c:	0f be d0             	movsbl %al,%edx
 83f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 845:	89 d6                	mov    %edx,%esi
 847:	89 c7                	mov    %eax,%edi
 849:	e8 01 fc ff ff       	call   44f <putc>
 84e:	eb 2a                	jmp    87a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 850:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 856:	be 25 00 00 00       	mov    $0x25,%esi
 85b:	89 c7                	mov    %eax,%edi
 85d:	e8 ed fb ff ff       	call   44f <putc>
        putc(fd, c);
 862:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 868:	0f be d0             	movsbl %al,%edx
 86b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 871:	89 d6                	mov    %edx,%esi
 873:	89 c7                	mov    %eax,%edi
 875:	e8 d5 fb ff ff       	call   44f <putc>
      }
      state = 0;
 87a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 881:	00 00 00 
  for(i = 0; fmt[i]; i++){
 884:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 88b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 891:	48 63 d0             	movslq %eax,%rdx
 894:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 89b:	48 01 d0             	add    %rdx,%rax
 89e:	0f b6 00             	movzbl (%rax),%eax
 8a1:	84 c0                	test   %al,%al
 8a3:	0f 85 3a fd ff ff    	jne    5e3 <printf+0xa2>
    }
  }
}
 8a9:	90                   	nop
 8aa:	90                   	nop
 8ab:	c9                   	leave
 8ac:	c3                   	ret

00000000000008ad <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ad:	f3 0f 1e fa          	endbr64
 8b1:	55                   	push   %rbp
 8b2:	48 89 e5             	mov    %rsp,%rbp
 8b5:	48 83 ec 18          	sub    $0x18,%rsp
 8b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8c1:	48 83 e8 10          	sub    $0x10,%rax
 8c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c9:	48 8b 05 00 05 00 00 	mov    0x500(%rip),%rax        # dd0 <freep>
 8d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d4:	eb 2f                	jmp    905 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8da:	48 8b 00             	mov    (%rax),%rax
 8dd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e1:	72 17                	jb     8fa <free+0x4d>
 8e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8eb:	72 2f                	jb     91c <free+0x6f>
 8ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f1:	48 8b 00             	mov    (%rax),%rax
 8f4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8f8:	72 22                	jb     91c <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fe:	48 8b 00             	mov    (%rax),%rax
 901:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 905:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 909:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 90d:	73 c7                	jae    8d6 <free+0x29>
 90f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 913:	48 8b 00             	mov    (%rax),%rax
 916:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 91a:	73 ba                	jae    8d6 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 91c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 920:	8b 40 08             	mov    0x8(%rax),%eax
 923:	89 c0                	mov    %eax,%eax
 925:	48 c1 e0 04          	shl    $0x4,%rax
 929:	48 89 c2             	mov    %rax,%rdx
 92c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 930:	48 01 c2             	add    %rax,%rdx
 933:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 937:	48 8b 00             	mov    (%rax),%rax
 93a:	48 39 c2             	cmp    %rax,%rdx
 93d:	75 2d                	jne    96c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 93f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 943:	8b 50 08             	mov    0x8(%rax),%edx
 946:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94a:	48 8b 00             	mov    (%rax),%rax
 94d:	8b 40 08             	mov    0x8(%rax),%eax
 950:	01 c2                	add    %eax,%edx
 952:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 956:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 959:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95d:	48 8b 00             	mov    (%rax),%rax
 960:	48 8b 10             	mov    (%rax),%rdx
 963:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 967:	48 89 10             	mov    %rdx,(%rax)
 96a:	eb 0e                	jmp    97a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 96c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 970:	48 8b 10             	mov    (%rax),%rdx
 973:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 977:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 97a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97e:	8b 40 08             	mov    0x8(%rax),%eax
 981:	89 c0                	mov    %eax,%eax
 983:	48 c1 e0 04          	shl    $0x4,%rax
 987:	48 89 c2             	mov    %rax,%rdx
 98a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98e:	48 01 d0             	add    %rdx,%rax
 991:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 995:	75 27                	jne    9be <free+0x111>
    p->s.size += bp->s.size;
 997:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99b:	8b 50 08             	mov    0x8(%rax),%edx
 99e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a2:	8b 40 08             	mov    0x8(%rax),%eax
 9a5:	01 c2                	add    %eax,%edx
 9a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ab:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b2:	48 8b 10             	mov    (%rax),%rdx
 9b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b9:	48 89 10             	mov    %rdx,(%rax)
 9bc:	eb 0b                	jmp    9c9 <free+0x11c>
  } else
    p->s.ptr = bp;
 9be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9c6:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cd:	48 89 05 fc 03 00 00 	mov    %rax,0x3fc(%rip)        # dd0 <freep>
}
 9d4:	90                   	nop
 9d5:	c9                   	leave
 9d6:	c3                   	ret

00000000000009d7 <morecore>:

static Header*
morecore(uint nu)
{
 9d7:	f3 0f 1e fa          	endbr64
 9db:	55                   	push   %rbp
 9dc:	48 89 e5             	mov    %rsp,%rbp
 9df:	48 83 ec 20          	sub    $0x20,%rsp
 9e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9e6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9ed:	77 07                	ja     9f6 <morecore+0x1f>
    nu = 4096;
 9ef:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9f9:	c1 e0 04             	shl    $0x4,%eax
 9fc:	89 c7                	mov    %eax,%edi
 9fe:	e8 14 fa ff ff       	call   417 <sbrk>
 a03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a07:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a0c:	75 07                	jne    a15 <morecore+0x3e>
    return 0;
 a0e:	b8 00 00 00 00       	mov    $0x0,%eax
 a13:	eb 29                	jmp    a3e <morecore+0x67>
  hp = (Header*)p;
 a15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a21:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a24:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2b:	48 83 c0 10          	add    $0x10,%rax
 a2f:	48 89 c7             	mov    %rax,%rdi
 a32:	e8 76 fe ff ff       	call   8ad <free>
  return freep;
 a37:	48 8b 05 92 03 00 00 	mov    0x392(%rip),%rax        # dd0 <freep>
}
 a3e:	c9                   	leave
 a3f:	c3                   	ret

0000000000000a40 <malloc>:

void*
malloc(uint nbytes)
{
 a40:	f3 0f 1e fa          	endbr64
 a44:	55                   	push   %rbp
 a45:	48 89 e5             	mov    %rsp,%rbp
 a48:	48 83 ec 30          	sub    $0x30,%rsp
 a4c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a4f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a52:	48 83 c0 0f          	add    $0xf,%rax
 a56:	48 c1 e8 04          	shr    $0x4,%rax
 a5a:	83 c0 01             	add    $0x1,%eax
 a5d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a60:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # dd0 <freep>
 a67:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a6b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a70:	75 2b                	jne    a9d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a72:	48 c7 45 f0 c0 0d 00 	movq   $0xdc0,-0x10(%rbp)
 a79:	00 
 a7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a7e:	48 89 05 4b 03 00 00 	mov    %rax,0x34b(%rip)        # dd0 <freep>
 a85:	48 8b 05 44 03 00 00 	mov    0x344(%rip),%rax        # dd0 <freep>
 a8c:	48 89 05 2d 03 00 00 	mov    %rax,0x32d(%rip)        # dc0 <base>
    base.s.size = 0;
 a93:	c7 05 2b 03 00 00 00 	movl   $0x0,0x32b(%rip)        # dc8 <base+0x8>
 a9a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa1:	48 8b 00             	mov    (%rax),%rax
 aa4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aac:	8b 40 08             	mov    0x8(%rax),%eax
 aaf:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ab2:	72 5f                	jb     b13 <malloc+0xd3>
      if(p->s.size == nunits)
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	8b 40 08             	mov    0x8(%rax),%eax
 abb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 abe:	75 10                	jne    ad0 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ac0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac4:	48 8b 10             	mov    (%rax),%rdx
 ac7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 acb:	48 89 10             	mov    %rdx,(%rax)
 ace:	eb 2e                	jmp    afe <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad4:	8b 40 08             	mov    0x8(%rax),%eax
 ad7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ada:	89 c2                	mov    %eax,%edx
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae7:	8b 40 08             	mov    0x8(%rax),%eax
 aea:	89 c0                	mov    %eax,%eax
 aec:	48 c1 e0 04          	shl    $0x4,%rax
 af0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 afb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 afe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b02:	48 89 05 c7 02 00 00 	mov    %rax,0x2c7(%rip)        # dd0 <freep>
      return (void*)(p + 1);
 b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0d:	48 83 c0 10          	add    $0x10,%rax
 b11:	eb 41                	jmp    b54 <malloc+0x114>
    }
    if(p == freep)
 b13:	48 8b 05 b6 02 00 00 	mov    0x2b6(%rip),%rax        # dd0 <freep>
 b1a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b1e:	75 1c                	jne    b3c <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b20:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b23:	89 c7                	mov    %eax,%edi
 b25:	e8 ad fe ff ff       	call   9d7 <morecore>
 b2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b2e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b33:	75 07                	jne    b3c <malloc+0xfc>
        return 0;
 b35:	b8 00 00 00 00       	mov    $0x0,%eax
 b3a:	eb 18                	jmp    b54 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b40:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b48:	48 8b 00             	mov    (%rax),%rax
 b4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b4f:	e9 54 ff ff ff       	jmp    aa8 <malloc+0x68>
  }
}
 b54:	c9                   	leave
 b55:	c3                   	ret
