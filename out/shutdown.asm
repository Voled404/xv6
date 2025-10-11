
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
  13:	48 c7 c6 26 0b 00 00 	mov    $0xb26,%rsi
  1a:	bf 02 00 00 00       	mov    $0x2,%edi
  1f:	b8 00 00 00 00       	mov    $0x0,%eax
  24:	e8 e8 04 00 00       	call   511 <printf>
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

000000000000040f <getcount>:
SYSCALL(getcount)
 40f:	b8 1e 00 00 00       	mov    $0x1e,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <killrandom>:
SYSCALL(killrandom)
 417:	b8 1f 00 00 00       	mov    $0x1f,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41f:	f3 0f 1e fa          	endbr64
 423:	55                   	push   %rbp
 424:	48 89 e5             	mov    %rsp,%rbp
 427:	48 83 ec 10          	sub    $0x10,%rsp
 42b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 42e:	89 f0                	mov    %esi,%eax
 430:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 433:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 437:	8b 45 fc             	mov    -0x4(%rbp),%eax
 43a:	ba 01 00 00 00       	mov    $0x1,%edx
 43f:	48 89 ce             	mov    %rcx,%rsi
 442:	89 c7                	mov    %eax,%edi
 444:	e8 26 ff ff ff       	call   36f <write>
}
 449:	90                   	nop
 44a:	c9                   	leave
 44b:	c3                   	ret

000000000000044c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44c:	f3 0f 1e fa          	endbr64
 450:	55                   	push   %rbp
 451:	48 89 e5             	mov    %rsp,%rbp
 454:	48 83 ec 30          	sub    $0x30,%rsp
 458:	89 7d dc             	mov    %edi,-0x24(%rbp)
 45b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 45e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 461:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 464:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 46b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 46f:	74 17                	je     488 <printint+0x3c>
 471:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 475:	79 11                	jns    488 <printint+0x3c>
    neg = 1;
 477:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 47e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 481:	f7 d8                	neg    %eax
 483:	89 45 f4             	mov    %eax,-0xc(%rbp)
 486:	eb 06                	jmp    48e <printint+0x42>
  } else {
    x = xx;
 488:	8b 45 d8             	mov    -0x28(%rbp),%eax
 48b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 48e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 495:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 498:	8b 45 f4             	mov    -0xc(%rbp),%eax
 49b:	ba 00 00 00 00       	mov    $0x0,%edx
 4a0:	f7 f6                	div    %esi
 4a2:	89 d1                	mov    %edx,%ecx
 4a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a7:	8d 50 01             	lea    0x1(%rax),%edx
 4aa:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ad:	89 ca                	mov    %ecx,%edx
 4af:	0f b6 92 80 0d 00 00 	movzbl 0xd80(%rdx),%edx
 4b6:	48 98                	cltq
 4b8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4bc:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4c2:	ba 00 00 00 00       	mov    $0x0,%edx
 4c7:	f7 f7                	div    %edi
 4c9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4d0:	75 c3                	jne    495 <printint+0x49>
  if(neg)
 4d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4d6:	74 2b                	je     503 <printint+0xb7>
    buf[i++] = '-';
 4d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4db:	8d 50 01             	lea    0x1(%rax),%edx
 4de:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e1:	48 98                	cltq
 4e3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4e8:	eb 19                	jmp    503 <printint+0xb7>
    putc(fd, buf[i]);
 4ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ed:	48 98                	cltq
 4ef:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4f4:	0f be d0             	movsbl %al,%edx
 4f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4fa:	89 d6                	mov    %edx,%esi
 4fc:	89 c7                	mov    %eax,%edi
 4fe:	e8 1c ff ff ff       	call   41f <putc>
  while(--i >= 0)
 503:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 507:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 50b:	79 dd                	jns    4ea <printint+0x9e>
}
 50d:	90                   	nop
 50e:	90                   	nop
 50f:	c9                   	leave
 510:	c3                   	ret

