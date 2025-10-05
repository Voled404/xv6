
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
  19:	48 c7 c6 5e 0b 00 00 	mov    $0xb5e,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 1a 05 00 00       	call   549 <printf>
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
  75:	48 c7 c6 71 0b 00 00 	mov    $0xb71,%rsi
  7c:	bf 02 00 00 00       	mov    $0x2,%edi
  81:	b8 00 00 00 00       	mov    $0x0,%eax
  86:	e8 be 04 00 00       	call   549 <printf>
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

0000000000000457 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 457:	f3 0f 1e fa          	endbr64
 45b:	55                   	push   %rbp
 45c:	48 89 e5             	mov    %rsp,%rbp
 45f:	48 83 ec 10          	sub    $0x10,%rsp
 463:	89 7d fc             	mov    %edi,-0x4(%rbp)
 466:	89 f0                	mov    %esi,%eax
 468:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 46b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 46f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 472:	ba 01 00 00 00       	mov    $0x1,%edx
 477:	48 89 ce             	mov    %rcx,%rsi
 47a:	89 c7                	mov    %eax,%edi
 47c:	e8 46 ff ff ff       	call   3c7 <write>
}
 481:	90                   	nop
 482:	c9                   	leave
 483:	c3                   	ret

0000000000000484 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 484:	f3 0f 1e fa          	endbr64
 488:	55                   	push   %rbp
 489:	48 89 e5             	mov    %rsp,%rbp
 48c:	48 83 ec 30          	sub    $0x30,%rsp
 490:	89 7d dc             	mov    %edi,-0x24(%rbp)
 493:	89 75 d8             	mov    %esi,-0x28(%rbp)
 496:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 499:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 49c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4a3:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4a7:	74 17                	je     4c0 <printint+0x3c>
 4a9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4ad:	79 11                	jns    4c0 <printint+0x3c>
    neg = 1;
 4af:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4b6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b9:	f7 d8                	neg    %eax
 4bb:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4be:	eb 06                	jmp    4c6 <printint+0x42>
  } else {
    x = xx;
 4c0:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4cd:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4d3:	ba 00 00 00 00       	mov    $0x0,%edx
 4d8:	f7 f6                	div    %esi
 4da:	89 d1                	mov    %edx,%ecx
 4dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4df:	8d 50 01             	lea    0x1(%rax),%edx
 4e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e5:	89 ca                	mov    %ecx,%edx
 4e7:	0f b6 92 d0 0d 00 00 	movzbl 0xdd0(%rdx),%edx
 4ee:	48 98                	cltq
 4f0:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4f4:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4f7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4fa:	ba 00 00 00 00       	mov    $0x0,%edx
 4ff:	f7 f7                	div    %edi
 501:	89 45 f4             	mov    %eax,-0xc(%rbp)
 504:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 508:	75 c3                	jne    4cd <printint+0x49>
  if(neg)
 50a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 50e:	74 2b                	je     53b <printint+0xb7>
    buf[i++] = '-';
 510:	8b 45 fc             	mov    -0x4(%rbp),%eax
 513:	8d 50 01             	lea    0x1(%rax),%edx
 516:	89 55 fc             	mov    %edx,-0x4(%rbp)
 519:	48 98                	cltq
 51b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 520:	eb 19                	jmp    53b <printint+0xb7>
    putc(fd, buf[i]);
 522:	8b 45 fc             	mov    -0x4(%rbp),%eax
 525:	48 98                	cltq
 527:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 52c:	0f be d0             	movsbl %al,%edx
 52f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 532:	89 d6                	mov    %edx,%esi
 534:	89 c7                	mov    %eax,%edi
 536:	e8 1c ff ff ff       	call   457 <putc>
  while(--i >= 0)
 53b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 53f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 543:	79 dd                	jns    522 <printint+0x9e>
}
 545:	90                   	nop
 546:	90                   	nop
 547:	c9                   	leave
 548:	c3                   	ret

