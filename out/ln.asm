
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
  19:	48 c7 c6 66 0b 00 00 	mov    $0xb66,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 22 05 00 00       	call   551 <printf>
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
  75:	48 c7 c6 79 0b 00 00 	mov    $0xb79,%rsi
  7c:	bf 02 00 00 00       	mov    $0x2,%edi
  81:	b8 00 00 00 00       	mov    $0x0,%eax
  86:	e8 c6 04 00 00       	call   551 <printf>
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

000000000000045f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45f:	f3 0f 1e fa          	endbr64
 463:	55                   	push   %rbp
 464:	48 89 e5             	mov    %rsp,%rbp
 467:	48 83 ec 10          	sub    $0x10,%rsp
 46b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 46e:	89 f0                	mov    %esi,%eax
 470:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 473:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 477:	8b 45 fc             	mov    -0x4(%rbp),%eax
 47a:	ba 01 00 00 00       	mov    $0x1,%edx
 47f:	48 89 ce             	mov    %rcx,%rsi
 482:	89 c7                	mov    %eax,%edi
 484:	e8 3e ff ff ff       	call   3c7 <write>
}
 489:	90                   	nop
 48a:	c9                   	leave
 48b:	c3                   	ret

000000000000048c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 48c:	f3 0f 1e fa          	endbr64
 490:	55                   	push   %rbp
 491:	48 89 e5             	mov    %rsp,%rbp
 494:	48 83 ec 30          	sub    $0x30,%rsp
 498:	89 7d dc             	mov    %edi,-0x24(%rbp)
 49b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 49e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4a1:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4ab:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4af:	74 17                	je     4c8 <printint+0x3c>
 4b1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4b5:	79 11                	jns    4c8 <printint+0x3c>
    neg = 1;
 4b7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4be:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4c1:	f7 d8                	neg    %eax
 4c3:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4c6:	eb 06                	jmp    4ce <printint+0x42>
  } else {
    x = xx;
 4c8:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4cb:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4d5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4db:	ba 00 00 00 00       	mov    $0x0,%edx
 4e0:	f7 f6                	div    %esi
 4e2:	89 d1                	mov    %edx,%ecx
 4e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e7:	8d 50 01             	lea    0x1(%rax),%edx
 4ea:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ed:	89 ca                	mov    %ecx,%edx
 4ef:	0f b6 92 d0 0d 00 00 	movzbl 0xdd0(%rdx),%edx
 4f6:	48 98                	cltq
 4f8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4fc:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4ff:	8b 45 f4             	mov    -0xc(%rbp),%eax
 502:	ba 00 00 00 00       	mov    $0x0,%edx
 507:	f7 f7                	div    %edi
 509:	89 45 f4             	mov    %eax,-0xc(%rbp)
 50c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 510:	75 c3                	jne    4d5 <printint+0x49>
  if(neg)
 512:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 516:	74 2b                	je     543 <printint+0xb7>
    buf[i++] = '-';
 518:	8b 45 fc             	mov    -0x4(%rbp),%eax
 51b:	8d 50 01             	lea    0x1(%rax),%edx
 51e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 521:	48 98                	cltq
 523:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 528:	eb 19                	jmp    543 <printint+0xb7>
    putc(fd, buf[i]);
 52a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 52d:	48 98                	cltq
 52f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 534:	0f be d0             	movsbl %al,%edx
 537:	8b 45 dc             	mov    -0x24(%rbp),%eax
 53a:	89 d6                	mov    %edx,%esi
 53c:	89 c7                	mov    %eax,%edi
 53e:	e8 1c ff ff ff       	call   45f <putc>
  while(--i >= 0)
 543:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 547:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 54b:	79 dd                	jns    52a <printint+0x9e>
}
 54d:	90                   	nop
 54e:	90                   	nop
 54f:	c9                   	leave
 550:	c3                   	ret

