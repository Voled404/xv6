
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

00000000000003ef <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ef:	f3 0f 1e fa          	endbr64
 3f3:	55                   	push   %rbp
 3f4:	48 89 e5             	mov    %rsp,%rbp
 3f7:	48 83 ec 10          	sub    $0x10,%rsp
 3fb:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3fe:	89 f0                	mov    %esi,%eax
 400:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 403:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 407:	8b 45 fc             	mov    -0x4(%rbp),%eax
 40a:	ba 01 00 00 00       	mov    $0x1,%edx
 40f:	48 89 ce             	mov    %rcx,%rsi
 412:	89 c7                	mov    %eax,%edi
 414:	e8 3e ff ff ff       	call   357 <write>
}
 419:	90                   	nop
 41a:	c9                   	leave
 41b:	c3                   	ret

000000000000041c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41c:	f3 0f 1e fa          	endbr64
 420:	55                   	push   %rbp
 421:	48 89 e5             	mov    %rsp,%rbp
 424:	48 83 ec 30          	sub    $0x30,%rsp
 428:	89 7d dc             	mov    %edi,-0x24(%rbp)
 42b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 42e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 431:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 434:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 43b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 43f:	74 17                	je     458 <printint+0x3c>
 441:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 445:	79 11                	jns    458 <printint+0x3c>
    neg = 1;
 447:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 44e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 451:	f7 d8                	neg    %eax
 453:	89 45 f4             	mov    %eax,-0xc(%rbp)
 456:	eb 06                	jmp    45e <printint+0x42>
  } else {
    x = xx;
 458:	8b 45 d8             	mov    -0x28(%rbp),%eax
 45b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 45e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 465:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 468:	8b 45 f4             	mov    -0xc(%rbp),%eax
 46b:	ba 00 00 00 00       	mov    $0x0,%edx
 470:	f7 f6                	div    %esi
 472:	89 d1                	mov    %edx,%ecx
 474:	8b 45 fc             	mov    -0x4(%rbp),%eax
 477:	8d 50 01             	lea    0x1(%rax),%edx
 47a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 47d:	89 ca                	mov    %ecx,%edx
 47f:	0f b6 92 40 0d 00 00 	movzbl 0xd40(%rdx),%edx
 486:	48 98                	cltq
 488:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 48c:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 48f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 492:	ba 00 00 00 00       	mov    $0x0,%edx
 497:	f7 f7                	div    %edi
 499:	89 45 f4             	mov    %eax,-0xc(%rbp)
 49c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4a0:	75 c3                	jne    465 <printint+0x49>
  if(neg)
 4a2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4a6:	74 2b                	je     4d3 <printint+0xb7>
    buf[i++] = '-';
 4a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ab:	8d 50 01             	lea    0x1(%rax),%edx
 4ae:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4b1:	48 98                	cltq
 4b3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4b8:	eb 19                	jmp    4d3 <printint+0xb7>
    putc(fd, buf[i]);
 4ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4bd:	48 98                	cltq
 4bf:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4c4:	0f be d0             	movsbl %al,%edx
 4c7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4ca:	89 d6                	mov    %edx,%esi
 4cc:	89 c7                	mov    %eax,%edi
 4ce:	e8 1c ff ff ff       	call   3ef <putc>
  while(--i >= 0)
 4d3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4db:	79 dd                	jns    4ba <printint+0x9e>
}
 4dd:	90                   	nop
 4de:	90                   	nop
 4df:	c9                   	leave
 4e0:	c3                   	ret

