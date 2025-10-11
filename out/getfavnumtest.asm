
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
  20:	48 c7 c6 29 0b 00 00 	mov    $0xb29,%rsi
  27:	bf 02 00 00 00       	mov    $0x2,%edi
  2c:	b8 00 00 00 00       	mov    $0x0,%eax
  31:	e8 de 04 00 00       	call   514 <printf>
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

0000000000000412 <getcount>:
SYSCALL(getcount)
 412:	b8 1e 00 00 00       	mov    $0x1e,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

000000000000041a <killrandom>:
SYSCALL(killrandom)
 41a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

0000000000000422 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 422:	f3 0f 1e fa          	endbr64
 426:	55                   	push   %rbp
 427:	48 89 e5             	mov    %rsp,%rbp
 42a:	48 83 ec 10          	sub    $0x10,%rsp
 42e:	89 7d fc             	mov    %edi,-0x4(%rbp)
 431:	89 f0                	mov    %esi,%eax
 433:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 436:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 43a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 43d:	ba 01 00 00 00       	mov    $0x1,%edx
 442:	48 89 ce             	mov    %rcx,%rsi
 445:	89 c7                	mov    %eax,%edi
 447:	e8 26 ff ff ff       	call   372 <write>
}
 44c:	90                   	nop
 44d:	c9                   	leave
 44e:	c3                   	ret

000000000000044f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44f:	f3 0f 1e fa          	endbr64
 453:	55                   	push   %rbp
 454:	48 89 e5             	mov    %rsp,%rbp
 457:	48 83 ec 30          	sub    $0x30,%rsp
 45b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 45e:	89 75 d8             	mov    %esi,-0x28(%rbp)
 461:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 464:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 467:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 46e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 472:	74 17                	je     48b <printint+0x3c>
 474:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 478:	79 11                	jns    48b <printint+0x3c>
    neg = 1;
 47a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 481:	8b 45 d8             	mov    -0x28(%rbp),%eax
 484:	f7 d8                	neg    %eax
 486:	89 45 f4             	mov    %eax,-0xc(%rbp)
 489:	eb 06                	jmp    491 <printint+0x42>
  } else {
    x = xx;
 48b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 48e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 491:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 498:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 49b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 49e:	ba 00 00 00 00       	mov    $0x0,%edx
 4a3:	f7 f6                	div    %esi
 4a5:	89 d1                	mov    %edx,%ecx
 4a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4aa:	8d 50 01             	lea    0x1(%rax),%edx
 4ad:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4b0:	89 ca                	mov    %ecx,%edx
 4b2:	0f b6 92 70 0d 00 00 	movzbl 0xd70(%rdx),%edx
 4b9:	48 98                	cltq
 4bb:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4bf:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4c5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ca:	f7 f7                	div    %edi
 4cc:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4d3:	75 c3                	jne    498 <printint+0x49>
  if(neg)
 4d5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4d9:	74 2b                	je     506 <printint+0xb7>
    buf[i++] = '-';
 4db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4de:	8d 50 01             	lea    0x1(%rax),%edx
 4e1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e4:	48 98                	cltq
 4e6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4eb:	eb 19                	jmp    506 <printint+0xb7>
    putc(fd, buf[i]);
 4ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f0:	48 98                	cltq
 4f2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4f7:	0f be d0             	movsbl %al,%edx
 4fa:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4fd:	89 d6                	mov    %edx,%esi
 4ff:	89 c7                	mov    %eax,%edi
 501:	e8 1c ff ff ff       	call   422 <putc>
  while(--i >= 0)
 506:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 50a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 50e:	79 dd                	jns    4ed <printint+0x9e>
}
 510:	90                   	nop
 511:	90                   	nop
 512:	c9                   	leave
 513:	c3                   	ret

