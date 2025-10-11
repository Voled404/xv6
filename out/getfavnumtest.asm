
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
  20:	48 c7 c6 19 0b 00 00 	mov    $0xb19,%rsi
  27:	bf 02 00 00 00       	mov    $0x2,%edi
  2c:	b8 00 00 00 00       	mov    $0x0,%eax
  31:	e8 ce 04 00 00       	call   504 <printf>
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

000000000000040a <halt>:
SYSCALL(halt)
 40a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

0000000000000412 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 412:	f3 0f 1e fa          	endbr64
 416:	55                   	push   %rbp
 417:	48 89 e5             	mov    %rsp,%rbp
 41a:	48 83 ec 10          	sub    $0x10,%rsp
 41e:	89 7d fc             	mov    %edi,-0x4(%rbp)
 421:	89 f0                	mov    %esi,%eax
 423:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 426:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 42a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 42d:	ba 01 00 00 00       	mov    $0x1,%edx
 432:	48 89 ce             	mov    %rcx,%rsi
 435:	89 c7                	mov    %eax,%edi
 437:	e8 36 ff ff ff       	call   372 <write>
}
 43c:	90                   	nop
 43d:	c9                   	leave
 43e:	c3                   	ret

000000000000043f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43f:	f3 0f 1e fa          	endbr64
 443:	55                   	push   %rbp
 444:	48 89 e5             	mov    %rsp,%rbp
 447:	48 83 ec 30          	sub    $0x30,%rsp
 44b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 44e:	89 75 d8             	mov    %esi,-0x28(%rbp)
 451:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 454:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 45e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 462:	74 17                	je     47b <printint+0x3c>
 464:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 468:	79 11                	jns    47b <printint+0x3c>
    neg = 1;
 46a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 471:	8b 45 d8             	mov    -0x28(%rbp),%eax
 474:	f7 d8                	neg    %eax
 476:	89 45 f4             	mov    %eax,-0xc(%rbp)
 479:	eb 06                	jmp    481 <printint+0x42>
  } else {
    x = xx;
 47b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 47e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 481:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 488:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 48b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 48e:	ba 00 00 00 00       	mov    $0x0,%edx
 493:	f7 f6                	div    %esi
 495:	89 d1                	mov    %edx,%ecx
 497:	8b 45 fc             	mov    -0x4(%rbp),%eax
 49a:	8d 50 01             	lea    0x1(%rax),%edx
 49d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4a0:	89 ca                	mov    %ecx,%edx
 4a2:	0f b6 92 60 0d 00 00 	movzbl 0xd60(%rdx),%edx
 4a9:	48 98                	cltq
 4ab:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4af:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4b2:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4b5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ba:	f7 f7                	div    %edi
 4bc:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4c3:	75 c3                	jne    488 <printint+0x49>
  if(neg)
 4c5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4c9:	74 2b                	je     4f6 <printint+0xb7>
    buf[i++] = '-';
 4cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ce:	8d 50 01             	lea    0x1(%rax),%edx
 4d1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4d4:	48 98                	cltq
 4d6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4db:	eb 19                	jmp    4f6 <printint+0xb7>
    putc(fd, buf[i]);
 4dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e0:	48 98                	cltq
 4e2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4e7:	0f be d0             	movsbl %al,%edx
 4ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4ed:	89 d6                	mov    %edx,%esi
 4ef:	89 c7                	mov    %eax,%edi
 4f1:	e8 1c ff ff ff       	call   412 <putc>
  while(--i >= 0)
 4f6:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4fa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4fe:	79 dd                	jns    4dd <printint+0x9e>
}
 500:	90                   	nop
 501:	90                   	nop
 502:	c9                   	leave
 503:	c3                   	ret