0000000000000549 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 549:	f3 0f 1e fa          	endbr64
 54d:	55                   	push   %rbp
 54e:	48 89 e5             	mov    %rsp,%rbp
 551:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 558:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 55e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 565:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 56c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 573:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 57a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 581:	84 c0                	test   %al,%al
 583:	74 20                	je     5a5 <printf+0x5c>
 585:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 589:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 58d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 591:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 595:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 599:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 59d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5a5:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5ac:	00 00 00 
 5af:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5b6:	00 00 00 
 5b9:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5bd:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5c4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5cb:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5d2:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5d9:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5dc:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5e3:	00 00 00 
 5e6:	e9 a8 02 00 00       	jmp    893 <printf+0x34a>
    c = fmt[i] & 0xff;
 5eb:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f1:	48 63 d0             	movslq %eax,%rdx
 5f4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5fb:	48 01 d0             	add    %rdx,%rax
 5fe:	0f b6 00             	movzbl (%rax),%eax
 601:	0f be c0             	movsbl %al,%eax
 604:	25 ff 00 00 00       	and    $0xff,%eax
 609:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 60f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 616:	75 35                	jne    64d <printf+0x104>
      if(c == '%'){
 618:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 61f:	75 0f                	jne    630 <printf+0xe7>
        state = '%';
 621:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 628:	00 00 00 
 62b:	e9 5c 02 00 00       	jmp    88c <printf+0x343>
      } else {
        putc(fd, c);
 630:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 636:	0f be d0             	movsbl %al,%edx
 639:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 63f:	89 d6                	mov    %edx,%esi
 641:	89 c7                	mov    %eax,%edi
 643:	e8 0f fe ff ff       	call   457 <putc>
 648:	e9 3f 02 00 00       	jmp    88c <printf+0x343>
      }
    } else if(state == '%'){
 64d:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 654:	0f 85 32 02 00 00    	jne    88c <printf+0x343>
      if(c == 'd'){
 65a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 661:	75 5e                	jne    6c1 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 663:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 669:	83 f8 2f             	cmp    $0x2f,%eax
 66c:	77 23                	ja     691 <printf+0x148>
 66e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 675:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67b:	89 d2                	mov    %edx,%edx
 67d:	48 01 d0             	add    %rdx,%rax
 680:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 686:	83 c2 08             	add    $0x8,%edx
 689:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 68f:	eb 12                	jmp    6a3 <printf+0x15a>
 691:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 698:	48 8d 50 08          	lea    0x8(%rax),%rdx
 69c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6a3:	8b 30                	mov    (%rax),%esi
 6a5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ab:	b9 01 00 00 00       	mov    $0x1,%ecx
 6b0:	ba 0a 00 00 00       	mov    $0xa,%edx
 6b5:	89 c7                	mov    %eax,%edi
 6b7:	e8 c8 fd ff ff       	call   484 <printint>
 6bc:	e9 c1 01 00 00       	jmp    882 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6c8:	74 09                	je     6d3 <printf+0x18a>
 6ca:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d1:	75 5e                	jne    731 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6d3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d9:	83 f8 2f             	cmp    $0x2f,%eax
 6dc:	77 23                	ja     701 <printf+0x1b8>
 6de:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6eb:	89 d2                	mov    %edx,%edx
 6ed:	48 01 d0             	add    %rdx,%rax
 6f0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f6:	83 c2 08             	add    $0x8,%edx
 6f9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6ff:	eb 12                	jmp    713 <printf+0x1ca>
 701:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 708:	48 8d 50 08          	lea    0x8(%rax),%rdx
 70c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 713:	8b 30                	mov    (%rax),%esi
 715:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 71b:	b9 00 00 00 00       	mov    $0x0,%ecx
 720:	ba 10 00 00 00       	mov    $0x10,%edx
 725:	89 c7                	mov    %eax,%edi
 727:	e8 58 fd ff ff       	call   484 <printint>
 72c:	e9 51 01 00 00       	jmp    882 <printf+0x339>
      } else if(c == 's'){
 731:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 738:	0f 85 98 00 00 00    	jne    7d6 <printf+0x28d>
        s = va_arg(ap, char*);
 73e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 744:	83 f8 2f             	cmp    $0x2f,%eax
 747:	77 23                	ja     76c <printf+0x223>
 749:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 750:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 756:	89 d2                	mov    %edx,%edx
 758:	48 01 d0             	add    %rdx,%rax
 75b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 761:	83 c2 08             	add    $0x8,%edx
 764:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 76a:	eb 12                	jmp    77e <printf+0x235>
 76c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 773:	48 8d 50 08          	lea    0x8(%rax),%rdx
 777:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 77e:	48 8b 00             	mov    (%rax),%rax
 781:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 788:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 78f:	00 
 790:	75 31                	jne    7c3 <printf+0x27a>
          s = "(null)";
 792:	48 c7 85 48 ff ff ff 	movq   $0xb85,-0xb8(%rbp)
 799:	85 0b 00 00 
        while(*s != 0){
 79d:	eb 24                	jmp    7c3 <printf+0x27a>
          putc(fd, *s);
 79f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7a6:	0f b6 00             	movzbl (%rax),%eax
 7a9:	0f be d0             	movsbl %al,%edx
 7ac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b2:	89 d6                	mov    %edx,%esi
 7b4:	89 c7                	mov    %eax,%edi
 7b6:	e8 9c fc ff ff       	call   457 <putc>
          s++;
 7bb:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7c2:	01 
        while(*s != 0){
 7c3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ca:	0f b6 00             	movzbl (%rax),%eax
 7cd:	84 c0                	test   %al,%al
 7cf:	75 ce                	jne    79f <printf+0x256>
 7d1:	e9 ac 00 00 00       	jmp    882 <printf+0x339>
        }
      } else if(c == 'c'){
 7d6:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7dd:	75 56                	jne    835 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7df:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7e5:	83 f8 2f             	cmp    $0x2f,%eax
 7e8:	77 23                	ja     80d <printf+0x2c4>
 7ea:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f7:	89 d2                	mov    %edx,%edx
 7f9:	48 01 d0             	add    %rdx,%rax
 7fc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 802:	83 c2 08             	add    $0x8,%edx
 805:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 80b:	eb 12                	jmp    81f <printf+0x2d6>
 80d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 814:	48 8d 50 08          	lea    0x8(%rax),%rdx
 818:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 81f:	8b 00                	mov    (%rax),%eax
 821:	0f be d0             	movsbl %al,%edx
 824:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 82a:	89 d6                	mov    %edx,%esi
 82c:	89 c7                	mov    %eax,%edi
 82e:	e8 24 fc ff ff       	call   457 <putc>
 833:	eb 4d                	jmp    882 <printf+0x339>
      } else if(c == '%'){
 835:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 83c:	75 1a                	jne    858 <printf+0x30f>
        putc(fd, c);
 83e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 844:	0f be d0             	movsbl %al,%edx
 847:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 84d:	89 d6                	mov    %edx,%esi
 84f:	89 c7                	mov    %eax,%edi
 851:	e8 01 fc ff ff       	call   457 <putc>
 856:	eb 2a                	jmp    882 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 858:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85e:	be 25 00 00 00       	mov    $0x25,%esi
 863:	89 c7                	mov    %eax,%edi
 865:	e8 ed fb ff ff       	call   457 <putc>
        putc(fd, c);
 86a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 870:	0f be d0             	movsbl %al,%edx
 873:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 879:	89 d6                	mov    %edx,%esi
 87b:	89 c7                	mov    %eax,%edi
 87d:	e8 d5 fb ff ff       	call   457 <putc>
      }
      state = 0;
 882:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 889:	00 00 00 
  for(i = 0; fmt[i]; i++){
 88c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 893:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 899:	48 63 d0             	movslq %eax,%rdx
 89c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8a3:	48 01 d0             	add    %rdx,%rax
 8a6:	0f b6 00             	movzbl (%rax),%eax
 8a9:	84 c0                	test   %al,%al
 8ab:	0f 85 3a fd ff ff    	jne    5eb <printf+0xa2>
    }
  }
}
 8b1:	90                   	nop
 8b2:	90                   	nop
 8b3:	c9                   	leave
 8b4:	c3                   	ret

