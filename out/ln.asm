
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
  19:	48 c7 c6 7e 0b 00 00 	mov    $0xb7e,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 3a 05 00 00       	call   569 <printf>
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
  75:	48 c7 c6 91 0b 00 00 	mov    $0xb91,%rsi
  7c:	bf 02 00 00 00       	mov    $0x2,%edi
  81:	b8 00 00 00 00       	mov    $0x0,%eax
  86:	e8 de 04 00 00       	call   569 <printf>
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

0000000000000467 <getcount>:
SYSCALL(getcount)
 467:	b8 1e 00 00 00       	mov    $0x1e,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret

000000000000046f <killrandom>:
SYSCALL(killrandom)
 46f:	b8 1f 00 00 00       	mov    $0x1f,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret

0000000000000477 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 477:	f3 0f 1e fa          	endbr64
 47b:	55                   	push   %rbp
 47c:	48 89 e5             	mov    %rsp,%rbp
 47f:	48 83 ec 10          	sub    $0x10,%rsp
 483:	89 7d fc             	mov    %edi,-0x4(%rbp)
 486:	89 f0                	mov    %esi,%eax
 488:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 48b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 48f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 492:	ba 01 00 00 00       	mov    $0x1,%edx
 497:	48 89 ce             	mov    %rcx,%rsi
 49a:	89 c7                	mov    %eax,%edi
 49c:	e8 26 ff ff ff       	call   3c7 <write>
}
 4a1:	90                   	nop
 4a2:	c9                   	leave
 4a3:	c3                   	ret

00000000000004a4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a4:	f3 0f 1e fa          	endbr64
 4a8:	55                   	push   %rbp
 4a9:	48 89 e5             	mov    %rsp,%rbp
 4ac:	48 83 ec 30          	sub    $0x30,%rsp
 4b0:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4b3:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4b6:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4b9:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4bc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4c3:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4c7:	74 17                	je     4e0 <printint+0x3c>
 4c9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4cd:	79 11                	jns    4e0 <printint+0x3c>
    neg = 1;
 4cf:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4d6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4d9:	f7 d8                	neg    %eax
 4db:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4de:	eb 06                	jmp    4e6 <printint+0x42>
  } else {
    x = xx;
 4e0:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4e3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4ed:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4f3:	ba 00 00 00 00       	mov    $0x0,%edx
 4f8:	f7 f6                	div    %esi
 4fa:	89 d1                	mov    %edx,%ecx
 4fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ff:	8d 50 01             	lea    0x1(%rax),%edx
 502:	89 55 fc             	mov    %edx,-0x4(%rbp)
 505:	89 ca                	mov    %ecx,%edx
 507:	0f b6 92 f0 0d 00 00 	movzbl 0xdf0(%rdx),%edx
 50e:	48 98                	cltq
 510:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 514:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 517:	8b 45 f4             	mov    -0xc(%rbp),%eax
 51a:	ba 00 00 00 00       	mov    $0x0,%edx
 51f:	f7 f7                	div    %edi
 521:	89 45 f4             	mov    %eax,-0xc(%rbp)
 524:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 528:	75 c3                	jne    4ed <printint+0x49>
  if(neg)
 52a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 52e:	74 2b                	je     55b <printint+0xb7>
    buf[i++] = '-';
 530:	8b 45 fc             	mov    -0x4(%rbp),%eax
 533:	8d 50 01             	lea    0x1(%rax),%edx
 536:	89 55 fc             	mov    %edx,-0x4(%rbp)
 539:	48 98                	cltq
 53b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 540:	eb 19                	jmp    55b <printint+0xb7>
    putc(fd, buf[i]);
 542:	8b 45 fc             	mov    -0x4(%rbp),%eax
 545:	48 98                	cltq
 547:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 54c:	0f be d0             	movsbl %al,%edx
 54f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 552:	89 d6                	mov    %edx,%esi
 554:	89 c7                	mov    %eax,%edi
 556:	e8 1c ff ff ff       	call   477 <putc>
  while(--i >= 0)
 55b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 55f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 563:	79 dd                	jns    542 <printint+0x9e>
}
 565:	90                   	nop
 566:	90                   	nop
 567:	c9                   	leave
 568:	c3                   	ret

