
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

00000000000003f7 <getcount>:
SYSCALL(getcount)
 3f7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <killrandom>:
SYSCALL(killrandom)
 3ff:	b8 1f 00 00 00       	mov    $0x1f,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 407:	f3 0f 1e fa          	endbr64
 40b:	55                   	push   %rbp
 40c:	48 89 e5             	mov    %rsp,%rbp
 40f:	48 83 ec 10          	sub    $0x10,%rsp
 413:	89 7d fc             	mov    %edi,-0x4(%rbp)
 416:	89 f0                	mov    %esi,%eax
 418:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 41b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 41f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 422:	ba 01 00 00 00       	mov    $0x1,%edx
 427:	48 89 ce             	mov    %rcx,%rsi
 42a:	89 c7                	mov    %eax,%edi
 42c:	e8 26 ff ff ff       	call   357 <write>
}
 431:	90                   	nop
 432:	c9                   	leave
 433:	c3                   	ret

0000000000000434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 434:	f3 0f 1e fa          	endbr64
 438:	55                   	push   %rbp
 439:	48 89 e5             	mov    %rsp,%rbp
 43c:	48 83 ec 30          	sub    $0x30,%rsp
 440:	89 7d dc             	mov    %edi,-0x24(%rbp)
 443:	89 75 d8             	mov    %esi,-0x28(%rbp)
 446:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 449:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 44c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 453:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 457:	74 17                	je     470 <printint+0x3c>
 459:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 45d:	79 11                	jns    470 <printint+0x3c>
    neg = 1;
 45f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 466:	8b 45 d8             	mov    -0x28(%rbp),%eax
 469:	f7 d8                	neg    %eax
 46b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 46e:	eb 06                	jmp    476 <printint+0x42>
  } else {
    x = xx;
 470:	8b 45 d8             	mov    -0x28(%rbp),%eax
 473:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 476:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 47d:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 480:	8b 45 f4             	mov    -0xc(%rbp),%eax
 483:	ba 00 00 00 00       	mov    $0x0,%edx
 488:	f7 f6                	div    %esi
 48a:	89 d1                	mov    %edx,%ecx
 48c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48f:	8d 50 01             	lea    0x1(%rax),%edx
 492:	89 55 fc             	mov    %edx,-0x4(%rbp)
 495:	89 ca                	mov    %ecx,%edx
 497:	0f b6 92 50 0d 00 00 	movzbl 0xd50(%rdx),%edx
 49e:	48 98                	cltq
 4a0:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4a4:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4a7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4aa:	ba 00 00 00 00       	mov    $0x0,%edx
 4af:	f7 f7                	div    %edi
 4b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4b8:	75 c3                	jne    47d <printint+0x49>
  if(neg)
 4ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4be:	74 2b                	je     4eb <printint+0xb7>
    buf[i++] = '-';
 4c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c3:	8d 50 01             	lea    0x1(%rax),%edx
 4c6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c9:	48 98                	cltq
 4cb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4d0:	eb 19                	jmp    4eb <printint+0xb7>
    putc(fd, buf[i]);
 4d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d5:	48 98                	cltq
 4d7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4dc:	0f be d0             	movsbl %al,%edx
 4df:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4e2:	89 d6                	mov    %edx,%esi
 4e4:	89 c7                	mov    %eax,%edi
 4e6:	e8 1c ff ff ff       	call   407 <putc>
  while(--i >= 0)
 4eb:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4f3:	79 dd                	jns    4d2 <printint+0x9e>
}
 4f5:	90                   	nop
 4f6:	90                   	nop
 4f7:	c9                   	leave
 4f8:	c3                   	ret

