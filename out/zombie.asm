
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

00000000000003e7 <getfavnum>:
SYSCALL(getfavnum)
 3e7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <halt>:
SYSCALL(halt)
 3ef:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f7:	f3 0f 1e fa          	endbr64
 3fb:	55                   	push   %rbp
 3fc:	48 89 e5             	mov    %rsp,%rbp
 3ff:	48 83 ec 10          	sub    $0x10,%rsp
 403:	89 7d fc             	mov    %edi,-0x4(%rbp)
 406:	89 f0                	mov    %esi,%eax
 408:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 40b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 40f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 412:	ba 01 00 00 00       	mov    $0x1,%edx
 417:	48 89 ce             	mov    %rcx,%rsi
 41a:	89 c7                	mov    %eax,%edi
 41c:	e8 36 ff ff ff       	call   357 <write>
}
 421:	90                   	nop
 422:	c9                   	leave
 423:	c3                   	ret

0000000000000424 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 424:	f3 0f 1e fa          	endbr64
 428:	55                   	push   %rbp
 429:	48 89 e5             	mov    %rsp,%rbp
 42c:	48 83 ec 30          	sub    $0x30,%rsp
 430:	89 7d dc             	mov    %edi,-0x24(%rbp)
 433:	89 75 d8             	mov    %esi,-0x28(%rbp)
 436:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 439:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 43c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 443:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 447:	74 17                	je     460 <printint+0x3c>
 449:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 44d:	79 11                	jns    460 <printint+0x3c>
    neg = 1;
 44f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 456:	8b 45 d8             	mov    -0x28(%rbp),%eax
 459:	f7 d8                	neg    %eax
 45b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 45e:	eb 06                	jmp    466 <printint+0x42>
  } else {
    x = xx;
 460:	8b 45 d8             	mov    -0x28(%rbp),%eax
 463:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 466:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 46d:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 470:	8b 45 f4             	mov    -0xc(%rbp),%eax
 473:	ba 00 00 00 00       	mov    $0x0,%edx
 478:	f7 f6                	div    %esi
 47a:	89 d1                	mov    %edx,%ecx
 47c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 47f:	8d 50 01             	lea    0x1(%rax),%edx
 482:	89 55 fc             	mov    %edx,-0x4(%rbp)
 485:	89 ca                	mov    %ecx,%edx
 487:	0f b6 92 40 0d 00 00 	movzbl 0xd40(%rdx),%edx
 48e:	48 98                	cltq
 490:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 494:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 497:	8b 45 f4             	mov    -0xc(%rbp),%eax
 49a:	ba 00 00 00 00       	mov    $0x0,%edx
 49f:	f7 f7                	div    %edi
 4a1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4a8:	75 c3                	jne    46d <printint+0x49>
  if(neg)
 4aa:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4ae:	74 2b                	je     4db <printint+0xb7>
    buf[i++] = '-';
 4b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4b3:	8d 50 01             	lea    0x1(%rax),%edx
 4b6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4b9:	48 98                	cltq
 4bb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4c0:	eb 19                	jmp    4db <printint+0xb7>
    putc(fd, buf[i]);
 4c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c5:	48 98                	cltq
 4c7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4cc:	0f be d0             	movsbl %al,%edx
 4cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4d2:	89 d6                	mov    %edx,%esi
 4d4:	89 c7                	mov    %eax,%edi
 4d6:	e8 1c ff ff ff       	call   3f7 <putc>
  while(--i >= 0)
 4db:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4e3:	79 dd                	jns    4c2 <printint+0x9e>
}
 4e5:	90                   	nop
 4e6:	90                   	nop
 4e7:	c9                   	leave
 4e8:	c3                   	ret

