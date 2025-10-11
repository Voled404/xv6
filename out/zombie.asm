
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

00000000000003ff <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ff:	f3 0f 1e fa          	endbr64
 403:	55                   	push   %rbp
 404:	48 89 e5             	mov    %rsp,%rbp
 407:	48 83 ec 10          	sub    $0x10,%rsp
 40b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 40e:	89 f0                	mov    %esi,%eax
 410:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 413:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 417:	8b 45 fc             	mov    -0x4(%rbp),%eax
 41a:	ba 01 00 00 00       	mov    $0x1,%edx
 41f:	48 89 ce             	mov    %rcx,%rsi
 422:	89 c7                	mov    %eax,%edi
 424:	e8 2e ff ff ff       	call   357 <write>
}
 429:	90                   	nop
 42a:	c9                   	leave
 42b:	c3                   	ret

000000000000042c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 42c:	f3 0f 1e fa          	endbr64
 430:	55                   	push   %rbp
 431:	48 89 e5             	mov    %rsp,%rbp
 434:	48 83 ec 30          	sub    $0x30,%rsp
 438:	89 7d dc             	mov    %edi,-0x24(%rbp)
 43b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 43e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 441:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 444:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 44b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 44f:	74 17                	je     468 <printint+0x3c>
 451:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 455:	79 11                	jns    468 <printint+0x3c>
    neg = 1;
 457:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 45e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 461:	f7 d8                	neg    %eax
 463:	89 45 f4             	mov    %eax,-0xc(%rbp)
 466:	eb 06                	jmp    46e <printint+0x42>
  } else {
    x = xx;
 468:	8b 45 d8             	mov    -0x28(%rbp),%eax
 46b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 46e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 475:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 478:	8b 45 f4             	mov    -0xc(%rbp),%eax
 47b:	ba 00 00 00 00       	mov    $0x0,%edx
 480:	f7 f6                	div    %esi
 482:	89 d1                	mov    %edx,%ecx
 484:	8b 45 fc             	mov    -0x4(%rbp),%eax
 487:	8d 50 01             	lea    0x1(%rax),%edx
 48a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 48d:	89 ca                	mov    %ecx,%edx
 48f:	0f b6 92 50 0d 00 00 	movzbl 0xd50(%rdx),%edx
 496:	48 98                	cltq
 498:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 49c:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 49f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4a2:	ba 00 00 00 00       	mov    $0x0,%edx
 4a7:	f7 f7                	div    %edi
 4a9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4b0:	75 c3                	jne    475 <printint+0x49>
  if(neg)
 4b2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4b6:	74 2b                	je     4e3 <printint+0xb7>
    buf[i++] = '-';
 4b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4bb:	8d 50 01             	lea    0x1(%rax),%edx
 4be:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c1:	48 98                	cltq
 4c3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4c8:	eb 19                	jmp    4e3 <printint+0xb7>
    putc(fd, buf[i]);
 4ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4cd:	48 98                	cltq
 4cf:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4d4:	0f be d0             	movsbl %al,%edx
 4d7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4da:	89 d6                	mov    %edx,%esi
 4dc:	89 c7                	mov    %eax,%edi
 4de:	e8 1c ff ff ff       	call   3ff <putc>
  while(--i >= 0)
 4e3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4eb:	79 dd                	jns    4ca <printint+0x9e>
}
 4ed:	90                   	nop
 4ee:	90                   	nop
 4ef:	c9                   	leave
 4f0:	c3                   	ret

