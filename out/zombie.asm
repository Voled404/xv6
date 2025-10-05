
fs/zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
  if(fork() > 0)
   8:	e8 22 03 00 00       	call   32f <fork>
   d:	85 c0                	test   %eax,%eax
   f:	7e 0a                	jle    1b <main+0x1b>
    sleep(5);  // Let child exit before parent.
  11:	bf 05 00 00 00       	mov    $0x5,%edi
  16:	e8 ac 03 00 00       	call   3c7 <sleep>
  exit();
  1b:	e8 17 03 00 00       	call   337 <exit>

0000000000000020 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  20:	55                   	push   %rbp
  21:	48 89 e5             	mov    %rsp,%rbp
  24:	48 83 ec 10          	sub    $0x10,%rsp
  28:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  2f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  32:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  36:	8b 55 f0             	mov    -0x10(%rbp),%edx
  39:	8b 45 f4             	mov    -0xc(%rbp),%eax
  3c:	48 89 ce             	mov    %rcx,%rsi
  3f:	48 89 f7             	mov    %rsi,%rdi
  42:	89 d1                	mov    %edx,%ecx
  44:	fc                   	cld
  45:	f3 aa                	rep stos %al,%es:(%rdi)
  47:	89 ca                	mov    %ecx,%edx
  49:	48 89 fe             	mov    %rdi,%rsi
  4c:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  50:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  53:	90                   	nop
  54:	c9                   	leave
  55:	c3                   	ret

0000000000000056 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  56:	f3 0f 1e fa          	endbr64
  5a:	55                   	push   %rbp
  5b:	48 89 e5             	mov    %rsp,%rbp
  5e:	48 83 ec 20          	sub    $0x20,%rsp
  62:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  66:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  6e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  72:	90                   	nop
  73:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  77:	48 8d 42 01          	lea    0x1(%rdx),%rax
  7b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  83:	48 8d 48 01          	lea    0x1(%rax),%rcx
  87:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8b:	0f b6 12             	movzbl (%rdx),%edx
  8e:	88 10                	mov    %dl,(%rax)
  90:	0f b6 00             	movzbl (%rax),%eax
  93:	84 c0                	test   %al,%al
  95:	75 dc                	jne    73 <strcpy+0x1d>
    ;
  return os;
  97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  9b:	c9                   	leave
  9c:	c3                   	ret

000000000000009d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9d:	f3 0f 1e fa          	endbr64
  a1:	55                   	push   %rbp
  a2:	48 89 e5             	mov    %rsp,%rbp
  a5:	48 83 ec 10          	sub    $0x10,%rsp
  a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  ad:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  b1:	eb 0a                	jmp    bd <strcmp+0x20>
    p++, q++;
  b3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  b8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  c1:	0f b6 00             	movzbl (%rax),%eax
  c4:	84 c0                	test   %al,%al
  c6:	74 12                	je     da <strcmp+0x3d>
  c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  cc:	0f b6 10             	movzbl (%rax),%edx
  cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  d3:	0f b6 00             	movzbl (%rax),%eax
  d6:	38 c2                	cmp    %al,%dl
  d8:	74 d9                	je     b3 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
  da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  de:	0f b6 00             	movzbl (%rax),%eax
  e1:	0f b6 d0             	movzbl %al,%edx
  e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  e8:	0f b6 00             	movzbl (%rax),%eax
  eb:	0f b6 c0             	movzbl %al,%eax
  ee:	29 c2                	sub    %eax,%edx
  f0:	89 d0                	mov    %edx,%eax
}
  f2:	c9                   	leave
  f3:	c3                   	ret

00000000000000f4 <strlen>:

uint
strlen(char *s)
{
  f4:	f3 0f 1e fa          	endbr64
  f8:	55                   	push   %rbp
  f9:	48 89 e5             	mov    %rsp,%rbp
  fc:	48 83 ec 18          	sub    $0x18,%rsp
 100:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 10b:	eb 04                	jmp    111 <strlen+0x1d>
 10d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 111:	8b 45 fc             	mov    -0x4(%rbp),%eax
 114:	48 63 d0             	movslq %eax,%rdx
 117:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 11b:	48 01 d0             	add    %rdx,%rax
 11e:	0f b6 00             	movzbl (%rax),%eax
 121:	84 c0                	test   %al,%al
 123:	75 e8                	jne    10d <strlen+0x19>
    ;
  return n;
 125:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 128:	c9                   	leave
 129:	c3                   	ret

000000000000012a <memset>:

void*
memset(void *dst, int c, uint n)
{
 12a:	f3 0f 1e fa          	endbr64
 12e:	55                   	push   %rbp
 12f:	48 89 e5             	mov    %rsp,%rbp
 132:	48 83 ec 10          	sub    $0x10,%rsp
 136:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 13a:	89 75 f4             	mov    %esi,-0xc(%rbp)
 13d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 140:	8b 55 f0             	mov    -0x10(%rbp),%edx
 143:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 146:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 14a:	89 ce                	mov    %ecx,%esi
 14c:	48 89 c7             	mov    %rax,%rdi
 14f:	e8 cc fe ff ff       	call   20 <stosb>
  return dst;
 154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 158:	c9                   	leave
 159:	c3                   	ret

000000000000015a <strchr>:

char*
strchr(const char *s, char c)
{
 15a:	f3 0f 1e fa          	endbr64
 15e:	55                   	push   %rbp
 15f:	48 89 e5             	mov    %rsp,%rbp
 162:	48 83 ec 10          	sub    $0x10,%rsp
 166:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 16a:	89 f0                	mov    %esi,%eax
 16c:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 16f:	eb 17                	jmp    188 <strchr+0x2e>
    if(*s == c)
 171:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 175:	0f b6 00             	movzbl (%rax),%eax
 178:	38 45 f4             	cmp    %al,-0xc(%rbp)
 17b:	75 06                	jne    183 <strchr+0x29>
      return (char*)s;
 17d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 181:	eb 15                	jmp    198 <strchr+0x3e>
  for(; *s; s++)
 183:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 188:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 18c:	0f b6 00             	movzbl (%rax),%eax
 18f:	84 c0                	test   %al,%al
 191:	75 de                	jne    171 <strchr+0x17>
  return 0;
 193:	b8 00 00 00 00       	mov    $0x0,%eax
}
 198:	c9                   	leave
 199:	c3                   	ret

000000000000019a <gets>:

char*
gets(char *buf, int max)
{
 19a:	f3 0f 1e fa          	endbr64
 19e:	55                   	push   %rbp
 19f:	48 89 e5             	mov    %rsp,%rbp
 1a2:	48 83 ec 20          	sub    $0x20,%rsp
 1a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1aa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1b4:	eb 48                	jmp    1fe <gets+0x64>
    cc = read(0, &c, 1);
 1b6:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1ba:	ba 01 00 00 00       	mov    $0x1,%edx
 1bf:	48 89 c6             	mov    %rax,%rsi
 1c2:	bf 00 00 00 00       	mov    $0x0,%edi
 1c7:	e8 83 01 00 00       	call   34f <read>
 1cc:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1cf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1d3:	7e 36                	jle    20b <gets+0x71>
      break;
    buf[i++] = c;
 1d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1d8:	8d 50 01             	lea    0x1(%rax),%edx
 1db:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1de:	48 63 d0             	movslq %eax,%rdx
 1e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1e5:	48 01 c2             	add    %rax,%rdx
 1e8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1ec:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 1ee:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1f2:	3c 0a                	cmp    $0xa,%al
 1f4:	74 16                	je     20c <gets+0x72>
 1f6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1fa:	3c 0d                	cmp    $0xd,%al
 1fc:	74 0e                	je     20c <gets+0x72>
  for(i=0; i+1 < max; ){
 1fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
 201:	83 c0 01             	add    $0x1,%eax
 204:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 207:	7f ad                	jg     1b6 <gets+0x1c>
 209:	eb 01                	jmp    20c <gets+0x72>
      break;
 20b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 20c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 20f:	48 63 d0             	movslq %eax,%rdx
 212:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 216:	48 01 d0             	add    %rdx,%rax
 219:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 21c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 220:	c9                   	leave
 221:	c3                   	ret

0000000000000222 <stat>:

int
stat(char *n, struct stat *st)
{
 222:	f3 0f 1e fa          	endbr64
 226:	55                   	push   %rbp
 227:	48 89 e5             	mov    %rsp,%rbp
 22a:	48 83 ec 20          	sub    $0x20,%rsp
 22e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 232:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 236:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 23a:	be 00 00 00 00       	mov    $0x0,%esi
 23f:	48 89 c7             	mov    %rax,%rdi
 242:	e8 30 01 00 00       	call   377 <open>
 247:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 24a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 24e:	79 07                	jns    257 <stat+0x35>
    return -1;
 250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 255:	eb 21                	jmp    278 <stat+0x56>
  r = fstat(fd, st);
 257:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 25b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 25e:	48 89 d6             	mov    %rdx,%rsi
 261:	89 c7                	mov    %eax,%edi
 263:	e8 27 01 00 00       	call   38f <fstat>
 268:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 26b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 26e:	89 c7                	mov    %eax,%edi
 270:	e8 ea 00 00 00       	call   35f <close>
  return r;
 275:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 278:	c9                   	leave
 279:	c3                   	ret

000000000000027a <atoi>:

int
atoi(const char *s)
{
 27a:	f3 0f 1e fa          	endbr64
 27e:	55                   	push   %rbp
 27f:	48 89 e5             	mov    %rsp,%rbp
 282:	48 83 ec 18          	sub    $0x18,%rsp
 286:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 28a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 291:	eb 28                	jmp    2bb <atoi+0x41>
    n = n*10 + *s++ - '0';
 293:	8b 55 fc             	mov    -0x4(%rbp),%edx
 296:	89 d0                	mov    %edx,%eax
 298:	c1 e0 02             	shl    $0x2,%eax
 29b:	01 d0                	add    %edx,%eax
 29d:	01 c0                	add    %eax,%eax
 29f:	89 c1                	mov    %eax,%ecx
 2a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2a5:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2a9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2ad:	0f b6 00             	movzbl (%rax),%eax
 2b0:	0f be c0             	movsbl %al,%eax
 2b3:	01 c8                	add    %ecx,%eax
 2b5:	83 e8 30             	sub    $0x30,%eax
 2b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2bf:	0f b6 00             	movzbl (%rax),%eax
 2c2:	3c 2f                	cmp    $0x2f,%al
 2c4:	7e 0b                	jle    2d1 <atoi+0x57>
 2c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2ca:	0f b6 00             	movzbl (%rax),%eax
 2cd:	3c 39                	cmp    $0x39,%al
 2cf:	7e c2                	jle    293 <atoi+0x19>
  return n;
 2d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2d4:	c9                   	leave
 2d5:	c3                   	ret

00000000000002d6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d6:	f3 0f 1e fa          	endbr64
 2da:	55                   	push   %rbp
 2db:	48 89 e5             	mov    %rsp,%rbp
 2de:	48 83 ec 28          	sub    $0x28,%rsp
 2e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 2ea:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 2ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 2f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 2f9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 2fd:	eb 1d                	jmp    31c <memmove+0x46>
    *dst++ = *src++;
 2ff:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 303:	48 8d 42 01          	lea    0x1(%rdx),%rax
 307:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 30b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 30f:	48 8d 48 01          	lea    0x1(%rax),%rcx
 313:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 317:	0f b6 12             	movzbl (%rdx),%edx
 31a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 31c:	8b 45 dc             	mov    -0x24(%rbp),%eax
 31f:	8d 50 ff             	lea    -0x1(%rax),%edx
 322:	89 55 dc             	mov    %edx,-0x24(%rbp)
 325:	85 c0                	test   %eax,%eax
 327:	7f d6                	jg     2ff <memmove+0x29>
  return vdst;
 329:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 32d:	c9                   	leave
 32e:	c3                   	ret

000000000000032f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32f:	b8 01 00 00 00       	mov    $0x1,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

0000000000000337 <exit>:
SYSCALL(exit)
 337:	b8 02 00 00 00       	mov    $0x2,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

000000000000033f <wait>:
SYSCALL(wait)
 33f:	b8 03 00 00 00       	mov    $0x3,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

0000000000000347 <pipe>:
SYSCALL(pipe)
 347:	b8 04 00 00 00       	mov    $0x4,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

000000000000034f <read>:
SYSCALL(read)
 34f:	b8 05 00 00 00       	mov    $0x5,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

0000000000000357 <write>:
SYSCALL(write)
 357:	b8 10 00 00 00       	mov    $0x10,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

000000000000035f <close>:
SYSCALL(close)
 35f:	b8 15 00 00 00       	mov    $0x15,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

0000000000000367 <kill>:
SYSCALL(kill)
 367:	b8 06 00 00 00       	mov    $0x6,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

000000000000036f <exec>:
SYSCALL(exec)
 36f:	b8 07 00 00 00       	mov    $0x7,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

0000000000000377 <open>:
SYSCALL(open)
 377:	b8 0f 00 00 00       	mov    $0xf,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

000000000000037f <mknod>:
SYSCALL(mknod)
 37f:	b8 11 00 00 00       	mov    $0x11,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

0000000000000387 <unlink>:
SYSCALL(unlink)
 387:	b8 12 00 00 00       	mov    $0x12,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <fstat>:
SYSCALL(fstat)
 38f:	b8 08 00 00 00       	mov    $0x8,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <link>:
SYSCALL(link)
 397:	b8 13 00 00 00       	mov    $0x13,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <mkdir>:
SYSCALL(mkdir)
 39f:	b8 14 00 00 00       	mov    $0x14,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <chdir>:
SYSCALL(chdir)
 3a7:	b8 09 00 00 00       	mov    $0x9,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <dup>:
SYSCALL(dup)
 3af:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <getpid>:
SYSCALL(getpid)
 3b7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <sbrk>:
SYSCALL(sbrk)
 3bf:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <sleep>:
SYSCALL(sleep)
 3c7:	b8 0d 00 00 00       	mov    $0xd,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <uptime>:
SYSCALL(uptime)
 3cf:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <getpinfo>:
SYSCALL(getpinfo)
 3d7:	b8 18 00 00 00       	mov    $0x18,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <settickets>:
SYSCALL(settickets)
 3df:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e7:	f3 0f 1e fa          	endbr64
 3eb:	55                   	push   %rbp
 3ec:	48 89 e5             	mov    %rsp,%rbp
 3ef:	48 83 ec 10          	sub    $0x10,%rsp
 3f3:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3f6:	89 f0                	mov    %esi,%eax
 3f8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 3fb:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 3ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
 402:	ba 01 00 00 00       	mov    $0x1,%edx
 407:	48 89 ce             	mov    %rcx,%rsi
 40a:	89 c7                	mov    %eax,%edi
 40c:	e8 46 ff ff ff       	call   357 <write>
}
 411:	90                   	nop
 412:	c9                   	leave
 413:	c3                   	ret

0000000000000414 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 414:	f3 0f 1e fa          	endbr64
 418:	55                   	push   %rbp
 419:	48 89 e5             	mov    %rsp,%rbp
 41c:	48 83 ec 30          	sub    $0x30,%rsp
 420:	89 7d dc             	mov    %edi,-0x24(%rbp)
 423:	89 75 d8             	mov    %esi,-0x28(%rbp)
 426:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 429:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 42c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 433:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 437:	74 17                	je     450 <printint+0x3c>
 439:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 43d:	79 11                	jns    450 <printint+0x3c>
    neg = 1;
 43f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 446:	8b 45 d8             	mov    -0x28(%rbp),%eax
 449:	f7 d8                	neg    %eax
 44b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 44e:	eb 06                	jmp    456 <printint+0x42>
  } else {
    x = xx;
 450:	8b 45 d8             	mov    -0x28(%rbp),%eax
 453:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 456:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 45d:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 460:	8b 45 f4             	mov    -0xc(%rbp),%eax
 463:	ba 00 00 00 00       	mov    $0x0,%edx
 468:	f7 f6                	div    %esi
 46a:	89 d1                	mov    %edx,%ecx
 46c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 46f:	8d 50 01             	lea    0x1(%rax),%edx
 472:	89 55 fc             	mov    %edx,-0x4(%rbp)
 475:	89 ca                	mov    %ecx,%edx
 477:	0f b6 92 30 0d 00 00 	movzbl 0xd30(%rdx),%edx
 47e:	48 98                	cltq
 480:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 484:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 487:	8b 45 f4             	mov    -0xc(%rbp),%eax
 48a:	ba 00 00 00 00       	mov    $0x0,%edx
 48f:	f7 f7                	div    %edi
 491:	89 45 f4             	mov    %eax,-0xc(%rbp)
 494:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 498:	75 c3                	jne    45d <printint+0x49>
  if(neg)
 49a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 49e:	74 2b                	je     4cb <printint+0xb7>
    buf[i++] = '-';
 4a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a3:	8d 50 01             	lea    0x1(%rax),%edx
 4a6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4a9:	48 98                	cltq
 4ab:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4b0:	eb 19                	jmp    4cb <printint+0xb7>
    putc(fd, buf[i]);
 4b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4b5:	48 98                	cltq
 4b7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4bc:	0f be d0             	movsbl %al,%edx
 4bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4c2:	89 d6                	mov    %edx,%esi
 4c4:	89 c7                	mov    %eax,%edi
 4c6:	e8 1c ff ff ff       	call   3e7 <putc>
  while(--i >= 0)
 4cb:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4d3:	79 dd                	jns    4b2 <printint+0x9e>
}
 4d5:	90                   	nop
 4d6:	90                   	nop
 4d7:	c9                   	leave
 4d8:	c3                   	ret

00000000000004d9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d9:	f3 0f 1e fa          	endbr64
 4dd:	55                   	push   %rbp
 4de:	48 89 e5             	mov    %rsp,%rbp
 4e1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4e8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4ee:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4f5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 4fc:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 503:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 50a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 511:	84 c0                	test   %al,%al
 513:	74 20                	je     535 <printf+0x5c>
 515:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 519:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 51d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 521:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 525:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 529:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 52d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 531:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 535:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 53c:	00 00 00 
 53f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 546:	00 00 00 
 549:	48 8d 45 10          	lea    0x10(%rbp),%rax
 54d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 554:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 55b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 562:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 569:	00 00 00 
  for(i = 0; fmt[i]; i++){
 56c:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 573:	00 00 00 
 576:	e9 a8 02 00 00       	jmp    823 <printf+0x34a>
    c = fmt[i] & 0xff;
 57b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 581:	48 63 d0             	movslq %eax,%rdx
 584:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 58b:	48 01 d0             	add    %rdx,%rax
 58e:	0f b6 00             	movzbl (%rax),%eax
 591:	0f be c0             	movsbl %al,%eax
 594:	25 ff 00 00 00       	and    $0xff,%eax
 599:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 59f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5a6:	75 35                	jne    5dd <printf+0x104>
      if(c == '%'){
 5a8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5af:	75 0f                	jne    5c0 <printf+0xe7>
        state = '%';
 5b1:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5b8:	00 00 00 
 5bb:	e9 5c 02 00 00       	jmp    81c <printf+0x343>
      } else {
        putc(fd, c);
 5c0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5c6:	0f be d0             	movsbl %al,%edx
 5c9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5cf:	89 d6                	mov    %edx,%esi
 5d1:	89 c7                	mov    %eax,%edi
 5d3:	e8 0f fe ff ff       	call   3e7 <putc>
 5d8:	e9 3f 02 00 00       	jmp    81c <printf+0x343>
      }
    } else if(state == '%'){
 5dd:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5e4:	0f 85 32 02 00 00    	jne    81c <printf+0x343>
      if(c == 'd'){
 5ea:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5f1:	75 5e                	jne    651 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 5f3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 5f9:	83 f8 2f             	cmp    $0x2f,%eax
 5fc:	77 23                	ja     621 <printf+0x148>
 5fe:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 605:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 60b:	89 d2                	mov    %edx,%edx
 60d:	48 01 d0             	add    %rdx,%rax
 610:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 616:	83 c2 08             	add    $0x8,%edx
 619:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 61f:	eb 12                	jmp    633 <printf+0x15a>
 621:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 628:	48 8d 50 08          	lea    0x8(%rax),%rdx
 62c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 633:	8b 30                	mov    (%rax),%esi
 635:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 63b:	b9 01 00 00 00       	mov    $0x1,%ecx
 640:	ba 0a 00 00 00       	mov    $0xa,%edx
 645:	89 c7                	mov    %eax,%edi
 647:	e8 c8 fd ff ff       	call   414 <printint>
 64c:	e9 c1 01 00 00       	jmp    812 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 651:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 658:	74 09                	je     663 <printf+0x18a>
 65a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 661:	75 5e                	jne    6c1 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 663:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 669:	83 f8 2f             	cmp    $0x2f,%eax
 66c:	77 23                	ja     691 <printf+0x1b8>
 66e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 675:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67b:	89 d2                	mov    %edx,%edx
 67d:	48 01 d0             	add    %rdx,%rax
 680:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 686:	83 c2 08             	add    $0x8,%edx
 689:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 68f:	eb 12                	jmp    6a3 <printf+0x1ca>
 691:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 698:	48 8d 50 08          	lea    0x8(%rax),%rdx
 69c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6a3:	8b 30                	mov    (%rax),%esi
 6a5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ab:	b9 00 00 00 00       	mov    $0x0,%ecx
 6b0:	ba 10 00 00 00       	mov    $0x10,%edx
 6b5:	89 c7                	mov    %eax,%edi
 6b7:	e8 58 fd ff ff       	call   414 <printint>
 6bc:	e9 51 01 00 00       	jmp    812 <printf+0x339>
      } else if(c == 's'){
 6c1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6c8:	0f 85 98 00 00 00    	jne    766 <printf+0x28d>
        s = va_arg(ap, char*);
 6ce:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d4:	83 f8 2f             	cmp    $0x2f,%eax
 6d7:	77 23                	ja     6fc <printf+0x223>
 6d9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6e6:	89 d2                	mov    %edx,%edx
 6e8:	48 01 d0             	add    %rdx,%rax
 6eb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f1:	83 c2 08             	add    $0x8,%edx
 6f4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6fa:	eb 12                	jmp    70e <printf+0x235>
 6fc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 703:	48 8d 50 08          	lea    0x8(%rax),%rdx
 707:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 70e:	48 8b 00             	mov    (%rax),%rax
 711:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 718:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 71f:	00 
 720:	75 31                	jne    753 <printf+0x27a>
          s = "(null)";
 722:	48 c7 85 48 ff ff ff 	movq   $0xaee,-0xb8(%rbp)
 729:	ee 0a 00 00 
        while(*s != 0){
 72d:	eb 24                	jmp    753 <printf+0x27a>
          putc(fd, *s);
 72f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 736:	0f b6 00             	movzbl (%rax),%eax
 739:	0f be d0             	movsbl %al,%edx
 73c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 742:	89 d6                	mov    %edx,%esi
 744:	89 c7                	mov    %eax,%edi
 746:	e8 9c fc ff ff       	call   3e7 <putc>
          s++;
 74b:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 752:	01 
        while(*s != 0){
 753:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 75a:	0f b6 00             	movzbl (%rax),%eax
 75d:	84 c0                	test   %al,%al
 75f:	75 ce                	jne    72f <printf+0x256>
 761:	e9 ac 00 00 00       	jmp    812 <printf+0x339>
        }
      } else if(c == 'c'){
 766:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 76d:	75 56                	jne    7c5 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 76f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 775:	83 f8 2f             	cmp    $0x2f,%eax
 778:	77 23                	ja     79d <printf+0x2c4>
 77a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 781:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 787:	89 d2                	mov    %edx,%edx
 789:	48 01 d0             	add    %rdx,%rax
 78c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 792:	83 c2 08             	add    $0x8,%edx
 795:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 79b:	eb 12                	jmp    7af <printf+0x2d6>
 79d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7a4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7a8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7af:	8b 00                	mov    (%rax),%eax
 7b1:	0f be d0             	movsbl %al,%edx
 7b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ba:	89 d6                	mov    %edx,%esi
 7bc:	89 c7                	mov    %eax,%edi
 7be:	e8 24 fc ff ff       	call   3e7 <putc>
 7c3:	eb 4d                	jmp    812 <printf+0x339>
      } else if(c == '%'){
 7c5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7cc:	75 1a                	jne    7e8 <printf+0x30f>
        putc(fd, c);
 7ce:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7d4:	0f be d0             	movsbl %al,%edx
 7d7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7dd:	89 d6                	mov    %edx,%esi
 7df:	89 c7                	mov    %eax,%edi
 7e1:	e8 01 fc ff ff       	call   3e7 <putc>
 7e6:	eb 2a                	jmp    812 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ee:	be 25 00 00 00       	mov    $0x25,%esi
 7f3:	89 c7                	mov    %eax,%edi
 7f5:	e8 ed fb ff ff       	call   3e7 <putc>
        putc(fd, c);
 7fa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 800:	0f be d0             	movsbl %al,%edx
 803:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 809:	89 d6                	mov    %edx,%esi
 80b:	89 c7                	mov    %eax,%edi
 80d:	e8 d5 fb ff ff       	call   3e7 <putc>
      }
      state = 0;
 812:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 819:	00 00 00 
  for(i = 0; fmt[i]; i++){
 81c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 823:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 829:	48 63 d0             	movslq %eax,%rdx
 82c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 833:	48 01 d0             	add    %rdx,%rax
 836:	0f b6 00             	movzbl (%rax),%eax
 839:	84 c0                	test   %al,%al
 83b:	0f 85 3a fd ff ff    	jne    57b <printf+0xa2>
    }
  }
}
 841:	90                   	nop
 842:	90                   	nop
 843:	c9                   	leave
 844:	c3                   	ret

0000000000000845 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 845:	f3 0f 1e fa          	endbr64
 849:	55                   	push   %rbp
 84a:	48 89 e5             	mov    %rsp,%rbp
 84d:	48 83 ec 18          	sub    $0x18,%rsp
 851:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 855:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 859:	48 83 e8 10          	sub    $0x10,%rax
 85d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 861:	48 8b 05 f8 04 00 00 	mov    0x4f8(%rip),%rax        # d60 <freep>
 868:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 86c:	eb 2f                	jmp    89d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 872:	48 8b 00             	mov    (%rax),%rax
 875:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 879:	72 17                	jb     892 <free+0x4d>
 87b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 87f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 883:	72 2f                	jb     8b4 <free+0x6f>
 885:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 889:	48 8b 00             	mov    (%rax),%rax
 88c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 890:	72 22                	jb     8b4 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 896:	48 8b 00             	mov    (%rax),%rax
 899:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 89d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a5:	73 c7                	jae    86e <free+0x29>
 8a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ab:	48 8b 00             	mov    (%rax),%rax
 8ae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8b2:	73 ba                	jae    86e <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b8:	8b 40 08             	mov    0x8(%rax),%eax
 8bb:	89 c0                	mov    %eax,%eax
 8bd:	48 c1 e0 04          	shl    $0x4,%rax
 8c1:	48 89 c2             	mov    %rax,%rdx
 8c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c8:	48 01 c2             	add    %rax,%rdx
 8cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8cf:	48 8b 00             	mov    (%rax),%rax
 8d2:	48 39 c2             	cmp    %rax,%rdx
 8d5:	75 2d                	jne    904 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8db:	8b 50 08             	mov    0x8(%rax),%edx
 8de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e2:	48 8b 00             	mov    (%rax),%rax
 8e5:	8b 40 08             	mov    0x8(%rax),%eax
 8e8:	01 c2                	add    %eax,%edx
 8ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ee:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f5:	48 8b 00             	mov    (%rax),%rax
 8f8:	48 8b 10             	mov    (%rax),%rdx
 8fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ff:	48 89 10             	mov    %rdx,(%rax)
 902:	eb 0e                	jmp    912 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 908:	48 8b 10             	mov    (%rax),%rdx
 90b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 916:	8b 40 08             	mov    0x8(%rax),%eax
 919:	89 c0                	mov    %eax,%eax
 91b:	48 c1 e0 04          	shl    $0x4,%rax
 91f:	48 89 c2             	mov    %rax,%rdx
 922:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 926:	48 01 d0             	add    %rdx,%rax
 929:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 92d:	75 27                	jne    956 <free+0x111>
    p->s.size += bp->s.size;
 92f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 933:	8b 50 08             	mov    0x8(%rax),%edx
 936:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93a:	8b 40 08             	mov    0x8(%rax),%eax
 93d:	01 c2                	add    %eax,%edx
 93f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 943:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94a:	48 8b 10             	mov    (%rax),%rdx
 94d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 951:	48 89 10             	mov    %rdx,(%rax)
 954:	eb 0b                	jmp    961 <free+0x11c>
  } else
    p->s.ptr = bp;
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 95e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 965:	48 89 05 f4 03 00 00 	mov    %rax,0x3f4(%rip)        # d60 <freep>
}
 96c:	90                   	nop
 96d:	c9                   	leave
 96e:	c3                   	ret

000000000000096f <morecore>:

static Header*
morecore(uint nu)
{
 96f:	f3 0f 1e fa          	endbr64
 973:	55                   	push   %rbp
 974:	48 89 e5             	mov    %rsp,%rbp
 977:	48 83 ec 20          	sub    $0x20,%rsp
 97b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 97e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 985:	77 07                	ja     98e <morecore+0x1f>
    nu = 4096;
 987:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 98e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 991:	c1 e0 04             	shl    $0x4,%eax
 994:	89 c7                	mov    %eax,%edi
 996:	e8 24 fa ff ff       	call   3bf <sbrk>
 99b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 99f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9a4:	75 07                	jne    9ad <morecore+0x3e>
    return 0;
 9a6:	b8 00 00 00 00       	mov    $0x0,%eax
 9ab:	eb 29                	jmp    9d6 <morecore+0x67>
  hp = (Header*)p;
 9ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9bc:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c3:	48 83 c0 10          	add    $0x10,%rax
 9c7:	48 89 c7             	mov    %rax,%rdi
 9ca:	e8 76 fe ff ff       	call   845 <free>
  return freep;
 9cf:	48 8b 05 8a 03 00 00 	mov    0x38a(%rip),%rax        # d60 <freep>
}
 9d6:	c9                   	leave
 9d7:	c3                   	ret

00000000000009d8 <malloc>:

void*
malloc(uint nbytes)
{
 9d8:	f3 0f 1e fa          	endbr64
 9dc:	55                   	push   %rbp
 9dd:	48 89 e5             	mov    %rsp,%rbp
 9e0:	48 83 ec 30          	sub    $0x30,%rsp
 9e4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9ea:	48 83 c0 0f          	add    $0xf,%rax
 9ee:	48 c1 e8 04          	shr    $0x4,%rax
 9f2:	83 c0 01             	add    $0x1,%eax
 9f5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 9f8:	48 8b 05 61 03 00 00 	mov    0x361(%rip),%rax        # d60 <freep>
 9ff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a03:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a08:	75 2b                	jne    a35 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a0a:	48 c7 45 f0 50 0d 00 	movq   $0xd50,-0x10(%rbp)
 a11:	00 
 a12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a16:	48 89 05 43 03 00 00 	mov    %rax,0x343(%rip)        # d60 <freep>
 a1d:	48 8b 05 3c 03 00 00 	mov    0x33c(%rip),%rax        # d60 <freep>
 a24:	48 89 05 25 03 00 00 	mov    %rax,0x325(%rip)        # d50 <base>
    base.s.size = 0;
 a2b:	c7 05 23 03 00 00 00 	movl   $0x0,0x323(%rip)        # d58 <base+0x8>
 a32:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a39:	48 8b 00             	mov    (%rax),%rax
 a3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a44:	8b 40 08             	mov    0x8(%rax),%eax
 a47:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a4a:	72 5f                	jb     aab <malloc+0xd3>
      if(p->s.size == nunits)
 a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a50:	8b 40 08             	mov    0x8(%rax),%eax
 a53:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a56:	75 10                	jne    a68 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5c:	48 8b 10             	mov    (%rax),%rdx
 a5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a63:	48 89 10             	mov    %rdx,(%rax)
 a66:	eb 2e                	jmp    a96 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	8b 40 08             	mov    0x8(%rax),%eax
 a6f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a72:	89 c2                	mov    %eax,%edx
 a74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a78:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	8b 40 08             	mov    0x8(%rax),%eax
 a82:	89 c0                	mov    %eax,%eax
 a84:	48 c1 e0 04          	shl    $0x4,%rax
 a88:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a90:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a93:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9a:	48 89 05 bf 02 00 00 	mov    %rax,0x2bf(%rip)        # d60 <freep>
      return (void*)(p + 1);
 aa1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa5:	48 83 c0 10          	add    $0x10,%rax
 aa9:	eb 41                	jmp    aec <malloc+0x114>
    }
    if(p == freep)
 aab:	48 8b 05 ae 02 00 00 	mov    0x2ae(%rip),%rax        # d60 <freep>
 ab2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ab6:	75 1c                	jne    ad4 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ab8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 abb:	89 c7                	mov    %eax,%edi
 abd:	e8 ad fe ff ff       	call   96f <morecore>
 ac2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ac6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 acb:	75 07                	jne    ad4 <malloc+0xfc>
        return 0;
 acd:	b8 00 00 00 00       	mov    $0x0,%eax
 ad2:	eb 18                	jmp    aec <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	48 8b 00             	mov    (%rax),%rax
 ae3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ae7:	e9 54 ff ff ff       	jmp    a40 <malloc+0x68>
  }
}
 aec:	c9                   	leave
 aed:	c3                   	ret