00000000000004e1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e1:	f3 0f 1e fa          	endbr64
 4e5:	55                   	push   %rbp
 4e6:	48 89 e5             	mov    %rsp,%rbp
 4e9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4f0:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4f6:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4fd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 504:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 50b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 512:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 519:	84 c0                	test   %al,%al
 51b:	74 20                	je     53d <printf+0x5c>
 51d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 521:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 525:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 529:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 52d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 531:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 535:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 539:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 53d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 544:	00 00 00 
 547:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 54e:	00 00 00 
 551:	48 8d 45 10          	lea    0x10(%rbp),%rax
 555:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 55c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 563:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 56a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 571:	00 00 00 
  for(i = 0; fmt[i]; i++){
 574:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 57b:	00 00 00 
 57e:	e9 a8 02 00 00       	jmp    82b <printf+0x34a>
    c = fmt[i] & 0xff;
 583:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 589:	48 63 d0             	movslq %eax,%rdx
 58c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 593:	48 01 d0             	add    %rdx,%rax
 596:	0f b6 00             	movzbl (%rax),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	25 ff 00 00 00       	and    $0xff,%eax
 5a1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5a7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5ae:	75 35                	jne    5e5 <printf+0x104>
      if(c == '%'){
 5b0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5b7:	75 0f                	jne    5c8 <printf+0xe7>
        state = '%';
 5b9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5c0:	00 00 00 
 5c3:	e9 5c 02 00 00       	jmp    824 <printf+0x343>
      } else {
        putc(fd, c);
 5c8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5ce:	0f be d0             	movsbl %al,%edx
 5d1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5d7:	89 d6                	mov    %edx,%esi
 5d9:	89 c7                	mov    %eax,%edi
 5db:	e8 0f fe ff ff       	call   3ef <putc>
 5e0:	e9 3f 02 00 00       	jmp    824 <printf+0x343>
      }
    } else if(state == '%'){
 5e5:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5ec:	0f 85 32 02 00 00    	jne    824 <printf+0x343>
      if(c == 'd'){
 5f2:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5f9:	75 5e                	jne    659 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 5fb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 601:	83 f8 2f             	cmp    $0x2f,%eax
 604:	77 23                	ja     629 <printf+0x148>
 606:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 60d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 613:	89 d2                	mov    %edx,%edx
 615:	48 01 d0             	add    %rdx,%rax
 618:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 61e:	83 c2 08             	add    $0x8,%edx
 621:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 627:	eb 12                	jmp    63b <printf+0x15a>
 629:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 630:	48 8d 50 08          	lea    0x8(%rax),%rdx
 634:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 63b:	8b 30                	mov    (%rax),%esi
 63d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 643:	b9 01 00 00 00       	mov    $0x1,%ecx
 648:	ba 0a 00 00 00       	mov    $0xa,%edx
 64d:	89 c7                	mov    %eax,%edi
 64f:	e8 c8 fd ff ff       	call   41c <printint>
 654:	e9 c1 01 00 00       	jmp    81a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 659:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 660:	74 09                	je     66b <printf+0x18a>
 662:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 669:	75 5e                	jne    6c9 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 66b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 671:	83 f8 2f             	cmp    $0x2f,%eax
 674:	77 23                	ja     699 <printf+0x1b8>
 676:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 67d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 683:	89 d2                	mov    %edx,%edx
 685:	48 01 d0             	add    %rdx,%rax
 688:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68e:	83 c2 08             	add    $0x8,%edx
 691:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 697:	eb 12                	jmp    6ab <printf+0x1ca>
 699:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ab:	8b 30                	mov    (%rax),%esi
 6ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6b8:	ba 10 00 00 00       	mov    $0x10,%edx
 6bd:	89 c7                	mov    %eax,%edi
 6bf:	e8 58 fd ff ff       	call   41c <printint>
 6c4:	e9 51 01 00 00       	jmp    81a <printf+0x339>
      } else if(c == 's'){
 6c9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6d0:	0f 85 98 00 00 00    	jne    76e <printf+0x28d>
        s = va_arg(ap, char*);
 6d6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6dc:	83 f8 2f             	cmp    $0x2f,%eax
 6df:	77 23                	ja     704 <printf+0x223>
 6e1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ee:	89 d2                	mov    %edx,%edx
 6f0:	48 01 d0             	add    %rdx,%rax
 6f3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f9:	83 c2 08             	add    $0x8,%edx
 6fc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 702:	eb 12                	jmp    716 <printf+0x235>
 704:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 70b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 70f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 716:	48 8b 00             	mov    (%rax),%rax
 719:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 720:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 727:	00 
 728:	75 31                	jne    75b <printf+0x27a>
          s = "(null)";
 72a:	48 c7 85 48 ff ff ff 	movq   $0xaf6,-0xb8(%rbp)
 731:	f6 0a 00 00 
        while(*s != 0){
 735:	eb 24                	jmp    75b <printf+0x27a>
          putc(fd, *s);
 737:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 73e:	0f b6 00             	movzbl (%rax),%eax
 741:	0f be d0             	movsbl %al,%edx
 744:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 74a:	89 d6                	mov    %edx,%esi
 74c:	89 c7                	mov    %eax,%edi
 74e:	e8 9c fc ff ff       	call   3ef <putc>
          s++;
 753:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 75a:	01 
        while(*s != 0){
 75b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 762:	0f b6 00             	movzbl (%rax),%eax
 765:	84 c0                	test   %al,%al
 767:	75 ce                	jne    737 <printf+0x256>
 769:	e9 ac 00 00 00       	jmp    81a <printf+0x339>
        }
      } else if(c == 'c'){
 76e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 775:	75 56                	jne    7cd <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 777:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 77d:	83 f8 2f             	cmp    $0x2f,%eax
 780:	77 23                	ja     7a5 <printf+0x2c4>
 782:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 789:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 78f:	89 d2                	mov    %edx,%edx
 791:	48 01 d0             	add    %rdx,%rax
 794:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 79a:	83 c2 08             	add    $0x8,%edx
 79d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7a3:	eb 12                	jmp    7b7 <printf+0x2d6>
 7a5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7ac:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7b0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7b7:	8b 00                	mov    (%rax),%eax
 7b9:	0f be d0             	movsbl %al,%edx
 7bc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7c2:	89 d6                	mov    %edx,%esi
 7c4:	89 c7                	mov    %eax,%edi
 7c6:	e8 24 fc ff ff       	call   3ef <putc>
 7cb:	eb 4d                	jmp    81a <printf+0x339>
      } else if(c == '%'){
 7cd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7d4:	75 1a                	jne    7f0 <printf+0x30f>
        putc(fd, c);
 7d6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7dc:	0f be d0             	movsbl %al,%edx
 7df:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e5:	89 d6                	mov    %edx,%esi
 7e7:	89 c7                	mov    %eax,%edi
 7e9:	e8 01 fc ff ff       	call   3ef <putc>
 7ee:	eb 2a                	jmp    81a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f6:	be 25 00 00 00       	mov    $0x25,%esi
 7fb:	89 c7                	mov    %eax,%edi
 7fd:	e8 ed fb ff ff       	call   3ef <putc>
        putc(fd, c);
 802:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 808:	0f be d0             	movsbl %al,%edx
 80b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 811:	89 d6                	mov    %edx,%esi
 813:	89 c7                	mov    %eax,%edi
 815:	e8 d5 fb ff ff       	call   3ef <putc>
      }
      state = 0;
 81a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 821:	00 00 00 
  for(i = 0; fmt[i]; i++){
 824:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 82b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 831:	48 63 d0             	movslq %eax,%rdx
 834:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 83b:	48 01 d0             	add    %rdx,%rax
 83e:	0f b6 00             	movzbl (%rax),%eax
 841:	84 c0                	test   %al,%al
 843:	0f 85 3a fd ff ff    	jne    583 <printf+0xa2>
    }
  }
}
 849:	90                   	nop
 84a:	90                   	nop
 84b:	c9                   	leave
 84c:	c3                   	ret

