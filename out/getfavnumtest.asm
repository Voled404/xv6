
fs/getfavnumtest:     file format elf64-x86-64


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
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int favnum = getfavnum();
  13:	e8 ea 03 00 00       	call   402 <getfavnum>
  18:	89 45 fc             	mov    %eax,-0x4(%rbp)
  printf(2, "%d\n", favnum);
  1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1e:	89 c2                	mov    %eax,%edx
  20:	48 c7 c6 11 0b 00 00 	mov    $0xb11,%rsi
  27:	bf 02 00 00 00       	mov    $0x2,%edi
  2c:	b8 00 00 00 00       	mov    $0x0,%eax
  31:	e8 c6 04 00 00       	call   4fc <printf>
  exit();
  36:	e8 17 03 00 00       	call   352 <exit>

000000000000003b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  3b:	55                   	push   %rbp
  3c:	48 89 e5             	mov    %rsp,%rbp
  3f:	48 83 ec 10          	sub    $0x10,%rsp
  43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  47:	89 75 f4             	mov    %esi,-0xc(%rbp)
  4a:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  4d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  51:	8b 55 f0             	mov    -0x10(%rbp),%edx
  54:	8b 45 f4             	mov    -0xc(%rbp),%eax
  57:	48 89 ce             	mov    %rcx,%rsi
  5a:	48 89 f7             	mov    %rsi,%rdi
  5d:	89 d1                	mov    %edx,%ecx
  5f:	fc                   	cld
  60:	f3 aa                	rep stos %al,%es:(%rdi)
  62:	89 ca                	mov    %ecx,%edx
  64:	48 89 fe             	mov    %rdi,%rsi
  67:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  6b:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  6e:	90                   	nop
  6f:	c9                   	leave
  70:	c3                   	ret

0000000000000071 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  71:	f3 0f 1e fa          	endbr64
  75:	55                   	push   %rbp
  76:	48 89 e5             	mov    %rsp,%rbp
  79:	48 83 ec 20          	sub    $0x20,%rsp
  7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  8d:	90                   	nop
  8e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  92:	48 8d 42 01          	lea    0x1(%rdx),%rax
  96:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  9e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  a2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  a6:	0f b6 12             	movzbl (%rdx),%edx
  a9:	88 10                	mov    %dl,(%rax)
  ab:	0f b6 00             	movzbl (%rax),%eax
  ae:	84 c0                	test   %al,%al
  b0:	75 dc                	jne    8e <strcpy+0x1d>
    ;
  return os;
  b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  b6:	c9                   	leave
  b7:	c3                   	ret

00000000000000b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b8:	f3 0f 1e fa          	endbr64
  bc:	55                   	push   %rbp
  bd:	48 89 e5             	mov    %rsp,%rbp
  c0:	48 83 ec 10          	sub    $0x10,%rsp
  c4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  c8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  cc:	eb 0a                	jmp    d8 <strcmp+0x20>
    p++, q++;
  ce:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  d3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  dc:	0f b6 00             	movzbl (%rax),%eax
  df:	84 c0                	test   %al,%al
  e1:	74 12                	je     f5 <strcmp+0x3d>
  e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  e7:	0f b6 10             	movzbl (%rax),%edx
  ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  ee:	0f b6 00             	movzbl (%rax),%eax
  f1:	38 c2                	cmp    %al,%dl
  f3:	74 d9                	je     ce <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
  f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  f9:	0f b6 00             	movzbl (%rax),%eax
  fc:	0f b6 d0             	movzbl %al,%edx
  ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 103:	0f b6 00             	movzbl (%rax),%eax
 106:	0f b6 c0             	movzbl %al,%eax
 109:	29 c2                	sub    %eax,%edx
 10b:	89 d0                	mov    %edx,%eax
}
 10d:	c9                   	leave
 10e:	c3                   	ret

000000000000010f <strlen>:

uint
strlen(char *s)
{
 10f:	f3 0f 1e fa          	endbr64
 113:	55                   	push   %rbp
 114:	48 89 e5             	mov    %rsp,%rbp
 117:	48 83 ec 18          	sub    $0x18,%rsp
 11b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 11f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 126:	eb 04                	jmp    12c <strlen+0x1d>
 128:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 12c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 12f:	48 63 d0             	movslq %eax,%rdx
 132:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 136:	48 01 d0             	add    %rdx,%rax
 139:	0f b6 00             	movzbl (%rax),%eax
 13c:	84 c0                	test   %al,%al
 13e:	75 e8                	jne    128 <strlen+0x19>
    ;
  return n;
 140:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 143:	c9                   	leave
 144:	c3                   	ret

0000000000000145 <memset>:

void*
memset(void *dst, int c, uint n)
{
 145:	f3 0f 1e fa          	endbr64
 149:	55                   	push   %rbp
 14a:	48 89 e5             	mov    %rsp,%rbp
 14d:	48 83 ec 10          	sub    $0x10,%rsp
 151:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 155:	89 75 f4             	mov    %esi,-0xc(%rbp)
 158:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 15b:	8b 55 f0             	mov    -0x10(%rbp),%edx
 15e:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 161:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 165:	89 ce                	mov    %ecx,%esi
 167:	48 89 c7             	mov    %rax,%rdi
 16a:	e8 cc fe ff ff       	call   3b <stosb>
  return dst;
 16f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 173:	c9                   	leave
 174:	c3                   	ret

0000000000000175 <strchr>:

char*
strchr(const char *s, char c)
{
 175:	f3 0f 1e fa          	endbr64
 179:	55                   	push   %rbp
 17a:	48 89 e5             	mov    %rsp,%rbp
 17d:	48 83 ec 10          	sub    $0x10,%rsp
 181:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 185:	89 f0                	mov    %esi,%eax
 187:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 18a:	eb 17                	jmp    1a3 <strchr+0x2e>
    if(*s == c)
 18c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 190:	0f b6 00             	movzbl (%rax),%eax
 193:	38 45 f4             	cmp    %al,-0xc(%rbp)
 196:	75 06                	jne    19e <strchr+0x29>
      return (char*)s;
 198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 19c:	eb 15                	jmp    1b3 <strchr+0x3e>
  for(; *s; s++)
 19e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a7:	0f b6 00             	movzbl (%rax),%eax
 1aa:	84 c0                	test   %al,%al
 1ac:	75 de                	jne    18c <strchr+0x17>
  return 0;
 1ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b3:	c9                   	leave
 1b4:	c3                   	ret

00000000000001b5 <gets>:

char*
gets(char *buf, int max)
{
 1b5:	f3 0f 1e fa          	endbr64
 1b9:	55                   	push   %rbp
 1ba:	48 89 e5             	mov    %rsp,%rbp
 1bd:	48 83 ec 20          	sub    $0x20,%rsp
 1c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1c5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1cf:	eb 48                	jmp    219 <gets+0x64>
    cc = read(0, &c, 1);
 1d1:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1d5:	ba 01 00 00 00       	mov    $0x1,%edx
 1da:	48 89 c6             	mov    %rax,%rsi
 1dd:	bf 00 00 00 00       	mov    $0x0,%edi
 1e2:	e8 83 01 00 00       	call   36a <read>
 1e7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1ea:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1ee:	7e 36                	jle    226 <gets+0x71>
      break;
    buf[i++] = c;
 1f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f3:	8d 50 01             	lea    0x1(%rax),%edx
 1f6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1f9:	48 63 d0             	movslq %eax,%rdx
 1fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 200:	48 01 c2             	add    %rax,%rdx
 203:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 207:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 209:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 20d:	3c 0a                	cmp    $0xa,%al
 20f:	74 16                	je     227 <gets+0x72>
 211:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 215:	3c 0d                	cmp    $0xd,%al
 217:	74 0e                	je     227 <gets+0x72>
  for(i=0; i+1 < max; ){
 219:	8b 45 fc             	mov    -0x4(%rbp),%eax
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 222:	7f ad                	jg     1d1 <gets+0x1c>
 224:	eb 01                	jmp    227 <gets+0x72>
      break;
 226:	90                   	nop
      break;
  }
  buf[i] = '\0';
 227:	8b 45 fc             	mov    -0x4(%rbp),%eax
 22a:	48 63 d0             	movslq %eax,%rdx
 22d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 231:	48 01 d0             	add    %rdx,%rax
 234:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 237:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 23b:	c9                   	leave
 23c:	c3                   	ret

000000000000023d <stat>:

int
stat(char *n, struct stat *st)
{
 23d:	f3 0f 1e fa          	endbr64
 241:	55                   	push   %rbp
 242:	48 89 e5             	mov    %rsp,%rbp
 245:	48 83 ec 20          	sub    $0x20,%rsp
 249:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 24d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 251:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 255:	be 00 00 00 00       	mov    $0x0,%esi
 25a:	48 89 c7             	mov    %rax,%rdi
 25d:	e8 30 01 00 00       	call   392 <open>
 262:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 265:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 269:	79 07                	jns    272 <stat+0x35>
    return -1;
 26b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 270:	eb 21                	jmp    293 <stat+0x56>
  r = fstat(fd, st);
 272:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 276:	8b 45 fc             	mov    -0x4(%rbp),%eax
 279:	48 89 d6             	mov    %rdx,%rsi
 27c:	89 c7                	mov    %eax,%edi
 27e:	e8 27 01 00 00       	call   3aa <fstat>
 283:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 286:	8b 45 fc             	mov    -0x4(%rbp),%eax
 289:	89 c7                	mov    %eax,%edi
 28b:	e8 ea 00 00 00       	call   37a <close>
  return r;
 290:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 293:	c9                   	leave
 294:	c3                   	ret

0000000000000295 <atoi>:

int
atoi(const char *s)
{
 295:	f3 0f 1e fa          	endbr64
 299:	55                   	push   %rbp
 29a:	48 89 e5             	mov    %rsp,%rbp
 29d:	48 83 ec 18          	sub    $0x18,%rsp
 2a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2ac:	eb 28                	jmp    2d6 <atoi+0x41>
    n = n*10 + *s++ - '0';
 2ae:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2b1:	89 d0                	mov    %edx,%eax
 2b3:	c1 e0 02             	shl    $0x2,%eax
 2b6:	01 d0                	add    %edx,%eax
 2b8:	01 c0                	add    %eax,%eax
 2ba:	89 c1                	mov    %eax,%ecx
 2bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2c0:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2c4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2c8:	0f b6 00             	movzbl (%rax),%eax
 2cb:	0f be c0             	movsbl %al,%eax
 2ce:	01 c8                	add    %ecx,%eax
 2d0:	83 e8 30             	sub    $0x30,%eax
 2d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2da:	0f b6 00             	movzbl (%rax),%eax
 2dd:	3c 2f                	cmp    $0x2f,%al
 2df:	7e 0b                	jle    2ec <atoi+0x57>
 2e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2e5:	0f b6 00             	movzbl (%rax),%eax
 2e8:	3c 39                	cmp    $0x39,%al
 2ea:	7e c2                	jle    2ae <atoi+0x19>
  return n;
 2ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2ef:	c9                   	leave
 2f0:	c3                   	ret

00000000000002f1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f1:	f3 0f 1e fa          	endbr64
 2f5:	55                   	push   %rbp
 2f6:	48 89 e5             	mov    %rsp,%rbp
 2f9:	48 83 ec 28          	sub    $0x28,%rsp
 2fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 301:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 305:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 308:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 30c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 310:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 314:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 318:	eb 1d                	jmp    337 <memmove+0x46>
    *dst++ = *src++;
 31a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 31e:	48 8d 42 01          	lea    0x1(%rdx),%rax
 322:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 326:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 32a:	48 8d 48 01          	lea    0x1(%rax),%rcx
 32e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 332:	0f b6 12             	movzbl (%rdx),%edx
 335:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 337:	8b 45 dc             	mov    -0x24(%rbp),%eax
 33a:	8d 50 ff             	lea    -0x1(%rax),%edx
 33d:	89 55 dc             	mov    %edx,-0x24(%rbp)
 340:	85 c0                	test   %eax,%eax
 342:	7f d6                	jg     31a <memmove+0x29>
  return vdst;
 344:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 348:	c9                   	leave
 349:	c3                   	ret

000000000000034a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34a:	b8 01 00 00 00       	mov    $0x1,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

0000000000000352 <exit>:
SYSCALL(exit)
 352:	b8 02 00 00 00       	mov    $0x2,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

000000000000035a <wait>:
SYSCALL(wait)
 35a:	b8 03 00 00 00       	mov    $0x3,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

0000000000000362 <pipe>:
SYSCALL(pipe)
 362:	b8 04 00 00 00       	mov    $0x4,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

000000000000036a <read>:
SYSCALL(read)
 36a:	b8 05 00 00 00       	mov    $0x5,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

0000000000000372 <write>:
SYSCALL(write)
 372:	b8 10 00 00 00       	mov    $0x10,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

000000000000037a <close>:
SYSCALL(close)
 37a:	b8 15 00 00 00       	mov    $0x15,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

0000000000000382 <kill>:
SYSCALL(kill)
 382:	b8 06 00 00 00       	mov    $0x6,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

000000000000038a <exec>:
SYSCALL(exec)
 38a:	b8 07 00 00 00       	mov    $0x7,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

0000000000000392 <open>:
SYSCALL(open)
 392:	b8 0f 00 00 00       	mov    $0xf,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

000000000000039a <mknod>:
SYSCALL(mknod)
 39a:	b8 11 00 00 00       	mov    $0x11,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

00000000000003a2 <unlink>:
SYSCALL(unlink)
 3a2:	b8 12 00 00 00       	mov    $0x12,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

00000000000003aa <fstat>:
SYSCALL(fstat)
 3aa:	b8 08 00 00 00       	mov    $0x8,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

00000000000003b2 <link>:
SYSCALL(link)
 3b2:	b8 13 00 00 00       	mov    $0x13,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

00000000000003ba <mkdir>:
SYSCALL(mkdir)
 3ba:	b8 14 00 00 00       	mov    $0x14,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

00000000000003c2 <chdir>:
SYSCALL(chdir)
 3c2:	b8 09 00 00 00       	mov    $0x9,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

00000000000003ca <dup>:
SYSCALL(dup)
 3ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

00000000000003d2 <getpid>:
SYSCALL(getpid)
 3d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

00000000000003da <sbrk>:
SYSCALL(sbrk)
 3da:	b8 0c 00 00 00       	mov    $0xc,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

00000000000003e2 <sleep>:
SYSCALL(sleep)
 3e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

00000000000003ea <uptime>:
SYSCALL(uptime)
 3ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

00000000000003f2 <getpinfo>:
SYSCALL(getpinfo)
 3f2:	b8 18 00 00 00       	mov    $0x18,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

00000000000003fa <settickets>:
SYSCALL(settickets)
 3fa:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

0000000000000402 <getfavnum>:
SYSCALL(getfavnum)
 402:	b8 1c 00 00 00       	mov    $0x1c,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

000000000000040a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40a:	f3 0f 1e fa          	endbr64
 40e:	55                   	push   %rbp
 40f:	48 89 e5             	mov    %rsp,%rbp
 412:	48 83 ec 10          	sub    $0x10,%rsp
 416:	89 7d fc             	mov    %edi,-0x4(%rbp)
 419:	89 f0                	mov    %esi,%eax
 41b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 41e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 422:	8b 45 fc             	mov    -0x4(%rbp),%eax
 425:	ba 01 00 00 00       	mov    $0x1,%edx
 42a:	48 89 ce             	mov    %rcx,%rsi
 42d:	89 c7                	mov    %eax,%edi
 42f:	e8 3e ff ff ff       	call   372 <write>
}
 434:	90                   	nop
 435:	c9                   	leave
 436:	c3                   	ret

0000000000000437 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 437:	f3 0f 1e fa          	endbr64
 43b:	55                   	push   %rbp
 43c:	48 89 e5             	mov    %rsp,%rbp
 43f:	48 83 ec 30          	sub    $0x30,%rsp
 443:	89 7d dc             	mov    %edi,-0x24(%rbp)
 446:	89 75 d8             	mov    %esi,-0x28(%rbp)
 449:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 44c:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 44f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 456:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 45a:	74 17                	je     473 <printint+0x3c>
 45c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 460:	79 11                	jns    473 <printint+0x3c>
    neg = 1;
 462:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 469:	8b 45 d8             	mov    -0x28(%rbp),%eax
 46c:	f7 d8                	neg    %eax
 46e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 471:	eb 06                	jmp    479 <printint+0x42>
  } else {
    x = xx;
 473:	8b 45 d8             	mov    -0x28(%rbp),%eax
 476:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 480:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 483:	8b 45 f4             	mov    -0xc(%rbp),%eax
 486:	ba 00 00 00 00       	mov    $0x0,%edx
 48b:	f7 f6                	div    %esi
 48d:	89 d1                	mov    %edx,%ecx
 48f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 492:	8d 50 01             	lea    0x1(%rax),%edx
 495:	89 55 fc             	mov    %edx,-0x4(%rbp)
 498:	89 ca                	mov    %ecx,%edx
 49a:	0f b6 92 60 0d 00 00 	movzbl 0xd60(%rdx),%edx
 4a1:	48 98                	cltq
 4a3:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4a7:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4ad:	ba 00 00 00 00       	mov    $0x0,%edx
 4b2:	f7 f7                	div    %edi
 4b4:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4bb:	75 c3                	jne    480 <printint+0x49>
  if(neg)
 4bd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4c1:	74 2b                	je     4ee <printint+0xb7>
    buf[i++] = '-';
 4c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c6:	8d 50 01             	lea    0x1(%rax),%edx
 4c9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4cc:	48 98                	cltq
 4ce:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4d3:	eb 19                	jmp    4ee <printint+0xb7>
    putc(fd, buf[i]);
 4d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d8:	48 98                	cltq
 4da:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4df:	0f be d0             	movsbl %al,%edx
 4e2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4e5:	89 d6                	mov    %edx,%esi
 4e7:	89 c7                	mov    %eax,%edi
 4e9:	e8 1c ff ff ff       	call   40a <putc>
  while(--i >= 0)
 4ee:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4f6:	79 dd                	jns    4d5 <printint+0x9e>
}
 4f8:	90                   	nop
 4f9:	90                   	nop
 4fa:	c9                   	leave
 4fb:	c3                   	ret

00000000000004fc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4fc:	f3 0f 1e fa          	endbr64
 500:	55                   	push   %rbp
 501:	48 89 e5             	mov    %rsp,%rbp
 504:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 50b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 511:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 518:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 51f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 526:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 52d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 534:	84 c0                	test   %al,%al
 536:	74 20                	je     558 <printf+0x5c>
 538:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 53c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 540:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 544:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 548:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 54c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 550:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 554:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 558:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 55f:	00 00 00 
 562:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 569:	00 00 00 
 56c:	48 8d 45 10          	lea    0x10(%rbp),%rax
 570:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 577:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 57e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 585:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 58c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 58f:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 596:	00 00 00 
 599:	e9 a8 02 00 00       	jmp    846 <printf+0x34a>
    c = fmt[i] & 0xff;
 59e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5a4:	48 63 d0             	movslq %eax,%rdx
 5a7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5ae:	48 01 d0             	add    %rdx,%rax
 5b1:	0f b6 00             	movzbl (%rax),%eax
 5b4:	0f be c0             	movsbl %al,%eax
 5b7:	25 ff 00 00 00       	and    $0xff,%eax
 5bc:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5c2:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5c9:	75 35                	jne    600 <printf+0x104>
      if(c == '%'){
 5cb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5d2:	75 0f                	jne    5e3 <printf+0xe7>
        state = '%';
 5d4:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5db:	00 00 00 
 5de:	e9 5c 02 00 00       	jmp    83f <printf+0x343>
      } else {
        putc(fd, c);
 5e3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5e9:	0f be d0             	movsbl %al,%edx
 5ec:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5f2:	89 d6                	mov    %edx,%esi
 5f4:	89 c7                	mov    %eax,%edi
 5f6:	e8 0f fe ff ff       	call   40a <putc>
 5fb:	e9 3f 02 00 00       	jmp    83f <printf+0x343>
      }
    } else if(state == '%'){
 600:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 607:	0f 85 32 02 00 00    	jne    83f <printf+0x343>
      if(c == 'd'){
 60d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 614:	75 5e                	jne    674 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 616:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 61c:	83 f8 2f             	cmp    $0x2f,%eax
 61f:	77 23                	ja     644 <printf+0x148>
 621:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 628:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 62e:	89 d2                	mov    %edx,%edx
 630:	48 01 d0             	add    %rdx,%rax
 633:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 639:	83 c2 08             	add    $0x8,%edx
 63c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 642:	eb 12                	jmp    656 <printf+0x15a>
 644:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 64b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 64f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 656:	8b 30                	mov    (%rax),%esi
 658:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 65e:	b9 01 00 00 00       	mov    $0x1,%ecx
 663:	ba 0a 00 00 00       	mov    $0xa,%edx
 668:	89 c7                	mov    %eax,%edi
 66a:	e8 c8 fd ff ff       	call   437 <printint>
 66f:	e9 c1 01 00 00       	jmp    835 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 674:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 67b:	74 09                	je     686 <printf+0x18a>
 67d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 684:	75 5e                	jne    6e4 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 686:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 68c:	83 f8 2f             	cmp    $0x2f,%eax
 68f:	77 23                	ja     6b4 <printf+0x1b8>
 691:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 698:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69e:	89 d2                	mov    %edx,%edx
 6a0:	48 01 d0             	add    %rdx,%rax
 6a3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a9:	83 c2 08             	add    $0x8,%edx
 6ac:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6b2:	eb 12                	jmp    6c6 <printf+0x1ca>
 6b4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6bb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6bf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6c6:	8b 30                	mov    (%rax),%esi
 6c8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ce:	b9 00 00 00 00       	mov    $0x0,%ecx
 6d3:	ba 10 00 00 00       	mov    $0x10,%edx
 6d8:	89 c7                	mov    %eax,%edi
 6da:	e8 58 fd ff ff       	call   437 <printint>
 6df:	e9 51 01 00 00       	jmp    835 <printf+0x339>
      } else if(c == 's'){
 6e4:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6eb:	0f 85 98 00 00 00    	jne    789 <printf+0x28d>
        s = va_arg(ap, char*);
 6f1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f7:	83 f8 2f             	cmp    $0x2f,%eax
 6fa:	77 23                	ja     71f <printf+0x223>
 6fc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 703:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 709:	89 d2                	mov    %edx,%edx
 70b:	48 01 d0             	add    %rdx,%rax
 70e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 714:	83 c2 08             	add    $0x8,%edx
 717:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 71d:	eb 12                	jmp    731 <printf+0x235>
 71f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 726:	48 8d 50 08          	lea    0x8(%rax),%rdx
 72a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 731:	48 8b 00             	mov    (%rax),%rax
 734:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 73b:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 742:	00 
 743:	75 31                	jne    776 <printf+0x27a>
          s = "(null)";
 745:	48 c7 85 48 ff ff ff 	movq   $0xb15,-0xb8(%rbp)
 74c:	15 0b 00 00 
        while(*s != 0){
 750:	eb 24                	jmp    776 <printf+0x27a>
          putc(fd, *s);
 752:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 759:	0f b6 00             	movzbl (%rax),%eax
 75c:	0f be d0             	movsbl %al,%edx
 75f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 765:	89 d6                	mov    %edx,%esi
 767:	89 c7                	mov    %eax,%edi
 769:	e8 9c fc ff ff       	call   40a <putc>
          s++;
 76e:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 775:	01 
        while(*s != 0){
 776:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 77d:	0f b6 00             	movzbl (%rax),%eax
 780:	84 c0                	test   %al,%al
 782:	75 ce                	jne    752 <printf+0x256>
 784:	e9 ac 00 00 00       	jmp    835 <printf+0x339>
        }
      } else if(c == 'c'){
 789:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 790:	75 56                	jne    7e8 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 792:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 798:	83 f8 2f             	cmp    $0x2f,%eax
 79b:	77 23                	ja     7c0 <printf+0x2c4>
 79d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7a4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7aa:	89 d2                	mov    %edx,%edx
 7ac:	48 01 d0             	add    %rdx,%rax
 7af:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7b5:	83 c2 08             	add    $0x8,%edx
 7b8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7be:	eb 12                	jmp    7d2 <printf+0x2d6>
 7c0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7c7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7cb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7d2:	8b 00                	mov    (%rax),%eax
 7d4:	0f be d0             	movsbl %al,%edx
 7d7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7dd:	89 d6                	mov    %edx,%esi
 7df:	89 c7                	mov    %eax,%edi
 7e1:	e8 24 fc ff ff       	call   40a <putc>
 7e6:	eb 4d                	jmp    835 <printf+0x339>
      } else if(c == '%'){
 7e8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7ef:	75 1a                	jne    80b <printf+0x30f>
        putc(fd, c);
 7f1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7f7:	0f be d0             	movsbl %al,%edx
 7fa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 800:	89 d6                	mov    %edx,%esi
 802:	89 c7                	mov    %eax,%edi
 804:	e8 01 fc ff ff       	call   40a <putc>
 809:	eb 2a                	jmp    835 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 80b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 811:	be 25 00 00 00       	mov    $0x25,%esi
 816:	89 c7                	mov    %eax,%edi
 818:	e8 ed fb ff ff       	call   40a <putc>
        putc(fd, c);
 81d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 823:	0f be d0             	movsbl %al,%edx
 826:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 82c:	89 d6                	mov    %edx,%esi
 82e:	89 c7                	mov    %eax,%edi
 830:	e8 d5 fb ff ff       	call   40a <putc>
      }
      state = 0;
 835:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 83c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 83f:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 846:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 84c:	48 63 d0             	movslq %eax,%rdx
 84f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 856:	48 01 d0             	add    %rdx,%rax
 859:	0f b6 00             	movzbl (%rax),%eax
 85c:	84 c0                	test   %al,%al
 85e:	0f 85 3a fd ff ff    	jne    59e <printf+0xa2>
    }
  }
}
 864:	90                   	nop
 865:	90                   	nop
 866:	c9                   	leave
 867:	c3                   	ret

0000000000000868 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 868:	f3 0f 1e fa          	endbr64
 86c:	55                   	push   %rbp
 86d:	48 89 e5             	mov    %rsp,%rbp
 870:	48 83 ec 18          	sub    $0x18,%rsp
 874:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 878:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 87c:	48 83 e8 10          	sub    $0x10,%rax
 880:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	48 8b 05 05 05 00 00 	mov    0x505(%rip),%rax        # d90 <freep>
 88b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 88f:	eb 2f                	jmp    8c0 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 891:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 895:	48 8b 00             	mov    (%rax),%rax
 898:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 89c:	72 17                	jb     8b5 <free+0x4d>
 89e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a6:	72 2f                	jb     8d7 <free+0x6f>
 8a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ac:	48 8b 00             	mov    (%rax),%rax
 8af:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8b3:	72 22                	jb     8d7 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b9:	48 8b 00             	mov    (%rax),%rax
 8bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8c8:	73 c7                	jae    891 <free+0x29>
 8ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ce:	48 8b 00             	mov    (%rax),%rax
 8d1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8d5:	73 ba                	jae    891 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8db:	8b 40 08             	mov    0x8(%rax),%eax
 8de:	89 c0                	mov    %eax,%eax
 8e0:	48 c1 e0 04          	shl    $0x4,%rax
 8e4:	48 89 c2             	mov    %rax,%rdx
 8e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8eb:	48 01 c2             	add    %rax,%rdx
 8ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f2:	48 8b 00             	mov    (%rax),%rax
 8f5:	48 39 c2             	cmp    %rax,%rdx
 8f8:	75 2d                	jne    927 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 8fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fe:	8b 50 08             	mov    0x8(%rax),%edx
 901:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 905:	48 8b 00             	mov    (%rax),%rax
 908:	8b 40 08             	mov    0x8(%rax),%eax
 90b:	01 c2                	add    %eax,%edx
 90d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 911:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 914:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 918:	48 8b 00             	mov    (%rax),%rax
 91b:	48 8b 10             	mov    (%rax),%rdx
 91e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 922:	48 89 10             	mov    %rdx,(%rax)
 925:	eb 0e                	jmp    935 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 927:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92b:	48 8b 10             	mov    (%rax),%rdx
 92e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 932:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 935:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 939:	8b 40 08             	mov    0x8(%rax),%eax
 93c:	89 c0                	mov    %eax,%eax
 93e:	48 c1 e0 04          	shl    $0x4,%rax
 942:	48 89 c2             	mov    %rax,%rdx
 945:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 949:	48 01 d0             	add    %rdx,%rax
 94c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 950:	75 27                	jne    979 <free+0x111>
    p->s.size += bp->s.size;
 952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 956:	8b 50 08             	mov    0x8(%rax),%edx
 959:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95d:	8b 40 08             	mov    0x8(%rax),%eax
 960:	01 c2                	add    %eax,%edx
 962:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 966:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 969:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96d:	48 8b 10             	mov    (%rax),%rdx
 970:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 974:	48 89 10             	mov    %rdx,(%rax)
 977:	eb 0b                	jmp    984 <free+0x11c>
  } else
    p->s.ptr = bp;
 979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 981:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 988:	48 89 05 01 04 00 00 	mov    %rax,0x401(%rip)        # d90 <freep>
}
 98f:	90                   	nop
 990:	c9                   	leave
 991:	c3                   	ret