00000000000008b5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b5:	f3 0f 1e fa          	endbr64
 8b9:	55                   	push   %rbp
 8ba:	48 89 e5             	mov    %rsp,%rbp
 8bd:	48 83 ec 18          	sub    $0x18,%rsp
 8c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8c9:	48 83 e8 10          	sub    $0x10,%rax
 8cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d1:	48 8b 05 28 05 00 00 	mov    0x528(%rip),%rax        # e00 <freep>
 8d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8dc:	eb 2f                	jmp    90d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e2:	48 8b 00             	mov    (%rax),%rax
 8e5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e9:	72 17                	jb     902 <free+0x4d>
 8eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ef:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f3:	72 2f                	jb     924 <free+0x6f>
 8f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f9:	48 8b 00             	mov    (%rax),%rax
 8fc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 900:	72 22                	jb     924 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 906:	48 8b 00             	mov    (%rax),%rax
 909:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 90d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 911:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 915:	73 c7                	jae    8de <free+0x29>
 917:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91b:	48 8b 00             	mov    (%rax),%rax
 91e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 922:	73 ba                	jae    8de <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 924:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 928:	8b 40 08             	mov    0x8(%rax),%eax
 92b:	89 c0                	mov    %eax,%eax
 92d:	48 c1 e0 04          	shl    $0x4,%rax
 931:	48 89 c2             	mov    %rax,%rdx
 934:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 938:	48 01 c2             	add    %rax,%rdx
 93b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93f:	48 8b 00             	mov    (%rax),%rax
 942:	48 39 c2             	cmp    %rax,%rdx
 945:	75 2d                	jne    974 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 947:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94b:	8b 50 08             	mov    0x8(%rax),%edx
 94e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 952:	48 8b 00             	mov    (%rax),%rax
 955:	8b 40 08             	mov    0x8(%rax),%eax
 958:	01 c2                	add    %eax,%edx
 95a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 965:	48 8b 00             	mov    (%rax),%rax
 968:	48 8b 10             	mov    (%rax),%rdx
 96b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96f:	48 89 10             	mov    %rdx,(%rax)
 972:	eb 0e                	jmp    982 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 974:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 978:	48 8b 10             	mov    (%rax),%rdx
 97b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 986:	8b 40 08             	mov    0x8(%rax),%eax
 989:	89 c0                	mov    %eax,%eax
 98b:	48 c1 e0 04          	shl    $0x4,%rax
 98f:	48 89 c2             	mov    %rax,%rdx
 992:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 996:	48 01 d0             	add    %rdx,%rax
 999:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 99d:	75 27                	jne    9c6 <free+0x111>
    p->s.size += bp->s.size;
 99f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a3:	8b 50 08             	mov    0x8(%rax),%edx
 9a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9aa:	8b 40 08             	mov    0x8(%rax),%eax
 9ad:	01 c2                	add    %eax,%edx
 9af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ba:	48 8b 10             	mov    (%rax),%rdx
 9bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c1:	48 89 10             	mov    %rdx,(%rax)
 9c4:	eb 0b                	jmp    9d1 <free+0x11c>
  } else
    p->s.ptr = bp;
 9c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9ce:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d5:	48 89 05 24 04 00 00 	mov    %rax,0x424(%rip)        # e00 <freep>
}
 9dc:	90                   	nop
 9dd:	c9                   	leave
 9de:	c3                   	ret

