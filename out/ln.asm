
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
  19:	48 c7 c6 76 0b 00 00 	mov    $0xb76,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 32 05 00 00       	call   561 <printf>
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
  75:	48 c7 c6 89 0b 00 00 	mov    $0xb89,%rsi
  7c:	bf 02 00 00 00       	mov    $0x2,%edi
  81:	b8 00 00 00 00       	mov    $0x0,%eax
  86:	e8 d6 04 00 00       	call   561 <printf>
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

000000000000046f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 46f:	f3 0f 1e fa          	endbr64
 473:	55                   	push   %rbp
 474:	48 89 e5             	mov    %rsp,%rbp
 477:	48 83 ec 10          	sub    $0x10,%rsp
 47b:	89 7d fc             	mov    %edi,-0x4(%rbp)
 47e:	89 f0                	mov    %esi,%eax
 480:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 483:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 487:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48a:	ba 01 00 00 00       	mov    $0x1,%edx
 48f:	48 89 ce             	mov    %rcx,%rsi
 492:	89 c7                	mov    %eax,%edi
 494:	e8 2e ff ff ff       	call   3c7 <write>
}
 499:	90                   	nop
 49a:	c9                   	leave
 49b:	c3                   	ret

000000000000049c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49c:	f3 0f 1e fa          	endbr64
 4a0:	55                   	push   %rbp
 4a1:	48 89 e5             	mov    %rsp,%rbp
 4a4:	48 83 ec 30          	sub    $0x30,%rsp
 4a8:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4ab:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4ae:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4b1:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4bb:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4bf:	74 17                	je     4d8 <printint+0x3c>
 4c1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4c5:	79 11                	jns    4d8 <printint+0x3c>
    neg = 1;
 4c7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4ce:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4d1:	f7 d8                	neg    %eax
 4d3:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4d6:	eb 06                	jmp    4de <printint+0x42>
  } else {
    x = xx;
 4d8:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4db:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4e5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4e8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4eb:	ba 00 00 00 00       	mov    $0x0,%edx
 4f0:	f7 f6                	div    %esi
 4f2:	89 d1                	mov    %edx,%ecx
 4f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f7:	8d 50 01             	lea    0x1(%rax),%edx
 4fa:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4fd:	89 ca                	mov    %ecx,%edx
 4ff:	0f b6 92 e0 0d 00 00 	movzbl 0xde0(%rdx),%edx
 506:	48 98                	cltq
 508:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 50c:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 50f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 512:	ba 00 00 00 00       	mov    $0x0,%edx
 517:	f7 f7                	div    %edi
 519:	89 45 f4             	mov    %eax,-0xc(%rbp)
 51c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 520:	75 c3                	jne    4e5 <printint+0x49>
  if(neg)
 522:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 526:	74 2b                	je     553 <printint+0xb7>
    buf[i++] = '-';
 528:	8b 45 fc             	mov    -0x4(%rbp),%eax
 52b:	8d 50 01             	lea    0x1(%rax),%edx
 52e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 531:	48 98                	cltq
 533:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 538:	eb 19                	jmp    553 <printint+0xb7>
    putc(fd, buf[i]);
 53a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 53d:	48 98                	cltq
 53f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 544:	0f be d0             	movsbl %al,%edx
 547:	8b 45 dc             	mov    -0x24(%rbp),%eax
 54a:	89 d6                	mov    %edx,%esi
 54c:	89 c7                	mov    %eax,%edi
 54e:	e8 1c ff ff ff       	call   46f <putc>
  while(--i >= 0)
 553:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 557:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 55b:	79 dd                	jns    53a <printint+0x9e>
}
 55d:	90                   	nop
 55e:	90                   	nop
 55f:	c9                   	leave
 560:	c3                   	ret

