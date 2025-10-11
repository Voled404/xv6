
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
  35:	48 c7 c6 65 0b 00 00 	mov    $0xb65,%rsi
  3c:	bf 02 00 00 00       	mov    $0x2,%edi
  41:	b8 00 00 00 00       	mov    $0x0,%eax
  46:	e8 05 05 00 00       	call   550 <printf>
    exit();
  4b:	e8 3e 03 00 00       	call   38e <exit>
  }
  printf(2, "System call count: %d\n", getcount(syscall));
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	89 c7                	mov    %eax,%edi
  55:	e8 f4 03 00 00       	call   44e <getcount>
  5a:	89 c2                	mov    %eax,%edx
  5c:	48 c7 c6 7e 0b 00 00 	mov    $0xb7e,%rsi
  63:	bf 02 00 00 00       	mov    $0x2,%edi
  68:	b8 00 00 00 00       	mov    $0x0,%eax
  6d:	e8 de 04 00 00       	call   550 <printf>
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

0000000000000456 <killrandom>:
SYSCALL(killrandom)
 456:	b8 1f 00 00 00       	mov    $0x1f,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret

000000000000045e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45e:	f3 0f 1e fa          	endbr64
 462:	55                   	push   %rbp
 463:	48 89 e5             	mov    %rsp,%rbp
 466:	48 83 ec 10          	sub    $0x10,%rsp
 46a:	89 7d fc             	mov    %edi,-0x4(%rbp)
 46d:	89 f0                	mov    %esi,%eax
 46f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 472:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 476:	8b 45 fc             	mov    -0x4(%rbp),%eax
 479:	ba 01 00 00 00       	mov    $0x1,%edx
 47e:	48 89 ce             	mov    %rcx,%rsi
 481:	89 c7                	mov    %eax,%edi
 483:	e8 26 ff ff ff       	call   3ae <write>
}
 488:	90                   	nop
 489:	c9                   	leave
 48a:	c3                   	ret

000000000000048b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 48b:	f3 0f 1e fa          	endbr64
 48f:	55                   	push   %rbp
 490:	48 89 e5             	mov    %rsp,%rbp
 493:	48 83 ec 30          	sub    $0x30,%rsp
 497:	89 7d dc             	mov    %edi,-0x24(%rbp)
 49a:	89 75 d8             	mov    %esi,-0x28(%rbp)
 49d:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4a0:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4aa:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4ae:	74 17                	je     4c7 <printint+0x3c>
 4b0:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4b4:	79 11                	jns    4c7 <printint+0x3c>
    neg = 1;
 4b6:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4bd:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c0:	f7 d8                	neg    %eax
 4c2:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4c5:	eb 06                	jmp    4cd <printint+0x42>
  } else {
    x = xx;
 4c7:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4ca:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4d4:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4da:	ba 00 00 00 00       	mov    $0x0,%edx
 4df:	f7 f6                	div    %esi
 4e1:	89 d1                	mov    %edx,%ecx
 4e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e6:	8d 50 01             	lea    0x1(%rax),%edx
 4e9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ec:	89 ca                	mov    %ecx,%edx
 4ee:	0f b6 92 e0 0d 00 00 	movzbl 0xde0(%rdx),%edx
 4f5:	48 98                	cltq
 4f7:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4fb:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
 501:	ba 00 00 00 00       	mov    $0x0,%edx
 506:	f7 f7                	div    %edi
 508:	89 45 f4             	mov    %eax,-0xc(%rbp)
 50b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 50f:	75 c3                	jne    4d4 <printint+0x49>
  if(neg)
 511:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 515:	74 2b                	je     542 <printint+0xb7>
    buf[i++] = '-';
 517:	8b 45 fc             	mov    -0x4(%rbp),%eax
 51a:	8d 50 01             	lea    0x1(%rax),%edx
 51d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 520:	48 98                	cltq
 522:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 527:	eb 19                	jmp    542 <printint+0xb7>
    putc(fd, buf[i]);
 529:	8b 45 fc             	mov    -0x4(%rbp),%eax
 52c:	48 98                	cltq
 52e:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 533:	0f be d0             	movsbl %al,%edx
 536:	8b 45 dc             	mov    -0x24(%rbp),%eax
 539:	89 d6                	mov    %edx,%esi
 53b:	89 c7                	mov    %eax,%edi
 53d:	e8 1c ff ff ff       	call   45e <putc>
  while(--i >= 0)
 542:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 546:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 54a:	79 dd                	jns    529 <printint+0x9e>
}
 54c:	90                   	nop
 54d:	90                   	nop
 54e:	c9                   	leave
 54f:	c3                   	ret

