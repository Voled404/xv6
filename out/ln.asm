
fs/ln:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 10          	sub    $0x10,%rsp
   c:	89 7d fc             	mov    %edi,-0x4(%rbp)
   f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(argc != 3){
  13:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  17:	74 1b                	je     34 <main+0x34>
    printf(2, "Usage: ln old new\n");
  19:	48 c7 c6 6e 0b 00 00 	mov    $0xb6e,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 2a 05 00 00       	call   559 <printf>
    exit();
  2f:	e8 73 03 00 00       	call   3a7 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  38:	48 83 c0 10          	add    $0x10,%rax
  3c:	48 8b 10             	mov    (%rax),%rdx
  3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  43:	48 83 c0 08          	add    $0x8,%rax
  47:	48 8b 00             	mov    (%rax),%rax
  4a:	48 89 d6             	mov    %rdx,%rsi
  4d:	48 89 c7             	mov    %rax,%rdi
  50:	e8 b2 03 00 00       	call   407 <link>
  55:	85 c0                	test   %eax,%eax
  57:	79 32                	jns    8b <main+0x8b>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  5d:	48 83 c0 10          	add    $0x10,%rax
  61:	48 8b 10             	mov    (%rax),%rdx
  64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  68:	48 83 c0 08          	add    $0x8,%rax
  6c:	48 8b 00             	mov    (%rax),%rax
  6f:	48 89 d1             	mov    %rdx,%rcx
  72:	48 89 c2             	mov    %rax,%rdx
  75:	48 c7 c6 81 0b 00 00 	mov    $0xb81,%rsi
  7c:	bf 02 00 00 00       	mov    $0x2,%edi
  81:	b8 00 00 00 00       	mov    $0x0,%eax
  86:	e8 ce 04 00 00       	call   559 <printf>
  exit();
  8b:	e8 17 03 00 00       	call   3a7 <exit>

0000000000000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %rbp
  91:	48 89 e5             	mov    %rsp,%rbp
  94:	48 83 ec 10          	sub    $0x10,%rsp
  98:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  9c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  9f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  a2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  a6:	8b 55 f0             	mov    -0x10(%rbp),%edx
  a9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  ac:	48 89 ce             	mov    %rcx,%rsi
  af:	48 89 f7             	mov    %rsi,%rdi
  b2:	89 d1                	mov    %edx,%ecx
  b4:	fc                   	cld
  b5:	f3 aa                	rep stos %al,%es:(%rdi)
  b7:	89 ca                	mov    %ecx,%edx
  b9:	48 89 fe             	mov    %rdi,%rsi
  bc:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  c0:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  c3:	90                   	nop
  c4:	c9                   	leave
  c5:	c3                   	ret

00000000000000c6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c6:	f3 0f 1e fa          	endbr64
  ca:	55                   	push   %rbp
  cb:	48 89 e5             	mov    %rsp,%rbp
  ce:	48 83 ec 20          	sub    $0x20,%rsp
  d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  d6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  e2:	90                   	nop
  e3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  e7:	48 8d 42 01          	lea    0x1(%rdx),%rax
  eb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  f3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  fb:	0f b6 12             	movzbl (%rdx),%edx
  fe:	88 10                	mov    %dl,(%rax)
 100:	0f b6 00             	movzbl (%rax),%eax
 103:	84 c0                	test   %al,%al
 105:	75 dc                	jne    e3 <strcpy+0x1d>
    ;
  return os;
 107:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 10b:	c9                   	leave
 10c:	c3                   	ret

000000000000010d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10d:	f3 0f 1e fa          	endbr64
 111:	55                   	push   %rbp
 112:	48 89 e5             	mov    %rsp,%rbp
 115:	48 83 ec 10          	sub    $0x10,%rsp
 119:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 11d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 121:	eb 0a                	jmp    12d <strcmp+0x20>
    p++, q++;
 123:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 128:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 12d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 131:	0f b6 00             	movzbl (%rax),%eax
 134:	84 c0                	test   %al,%al
 136:	74 12                	je     14a <strcmp+0x3d>
 138:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 13c:	0f b6 10             	movzbl (%rax),%edx
 13f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 143:	0f b6 00             	movzbl (%rax),%eax
 146:	38 c2                	cmp    %al,%dl
 148:	74 d9                	je     123 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 14a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 14e:	0f b6 00             	movzbl (%rax),%eax
 151:	0f b6 d0             	movzbl %al,%edx
 154:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 158:	0f b6 00             	movzbl (%rax),%eax
 15b:	0f b6 c0             	movzbl %al,%eax
 15e:	29 c2                	sub    %eax,%edx
 160:	89 d0                	mov    %edx,%eax
}
 162:	c9                   	leave
 163:	c3                   	ret