0000000000000514 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 514:	f3 0f 1e fa          	endbr64
 518:	55                   	push   %rbp
 519:	48 89 e5             	mov    %rsp,%rbp
 51c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 523:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 529:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 530:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 537:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 53e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 545:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 54c:	84 c0                	test   %al,%al
 54e:	74 20                	je     570 <printf+0x5c>
 550:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 554:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 558:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 55c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 560:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 564:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 568:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 56c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 570:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 577:	00 00 00 
 57a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 581:	00 00 00 
 584:	48 8d 45 10          	lea    0x10(%rbp),%rax
 588:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 58f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 596:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 59d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5a4:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5a7:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5ae:	00 00 00 
 5b1:	e9 a8 02 00 00       	jmp    85e <printf+0x34a>
    c = fmt[i] & 0xff;
 5b6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5bc:	48 63 d0             	movslq %eax,%rdx
 5bf:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5c6:	48 01 d0             	add    %rdx,%rax
 5c9:	0f b6 00             	movzbl (%rax),%eax
 5cc:	0f be c0             	movsbl %al,%eax
 5cf:	25 ff 00 00 00       	and    $0xff,%eax
 5d4:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5da:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5e1:	75 35                	jne    618 <printf+0x104>
      if(c == '%'){
 5e3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5ea:	75 0f                	jne    5fb <printf+0xe7>
        state = '%';
 5ec:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5f3:	00 00 00 
 5f6:	e9 5c 02 00 00       	jmp    857 <printf+0x343>
      } else {
        putc(fd, c);
 5fb:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 601:	0f be d0             	movsbl %al,%edx
 604:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 60a:	89 d6                	mov    %edx,%esi
 60c:	89 c7                	mov    %eax,%edi
 60e:	e8 0f fe ff ff       	call   422 <putc>
 613:	e9 3f 02 00 00       	jmp    857 <printf+0x343>
      }
    } else if(state == '%'){
 618:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 61f:	0f 85 32 02 00 00    	jne    857 <printf+0x343>
      if(c == 'd'){
 625:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 62c:	75 5e                	jne    68c <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 62e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 634:	83 f8 2f             	cmp    $0x2f,%eax
 637:	77 23                	ja     65c <printf+0x148>
 639:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 640:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 646:	89 d2                	mov    %edx,%edx
 648:	48 01 d0             	add    %rdx,%rax
 64b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 651:	83 c2 08             	add    $0x8,%edx
 654:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 65a:	eb 12                	jmp    66e <printf+0x15a>
 65c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 663:	48 8d 50 08          	lea    0x8(%rax),%rdx
 667:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 66e:	8b 30                	mov    (%rax),%esi
 670:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 676:	b9 01 00 00 00       	mov    $0x1,%ecx
 67b:	ba 0a 00 00 00       	mov    $0xa,%edx
 680:	89 c7                	mov    %eax,%edi
 682:	e8 c8 fd ff ff       	call   44f <printint>
 687:	e9 c1 01 00 00       	jmp    84d <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 68c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 693:	74 09                	je     69e <printf+0x18a>
 695:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 69c:	75 5e                	jne    6fc <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 69e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6a4:	83 f8 2f             	cmp    $0x2f,%eax
 6a7:	77 23                	ja     6cc <printf+0x1b8>
 6a9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6b0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b6:	89 d2                	mov    %edx,%edx
 6b8:	48 01 d0             	add    %rdx,%rax
 6bb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6c1:	83 c2 08             	add    $0x8,%edx
 6c4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6ca:	eb 12                	jmp    6de <printf+0x1ca>
 6cc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6d3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6de:	8b 30                	mov    (%rax),%esi
 6e0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6e6:	b9 00 00 00 00       	mov    $0x0,%ecx
 6eb:	ba 10 00 00 00       	mov    $0x10,%edx
 6f0:	89 c7                	mov    %eax,%edi
 6f2:	e8 58 fd ff ff       	call   44f <printint>
 6f7:	e9 51 01 00 00       	jmp    84d <printf+0x339>
      } else if(c == 's'){
 6fc:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 703:	0f 85 98 00 00 00    	jne    7a1 <printf+0x28d>
        s = va_arg(ap, char*);
 709:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 70f:	83 f8 2f             	cmp    $0x2f,%eax
 712:	77 23                	ja     737 <printf+0x223>
 714:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 71b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 721:	89 d2                	mov    %edx,%edx
 723:	48 01 d0             	add    %rdx,%rax
 726:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 72c:	83 c2 08             	add    $0x8,%edx
 72f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 735:	eb 12                	jmp    749 <printf+0x235>
 737:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 73e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 742:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 749:	48 8b 00             	mov    (%rax),%rax
 74c:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 753:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 75a:	00 
 75b:	75 31                	jne    78e <printf+0x27a>
          s = "(null)";
 75d:	48 c7 85 48 ff ff ff 	movq   $0xb2d,-0xb8(%rbp)
 764:	2d 0b 00 00 
        while(*s != 0){
 768:	eb 24                	jmp    78e <printf+0x27a>
          putc(fd, *s);
 76a:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 771:	0f b6 00             	movzbl (%rax),%eax
 774:	0f be d0             	movsbl %al,%edx
 777:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77d:	89 d6                	mov    %edx,%esi
 77f:	89 c7                	mov    %eax,%edi
 781:	e8 9c fc ff ff       	call   422 <putc>
          s++;
 786:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 78d:	01 
        while(*s != 0){
 78e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 795:	0f b6 00             	movzbl (%rax),%eax
 798:	84 c0                	test   %al,%al
 79a:	75 ce                	jne    76a <printf+0x256>
 79c:	e9 ac 00 00 00       	jmp    84d <printf+0x339>
        }
      } else if(c == 'c'){
 7a1:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7a8:	75 56                	jne    800 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7aa:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7b0:	83 f8 2f             	cmp    $0x2f,%eax
 7b3:	77 23                	ja     7d8 <printf+0x2c4>
 7b5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7c2:	89 d2                	mov    %edx,%edx
 7c4:	48 01 d0             	add    %rdx,%rax
 7c7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7cd:	83 c2 08             	add    $0x8,%edx
 7d0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7d6:	eb 12                	jmp    7ea <printf+0x2d6>
 7d8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7df:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7e3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7ea:	8b 00                	mov    (%rax),%eax
 7ec:	0f be d0             	movsbl %al,%edx
 7ef:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f5:	89 d6                	mov    %edx,%esi
 7f7:	89 c7                	mov    %eax,%edi
 7f9:	e8 24 fc ff ff       	call   422 <putc>
 7fe:	eb 4d                	jmp    84d <printf+0x339>
      } else if(c == '%'){
 800:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 807:	75 1a                	jne    823 <printf+0x30f>
        putc(fd, c);
 809:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 80f:	0f be d0             	movsbl %al,%edx
 812:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 818:	89 d6                	mov    %edx,%esi
 81a:	89 c7                	mov    %eax,%edi
 81c:	e8 01 fc ff ff       	call   422 <putc>
 821:	eb 2a                	jmp    84d <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 823:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 829:	be 25 00 00 00       	mov    $0x25,%esi
 82e:	89 c7                	mov    %eax,%edi
 830:	e8 ed fb ff ff       	call   422 <putc>
        putc(fd, c);
 835:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 83b:	0f be d0             	movsbl %al,%edx
 83e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 844:	89 d6                	mov    %edx,%esi
 846:	89 c7                	mov    %eax,%edi
 848:	e8 d5 fb ff ff       	call   422 <putc>
      }
      state = 0;
 84d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 854:	00 00 00 
  for(i = 0; fmt[i]; i++){
 857:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 85e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 864:	48 63 d0             	movslq %eax,%rdx
 867:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 86e:	48 01 d0             	add    %rdx,%rax
 871:	0f b6 00             	movzbl (%rax),%eax
 874:	84 c0                	test   %al,%al
 876:	0f 85 3a fd ff ff    	jne    5b6 <printf+0xa2>
    }
  }
}
 87c:	90                   	nop
 87d:	90                   	nop
 87e:	c9                   	leave
 87f:	c3                   	ret