0000000000000550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 550:	f3 0f 1e fa          	endbr64
 554:	55                   	push   %rbp
 555:	48 89 e5             	mov    %rsp,%rbp
 558:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 55f:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 565:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 56c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 573:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 57a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 581:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 588:	84 c0                	test   %al,%al
 58a:	74 20                	je     5ac <printf+0x5c>
 58c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 590:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 594:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 598:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 59c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5a0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5a4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5ac:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5b3:	00 00 00 
 5b6:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5bd:	00 00 00 
 5c0:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5c4:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5cb:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5d2:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5d9:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5e0:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5e3:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5ea:	00 00 00 
 5ed:	e9 a8 02 00 00       	jmp    89a <printf+0x34a>
    c = fmt[i] & 0xff;
 5f2:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f8:	48 63 d0             	movslq %eax,%rdx
 5fb:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 602:	48 01 d0             	add    %rdx,%rax
 605:	0f b6 00             	movzbl (%rax),%eax
 608:	0f be c0             	movsbl %al,%eax
 60b:	25 ff 00 00 00       	and    $0xff,%eax
 610:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 616:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 61d:	75 35                	jne    654 <printf+0x104>
      if(c == '%'){
 61f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 626:	75 0f                	jne    637 <printf+0xe7>
        state = '%';
 628:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 62f:	00 00 00 
 632:	e9 5c 02 00 00       	jmp    893 <printf+0x343>
      } else {
        putc(fd, c);
 637:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 63d:	0f be d0             	movsbl %al,%edx
 640:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 646:	89 d6                	mov    %edx,%esi
 648:	89 c7                	mov    %eax,%edi
 64a:	e8 0f fe ff ff       	call   45e <putc>
 64f:	e9 3f 02 00 00       	jmp    893 <printf+0x343>
      }
    } else if(state == '%'){
 654:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 65b:	0f 85 32 02 00 00    	jne    893 <printf+0x343>
      if(c == 'd'){
 661:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 668:	75 5e                	jne    6c8 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 66a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 670:	83 f8 2f             	cmp    $0x2f,%eax
 673:	77 23                	ja     698 <printf+0x148>
 675:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 67c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 682:	89 d2                	mov    %edx,%edx
 684:	48 01 d0             	add    %rdx,%rax
 687:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68d:	83 c2 08             	add    $0x8,%edx
 690:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 696:	eb 12                	jmp    6aa <printf+0x15a>
 698:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 69f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6a3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6aa:	8b 30                	mov    (%rax),%esi
 6ac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b2:	b9 01 00 00 00       	mov    $0x1,%ecx
 6b7:	ba 0a 00 00 00       	mov    $0xa,%edx
 6bc:	89 c7                	mov    %eax,%edi
 6be:	e8 c8 fd ff ff       	call   48b <printint>
 6c3:	e9 c1 01 00 00       	jmp    889 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c8:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6cf:	74 09                	je     6da <printf+0x18a>
 6d1:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d8:	75 5e                	jne    738 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6da:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e0:	83 f8 2f             	cmp    $0x2f,%eax
 6e3:	77 23                	ja     708 <printf+0x1b8>
 6e5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ec:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f2:	89 d2                	mov    %edx,%edx
 6f4:	48 01 d0             	add    %rdx,%rax
 6f7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fd:	83 c2 08             	add    $0x8,%edx
 700:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 706:	eb 12                	jmp    71a <printf+0x1ca>
 708:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 70f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 713:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 71a:	8b 30                	mov    (%rax),%esi
 71c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 722:	b9 00 00 00 00       	mov    $0x0,%ecx
 727:	ba 10 00 00 00       	mov    $0x10,%edx
 72c:	89 c7                	mov    %eax,%edi
 72e:	e8 58 fd ff ff       	call   48b <printint>
 733:	e9 51 01 00 00       	jmp    889 <printf+0x339>
      } else if(c == 's'){
 738:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 73f:	0f 85 98 00 00 00    	jne    7dd <printf+0x28d>
        s = va_arg(ap, char*);
 745:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74b:	83 f8 2f             	cmp    $0x2f,%eax
 74e:	77 23                	ja     773 <printf+0x223>
 750:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 757:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75d:	89 d2                	mov    %edx,%edx
 75f:	48 01 d0             	add    %rdx,%rax
 762:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 768:	83 c2 08             	add    $0x8,%edx
 76b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 771:	eb 12                	jmp    785 <printf+0x235>
 773:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 77e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 785:	48 8b 00             	mov    (%rax),%rax
 788:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 78f:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 796:	00 
 797:	75 31                	jne    7ca <printf+0x27a>
          s = "(null)";
 799:	48 c7 85 48 ff ff ff 	movq   $0xb95,-0xb8(%rbp)
 7a0:	95 0b 00 00 
        while(*s != 0){
 7a4:	eb 24                	jmp    7ca <printf+0x27a>
          putc(fd, *s);
 7a6:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ad:	0f b6 00             	movzbl (%rax),%eax
 7b0:	0f be d0             	movsbl %al,%edx
 7b3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b9:	89 d6                	mov    %edx,%esi
 7bb:	89 c7                	mov    %eax,%edi
 7bd:	e8 9c fc ff ff       	call   45e <putc>
          s++;
 7c2:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7c9:	01 
        while(*s != 0){
 7ca:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7d1:	0f b6 00             	movzbl (%rax),%eax
 7d4:	84 c0                	test   %al,%al
 7d6:	75 ce                	jne    7a6 <printf+0x256>
 7d8:	e9 ac 00 00 00       	jmp    889 <printf+0x339>
        }
      } else if(c == 'c'){
 7dd:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7e4:	75 56                	jne    83c <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7e6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ec:	83 f8 2f             	cmp    $0x2f,%eax
 7ef:	77 23                	ja     814 <printf+0x2c4>
 7f1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7fe:	89 d2                	mov    %edx,%edx
 800:	48 01 d0             	add    %rdx,%rax
 803:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 809:	83 c2 08             	add    $0x8,%edx
 80c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 812:	eb 12                	jmp    826 <printf+0x2d6>
 814:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 81b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 81f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 826:	8b 00                	mov    (%rax),%eax
 828:	0f be d0             	movsbl %al,%edx
 82b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 831:	89 d6                	mov    %edx,%esi
 833:	89 c7                	mov    %eax,%edi
 835:	e8 24 fc ff ff       	call   45e <putc>
 83a:	eb 4d                	jmp    889 <printf+0x339>
      } else if(c == '%'){
 83c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 843:	75 1a                	jne    85f <printf+0x30f>
        putc(fd, c);
 845:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 84b:	0f be d0             	movsbl %al,%edx
 84e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 854:	89 d6                	mov    %edx,%esi
 856:	89 c7                	mov    %eax,%edi
 858:	e8 01 fc ff ff       	call   45e <putc>
 85d:	eb 2a                	jmp    889 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 85f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 865:	be 25 00 00 00       	mov    $0x25,%esi
 86a:	89 c7                	mov    %eax,%edi
 86c:	e8 ed fb ff ff       	call   45e <putc>
        putc(fd, c);
 871:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 877:	0f be d0             	movsbl %al,%edx
 87a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 880:	89 d6                	mov    %edx,%esi
 882:	89 c7                	mov    %eax,%edi
 884:	e8 d5 fb ff ff       	call   45e <putc>
      }
      state = 0;
 889:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 890:	00 00 00 
  for(i = 0; fmt[i]; i++){
 893:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 89a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8a0:	48 63 d0             	movslq %eax,%rdx
 8a3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8aa:	48 01 d0             	add    %rdx,%rax
 8ad:	0f b6 00             	movzbl (%rax),%eax
 8b0:	84 c0                	test   %al,%al
 8b2:	0f 85 3a fd ff ff    	jne    5f2 <printf+0xa2>
    }
  }
}
 8b8:	90                   	nop
 8b9:	90                   	nop
 8ba:	c9                   	leave
 8bb:	c3                   	ret