0000000000000504 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 504:	f3 0f 1e fa          	endbr64
 508:	55                   	push   %rbp
 509:	48 89 e5             	mov    %rsp,%rbp
 50c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 513:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 519:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 520:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 527:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 52e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 535:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 53c:	84 c0                	test   %al,%al
 53e:	74 20                	je     560 <printf+0x5c>
 540:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 544:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 548:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 54c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 550:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 554:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 558:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 55c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 560:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 567:	00 00 00 
 56a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 571:	00 00 00 
 574:	48 8d 45 10          	lea    0x10(%rbp),%rax
 578:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 57f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 586:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 58d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 594:	00 00 00 
  for(i = 0; fmt[i]; i++){
 597:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 59e:	00 00 00 
 5a1:	e9 a8 02 00 00       	jmp    84e <printf+0x34a>
    c = fmt[i] & 0xff;
 5a6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5ac:	48 63 d0             	movslq %eax,%rdx
 5af:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5b6:	48 01 d0             	add    %rdx,%rax
 5b9:	0f b6 00             	movzbl (%rax),%eax
 5bc:	0f be c0             	movsbl %al,%eax
 5bf:	25 ff 00 00 00       	and    $0xff,%eax
 5c4:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5ca:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5d1:	75 35                	jne    608 <printf+0x104>
      if(c == '%'){
 5d3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5da:	75 0f                	jne    5eb <printf+0xe7>
        state = '%';
 5dc:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5e3:	00 00 00 
 5e6:	e9 5c 02 00 00       	jmp    847 <printf+0x343>
      } else {
        putc(fd, c);
 5eb:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5f1:	0f be d0             	movsbl %al,%edx
 5f4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5fa:	89 d6                	mov    %edx,%esi
 5fc:	89 c7                	mov    %eax,%edi
 5fe:	e8 0f fe ff ff       	call   412 <putc>
 603:	e9 3f 02 00 00       	jmp    847 <printf+0x343>
      }
    } else if(state == '%'){
 608:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 60f:	0f 85 32 02 00 00    	jne    847 <printf+0x343>
      if(c == 'd'){
 615:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 61c:	75 5e                	jne    67c <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 61e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 624:	83 f8 2f             	cmp    $0x2f,%eax
 627:	77 23                	ja     64c <printf+0x148>
 629:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 630:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 636:	89 d2                	mov    %edx,%edx
 638:	48 01 d0             	add    %rdx,%rax
 63b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 641:	83 c2 08             	add    $0x8,%edx
 644:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 64a:	eb 12                	jmp    65e <printf+0x15a>
 64c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 653:	48 8d 50 08          	lea    0x8(%rax),%rdx
 657:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 65e:	8b 30                	mov    (%rax),%esi
 660:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 666:	b9 01 00 00 00       	mov    $0x1,%ecx
 66b:	ba 0a 00 00 00       	mov    $0xa,%edx
 670:	89 c7                	mov    %eax,%edi
 672:	e8 c8 fd ff ff       	call   43f <printint>
 677:	e9 c1 01 00 00       	jmp    83d <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 67c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 683:	74 09                	je     68e <printf+0x18a>
 685:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 68c:	75 5e                	jne    6ec <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 68e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 694:	83 f8 2f             	cmp    $0x2f,%eax
 697:	77 23                	ja     6bc <printf+0x1b8>
 699:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a6:	89 d2                	mov    %edx,%edx
 6a8:	48 01 d0             	add    %rdx,%rax
 6ab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b1:	83 c2 08             	add    $0x8,%edx
 6b4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6ba:	eb 12                	jmp    6ce <printf+0x1ca>
 6bc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6c3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6c7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ce:	8b 30                	mov    (%rax),%esi
 6d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6d6:	b9 00 00 00 00       	mov    $0x0,%ecx
 6db:	ba 10 00 00 00       	mov    $0x10,%edx
 6e0:	89 c7                	mov    %eax,%edi
 6e2:	e8 58 fd ff ff       	call   43f <printint>
 6e7:	e9 51 01 00 00       	jmp    83d <printf+0x339>
      } else if(c == 's'){
 6ec:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6f3:	0f 85 98 00 00 00    	jne    791 <printf+0x28d>
        s = va_arg(ap, char*);
 6f9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6ff:	83 f8 2f             	cmp    $0x2f,%eax
 702:	77 23                	ja     727 <printf+0x223>
 704:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 70b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 711:	89 d2                	mov    %edx,%edx
 713:	48 01 d0             	add    %rdx,%rax
 716:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71c:	83 c2 08             	add    $0x8,%edx
 71f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 725:	eb 12                	jmp    739 <printf+0x235>
 727:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 72e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 732:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 739:	48 8b 00             	mov    (%rax),%rax
 73c:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 743:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 74a:	00 
 74b:	75 31                	jne    77e <printf+0x27a>
          s = "(null)";
 74d:	48 c7 85 48 ff ff ff 	movq   $0xb1d,-0xb8(%rbp)
 754:	1d 0b 00 00 
        while(*s != 0){
 758:	eb 24                	jmp    77e <printf+0x27a>
          putc(fd, *s);
 75a:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 761:	0f b6 00             	movzbl (%rax),%eax
 764:	0f be d0             	movsbl %al,%edx
 767:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 76d:	89 d6                	mov    %edx,%esi
 76f:	89 c7                	mov    %eax,%edi
 771:	e8 9c fc ff ff       	call   412 <putc>
          s++;
 776:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 77d:	01 
        while(*s != 0){
 77e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 785:	0f b6 00             	movzbl (%rax),%eax
 788:	84 c0                	test   %al,%al
 78a:	75 ce                	jne    75a <printf+0x256>
 78c:	e9 ac 00 00 00       	jmp    83d <printf+0x339>
        }
      } else if(c == 'c'){
 791:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 798:	75 56                	jne    7f0 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 79a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7a0:	83 f8 2f             	cmp    $0x2f,%eax
 7a3:	77 23                	ja     7c8 <printf+0x2c4>
 7a5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7ac:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7b2:	89 d2                	mov    %edx,%edx
 7b4:	48 01 d0             	add    %rdx,%rax
 7b7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7bd:	83 c2 08             	add    $0x8,%edx
 7c0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7c6:	eb 12                	jmp    7da <printf+0x2d6>
 7c8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7cf:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7d3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7da:	8b 00                	mov    (%rax),%eax
 7dc:	0f be d0             	movsbl %al,%edx
 7df:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e5:	89 d6                	mov    %edx,%esi
 7e7:	89 c7                	mov    %eax,%edi
 7e9:	e8 24 fc ff ff       	call   412 <putc>
 7ee:	eb 4d                	jmp    83d <printf+0x339>
      } else if(c == '%'){
 7f0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7f7:	75 1a                	jne    813 <printf+0x30f>
        putc(fd, c);
 7f9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7ff:	0f be d0             	movsbl %al,%edx
 802:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 808:	89 d6                	mov    %edx,%esi
 80a:	89 c7                	mov    %eax,%edi
 80c:	e8 01 fc ff ff       	call   412 <putc>
 811:	eb 2a                	jmp    83d <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 813:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 819:	be 25 00 00 00       	mov    $0x25,%esi
 81e:	89 c7                	mov    %eax,%edi
 820:	e8 ed fb ff ff       	call   412 <putc>
        putc(fd, c);
 825:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 82b:	0f be d0             	movsbl %al,%edx
 82e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 834:	89 d6                	mov    %edx,%esi
 836:	89 c7                	mov    %eax,%edi
 838:	e8 d5 fb ff ff       	call   412 <putc>
      }
      state = 0;
 83d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 844:	00 00 00 
  for(i = 0; fmt[i]; i++){
 847:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 84e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 854:	48 63 d0             	movslq %eax,%rdx
 857:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 85e:	48 01 d0             	add    %rdx,%rax
 861:	0f b6 00             	movzbl (%rax),%eax
 864:	84 c0                	test   %al,%al
 866:	0f 85 3a fd ff ff    	jne    5a6 <printf+0xa2>
    }
  }
}
 86c:	90                   	nop
 86d:	90                   	nop
 86e:	c9                   	leave
 86f:	c3                   	ret