000000000000084d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84d:	f3 0f 1e fa          	endbr64
 851:	55                   	push   %rbp
 852:	48 89 e5             	mov    %rsp,%rbp
 855:	48 83 ec 18          	sub    $0x18,%rsp
 859:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 861:	48 83 e8 10          	sub    $0x10,%rax
 865:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 869:	48 8b 05 00 05 00 00 	mov    0x500(%rip),%rax        # d70 <freep>
 870:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 874:	eb 2f                	jmp    8a5 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 876:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 87a:	48 8b 00             	mov    (%rax),%rax
 87d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 881:	72 17                	jb     89a <free+0x4d>
 883:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 887:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 88b:	72 2f                	jb     8bc <free+0x6f>
 88d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 891:	48 8b 00             	mov    (%rax),%rax
 894:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 898:	72 22                	jb     8bc <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 89e:	48 8b 00             	mov    (%rax),%rax
 8a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ad:	73 c7                	jae    876 <free+0x29>
 8af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b3:	48 8b 00             	mov    (%rax),%rax
 8b6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ba:	73 ba                	jae    876 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c0:	8b 40 08             	mov    0x8(%rax),%eax
 8c3:	89 c0                	mov    %eax,%eax
 8c5:	48 c1 e0 04          	shl    $0x4,%rax
 8c9:	48 89 c2             	mov    %rax,%rdx
 8cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d0:	48 01 c2             	add    %rax,%rdx
 8d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d7:	48 8b 00             	mov    (%rax),%rax
 8da:	48 39 c2             	cmp    %rax,%rdx
 8dd:	75 2d                	jne    90c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e3:	8b 50 08             	mov    0x8(%rax),%edx
 8e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ea:	48 8b 00             	mov    (%rax),%rax
 8ed:	8b 40 08             	mov    0x8(%rax),%eax
 8f0:	01 c2                	add    %eax,%edx
 8f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f6:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fd:	48 8b 00             	mov    (%rax),%rax
 900:	48 8b 10             	mov    (%rax),%rdx
 903:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 907:	48 89 10             	mov    %rdx,(%rax)
 90a:	eb 0e                	jmp    91a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 90c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 910:	48 8b 10             	mov    (%rax),%rdx
 913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 917:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 91a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91e:	8b 40 08             	mov    0x8(%rax),%eax
 921:	89 c0                	mov    %eax,%eax
 923:	48 c1 e0 04          	shl    $0x4,%rax
 927:	48 89 c2             	mov    %rax,%rdx
 92a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92e:	48 01 d0             	add    %rdx,%rax
 931:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 935:	75 27                	jne    95e <free+0x111>
    p->s.size += bp->s.size;
 937:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93b:	8b 50 08             	mov    0x8(%rax),%edx
 93e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 942:	8b 40 08             	mov    0x8(%rax),%eax
 945:	01 c2                	add    %eax,%edx
 947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 94e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 952:	48 8b 10             	mov    (%rax),%rdx
 955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 959:	48 89 10             	mov    %rdx,(%rax)
 95c:	eb 0b                	jmp    969 <free+0x11c>
  } else
    p->s.ptr = bp;
 95e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 962:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 966:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 89 05 fc 03 00 00 	mov    %rax,0x3fc(%rip)        # d70 <freep>
}
 974:	90                   	nop
 975:	c9                   	leave
 976:	c3                   	ret

