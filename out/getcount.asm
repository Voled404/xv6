
fs/getcount:     file format elf64-x86-64


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
  int syscall = atoi(argv[1]);
  13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  17:	48 83 c0 08          	add    $0x8,%rax
  1b:	48 8b 00             	mov    (%rax),%rax
  1e:	48 89 c7             	mov    %rax,%rdi
  21:	e8 ab 02 00 00       	call   2d1 <atoi>
  26:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(argc < 2 || syscall == 0){
  29:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  2d:	7e 06                	jle    35 <main+0x35>
  2f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  33:	75 1b                	jne    50 <main+0x50>
    printf(2, "Usage: getcount syscall\n");
  35:	48 c7 c6 5d 0b 00 00 	mov    $0xb5d,%rsi
  3c:	bf 02 00 00 00       	mov    $0x2,%edi
  41:	b8 00 00 00 00       	mov    $0x0,%eax
  46:	e8 fd 04 00 00       	call   548 <printf>
    exit();
  4b:	e8 3e 03 00 00       	call   38e <exit>
  }
  printf(2, "System call count: %d\n", getcount(syscall));
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	89 c7                	mov    %eax,%edi
  55:	e8 f4 03 00 00       	call   44e <getcount>
  5a:	89 c2                	mov    %eax,%edx
  5c:	48 c7 c6 76 0b 00 00 	mov    $0xb76,%rsi
  63:	bf 02 00 00 00       	mov    $0x2,%edi
  68:	b8 00 00 00 00       	mov    $0x0,%eax
  6d:	e8 d6 04 00 00       	call   548 <printf>
  exit();
  72:	e8 17 03 00 00       	call   38e <exit>

0000000000000077 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  77:	55                   	push   %rbp
  78:	48 89 e5             	mov    %rsp,%rbp
  7b:	48 83 ec 10          	sub    $0x10,%rsp
  7f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  83:	89 75 f4             	mov    %esi,-0xc(%rbp)
  86:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  89:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8d:	8b 55 f0             	mov    -0x10(%rbp),%edx
  90:	8b 45 f4             	mov    -0xc(%rbp),%eax
  93:	48 89 ce             	mov    %rcx,%rsi
  96:	48 89 f7             	mov    %rsi,%rdi
  99:	89 d1                	mov    %edx,%ecx
  9b:	fc                   	cld
  9c:	f3 aa                	rep stos %al,%es:(%rdi)
  9e:	89 ca                	mov    %ecx,%edx
  a0:	48 89 fe             	mov    %rdi,%rsi
  a3:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  a7:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  aa:	90                   	nop
  ab:	c9                   	leave
  ac:	c3                   	ret

00000000000000ad <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  ad:	f3 0f 1e fa          	endbr64
  b1:	55                   	push   %rbp
  b2:	48 89 e5             	mov    %rsp,%rbp
  b5:	48 83 ec 20          	sub    $0x20,%rsp
  b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  c9:	90                   	nop
  ca:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  ce:	48 8d 42 01          	lea    0x1(%rdx),%rax
  d2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  da:	48 8d 48 01          	lea    0x1(%rax),%rcx
  de:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  e2:	0f b6 12             	movzbl (%rdx),%edx
  e5:	88 10                	mov    %dl,(%rax)
  e7:	0f b6 00             	movzbl (%rax),%eax
  ea:	84 c0                	test   %al,%al
  ec:	75 dc                	jne    ca <strcpy+0x1d>
    ;
  return os;
  ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  f2:	c9                   	leave
  f3:	c3                   	ret

00000000000000f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f4:	f3 0f 1e fa          	endbr64
  f8:	55                   	push   %rbp
  f9:	48 89 e5             	mov    %rsp,%rbp
  fc:	48 83 ec 10          	sub    $0x10,%rsp
 100:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 104:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 108:	eb 0a                	jmp    114 <strcmp+0x20>
    p++, q++;
 10a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 10f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 114:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 118:	0f b6 00             	movzbl (%rax),%eax
 11b:	84 c0                	test   %al,%al
 11d:	74 12                	je     131 <strcmp+0x3d>
 11f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 123:	0f b6 10             	movzbl (%rax),%edx
 126:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 12a:	0f b6 00             	movzbl (%rax),%eax
 12d:	38 c2                	cmp    %al,%dl
 12f:	74 d9                	je     10a <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 131:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 135:	0f b6 00             	movzbl (%rax),%eax
 138:	0f b6 d0             	movzbl %al,%edx
 13b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 13f:	0f b6 00             	movzbl (%rax),%eax
 142:	0f b6 c0             	movzbl %al,%eax
 145:	29 c2                	sub    %eax,%edx
 147:	89 d0                	mov    %edx,%eax
}
 149:	c9                   	leave
 14a:	c3                   	ret