0000000000000569 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 569:	f3 0f 1e fa          	endbr64
 56d:	55                   	push   %rbp
 56e:	48 89 e5             	mov    %rsp,%rbp
 571:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 578:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 57e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 585:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 58c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 593:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 59a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5a1:	84 c0                	test   %al,%al
 5a3:	74 20                	je     5c5 <printf+0x5c>
 5a5:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5a9:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5ad:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5b1:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5b5:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5b9:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5bd:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5c1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5c5:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5cc:	00 00 00 
 5cf:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5d6:	00 00 00 
 5d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5dd:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5e4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5eb:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5f2:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5f9:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5fc:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 603:	00 00 00 
 606:	e9 a8 02 00 00       	jmp    8b3 <printf+0x34a>
    c = fmt[i] & 0xff;
 60b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 611:	48 63 d0             	movslq %eax,%rdx
 614:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 61b:	48 01 d0             	add    %rdx,%rax
 61e:	0f b6 00             	movzbl (%rax),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	25 ff 00 00 00       	and    $0xff,%eax
 629:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 62f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 636:	75 35                	jne    66d <printf+0x104>
      if(c == '%'){
 638:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 63f:	75 0f                	jne    650 <printf+0xe7>
        state = '%';
 641:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 648:	00 00 00 
 64b:	e9 5c 02 00 00       	jmp    8ac <printf+0x343>
      } else {
        putc(fd, c);
 650:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 656:	0f be d0             	movsbl %al,%edx
 659:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 65f:	89 d6                	mov    %edx,%esi
 661:	89 c7                	mov    %eax,%edi
 663:	e8 0f fe ff ff       	call   477 <putc>
 668:	e9 3f 02 00 00       	jmp    8ac <printf+0x343>
      }
    } else if(state == '%'){
 66d:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 674:	0f 85 32 02 00 00    	jne    8ac <printf+0x343>
      if(c == 'd'){
 67a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 681:	75 5e                	jne    6e1 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 683:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 689:	83 f8 2f             	cmp    $0x2f,%eax
 68c:	77 23                	ja     6b1 <printf+0x148>
 68e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 695:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69b:	89 d2                	mov    %edx,%edx
 69d:	48 01 d0             	add    %rdx,%rax
 6a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a6:	83 c2 08             	add    $0x8,%edx
 6a9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6af:	eb 12                	jmp    6c3 <printf+0x15a>
 6b1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6bc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6c3:	8b 30                	mov    (%rax),%esi
 6c5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6cb:	b9 01 00 00 00       	mov    $0x1,%ecx
 6d0:	ba 0a 00 00 00       	mov    $0xa,%edx
 6d5:	89 c7                	mov    %eax,%edi
 6d7:	e8 c8 fd ff ff       	call   4a4 <printint>
 6dc:	e9 c1 01 00 00       	jmp    8a2 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6e1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6e8:	74 09                	je     6f3 <printf+0x18a>
 6ea:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6f1:	75 5e                	jne    751 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6f3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f9:	83 f8 2f             	cmp    $0x2f,%eax
 6fc:	77 23                	ja     721 <printf+0x1b8>
 6fe:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 705:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70b:	89 d2                	mov    %edx,%edx
 70d:	48 01 d0             	add    %rdx,%rax
 710:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 716:	83 c2 08             	add    $0x8,%edx
 719:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 71f:	eb 12                	jmp    733 <printf+0x1ca>
 721:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 728:	48 8d 50 08          	lea    0x8(%rax),%rdx
 72c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 733:	8b 30                	mov    (%rax),%esi
 735:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 73b:	b9 00 00 00 00       	mov    $0x0,%ecx
 740:	ba 10 00 00 00       	mov    $0x10,%edx
 745:	89 c7                	mov    %eax,%edi
 747:	e8 58 fd ff ff       	call   4a4 <printint>
 74c:	e9 51 01 00 00       	jmp    8a2 <printf+0x339>
      } else if(c == 's'){
 751:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 758:	0f 85 98 00 00 00    	jne    7f6 <printf+0x28d>
        s = va_arg(ap, char*);
 75e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 764:	83 f8 2f             	cmp    $0x2f,%eax
 767:	77 23                	ja     78c <printf+0x223>
 769:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 770:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 776:	89 d2                	mov    %edx,%edx
 778:	48 01 d0             	add    %rdx,%rax
 77b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 781:	83 c2 08             	add    $0x8,%edx
 784:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 78a:	eb 12                	jmp    79e <printf+0x235>
 78c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 793:	48 8d 50 08          	lea    0x8(%rax),%rdx
 797:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 79e:	48 8b 00             	mov    (%rax),%rax
 7a1:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7a8:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7af:	00 
 7b0:	75 31                	jne    7e3 <printf+0x27a>
          s = "(null)";
 7b2:	48 c7 85 48 ff ff ff 	movq   $0xba5,-0xb8(%rbp)
 7b9:	a5 0b 00 00 
        while(*s != 0){
 7bd:	eb 24                	jmp    7e3 <printf+0x27a>
          putc(fd, *s);
 7bf:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7c6:	0f b6 00             	movzbl (%rax),%eax
 7c9:	0f be d0             	movsbl %al,%edx
 7cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d2:	89 d6                	mov    %edx,%esi
 7d4:	89 c7                	mov    %eax,%edi
 7d6:	e8 9c fc ff ff       	call   477 <putc>
          s++;
 7db:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7e2:	01 
        while(*s != 0){
 7e3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ea:	0f b6 00             	movzbl (%rax),%eax
 7ed:	84 c0                	test   %al,%al
 7ef:	75 ce                	jne    7bf <printf+0x256>
 7f1:	e9 ac 00 00 00       	jmp    8a2 <printf+0x339>
        }
      } else if(c == 'c'){
 7f6:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7fd:	75 56                	jne    855 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7ff:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 805:	83 f8 2f             	cmp    $0x2f,%eax
 808:	77 23                	ja     82d <printf+0x2c4>
 80a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 811:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 817:	89 d2                	mov    %edx,%edx
 819:	48 01 d0             	add    %rdx,%rax
 81c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 822:	83 c2 08             	add    $0x8,%edx
 825:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 82b:	eb 12                	jmp    83f <printf+0x2d6>
 82d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 834:	48 8d 50 08          	lea    0x8(%rax),%rdx
 838:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 83f:	8b 00                	mov    (%rax),%eax
 841:	0f be d0             	movsbl %al,%edx
 844:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 84a:	89 d6                	mov    %edx,%esi
 84c:	89 c7                	mov    %eax,%edi
 84e:	e8 24 fc ff ff       	call   477 <putc>
 853:	eb 4d                	jmp    8a2 <printf+0x339>
      } else if(c == '%'){
 855:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 85c:	75 1a                	jne    878 <printf+0x30f>
        putc(fd, c);
 85e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 864:	0f be d0             	movsbl %al,%edx
 867:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 86d:	89 d6                	mov    %edx,%esi
 86f:	89 c7                	mov    %eax,%edi
 871:	e8 01 fc ff ff       	call   477 <putc>
 876:	eb 2a                	jmp    8a2 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 878:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 87e:	be 25 00 00 00       	mov    $0x25,%esi
 883:	89 c7                	mov    %eax,%edi
 885:	e8 ed fb ff ff       	call   477 <putc>
        putc(fd, c);
 88a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 890:	0f be d0             	movsbl %al,%edx
 893:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 899:	89 d6                	mov    %edx,%esi
 89b:	89 c7                	mov    %eax,%edi
 89d:	e8 d5 fb ff ff       	call   477 <putc>
      }
      state = 0;
 8a2:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8a9:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8ac:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8b3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8b9:	48 63 d0             	movslq %eax,%rdx
 8bc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8c3:	48 01 d0             	add    %rdx,%rax
 8c6:	0f b6 00             	movzbl (%rax),%eax
 8c9:	84 c0                	test   %al,%al
 8cb:	0f 85 3a fd ff ff    	jne    60b <printf+0xa2>
    }
  }
}
 8d1:	90                   	nop
 8d2:	90                   	nop
 8d3:	c9                   	leave
 8d4:	c3                   	ret