00000000000004e9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e9:	f3 0f 1e fa          	endbr64
 4ed:	55                   	push   %rbp
 4ee:	48 89 e5             	mov    %rsp,%rbp
 4f1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4f8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4fe:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 505:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 50c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 513:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 51a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 521:	84 c0                	test   %al,%al
 523:	74 20                	je     545 <printf+0x5c>
 525:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 529:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 52d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 531:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 535:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 539:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 53d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 541:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 545:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 54c:	00 00 00 
 54f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 556:	00 00 00 
 559:	48 8d 45 10          	lea    0x10(%rbp),%rax
 55d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 564:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 56b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 572:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 579:	00 00 00 
  for(i = 0; fmt[i]; i++){
 57c:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 583:	00 00 00 
 586:	e9 a8 02 00 00       	jmp    833 <printf+0x34a>
    c = fmt[i] & 0xff;
 58b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 591:	48 63 d0             	movslq %eax,%rdx
 594:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 59b:	48 01 d0             	add    %rdx,%rax
 59e:	0f b6 00             	movzbl (%rax),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	25 ff 00 00 00       	and    $0xff,%eax
 5a9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5af:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5b6:	75 35                	jne    5ed <printf+0x104>
      if(c == '%'){
 5b8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5bf:	75 0f                	jne    5d0 <printf+0xe7>
        state = '%';
 5c1:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5c8:	00 00 00 
 5cb:	e9 5c 02 00 00       	jmp    82c <printf+0x343>
      } else {
        putc(fd, c);
 5d0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5d6:	0f be d0             	movsbl %al,%edx
 5d9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5df:	89 d6                	mov    %edx,%esi
 5e1:	89 c7                	mov    %eax,%edi
 5e3:	e8 0f fe ff ff       	call   3f7 <putc>
 5e8:	e9 3f 02 00 00       	jmp    82c <printf+0x343>
      }
    } else if(state == '%'){
 5ed:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5f4:	0f 85 32 02 00 00    	jne    82c <printf+0x343>
      if(c == 'd'){
 5fa:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 601:	75 5e                	jne    661 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 603:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 609:	83 f8 2f             	cmp    $0x2f,%eax
 60c:	77 23                	ja     631 <printf+0x148>
 60e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 615:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 61b:	89 d2                	mov    %edx,%edx
 61d:	48 01 d0             	add    %rdx,%rax
 620:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 626:	83 c2 08             	add    $0x8,%edx
 629:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 62f:	eb 12                	jmp    643 <printf+0x15a>
 631:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 638:	48 8d 50 08          	lea    0x8(%rax),%rdx
 63c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 643:	8b 30                	mov    (%rax),%esi
 645:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 64b:	b9 01 00 00 00       	mov    $0x1,%ecx
 650:	ba 0a 00 00 00       	mov    $0xa,%edx
 655:	89 c7                	mov    %eax,%edi
 657:	e8 c8 fd ff ff       	call   424 <printint>
 65c:	e9 c1 01 00 00       	jmp    822 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 661:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 668:	74 09                	je     673 <printf+0x18a>
 66a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 671:	75 5e                	jne    6d1 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 673:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 679:	83 f8 2f             	cmp    $0x2f,%eax
 67c:	77 23                	ja     6a1 <printf+0x1b8>
 67e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 685:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68b:	89 d2                	mov    %edx,%edx
 68d:	48 01 d0             	add    %rdx,%rax
 690:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 696:	83 c2 08             	add    $0x8,%edx
 699:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 69f:	eb 12                	jmp    6b3 <printf+0x1ca>
 6a1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6a8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6ac:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6b3:	8b 30                	mov    (%rax),%esi
 6b5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6bb:	b9 00 00 00 00       	mov    $0x0,%ecx
 6c0:	ba 10 00 00 00       	mov    $0x10,%edx
 6c5:	89 c7                	mov    %eax,%edi
 6c7:	e8 58 fd ff ff       	call   424 <printint>
 6cc:	e9 51 01 00 00       	jmp    822 <printf+0x339>
      } else if(c == 's'){
 6d1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6d8:	0f 85 98 00 00 00    	jne    776 <printf+0x28d>
        s = va_arg(ap, char*);
 6de:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e4:	83 f8 2f             	cmp    $0x2f,%eax
 6e7:	77 23                	ja     70c <printf+0x223>
 6e9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f6:	89 d2                	mov    %edx,%edx
 6f8:	48 01 d0             	add    %rdx,%rax
 6fb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 701:	83 c2 08             	add    $0x8,%edx
 704:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 70a:	eb 12                	jmp    71e <printf+0x235>
 70c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 713:	48 8d 50 08          	lea    0x8(%rax),%rdx
 717:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 71e:	48 8b 00             	mov    (%rax),%rax
 721:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 728:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 72f:	00 
 730:	75 31                	jne    763 <printf+0x27a>
          s = "(null)";
 732:	48 c7 85 48 ff ff ff 	movq   $0xafe,-0xb8(%rbp)
 739:	fe 0a 00 00 
        while(*s != 0){
 73d:	eb 24                	jmp    763 <printf+0x27a>
          putc(fd, *s);
 73f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 746:	0f b6 00             	movzbl (%rax),%eax
 749:	0f be d0             	movsbl %al,%edx
 74c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 752:	89 d6                	mov    %edx,%esi
 754:	89 c7                	mov    %eax,%edi
 756:	e8 9c fc ff ff       	call   3f7 <putc>
          s++;
 75b:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 762:	01 
        while(*s != 0){
 763:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 76a:	0f b6 00             	movzbl (%rax),%eax
 76d:	84 c0                	test   %al,%al
 76f:	75 ce                	jne    73f <printf+0x256>
 771:	e9 ac 00 00 00       	jmp    822 <printf+0x339>
        }
      } else if(c == 'c'){
 776:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 77d:	75 56                	jne    7d5 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 77f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 785:	83 f8 2f             	cmp    $0x2f,%eax
 788:	77 23                	ja     7ad <printf+0x2c4>
 78a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 791:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 797:	89 d2                	mov    %edx,%edx
 799:	48 01 d0             	add    %rdx,%rax
 79c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a2:	83 c2 08             	add    $0x8,%edx
 7a5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7ab:	eb 12                	jmp    7bf <printf+0x2d6>
 7ad:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7b4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7b8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7bf:	8b 00                	mov    (%rax),%eax
 7c1:	0f be d0             	movsbl %al,%edx
 7c4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ca:	89 d6                	mov    %edx,%esi
 7cc:	89 c7                	mov    %eax,%edi
 7ce:	e8 24 fc ff ff       	call   3f7 <putc>
 7d3:	eb 4d                	jmp    822 <printf+0x339>
      } else if(c == '%'){
 7d5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7dc:	75 1a                	jne    7f8 <printf+0x30f>
        putc(fd, c);
 7de:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7e4:	0f be d0             	movsbl %al,%edx
 7e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ed:	89 d6                	mov    %edx,%esi
 7ef:	89 c7                	mov    %eax,%edi
 7f1:	e8 01 fc ff ff       	call   3f7 <putc>
 7f6:	eb 2a                	jmp    822 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7fe:	be 25 00 00 00       	mov    $0x25,%esi
 803:	89 c7                	mov    %eax,%edi
 805:	e8 ed fb ff ff       	call   3f7 <putc>
        putc(fd, c);
 80a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 810:	0f be d0             	movsbl %al,%edx
 813:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 819:	89 d6                	mov    %edx,%esi
 81b:	89 c7                	mov    %eax,%edi
 81d:	e8 d5 fb ff ff       	call   3f7 <putc>
      }
      state = 0;
 822:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 829:	00 00 00 
  for(i = 0; fmt[i]; i++){
 82c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 833:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 839:	48 63 d0             	movslq %eax,%rdx
 83c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 843:	48 01 d0             	add    %rdx,%rax
 846:	0f b6 00             	movzbl (%rax),%eax
 849:	84 c0                	test   %al,%al
 84b:	0f 85 3a fd ff ff    	jne    58b <printf+0xa2>
    }
  }
}
 851:	90                   	nop
 852:	90                   	nop
 853:	c9                   	leave
 854:	c3                   	ret