0000000000000551 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 551:	f3 0f 1e fa          	endbr64
 555:	55                   	push   %rbp
 556:	48 89 e5             	mov    %rsp,%rbp
 559:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 560:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 566:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 56d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 574:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 57b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 582:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 589:	84 c0                	test   %al,%al
 58b:	74 20                	je     5ad <printf+0x5c>
 58d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 591:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 595:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 599:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 59d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5a1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5a5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5a9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5ad:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5b4:	00 00 00 
 5b7:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5be:	00 00 00 
 5c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5c5:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5cc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5d3:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5da:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5e1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5e4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5eb:	00 00 00 
 5ee:	e9 a8 02 00 00       	jmp    89b <printf+0x34a>
    c = fmt[i] & 0xff;
 5f3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5f9:	48 63 d0             	movslq %eax,%rdx
 5fc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 603:	48 01 d0             	add    %rdx,%rax
 606:	0f b6 00             	movzbl (%rax),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	25 ff 00 00 00       	and    $0xff,%eax
 611:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 617:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 61e:	75 35                	jne    655 <printf+0x104>
      if(c == '%'){
 620:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 627:	75 0f                	jne    638 <printf+0xe7>
        state = '%';
 629:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 630:	00 00 00 
 633:	e9 5c 02 00 00       	jmp    894 <printf+0x343>
      } else {
        putc(fd, c);
 638:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 63e:	0f be d0             	movsbl %al,%edx
 641:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 647:	89 d6                	mov    %edx,%esi
 649:	89 c7                	mov    %eax,%edi
 64b:	e8 0f fe ff ff       	call   45f <putc>
 650:	e9 3f 02 00 00       	jmp    894 <printf+0x343>
      }
    } else if(state == '%'){
 655:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 65c:	0f 85 32 02 00 00    	jne    894 <printf+0x343>
      if(c == 'd'){
 662:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 669:	75 5e                	jne    6c9 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 66b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 671:	83 f8 2f             	cmp    $0x2f,%eax
 674:	77 23                	ja     699 <printf+0x148>
 676:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 67d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 683:	89 d2                	mov    %edx,%edx
 685:	48 01 d0             	add    %rdx,%rax
 688:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68e:	83 c2 08             	add    $0x8,%edx
 691:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 697:	eb 12                	jmp    6ab <printf+0x15a>
 699:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ab:	8b 30                	mov    (%rax),%esi
 6ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b3:	b9 01 00 00 00       	mov    $0x1,%ecx
 6b8:	ba 0a 00 00 00       	mov    $0xa,%edx
 6bd:	89 c7                	mov    %eax,%edi
 6bf:	e8 c8 fd ff ff       	call   48c <printint>
 6c4:	e9 c1 01 00 00       	jmp    88a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6c9:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6d0:	74 09                	je     6db <printf+0x18a>
 6d2:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6d9:	75 5e                	jne    739 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e1:	83 f8 2f             	cmp    $0x2f,%eax
 6e4:	77 23                	ja     709 <printf+0x1b8>
 6e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f3:	89 d2                	mov    %edx,%edx
 6f5:	48 01 d0             	add    %rdx,%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	83 c2 08             	add    $0x8,%edx
 701:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 707:	eb 12                	jmp    71b <printf+0x1ca>
 709:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 710:	48 8d 50 08          	lea    0x8(%rax),%rdx
 714:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 71b:	8b 30                	mov    (%rax),%esi
 71d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 723:	b9 00 00 00 00       	mov    $0x0,%ecx
 728:	ba 10 00 00 00       	mov    $0x10,%edx
 72d:	89 c7                	mov    %eax,%edi
 72f:	e8 58 fd ff ff       	call   48c <printint>
 734:	e9 51 01 00 00       	jmp    88a <printf+0x339>
      } else if(c == 's'){
 739:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 740:	0f 85 98 00 00 00    	jne    7de <printf+0x28d>
        s = va_arg(ap, char*);
 746:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74c:	83 f8 2f             	cmp    $0x2f,%eax
 74f:	77 23                	ja     774 <printf+0x223>
 751:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 758:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75e:	89 d2                	mov    %edx,%edx
 760:	48 01 d0             	add    %rdx,%rax
 763:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 769:	83 c2 08             	add    $0x8,%edx
 76c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 772:	eb 12                	jmp    786 <printf+0x235>
 774:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 77f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 786:	48 8b 00             	mov    (%rax),%rax
 789:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 790:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 797:	00 
 798:	75 31                	jne    7cb <printf+0x27a>
          s = "(null)";
 79a:	48 c7 85 48 ff ff ff 	movq   $0xb8d,-0xb8(%rbp)
 7a1:	8d 0b 00 00 
        while(*s != 0){
 7a5:	eb 24                	jmp    7cb <printf+0x27a>
          putc(fd, *s);
 7a7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ae:	0f b6 00             	movzbl (%rax),%eax
 7b1:	0f be d0             	movsbl %al,%edx
 7b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ba:	89 d6                	mov    %edx,%esi
 7bc:	89 c7                	mov    %eax,%edi
 7be:	e8 9c fc ff ff       	call   45f <putc>
          s++;
 7c3:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7ca:	01 
        while(*s != 0){
 7cb:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7d2:	0f b6 00             	movzbl (%rax),%eax
 7d5:	84 c0                	test   %al,%al
 7d7:	75 ce                	jne    7a7 <printf+0x256>
 7d9:	e9 ac 00 00 00       	jmp    88a <printf+0x339>
        }
      } else if(c == 'c'){
 7de:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7e5:	75 56                	jne    83d <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7e7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ed:	83 f8 2f             	cmp    $0x2f,%eax
 7f0:	77 23                	ja     815 <printf+0x2c4>
 7f2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7f9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ff:	89 d2                	mov    %edx,%edx
 801:	48 01 d0             	add    %rdx,%rax
 804:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 80a:	83 c2 08             	add    $0x8,%edx
 80d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 813:	eb 12                	jmp    827 <printf+0x2d6>
 815:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 81c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 820:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 827:	8b 00                	mov    (%rax),%eax
 829:	0f be d0             	movsbl %al,%edx
 82c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 832:	89 d6                	mov    %edx,%esi
 834:	89 c7                	mov    %eax,%edi
 836:	e8 24 fc ff ff       	call   45f <putc>
 83b:	eb 4d                	jmp    88a <printf+0x339>
      } else if(c == '%'){
 83d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 844:	75 1a                	jne    860 <printf+0x30f>
        putc(fd, c);
 846:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 84c:	0f be d0             	movsbl %al,%edx
 84f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 855:	89 d6                	mov    %edx,%esi
 857:	89 c7                	mov    %eax,%edi
 859:	e8 01 fc ff ff       	call   45f <putc>
 85e:	eb 2a                	jmp    88a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 860:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 866:	be 25 00 00 00       	mov    $0x25,%esi
 86b:	89 c7                	mov    %eax,%edi
 86d:	e8 ed fb ff ff       	call   45f <putc>
        putc(fd, c);
 872:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 878:	0f be d0             	movsbl %al,%edx
 87b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 881:	89 d6                	mov    %edx,%esi
 883:	89 c7                	mov    %eax,%edi
 885:	e8 d5 fb ff ff       	call   45f <putc>
      }
      state = 0;
 88a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 891:	00 00 00 
  for(i = 0; fmt[i]; i++){
 894:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 89b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8a1:	48 63 d0             	movslq %eax,%rdx
 8a4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8ab:	48 01 d0             	add    %rdx,%rax
 8ae:	0f b6 00             	movzbl (%rax),%eax
 8b1:	84 c0                	test   %al,%al
 8b3:	0f 85 3a fd ff ff    	jne    5f3 <printf+0xa2>
    }
  }
}
 8b9:	90                   	nop
 8ba:	90                   	nop
 8bb:	c9                   	leave
 8bc:	c3                   	ret