00000000000004f9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f9:	f3 0f 1e fa          	endbr64
 4fd:	55                   	push   %rbp
 4fe:	48 89 e5             	mov    %rsp,%rbp
 501:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 508:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 50e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 515:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 51c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 523:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 52a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 531:	84 c0                	test   %al,%al
 533:	74 20                	je     555 <printf+0x5c>
 535:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 539:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 53d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 541:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 545:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 549:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 54d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 551:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 555:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 55c:	00 00 00 
 55f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 566:	00 00 00 
 569:	48 8d 45 10          	lea    0x10(%rbp),%rax
 56d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 574:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 57b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 582:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 589:	00 00 00 
  for(i = 0; fmt[i]; i++){
 58c:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 593:	00 00 00 
 596:	e9 a8 02 00 00       	jmp    843 <printf+0x34a>
    c = fmt[i] & 0xff;
 59b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5a1:	48 63 d0             	movslq %eax,%rdx
 5a4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5ab:	48 01 d0             	add    %rdx,%rax
 5ae:	0f b6 00             	movzbl (%rax),%eax
 5b1:	0f be c0             	movsbl %al,%eax
 5b4:	25 ff 00 00 00       	and    $0xff,%eax
 5b9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5bf:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5c6:	75 35                	jne    5fd <printf+0x104>
      if(c == '%'){
 5c8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5cf:	75 0f                	jne    5e0 <printf+0xe7>
        state = '%';
 5d1:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5d8:	00 00 00 
 5db:	e9 5c 02 00 00       	jmp    83c <printf+0x343>
      } else {
        putc(fd, c);
 5e0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5e6:	0f be d0             	movsbl %al,%edx
 5e9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5ef:	89 d6                	mov    %edx,%esi
 5f1:	89 c7                	mov    %eax,%edi
 5f3:	e8 0f fe ff ff       	call   407 <putc>
 5f8:	e9 3f 02 00 00       	jmp    83c <printf+0x343>
      }
    } else if(state == '%'){
 5fd:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 604:	0f 85 32 02 00 00    	jne    83c <printf+0x343>
      if(c == 'd'){
 60a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 611:	75 5e                	jne    671 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 613:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 619:	83 f8 2f             	cmp    $0x2f,%eax
 61c:	77 23                	ja     641 <printf+0x148>
 61e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 625:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 62b:	89 d2                	mov    %edx,%edx
 62d:	48 01 d0             	add    %rdx,%rax
 630:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 636:	83 c2 08             	add    $0x8,%edx
 639:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 63f:	eb 12                	jmp    653 <printf+0x15a>
 641:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 648:	48 8d 50 08          	lea    0x8(%rax),%rdx
 64c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 653:	8b 30                	mov    (%rax),%esi
 655:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 65b:	b9 01 00 00 00       	mov    $0x1,%ecx
 660:	ba 0a 00 00 00       	mov    $0xa,%edx
 665:	89 c7                	mov    %eax,%edi
 667:	e8 c8 fd ff ff       	call   434 <printint>
 66c:	e9 c1 01 00 00       	jmp    832 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 671:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 678:	74 09                	je     683 <printf+0x18a>
 67a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 681:	75 5e                	jne    6e1 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 683:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 689:	83 f8 2f             	cmp    $0x2f,%eax
 68c:	77 23                	ja     6b1 <printf+0x1b8>
 68e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 695:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69b:	89 d2                	mov    %edx,%edx
 69d:	48 01 d0             	add    %rdx,%rax
 6a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a6:	83 c2 08             	add    $0x8,%edx
 6a9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6af:	eb 12                	jmp    6c3 <printf+0x1ca>
 6b1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6bc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6c3:	8b 30                	mov    (%rax),%esi
 6c5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6cb:	b9 00 00 00 00       	mov    $0x0,%ecx
 6d0:	ba 10 00 00 00       	mov    $0x10,%edx
 6d5:	89 c7                	mov    %eax,%edi
 6d7:	e8 58 fd ff ff       	call   434 <printint>
 6dc:	e9 51 01 00 00       	jmp    832 <printf+0x339>
      } else if(c == 's'){
 6e1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6e8:	0f 85 98 00 00 00    	jne    786 <printf+0x28d>
        s = va_arg(ap, char*);
 6ee:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f4:	83 f8 2f             	cmp    $0x2f,%eax
 6f7:	77 23                	ja     71c <printf+0x223>
 6f9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 700:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 706:	89 d2                	mov    %edx,%edx
 708:	48 01 d0             	add    %rdx,%rax
 70b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 711:	83 c2 08             	add    $0x8,%edx
 714:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 71a:	eb 12                	jmp    72e <printf+0x235>
 71c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 723:	48 8d 50 08          	lea    0x8(%rax),%rdx
 727:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 72e:	48 8b 00             	mov    (%rax),%rax
 731:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 738:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 73f:	00 
 740:	75 31                	jne    773 <printf+0x27a>
          s = "(null)";
 742:	48 c7 85 48 ff ff ff 	movq   $0xb0e,-0xb8(%rbp)
 749:	0e 0b 00 00 
        while(*s != 0){
 74d:	eb 24                	jmp    773 <printf+0x27a>
          putc(fd, *s);
 74f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 756:	0f b6 00             	movzbl (%rax),%eax
 759:	0f be d0             	movsbl %al,%edx
 75c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 762:	89 d6                	mov    %edx,%esi
 764:	89 c7                	mov    %eax,%edi
 766:	e8 9c fc ff ff       	call   407 <putc>
          s++;
 76b:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 772:	01 
        while(*s != 0){
 773:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 77a:	0f b6 00             	movzbl (%rax),%eax
 77d:	84 c0                	test   %al,%al
 77f:	75 ce                	jne    74f <printf+0x256>
 781:	e9 ac 00 00 00       	jmp    832 <printf+0x339>
        }
      } else if(c == 'c'){
 786:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 78d:	75 56                	jne    7e5 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 78f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 795:	83 f8 2f             	cmp    $0x2f,%eax
 798:	77 23                	ja     7bd <printf+0x2c4>
 79a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7a1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a7:	89 d2                	mov    %edx,%edx
 7a9:	48 01 d0             	add    %rdx,%rax
 7ac:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7b2:	83 c2 08             	add    $0x8,%edx
 7b5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7bb:	eb 12                	jmp    7cf <printf+0x2d6>
 7bd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7c4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7c8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7cf:	8b 00                	mov    (%rax),%eax
 7d1:	0f be d0             	movsbl %al,%edx
 7d4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7da:	89 d6                	mov    %edx,%esi
 7dc:	89 c7                	mov    %eax,%edi
 7de:	e8 24 fc ff ff       	call   407 <putc>
 7e3:	eb 4d                	jmp    832 <printf+0x339>
      } else if(c == '%'){
 7e5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7ec:	75 1a                	jne    808 <printf+0x30f>
        putc(fd, c);
 7ee:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7f4:	0f be d0             	movsbl %al,%edx
 7f7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7fd:	89 d6                	mov    %edx,%esi
 7ff:	89 c7                	mov    %eax,%edi
 801:	e8 01 fc ff ff       	call   407 <putc>
 806:	eb 2a                	jmp    832 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 808:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 80e:	be 25 00 00 00       	mov    $0x25,%esi
 813:	89 c7                	mov    %eax,%edi
 815:	e8 ed fb ff ff       	call   407 <putc>
        putc(fd, c);
 81a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 820:	0f be d0             	movsbl %al,%edx
 823:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 829:	89 d6                	mov    %edx,%esi
 82b:	89 c7                	mov    %eax,%edi
 82d:	e8 d5 fb ff ff       	call   407 <putc>
      }
      state = 0;
 832:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 839:	00 00 00 
  for(i = 0; fmt[i]; i++){
 83c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 843:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 849:	48 63 d0             	movslq %eax,%rdx
 84c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 853:	48 01 d0             	add    %rdx,%rax
 856:	0f b6 00             	movzbl (%rax),%eax
 859:	84 c0                	test   %al,%al
 85b:	0f 85 3a fd ff ff    	jne    59b <printf+0xa2>
    }
  }
}
 861:	90                   	nop
 862:	90                   	nop
 863:	c9                   	leave
 864:	c3                   	ret