0000000000000561 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 561:	f3 0f 1e fa          	endbr64
 565:	55                   	push   %rbp
 566:	48 89 e5             	mov    %rsp,%rbp
 569:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 570:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 576:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 57d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 584:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 58b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 592:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 599:	84 c0                	test   %al,%al
 59b:	74 20                	je     5bd <printf+0x5c>
 59d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5a1:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5a5:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5a9:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5ad:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5b1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5b5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5b9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5bd:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5c4:	00 00 00 
 5c7:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5ce:	00 00 00 
 5d1:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5d5:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5dc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5e3:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5ea:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5f1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5f4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5fb:	00 00 00 
 5fe:	e9 a8 02 00 00       	jmp    8ab <printf+0x34a>
    c = fmt[i] & 0xff;
 603:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 609:	48 63 d0             	movslq %eax,%rdx
 60c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 613:	48 01 d0             	add    %rdx,%rax
 616:	0f b6 00             	movzbl (%rax),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	25 ff 00 00 00       	and    $0xff,%eax
 621:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 627:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 62e:	75 35                	jne    665 <printf+0x104>
      if(c == '%'){
 630:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 637:	75 0f                	jne    648 <printf+0xe7>
        state = '%';
 639:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 640:	00 00 00 
 643:	e9 5c 02 00 00       	jmp    8a4 <printf+0x343>
      } else {
        putc(fd, c);
 648:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 64e:	0f be d0             	movsbl %al,%edx
 651:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 657:	89 d6                	mov    %edx,%esi
 659:	89 c7                	mov    %eax,%edi
 65b:	e8 0f fe ff ff       	call   46f <putc>
 660:	e9 3f 02 00 00       	jmp    8a4 <printf+0x343>
      }
    } else if(state == '%'){
 665:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 66c:	0f 85 32 02 00 00    	jne    8a4 <printf+0x343>
      if(c == 'd'){
 672:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 679:	75 5e                	jne    6d9 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 67b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 681:	83 f8 2f             	cmp    $0x2f,%eax
 684:	77 23                	ja     6a9 <printf+0x148>
 686:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 68d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 693:	89 d2                	mov    %edx,%edx
 695:	48 01 d0             	add    %rdx,%rax
 698:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69e:	83 c2 08             	add    $0x8,%edx
 6a1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6a7:	eb 12                	jmp    6bb <printf+0x15a>
 6a9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6b4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6bb:	8b 30                	mov    (%rax),%esi
 6bd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6c3:	b9 01 00 00 00       	mov    $0x1,%ecx
 6c8:	ba 0a 00 00 00       	mov    $0xa,%edx
 6cd:	89 c7                	mov    %eax,%edi
 6cf:	e8 c8 fd ff ff       	call   49c <printint>
 6d4:	e9 c1 01 00 00       	jmp    89a <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6d9:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6e0:	74 09                	je     6eb <printf+0x18a>
 6e2:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6e9:	75 5e                	jne    749 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6eb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f1:	83 f8 2f             	cmp    $0x2f,%eax
 6f4:	77 23                	ja     719 <printf+0x1b8>
 6f6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6fd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 703:	89 d2                	mov    %edx,%edx
 705:	48 01 d0             	add    %rdx,%rax
 708:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70e:	83 c2 08             	add    $0x8,%edx
 711:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 717:	eb 12                	jmp    72b <printf+0x1ca>
 719:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 720:	48 8d 50 08          	lea    0x8(%rax),%rdx
 724:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 72b:	8b 30                	mov    (%rax),%esi
 72d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 733:	b9 00 00 00 00       	mov    $0x0,%ecx
 738:	ba 10 00 00 00       	mov    $0x10,%edx
 73d:	89 c7                	mov    %eax,%edi
 73f:	e8 58 fd ff ff       	call   49c <printint>
 744:	e9 51 01 00 00       	jmp    89a <printf+0x339>
      } else if(c == 's'){
 749:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 750:	0f 85 98 00 00 00    	jne    7ee <printf+0x28d>
        s = va_arg(ap, char*);
 756:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 75c:	83 f8 2f             	cmp    $0x2f,%eax
 75f:	77 23                	ja     784 <printf+0x223>
 761:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 768:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76e:	89 d2                	mov    %edx,%edx
 770:	48 01 d0             	add    %rdx,%rax
 773:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 779:	83 c2 08             	add    $0x8,%edx
 77c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 782:	eb 12                	jmp    796 <printf+0x235>
 784:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 78b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 78f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 796:	48 8b 00             	mov    (%rax),%rax
 799:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7a0:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7a7:	00 
 7a8:	75 31                	jne    7db <printf+0x27a>
          s = "(null)";
 7aa:	48 c7 85 48 ff ff ff 	movq   $0xb9d,-0xb8(%rbp)
 7b1:	9d 0b 00 00 
        while(*s != 0){
 7b5:	eb 24                	jmp    7db <printf+0x27a>
          putc(fd, *s);
 7b7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7be:	0f b6 00             	movzbl (%rax),%eax
 7c1:	0f be d0             	movsbl %al,%edx
 7c4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ca:	89 d6                	mov    %edx,%esi
 7cc:	89 c7                	mov    %eax,%edi
 7ce:	e8 9c fc ff ff       	call   46f <putc>
          s++;
 7d3:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7da:	01 
        while(*s != 0){
 7db:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7e2:	0f b6 00             	movzbl (%rax),%eax
 7e5:	84 c0                	test   %al,%al
 7e7:	75 ce                	jne    7b7 <printf+0x256>
 7e9:	e9 ac 00 00 00       	jmp    89a <printf+0x339>
        }
      } else if(c == 'c'){
 7ee:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7f5:	75 56                	jne    84d <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7f7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7fd:	83 f8 2f             	cmp    $0x2f,%eax
 800:	77 23                	ja     825 <printf+0x2c4>
 802:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 809:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 80f:	89 d2                	mov    %edx,%edx
 811:	48 01 d0             	add    %rdx,%rax
 814:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 81a:	83 c2 08             	add    $0x8,%edx
 81d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 823:	eb 12                	jmp    837 <printf+0x2d6>
 825:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 82c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 830:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 837:	8b 00                	mov    (%rax),%eax
 839:	0f be d0             	movsbl %al,%edx
 83c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 842:	89 d6                	mov    %edx,%esi
 844:	89 c7                	mov    %eax,%edi
 846:	e8 24 fc ff ff       	call   46f <putc>
 84b:	eb 4d                	jmp    89a <printf+0x339>
      } else if(c == '%'){
 84d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 854:	75 1a                	jne    870 <printf+0x30f>
        putc(fd, c);
 856:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 85c:	0f be d0             	movsbl %al,%edx
 85f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 865:	89 d6                	mov    %edx,%esi
 867:	89 c7                	mov    %eax,%edi
 869:	e8 01 fc ff ff       	call   46f <putc>
 86e:	eb 2a                	jmp    89a <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 870:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 876:	be 25 00 00 00       	mov    $0x25,%esi
 87b:	89 c7                	mov    %eax,%edi
 87d:	e8 ed fb ff ff       	call   46f <putc>
        putc(fd, c);
 882:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 888:	0f be d0             	movsbl %al,%edx
 88b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 891:	89 d6                	mov    %edx,%esi
 893:	89 c7                	mov    %eax,%edi
 895:	e8 d5 fb ff ff       	call   46f <putc>
      }
      state = 0;
 89a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8a1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8a4:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8ab:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8b1:	48 63 d0             	movslq %eax,%rdx
 8b4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8bb:	48 01 d0             	add    %rdx,%rax
 8be:	0f b6 00             	movzbl (%rax),%eax
 8c1:	84 c0                	test   %al,%al
 8c3:	0f 85 3a fd ff ff    	jne    603 <printf+0xa2>
    }
  }
}
 8c9:	90                   	nop
 8ca:	90                   	nop
 8cb:	c9                   	leave
 8cc:	c3                   	ret