00000000000009df <morecore>:

static Header*
morecore(uint nu)
{
 9df:	f3 0f 1e fa          	endbr64
 9e3:	55                   	push   %rbp
 9e4:	48 89 e5             	mov    %rsp,%rbp
 9e7:	48 83 ec 20          	sub    $0x20,%rsp
 9eb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9ee:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9f5:	77 07                	ja     9fe <morecore+0x1f>
    nu = 4096;
 9f7:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9fe:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a01:	c1 e0 04             	shl    $0x4,%eax
 a04:	89 c7                	mov    %eax,%edi
 a06:	e8 24 fa ff ff       	call   42f <sbrk>
 a0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a0f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a14:	75 07                	jne    a1d <morecore+0x3e>
    return 0;
 a16:	b8 00 00 00 00       	mov    $0x0,%eax
 a1b:	eb 29                	jmp    a46 <morecore+0x67>
  hp = (Header*)p;
 a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a29:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a2c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a33:	48 83 c0 10          	add    $0x10,%rax
 a37:	48 89 c7             	mov    %rax,%rdi
 a3a:	e8 76 fe ff ff       	call   8b5 <free>
  return freep;
 a3f:	48 8b 05 ba 03 00 00 	mov    0x3ba(%rip),%rax        # e00 <freep>
}
 a46:	c9                   	leave
 a47:	c3                   	ret