0000000000000855 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 855:	f3 0f 1e fa          	endbr64
 859:	55                   	push   %rbp
 85a:	48 89 e5             	mov    %rsp,%rbp
 85d:	48 83 ec 18          	sub    $0x18,%rsp
 861:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 865:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 869:	48 83 e8 10          	sub    $0x10,%rax
 86d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 871:	48 8b 05 f8 04 00 00 	mov    0x4f8(%rip),%rax        # d70 <freep>
 878:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 87c:	eb 2f                	jmp    8ad <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 882:	48 8b 00             	mov    (%rax),%rax
 885:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 889:	72 17                	jb     8a2 <free+0x4d>
 88b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 88f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 893:	72 2f                	jb     8c4 <free+0x6f>
 895:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 899:	48 8b 00             	mov    (%rax),%rax
 89c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a0:	72 22                	jb     8c4 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a6:	48 8b 00             	mov    (%rax),%rax
 8a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b5:	73 c7                	jae    87e <free+0x29>
 8b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8bb:	48 8b 00             	mov    (%rax),%rax
 8be:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c2:	73 ba                	jae    87e <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c8:	8b 40 08             	mov    0x8(%rax),%eax
 8cb:	89 c0                	mov    %eax,%eax
 8cd:	48 c1 e0 04          	shl    $0x4,%rax
 8d1:	48 89 c2             	mov    %rax,%rdx
 8d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d8:	48 01 c2             	add    %rax,%rdx
 8db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8df:	48 8b 00             	mov    (%rax),%rax
 8e2:	48 39 c2             	cmp    %rax,%rdx
 8e5:	75 2d                	jne    914 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8eb:	8b 50 08             	mov    0x8(%rax),%edx
 8ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f2:	48 8b 00             	mov    (%rax),%rax
 8f5:	8b 40 08             	mov    0x8(%rax),%eax
 8f8:	01 c2                	add    %eax,%edx
 8fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fe:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 901:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 905:	48 8b 00             	mov    (%rax),%rax
 908:	48 8b 10             	mov    (%rax),%rdx
 90b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90f:	48 89 10             	mov    %rdx,(%rax)
 912:	eb 0e                	jmp    922 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 914:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 918:	48 8b 10             	mov    (%rax),%rdx
 91b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 922:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 926:	8b 40 08             	mov    0x8(%rax),%eax
 929:	89 c0                	mov    %eax,%eax
 92b:	48 c1 e0 04          	shl    $0x4,%rax
 92f:	48 89 c2             	mov    %rax,%rdx
 932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 936:	48 01 d0             	add    %rdx,%rax
 939:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 93d:	75 27                	jne    966 <free+0x111>
    p->s.size += bp->s.size;
 93f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 943:	8b 50 08             	mov    0x8(%rax),%edx
 946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94a:	8b 40 08             	mov    0x8(%rax),%eax
 94d:	01 c2                	add    %eax,%edx
 94f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 953:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95a:	48 8b 10             	mov    (%rax),%rdx
 95d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 961:	48 89 10             	mov    %rdx,(%rax)
 964:	eb 0b                	jmp    971 <free+0x11c>
  } else
    p->s.ptr = bp;
 966:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 96e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 971:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 975:	48 89 05 f4 03 00 00 	mov    %rax,0x3f4(%rip)        # d70 <freep>
}
 97c:	90                   	nop
 97d:	c9                   	leave
 97e:	c3                   	ret