0000000000000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	f3 0f 1e fa          	endbr64
 884:	55                   	push   %rbp
 885:	48 89 e5             	mov    %rsp,%rbp
 888:	48 83 ec 18          	sub    $0x18,%rsp
 88c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 890:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 894:	48 83 e8 10          	sub    $0x10,%rax
 898:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89c:	48 8b 05 fd 04 00 00 	mov    0x4fd(%rip),%rax        # da0 <freep>
 8a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8a7:	eb 2f                	jmp    8d8 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ad:	48 8b 00             	mov    (%rax),%rax
 8b0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b4:	72 17                	jb     8cd <free+0x4d>
 8b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8be:	72 2f                	jb     8ef <free+0x6f>
 8c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c4:	48 8b 00             	mov    (%rax),%rax
 8c7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8cb:	72 22                	jb     8ef <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d1:	48 8b 00             	mov    (%rax),%rax
 8d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8dc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e0:	73 c7                	jae    8a9 <free+0x29>
 8e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e6:	48 8b 00             	mov    (%rax),%rax
 8e9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ed:	73 ba                	jae    8a9 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f3:	8b 40 08             	mov    0x8(%rax),%eax
 8f6:	89 c0                	mov    %eax,%eax
 8f8:	48 c1 e0 04          	shl    $0x4,%rax
 8fc:	48 89 c2             	mov    %rax,%rdx
 8ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 903:	48 01 c2             	add    %rax,%rdx
 906:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90a:	48 8b 00             	mov    (%rax),%rax
 90d:	48 39 c2             	cmp    %rax,%rdx
 910:	75 2d                	jne    93f <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 912:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 916:	8b 50 08             	mov    0x8(%rax),%edx
 919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91d:	48 8b 00             	mov    (%rax),%rax
 920:	8b 40 08             	mov    0x8(%rax),%eax
 923:	01 c2                	add    %eax,%edx
 925:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 929:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 92c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 930:	48 8b 00             	mov    (%rax),%rax
 933:	48 8b 10             	mov    (%rax),%rdx
 936:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93a:	48 89 10             	mov    %rdx,(%rax)
 93d:	eb 0e                	jmp    94d <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 93f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 943:	48 8b 10             	mov    (%rax),%rdx
 946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 94d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 951:	8b 40 08             	mov    0x8(%rax),%eax
 954:	89 c0                	mov    %eax,%eax
 956:	48 c1 e0 04          	shl    $0x4,%rax
 95a:	48 89 c2             	mov    %rax,%rdx
 95d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 961:	48 01 d0             	add    %rdx,%rax
 964:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 968:	75 27                	jne    991 <free+0x111>
    p->s.size += bp->s.size;
 96a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96e:	8b 50 08             	mov    0x8(%rax),%edx
 971:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 975:	8b 40 08             	mov    0x8(%rax),%eax
 978:	01 c2                	add    %eax,%edx
 97a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 981:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 985:	48 8b 10             	mov    (%rax),%rdx
 988:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98c:	48 89 10             	mov    %rdx,(%rax)
 98f:	eb 0b                	jmp    99c <free+0x11c>
  } else
    p->s.ptr = bp;
 991:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 995:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 999:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 99c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a0:	48 89 05 f9 03 00 00 	mov    %rax,0x3f9(%rip)        # da0 <freep>
}
 9a7:	90                   	nop
 9a8:	c9                   	leave
 9a9:	c3                   	ret