0000000000000164 <strlen>:

uint
strlen(char *s)
{
 164:	f3 0f 1e fa          	endbr64
 168:	55                   	push   %rbp
 169:	48 89 e5             	mov    %rsp,%rbp
 16c:	48 83 ec 18          	sub    $0x18,%rsp
 170:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 174:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 17b:	eb 04                	jmp    181 <strlen+0x1d>
 17d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 181:	8b 45 fc             	mov    -0x4(%rbp),%eax
 184:	48 63 d0             	movslq %eax,%rdx
 187:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 18b:	48 01 d0             	add    %rdx,%rax
 18e:	0f b6 00             	movzbl (%rax),%eax
 191:	84 c0                	test   %al,%al
 193:	75 e8                	jne    17d <strlen+0x19>
    ;
  return n;
 195:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 198:	c9                   	leave
 199:	c3                   	ret

000000000000019a <memset>:

void*
memset(void *dst, int c, uint n)
{
 19a:	f3 0f 1e fa          	endbr64
 19e:	55                   	push   %rbp
 19f:	48 89 e5             	mov    %rsp,%rbp
 1a2:	48 83 ec 10          	sub    $0x10,%rsp
 1a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1aa:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1ad:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 1b0:	8b 55 f0             	mov    -0x10(%rbp),%edx
 1b3:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 1b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1ba:	89 ce                	mov    %ecx,%esi
 1bc:	48 89 c7             	mov    %rax,%rdi
 1bf:	e8 cc fe ff ff       	call   90 <stosb>
  return dst;
 1c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1c8:	c9                   	leave
 1c9:	c3                   	ret

00000000000001ca <strchr>:

char*
strchr(const char *s, char c)
{
 1ca:	f3 0f 1e fa          	endbr64
 1ce:	55                   	push   %rbp
 1cf:	48 89 e5             	mov    %rsp,%rbp
 1d2:	48 83 ec 10          	sub    $0x10,%rsp
 1d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1da:	89 f0                	mov    %esi,%eax
 1dc:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1df:	eb 17                	jmp    1f8 <strchr+0x2e>
    if(*s == c)
 1e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e5:	0f b6 00             	movzbl (%rax),%eax
 1e8:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1eb:	75 06                	jne    1f3 <strchr+0x29>
      return (char*)s;
 1ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1f1:	eb 15                	jmp    208 <strchr+0x3e>
  for(; *s; s++)
 1f3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1fc:	0f b6 00             	movzbl (%rax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 de                	jne    1e1 <strchr+0x17>
  return 0;
 203:	b8 00 00 00 00       	mov    $0x0,%eax
}
 208:	c9                   	leave
 209:	c3                   	ret

000000000000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	f3 0f 1e fa          	endbr64
 20e:	55                   	push   %rbp
 20f:	48 89 e5             	mov    %rsp,%rbp
 212:	48 83 ec 20          	sub    $0x20,%rsp
 216:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 21a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 224:	eb 48                	jmp    26e <gets+0x64>
    cc = read(0, &c, 1);
 226:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 22a:	ba 01 00 00 00       	mov    $0x1,%edx
 22f:	48 89 c6             	mov    %rax,%rsi
 232:	bf 00 00 00 00       	mov    $0x0,%edi
 237:	e8 83 01 00 00       	call   3bf <read>
 23c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 23f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 243:	7e 36                	jle    27b <gets+0x71>
      break;
    buf[i++] = c;
 245:	8b 45 fc             	mov    -0x4(%rbp),%eax
 248:	8d 50 01             	lea    0x1(%rax),%edx
 24b:	89 55 fc             	mov    %edx,-0x4(%rbp)
 24e:	48 63 d0             	movslq %eax,%rdx
 251:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 255:	48 01 c2             	add    %rax,%rdx
 258:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 25c:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 25e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 262:	3c 0a                	cmp    $0xa,%al
 264:	74 16                	je     27c <gets+0x72>
 266:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 26a:	3c 0d                	cmp    $0xd,%al
 26c:	74 0e                	je     27c <gets+0x72>
  for(i=0; i+1 < max; ){
 26e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 271:	83 c0 01             	add    $0x1,%eax
 274:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 277:	7f ad                	jg     226 <gets+0x1c>
 279:	eb 01                	jmp    27c <gets+0x72>
      break;
 27b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 27c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 27f:	48 63 d0             	movslq %eax,%rdx
 282:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 286:	48 01 d0             	add    %rdx,%rax
 289:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 28c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 290:	c9                   	leave
 291:	c3                   	ret

0000000000000292 <stat>:

int
stat(char *n, struct stat *st)
{
 292:	f3 0f 1e fa          	endbr64
 296:	55                   	push   %rbp
 297:	48 89 e5             	mov    %rsp,%rbp
 29a:	48 83 ec 20          	sub    $0x20,%rsp
 29e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2a2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2aa:	be 00 00 00 00       	mov    $0x0,%esi
 2af:	48 89 c7             	mov    %rax,%rdi
 2b2:	e8 30 01 00 00       	call   3e7 <open>
 2b7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 2ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2be:	79 07                	jns    2c7 <stat+0x35>
    return -1;
 2c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c5:	eb 21                	jmp    2e8 <stat+0x56>
  r = fstat(fd, st);
 2c7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2ce:	48 89 d6             	mov    %rdx,%rsi
 2d1:	89 c7                	mov    %eax,%edi
 2d3:	e8 27 01 00 00       	call   3ff <fstat>
 2d8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2de:	89 c7                	mov    %eax,%edi
 2e0:	e8 ea 00 00 00       	call   3cf <close>
  return r;
 2e5:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2e8:	c9                   	leave
 2e9:	c3                   	ret

00000000000002ea <atoi>:

int
atoi(const char *s)
{
 2ea:	f3 0f 1e fa          	endbr64
 2ee:	55                   	push   %rbp
 2ef:	48 89 e5             	mov    %rsp,%rbp
 2f2:	48 83 ec 18          	sub    $0x18,%rsp
 2f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 301:	eb 28                	jmp    32b <atoi+0x41>
    n = n*10 + *s++ - '0';
 303:	8b 55 fc             	mov    -0x4(%rbp),%edx
 306:	89 d0                	mov    %edx,%eax
 308:	c1 e0 02             	shl    $0x2,%eax
 30b:	01 d0                	add    %edx,%eax
 30d:	01 c0                	add    %eax,%eax
 30f:	89 c1                	mov    %eax,%ecx
 311:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 315:	48 8d 50 01          	lea    0x1(%rax),%rdx
 319:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 31d:	0f b6 00             	movzbl (%rax),%eax
 320:	0f be c0             	movsbl %al,%eax
 323:	01 c8                	add    %ecx,%eax
 325:	83 e8 30             	sub    $0x30,%eax
 328:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 32b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 32f:	0f b6 00             	movzbl (%rax),%eax
 332:	3c 2f                	cmp    $0x2f,%al
 334:	7e 0b                	jle    341 <atoi+0x57>
 336:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 33a:	0f b6 00             	movzbl (%rax),%eax
 33d:	3c 39                	cmp    $0x39,%al
 33f:	7e c2                	jle    303 <atoi+0x19>
  return n;
 341:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 344:	c9                   	leave
 345:	c3                   	ret

0000000000000346 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 346:	f3 0f 1e fa          	endbr64
 34a:	55                   	push   %rbp
 34b:	48 89 e5             	mov    %rsp,%rbp
 34e:	48 83 ec 28          	sub    $0x28,%rsp
 352:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 356:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 35a:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 35d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 361:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 365:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 369:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 36d:	eb 1d                	jmp    38c <memmove+0x46>
    *dst++ = *src++;
 36f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 373:	48 8d 42 01          	lea    0x1(%rdx),%rax
 377:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 37b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 37f:	48 8d 48 01          	lea    0x1(%rax),%rcx
 383:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 387:	0f b6 12             	movzbl (%rdx),%edx
 38a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 38c:	8b 45 dc             	mov    -0x24(%rbp),%eax
 38f:	8d 50 ff             	lea    -0x1(%rax),%edx
 392:	89 55 dc             	mov    %edx,-0x24(%rbp)
 395:	85 c0                	test   %eax,%eax
 397:	7f d6                	jg     36f <memmove+0x29>
  return vdst;
 399:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 39d:	c9                   	leave
 39e:	c3                   	ret

000000000000039f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39f:	b8 01 00 00 00       	mov    $0x1,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <exit>:
SYSCALL(exit)
 3a7:	b8 02 00 00 00       	mov    $0x2,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <wait>:
SYSCALL(wait)
 3af:	b8 03 00 00 00       	mov    $0x3,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <pipe>:
SYSCALL(pipe)
 3b7:	b8 04 00 00 00       	mov    $0x4,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <read>:
SYSCALL(read)
 3bf:	b8 05 00 00 00       	mov    $0x5,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <write>:
SYSCALL(write)
 3c7:	b8 10 00 00 00       	mov    $0x10,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <close>:
SYSCALL(close)
 3cf:	b8 15 00 00 00       	mov    $0x15,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <kill>:
SYSCALL(kill)
 3d7:	b8 06 00 00 00       	mov    $0x6,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <exec>:
SYSCALL(exec)
 3df:	b8 07 00 00 00       	mov    $0x7,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <open>:
SYSCALL(open)
 3e7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <mknod>:
SYSCALL(mknod)
 3ef:	b8 11 00 00 00       	mov    $0x11,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <unlink>:
SYSCALL(unlink)
 3f7:	b8 12 00 00 00       	mov    $0x12,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <fstat>:
SYSCALL(fstat)
 3ff:	b8 08 00 00 00       	mov    $0x8,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <link>:
SYSCALL(link)
 407:	b8 13 00 00 00       	mov    $0x13,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

000000000000040f <mkdir>:
SYSCALL(mkdir)
 40f:	b8 14 00 00 00       	mov    $0x14,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <chdir>:
SYSCALL(chdir)
 417:	b8 09 00 00 00       	mov    $0x9,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <dup>:
SYSCALL(dup)
 41f:	b8 0a 00 00 00       	mov    $0xa,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

0000000000000427 <getpid>:
SYSCALL(getpid)
 427:	b8 0b 00 00 00       	mov    $0xb,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

000000000000042f <sbrk>:
SYSCALL(sbrk)
 42f:	b8 0c 00 00 00       	mov    $0xc,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

0000000000000437 <sleep>:
SYSCALL(sleep)
 437:	b8 0d 00 00 00       	mov    $0xd,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

000000000000043f <uptime>:
SYSCALL(uptime)
 43f:	b8 0e 00 00 00       	mov    $0xe,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret

0000000000000447 <getpinfo>:
SYSCALL(getpinfo)
 447:	b8 18 00 00 00       	mov    $0x18,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret

000000000000044f <settickets>:
SYSCALL(settickets)
 44f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret

0000000000000457 <getfavnum>:
SYSCALL(getfavnum)
 457:	b8 1c 00 00 00       	mov    $0x1c,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret

000000000000045f <halt>:
SYSCALL(halt)
 45f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret

0000000000000467 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 467:	f3 0f 1e fa          	endbr64
 46b:	55                   	push   %rbp
 46c:	48 89 e5             	mov    %rsp,%rbp
 46f:	48 83 ec 10          	sub    $0x10,%rsp
 473:	89 7d fc             	mov    %edi,-0x4(%rbp)
 476:	89 f0                	mov    %esi,%eax
 478:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 47b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 47f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 482:	ba 01 00 00 00       	mov    $0x1,%edx
 487:	48 89 ce             	mov    %rcx,%rsi
 48a:	89 c7                	mov    %eax,%edi
 48c:	e8 36 ff ff ff       	call   3c7 <write>
}
 491:	90                   	nop
 492:	c9                   	leave
 493:	c3                   	ret

0000000000000494 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 494:	f3 0f 1e fa          	endbr64
 498:	55                   	push   %rbp
 499:	48 89 e5             	mov    %rsp,%rbp
 49c:	48 83 ec 30          	sub    $0x30,%rsp
 4a0:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4a3:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4a6:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4a9:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4b3:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4b7:	74 17                	je     4d0 <printint+0x3c>
 4b9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4bd:	79 11                	jns    4d0 <printint+0x3c>
    neg = 1;
 4bf:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4c6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c9:	f7 d8                	neg    %eax
 4cb:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ce:	eb 06                	jmp    4d6 <printint+0x42>
  } else {
    x = xx;
 4d0:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4d3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4dd:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4e3:	ba 00 00 00 00       	mov    $0x0,%edx
 4e8:	f7 f6                	div    %esi
 4ea:	89 d1                	mov    %edx,%ecx
 4ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ef:	8d 50 01             	lea    0x1(%rax),%edx
 4f2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4f5:	89 ca                	mov    %ecx,%edx
 4f7:	0f b6 92 e0 0d 00 00 	movzbl 0xde0(%rdx),%edx
 4fe:	48 98                	cltq
 500:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 504:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 507:	8b 45 f4             	mov    -0xc(%rbp),%eax
 50a:	ba 00 00 00 00       	mov    $0x0,%edx
 50f:	f7 f7                	div    %edi
 511:	89 45 f4             	mov    %eax,-0xc(%rbp)
 514:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 518:	75 c3                	jne    4dd <printint+0x49>
  if(neg)
 51a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 51e:	74 2b                	je     54b <printint+0xb7>
    buf[i++] = '-';
 520:	8b 45 fc             	mov    -0x4(%rbp),%eax
 523:	8d 50 01             	lea    0x1(%rax),%edx
 526:	89 55 fc             	mov    %edx,-0x4(%rbp)
 529:	48 98                	cltq
 52b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 530:	eb 19                	jmp    54b <printint+0xb7>
    putc(fd, buf[i]);
 532:	8b 45 fc             	mov    -0x4(%rbp),%eax
 535:	48 98                	cltq
 537:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 53c:	0f be d0             	movsbl %al,%edx
 53f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 542:	89 d6                	mov    %edx,%esi
 544:	89 c7                	mov    %eax,%edi
 546:	e8 1c ff ff ff       	call   467 <putc>
  while(--i >= 0)
 54b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 54f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 553:	79 dd                	jns    532 <printint+0x9e>
}
 555:	90                   	nop
 556:	90                   	nop
 557:	c9                   	leave
 558:	c3                   	ret

0000000000000559 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 559:	f3 0f 1e fa          	endbr64
 55d:	55                   	push   %rbp
 55e:	48 89 e5             	mov    %rsp,%rbp
 561:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 568:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 56e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 575:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 57c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 583:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 58a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 591:	84 c0                	test   %al,%al
 593:	74 20                	je     5b5 <printf+0x5c>
 595:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 599:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 59d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5a1:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5a5:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5a9:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5ad:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5b1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5b5:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5bc:	00 00 00 
 5bf:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5c6:	00 00 00 
 5c9:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5cd:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5d4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5db:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5e2:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5e9:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5ec:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5f3:	00 00 00 
 5f6:	e9 a8 02 00 00       	jmp    8a3 <printf+0x34a>
    c = fmt[i] & 0xff;
 5fb:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 601:	48 63 d0             	movslq %eax,%rdx
 604:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 60b:	48 01 d0             	add    %rdx,%rax
 60e:	0f b6 00             	movzbl (%rax),%eax
 611:	0f be c0             	movsbl %al,%eax
 614:	25 ff 00 00 00       	and    $0xff,%eax
 619:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 61f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 626:	75 35                	jne    65d <printf+0x104>
      if(c == '%'){
 628:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 62f:	75 0f                	jne    640 <printf+0xe7>
        state = '%';
 631:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 638:	00 00 00 
 63b:	e9 5c 02 00 00       	jmp    89c <printf+0x343>
      } else {
        putc(fd, c);
 640:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 646:	0f be d0             	movsbl %al,%edx
 649:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 64f:	89 d6                	mov    %edx,%esi
 651:	89 c7                	mov    %eax,%edi
 653:	e8 0f fe ff ff       	call   467 <putc>
 658:	e9 3f 02 00 00       	jmp    89c <printf+0x343>
      }
    } else if(state == '%'){
 65d:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 664:	0f 85 32 02 00 00    	jne    89c <printf+0x343>
      if(c == 'd'){
 66a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 671:	75 5e                	jne    6d1 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 673:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 679:	83 f8 2f             	cmp    $0x2f,%eax
 67c:	77 23                	ja     6a1 <printf+0x148>
 67e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 685:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68b:	89 d2                	mov    %edx,%edx
 68d:	48 01 d0             	add    %rdx,%rax
 690:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 696:	83 c2 08             	add    $0x8,%edx
 699:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 69f:	eb 12                	jmp    6b3 <printf+0x15a>
 6a1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6a8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6ac:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6b3:	8b 30                	mov    (%rax),%esi
 6b5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6bb:	b9 01 00 00 00       	mov    $0x1,%ecx
 6c0:	ba 0a 00 00 00       	mov    $0xa,%edx
 6c5:	89 c7                	mov    %eax,%edi
 6c7:	e8 c8 fd ff ff       	call   494 <printint>
 6cc:	e9 c1 01 00 00       	jmp    892 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6d1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6d8:	74 09                	je     6e3 <printf+0x18a>
 6da:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6e1:	75 5e                	jne    741 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6e3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e9:	83 f8 2f             	cmp    $0x2f,%eax
 6ec:	77 23                	ja     711 <printf+0x1b8>
 6ee:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fb:	89 d2                	mov    %edx,%edx
 6fd:	48 01 d0             	add    %rdx,%rax
 700:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 706:	83 c2 08             	add    $0x8,%edx
 709:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 70f:	eb 12                	jmp    723 <printf+0x1ca>
 711:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 718:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 723:	8b 30                	mov    (%rax),%esi
 725:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 72b:	b9 00 00 00 00       	mov    $0x0,%ecx
 730:	ba 10 00 00 00       	mov    $0x10,%edx
 735:	89 c7                	mov    %eax,%edi
 737:	e8 58 fd ff ff       	call   494 <printint>
 73c:	e9 51 01 00 00       	jmp    892 <printf+0x339>
      } else if(c == 's'){
 741:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 748:	0f 85 98 00 00 00    	jne    7e6 <printf+0x28d>
        s = va_arg(ap, char*);
 74e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 754:	83 f8 2f             	cmp    $0x2f,%eax
 757:	77 23                	ja     77c <printf+0x223>
 759:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 760:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 766:	89 d2                	mov    %edx,%edx
 768:	48 01 d0             	add    %rdx,%rax
 76b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 771:	83 c2 08             	add    $0x8,%edx
 774:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77a:	eb 12                	jmp    78e <printf+0x235>
 77c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 783:	48 8d 50 08          	lea    0x8(%rax),%rdx
 787:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 78e:	48 8b 00             	mov    (%rax),%rax
 791:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 798:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 79f:	00 
 7a0:	75 31                	jne    7d3 <printf+0x27a>
          s = "(null)";
 7a2:	48 c7 85 48 ff ff ff 	movq   $0xb95,-0xb8(%rbp)
 7a9:	95 0b 00 00 
        while(*s != 0){
 7ad:	eb 24                	jmp    7d3 <printf+0x27a>
          putc(fd, *s);
 7af:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7b6:	0f b6 00             	movzbl (%rax),%eax
 7b9:	0f be d0             	movsbl %al,%edx
 7bc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7c2:	89 d6                	mov    %edx,%esi
 7c4:	89 c7                	mov    %eax,%edi
 7c6:	e8 9c fc ff ff       	call   467 <putc>
          s++;
 7cb:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7d2:	01 
        while(*s != 0){
 7d3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7da:	0f b6 00             	movzbl (%rax),%eax
 7dd:	84 c0                	test   %al,%al
 7df:	75 ce                	jne    7af <printf+0x256>
 7e1:	e9 ac 00 00 00       	jmp    892 <printf+0x339>
        }
      } else if(c == 'c'){
 7e6:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7ed:	75 56                	jne    845 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7ef:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7f5:	83 f8 2f             	cmp    $0x2f,%eax
 7f8:	77 23                	ja     81d <printf+0x2c4>
 7fa:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 801:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 807:	89 d2                	mov    %edx,%edx
 809:	48 01 d0             	add    %rdx,%rax
 80c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 812:	83 c2 08             	add    $0x8,%edx
 815:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 81b:	eb 12                	jmp    82f <printf+0x2d6>
 81d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 824:	48 8d 50 08          	lea    0x8(%rax),%rdx
 828:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 82f:	8b 00                	mov    (%rax),%eax
 831:	0f be d0             	movsbl %al,%edx
 834:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 83a:	89 d6                	mov    %edx,%esi
 83c:	89 c7                	mov    %eax,%edi
 83e:	e8 24 fc ff ff       	call   467 <putc>
 843:	eb 4d                	jmp    892 <printf+0x339>
      } else if(c == '%'){
 845:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 84c:	75 1a                	jne    868 <printf+0x30f>
        putc(fd, c);
 84e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 854:	0f be d0             	movsbl %al,%edx
 857:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85d:	89 d6                	mov    %edx,%esi
 85f:	89 c7                	mov    %eax,%edi
 861:	e8 01 fc ff ff       	call   467 <putc>
 866:	eb 2a                	jmp    892 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 868:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 86e:	be 25 00 00 00       	mov    $0x25,%esi
 873:	89 c7                	mov    %eax,%edi
 875:	e8 ed fb ff ff       	call   467 <putc>
        putc(fd, c);
 87a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 880:	0f be d0             	movsbl %al,%edx
 883:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 889:	89 d6                	mov    %edx,%esi
 88b:	89 c7                	mov    %eax,%edi
 88d:	e8 d5 fb ff ff       	call   467 <putc>
      }
      state = 0;
 892:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 899:	00 00 00 
  for(i = 0; fmt[i]; i++){
 89c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8a3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8a9:	48 63 d0             	movslq %eax,%rdx
 8ac:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8b3:	48 01 d0             	add    %rdx,%rax
 8b6:	0f b6 00             	movzbl (%rax),%eax
 8b9:	84 c0                	test   %al,%al
 8bb:	0f 85 3a fd ff ff    	jne    5fb <printf+0xa2>
    }
  }
}
 8c1:	90                   	nop
 8c2:	90                   	nop
 8c3:	c9                   	leave
 8c4:	c3                   	ret

00000000000008c5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c5:	f3 0f 1e fa          	endbr64
 8c9:	55                   	push   %rbp
 8ca:	48 89 e5             	mov    %rsp,%rbp
 8cd:	48 83 ec 18          	sub    $0x18,%rsp
 8d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8d9:	48 83 e8 10          	sub    $0x10,%rax
 8dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e1:	48 8b 05 28 05 00 00 	mov    0x528(%rip),%rax        # e10 <freep>
 8e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8ec:	eb 2f                	jmp    91d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f2:	48 8b 00             	mov    (%rax),%rax
 8f5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f9:	72 17                	jb     912 <free+0x4d>
 8fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ff:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 903:	72 2f                	jb     934 <free+0x6f>
 905:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 909:	48 8b 00             	mov    (%rax),%rax
 90c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 910:	72 22                	jb     934 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 916:	48 8b 00             	mov    (%rax),%rax
 919:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 91d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 921:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 925:	73 c7                	jae    8ee <free+0x29>
 927:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92b:	48 8b 00             	mov    (%rax),%rax
 92e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 932:	73 ba                	jae    8ee <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 934:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 938:	8b 40 08             	mov    0x8(%rax),%eax
 93b:	89 c0                	mov    %eax,%eax
 93d:	48 c1 e0 04          	shl    $0x4,%rax
 941:	48 89 c2             	mov    %rax,%rdx
 944:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 948:	48 01 c2             	add    %rax,%rdx
 94b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94f:	48 8b 00             	mov    (%rax),%rax
 952:	48 39 c2             	cmp    %rax,%rdx
 955:	75 2d                	jne    984 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 957:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95b:	8b 50 08             	mov    0x8(%rax),%edx
 95e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 962:	48 8b 00             	mov    (%rax),%rax
 965:	8b 40 08             	mov    0x8(%rax),%eax
 968:	01 c2                	add    %eax,%edx
 96a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 971:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 975:	48 8b 00             	mov    (%rax),%rax
 978:	48 8b 10             	mov    (%rax),%rdx
 97b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97f:	48 89 10             	mov    %rdx,(%rax)
 982:	eb 0e                	jmp    992 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 988:	48 8b 10             	mov    (%rax),%rdx
 98b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 98f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 992:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 996:	8b 40 08             	mov    0x8(%rax),%eax
 999:	89 c0                	mov    %eax,%eax
 99b:	48 c1 e0 04          	shl    $0x4,%rax
 99f:	48 89 c2             	mov    %rax,%rdx
 9a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a6:	48 01 d0             	add    %rdx,%rax
 9a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9ad:	75 27                	jne    9d6 <free+0x111>
    p->s.size += bp->s.size;
 9af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b3:	8b 50 08             	mov    0x8(%rax),%edx
 9b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ba:	8b 40 08             	mov    0x8(%rax),%eax
 9bd:	01 c2                	add    %eax,%edx
 9bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ca:	48 8b 10             	mov    (%rax),%rdx
 9cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d1:	48 89 10             	mov    %rdx,(%rax)
 9d4:	eb 0b                	jmp    9e1 <free+0x11c>
  } else
    p->s.ptr = bp;
 9d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9da:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9de:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e5:	48 89 05 24 04 00 00 	mov    %rax,0x424(%rip)        # e10 <freep>
}
 9ec:	90                   	nop
 9ed:	c9                   	leave
 9ee:	c3                   	ret

00000000000009ef <morecore>:

static Header*
morecore(uint nu)
{
 9ef:	f3 0f 1e fa          	endbr64
 9f3:	55                   	push   %rbp
 9f4:	48 89 e5             	mov    %rsp,%rbp
 9f7:	48 83 ec 20          	sub    $0x20,%rsp
 9fb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9fe:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a05:	77 07                	ja     a0e <morecore+0x1f>
    nu = 4096;
 a07:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a11:	c1 e0 04             	shl    $0x4,%eax
 a14:	89 c7                	mov    %eax,%edi
 a16:	e8 14 fa ff ff       	call   42f <sbrk>
 a1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a1f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a24:	75 07                	jne    a2d <morecore+0x3e>
    return 0;
 a26:	b8 00 00 00 00       	mov    $0x0,%eax
 a2b:	eb 29                	jmp    a56 <morecore+0x67>
  hp = (Header*)p;
 a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a39:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a3c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a43:	48 83 c0 10          	add    $0x10,%rax
 a47:	48 89 c7             	mov    %rax,%rdi
 a4a:	e8 76 fe ff ff       	call   8c5 <free>
  return freep;
 a4f:	48 8b 05 ba 03 00 00 	mov    0x3ba(%rip),%rax        # e10 <freep>
}
 a56:	c9                   	leave
 a57:	c3                   	ret

0000000000000a58 <malloc>:

void*
malloc(uint nbytes)
{
 a58:	f3 0f 1e fa          	endbr64
 a5c:	55                   	push   %rbp
 a5d:	48 89 e5             	mov    %rsp,%rbp
 a60:	48 83 ec 30          	sub    $0x30,%rsp
 a64:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a67:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a6a:	48 83 c0 0f          	add    $0xf,%rax
 a6e:	48 c1 e8 04          	shr    $0x4,%rax
 a72:	83 c0 01             	add    $0x1,%eax
 a75:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a78:	48 8b 05 91 03 00 00 	mov    0x391(%rip),%rax        # e10 <freep>
 a7f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a83:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a88:	75 2b                	jne    ab5 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a8a:	48 c7 45 f0 00 0e 00 	movq   $0xe00,-0x10(%rbp)
 a91:	00 
 a92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a96:	48 89 05 73 03 00 00 	mov    %rax,0x373(%rip)        # e10 <freep>
 a9d:	48 8b 05 6c 03 00 00 	mov    0x36c(%rip),%rax        # e10 <freep>
 aa4:	48 89 05 55 03 00 00 	mov    %rax,0x355(%rip)        # e00 <base>
    base.s.size = 0;
 aab:	c7 05 53 03 00 00 00 	movl   $0x0,0x353(%rip)        # e08 <base+0x8>
 ab2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab9:	48 8b 00             	mov    (%rax),%rax
 abc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ac0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac4:	8b 40 08             	mov    0x8(%rax),%eax
 ac7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aca:	72 5f                	jb     b2b <malloc+0xd3>
      if(p->s.size == nunits)
 acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad0:	8b 40 08             	mov    0x8(%rax),%eax
 ad3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ad6:	75 10                	jne    ae8 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ad8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adc:	48 8b 10             	mov    (%rax),%rdx
 adf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae3:	48 89 10             	mov    %rdx,(%rax)
 ae6:	eb 2e                	jmp    b16 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ae8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aec:	8b 40 08             	mov    0x8(%rax),%eax
 aef:	2b 45 ec             	sub    -0x14(%rbp),%eax
 af2:	89 c2                	mov    %eax,%edx
 af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af8:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aff:	8b 40 08             	mov    0x8(%rax),%eax
 b02:	89 c0                	mov    %eax,%eax
 b04:	48 c1 e0 04          	shl    $0x4,%rax
 b08:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b10:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b13:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1a:	48 89 05 ef 02 00 00 	mov    %rax,0x2ef(%rip)        # e10 <freep>
      return (void*)(p + 1);
 b21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b25:	48 83 c0 10          	add    $0x10,%rax
 b29:	eb 41                	jmp    b6c <malloc+0x114>
    }
    if(p == freep)
 b2b:	48 8b 05 de 02 00 00 	mov    0x2de(%rip),%rax        # e10 <freep>
 b32:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b36:	75 1c                	jne    b54 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b38:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b3b:	89 c7                	mov    %eax,%edi
 b3d:	e8 ad fe ff ff       	call   9ef <morecore>
 b42:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b46:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b4b:	75 07                	jne    b54 <malloc+0xfc>
        return 0;
 b4d:	b8 00 00 00 00       	mov    $0x0,%eax
 b52:	eb 18                	jmp    b6c <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b58:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b60:	48 8b 00             	mov    (%rax),%rax
 b63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b67:	e9 54 ff ff ff       	jmp    ac0 <malloc+0x68>
  }
}
 b6c:	c9                   	leave
 b6d:	c3                   	ret