0000000000000865 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 865:	f3 0f 1e fa          	endbr64
 869:	55                   	push   %rbp
 86a:	48 89 e5             	mov    %rsp,%rbp
 86d:	48 83 ec 18          	sub    $0x18,%rsp
 871:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 875:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 879:	48 83 e8 10          	sub    $0x10,%rax
 87d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	48 8b 05 f8 04 00 00 	mov    0x4f8(%rip),%rax        # d80 <freep>
 888:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 88c:	eb 2f                	jmp    8bd <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 892:	48 8b 00             	mov    (%rax),%rax
 895:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 899:	72 17                	jb     8b2 <free+0x4d>
 89b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 89f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a3:	72 2f                	jb     8d4 <free+0x6f>
 8a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a9:	48 8b 00             	mov    (%rax),%rax
 8ac:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8b0:	72 22                	jb     8d4 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b6:	48 8b 00             	mov    (%rax),%rax
 8b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8c5:	73 c7                	jae    88e <free+0x29>
 8c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8cb:	48 8b 00             	mov    (%rax),%rax
 8ce:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8d2:	73 ba                	jae    88e <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d8:	8b 40 08             	mov    0x8(%rax),%eax
 8db:	89 c0                	mov    %eax,%eax
 8dd:	48 c1 e0 04          	shl    $0x4,%rax
 8e1:	48 89 c2             	mov    %rax,%rdx
 8e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e8:	48 01 c2             	add    %rax,%rdx
 8eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ef:	48 8b 00             	mov    (%rax),%rax
 8f2:	48 39 c2             	cmp    %rax,%rdx
 8f5:	75 2d                	jne    924 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fb:	8b 50 08             	mov    0x8(%rax),%edx
 8fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 902:	48 8b 00             	mov    (%rax),%rax
 905:	8b 40 08             	mov    0x8(%rax),%eax
 908:	01 c2                	add    %eax,%edx
 90a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 911:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 915:	48 8b 00             	mov    (%rax),%rax
 918:	48 8b 10             	mov    (%rax),%rdx
 91b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91f:	48 89 10             	mov    %rdx,(%rax)
 922:	eb 0e                	jmp    932 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 928:	48 8b 10             	mov    (%rax),%rdx
 92b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 936:	8b 40 08             	mov    0x8(%rax),%eax
 939:	89 c0                	mov    %eax,%eax
 93b:	48 c1 e0 04          	shl    $0x4,%rax
 93f:	48 89 c2             	mov    %rax,%rdx
 942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 946:	48 01 d0             	add    %rdx,%rax
 949:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 94d:	75 27                	jne    976 <free+0x111>
    p->s.size += bp->s.size;
 94f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 953:	8b 50 08             	mov    0x8(%rax),%edx
 956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95a:	8b 40 08             	mov    0x8(%rax),%eax
 95d:	01 c2                	add    %eax,%edx
 95f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 963:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 966:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96a:	48 8b 10             	mov    (%rax),%rdx
 96d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 971:	48 89 10             	mov    %rdx,(%rax)
 974:	eb 0b                	jmp    981 <free+0x11c>
  } else
    p->s.ptr = bp;
 976:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 97e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	48 89 05 f4 03 00 00 	mov    %rax,0x3f4(%rip)        # d80 <freep>
}
 98c:	90                   	nop
 98d:	c9                   	leave
 98e:	c3                   	ret