0000000000000511 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 511:	f3 0f 1e fa          	endbr64
 515:	55                   	push   %rbp
 516:	48 89 e5             	mov    %rsp,%rbp
 519:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 520:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 526:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 52d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 534:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 53b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 542:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 549:	84 c0                	test   %al,%al
 54b:	74 20                	je     56d <printf+0x5c>
 54d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 551:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 555:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 559:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 55d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 561:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 565:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 569:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 56d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 574:	00 00 00 
 577:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 57e:	00 00 00 
 581:	48 8d 45 10          	lea    0x10(%rbp),%rax
 585:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 58c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 593:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 59a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5a1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5a4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5ab:	00 00 00 
 5ae:	e9 a8 02 00 00       	jmp    85b <printf+0x34a>
    c = fmt[i] & 0xff;
 5b3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5b9:	48 63 d0             	movslq %eax,%rdx
 5bc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5c3:	48 01 d0             	add    %rdx,%rax
 5c6:	0f b6 00             	movzbl (%rax),%eax
 5c9:	0f be c0             	movsbl %al,%eax
 5cc:	25 ff 00 00 00       	and    $0xff,%eax
 5d1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5d7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5de:	75 35                	jne    615 <printf+0x104>
      if(c == '%'){
 5e0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5e7:	75 0f                	jne    5f8 <printf+0xe7>
        state = '%';
 5e9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5f0:	00 00 00 
 5f3:	e9 5c 02 00 00       	jmp    854 <printf+0x343>
      } else {
        putc(fd, c);
 5f8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5fe:	0f be d0             	movsbl %al,%edx
 601:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 607:	89 d6                	mov    %edx,%esi
 609:	89 c7                	mov    %eax,%edi
 60b:	e8 0f fe ff ff       	call   41f <putc>
 610:	e9 3f 02 00 00       	jmp    854 <printf+0x343>
      }
    } else if(state == '%'){
 615:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 61c:	0f 85 32 02 00 00    	jne    854 <printf+0x343>
      if(c == 'd'){
 622:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 629:	75 5e                	jne    689 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 62b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 631:	83 f8 2f             	cmp    $0x2f,%eax
 634:	77 23                	ja     659 <printf+0x148>
 636:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 63d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 643:	89 d2                	mov    %edx,%edx
 645:	48 01 d0             	add    %rdx,%rax
 648:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 64e:	83 c2 08             	add    $0x8,%edx
 651:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 657:	eb 12                	jmp    66b <printf+0x15a>
 659:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 660:	48 8d 50 08          	lea    0x8(%rax),%rdx
 664:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 66b:	8b 30                	mov    (%rax),%esi
 66d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 673:	b9 01 00 00 00       	mov    $0x1,%ecx
 678:	ba 0a 00 00 00       	mov    $0xa,%edx
 67d:	89 c7                	mov    %eax,%edi
 67f:	e8 c8 fd ff ff       	call   44c <printint>
 684:	e9 c1 01 00 00       	jmp    84a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 689:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 690:	74 09                	je     69b <printf+0x18a>
 692:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 699:	75 5e                	jne    6f9 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 69b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6a1:	83 f8 2f             	cmp    $0x2f,%eax
 6a4:	77 23                	ja     6c9 <printf+0x1b8>
 6a6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ad:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b3:	89 d2                	mov    %edx,%edx
 6b5:	48 01 d0             	add    %rdx,%rax
 6b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6be:	83 c2 08             	add    $0x8,%edx
 6c1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6c7:	eb 12                	jmp    6db <printf+0x1ca>
 6c9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6d0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6db:	8b 30                	mov    (%rax),%esi
 6dd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6e3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6e8:	ba 10 00 00 00       	mov    $0x10,%edx
 6ed:	89 c7                	mov    %eax,%edi
 6ef:	e8 58 fd ff ff       	call   44c <printint>
 6f4:	e9 51 01 00 00       	jmp    84a <printf+0x339>
      } else if(c == 's'){
 6f9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 700:	0f 85 98 00 00 00    	jne    79e <printf+0x28d>
        s = va_arg(ap, char*);
 706:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 70c:	83 f8 2f             	cmp    $0x2f,%eax
 70f:	77 23                	ja     734 <printf+0x223>
 711:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 718:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71e:	89 d2                	mov    %edx,%edx
 720:	48 01 d0             	add    %rdx,%rax
 723:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 729:	83 c2 08             	add    $0x8,%edx
 72c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 732:	eb 12                	jmp    746 <printf+0x235>
 734:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 73b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 73f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 746:	48 8b 00             	mov    (%rax),%rax
 749:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 750:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 757:	00 
 758:	75 31                	jne    78b <printf+0x27a>
          s = "(null)";
 75a:	48 c7 85 48 ff ff ff 	movq   $0xb41,-0xb8(%rbp)
 761:	41 0b 00 00 
        while(*s != 0){
 765:	eb 24                	jmp    78b <printf+0x27a>
          putc(fd, *s);
 767:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 76e:	0f b6 00             	movzbl (%rax),%eax
 771:	0f be d0             	movsbl %al,%edx
 774:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77a:	89 d6                	mov    %edx,%esi
 77c:	89 c7                	mov    %eax,%edi
 77e:	e8 9c fc ff ff       	call   41f <putc>
          s++;
 783:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 78a:	01 
        while(*s != 0){
 78b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 792:	0f b6 00             	movzbl (%rax),%eax
 795:	84 c0                	test   %al,%al
 797:	75 ce                	jne    767 <printf+0x256>
 799:	e9 ac 00 00 00       	jmp    84a <printf+0x339>
        }
      } else if(c == 'c'){
 79e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7a5:	75 56                	jne    7fd <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7a7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ad:	83 f8 2f             	cmp    $0x2f,%eax
 7b0:	77 23                	ja     7d5 <printf+0x2c4>
 7b2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7b9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7bf:	89 d2                	mov    %edx,%edx
 7c1:	48 01 d0             	add    %rdx,%rax
 7c4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ca:	83 c2 08             	add    $0x8,%edx
 7cd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7d3:	eb 12                	jmp    7e7 <printf+0x2d6>
 7d5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7dc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7e0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7e7:	8b 00                	mov    (%rax),%eax
 7e9:	0f be d0             	movsbl %al,%edx
 7ec:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f2:	89 d6                	mov    %edx,%esi
 7f4:	89 c7                	mov    %eax,%edi
 7f6:	e8 24 fc ff ff       	call   41f <putc>
 7fb:	eb 4d                	jmp    84a <printf+0x339>
      } else if(c == '%'){
 7fd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 804:	75 1a                	jne    820 <printf+0x30f>
        putc(fd, c);
 806:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 80c:	0f be d0             	movsbl %al,%edx
 80f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 815:	89 d6                	mov    %edx,%esi
 817:	89 c7                	mov    %eax,%edi
 819:	e8 01 fc ff ff       	call   41f <putc>
 81e:	eb 2a                	jmp    84a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 820:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 826:	be 25 00 00 00       	mov    $0x25,%esi
 82b:	89 c7                	mov    %eax,%edi
 82d:	e8 ed fb ff ff       	call   41f <putc>
        putc(fd, c);
 832:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 838:	0f be d0             	movsbl %al,%edx
 83b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 841:	89 d6                	mov    %edx,%esi
 843:	89 c7                	mov    %eax,%edi
 845:	e8 d5 fb ff ff       	call   41f <putc>
      }
      state = 0;
 84a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 851:	00 00 00 
  for(i = 0; fmt[i]; i++){
 854:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 85b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 861:	48 63 d0             	movslq %eax,%rdx
 864:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 86b:	48 01 d0             	add    %rdx,%rax
 86e:	0f b6 00             	movzbl (%rax),%eax
 871:	84 c0                	test   %al,%al
 873:	0f 85 3a fd ff ff    	jne    5b3 <printf+0xa2>
    }
  }
}
 879:	90                   	nop
 87a:	90                   	nop
 87b:	c9                   	leave
 87c:	c3                   	ret