00000000000008cd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8cd:	f3 0f 1e fa          	endbr64
 8d1:	55                   	push   %rbp
 8d2:	48 89 e5             	mov    %rsp,%rbp
 8d5:	48 83 ec 18          	sub    $0x18,%rsp
 8d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8e1:	48 83 e8 10          	sub    $0x10,%rax
 8e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e9:	48 8b 05 20 05 00 00 	mov    0x520(%rip),%rax        # e10 <freep>
 8f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8f4:	eb 2f                	jmp    925 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fa:	48 8b 00             	mov    (%rax),%rax
 8fd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 901:	72 17                	jb     91a <free+0x4d>
 903:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 907:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 90b:	72 2f                	jb     93c <free+0x6f>
 90d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 911:	48 8b 00             	mov    (%rax),%rax
 914:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 918:	72 22                	jb     93c <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91e:	48 8b 00             	mov    (%rax),%rax
 921:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 925:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 929:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 92d:	73 c7                	jae    8f6 <free+0x29>
 92f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 933:	48 8b 00             	mov    (%rax),%rax
 936:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 93a:	73 ba                	jae    8f6 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 93c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 940:	8b 40 08             	mov    0x8(%rax),%eax
 943:	89 c0                	mov    %eax,%eax
 945:	48 c1 e0 04          	shl    $0x4,%rax
 949:	48 89 c2             	mov    %rax,%rdx
 94c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 950:	48 01 c2             	add    %rax,%rdx
 953:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 957:	48 8b 00             	mov    (%rax),%rax
 95a:	48 39 c2             	cmp    %rax,%rdx
 95d:	75 2d                	jne    98c <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 95f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 963:	8b 50 08             	mov    0x8(%rax),%edx
 966:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96a:	48 8b 00             	mov    (%rax),%rax
 96d:	8b 40 08             	mov    0x8(%rax),%eax
 970:	01 c2                	add    %eax,%edx
 972:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 976:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97d:	48 8b 00             	mov    (%rax),%rax
 980:	48 8b 10             	mov    (%rax),%rdx
 983:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 987:	48 89 10             	mov    %rdx,(%rax)
 98a:	eb 0e                	jmp    99a <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 98c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 990:	48 8b 10             	mov    (%rax),%rdx
 993:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 997:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 99a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99e:	8b 40 08             	mov    0x8(%rax),%eax
 9a1:	89 c0                	mov    %eax,%eax
 9a3:	48 c1 e0 04          	shl    $0x4,%rax
 9a7:	48 89 c2             	mov    %rax,%rdx
 9aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ae:	48 01 d0             	add    %rdx,%rax
 9b1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9b5:	75 27                	jne    9de <free+0x111>
    p->s.size += bp->s.size;
 9b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bb:	8b 50 08             	mov    0x8(%rax),%edx
 9be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c2:	8b 40 08             	mov    0x8(%rax),%eax
 9c5:	01 c2                	add    %eax,%edx
 9c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cb:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d2:	48 8b 10             	mov    (%rax),%rdx
 9d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d9:	48 89 10             	mov    %rdx,(%rax)
 9dc:	eb 0b                	jmp    9e9 <free+0x11c>
  } else
    p->s.ptr = bp;
 9de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9e6:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ed:	48 89 05 1c 04 00 00 	mov    %rax,0x41c(%rip)        # e10 <freep>
}
 9f4:	90                   	nop
 9f5:	c9                   	leave
 9f6:	c3                   	ret