00000000000009aa <morecore>:

static Header*
morecore(uint nu)
{
 9aa:	f3 0f 1e fa          	endbr64
 9ae:	55                   	push   %rbp
 9af:	48 89 e5             	mov    %rsp,%rbp
 9b2:	48 83 ec 20          	sub    $0x20,%rsp
 9b6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9b9:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9c0:	77 07                	ja     9c9 <morecore+0x1f>
    nu = 4096;
 9c2:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9cc:	c1 e0 04             	shl    $0x4,%eax
 9cf:	89 c7                	mov    %eax,%edi
 9d1:	e8 04 fa ff ff       	call   3da <sbrk>
 9d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9da:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9df:	75 07                	jne    9e8 <morecore+0x3e>
    return 0;
 9e1:	b8 00 00 00 00       	mov    $0x0,%eax
 9e6:	eb 29                	jmp    a11 <morecore+0x67>
  hp = (Header*)p;
 9e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f4:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9f7:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fe:	48 83 c0 10          	add    $0x10,%rax
 a02:	48 89 c7             	mov    %rax,%rdi
 a05:	e8 76 fe ff ff       	call   880 <free>
  return freep;
 a0a:	48 8b 05 8f 03 00 00 	mov    0x38f(%rip),%rax        # da0 <freep>
}
 a11:	c9                   	leave
 a12:	c3                   	ret