000000000000087d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 87d:	f3 0f 1e fa          	endbr64
 881:	55                   	push   %rbp
 882:	48 89 e5             	mov    %rsp,%rbp
 885:	48 83 ec 18          	sub    $0x18,%rsp
 889:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 891:	48 83 e8 10          	sub    $0x10,%rax
 895:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 899:	48 8b 05 10 05 00 00 	mov    0x510(%rip),%rax        # db0 <freep>
 8a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8a4:	eb 2f                	jmp    8d5 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8aa:	48 8b 00             	mov    (%rax),%rax
 8ad:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b1:	72 17                	jb     8ca <free+0x4d>
 8b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8bb:	72 2f                	jb     8ec <free+0x6f>
 8bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c1:	48 8b 00             	mov    (%rax),%rax
 8c4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c8:	72 22                	jb     8ec <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ce:	48 8b 00             	mov    (%rax),%rax
 8d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8dd:	73 c7                	jae    8a6 <free+0x29>
 8df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e3:	48 8b 00             	mov    (%rax),%rax
 8e6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ea:	73 ba                	jae    8a6 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f0:	8b 40 08             	mov    0x8(%rax),%eax
 8f3:	89 c0                	mov    %eax,%eax
 8f5:	48 c1 e0 04          	shl    $0x4,%rax
 8f9:	48 89 c2             	mov    %rax,%rdx
 8fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 900:	48 01 c2             	add    %rax,%rdx
 903:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 907:	48 8b 00             	mov    (%rax),%rax
 90a:	48 39 c2             	cmp    %rax,%rdx
 90d:	75 2d                	jne    93c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 90f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 913:	8b 50 08             	mov    0x8(%rax),%edx
 916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91a:	48 8b 00             	mov    (%rax),%rax
 91d:	8b 40 08             	mov    0x8(%rax),%eax
 920:	01 c2                	add    %eax,%edx
 922:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 926:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92d:	48 8b 00             	mov    (%rax),%rax
 930:	48 8b 10             	mov    (%rax),%rdx
 933:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 937:	48 89 10             	mov    %rdx,(%rax)
 93a:	eb 0e                	jmp    94a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 93c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 940:	48 8b 10             	mov    (%rax),%rdx
 943:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 947:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 94a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94e:	8b 40 08             	mov    0x8(%rax),%eax
 951:	89 c0                	mov    %eax,%eax
 953:	48 c1 e0 04          	shl    $0x4,%rax
 957:	48 89 c2             	mov    %rax,%rdx
 95a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95e:	48 01 d0             	add    %rdx,%rax
 961:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 965:	75 27                	jne    98e <free+0x111>
    p->s.size += bp->s.size;
 967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96b:	8b 50 08             	mov    0x8(%rax),%edx
 96e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 972:	8b 40 08             	mov    0x8(%rax),%eax
 975:	01 c2                	add    %eax,%edx
 977:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 97e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 982:	48 8b 10             	mov    (%rax),%rdx
 985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 989:	48 89 10             	mov    %rdx,(%rax)
 98c:	eb 0b                	jmp    999 <free+0x11c>
  } else
    p->s.ptr = bp;
 98e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 992:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 996:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99d:	48 89 05 0c 04 00 00 	mov    %rax,0x40c(%rip)        # db0 <freep>
}
 9a4:	90                   	nop
 9a5:	c9                   	leave
 9a6:	c3                   	ret