000000000000098f <morecore>:

static Header*
morecore(uint nu)
{
 98f:	f3 0f 1e fa          	endbr64
 993:	55                   	push   %rbp
 994:	48 89 e5             	mov    %rsp,%rbp
 997:	48 83 ec 20          	sub    $0x20,%rsp
 99b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 99e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9a5:	77 07                	ja     9ae <morecore+0x1f>
    nu = 4096;
 9a7:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9b1:	c1 e0 04             	shl    $0x4,%eax
 9b4:	89 c7                	mov    %eax,%edi
 9b6:	e8 04 fa ff ff       	call   3bf <sbrk>
 9bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9bf:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9c4:	75 07                	jne    9cd <morecore+0x3e>
    return 0;
 9c6:	b8 00 00 00 00       	mov    $0x0,%eax
 9cb:	eb 29                	jmp    9f6 <morecore+0x67>
  hp = (Header*)p;
 9cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9dc:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e3:	48 83 c0 10          	add    $0x10,%rax
 9e7:	48 89 c7             	mov    %rax,%rdi
 9ea:	e8 76 fe ff ff       	call   865 <free>
  return freep;
 9ef:	48 8b 05 8a 03 00 00 	mov    0x38a(%rip),%rax        # d80 <freep>
}
 9f6:	c9                   	leave
 9f7:	c3                   	ret