00000000000008bd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8bd:	f3 0f 1e fa          	endbr64
 8c1:	55                   	push   %rbp
 8c2:	48 89 e5             	mov    %rsp,%rbp
 8c5:	48 83 ec 18          	sub    $0x18,%rsp
 8c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8d1:	48 83 e8 10          	sub    $0x10,%rax
 8d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d9:	48 8b 05 20 05 00 00 	mov    0x520(%rip),%rax        # e00 <freep>
 8e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8e4:	eb 2f                	jmp    915 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ea:	48 8b 00             	mov    (%rax),%rax
 8ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f1:	72 17                	jb     90a <free+0x4d>
 8f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8fb:	72 2f                	jb     92c <free+0x6f>
 8fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 901:	48 8b 00             	mov    (%rax),%rax
 904:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 908:	72 22                	jb     92c <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90e:	48 8b 00             	mov    (%rax),%rax
 911:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 915:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 919:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 91d:	73 c7                	jae    8e6 <free+0x29>
 91f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 923:	48 8b 00             	mov    (%rax),%rax
 926:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 92a:	73 ba                	jae    8e6 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 92c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 930:	8b 40 08             	mov    0x8(%rax),%eax
 933:	89 c0                	mov    %eax,%eax
 935:	48 c1 e0 04          	shl    $0x4,%rax
 939:	48 89 c2             	mov    %rax,%rdx
 93c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 940:	48 01 c2             	add    %rax,%rdx
 943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 947:	48 8b 00             	mov    (%rax),%rax
 94a:	48 39 c2             	cmp    %rax,%rdx
 94d:	75 2d                	jne    97c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 94f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 953:	8b 50 08             	mov    0x8(%rax),%edx
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 8b 00             	mov    (%rax),%rax
 95d:	8b 40 08             	mov    0x8(%rax),%eax
 960:	01 c2                	add    %eax,%edx
 962:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 966:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 8b 00             	mov    (%rax),%rax
 970:	48 8b 10             	mov    (%rax),%rdx
 973:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 977:	48 89 10             	mov    %rdx,(%rax)
 97a:	eb 0e                	jmp    98a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 97c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 980:	48 8b 10             	mov    (%rax),%rdx
 983:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 987:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 98a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98e:	8b 40 08             	mov    0x8(%rax),%eax
 991:	89 c0                	mov    %eax,%eax
 993:	48 c1 e0 04          	shl    $0x4,%rax
 997:	48 89 c2             	mov    %rax,%rdx
 99a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99e:	48 01 d0             	add    %rdx,%rax
 9a1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9a5:	75 27                	jne    9ce <free+0x111>
    p->s.size += bp->s.size;
 9a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ab:	8b 50 08             	mov    0x8(%rax),%edx
 9ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b2:	8b 40 08             	mov    0x8(%rax),%eax
 9b5:	01 c2                	add    %eax,%edx
 9b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bb:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c2:	48 8b 10             	mov    (%rax),%rdx
 9c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c9:	48 89 10             	mov    %rdx,(%rax)
 9cc:	eb 0b                	jmp    9d9 <free+0x11c>
  } else
    p->s.ptr = bp;
 9ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9d6:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 89 05 1c 04 00 00 	mov    %rax,0x41c(%rip)        # e00 <freep>
}
 9e4:	90                   	nop
 9e5:	c9                   	leave
 9e6:	c3                   	ret