000000000000014b <strlen>:

uint
strlen(char *s)
{
 14b:	f3 0f 1e fa          	endbr64
 14f:	55                   	push   %rbp
 150:	48 89 e5             	mov    %rsp,%rbp
 153:	48 83 ec 18          	sub    $0x18,%rsp
 157:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 15b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 162:	eb 04                	jmp    168 <strlen+0x1d>
 164:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 168:	8b 45 fc             	mov    -0x4(%rbp),%eax
 16b:	48 63 d0             	movslq %eax,%rdx
 16e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 172:	48 01 d0             	add    %rdx,%rax
 175:	0f b6 00             	movzbl (%rax),%eax
 178:	84 c0                	test   %al,%al
 17a:	75 e8                	jne    164 <strlen+0x19>
    ;
  return n;
 17c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 17f:	c9                   	leave
 180:	c3                   	ret

0000000000000181 <memset>:

void*
memset(void *dst, int c, uint n)
{
 181:	f3 0f 1e fa          	endbr64
 185:	55                   	push   %rbp
 186:	48 89 e5             	mov    %rsp,%rbp
 189:	48 83 ec 10          	sub    $0x10,%rsp
 18d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 191:	89 75 f4             	mov    %esi,-0xc(%rbp)
 194:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 197:	8b 55 f0             	mov    -0x10(%rbp),%edx
 19a:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 19d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a1:	89 ce                	mov    %ecx,%esi
 1a3:	48 89 c7             	mov    %rax,%rdi
 1a6:	e8 cc fe ff ff       	call   77 <stosb>
  return dst;
 1ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1af:	c9                   	leave
 1b0:	c3                   	ret

00000000000001b1 <strchr>:

char*
strchr(const char *s, char c)
{
 1b1:	f3 0f 1e fa          	endbr64
 1b5:	55                   	push   %rbp
 1b6:	48 89 e5             	mov    %rsp,%rbp
 1b9:	48 83 ec 10          	sub    $0x10,%rsp
 1bd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1c1:	89 f0                	mov    %esi,%eax
 1c3:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1c6:	eb 17                	jmp    1df <strchr+0x2e>
    if(*s == c)
 1c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1cc:	0f b6 00             	movzbl (%rax),%eax
 1cf:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1d2:	75 06                	jne    1da <strchr+0x29>
      return (char*)s;
 1d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d8:	eb 15                	jmp    1ef <strchr+0x3e>
  for(; *s; s++)
 1da:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e3:	0f b6 00             	movzbl (%rax),%eax
 1e6:	84 c0                	test   %al,%al
 1e8:	75 de                	jne    1c8 <strchr+0x17>
  return 0;
 1ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ef:	c9                   	leave
 1f0:	c3                   	ret

00000000000001f1 <gets>:

char*
gets(char *buf, int max)
{
 1f1:	f3 0f 1e fa          	endbr64
 1f5:	55                   	push   %rbp
 1f6:	48 89 e5             	mov    %rsp,%rbp
 1f9:	48 83 ec 20          	sub    $0x20,%rsp
 1fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 201:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 204:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 20b:	eb 48                	jmp    255 <gets+0x64>
    cc = read(0, &c, 1);
 20d:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 211:	ba 01 00 00 00       	mov    $0x1,%edx
 216:	48 89 c6             	mov    %rax,%rsi
 219:	bf 00 00 00 00       	mov    $0x0,%edi
 21e:	e8 83 01 00 00       	call   3a6 <read>
 223:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 226:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 22a:	7e 36                	jle    262 <gets+0x71>
      break;
    buf[i++] = c;
 22c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 22f:	8d 50 01             	lea    0x1(%rax),%edx
 232:	89 55 fc             	mov    %edx,-0x4(%rbp)
 235:	48 63 d0             	movslq %eax,%rdx
 238:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 23c:	48 01 c2             	add    %rax,%rdx
 23f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 243:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 245:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 249:	3c 0a                	cmp    $0xa,%al
 24b:	74 16                	je     263 <gets+0x72>
 24d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 251:	3c 0d                	cmp    $0xd,%al
 253:	74 0e                	je     263 <gets+0x72>
  for(i=0; i+1 < max; ){
 255:	8b 45 fc             	mov    -0x4(%rbp),%eax
 258:	83 c0 01             	add    $0x1,%eax
 25b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 25e:	7f ad                	jg     20d <gets+0x1c>
 260:	eb 01                	jmp    263 <gets+0x72>
      break;
 262:	90                   	nop
      break;
  }
  buf[i] = '\0';
 263:	8b 45 fc             	mov    -0x4(%rbp),%eax
 266:	48 63 d0             	movslq %eax,%rdx
 269:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 26d:	48 01 d0             	add    %rdx,%rax
 270:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 273:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 277:	c9                   	leave
 278:	c3                   	ret

0000000000000279 <stat>:

int
stat(char *n, struct stat *st)
{
 279:	f3 0f 1e fa          	endbr64
 27d:	55                   	push   %rbp
 27e:	48 89 e5             	mov    %rsp,%rbp
 281:	48 83 ec 20          	sub    $0x20,%rsp
 285:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 289:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 291:	be 00 00 00 00       	mov    $0x0,%esi
 296:	48 89 c7             	mov    %rax,%rdi
 299:	e8 30 01 00 00       	call   3ce <open>
 29e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 2a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2a5:	79 07                	jns    2ae <stat+0x35>
    return -1;
 2a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ac:	eb 21                	jmp    2cf <stat+0x56>
  r = fstat(fd, st);
 2ae:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2b5:	48 89 d6             	mov    %rdx,%rsi
 2b8:	89 c7                	mov    %eax,%edi
 2ba:	e8 27 01 00 00       	call   3e6 <fstat>
 2bf:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2c5:	89 c7                	mov    %eax,%edi
 2c7:	e8 ea 00 00 00       	call   3b6 <close>
  return r;
 2cc:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2cf:	c9                   	leave
 2d0:	c3                   	ret

00000000000002d1 <atoi>:

int
atoi(const char *s)
{
 2d1:	f3 0f 1e fa          	endbr64
 2d5:	55                   	push   %rbp
 2d6:	48 89 e5             	mov    %rsp,%rbp
 2d9:	48 83 ec 18          	sub    $0x18,%rsp
 2dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2e8:	eb 28                	jmp    312 <atoi+0x41>
    n = n*10 + *s++ - '0';
 2ea:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2ed:	89 d0                	mov    %edx,%eax
 2ef:	c1 e0 02             	shl    $0x2,%eax
 2f2:	01 d0                	add    %edx,%eax
 2f4:	01 c0                	add    %eax,%eax
 2f6:	89 c1                	mov    %eax,%ecx
 2f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fc:	48 8d 50 01          	lea    0x1(%rax),%rdx
 300:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 304:	0f b6 00             	movzbl (%rax),%eax
 307:	0f be c0             	movsbl %al,%eax
 30a:	01 c8                	add    %ecx,%eax
 30c:	83 e8 30             	sub    $0x30,%eax
 30f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 312:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 316:	0f b6 00             	movzbl (%rax),%eax
 319:	3c 2f                	cmp    $0x2f,%al
 31b:	7e 0b                	jle    328 <atoi+0x57>
 31d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 321:	0f b6 00             	movzbl (%rax),%eax
 324:	3c 39                	cmp    $0x39,%al
 326:	7e c2                	jle    2ea <atoi+0x19>
  return n;
 328:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 32b:	c9                   	leave
 32c:	c3                   	ret

000000000000032d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32d:	f3 0f 1e fa          	endbr64
 331:	55                   	push   %rbp
 332:	48 89 e5             	mov    %rsp,%rbp
 335:	48 83 ec 28          	sub    $0x28,%rsp
 339:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 33d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 341:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 344:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 348:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 34c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 350:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 354:	eb 1d                	jmp    373 <memmove+0x46>
    *dst++ = *src++;
 356:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 35a:	48 8d 42 01          	lea    0x1(%rdx),%rax
 35e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 362:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 366:	48 8d 48 01          	lea    0x1(%rax),%rcx
 36a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 36e:	0f b6 12             	movzbl (%rdx),%edx
 371:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 373:	8b 45 dc             	mov    -0x24(%rbp),%eax
 376:	8d 50 ff             	lea    -0x1(%rax),%edx
 379:	89 55 dc             	mov    %edx,-0x24(%rbp)
 37c:	85 c0                	test   %eax,%eax
 37e:	7f d6                	jg     356 <memmove+0x29>
  return vdst;
 380:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 384:	c9                   	leave
 385:	c3                   	ret

0000000000000386 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 386:	b8 01 00 00 00       	mov    $0x1,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret

000000000000038e <exit>:
SYSCALL(exit)
 38e:	b8 02 00 00 00       	mov    $0x2,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret

0000000000000396 <wait>:
SYSCALL(wait)
 396:	b8 03 00 00 00       	mov    $0x3,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret

000000000000039e <pipe>:
SYSCALL(pipe)
 39e:	b8 04 00 00 00       	mov    $0x4,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret

00000000000003a6 <read>:
SYSCALL(read)
 3a6:	b8 05 00 00 00       	mov    $0x5,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret

00000000000003ae <write>:
SYSCALL(write)
 3ae:	b8 10 00 00 00       	mov    $0x10,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret

00000000000003b6 <close>:
SYSCALL(close)
 3b6:	b8 15 00 00 00       	mov    $0x15,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret

00000000000003be <kill>:
SYSCALL(kill)
 3be:	b8 06 00 00 00       	mov    $0x6,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret

00000000000003c6 <exec>:
SYSCALL(exec)
 3c6:	b8 07 00 00 00       	mov    $0x7,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret

00000000000003ce <open>:
SYSCALL(open)
 3ce:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret

00000000000003d6 <mknod>:
SYSCALL(mknod)
 3d6:	b8 11 00 00 00       	mov    $0x11,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret

00000000000003de <unlink>:
SYSCALL(unlink)
 3de:	b8 12 00 00 00       	mov    $0x12,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret

00000000000003e6 <fstat>:
SYSCALL(fstat)
 3e6:	b8 08 00 00 00       	mov    $0x8,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret

00000000000003ee <link>:
SYSCALL(link)
 3ee:	b8 13 00 00 00       	mov    $0x13,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret

00000000000003f6 <mkdir>:
SYSCALL(mkdir)
 3f6:	b8 14 00 00 00       	mov    $0x14,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret

00000000000003fe <chdir>:
SYSCALL(chdir)
 3fe:	b8 09 00 00 00       	mov    $0x9,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret

0000000000000406 <dup>:
SYSCALL(dup)
 406:	b8 0a 00 00 00       	mov    $0xa,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret

000000000000040e <getpid>:
SYSCALL(getpid)
 40e:	b8 0b 00 00 00       	mov    $0xb,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret

0000000000000416 <sbrk>:
SYSCALL(sbrk)
 416:	b8 0c 00 00 00       	mov    $0xc,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret

000000000000041e <sleep>:
SYSCALL(sleep)
 41e:	b8 0d 00 00 00       	mov    $0xd,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret

0000000000000426 <uptime>:
SYSCALL(uptime)
 426:	b8 0e 00 00 00       	mov    $0xe,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret

000000000000042e <getpinfo>:
SYSCALL(getpinfo)
 42e:	b8 18 00 00 00       	mov    $0x18,%eax
 433:	cd 40                	int    $0x40
 435:	c3                   	ret

0000000000000436 <settickets>:
SYSCALL(settickets)
 436:	b8 1b 00 00 00       	mov    $0x1b,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret

000000000000043e <getfavnum>:
SYSCALL(getfavnum)
 43e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret

0000000000000446 <halt>:
SYSCALL(halt)
 446:	b8 1d 00 00 00       	mov    $0x1d,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret

000000000000044e <getcount>:
SYSCALL(getcount)
 44e:	b8 1e 00 00 00       	mov    $0x1e,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret

0000000000000456 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 456:	f3 0f 1e fa          	endbr64
 45a:	55                   	push   %rbp
 45b:	48 89 e5             	mov    %rsp,%rbp
 45e:	48 83 ec 10          	sub    $0x10,%rsp
 462:	89 7d fc             	mov    %edi,-0x4(%rbp)
 465:	89 f0                	mov    %esi,%eax
 467:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 46a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 46e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 471:	ba 01 00 00 00       	mov    $0x1,%edx
 476:	48 89 ce             	mov    %rcx,%rsi
 479:	89 c7                	mov    %eax,%edi
 47b:	e8 2e ff ff ff       	call   3ae <write>
}
 480:	90                   	nop
 481:	c9                   	leave
 482:	c3                   	ret

0000000000000483 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 483:	f3 0f 1e fa          	endbr64
 487:	55                   	push   %rbp
 488:	48 89 e5             	mov    %rsp,%rbp
 48b:	48 83 ec 30          	sub    $0x30,%rsp
 48f:	89 7d dc             	mov    %edi,-0x24(%rbp)
 492:	89 75 d8             	mov    %esi,-0x28(%rbp)
 495:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 498:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 49b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4a2:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4a6:	74 17                	je     4bf <printint+0x3c>
 4a8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4ac:	79 11                	jns    4bf <printint+0x3c>
    neg = 1;
 4ae:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4b5:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b8:	f7 d8                	neg    %eax
 4ba:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4bd:	eb 06                	jmp    4c5 <printint+0x42>
  } else {
    x = xx;
 4bf:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c2:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4cc:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4d2:	ba 00 00 00 00       	mov    $0x0,%edx
 4d7:	f7 f6                	div    %esi
 4d9:	89 d1                	mov    %edx,%ecx
 4db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4de:	8d 50 01             	lea    0x1(%rax),%edx
 4e1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e4:	89 ca                	mov    %ecx,%edx
 4e6:	0f b6 92 d0 0d 00 00 	movzbl 0xdd0(%rdx),%edx
 4ed:	48 98                	cltq
 4ef:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4f3:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4f6:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4f9:	ba 00 00 00 00       	mov    $0x0,%edx
 4fe:	f7 f7                	div    %edi
 500:	89 45 f4             	mov    %eax,-0xc(%rbp)
 503:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 507:	75 c3                	jne    4cc <printint+0x49>
  if(neg)
 509:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 50d:	74 2b                	je     53a <printint+0xb7>
    buf[i++] = '-';
 50f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 512:	8d 50 01             	lea    0x1(%rax),%edx
 515:	89 55 fc             	mov    %edx,-0x4(%rbp)
 518:	48 98                	cltq
 51a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 51f:	eb 19                	jmp    53a <printint+0xb7>
    putc(fd, buf[i]);
 521:	8b 45 fc             	mov    -0x4(%rbp),%eax
 524:	48 98                	cltq
 526:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 52b:	0f be d0             	movsbl %al,%edx
 52e:	8b 45 dc             	mov    -0x24(%rbp),%eax
 531:	89 d6                	mov    %edx,%esi
 533:	89 c7                	mov    %eax,%edi
 535:	e8 1c ff ff ff       	call   456 <putc>
  while(--i >= 0)
 53a:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 53e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 542:	79 dd                	jns    521 <printint+0x9e>
}
 544:	90                   	nop
 545:	90                   	nop
 546:	c9                   	leave
 547:	c3                   	ret

0000000000000548 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 548:	f3 0f 1e fa          	endbr64
 54c:	55                   	push   %rbp
 54d:	48 89 e5             	mov    %rsp,%rbp
 550:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 557:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 55d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 564:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 56b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 572:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 579:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 580:	84 c0                	test   %al,%al
 582:	74 20                	je     5a4 <printf+0x5c>
 584:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 588:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 58c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 590:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 594:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 598:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 59c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5a4:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5ab:	00 00 00 
 5ae:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5b5:	00 00 00 
 5b8:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5bc:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5c3:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5ca:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5d1:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5d8:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5db:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5e2:	00 00 00 
 5e5:	e9 a8 02 00 00       	jmp    892 <printf+0x34a>
    c = fmt[i] & 0xff;
 5ea:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f0:	48 63 d0             	movslq %eax,%rdx
 5f3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5fa:	48 01 d0             	add    %rdx,%rax
 5fd:	0f b6 00             	movzbl (%rax),%eax
 600:	0f be c0             	movsbl %al,%eax
 603:	25 ff 00 00 00       	and    $0xff,%eax
 608:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 60e:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 615:	75 35                	jne    64c <printf+0x104>
      if(c == '%'){
 617:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 61e:	75 0f                	jne    62f <printf+0xe7>
        state = '%';
 620:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 627:	00 00 00 
 62a:	e9 5c 02 00 00       	jmp    88b <printf+0x343>
      } else {
        putc(fd, c);
 62f:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 635:	0f be d0             	movsbl %al,%edx
 638:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 63e:	89 d6                	mov    %edx,%esi
 640:	89 c7                	mov    %eax,%edi
 642:	e8 0f fe ff ff       	call   456 <putc>
 647:	e9 3f 02 00 00       	jmp    88b <printf+0x343>
      }
    } else if(state == '%'){
 64c:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 653:	0f 85 32 02 00 00    	jne    88b <printf+0x343>
      if(c == 'd'){
 659:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 660:	75 5e                	jne    6c0 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 662:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 668:	83 f8 2f             	cmp    $0x2f,%eax
 66b:	77 23                	ja     690 <printf+0x148>
 66d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 674:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67a:	89 d2                	mov    %edx,%edx
 67c:	48 01 d0             	add    %rdx,%rax
 67f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 685:	83 c2 08             	add    $0x8,%edx
 688:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 68e:	eb 12                	jmp    6a2 <printf+0x15a>
 690:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 697:	48 8d 50 08          	lea    0x8(%rax),%rdx
 69b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6a2:	8b 30                	mov    (%rax),%esi
 6a4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6aa:	b9 01 00 00 00       	mov    $0x1,%ecx
 6af:	ba 0a 00 00 00       	mov    $0xa,%edx
 6b4:	89 c7                	mov    %eax,%edi
 6b6:	e8 c8 fd ff ff       	call   483 <printint>
 6bb:	e9 c1 01 00 00       	jmp    881 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6c7:	74 09                	je     6d2 <printf+0x18a>
 6c9:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d0:	75 5e                	jne    730 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6d2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d8:	83 f8 2f             	cmp    $0x2f,%eax
 6db:	77 23                	ja     700 <printf+0x1b8>
 6dd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ea:	89 d2                	mov    %edx,%edx
 6ec:	48 01 d0             	add    %rdx,%rax
 6ef:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f5:	83 c2 08             	add    $0x8,%edx
 6f8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6fe:	eb 12                	jmp    712 <printf+0x1ca>
 700:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 707:	48 8d 50 08          	lea    0x8(%rax),%rdx
 70b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 712:	8b 30                	mov    (%rax),%esi
 714:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 71a:	b9 00 00 00 00       	mov    $0x0,%ecx
 71f:	ba 10 00 00 00       	mov    $0x10,%edx
 724:	89 c7                	mov    %eax,%edi
 726:	e8 58 fd ff ff       	call   483 <printint>
 72b:	e9 51 01 00 00       	jmp    881 <printf+0x339>
      } else if(c == 's'){
 730:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 737:	0f 85 98 00 00 00    	jne    7d5 <printf+0x28d>
        s = va_arg(ap, char*);
 73d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 743:	83 f8 2f             	cmp    $0x2f,%eax
 746:	77 23                	ja     76b <printf+0x223>
 748:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 74f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 755:	89 d2                	mov    %edx,%edx
 757:	48 01 d0             	add    %rdx,%rax
 75a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 760:	83 c2 08             	add    $0x8,%edx
 763:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 769:	eb 12                	jmp    77d <printf+0x235>
 76b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 772:	48 8d 50 08          	lea    0x8(%rax),%rdx
 776:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 77d:	48 8b 00             	mov    (%rax),%rax
 780:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 787:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 78e:	00 
 78f:	75 31                	jne    7c2 <printf+0x27a>
          s = "(null)";
 791:	48 c7 85 48 ff ff ff 	movq   $0xb8d,-0xb8(%rbp)
 798:	8d 0b 00 00 
        while(*s != 0){
 79c:	eb 24                	jmp    7c2 <printf+0x27a>
          putc(fd, *s);
 79e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7a5:	0f b6 00             	movzbl (%rax),%eax
 7a8:	0f be d0             	movsbl %al,%edx
 7ab:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b1:	89 d6                	mov    %edx,%esi
 7b3:	89 c7                	mov    %eax,%edi
 7b5:	e8 9c fc ff ff       	call   456 <putc>
          s++;
 7ba:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7c1:	01 
        while(*s != 0){
 7c2:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7c9:	0f b6 00             	movzbl (%rax),%eax
 7cc:	84 c0                	test   %al,%al
 7ce:	75 ce                	jne    79e <printf+0x256>
 7d0:	e9 ac 00 00 00       	jmp    881 <printf+0x339>
        }
      } else if(c == 'c'){
 7d5:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7dc:	75 56                	jne    834 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7de:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7e4:	83 f8 2f             	cmp    $0x2f,%eax
 7e7:	77 23                	ja     80c <printf+0x2c4>
 7e9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f6:	89 d2                	mov    %edx,%edx
 7f8:	48 01 d0             	add    %rdx,%rax
 7fb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 801:	83 c2 08             	add    $0x8,%edx
 804:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 80a:	eb 12                	jmp    81e <printf+0x2d6>
 80c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 813:	48 8d 50 08          	lea    0x8(%rax),%rdx
 817:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 81e:	8b 00                	mov    (%rax),%eax
 820:	0f be d0             	movsbl %al,%edx
 823:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 829:	89 d6                	mov    %edx,%esi
 82b:	89 c7                	mov    %eax,%edi
 82d:	e8 24 fc ff ff       	call   456 <putc>
 832:	eb 4d                	jmp    881 <printf+0x339>
      } else if(c == '%'){
 834:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 83b:	75 1a                	jne    857 <printf+0x30f>
        putc(fd, c);
 83d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 843:	0f be d0             	movsbl %al,%edx
 846:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 84c:	89 d6                	mov    %edx,%esi
 84e:	89 c7                	mov    %eax,%edi
 850:	e8 01 fc ff ff       	call   456 <putc>
 855:	eb 2a                	jmp    881 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 857:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85d:	be 25 00 00 00       	mov    $0x25,%esi
 862:	89 c7                	mov    %eax,%edi
 864:	e8 ed fb ff ff       	call   456 <putc>
        putc(fd, c);
 869:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 86f:	0f be d0             	movsbl %al,%edx
 872:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 878:	89 d6                	mov    %edx,%esi
 87a:	89 c7                	mov    %eax,%edi
 87c:	e8 d5 fb ff ff       	call   456 <putc>
      }
      state = 0;
 881:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 888:	00 00 00 
  for(i = 0; fmt[i]; i++){
 88b:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 892:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 898:	48 63 d0             	movslq %eax,%rdx
 89b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8a2:	48 01 d0             	add    %rdx,%rax
 8a5:	0f b6 00             	movzbl (%rax),%eax
 8a8:	84 c0                	test   %al,%al
 8aa:	0f 85 3a fd ff ff    	jne    5ea <printf+0xa2>
    }
  }
}
 8b0:	90                   	nop
 8b1:	90                   	nop
 8b2:	c9                   	leave
 8b3:	c3                   	ret

00000000000008b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b4:	f3 0f 1e fa          	endbr64
 8b8:	55                   	push   %rbp
 8b9:	48 89 e5             	mov    %rsp,%rbp
 8bc:	48 83 ec 18          	sub    $0x18,%rsp
 8c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8c8:	48 83 e8 10          	sub    $0x10,%rax
 8cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	48 8b 05 29 05 00 00 	mov    0x529(%rip),%rax        # e00 <freep>
 8d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8db:	eb 2f                	jmp    90c <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e1:	48 8b 00             	mov    (%rax),%rax
 8e4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e8:	72 17                	jb     901 <free+0x4d>
 8ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ee:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f2:	72 2f                	jb     923 <free+0x6f>
 8f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f8:	48 8b 00             	mov    (%rax),%rax
 8fb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ff:	72 22                	jb     923 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 901:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 905:	48 8b 00             	mov    (%rax),%rax
 908:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 90c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 910:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 914:	73 c7                	jae    8dd <free+0x29>
 916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91a:	48 8b 00             	mov    (%rax),%rax
 91d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 921:	73 ba                	jae    8dd <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 927:	8b 40 08             	mov    0x8(%rax),%eax
 92a:	89 c0                	mov    %eax,%eax
 92c:	48 c1 e0 04          	shl    $0x4,%rax
 930:	48 89 c2             	mov    %rax,%rdx
 933:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 937:	48 01 c2             	add    %rax,%rdx
 93a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93e:	48 8b 00             	mov    (%rax),%rax
 941:	48 39 c2             	cmp    %rax,%rdx
 944:	75 2d                	jne    973 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94a:	8b 50 08             	mov    0x8(%rax),%edx
 94d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 951:	48 8b 00             	mov    (%rax),%rax
 954:	8b 40 08             	mov    0x8(%rax),%eax
 957:	01 c2                	add    %eax,%edx
 959:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95d:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 960:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 964:	48 8b 00             	mov    (%rax),%rax
 967:	48 8b 10             	mov    (%rax),%rdx
 96a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96e:	48 89 10             	mov    %rdx,(%rax)
 971:	eb 0e                	jmp    981 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 973:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 977:	48 8b 10             	mov    (%rax),%rdx
 97a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97e:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	8b 40 08             	mov    0x8(%rax),%eax
 988:	89 c0                	mov    %eax,%eax
 98a:	48 c1 e0 04          	shl    $0x4,%rax
 98e:	48 89 c2             	mov    %rax,%rdx
 991:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 995:	48 01 d0             	add    %rdx,%rax
 998:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 99c:	75 27                	jne    9c5 <free+0x111>
    p->s.size += bp->s.size;
 99e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a2:	8b 50 08             	mov    0x8(%rax),%edx
 9a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a9:	8b 40 08             	mov    0x8(%rax),%eax
 9ac:	01 c2                	add    %eax,%edx
 9ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b2:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b9:	48 8b 10             	mov    (%rax),%rdx
 9bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c0:	48 89 10             	mov    %rdx,(%rax)
 9c3:	eb 0b                	jmp    9d0 <free+0x11c>
  } else
    p->s.ptr = bp;
 9c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9cd:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d4:	48 89 05 25 04 00 00 	mov    %rax,0x425(%rip)        # e00 <freep>
}
 9db:	90                   	nop
 9dc:	c9                   	leave
 9dd:	c3                   	ret

00000000000009de <morecore>:

static Header*
morecore(uint nu)
{
 9de:	f3 0f 1e fa          	endbr64
 9e2:	55                   	push   %rbp
 9e3:	48 89 e5             	mov    %rsp,%rbp
 9e6:	48 83 ec 20          	sub    $0x20,%rsp
 9ea:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9ed:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9f4:	77 07                	ja     9fd <morecore+0x1f>
    nu = 4096;
 9f6:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a00:	c1 e0 04             	shl    $0x4,%eax
 a03:	89 c7                	mov    %eax,%edi
 a05:	e8 0c fa ff ff       	call   416 <sbrk>
 a0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a0e:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a13:	75 07                	jne    a1c <morecore+0x3e>
    return 0;
 a15:	b8 00 00 00 00       	mov    $0x0,%eax
 a1a:	eb 29                	jmp    a45 <morecore+0x67>
  hp = (Header*)p;
 a1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a20:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a28:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a2b:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a32:	48 83 c0 10          	add    $0x10,%rax
 a36:	48 89 c7             	mov    %rax,%rdi
 a39:	e8 76 fe ff ff       	call   8b4 <free>
  return freep;
 a3e:	48 8b 05 bb 03 00 00 	mov    0x3bb(%rip),%rax        # e00 <freep>
}
 a45:	c9                   	leave
 a46:	c3                   	ret

0000000000000a47 <malloc>:

void*
malloc(uint nbytes)
{
 a47:	f3 0f 1e fa          	endbr64
 a4b:	55                   	push   %rbp
 a4c:	48 89 e5             	mov    %rsp,%rbp
 a4f:	48 83 ec 30          	sub    $0x30,%rsp
 a53:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a56:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a59:	48 83 c0 0f          	add    $0xf,%rax
 a5d:	48 c1 e8 04          	shr    $0x4,%rax
 a61:	83 c0 01             	add    $0x1,%eax
 a64:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a67:	48 8b 05 92 03 00 00 	mov    0x392(%rip),%rax        # e00 <freep>
 a6e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a72:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a77:	75 2b                	jne    aa4 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a79:	48 c7 45 f0 f0 0d 00 	movq   $0xdf0,-0x10(%rbp)
 a80:	00 
 a81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a85:	48 89 05 74 03 00 00 	mov    %rax,0x374(%rip)        # e00 <freep>
 a8c:	48 8b 05 6d 03 00 00 	mov    0x36d(%rip),%rax        # e00 <freep>
 a93:	48 89 05 56 03 00 00 	mov    %rax,0x356(%rip)        # df0 <base>
    base.s.size = 0;
 a9a:	c7 05 54 03 00 00 00 	movl   $0x0,0x354(%rip)        # df8 <base+0x8>
 aa1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa8:	48 8b 00             	mov    (%rax),%rax
 aab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab3:	8b 40 08             	mov    0x8(%rax),%eax
 ab6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ab9:	72 5f                	jb     b1a <malloc+0xd3>
      if(p->s.size == nunits)
 abb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abf:	8b 40 08             	mov    0x8(%rax),%eax
 ac2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ac5:	75 10                	jne    ad7 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acb:	48 8b 10             	mov    (%rax),%rdx
 ace:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad2:	48 89 10             	mov    %rdx,(%rax)
 ad5:	eb 2e                	jmp    b05 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ad7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adb:	8b 40 08             	mov    0x8(%rax),%eax
 ade:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ae1:	89 c2                	mov    %eax,%edx
 ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae7:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aee:	8b 40 08             	mov    0x8(%rax),%eax
 af1:	89 c0                	mov    %eax,%eax
 af3:	48 c1 e0 04          	shl    $0x4,%rax
 af7:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aff:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b02:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b09:	48 89 05 f0 02 00 00 	mov    %rax,0x2f0(%rip)        # e00 <freep>
      return (void*)(p + 1);
 b10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b14:	48 83 c0 10          	add    $0x10,%rax
 b18:	eb 41                	jmp    b5b <malloc+0x114>
    }
    if(p == freep)
 b1a:	48 8b 05 df 02 00 00 	mov    0x2df(%rip),%rax        # e00 <freep>
 b21:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b25:	75 1c                	jne    b43 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b27:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b2a:	89 c7                	mov    %eax,%edi
 b2c:	e8 ad fe ff ff       	call   9de <morecore>
 b31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b35:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b3a:	75 07                	jne    b43 <malloc+0xfc>
        return 0;
 b3c:	b8 00 00 00 00       	mov    $0x0,%eax
 b41:	eb 18                	jmp    b5b <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b47:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4f:	48 8b 00             	mov    (%rax),%rax
 b52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b56:	e9 54 ff ff ff       	jmp    aaf <malloc+0x68>
  }
}
 b5b:	c9                   	leave
 b5c:	c3                   	ret