000000000000097f <morecore>:

static Header*
morecore(uint nu)
{
 97f:	f3 0f 1e fa          	endbr64
 983:	55                   	push   %rbp
 984:	48 89 e5             	mov    %rsp,%rbp
 987:	48 83 ec 20          	sub    $0x20,%rsp
 98b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 98e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 995:	77 07                	ja     99e <morecore+0x1f>
    nu = 4096;
 997:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 99e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9a1:	c1 e0 04             	shl    $0x4,%eax
 9a4:	89 c7                	mov    %eax,%edi
 9a6:	e8 14 fa ff ff       	call   3bf <sbrk>
 9ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9af:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9b4:	75 07                	jne    9bd <morecore+0x3e>
    return 0;
 9b6:	b8 00 00 00 00       	mov    $0x0,%eax
 9bb:	eb 29                	jmp    9e6 <morecore+0x67>
  hp = (Header*)p;
 9bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9cc:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d3:	48 83 c0 10          	add    $0x10,%rax
 9d7:	48 89 c7             	mov    %rax,%rdi
 9da:	e8 76 fe ff ff       	call   855 <free>
  return freep;
 9df:	48 8b 05 8a 03 00 00 	mov    0x38a(%rip),%rax        # d70 <freep>
}
 9e6:	c9                   	leave
 9e7:	c3                   	ret