0000000000000992 <morecore>:

static Header*
morecore(uint nu)
{
 992:	f3 0f 1e fa          	endbr64
 996:	55                   	push   %rbp
 997:	48 89 e5             	mov    %rsp,%rbp
 99a:	48 83 ec 20          	sub    $0x20,%rsp
 99e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9a1:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9a8:	77 07                	ja     9b1 <morecore+0x1f>
    nu = 4096;
 9aa:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9b1:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9b4:	c1 e0 04             	shl    $0x4,%eax
 9b7:	89 c7                	mov    %eax,%edi
 9b9:	e8 1c fa ff ff       	call   3da <sbrk>
 9be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9c2:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9c7:	75 07                	jne    9d0 <morecore+0x3e>
    return 0;
 9c9:	b8 00 00 00 00       	mov    $0x0,%eax
 9ce:	eb 29                	jmp    9f9 <morecore+0x67>
  hp = (Header*)p;
 9d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9dc:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9df:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e6:	48 83 c0 10          	add    $0x10,%rax
 9ea:	48 89 c7             	mov    %rax,%rdi
 9ed:	e8 76 fe ff ff       	call   868 <free>
  return freep;
 9f2:	48 8b 05 97 03 00 00 	mov    0x397(%rip),%rax        # d90 <freep>
}
 9f9:	c9                   	leave
 9fa:	c3                   	ret