00000000000004f1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f1:	f3 0f 1e fa          	endbr64
 4f5:	55                   	push   %rbp
 4f6:	48 89 e5             	mov    %rsp,%rbp
 4f9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 500:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 506:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 50d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 514:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 51b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 522:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 529:	84 c0                	test   %al,%al
 52b:	74 20                	je     54d <printf+0x5c>
 52d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 531:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 535:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 539:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 53d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 541:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 545:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 549:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 54d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 554:	00 00 00 
 557:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 55e:	00 00 00 
 561:	48 8d 45 10          	lea    0x10(%rbp),%rax
 565:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 56c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 573:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 57a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 581:	00 00 00 
  for(i = 0; fmt[i]; i++){
 584:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 58b:	00 00 00 
 58e:	e9 a8 02 00 00       	jmp    83b <printf+0x34a>
    c = fmt[i] & 0xff;
 593:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 599:	48 63 d0             	movslq %eax,%rdx
 59c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5a3:	48 01 d0             	add    %rdx,%rax
 5a6:	0f b6 00             	movzbl (%rax),%eax
 5a9:	0f be c0             	movsbl %al,%eax
 5ac:	25 ff 00 00 00       	and    $0xff,%eax
 5b1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5b7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5be:	75 35                	jne    5f5 <printf+0x104>
      if(c == '%'){
 5c0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5c7:	75 0f                	jne    5d8 <printf+0xe7>
        state = '%';
 5c9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5d0:	00 00 00 
 5d3:	e9 5c 02 00 00       	jmp    834 <printf+0x343>
      } else {
        putc(fd, c);
 5d8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5de:	0f be d0             	movsbl %al,%edx
 5e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5e7:	89 d6                	mov    %edx,%esi
 5e9:	89 c7                	mov    %eax,%edi
 5eb:	e8 0f fe ff ff       	call   3ff <putc>
 5f0:	e9 3f 02 00 00       	jmp    834 <printf+0x343>
      }
    } else if(state == '%'){
 5f5:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5fc:	0f 85 32 02 00 00    	jne    834 <printf+0x343>
      if(c == 'd'){
 602:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 609:	75 5e                	jne    669 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 60b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 611:	83 f8 2f             	cmp    $0x2f,%eax
 614:	77 23                	ja     639 <printf+0x148>
 616:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 61d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 623:	89 d2                	mov    %edx,%edx
 625:	48 01 d0             	add    %rdx,%rax
 628:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 62e:	83 c2 08             	add    $0x8,%edx
 631:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 637:	eb 12                	jmp    64b <printf+0x15a>
 639:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 640:	48 8d 50 08          	lea    0x8(%rax),%rdx
 644:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 64b:	8b 30                	mov    (%rax),%esi
 64d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 653:	b9 01 00 00 00       	mov    $0x1,%ecx
 658:	ba 0a 00 00 00       	mov    $0xa,%edx
 65d:	89 c7                	mov    %eax,%edi
 65f:	e8 c8 fd ff ff       	call   42c <printint>
 664:	e9 c1 01 00 00       	jmp    82a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 669:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 670:	74 09                	je     67b <printf+0x18a>
 672:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 679:	75 5e                	jne    6d9 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 67b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 681:	83 f8 2f             	cmp    $0x2f,%eax
 684:	77 23                	ja     6a9 <printf+0x1b8>
 686:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 68d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 693:	89 d2                	mov    %edx,%edx
 695:	48 01 d0             	add    %rdx,%rax
 698:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69e:	83 c2 08             	add    $0x8,%edx
 6a1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6a7:	eb 12                	jmp    6bb <printf+0x1ca>
 6a9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6b4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6bb:	8b 30                	mov    (%rax),%esi
 6bd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6c3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6c8:	ba 10 00 00 00       	mov    $0x10,%edx
 6cd:	89 c7                	mov    %eax,%edi
 6cf:	e8 58 fd ff ff       	call   42c <printint>
 6d4:	e9 51 01 00 00       	jmp    82a <printf+0x339>
      } else if(c == 's'){
 6d9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6e0:	0f 85 98 00 00 00    	jne    77e <printf+0x28d>
        s = va_arg(ap, char*);
 6e6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6ec:	83 f8 2f             	cmp    $0x2f,%eax
 6ef:	77 23                	ja     714 <printf+0x223>
 6f1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	89 d2                	mov    %edx,%edx
 700:	48 01 d0             	add    %rdx,%rax
 703:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 709:	83 c2 08             	add    $0x8,%edx
 70c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 712:	eb 12                	jmp    726 <printf+0x235>
 714:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 71b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 726:	48 8b 00             	mov    (%rax),%rax
 729:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 730:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 737:	00 
 738:	75 31                	jne    76b <printf+0x27a>
          s = "(null)";
 73a:	48 c7 85 48 ff ff ff 	movq   $0xb06,-0xb8(%rbp)
 741:	06 0b 00 00 
        while(*s != 0){
 745:	eb 24                	jmp    76b <printf+0x27a>
          putc(fd, *s);
 747:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 74e:	0f b6 00             	movzbl (%rax),%eax
 751:	0f be d0             	movsbl %al,%edx
 754:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 75a:	89 d6                	mov    %edx,%esi
 75c:	89 c7                	mov    %eax,%edi
 75e:	e8 9c fc ff ff       	call   3ff <putc>
          s++;
 763:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 76a:	01 
        while(*s != 0){
 76b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 772:	0f b6 00             	movzbl (%rax),%eax
 775:	84 c0                	test   %al,%al
 777:	75 ce                	jne    747 <printf+0x256>
 779:	e9 ac 00 00 00       	jmp    82a <printf+0x339>
        }
      } else if(c == 'c'){
 77e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 785:	75 56                	jne    7dd <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 787:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 78d:	83 f8 2f             	cmp    $0x2f,%eax
 790:	77 23                	ja     7b5 <printf+0x2c4>
 792:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 799:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 79f:	89 d2                	mov    %edx,%edx
 7a1:	48 01 d0             	add    %rdx,%rax
 7a4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7aa:	83 c2 08             	add    $0x8,%edx
 7ad:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7b3:	eb 12                	jmp    7c7 <printf+0x2d6>
 7b5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7bc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7c0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7c7:	8b 00                	mov    (%rax),%eax
 7c9:	0f be d0             	movsbl %al,%edx
 7cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d2:	89 d6                	mov    %edx,%esi
 7d4:	89 c7                	mov    %eax,%edi
 7d6:	e8 24 fc ff ff       	call   3ff <putc>
 7db:	eb 4d                	jmp    82a <printf+0x339>
      } else if(c == '%'){
 7dd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7e4:	75 1a                	jne    800 <printf+0x30f>
        putc(fd, c);
 7e6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7ec:	0f be d0             	movsbl %al,%edx
 7ef:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f5:	89 d6                	mov    %edx,%esi
 7f7:	89 c7                	mov    %eax,%edi
 7f9:	e8 01 fc ff ff       	call   3ff <putc>
 7fe:	eb 2a                	jmp    82a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 800:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 806:	be 25 00 00 00       	mov    $0x25,%esi
 80b:	89 c7                	mov    %eax,%edi
 80d:	e8 ed fb ff ff       	call   3ff <putc>
        putc(fd, c);
 812:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 818:	0f be d0             	movsbl %al,%edx
 81b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 821:	89 d6                	mov    %edx,%esi
 823:	89 c7                	mov    %eax,%edi
 825:	e8 d5 fb ff ff       	call   3ff <putc>
      }
      state = 0;
 82a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 831:	00 00 00 
  for(i = 0; fmt[i]; i++){
 834:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 83b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 841:	48 63 d0             	movslq %eax,%rdx
 844:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 84b:	48 01 d0             	add    %rdx,%rax
 84e:	0f b6 00             	movzbl (%rax),%eax
 851:	84 c0                	test   %al,%al
 853:	0f 85 3a fd ff ff    	jne    593 <printf+0xa2>
    }
  }
}
 859:	90                   	nop
 85a:	90                   	nop
 85b:	c9                   	leave
 85c:	c3                   	ret