00000000000009f7 <morecore>:

static Header*
morecore(uint nu)
{
 9f7:	f3 0f 1e fa          	endbr64
 9fb:	55                   	push   %rbp
 9fc:	48 89 e5             	mov    %rsp,%rbp
 9ff:	48 83 ec 20          	sub    $0x20,%rsp
 a03:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a06:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a0d:	77 07                	ja     a16 <morecore+0x1f>
    nu = 4096;
 a0f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a16:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a19:	c1 e0 04             	shl    $0x4,%eax
 a1c:	89 c7                	mov    %eax,%edi
 a1e:	e8 0c fa ff ff       	call   42f <sbrk>
 a23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a27:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a2c:	75 07                	jne    a35 <morecore+0x3e>
    return 0;
 a2e:	b8 00 00 00 00       	mov    $0x0,%eax
 a33:	eb 29                	jmp    a5e <morecore+0x67>
  hp = (Header*)p;
 a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a41:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a44:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a4b:	48 83 c0 10          	add    $0x10,%rax
 a4f:	48 89 c7             	mov    %rax,%rdi
 a52:	e8 76 fe ff ff       	call   8cd <free>
  return freep;
 a57:	48 8b 05 b2 03 00 00 	mov    0x3b2(%rip),%rax        # e10 <freep>
}
 a5e:	c9                   	leave
 a5f:	c3                   	ret