00000000000008bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8bc:	f3 0f 1e fa          	endbr64
 8c0:	55                   	push   %rbp
 8c1:	48 89 e5             	mov    %rsp,%rbp
 8c4:	48 83 ec 18          	sub    $0x18,%rsp
 8c8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8d0:	48 83 e8 10          	sub    $0x10,%rax
 8d4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	48 8b 05 31 05 00 00 	mov    0x531(%rip),%rax        # e10 <freep>
 8df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8e3:	eb 2f                	jmp    914 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e9:	48 8b 00             	mov    (%rax),%rax
 8ec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f0:	72 17                	jb     909 <free+0x4d>
 8f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8fa:	72 2f                	jb     92b <free+0x6f>
 8fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 900:	48 8b 00             	mov    (%rax),%rax
 903:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 907:	72 22                	jb     92b <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 909:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90d:	48 8b 00             	mov    (%rax),%rax
 910:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 914:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 918:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 91c:	73 c7                	jae    8e5 <free+0x29>
 91e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 922:	48 8b 00             	mov    (%rax),%rax
 925:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 929:	73 ba                	jae    8e5 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 92b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92f:	8b 40 08             	mov    0x8(%rax),%eax
 932:	89 c0                	mov    %eax,%eax
 934:	48 c1 e0 04          	shl    $0x4,%rax
 938:	48 89 c2             	mov    %rax,%rdx
 93b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93f:	48 01 c2             	add    %rax,%rdx
 942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 946:	48 8b 00             	mov    (%rax),%rax
 949:	48 39 c2             	cmp    %rax,%rdx
 94c:	75 2d                	jne    97b <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 94e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 952:	8b 50 08             	mov    0x8(%rax),%edx
 955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 959:	48 8b 00             	mov    (%rax),%rax
 95c:	8b 40 08             	mov    0x8(%rax),%eax
 95f:	01 c2                	add    %eax,%edx
 961:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 965:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 968:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96c:	48 8b 00             	mov    (%rax),%rax
 96f:	48 8b 10             	mov    (%rax),%rdx
 972:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 976:	48 89 10             	mov    %rdx,(%rax)
 979:	eb 0e                	jmp    989 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 97b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97f:	48 8b 10             	mov    (%rax),%rdx
 982:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 986:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	8b 40 08             	mov    0x8(%rax),%eax
 990:	89 c0                	mov    %eax,%eax
 992:	48 c1 e0 04          	shl    $0x4,%rax
 996:	48 89 c2             	mov    %rax,%rdx
 999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99d:	48 01 d0             	add    %rdx,%rax
 9a0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9a4:	75 27                	jne    9cd <free+0x111>
    p->s.size += bp->s.size;
 9a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9aa:	8b 50 08             	mov    0x8(%rax),%edx
 9ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b1:	8b 40 08             	mov    0x8(%rax),%eax
 9b4:	01 c2                	add    %eax,%edx
 9b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ba:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c1:	48 8b 10             	mov    (%rax),%rdx
 9c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c8:	48 89 10             	mov    %rdx,(%rax)
 9cb:	eb 0b                	jmp    9d8 <free+0x11c>
  } else
    p->s.ptr = bp;
 9cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9d5:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dc:	48 89 05 2d 04 00 00 	mov    %rax,0x42d(%rip)        # e10 <freep>
}
 9e3:	90                   	nop
 9e4:	c9                   	leave
 9e5:	c3                   	ret