000000000000085d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85d:	f3 0f 1e fa          	endbr64
 861:	55                   	push   %rbp
 862:	48 89 e5             	mov    %rsp,%rbp
 865:	48 83 ec 18          	sub    $0x18,%rsp
 869:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 86d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 871:	48 83 e8 10          	sub    $0x10,%rax
 875:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 879:	48 8b 05 00 05 00 00 	mov    0x500(%rip),%rax        # d80 <freep>
 880:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 884:	eb 2f                	jmp    8b5 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 88a:	48 8b 00             	mov    (%rax),%rax
 88d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 891:	72 17                	jb     8aa <free+0x4d>
 893:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 897:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 89b:	72 2f                	jb     8cc <free+0x6f>
 89d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a1:	48 8b 00             	mov    (%rax),%rax
 8a4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a8:	72 22                	jb     8cc <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ae:	48 8b 00             	mov    (%rax),%rax
 8b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8bd:	73 c7                	jae    886 <free+0x29>
 8bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c3:	48 8b 00             	mov    (%rax),%rax
 8c6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ca:	73 ba                	jae    886 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d0:	8b 40 08             	mov    0x8(%rax),%eax
 8d3:	89 c0                	mov    %eax,%eax
 8d5:	48 c1 e0 04          	shl    $0x4,%rax
 8d9:	48 89 c2             	mov    %rax,%rdx
 8dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e0:	48 01 c2             	add    %rax,%rdx
 8e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e7:	48 8b 00             	mov    (%rax),%rax
 8ea:	48 39 c2             	cmp    %rax,%rdx
 8ed:	75 2d                	jne    91c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f3:	8b 50 08             	mov    0x8(%rax),%edx
 8f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fa:	48 8b 00             	mov    (%rax),%rax
 8fd:	8b 40 08             	mov    0x8(%rax),%eax
 900:	01 c2                	add    %eax,%edx
 902:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 906:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 909:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90d:	48 8b 00             	mov    (%rax),%rax
 910:	48 8b 10             	mov    (%rax),%rdx
 913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 917:	48 89 10             	mov    %rdx,(%rax)
 91a:	eb 0e                	jmp    92a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 91c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 920:	48 8b 10             	mov    (%rax),%rdx
 923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 927:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 92a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92e:	8b 40 08             	mov    0x8(%rax),%eax
 931:	89 c0                	mov    %eax,%eax
 933:	48 c1 e0 04          	shl    $0x4,%rax
 937:	48 89 c2             	mov    %rax,%rdx
 93a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93e:	48 01 d0             	add    %rdx,%rax
 941:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 945:	75 27                	jne    96e <free+0x111>
    p->s.size += bp->s.size;
 947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94b:	8b 50 08             	mov    0x8(%rax),%edx
 94e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 952:	8b 40 08             	mov    0x8(%rax),%eax
 955:	01 c2                	add    %eax,%edx
 957:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 95e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 962:	48 8b 10             	mov    (%rax),%rdx
 965:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 969:	48 89 10             	mov    %rdx,(%rax)
 96c:	eb 0b                	jmp    979 <free+0x11c>
  } else
    p->s.ptr = bp;
 96e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 972:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 976:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97d:	48 89 05 fc 03 00 00 	mov    %rax,0x3fc(%rip)        # d80 <freep>
}
 984:	90                   	nop
 985:	c9                   	leave
 986:	c3                   	ret