0000000000000977 <morecore>:

static Header*
morecore(uint nu)
{
 977:	f3 0f 1e fa          	endbr64
 97b:	55                   	push   %rbp
 97c:	48 89 e5             	mov    %rsp,%rbp
 97f:	48 83 ec 20          	sub    $0x20,%rsp
 983:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 986:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 98d:	77 07                	ja     996 <morecore+0x1f>
    nu = 4096;
 98f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 996:	8b 45 ec             	mov    -0x14(%rbp),%eax
 999:	c1 e0 04             	shl    $0x4,%eax
 99c:	89 c7                	mov    %eax,%edi
 99e:	e8 1c fa ff ff       	call   3bf <sbrk>
 9a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9a7:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9ac:	75 07                	jne    9b5 <morecore+0x3e>
    return 0;
 9ae:	b8 00 00 00 00       	mov    $0x0,%eax
 9b3:	eb 29                	jmp    9de <morecore+0x67>
  hp = (Header*)p;
 9b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9c4:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9cb:	48 83 c0 10          	add    $0x10,%rax
 9cf:	48 89 c7             	mov    %rax,%rdi
 9d2:	e8 76 fe ff ff       	call   84d <free>
  return freep;
 9d7:	48 8b 05 92 03 00 00 	mov    0x392(%rip),%rax        # d70 <freep>
}
 9de:	c9                   	leave
 9df:	c3                   	ret