00000000000009e7 <morecore>:

static Header*
morecore(uint nu)
{
 9e7:	f3 0f 1e fa          	endbr64
 9eb:	55                   	push   %rbp
 9ec:	48 89 e5             	mov    %rsp,%rbp
 9ef:	48 83 ec 20          	sub    $0x20,%rsp
 9f3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9f6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9fd:	77 07                	ja     a06 <morecore+0x1f>
    nu = 4096;
 9ff:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a06:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a09:	c1 e0 04             	shl    $0x4,%eax
 a0c:	89 c7                	mov    %eax,%edi
 a0e:	e8 1c fa ff ff       	call   42f <sbrk>
 a13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a17:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a1c:	75 07                	jne    a25 <morecore+0x3e>
    return 0;
 a1e:	b8 00 00 00 00       	mov    $0x0,%eax
 a23:	eb 29                	jmp    a4e <morecore+0x67>
  hp = (Header*)p;
 a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a31:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a34:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3b:	48 83 c0 10          	add    $0x10,%rax
 a3f:	48 89 c7             	mov    %rax,%rdi
 a42:	e8 76 fe ff ff       	call   8bd <free>
  return freep;
 a47:	48 8b 05 b2 03 00 00 	mov    0x3b2(%rip),%rax        # e00 <freep>
}
 a4e:	c9                   	leave
 a4f:	c3                   	ret