00000000000009a7 <morecore>:

static Header*
morecore(uint nu)
{
 9a7:	f3 0f 1e fa          	endbr64
 9ab:	55                   	push   %rbp
 9ac:	48 89 e5             	mov    %rsp,%rbp
 9af:	48 83 ec 20          	sub    $0x20,%rsp
 9b3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9b6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9bd:	77 07                	ja     9c6 <morecore+0x1f>
    nu = 4096;
 9bf:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9c9:	c1 e0 04             	shl    $0x4,%eax
 9cc:	89 c7                	mov    %eax,%edi
 9ce:	e8 04 fa ff ff       	call   3d7 <sbrk>
 9d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9d7:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9dc:	75 07                	jne    9e5 <morecore+0x3e>
    return 0;
 9de:	b8 00 00 00 00       	mov    $0x0,%eax
 9e3:	eb 29                	jmp    a0e <morecore+0x67>
  hp = (Header*)p;
 9e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9f4:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fb:	48 83 c0 10          	add    $0x10,%rax
 9ff:	48 89 c7             	mov    %rax,%rdi
 a02:	e8 76 fe ff ff       	call   87d <free>
  return freep;
 a07:	48 8b 05 a2 03 00 00 	mov    0x3a2(%rip),%rax        # db0 <freep>
}
 a0e:	c9                   	leave
 a0f:	c3                   	ret