00000000000009e0 <malloc>:

void*
malloc(uint nbytes)
{
 9e0:	f3 0f 1e fa          	endbr64
 9e4:	55                   	push   %rbp
 9e5:	48 89 e5             	mov    %rsp,%rbp
 9e8:	48 83 ec 30          	sub    $0x30,%rsp
 9ec:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ef:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9f2:	48 83 c0 0f          	add    $0xf,%rax
 9f6:	48 c1 e8 04          	shr    $0x4,%rax
 9fa:	83 c0 01             	add    $0x1,%eax
 9fd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a00:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # d70 <freep>
 a07:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a0b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a10:	75 2b                	jne    a3d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a12:	48 c7 45 f0 60 0d 00 	movq   $0xd60,-0x10(%rbp)
 a19:	00 
 a1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1e:	48 89 05 4b 03 00 00 	mov    %rax,0x34b(%rip)        # d70 <freep>
 a25:	48 8b 05 44 03 00 00 	mov    0x344(%rip),%rax        # d70 <freep>
 a2c:	48 89 05 2d 03 00 00 	mov    %rax,0x32d(%rip)        # d60 <base>
    base.s.size = 0;
 a33:	c7 05 2b 03 00 00 00 	movl   $0x0,0x32b(%rip)        # d68 <base+0x8>
 a3a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a41:	48 8b 00             	mov    (%rax),%rax
 a44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4c:	8b 40 08             	mov    0x8(%rax),%eax
 a4f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a52:	72 5f                	jb     ab3 <malloc+0xd3>
      if(p->s.size == nunits)
 a54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a58:	8b 40 08             	mov    0x8(%rax),%eax
 a5b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a5e:	75 10                	jne    a70 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a64:	48 8b 10             	mov    (%rax),%rdx
 a67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a6b:	48 89 10             	mov    %rdx,(%rax)
 a6e:	eb 2e                	jmp    a9e <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a74:	8b 40 08             	mov    0x8(%rax),%eax
 a77:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a7a:	89 c2                	mov    %eax,%edx
 a7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a80:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a87:	8b 40 08             	mov    0x8(%rax),%eax
 a8a:	89 c0                	mov    %eax,%eax
 a8c:	48 c1 e0 04          	shl    $0x4,%rax
 a90:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a98:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a9b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa2:	48 89 05 c7 02 00 00 	mov    %rax,0x2c7(%rip)        # d70 <freep>
      return (void*)(p + 1);
 aa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aad:	48 83 c0 10          	add    $0x10,%rax
 ab1:	eb 41                	jmp    af4 <malloc+0x114>
    }
    if(p == freep)
 ab3:	48 8b 05 b6 02 00 00 	mov    0x2b6(%rip),%rax        # d70 <freep>
 aba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 abe:	75 1c                	jne    adc <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ac0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ac3:	89 c7                	mov    %eax,%edi
 ac5:	e8 ad fe ff ff       	call   977 <morecore>
 aca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ace:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ad3:	75 07                	jne    adc <malloc+0xfc>
        return 0;
 ad5:	b8 00 00 00 00       	mov    $0x0,%eax
 ada:	eb 18                	jmp    af4 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae8:	48 8b 00             	mov    (%rax),%rax
 aeb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aef:	e9 54 ff ff ff       	jmp    a48 <malloc+0x68>
  }
}
 af4:	c9                   	leave
 af5:	c3                   	ret