00000000000009e6 <morecore>:

static Header*
morecore(uint nu)
{
 9e6:	f3 0f 1e fa          	endbr64
 9ea:	55                   	push   %rbp
 9eb:	48 89 e5             	mov    %rsp,%rbp
 9ee:	48 83 ec 20          	sub    $0x20,%rsp
 9f2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9f5:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9fc:	77 07                	ja     a05 <morecore+0x1f>
    nu = 4096;
 9fe:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a05:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a08:	c1 e0 04             	shl    $0x4,%eax
 a0b:	89 c7                	mov    %eax,%edi
 a0d:	e8 04 fa ff ff       	call   416 <sbrk>
 a12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a16:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a1b:	75 07                	jne    a24 <morecore+0x3e>
    return 0;
 a1d:	b8 00 00 00 00       	mov    $0x0,%eax
 a22:	eb 29                	jmp    a4d <morecore+0x67>
  hp = (Header*)p;
 a24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a28:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a30:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a33:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3a:	48 83 c0 10          	add    $0x10,%rax
 a3e:	48 89 c7             	mov    %rax,%rdi
 a41:	e8 76 fe ff ff       	call   8bc <free>
  return freep;
 a46:	48 8b 05 c3 03 00 00 	mov    0x3c3(%rip),%rax        # e10 <freep>
}
 a4d:	c9                   	leave
 a4e:	c3                   	ret