0000000000000a10 <malloc>:

void*
malloc(uint nbytes)
{
 a10:	f3 0f 1e fa          	endbr64
 a14:	55                   	push   %rbp
 a15:	48 89 e5             	mov    %rsp,%rbp
 a18:	48 83 ec 30          	sub    $0x30,%rsp
 a1c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a1f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a22:	48 83 c0 0f          	add    $0xf,%rax
 a26:	48 c1 e8 04          	shr    $0x4,%rax
 a2a:	83 c0 01             	add    $0x1,%eax
 a2d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a30:	48 8b 05 79 03 00 00 	mov    0x379(%rip),%rax        # db0 <freep>
 a37:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a3b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a40:	75 2b                	jne    a6d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a42:	48 c7 45 f0 a0 0d 00 	movq   $0xda0,-0x10(%rbp)
 a49:	00 
 a4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a4e:	48 89 05 5b 03 00 00 	mov    %rax,0x35b(%rip)        # db0 <freep>
 a55:	48 8b 05 54 03 00 00 	mov    0x354(%rip),%rax        # db0 <freep>
 a5c:	48 89 05 3d 03 00 00 	mov    %rax,0x33d(%rip)        # da0 <base>
    base.s.size = 0;
 a63:	c7 05 3b 03 00 00 00 	movl   $0x0,0x33b(%rip)        # da8 <base+0x8>
 a6a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a71:	48 8b 00             	mov    (%rax),%rax
 a74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7c:	8b 40 08             	mov    0x8(%rax),%eax
 a7f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a82:	72 5f                	jb     ae3 <malloc+0xd3>
      if(p->s.size == nunits)
 a84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a88:	8b 40 08             	mov    0x8(%rax),%eax
 a8b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a8e:	75 10                	jne    aa0 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a94:	48 8b 10             	mov    (%rax),%rdx
 a97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9b:	48 89 10             	mov    %rdx,(%rax)
 a9e:	eb 2e                	jmp    ace <malloc+0xbe>
      else {
        p->s.size -= nunits;
 aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa4:	8b 40 08             	mov    0x8(%rax),%eax
 aa7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aaa:	89 c2                	mov    %eax,%edx
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ab3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab7:	8b 40 08             	mov    0x8(%rax),%eax
 aba:	89 c0                	mov    %eax,%eax
 abc:	48 c1 e0 04          	shl    $0x4,%rax
 ac0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 acb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ace:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad2:	48 89 05 d7 02 00 00 	mov    %rax,0x2d7(%rip)        # db0 <freep>
      return (void*)(p + 1);
 ad9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 add:	48 83 c0 10          	add    $0x10,%rax
 ae1:	eb 41                	jmp    b24 <malloc+0x114>
    }
    if(p == freep)
 ae3:	48 8b 05 c6 02 00 00 	mov    0x2c6(%rip),%rax        # db0 <freep>
 aea:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 aee:	75 1c                	jne    b0c <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 af0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 af3:	89 c7                	mov    %eax,%edi
 af5:	e8 ad fe ff ff       	call   9a7 <morecore>
 afa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 afe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b03:	75 07                	jne    b0c <malloc+0xfc>
        return 0;
 b05:	b8 00 00 00 00       	mov    $0x0,%eax
 b0a:	eb 18                	jmp    b24 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b18:	48 8b 00             	mov    (%rax),%rax
 b1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b1f:	e9 54 ff ff ff       	jmp    a78 <malloc+0x68>
  }
}
 b24:	c9                   	leave
 b25:	c3                   	ret