0000000000000a13 <malloc>:

void*
malloc(uint nbytes)
{
 a13:	f3 0f 1e fa          	endbr64
 a17:	55                   	push   %rbp
 a18:	48 89 e5             	mov    %rsp,%rbp
 a1b:	48 83 ec 30          	sub    $0x30,%rsp
 a1f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a25:	48 83 c0 0f          	add    $0xf,%rax
 a29:	48 c1 e8 04          	shr    $0x4,%rax
 a2d:	83 c0 01             	add    $0x1,%eax
 a30:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a33:	48 8b 05 66 03 00 00 	mov    0x366(%rip),%rax        # da0 <freep>
 a3a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a3e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a43:	75 2b                	jne    a70 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a45:	48 c7 45 f0 90 0d 00 	movq   $0xd90,-0x10(%rbp)
 a4c:	00 
 a4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a51:	48 89 05 48 03 00 00 	mov    %rax,0x348(%rip)        # da0 <freep>
 a58:	48 8b 05 41 03 00 00 	mov    0x341(%rip),%rax        # da0 <freep>
 a5f:	48 89 05 2a 03 00 00 	mov    %rax,0x32a(%rip)        # d90 <base>
    base.s.size = 0;
 a66:	c7 05 28 03 00 00 00 	movl   $0x0,0x328(%rip)        # d98 <base+0x8>
 a6d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a74:	48 8b 00             	mov    (%rax),%rax
 a77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	8b 40 08             	mov    0x8(%rax),%eax
 a82:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a85:	72 5f                	jb     ae6 <malloc+0xd3>
      if(p->s.size == nunits)
 a87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8b:	8b 40 08             	mov    0x8(%rax),%eax
 a8e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a91:	75 10                	jne    aa3 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 a93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a97:	48 8b 10             	mov    (%rax),%rdx
 a9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9e:	48 89 10             	mov    %rdx,(%rax)
 aa1:	eb 2e                	jmp    ad1 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa7:	8b 40 08             	mov    0x8(%rax),%eax
 aaa:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aad:	89 c2                	mov    %eax,%edx
 aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab3:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ab6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aba:	8b 40 08             	mov    0x8(%rax),%eax
 abd:	89 c0                	mov    %eax,%eax
 abf:	48 c1 e0 04          	shl    $0x4,%rax
 ac3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acb:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ace:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ad1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad5:	48 89 05 c4 02 00 00 	mov    %rax,0x2c4(%rip)        # da0 <freep>
      return (void*)(p + 1);
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	48 83 c0 10          	add    $0x10,%rax
 ae4:	eb 41                	jmp    b27 <malloc+0x114>
    }
    if(p == freep)
 ae6:	48 8b 05 b3 02 00 00 	mov    0x2b3(%rip),%rax        # da0 <freep>
 aed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 af1:	75 1c                	jne    b0f <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 af3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 af6:	89 c7                	mov    %eax,%edi
 af8:	e8 ad fe ff ff       	call   9aa <morecore>
 afd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b01:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b06:	75 07                	jne    b0f <malloc+0xfc>
        return 0;
 b08:	b8 00 00 00 00       	mov    $0x0,%eax
 b0d:	eb 18                	jmp    b27 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1b:	48 8b 00             	mov    (%rax),%rax
 b1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b22:	e9 54 ff ff ff       	jmp    a7b <malloc+0x68>
  }
}
 b27:	c9                   	leave
 b28:	c3                   	ret