0000000000000987 <morecore>:

static Header*
morecore(uint nu)
{
 987:	f3 0f 1e fa          	endbr64
 98b:	55                   	push   %rbp
 98c:	48 89 e5             	mov    %rsp,%rbp
 98f:	48 83 ec 20          	sub    $0x20,%rsp
 993:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 996:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 99d:	77 07                	ja     9a6 <morecore+0x1f>
    nu = 4096;
 99f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9a9:	c1 e0 04             	shl    $0x4,%eax
 9ac:	89 c7                	mov    %eax,%edi
 9ae:	e8 0c fa ff ff       	call   3bf <sbrk>
 9b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9b7:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9bc:	75 07                	jne    9c5 <morecore+0x3e>
    return 0;
 9be:	b8 00 00 00 00       	mov    $0x0,%eax
 9c3:	eb 29                	jmp    9ee <morecore+0x67>
  hp = (Header*)p;
 9c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9d4:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9db:	48 83 c0 10          	add    $0x10,%rax
 9df:	48 89 c7             	mov    %rax,%rdi
 9e2:	e8 76 fe ff ff       	call   85d <free>
  return freep;
 9e7:	48 8b 05 92 03 00 00 	mov    0x392(%rip),%rax        # d80 <freep>
}
 9ee:	c9                   	leave
 9ef:	c3                   	ret