0000000000000a4f <malloc>:

void*
malloc(uint nbytes)
{
 a4f:	f3 0f 1e fa          	endbr64
 a53:	55                   	push   %rbp
 a54:	48 89 e5             	mov    %rsp,%rbp
 a57:	48 83 ec 30          	sub    $0x30,%rsp
 a5b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5e:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a61:	48 83 c0 0f          	add    $0xf,%rax
 a65:	48 c1 e8 04          	shr    $0x4,%rax
 a69:	83 c0 01             	add    $0x1,%eax
 a6c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a6f:	48 8b 05 9a 03 00 00 	mov    0x39a(%rip),%rax        # e10 <freep>
 a76:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a7a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a7f:	75 2b                	jne    aac <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a81:	48 c7 45 f0 00 0e 00 	movq   $0xe00,-0x10(%rbp)
 a88:	00 
 a89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8d:	48 89 05 7c 03 00 00 	mov    %rax,0x37c(%rip)        # e10 <freep>
 a94:	48 8b 05 75 03 00 00 	mov    0x375(%rip),%rax        # e10 <freep>
 a9b:	48 89 05 5e 03 00 00 	mov    %rax,0x35e(%rip)        # e00 <base>
    base.s.size = 0;
 aa2:	c7 05 5c 03 00 00 00 	movl   $0x0,0x35c(%rip)        # e08 <base+0x8>
 aa9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab0:	48 8b 00             	mov    (%rax),%rax
 ab3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ab7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abb:	8b 40 08             	mov    0x8(%rax),%eax
 abe:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ac1:	72 5f                	jb     b22 <malloc+0xd3>
      if(p->s.size == nunits)
 ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac7:	8b 40 08             	mov    0x8(%rax),%eax
 aca:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 acd:	75 10                	jne    adf <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad3:	48 8b 10             	mov    (%rax),%rdx
 ad6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ada:	48 89 10             	mov    %rdx,(%rax)
 add:	eb 2e                	jmp    b0d <malloc+0xbe>
      else {
        p->s.size -= nunits;
 adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae3:	8b 40 08             	mov    0x8(%rax),%eax
 ae6:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ae9:	89 c2                	mov    %eax,%edx
 aeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aef:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 af2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af6:	8b 40 08             	mov    0x8(%rax),%eax
 af9:	89 c0                	mov    %eax,%eax
 afb:	48 c1 e0 04          	shl    $0x4,%rax
 aff:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b07:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b0a:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b11:	48 89 05 f8 02 00 00 	mov    %rax,0x2f8(%rip)        # e10 <freep>
      return (void*)(p + 1);
 b18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1c:	48 83 c0 10          	add    $0x10,%rax
 b20:	eb 41                	jmp    b63 <malloc+0x114>
    }
    if(p == freep)
 b22:	48 8b 05 e7 02 00 00 	mov    0x2e7(%rip),%rax        # e10 <freep>
 b29:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b2d:	75 1c                	jne    b4b <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b32:	89 c7                	mov    %eax,%edi
 b34:	e8 ad fe ff ff       	call   9e6 <morecore>
 b39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b3d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b42:	75 07                	jne    b4b <malloc+0xfc>
        return 0;
 b44:	b8 00 00 00 00       	mov    $0x0,%eax
 b49:	eb 18                	jmp    b63 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b57:	48 8b 00             	mov    (%rax),%rax
 b5a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b5e:	e9 54 ff ff ff       	jmp    ab7 <malloc+0x68>
  }
}
 b63:	c9                   	leave
 b64:	c3                   	ret