00000000000008d5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d5:	f3 0f 1e fa          	endbr64
 8d9:	55                   	push   %rbp
 8da:	48 89 e5             	mov    %rsp,%rbp
 8dd:	48 83 ec 18          	sub    $0x18,%rsp
 8e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8e9:	48 83 e8 10          	sub    $0x10,%rax
 8ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f1:	48 8b 05 28 05 00 00 	mov    0x528(%rip),%rax        # e20 <freep>
 8f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8fc:	eb 2f                	jmp    92d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 902:	48 8b 00             	mov    (%rax),%rax
 905:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 909:	72 17                	jb     922 <free+0x4d>
 90b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 913:	72 2f                	jb     944 <free+0x6f>
 915:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 919:	48 8b 00             	mov    (%rax),%rax
 91c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 920:	72 22                	jb     944 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 922:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 926:	48 8b 00             	mov    (%rax),%rax
 929:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 92d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 931:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 935:	73 c7                	jae    8fe <free+0x29>
 937:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93b:	48 8b 00             	mov    (%rax),%rax
 93e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 942:	73 ba                	jae    8fe <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 944:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 948:	8b 40 08             	mov    0x8(%rax),%eax
 94b:	89 c0                	mov    %eax,%eax
 94d:	48 c1 e0 04          	shl    $0x4,%rax
 951:	48 89 c2             	mov    %rax,%rdx
 954:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 958:	48 01 c2             	add    %rax,%rdx
 95b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95f:	48 8b 00             	mov    (%rax),%rax
 962:	48 39 c2             	cmp    %rax,%rdx
 965:	75 2d                	jne    994 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 967:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96b:	8b 50 08             	mov    0x8(%rax),%edx
 96e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 972:	48 8b 00             	mov    (%rax),%rax
 975:	8b 40 08             	mov    0x8(%rax),%eax
 978:	01 c2                	add    %eax,%edx
 97a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	48 8b 00             	mov    (%rax),%rax
 988:	48 8b 10             	mov    (%rax),%rdx
 98b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 98f:	48 89 10             	mov    %rdx,(%rax)
 992:	eb 0e                	jmp    9a2 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 994:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 998:	48 8b 10             	mov    (%rax),%rdx
 99b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a6:	8b 40 08             	mov    0x8(%rax),%eax
 9a9:	89 c0                	mov    %eax,%eax
 9ab:	48 c1 e0 04          	shl    $0x4,%rax
 9af:	48 89 c2             	mov    %rax,%rdx
 9b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b6:	48 01 d0             	add    %rdx,%rax
 9b9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9bd:	75 27                	jne    9e6 <free+0x111>
    p->s.size += bp->s.size;
 9bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c3:	8b 50 08             	mov    0x8(%rax),%edx
 9c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ca:	8b 40 08             	mov    0x8(%rax),%eax
 9cd:	01 c2                	add    %eax,%edx
 9cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9da:	48 8b 10             	mov    (%rax),%rdx
 9dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e1:	48 89 10             	mov    %rdx,(%rax)
 9e4:	eb 0b                	jmp    9f1 <free+0x11c>
  } else
    p->s.ptr = bp;
 9e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9ee:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f5:	48 89 05 24 04 00 00 	mov    %rax,0x424(%rip)        # e20 <freep>
}
 9fc:	90                   	nop
 9fd:	c9                   	leave
 9fe:	c3                   	ret