00000000000009f0 <malloc>:

void*
malloc(uint nbytes)
{
 9f0:	f3 0f 1e fa          	endbr64
 9f4:	55                   	push   %rbp
 9f5:	48 89 e5             	mov    %rsp,%rbp
 9f8:	48 83 ec 30          	sub    $0x30,%rsp
 9fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ff:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a02:	48 83 c0 0f          	add    $0xf,%rax
 a06:	48 c1 e8 04          	shr    $0x4,%rax
 a0a:	83 c0 01             	add    $0x1,%eax
 a0d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a10:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # d80 <freep>
 a17:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a1b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a20:	75 2b                	jne    a4d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a22:	48 c7 45 f0 70 0d 00 	movq   $0xd70,-0x10(%rbp)
 a29:	00 
 a2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2e:	48 89 05 4b 03 00 00 	mov    %rax,0x34b(%rip)        # d80 <freep>
 a35:	48 8b 05 44 03 00 00 	mov    0x344(%rip),%rax        # d80 <freep>
 a3c:	48 89 05 2d 03 00 00 	mov    %rax,0x32d(%rip)        # d70 <base>
    base.s.size = 0;
 a43:	c7 05 2b 03 00 00 00 	movl   $0x0,0x32b(%rip)        # d78 <base+0x8>
 a4a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a51:	48 8b 00             	mov    (%rax),%rax
 a54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5c:	8b 40 08             	mov    0x8(%rax),%eax
 a5f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a62:	72 5f                	jb     ac3 <malloc+0xd3>
      if(p->s.size == nunits)
 a64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a68:	8b 40 08             	mov    0x8(%rax),%eax
 a6b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a6e:	75 10                	jne    a80 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a74:	48 8b 10             	mov    (%rax),%rdx
 a77:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a7b:	48 89 10             	mov    %rdx,(%rax)
 a7e:	eb 2e                	jmp    aae <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a84:	8b 40 08             	mov    0x8(%rax),%eax
 a87:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a8a:	89 c2                	mov    %eax,%edx
 a8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a90:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a97:	8b 40 08             	mov    0x8(%rax),%eax
 a9a:	89 c0                	mov    %eax,%eax
 a9c:	48 c1 e0 04          	shl    $0x4,%rax
 aa0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 aa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aab:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab2:	48 89 05 c7 02 00 00 	mov    %rax,0x2c7(%rip)        # d80 <freep>
      return (void*)(p + 1);
 ab9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abd:	48 83 c0 10          	add    $0x10,%rax
 ac1:	eb 41                	jmp    b04 <malloc+0x114>
    }
    if(p == freep)
 ac3:	48 8b 05 b6 02 00 00 	mov    0x2b6(%rip),%rax        # d80 <freep>
 aca:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ace:	75 1c                	jne    aec <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ad0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ad3:	89 c7                	mov    %eax,%edi
 ad5:	e8 ad fe ff ff       	call   987 <morecore>
 ada:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ade:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ae3:	75 07                	jne    aec <malloc+0xfc>
        return 0;
 ae5:	b8 00 00 00 00       	mov    $0x0,%eax
 aea:	eb 18                	jmp    b04 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af8:	48 8b 00             	mov    (%rax),%rax
 afb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aff:	e9 54 ff ff ff       	jmp    a58 <malloc+0x68>
  }
}
 b04:	c9                   	leave
 b05:	c3                   	ret