0000000000000a48 <malloc>:

void*
malloc(uint nbytes)
{
 a48:	f3 0f 1e fa          	endbr64
 a4c:	55                   	push   %rbp
 a4d:	48 89 e5             	mov    %rsp,%rbp
 a50:	48 83 ec 30          	sub    $0x30,%rsp
 a54:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a57:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a5a:	48 83 c0 0f          	add    $0xf,%rax
 a5e:	48 c1 e8 04          	shr    $0x4,%rax
 a62:	83 c0 01             	add    $0x1,%eax
 a65:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a68:	48 8b 05 91 03 00 00 	mov    0x391(%rip),%rax        # e00 <freep>
 a6f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a73:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a78:	75 2b                	jne    aa5 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a7a:	48 c7 45 f0 f0 0d 00 	movq   $0xdf0,-0x10(%rbp)
 a81:	00 
 a82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a86:	48 89 05 73 03 00 00 	mov    %rax,0x373(%rip)        # e00 <freep>
 a8d:	48 8b 05 6c 03 00 00 	mov    0x36c(%rip),%rax        # e00 <freep>
 a94:	48 89 05 55 03 00 00 	mov    %rax,0x355(%rip)        # df0 <base>
    base.s.size = 0;
 a9b:	c7 05 53 03 00 00 00 	movl   $0x0,0x353(%rip)        # df8 <base+0x8>
 aa2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa9:	48 8b 00             	mov    (%rax),%rax
 aac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ab0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab4:	8b 40 08             	mov    0x8(%rax),%eax
 ab7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aba:	72 5f                	jb     b1b <malloc+0xd3>
      if(p->s.size == nunits)
 abc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac0:	8b 40 08             	mov    0x8(%rax),%eax
 ac3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ac6:	75 10                	jne    ad8 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ac8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acc:	48 8b 10             	mov    (%rax),%rdx
 acf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad3:	48 89 10             	mov    %rdx,(%rax)
 ad6:	eb 2e                	jmp    b06 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ad8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adc:	8b 40 08             	mov    0x8(%rax),%eax
 adf:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ae2:	89 c2                	mov    %eax,%edx
 ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae8:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aef:	8b 40 08             	mov    0x8(%rax),%eax
 af2:	89 c0                	mov    %eax,%eax
 af4:	48 c1 e0 04          	shl    $0x4,%rax
 af8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b03:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b0a:	48 89 05 ef 02 00 00 	mov    %rax,0x2ef(%rip)        # e00 <freep>
      return (void*)(p + 1);
 b11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b15:	48 83 c0 10          	add    $0x10,%rax
 b19:	eb 41                	jmp    b5c <malloc+0x114>
    }
    if(p == freep)
 b1b:	48 8b 05 de 02 00 00 	mov    0x2de(%rip),%rax        # e00 <freep>
 b22:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b26:	75 1c                	jne    b44 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b28:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b2b:	89 c7                	mov    %eax,%edi
 b2d:	e8 ad fe ff ff       	call   9df <morecore>
 b32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b36:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b3b:	75 07                	jne    b44 <malloc+0xfc>
        return 0;
 b3d:	b8 00 00 00 00       	mov    $0x0,%eax
 b42:	eb 18                	jmp    b5c <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b48:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	48 8b 00             	mov    (%rax),%rax
 b53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b57:	e9 54 ff ff ff       	jmp    ab0 <malloc+0x68>
  }
}
 b5c:	c9                   	leave
 b5d:	c3                   	ret