00000000000009fb <malloc>:

void*
malloc(uint nbytes)
{
 9fb:	f3 0f 1e fa          	endbr64
 9ff:	55                   	push   %rbp
 a00:	48 89 e5             	mov    %rsp,%rbp
 a03:	48 83 ec 30          	sub    $0x30,%rsp
 a07:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a0d:	48 83 c0 0f          	add    $0xf,%rax
 a11:	48 c1 e8 04          	shr    $0x4,%rax
 a15:	83 c0 01             	add    $0x1,%eax
 a18:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a1b:	48 8b 05 6e 03 00 00 	mov    0x36e(%rip),%rax        # d90 <freep>
 a22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a26:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a2b:	75 2b                	jne    a58 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a2d:	48 c7 45 f0 80 0d 00 	movq   $0xd80,-0x10(%rbp)
 a34:	00 
 a35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a39:	48 89 05 50 03 00 00 	mov    %rax,0x350(%rip)        # d90 <freep>
 a40:	48 8b 05 49 03 00 00 	mov    0x349(%rip),%rax        # d90 <freep>
 a47:	48 89 05 32 03 00 00 	mov    %rax,0x332(%rip)        # d80 <base>
    base.s.size = 0;
 a4e:	c7 05 30 03 00 00 00 	movl   $0x0,0x330(%rip)        # d88 <base+0x8>
 a55:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a5c:	48 8b 00             	mov    (%rax),%rax
 a5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a67:	8b 40 08             	mov    0x8(%rax),%eax
 a6a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a6d:	72 5f                	jb     ace <malloc+0xd3>
      if(p->s.size == nunits)
 a6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a73:	8b 40 08             	mov    0x8(%rax),%eax
 a76:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a79:	75 10                	jne    a8b <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	48 8b 10             	mov    (%rax),%rdx
 a82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a86:	48 89 10             	mov    %rdx,(%rax)
 a89:	eb 2e                	jmp    ab9 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8f:	8b 40 08             	mov    0x8(%rax),%eax
 a92:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a95:	89 c2                	mov    %eax,%edx
 a97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa2:	8b 40 08             	mov    0x8(%rax),%eax
 aa5:	89 c0                	mov    %eax,%eax
 aa7:	48 c1 e0 04          	shl    $0x4,%rax
 aab:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab3:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ab6:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ab9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 abd:	48 89 05 cc 02 00 00 	mov    %rax,0x2cc(%rip)        # d90 <freep>
      return (void*)(p + 1);
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	48 83 c0 10          	add    $0x10,%rax
 acc:	eb 41                	jmp    b0f <malloc+0x114>
    }
    if(p == freep)
 ace:	48 8b 05 bb 02 00 00 	mov    0x2bb(%rip),%rax        # d90 <freep>
 ad5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ad9:	75 1c                	jne    af7 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 adb:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ade:	89 c7                	mov    %eax,%edi
 ae0:	e8 ad fe ff ff       	call   992 <morecore>
 ae5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ae9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 aee:	75 07                	jne    af7 <malloc+0xfc>
        return 0;
 af0:	b8 00 00 00 00       	mov    $0x0,%eax
 af5:	eb 18                	jmp    b0f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 aff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b03:	48 8b 00             	mov    (%rax),%rax
 b06:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b0a:	e9 54 ff ff ff       	jmp    a63 <malloc+0x68>
  }
}
 b0f:	c9                   	leave
 b10:	c3                   	ret