00000000000009ff <morecore>:

static Header*
morecore(uint nu)
{
 9ff:	f3 0f 1e fa          	endbr64
 a03:	55                   	push   %rbp
 a04:	48 89 e5             	mov    %rsp,%rbp
 a07:	48 83 ec 20          	sub    $0x20,%rsp
 a0b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a0e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a15:	77 07                	ja     a1e <morecore+0x1f>
    nu = 4096;
 a17:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a21:	c1 e0 04             	shl    $0x4,%eax
 a24:	89 c7                	mov    %eax,%edi
 a26:	e8 04 fa ff ff       	call   42f <sbrk>
 a2b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a2f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a34:	75 07                	jne    a3d <morecore+0x3e>
    return 0;
 a36:	b8 00 00 00 00       	mov    $0x0,%eax
 a3b:	eb 29                	jmp    a66 <morecore+0x67>
  hp = (Header*)p;
 a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a49:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a4c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a53:	48 83 c0 10          	add    $0x10,%rax
 a57:	48 89 c7             	mov    %rax,%rdi
 a5a:	e8 76 fe ff ff       	call   8d5 <free>
  return freep;
 a5f:	48 8b 05 ba 03 00 00 	mov    0x3ba(%rip),%rax        # e20 <freep>
}
 a66:	c9                   	leave
 a67:	c3                   	ret

