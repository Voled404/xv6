
fs/shutdown:     file format elf64-x86-64


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
   8:	48 83 ec 10          	sub    $0x10,%rsp
   c:	89 7d fc             	mov    %edi,-0x4(%rbp)
   f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  printf(2, "Shutting down emulator...\n");
  13:	48 c7 c6 16 0b 00 00 	mov    $0xb16,%rsi
  1a:	bf 02 00 00 00       	mov    $0x2,%edi
  1f:	b8 00 00 00 00       	mov    $0x0,%eax
  24:	e8 d8 04 00 00       	call   501 <printf>
  halt();
  29:	b8 00 00 00 00       	mov    $0x0,%eax
  2e:	e8 d4 03 00 00       	call   407 <halt>
  exit(); //not reached
  33:	e8 17 03 00 00       	call   34f <exit>

0000000000000038 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  38:	55                   	push   %rbp
  39:	48 89 e5             	mov    %rsp,%rbp
  3c:	48 83 ec 10          	sub    $0x10,%rsp
  40:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  44:	89 75 f4             	mov    %esi,-0xc(%rbp)
  47:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  4a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  4e:	8b 55 f0             	mov    -0x10(%rbp),%edx
  51:	8b 45 f4             	mov    -0xc(%rbp),%eax
  54:	48 89 ce             	mov    %rcx,%rsi
  57:	48 89 f7             	mov    %rsi,%rdi
  5a:	89 d1                	mov    %edx,%ecx
  5c:	fc                   	cld
  5d:	f3 aa                	rep stos %al,%es:(%rdi)
  5f:	89 ca                	mov    %ecx,%edx
  61:	48 89 fe             	mov    %rdi,%rsi
  64:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  68:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  6b:	90                   	nop
  6c:	c9                   	leave
  6d:	c3                   	ret

000000000000006e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  6e:	f3 0f 1e fa          	endbr64
  72:	55                   	push   %rbp
  73:	48 89 e5             	mov    %rsp,%rbp
  76:	48 83 ec 20          	sub    $0x20,%rsp
  7a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  7e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  8a:	90                   	nop
  8b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  93:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  9b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  9f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  a3:	0f b6 12             	movzbl (%rdx),%edx
  a6:	88 10                	mov    %dl,(%rax)
  a8:	0f b6 00             	movzbl (%rax),%eax
  ab:	84 c0                	test   %al,%al
  ad:	75 dc                	jne    8b <strcpy+0x1d>
    ;
  return os;
  af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  b3:	c9                   	leave
  b4:	c3                   	ret

00000000000000b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b5:	f3 0f 1e fa          	endbr64
  b9:	55                   	push   %rbp
  ba:	48 89 e5             	mov    %rsp,%rbp
  bd:	48 83 ec 10          	sub    $0x10,%rsp
  c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  c5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  c9:	eb 0a                	jmp    d5 <strcmp+0x20>
    p++, q++;
  cb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  d0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d9:	0f b6 00             	movzbl (%rax),%eax
  dc:	84 c0                	test   %al,%al
  de:	74 12                	je     f2 <strcmp+0x3d>
  e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  e4:	0f b6 10             	movzbl (%rax),%edx
  e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  eb:	0f b6 00             	movzbl (%rax),%eax
  ee:	38 c2                	cmp    %al,%dl
  f0:	74 d9                	je     cb <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
  f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  f6:	0f b6 00             	movzbl (%rax),%eax
  f9:	0f b6 d0             	movzbl %al,%edx
  fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 100:	0f b6 00             	movzbl (%rax),%eax
 103:	0f b6 c0             	movzbl %al,%eax
 106:	29 c2                	sub    %eax,%edx
 108:	89 d0                	mov    %edx,%eax
}
 10a:	c9                   	leave
 10b:	c3                   	ret

000000000000010c <strlen>:

uint
strlen(char *s)
{
 10c:	f3 0f 1e fa          	endbr64
 110:	55                   	push   %rbp
 111:	48 89 e5             	mov    %rsp,%rbp
 114:	48 83 ec 18          	sub    $0x18,%rsp
 118:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 11c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 123:	eb 04                	jmp    129 <strlen+0x1d>
 125:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 129:	8b 45 fc             	mov    -0x4(%rbp),%eax
 12c:	48 63 d0             	movslq %eax,%rdx
 12f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 133:	48 01 d0             	add    %rdx,%rax
 136:	0f b6 00             	movzbl (%rax),%eax
 139:	84 c0                	test   %al,%al
 13b:	75 e8                	jne    125 <strlen+0x19>
    ;
  return n;
 13d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 140:	c9                   	leave
 141:	c3                   	ret

0000000000000142 <memset>:

void*
memset(void *dst, int c, uint n)
{
 142:	f3 0f 1e fa          	endbr64
 146:	55                   	push   %rbp
 147:	48 89 e5             	mov    %rsp,%rbp
 14a:	48 83 ec 10          	sub    $0x10,%rsp
 14e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 152:	89 75 f4             	mov    %esi,-0xc(%rbp)
 155:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 158:	8b 55 f0             	mov    -0x10(%rbp),%edx
 15b:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 15e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 162:	89 ce                	mov    %ecx,%esi
 164:	48 89 c7             	mov    %rax,%rdi
 167:	e8 cc fe ff ff       	call   38 <stosb>
  return dst;
 16c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 170:	c9                   	leave
 171:	c3                   	ret

0000000000000172 <strchr>:

char*
strchr(const char *s, char c)
{
 172:	f3 0f 1e fa          	endbr64
 176:	55                   	push   %rbp
 177:	48 89 e5             	mov    %rsp,%rbp
 17a:	48 83 ec 10          	sub    $0x10,%rsp
 17e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 182:	89 f0                	mov    %esi,%eax
 184:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 187:	eb 17                	jmp    1a0 <strchr+0x2e>
    if(*s == c)
 189:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 18d:	0f b6 00             	movzbl (%rax),%eax
 190:	38 45 f4             	cmp    %al,-0xc(%rbp)
 193:	75 06                	jne    19b <strchr+0x29>
      return (char*)s;
 195:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 199:	eb 15                	jmp    1b0 <strchr+0x3e>
  for(; *s; s++)
 19b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a4:	0f b6 00             	movzbl (%rax),%eax
 1a7:	84 c0                	test   %al,%al
 1a9:	75 de                	jne    189 <strchr+0x17>
  return 0;
 1ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b0:	c9                   	leave
 1b1:	c3                   	ret

00000000000001b2 <gets>:

char*
gets(char *buf, int max)
{
 1b2:	f3 0f 1e fa          	endbr64
 1b6:	55                   	push   %rbp
 1b7:	48 89 e5             	mov    %rsp,%rbp
 1ba:	48 83 ec 20          	sub    $0x20,%rsp
 1be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1c2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1cc:	eb 48                	jmp    216 <gets+0x64>
    cc = read(0, &c, 1);
 1ce:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1d2:	ba 01 00 00 00       	mov    $0x1,%edx
 1d7:	48 89 c6             	mov    %rax,%rsi
 1da:	bf 00 00 00 00       	mov    $0x0,%edi
 1df:	e8 83 01 00 00       	call   367 <read>
 1e4:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1e7:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1eb:	7e 36                	jle    223 <gets+0x71>
      break;
    buf[i++] = c;
 1ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f0:	8d 50 01             	lea    0x1(%rax),%edx
 1f3:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1f6:	48 63 d0             	movslq %eax,%rdx
 1f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1fd:	48 01 c2             	add    %rax,%rdx
 200:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 204:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 206:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 20a:	3c 0a                	cmp    $0xa,%al
 20c:	74 16                	je     224 <gets+0x72>
 20e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 212:	3c 0d                	cmp    $0xd,%al
 214:	74 0e                	je     224 <gets+0x72>
  for(i=0; i+1 < max; ){
 216:	8b 45 fc             	mov    -0x4(%rbp),%eax
 219:	83 c0 01             	add    $0x1,%eax
 21c:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 21f:	7f ad                	jg     1ce <gets+0x1c>
 221:	eb 01                	jmp    224 <gets+0x72>
      break;
 223:	90                   	nop
      break;
  }
  buf[i] = '\0';
 224:	8b 45 fc             	mov    -0x4(%rbp),%eax
 227:	48 63 d0             	movslq %eax,%rdx
 22a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 22e:	48 01 d0             	add    %rdx,%rax
 231:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 234:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 238:	c9                   	leave
 239:	c3                   	ret

000000000000023a <stat>:

int
stat(char *n, struct stat *st)
{
 23a:	f3 0f 1e fa          	endbr64
 23e:	55                   	push   %rbp
 23f:	48 89 e5             	mov    %rsp,%rbp
 242:	48 83 ec 20          	sub    $0x20,%rsp
 246:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 24a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 252:	be 00 00 00 00       	mov    $0x0,%esi
 257:	48 89 c7             	mov    %rax,%rdi
 25a:	e8 30 01 00 00       	call   38f <open>
 25f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 262:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 266:	79 07                	jns    26f <stat+0x35>
    return -1;
 268:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 26d:	eb 21                	jmp    290 <stat+0x56>
  r = fstat(fd, st);
 26f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 273:	8b 45 fc             	mov    -0x4(%rbp),%eax
 276:	48 89 d6             	mov    %rdx,%rsi
 279:	89 c7                	mov    %eax,%edi
 27b:	e8 27 01 00 00       	call   3a7 <fstat>
 280:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 283:	8b 45 fc             	mov    -0x4(%rbp),%eax
 286:	89 c7                	mov    %eax,%edi
 288:	e8 ea 00 00 00       	call   377 <close>
  return r;
 28d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 290:	c9                   	leave
 291:	c3                   	ret

0000000000000292 <atoi>:

int
atoi(const char *s)
{
 292:	f3 0f 1e fa          	endbr64
 296:	55                   	push   %rbp
 297:	48 89 e5             	mov    %rsp,%rbp
 29a:	48 83 ec 18          	sub    $0x18,%rsp
 29e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2a9:	eb 28                	jmp    2d3 <atoi+0x41>
    n = n*10 + *s++ - '0';
 2ab:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2ae:	89 d0                	mov    %edx,%eax
 2b0:	c1 e0 02             	shl    $0x2,%eax
 2b3:	01 d0                	add    %edx,%eax
 2b5:	01 c0                	add    %eax,%eax
 2b7:	89 c1                	mov    %eax,%ecx
 2b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2bd:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2c1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2c5:	0f b6 00             	movzbl (%rax),%eax
 2c8:	0f be c0             	movsbl %al,%eax
 2cb:	01 c8                	add    %ecx,%eax
 2cd:	83 e8 30             	sub    $0x30,%eax
 2d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2d7:	0f b6 00             	movzbl (%rax),%eax
 2da:	3c 2f                	cmp    $0x2f,%al
 2dc:	7e 0b                	jle    2e9 <atoi+0x57>
 2de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2e2:	0f b6 00             	movzbl (%rax),%eax
 2e5:	3c 39                	cmp    $0x39,%al
 2e7:	7e c2                	jle    2ab <atoi+0x19>
  return n;
 2e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2ec:	c9                   	leave
 2ed:	c3                   	ret

00000000000002ee <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ee:	f3 0f 1e fa          	endbr64
 2f2:	55                   	push   %rbp
 2f3:	48 89 e5             	mov    %rsp,%rbp
 2f6:	48 83 ec 28          	sub    $0x28,%rsp
 2fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2fe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 302:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 305:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 309:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 30d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 311:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 315:	eb 1d                	jmp    334 <memmove+0x46>
    *dst++ = *src++;
 317:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 31b:	48 8d 42 01          	lea    0x1(%rdx),%rax
 31f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 323:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 327:	48 8d 48 01          	lea    0x1(%rax),%rcx
 32b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 32f:	0f b6 12             	movzbl (%rdx),%edx
 332:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 334:	8b 45 dc             	mov    -0x24(%rbp),%eax
 337:	8d 50 ff             	lea    -0x1(%rax),%edx
 33a:	89 55 dc             	mov    %edx,-0x24(%rbp)
 33d:	85 c0                	test   %eax,%eax
 33f:	7f d6                	jg     317 <memmove+0x29>
  return vdst;
 341:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 345:	c9                   	leave
 346:	c3                   	ret

0000000000000347 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 347:	b8 01 00 00 00       	mov    $0x1,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

000000000000034f <exit>:
SYSCALL(exit)
 34f:	b8 02 00 00 00       	mov    $0x2,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

0000000000000357 <wait>:
SYSCALL(wait)
 357:	b8 03 00 00 00       	mov    $0x3,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

000000000000035f <pipe>:
SYSCALL(pipe)
 35f:	b8 04 00 00 00       	mov    $0x4,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

0000000000000367 <read>:
SYSCALL(read)
 367:	b8 05 00 00 00       	mov    $0x5,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

000000000000036f <write>:
SYSCALL(write)
 36f:	b8 10 00 00 00       	mov    $0x10,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

0000000000000377 <close>:
SYSCALL(close)
 377:	b8 15 00 00 00       	mov    $0x15,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

000000000000037f <kill>:
SYSCALL(kill)
 37f:	b8 06 00 00 00       	mov    $0x6,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

0000000000000387 <exec>:
SYSCALL(exec)
 387:	b8 07 00 00 00       	mov    $0x7,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <open>:
SYSCALL(open)
 38f:	b8 0f 00 00 00       	mov    $0xf,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <mknod>:
SYSCALL(mknod)
 397:	b8 11 00 00 00       	mov    $0x11,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <unlink>:
SYSCALL(unlink)
 39f:	b8 12 00 00 00       	mov    $0x12,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <fstat>:
SYSCALL(fstat)
 3a7:	b8 08 00 00 00       	mov    $0x8,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <link>:
SYSCALL(link)
 3af:	b8 13 00 00 00       	mov    $0x13,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <mkdir>:
SYSCALL(mkdir)
 3b7:	b8 14 00 00 00       	mov    $0x14,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <chdir>:
SYSCALL(chdir)
 3bf:	b8 09 00 00 00       	mov    $0x9,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <dup>:
SYSCALL(dup)
 3c7:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <getpid>:
SYSCALL(getpid)
 3cf:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <sbrk>:
SYSCALL(sbrk)
 3d7:	b8 0c 00 00 00       	mov    $0xc,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <sleep>:
SYSCALL(sleep)
 3df:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <uptime>:
SYSCALL(uptime)
 3e7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <getpinfo>:
SYSCALL(getpinfo)
 3ef:	b8 18 00 00 00       	mov    $0x18,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <settickets>:
SYSCALL(settickets)
 3f7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <getfavnum>:
SYSCALL(getfavnum)
 3ff:	b8 1c 00 00 00       	mov    $0x1c,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <halt>:
SYSCALL(halt)
 407:	b8 1d 00 00 00       	mov    $0x1d,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

000000000000040f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40f:	f3 0f 1e fa          	endbr64
 413:	55                   	push   %rbp
 414:	48 89 e5             	mov    %rsp,%rbp
 417:	48 83 ec 10          	sub    $0x10,%rsp
 41b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 41e:	89 f0                	mov    %esi,%eax
 420:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 423:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 427:	8b 45 fc             	mov    -0x4(%rbp),%eax
 42a:	ba 01 00 00 00       	mov    $0x1,%edx
 42f:	48 89 ce             	mov    %rcx,%rsi
 432:	89 c7                	mov    %eax,%edi
 434:	e8 36 ff ff ff       	call   36f <write>
}
 439:	90                   	nop
 43a:	c9                   	leave
 43b:	c3                   	ret

000000000000043c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43c:	f3 0f 1e fa          	endbr64
 440:	55                   	push   %rbp
 441:	48 89 e5             	mov    %rsp,%rbp
 444:	48 83 ec 30          	sub    $0x30,%rsp
 448:	89 7d dc             	mov    %edi,-0x24(%rbp)
 44b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 44e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 451:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 454:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 45b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 45f:	74 17                	je     478 <printint+0x3c>
 461:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 465:	79 11                	jns    478 <printint+0x3c>
    neg = 1;
 467:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 46e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 471:	f7 d8                	neg    %eax
 473:	89 45 f4             	mov    %eax,-0xc(%rbp)
 476:	eb 06                	jmp    47e <printint+0x42>
  } else {
    x = xx;
 478:	8b 45 d8             	mov    -0x28(%rbp),%eax
 47b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 47e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 485:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 488:	8b 45 f4             	mov    -0xc(%rbp),%eax
 48b:	ba 00 00 00 00       	mov    $0x0,%edx
 490:	f7 f6                	div    %esi
 492:	89 d1                	mov    %edx,%ecx
 494:	8b 45 fc             	mov    -0x4(%rbp),%eax
 497:	8d 50 01             	lea    0x1(%rax),%edx
 49a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 49d:	89 ca                	mov    %ecx,%edx
 49f:	0f b6 92 70 0d 00 00 	movzbl 0xd70(%rdx),%edx
 4a6:	48 98                	cltq
 4a8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4ac:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4af:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4b2:	ba 00 00 00 00       	mov    $0x0,%edx
 4b7:	f7 f7                	div    %edi
 4b9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4c0:	75 c3                	jne    485 <printint+0x49>
  if(neg)
 4c2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4c6:	74 2b                	je     4f3 <printint+0xb7>
    buf[i++] = '-';
 4c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4cb:	8d 50 01             	lea    0x1(%rax),%edx
 4ce:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4d1:	48 98                	cltq
 4d3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4d8:	eb 19                	jmp    4f3 <printint+0xb7>
    putc(fd, buf[i]);
 4da:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4dd:	48 98                	cltq
 4df:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4e4:	0f be d0             	movsbl %al,%edx
 4e7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4ea:	89 d6                	mov    %edx,%esi
 4ec:	89 c7                	mov    %eax,%edi
 4ee:	e8 1c ff ff ff       	call   40f <putc>
  while(--i >= 0)
 4f3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4fb:	79 dd                	jns    4da <printint+0x9e>
}
 4fd:	90                   	nop
 4fe:	90                   	nop
 4ff:	c9                   	leave
 500:	c3                   	ret

0000000000000501 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 501:	f3 0f 1e fa          	endbr64
 505:	55                   	push   %rbp
 506:	48 89 e5             	mov    %rsp,%rbp
 509:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 510:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 516:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 51d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 524:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 52b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 532:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 539:	84 c0                	test   %al,%al
 53b:	74 20                	je     55d <printf+0x5c>
 53d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 541:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 545:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 549:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 54d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 551:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 555:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 559:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 55d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 564:	00 00 00 
 567:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 56e:	00 00 00 
 571:	48 8d 45 10          	lea    0x10(%rbp),%rax
 575:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 57c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 583:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 58a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 591:	00 00 00 
  for(i = 0; fmt[i]; i++){
 594:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 59b:	00 00 00 
 59e:	e9 a8 02 00 00       	jmp    84b <printf+0x34a>
    c = fmt[i] & 0xff;
 5a3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5a9:	48 63 d0             	movslq %eax,%rdx
 5ac:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5b3:	48 01 d0             	add    %rdx,%rax
 5b6:	0f b6 00             	movzbl (%rax),%eax
 5b9:	0f be c0             	movsbl %al,%eax
 5bc:	25 ff 00 00 00       	and    $0xff,%eax
 5c1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5c7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5ce:	75 35                	jne    605 <printf+0x104>
      if(c == '%'){
 5d0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5d7:	75 0f                	jne    5e8 <printf+0xe7>
        state = '%';
 5d9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5e0:	00 00 00 
 5e3:	e9 5c 02 00 00       	jmp    844 <printf+0x343>
      } else {
        putc(fd, c);
 5e8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5ee:	0f be d0             	movsbl %al,%edx
 5f1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5f7:	89 d6                	mov    %edx,%esi
 5f9:	89 c7                	mov    %eax,%edi
 5fb:	e8 0f fe ff ff       	call   40f <putc>
 600:	e9 3f 02 00 00       	jmp    844 <printf+0x343>
      }
    } else if(state == '%'){
 605:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 60c:	0f 85 32 02 00 00    	jne    844 <printf+0x343>
      if(c == 'd'){
 612:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 619:	75 5e                	jne    679 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 61b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 621:	83 f8 2f             	cmp    $0x2f,%eax
 624:	77 23                	ja     649 <printf+0x148>
 626:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 62d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 633:	89 d2                	mov    %edx,%edx
 635:	48 01 d0             	add    %rdx,%rax
 638:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 63e:	83 c2 08             	add    $0x8,%edx
 641:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 647:	eb 12                	jmp    65b <printf+0x15a>
 649:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 650:	48 8d 50 08          	lea    0x8(%rax),%rdx
 654:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 65b:	8b 30                	mov    (%rax),%esi
 65d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 663:	b9 01 00 00 00       	mov    $0x1,%ecx
 668:	ba 0a 00 00 00       	mov    $0xa,%edx
 66d:	89 c7                	mov    %eax,%edi
 66f:	e8 c8 fd ff ff       	call   43c <printint>
 674:	e9 c1 01 00 00       	jmp    83a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 679:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 680:	74 09                	je     68b <printf+0x18a>
 682:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 689:	75 5e                	jne    6e9 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 68b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 691:	83 f8 2f             	cmp    $0x2f,%eax
 694:	77 23                	ja     6b9 <printf+0x1b8>
 696:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 69d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a3:	89 d2                	mov    %edx,%edx
 6a5:	48 01 d0             	add    %rdx,%rax
 6a8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ae:	83 c2 08             	add    $0x8,%edx
 6b1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6b7:	eb 12                	jmp    6cb <printf+0x1ca>
 6b9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6c0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6c4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6cb:	8b 30                	mov    (%rax),%esi
 6cd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6d3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6d8:	ba 10 00 00 00       	mov    $0x10,%edx
 6dd:	89 c7                	mov    %eax,%edi
 6df:	e8 58 fd ff ff       	call   43c <printint>
 6e4:	e9 51 01 00 00       	jmp    83a <printf+0x339>
      } else if(c == 's'){
 6e9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6f0:	0f 85 98 00 00 00    	jne    78e <printf+0x28d>
        s = va_arg(ap, char*);
 6f6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6fc:	83 f8 2f             	cmp    $0x2f,%eax
 6ff:	77 23                	ja     724 <printf+0x223>
 701:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 708:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70e:	89 d2                	mov    %edx,%edx
 710:	48 01 d0             	add    %rdx,%rax
 713:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 719:	83 c2 08             	add    $0x8,%edx
 71c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 722:	eb 12                	jmp    736 <printf+0x235>
 724:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 72b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 72f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 736:	48 8b 00             	mov    (%rax),%rax
 739:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 740:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 747:	00 
 748:	75 31                	jne    77b <printf+0x27a>
          s = "(null)";
 74a:	48 c7 85 48 ff ff ff 	movq   $0xb31,-0xb8(%rbp)
 751:	31 0b 00 00 
        while(*s != 0){
 755:	eb 24                	jmp    77b <printf+0x27a>
          putc(fd, *s);
 757:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 75e:	0f b6 00             	movzbl (%rax),%eax
 761:	0f be d0             	movsbl %al,%edx
 764:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 76a:	89 d6                	mov    %edx,%esi
 76c:	89 c7                	mov    %eax,%edi
 76e:	e8 9c fc ff ff       	call   40f <putc>
          s++;
 773:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 77a:	01 
        while(*s != 0){
 77b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 782:	0f b6 00             	movzbl (%rax),%eax
 785:	84 c0                	test   %al,%al
 787:	75 ce                	jne    757 <printf+0x256>
 789:	e9 ac 00 00 00       	jmp    83a <printf+0x339>
        }
      } else if(c == 'c'){
 78e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 795:	75 56                	jne    7ed <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 797:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 79d:	83 f8 2f             	cmp    $0x2f,%eax
 7a0:	77 23                	ja     7c5 <printf+0x2c4>
 7a2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7a9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7af:	89 d2                	mov    %edx,%edx
 7b1:	48 01 d0             	add    %rdx,%rax
 7b4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ba:	83 c2 08             	add    $0x8,%edx
 7bd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7c3:	eb 12                	jmp    7d7 <printf+0x2d6>
 7c5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7cc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7d0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7d7:	8b 00                	mov    (%rax),%eax
 7d9:	0f be d0             	movsbl %al,%edx
 7dc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e2:	89 d6                	mov    %edx,%esi
 7e4:	89 c7                	mov    %eax,%edi
 7e6:	e8 24 fc ff ff       	call   40f <putc>
 7eb:	eb 4d                	jmp    83a <printf+0x339>
      } else if(c == '%'){
 7ed:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7f4:	75 1a                	jne    810 <printf+0x30f>
        putc(fd, c);
 7f6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7fc:	0f be d0             	movsbl %al,%edx
 7ff:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 805:	89 d6                	mov    %edx,%esi
 807:	89 c7                	mov    %eax,%edi
 809:	e8 01 fc ff ff       	call   40f <putc>
 80e:	eb 2a                	jmp    83a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 810:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 816:	be 25 00 00 00       	mov    $0x25,%esi
 81b:	89 c7                	mov    %eax,%edi
 81d:	e8 ed fb ff ff       	call   40f <putc>
        putc(fd, c);
 822:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 828:	0f be d0             	movsbl %al,%edx
 82b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 831:	89 d6                	mov    %edx,%esi
 833:	89 c7                	mov    %eax,%edi
 835:	e8 d5 fb ff ff       	call   40f <putc>
      }
      state = 0;
 83a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 841:	00 00 00 
  for(i = 0; fmt[i]; i++){
 844:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 84b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 851:	48 63 d0             	movslq %eax,%rdx
 854:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 85b:	48 01 d0             	add    %rdx,%rax
 85e:	0f b6 00             	movzbl (%rax),%eax
 861:	84 c0                	test   %al,%al
 863:	0f 85 3a fd ff ff    	jne    5a3 <printf+0xa2>
    }
  }
}
 869:	90                   	nop
 86a:	90                   	nop
 86b:	c9                   	leave
 86c:	c3                   	ret

000000000000086d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 86d:	f3 0f 1e fa          	endbr64
 871:	55                   	push   %rbp
 872:	48 89 e5             	mov    %rsp,%rbp
 875:	48 83 ec 18          	sub    $0x18,%rsp
 879:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 87d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 881:	48 83 e8 10          	sub    $0x10,%rax
 885:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 889:	48 8b 05 10 05 00 00 	mov    0x510(%rip),%rax        # da0 <freep>
 890:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 894:	eb 2f                	jmp    8c5 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 896:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 89a:	48 8b 00             	mov    (%rax),%rax
 89d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a1:	72 17                	jb     8ba <free+0x4d>
 8a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ab:	72 2f                	jb     8dc <free+0x6f>
 8ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b1:	48 8b 00             	mov    (%rax),%rax
 8b4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8b8:	72 22                	jb     8dc <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8be:	48 8b 00             	mov    (%rax),%rax
 8c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8cd:	73 c7                	jae    896 <free+0x29>
 8cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d3:	48 8b 00             	mov    (%rax),%rax
 8d6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8da:	73 ba                	jae    896 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e0:	8b 40 08             	mov    0x8(%rax),%eax
 8e3:	89 c0                	mov    %eax,%eax
 8e5:	48 c1 e0 04          	shl    $0x4,%rax
 8e9:	48 89 c2             	mov    %rax,%rdx
 8ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f0:	48 01 c2             	add    %rax,%rdx
 8f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f7:	48 8b 00             	mov    (%rax),%rax
 8fa:	48 39 c2             	cmp    %rax,%rdx
 8fd:	75 2d                	jne    92c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 903:	8b 50 08             	mov    0x8(%rax),%edx
 906:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90a:	48 8b 00             	mov    (%rax),%rax
 90d:	8b 40 08             	mov    0x8(%rax),%eax
 910:	01 c2                	add    %eax,%edx
 912:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 916:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91d:	48 8b 00             	mov    (%rax),%rax
 920:	48 8b 10             	mov    (%rax),%rdx
 923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 927:	48 89 10             	mov    %rdx,(%rax)
 92a:	eb 0e                	jmp    93a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 92c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 930:	48 8b 10             	mov    (%rax),%rdx
 933:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 937:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 93a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93e:	8b 40 08             	mov    0x8(%rax),%eax
 941:	89 c0                	mov    %eax,%eax
 943:	48 c1 e0 04          	shl    $0x4,%rax
 947:	48 89 c2             	mov    %rax,%rdx
 94a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94e:	48 01 d0             	add    %rdx,%rax
 951:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 955:	75 27                	jne    97e <free+0x111>
    p->s.size += bp->s.size;
 957:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95b:	8b 50 08             	mov    0x8(%rax),%edx
 95e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 962:	8b 40 08             	mov    0x8(%rax),%eax
 965:	01 c2                	add    %eax,%edx
 967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 96e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 972:	48 8b 10             	mov    (%rax),%rdx
 975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 979:	48 89 10             	mov    %rdx,(%rax)
 97c:	eb 0b                	jmp    989 <free+0x11c>
  } else
    p->s.ptr = bp;
 97e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 982:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 986:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	48 89 05 0c 04 00 00 	mov    %rax,0x40c(%rip)        # da0 <freep>
}
 994:	90                   	nop
 995:	c9                   	leave
 996:	c3                   	ret

0000000000000997 <morecore>:

static Header*
morecore(uint nu)
{
 997:	f3 0f 1e fa          	endbr64
 99b:	55                   	push   %rbp
 99c:	48 89 e5             	mov    %rsp,%rbp
 99f:	48 83 ec 20          	sub    $0x20,%rsp
 9a3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9a6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9ad:	77 07                	ja     9b6 <morecore+0x1f>
    nu = 4096;
 9af:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9b9:	c1 e0 04             	shl    $0x4,%eax
 9bc:	89 c7                	mov    %eax,%edi
 9be:	e8 14 fa ff ff       	call   3d7 <sbrk>
 9c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9c7:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9cc:	75 07                	jne    9d5 <morecore+0x3e>
    return 0;
 9ce:	b8 00 00 00 00       	mov    $0x0,%eax
 9d3:	eb 29                	jmp    9fe <morecore+0x67>
  hp = (Header*)p;
 9d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9e4:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9eb:	48 83 c0 10          	add    $0x10,%rax
 9ef:	48 89 c7             	mov    %rax,%rdi
 9f2:	e8 76 fe ff ff       	call   86d <free>
  return freep;
 9f7:	48 8b 05 a2 03 00 00 	mov    0x3a2(%rip),%rax        # da0 <freep>
}
 9fe:	c9                   	leave
 9ff:	c3                   	ret

0000000000000a00 <malloc>:

void*
malloc(uint nbytes)
{
 a00:	f3 0f 1e fa          	endbr64
 a04:	55                   	push   %rbp
 a05:	48 89 e5             	mov    %rsp,%rbp
 a08:	48 83 ec 30          	sub    $0x30,%rsp
 a0c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a12:	48 83 c0 0f          	add    $0xf,%rax
 a16:	48 c1 e8 04          	shr    $0x4,%rax
 a1a:	83 c0 01             	add    $0x1,%eax
 a1d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a20:	48 8b 05 79 03 00 00 	mov    0x379(%rip),%rax        # da0 <freep>
 a27:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a2b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a30:	75 2b                	jne    a5d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a32:	48 c7 45 f0 90 0d 00 	movq   $0xd90,-0x10(%rbp)
 a39:	00 
 a3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3e:	48 89 05 5b 03 00 00 	mov    %rax,0x35b(%rip)        # da0 <freep>
 a45:	48 8b 05 54 03 00 00 	mov    0x354(%rip),%rax        # da0 <freep>
 a4c:	48 89 05 3d 03 00 00 	mov    %rax,0x33d(%rip)        # d90 <base>
    base.s.size = 0;
 a53:	c7 05 3b 03 00 00 00 	movl   $0x0,0x33b(%rip)        # d98 <base+0x8>
 a5a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a61:	48 8b 00             	mov    (%rax),%rax
 a64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	8b 40 08             	mov    0x8(%rax),%eax
 a6f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a72:	72 5f                	jb     ad3 <malloc+0xd3>
      if(p->s.size == nunits)
 a74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a78:	8b 40 08             	mov    0x8(%rax),%eax
 a7b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a7e:	75 10                	jne    a90 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a84:	48 8b 10             	mov    (%rax),%rdx
 a87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8b:	48 89 10             	mov    %rdx,(%rax)
 a8e:	eb 2e                	jmp    abe <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a94:	8b 40 08             	mov    0x8(%rax),%eax
 a97:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a9a:	89 c2                	mov    %eax,%edx
 a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa7:	8b 40 08             	mov    0x8(%rax),%eax
 aaa:	89 c0                	mov    %eax,%eax
 aac:	48 c1 e0 04          	shl    $0x4,%rax
 ab0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 abb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac2:	48 89 05 d7 02 00 00 	mov    %rax,0x2d7(%rip)        # da0 <freep>
      return (void*)(p + 1);
 ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acd:	48 83 c0 10          	add    $0x10,%rax
 ad1:	eb 41                	jmp    b14 <malloc+0x114>
    }
    if(p == freep)
 ad3:	48 8b 05 c6 02 00 00 	mov    0x2c6(%rip),%rax        # da0 <freep>
 ada:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ade:	75 1c                	jne    afc <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ae0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae3:	89 c7                	mov    %eax,%edi
 ae5:	e8 ad fe ff ff       	call   997 <morecore>
 aea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 aee:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 af3:	75 07                	jne    afc <malloc+0xfc>
        return 0;
 af5:	b8 00 00 00 00       	mov    $0x0,%eax
 afa:	eb 18                	jmp    b14 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	48 8b 00             	mov    (%rax),%rax
 b0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b0f:	e9 54 ff ff ff       	jmp    a68 <malloc+0x68>
  }
}
 b14:	c9                   	leave
 b15:	c3                   	ret