00000000000009e8 <malloc>:

void*
malloc(uint nbytes)
{
 9e8:	f3 0f 1e fa          	endbr64
 9ec:	55                   	push   %rbp
 9ed:	48 89 e5             	mov    %rsp,%rbp
 9f0:	48 83 ec 30          	sub    $0x30,%rsp
 9f4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9fa:	48 83 c0 0f          	add    $0xf,%rax
 9fe:	48 c1 e8 04          	shr    $0x4,%rax
 a02:	83 c0 01             	add    $0x1,%eax
 a05:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a08:	48 8b 05 61 03 00 00 	mov    0x361(%rip),%rax        # d70 <freep>
 a0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a13:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a18:	75 2b                	jne    a45 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a1a:	48 c7 45 f0 60 0d 00 	movq   $0xd60,-0x10(%rbp)
 a21:	00 
 a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a26:	48 89 05 43 03 00 00 	mov    %rax,0x343(%rip)        # d70 <freep>
 a2d:	48 8b 05 3c 03 00 00 	mov    0x33c(%rip),%rax        # d70 <freep>
 a34:	48 89 05 25 03 00 00 	mov    %rax,0x325(%rip)        # d60 <base>
    base.s.size = 0;
 a3b:	c7 05 23 03 00 00 00 	movl   $0x0,0x323(%rip)        # d68 <base+0x8>
 a42:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a49:	48 8b 00             	mov    (%rax),%rax
 a4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a54:	8b 40 08             	mov    0x8(%rax),%eax
 a57:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a5a:	72 5f                	jb     abb <malloc+0xd3>
      if(p->s.size == nunits)
 a5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a60:	8b 40 08             	mov    0x8(%rax),%eax
 a63:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a66:	75 10                	jne    a78 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	48 8b 10             	mov    (%rax),%rdx
 a6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a73:	48 89 10             	mov    %rdx,(%rax)
 a76:	eb 2e                	jmp    aa6 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7c:	8b 40 08             	mov    0x8(%rax),%eax
 a7f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a82:	89 c2                	mov    %eax,%edx
 a84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a88:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8f:	8b 40 08             	mov    0x8(%rax),%eax
 a92:	89 c0                	mov    %eax,%eax
 a94:	48 c1 e0 04          	shl    $0x4,%rax
 a98:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aa3:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aaa:	48 89 05 bf 02 00 00 	mov    %rax,0x2bf(%rip)        # d70 <freep>
      return (void*)(p + 1);
 ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab5:	48 83 c0 10          	add    $0x10,%rax
 ab9:	eb 41                	jmp    afc <malloc+0x114>
    }
    if(p == freep)
 abb:	48 8b 05 ae 02 00 00 	mov    0x2ae(%rip),%rax        # d70 <freep>
 ac2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ac6:	75 1c                	jne    ae4 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ac8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 acb:	89 c7                	mov    %eax,%edi
 acd:	e8 ad fe ff ff       	call   97f <morecore>
 ad2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ad6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 adb:	75 07                	jne    ae4 <malloc+0xfc>
        return 0;
 add:	b8 00 00 00 00       	mov    $0x0,%eax
 ae2:	eb 18                	jmp    afc <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	48 8b 00             	mov    (%rax),%rax
 af3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 af7:	e9 54 ff ff ff       	jmp    a50 <malloc+0x68>
  }
}
 afc:	c9                   	leave
 afd:	c3                   	ret