0000000000000870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 870:	f3 0f 1e fa          	endbr64
 874:	55                   	push   %rbp
 875:	48 89 e5             	mov    %rsp,%rbp
 878:	48 83 ec 18          	sub    $0x18,%rsp
 87c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 880:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 884:	48 83 e8 10          	sub    $0x10,%rax
 888:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	48 8b 05 fd 04 00 00 	mov    0x4fd(%rip),%rax        # d90 <freep>
 893:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 897:	eb 2f                	jmp    8c8 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 89d:	48 8b 00             	mov    (%rax),%rax
 8a0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a4:	72 17                	jb     8bd <free+0x4d>
 8a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8aa:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ae:	72 2f                	jb     8df <free+0x6f>
 8b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b4:	48 8b 00             	mov    (%rax),%rax
 8b7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8bb:	72 22                	jb     8df <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c1:	48 8b 00             	mov    (%rax),%rax
 8c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d0:	73 c7                	jae    899 <free+0x29>
 8d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d6:	48 8b 00             	mov    (%rax),%rax
 8d9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8dd:	73 ba                	jae    899 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e3:	8b 40 08             	mov    0x8(%rax),%eax
 8e6:	89 c0                	mov    %eax,%eax
 8e8:	48 c1 e0 04          	shl    $0x4,%rax
 8ec:	48 89 c2             	mov    %rax,%rdx
 8ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f3:	48 01 c2             	add    %rax,%rdx
 8f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fa:	48 8b 00             	mov    (%rax),%rax
 8fd:	48 39 c2             	cmp    %rax,%rdx
 900:	75 2d                	jne    92f <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 902:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 906:	8b 50 08             	mov    0x8(%rax),%edx
 909:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90d:	48 8b 00             	mov    (%rax),%rax
 910:	8b 40 08             	mov    0x8(%rax),%eax
 913:	01 c2                	add    %eax,%edx
 915:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 919:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 91c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 920:	48 8b 00             	mov    (%rax),%rax
 923:	48 8b 10             	mov    (%rax),%rdx
 926:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92a:	48 89 10             	mov    %rdx,(%rax)
 92d:	eb 0e                	jmp    93d <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 92f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 933:	48 8b 10             	mov    (%rax),%rdx
 936:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 93d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 941:	8b 40 08             	mov    0x8(%rax),%eax
 944:	89 c0                	mov    %eax,%eax
 946:	48 c1 e0 04          	shl    $0x4,%rax
 94a:	48 89 c2             	mov    %rax,%rdx
 94d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 951:	48 01 d0             	add    %rdx,%rax
 954:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 958:	75 27                	jne    981 <free+0x111>
    p->s.size += bp->s.size;
 95a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95e:	8b 50 08             	mov    0x8(%rax),%edx
 961:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 965:	8b 40 08             	mov    0x8(%rax),%eax
 968:	01 c2                	add    %eax,%edx
 96a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 971:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 975:	48 8b 10             	mov    (%rax),%rdx
 978:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97c:	48 89 10             	mov    %rdx,(%rax)
 97f:	eb 0b                	jmp    98c <free+0x11c>
  } else
    p->s.ptr = bp;
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 989:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 98c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 990:	48 89 05 f9 03 00 00 	mov    %rax,0x3f9(%rip)        # d90 <freep>
}
 997:	90                   	nop
 998:	c9                   	leave
 999:	c3                   	ret