0000000000000a60 <malloc>:

void*
malloc(uint nbytes)
{
 a60:	f3 0f 1e fa          	endbr64
 a64:	55                   	push   %rbp
 a65:	48 89 e5             	mov    %rsp,%rbp
 a68:	48 83 ec 30          	sub    $0x30,%rsp
 a6c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a72:	48 83 c0 0f          	add    $0xf,%rax
 a76:	48 c1 e8 04          	shr    $0x4,%rax
 a7a:	83 c0 01             	add    $0x1,%eax
 a7d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a80:	48 8b 05 89 03 00 00 	mov    0x389(%rip),%rax        # e10 <freep>
 a87:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a8b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a90:	75 2b                	jne    abd <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a92:	48 c7 45 f0 00 0e 00 	movq   $0xe00,-0x10(%rbp)
 a99:	00 
 a9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9e:	48 89 05 6b 03 00 00 	mov    %rax,0x36b(%rip)        # e10 <freep>
 aa5:	48 8b 05 64 03 00 00 	mov    0x364(%rip),%rax        # e10 <freep>
 aac:	48 89 05 4d 03 00 00 	mov    %rax,0x34d(%rip)        # e00 <base>
    base.s.size = 0;
 ab3:	c7 05 4b 03 00 00 00 	movl   $0x0,0x34b(%rip)        # e08 <base+0x8>
 aba:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 abd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac1:	48 8b 00             	mov    (%rax),%rax
 ac4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ac8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acc:	8b 40 08             	mov    0x8(%rax),%eax
 acf:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ad2:	72 5f                	jb     b33 <malloc+0xd3>
      if(p->s.size == nunits)
 ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad8:	8b 40 08             	mov    0x8(%rax),%eax
 adb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ade:	75 10                	jne    af0 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	48 8b 10             	mov    (%rax),%rdx
 ae7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aeb:	48 89 10             	mov    %rdx,(%rax)
 aee:	eb 2e                	jmp    b1e <malloc+0xbe>
      else {
        p->s.size -= nunits;
 af0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af4:	8b 40 08             	mov    0x8(%rax),%eax
 af7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 afa:	89 c2                	mov    %eax,%edx
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b07:	8b 40 08             	mov    0x8(%rax),%eax
 b0a:	89 c0                	mov    %eax,%eax
 b0c:	48 c1 e0 04          	shl    $0x4,%rax
 b10:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b18:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b1b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b22:	48 89 05 e7 02 00 00 	mov    %rax,0x2e7(%rip)        # e10 <freep>
      return (void*)(p + 1);
 b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2d:	48 83 c0 10          	add    $0x10,%rax
 b31:	eb 41                	jmp    b74 <malloc+0x114>
    }
    if(p == freep)
 b33:	48 8b 05 d6 02 00 00 	mov    0x2d6(%rip),%rax        # e10 <freep>
 b3a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b3e:	75 1c                	jne    b5c <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b40:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b43:	89 c7                	mov    %eax,%edi
 b45:	e8 ad fe ff ff       	call   9f7 <morecore>
 b4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b4e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b53:	75 07                	jne    b5c <malloc+0xfc>
        return 0;
 b55:	b8 00 00 00 00       	mov    $0x0,%eax
 b5a:	eb 18                	jmp    b74 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b60:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b68:	48 8b 00             	mov    (%rax),%rax
 b6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b6f:	e9 54 ff ff ff       	jmp    ac8 <malloc+0x68>
  }
}
 b74:	c9                   	leave
 b75:	c3                   	ret