0000000000000a50 <malloc>:

void*
malloc(uint nbytes)
{
 a50:	f3 0f 1e fa          	endbr64
 a54:	55                   	push   %rbp
 a55:	48 89 e5             	mov    %rsp,%rbp
 a58:	48 83 ec 30          	sub    $0x30,%rsp
 a5c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a62:	48 83 c0 0f          	add    $0xf,%rax
 a66:	48 c1 e8 04          	shr    $0x4,%rax
 a6a:	83 c0 01             	add    $0x1,%eax
 a6d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a70:	48 8b 05 89 03 00 00 	mov    0x389(%rip),%rax        # e00 <freep>
 a77:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a7b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a80:	75 2b                	jne    aad <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a82:	48 c7 45 f0 f0 0d 00 	movq   $0xdf0,-0x10(%rbp)
 a89:	00 
 a8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8e:	48 89 05 6b 03 00 00 	mov    %rax,0x36b(%rip)        # e00 <freep>
 a95:	48 8b 05 64 03 00 00 	mov    0x364(%rip),%rax        # e00 <freep>
 a9c:	48 89 05 4d 03 00 00 	mov    %rax,0x34d(%rip)        # df0 <base>
    base.s.size = 0;
 aa3:	c7 05 4b 03 00 00 00 	movl   $0x0,0x34b(%rip)        # df8 <base+0x8>
 aaa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab1:	48 8b 00             	mov    (%rax),%rax
 ab4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abc:	8b 40 08             	mov    0x8(%rax),%eax
 abf:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ac2:	72 5f                	jb     b23 <malloc+0xd3>
      if(p->s.size == nunits)
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	8b 40 08             	mov    0x8(%rax),%eax
 acb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ace:	75 10                	jne    ae0 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad4:	48 8b 10             	mov    (%rax),%rdx
 ad7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 adb:	48 89 10             	mov    %rdx,(%rax)
 ade:	eb 2e                	jmp    b0e <malloc+0xbe>
      else {
        p->s.size -= nunits;
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	8b 40 08             	mov    0x8(%rax),%eax
 ae7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aea:	89 c2                	mov    %eax,%edx
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 af3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af7:	8b 40 08             	mov    0x8(%rax),%eax
 afa:	89 c0                	mov    %eax,%eax
 afc:	48 c1 e0 04          	shl    $0x4,%rax
 b00:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b0b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b12:	48 89 05 e7 02 00 00 	mov    %rax,0x2e7(%rip)        # e00 <freep>
      return (void*)(p + 1);
 b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1d:	48 83 c0 10          	add    $0x10,%rax
 b21:	eb 41                	jmp    b64 <malloc+0x114>
    }
    if(p == freep)
 b23:	48 8b 05 d6 02 00 00 	mov    0x2d6(%rip),%rax        # e00 <freep>
 b2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b2e:	75 1c                	jne    b4c <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b30:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b33:	89 c7                	mov    %eax,%edi
 b35:	e8 ad fe ff ff       	call   9e7 <morecore>
 b3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b3e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b43:	75 07                	jne    b4c <malloc+0xfc>
        return 0;
 b45:	b8 00 00 00 00       	mov    $0x0,%eax
 b4a:	eb 18                	jmp    b64 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b58:	48 8b 00             	mov    (%rax),%rax
 b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b5f:	e9 54 ff ff ff       	jmp    ab8 <malloc+0x68>
  }
}
 b64:	c9                   	leave
 b65:	c3                   	ret