000000000000099a <morecore>:

static Header*
morecore(uint nu)
{
 99a:	f3 0f 1e fa          	endbr64
 99e:	55                   	push   %rbp
 99f:	48 89 e5             	mov    %rsp,%rbp
 9a2:	48 83 ec 20          	sub    $0x20,%rsp
 9a6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9a9:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9b0:	77 07                	ja     9b9 <morecore+0x1f>
    nu = 4096;
 9b2:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9bc:	c1 e0 04             	shl    $0x4,%eax
 9bf:	89 c7                	mov    %eax,%edi
 9c1:	e8 14 fa ff ff       	call   3da <sbrk>
 9c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9ca:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9cf:	75 07                	jne    9d8 <morecore+0x3e>
    return 0;
 9d1:	b8 00 00 00 00       	mov    $0x0,%eax
 9d6:	eb 29                	jmp    a01 <morecore+0x67>
  hp = (Header*)p;
 9d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e4:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9e7:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ee:	48 83 c0 10          	add    $0x10,%rax
 9f2:	48 89 c7             	mov    %rax,%rdi
 9f5:	e8 76 fe ff ff       	call   870 <free>
  return freep;
 9fa:	48 8b 05 8f 03 00 00 	mov    0x38f(%rip),%rax        # d90 <freep>
}
 a01:	c9                   	leave
 a02:	c3                   	ret