0000000000000a68 <malloc>:

void*
malloc(uint nbytes)
{
 a68:	f3 0f 1e fa          	endbr64
 a6c:	55                   	push   %rbp
 a6d:	48 89 e5             	mov    %rsp,%rbp
 a70:	48 83 ec 30          	sub    $0x30,%rsp
 a74:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a77:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a7a:	48 83 c0 0f          	add    $0xf,%rax
 a7e:	48 c1 e8 04          	shr    $0x4,%rax
 a82:	83 c0 01             	add    $0x1,%eax
 a85:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a88:	48 8b 05 91 03 00 00 	mov    0x391(%rip),%rax        # e20 <freep>
 a8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a93:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a98:	75 2b                	jne    ac5 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a9a:	48 c7 45 f0 10 0e 00 	movq   $0xe10,-0x10(%rbp)
 aa1:	00 
 aa2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa6:	48 89 05 73 03 00 00 	mov    %rax,0x373(%rip)        # e20 <freep>
 aad:	48 8b 05 6c 03 00 00 	mov    0x36c(%rip),%rax        # e20 <freep>
 ab4:	48 89 05 55 03 00 00 	mov    %rax,0x355(%rip)        # e10 <base>
    base.s.size = 0;
 abb:	c7 05 53 03 00 00 00 	movl   $0x0,0x353(%rip)        # e18 <base+0x8>
 ac2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac9:	48 8b 00             	mov    (%rax),%rax
 acc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad4:	8b 40 08             	mov    0x8(%rax),%eax
 ad7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ada:	72 5f                	jb     b3b <malloc+0xd3>
      if(p->s.size == nunits)
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	8b 40 08             	mov    0x8(%rax),%eax
 ae3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ae6:	75 10                	jne    af8 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ae8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aec:	48 8b 10             	mov    (%rax),%rdx
 aef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af3:	48 89 10             	mov    %rdx,(%rax)
 af6:	eb 2e                	jmp    b26 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 af8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afc:	8b 40 08             	mov    0x8(%rax),%eax
 aff:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b02:	89 c2                	mov    %eax,%edx
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0f:	8b 40 08             	mov    0x8(%rax),%eax
 b12:	89 c0                	mov    %eax,%eax
 b14:	48 c1 e0 04          	shl    $0x4,%rax
 b18:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b20:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b23:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b2a:	48 89 05 ef 02 00 00 	mov    %rax,0x2ef(%rip)        # e20 <freep>
      return (void*)(p + 1);
 b31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b35:	48 83 c0 10          	add    $0x10,%rax
 b39:	eb 41                	jmp    b7c <malloc+0x114>
    }
    if(p == freep)
 b3b:	48 8b 05 de 02 00 00 	mov    0x2de(%rip),%rax        # e20 <freep>
 b42:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b46:	75 1c                	jne    b64 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b48:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b4b:	89 c7                	mov    %eax,%edi
 b4d:	e8 ad fe ff ff       	call   9ff <morecore>
 b52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b56:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b5b:	75 07                	jne    b64 <malloc+0xfc>
        return 0;
 b5d:	b8 00 00 00 00       	mov    $0x0,%eax
 b62:	eb 18                	jmp    b7c <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b68:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b70:	48 8b 00             	mov    (%rax),%rax
 b73:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b77:	e9 54 ff ff ff       	jmp    ad0 <malloc+0x68>
  }
}
 b7c:	c9                   	leave
 b7d:	c3                   	ret