00000000000009f8 <malloc>:

void*
malloc(uint nbytes)
{
 9f8:	f3 0f 1e fa          	endbr64
 9fc:	55                   	push   %rbp
 9fd:	48 89 e5             	mov    %rsp,%rbp
 a00:	48 83 ec 30          	sub    $0x30,%rsp
 a04:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a07:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a0a:	48 83 c0 0f          	add    $0xf,%rax
 a0e:	48 c1 e8 04          	shr    $0x4,%rax
 a12:	83 c0 01             	add    $0x1,%eax
 a15:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a18:	48 8b 05 61 03 00 00 	mov    0x361(%rip),%rax        # d80 <freep>
 a1f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a23:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a28:	75 2b                	jne    a55 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a2a:	48 c7 45 f0 70 0d 00 	movq   $0xd70,-0x10(%rbp)
 a31:	00 
 a32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a36:	48 89 05 43 03 00 00 	mov    %rax,0x343(%rip)        # d80 <freep>
 a3d:	48 8b 05 3c 03 00 00 	mov    0x33c(%rip),%rax        # d80 <freep>
 a44:	48 89 05 25 03 00 00 	mov    %rax,0x325(%rip)        # d70 <base>
    base.s.size = 0;
 a4b:	c7 05 23 03 00 00 00 	movl   $0x0,0x323(%rip)        # d78 <base+0x8>
 a52:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a59:	48 8b 00             	mov    (%rax),%rax
 a5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a64:	8b 40 08             	mov    0x8(%rax),%eax
 a67:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a6a:	72 5f                	jb     acb <malloc+0xd3>
      if(p->s.size == nunits)
 a6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a70:	8b 40 08             	mov    0x8(%rax),%eax
 a73:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a76:	75 10                	jne    a88 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7c:	48 8b 10             	mov    (%rax),%rdx
 a7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a83:	48 89 10             	mov    %rdx,(%rax)
 a86:	eb 2e                	jmp    ab6 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8c:	8b 40 08             	mov    0x8(%rax),%eax
 a8f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a92:	89 c2                	mov    %eax,%edx
 a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a98:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9f:	8b 40 08             	mov    0x8(%rax),%eax
 aa2:	89 c0                	mov    %eax,%eax
 aa4:	48 c1 e0 04          	shl    $0x4,%rax
 aa8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ab3:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ab6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aba:	48 89 05 bf 02 00 00 	mov    %rax,0x2bf(%rip)        # d80 <freep>
      return (void*)(p + 1);
 ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac5:	48 83 c0 10          	add    $0x10,%rax
 ac9:	eb 41                	jmp    b0c <malloc+0x114>
    }
    if(p == freep)
 acb:	48 8b 05 ae 02 00 00 	mov    0x2ae(%rip),%rax        # d80 <freep>
 ad2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ad6:	75 1c                	jne    af4 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ad8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 adb:	89 c7                	mov    %eax,%edi
 add:	e8 ad fe ff ff       	call   98f <morecore>
 ae2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ae6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 aeb:	75 07                	jne    af4 <malloc+0xfc>
        return 0;
 aed:	b8 00 00 00 00       	mov    $0x0,%eax
 af2:	eb 18                	jmp    b0c <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	48 8b 00             	mov    (%rax),%rax
 b03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b07:	e9 54 ff ff ff       	jmp    a60 <malloc+0x68>
  }
}
 b0c:	c9                   	leave
 b0d:	c3                   	ret