0000000000000a03 <malloc>:

void*
malloc(uint nbytes)
{
 a03:	f3 0f 1e fa          	endbr64
 a07:	55                   	push   %rbp
 a08:	48 89 e5             	mov    %rsp,%rbp
 a0b:	48 83 ec 30          	sub    $0x30,%rsp
 a0f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a12:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a15:	48 83 c0 0f          	add    $0xf,%rax
 a19:	48 c1 e8 04          	shr    $0x4,%rax
 a1d:	83 c0 01             	add    $0x1,%eax
 a20:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a23:	48 8b 05 66 03 00 00 	mov    0x366(%rip),%rax        # d90 <freep>
 a2a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a2e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a33:	75 2b                	jne    a60 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a35:	48 c7 45 f0 80 0d 00 	movq   $0xd80,-0x10(%rbp)
 a3c:	00 
 a3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a41:	48 89 05 48 03 00 00 	mov    %rax,0x348(%rip)        # d90 <freep>
 a48:	48 8b 05 41 03 00 00 	mov    0x341(%rip),%rax        # d90 <freep>
 a4f:	48 89 05 2a 03 00 00 	mov    %rax,0x32a(%rip)        # d80 <base>
    base.s.size = 0;
 a56:	c7 05 28 03 00 00 00 	movl   $0x0,0x328(%rip)        # d88 <base+0x8>
 a5d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a64:	48 8b 00             	mov    (%rax),%rax
 a67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6f:	8b 40 08             	mov    0x8(%rax),%eax
 a72:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a75:	72 5f                	jb     ad6 <malloc+0xd3>
      if(p->s.size == nunits)
 a77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7b:	8b 40 08             	mov    0x8(%rax),%eax
 a7e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a81:	75 10                	jne    a93 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a87:	48 8b 10             	mov    (%rax),%rdx
 a8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8e:	48 89 10             	mov    %rdx,(%rax)
 a91:	eb 2e                	jmp    ac1 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 a93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a97:	8b 40 08             	mov    0x8(%rax),%eax
 a9a:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a9d:	89 c2                	mov    %eax,%edx
 a9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa3:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aaa:	8b 40 08             	mov    0x8(%rax),%eax
 aad:	89 c0                	mov    %eax,%eax
 aaf:	48 c1 e0 04          	shl    $0x4,%rax
 ab3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ab7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abb:	8b 55 ec             	mov    -0x14(%rbp),%edx
 abe:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ac1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac5:	48 89 05 c4 02 00 00 	mov    %rax,0x2c4(%rip)        # d90 <freep>
      return (void*)(p + 1);
 acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad0:	48 83 c0 10          	add    $0x10,%rax
 ad4:	eb 41                	jmp    b17 <malloc+0x114>
    }
    if(p == freep)
 ad6:	48 8b 05 b3 02 00 00 	mov    0x2b3(%rip),%rax        # d90 <freep>
 add:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ae1:	75 1c                	jne    aff <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ae3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae6:	89 c7                	mov    %eax,%edi
 ae8:	e8 ad fe ff ff       	call   99a <morecore>
 aed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 af1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 af6:	75 07                	jne    aff <malloc+0xfc>
        return 0;
 af8:	b8 00 00 00 00       	mov    $0x0,%eax
 afd:	eb 18                	jmp    b17 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0b:	48 8b 00             	mov    (%rax),%rax
 b0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b12:	e9 54 ff ff ff       	jmp    a6b <malloc+0x68>
  }
}
 b17:	c9                   	leave
 b18:	c3                   	ret
