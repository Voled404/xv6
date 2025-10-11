
fs/countdown:     file format elf64-x86-64


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
  int time = atoi(argv[1]);
  13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  17:	48 83 c0 08          	add    $0x8,%rax
  1b:	48 8b 00             	mov    (%rax),%rax
  1e:	48 89 c7             	mov    %rax,%rdi
  21:	e8 34 03 00 00       	call   35a <atoi>
  26:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(argc < 3 || time <= 0){
  29:	83 7d ec 02          	cmpl   $0x2,-0x14(%rbp)
  2d:	7e 06                	jle    35 <main+0x35>
  2f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  33:	7f 44                	jg     79 <main+0x79>
    printf(2, "Usage: countdown seconds message...\n");
  35:	48 c7 c6 e0 0b 00 00 	mov    $0xbe0,%rsi
  3c:	bf 02 00 00 00       	mov    $0x2,%edi
  41:	b8 00 00 00 00       	mov    $0x0,%eax
  46:	e8 7e 05 00 00       	call   5c9 <printf>
    exit();
  4b:	e8 c7 03 00 00       	call   417 <exit>
  }

  while(time > 0){
    printf(2, "%d\n", time);
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	89 c2                	mov    %eax,%edx
  55:	48 c7 c6 05 0c 00 00 	mov    $0xc05,%rsi
  5c:	bf 02 00 00 00       	mov    $0x2,%edi
  61:	b8 00 00 00 00       	mov    $0x0,%eax
  66:	e8 5e 05 00 00       	call   5c9 <printf>
    time -= 1;
  6b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    sleep(100);
  6f:	bf 64 00 00 00       	mov    $0x64,%edi
  74:	e8 2e 04 00 00       	call   4a7 <sleep>
  while(time > 0){
  79:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  7d:	7f d1                	jg     50 <main+0x50>
  }

  for(int i = 2; i < argc; i++){
  7f:	c7 45 f8 02 00 00 00 	movl   $0x2,-0x8(%rbp)
  86:	eb 55                	jmp    dd <main+0xdd>
    printf(2, "%s", argv[i]);
  88:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8b:	48 98                	cltq
  8d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  94:	00 
  95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  99:	48 01 d0             	add    %rdx,%rax
  9c:	48 8b 00             	mov    (%rax),%rax
  9f:	48 89 c2             	mov    %rax,%rdx
  a2:	48 c7 c6 09 0c 00 00 	mov    $0xc09,%rsi
  a9:	bf 02 00 00 00       	mov    $0x2,%edi
  ae:	b8 00 00 00 00       	mov    $0x0,%eax
  b3:	e8 11 05 00 00       	call   5c9 <printf>
    if(i < argc - 1){
  b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  bb:	83 e8 01             	sub    $0x1,%eax
  be:	39 45 f8             	cmp    %eax,-0x8(%rbp)
  c1:	7d 16                	jge    d9 <main+0xd9>
      printf(2, " ");
  c3:	48 c7 c6 0c 0c 00 00 	mov    $0xc0c,%rsi
  ca:	bf 02 00 00 00       	mov    $0x2,%edi
  cf:	b8 00 00 00 00       	mov    $0x0,%eax
  d4:	e8 f0 04 00 00       	call   5c9 <printf>
  for(int i = 2; i < argc; i++){
  d9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  e3:	7c a3                	jl     88 <main+0x88>
    }
  }
  printf(2, "\n");
  e5:	48 c7 c6 0e 0c 00 00 	mov    $0xc0e,%rsi
  ec:	bf 02 00 00 00       	mov    $0x2,%edi
  f1:	b8 00 00 00 00       	mov    $0x0,%eax
  f6:	e8 ce 04 00 00       	call   5c9 <printf>
  exit();
  fb:	e8 17 03 00 00       	call   417 <exit>

0000000000000100 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 100:	55                   	push   %rbp
 101:	48 89 e5             	mov    %rsp,%rbp
 104:	48 83 ec 10          	sub    $0x10,%rsp
 108:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 10c:	89 75 f4             	mov    %esi,-0xc(%rbp)
 10f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 112:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 116:	8b 55 f0             	mov    -0x10(%rbp),%edx
 119:	8b 45 f4             	mov    -0xc(%rbp),%eax
 11c:	48 89 ce             	mov    %rcx,%rsi
 11f:	48 89 f7             	mov    %rsi,%rdi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld
 125:	f3 aa                	rep stos %al,%es:(%rdi)
 127:	89 ca                	mov    %ecx,%edx
 129:	48 89 fe             	mov    %rdi,%rsi
 12c:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 130:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 133:	90                   	nop
 134:	c9                   	leave
 135:	c3                   	ret

0000000000000136 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 136:	f3 0f 1e fa          	endbr64
 13a:	55                   	push   %rbp
 13b:	48 89 e5             	mov    %rsp,%rbp
 13e:	48 83 ec 20          	sub    $0x20,%rsp
 142:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 146:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 14a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 14e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 152:	90                   	nop
 153:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 157:	48 8d 42 01          	lea    0x1(%rdx),%rax
 15b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 15f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 163:	48 8d 48 01          	lea    0x1(%rax),%rcx
 167:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 16b:	0f b6 12             	movzbl (%rdx),%edx
 16e:	88 10                	mov    %dl,(%rax)
 170:	0f b6 00             	movzbl (%rax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 dc                	jne    153 <strcpy+0x1d>
    ;
  return os;
 177:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 17b:	c9                   	leave
 17c:	c3                   	ret

000000000000017d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 17d:	f3 0f 1e fa          	endbr64
 181:	55                   	push   %rbp
 182:	48 89 e5             	mov    %rsp,%rbp
 185:	48 83 ec 10          	sub    $0x10,%rsp
 189:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 18d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 191:	eb 0a                	jmp    19d <strcmp+0x20>
    p++, q++;
 193:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 198:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 19d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a1:	0f b6 00             	movzbl (%rax),%eax
 1a4:	84 c0                	test   %al,%al
 1a6:	74 12                	je     1ba <strcmp+0x3d>
 1a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1ac:	0f b6 10             	movzbl (%rax),%edx
 1af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1b3:	0f b6 00             	movzbl (%rax),%eax
 1b6:	38 c2                	cmp    %al,%dl
 1b8:	74 d9                	je     193 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 1ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1be:	0f b6 00             	movzbl (%rax),%eax
 1c1:	0f b6 d0             	movzbl %al,%edx
 1c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1c8:	0f b6 00             	movzbl (%rax),%eax
 1cb:	0f b6 c0             	movzbl %al,%eax
 1ce:	29 c2                	sub    %eax,%edx
 1d0:	89 d0                	mov    %edx,%eax
}
 1d2:	c9                   	leave
 1d3:	c3                   	ret

00000000000001d4 <strlen>:

uint
strlen(char *s)
{
 1d4:	f3 0f 1e fa          	endbr64
 1d8:	55                   	push   %rbp
 1d9:	48 89 e5             	mov    %rsp,%rbp
 1dc:	48 83 ec 18          	sub    $0x18,%rsp
 1e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 1e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1eb:	eb 04                	jmp    1f1 <strlen+0x1d>
 1ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f4:	48 63 d0             	movslq %eax,%rdx
 1f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1fb:	48 01 d0             	add    %rdx,%rax
 1fe:	0f b6 00             	movzbl (%rax),%eax
 201:	84 c0                	test   %al,%al
 203:	75 e8                	jne    1ed <strlen+0x19>
    ;
  return n;
 205:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 208:	c9                   	leave
 209:	c3                   	ret

000000000000020a <memset>:

void*
memset(void *dst, int c, uint n)
{
 20a:	f3 0f 1e fa          	endbr64
 20e:	55                   	push   %rbp
 20f:	48 89 e5             	mov    %rsp,%rbp
 212:	48 83 ec 10          	sub    $0x10,%rsp
 216:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 21a:	89 75 f4             	mov    %esi,-0xc(%rbp)
 21d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 220:	8b 55 f0             	mov    -0x10(%rbp),%edx
 223:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 226:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22a:	89 ce                	mov    %ecx,%esi
 22c:	48 89 c7             	mov    %rax,%rdi
 22f:	e8 cc fe ff ff       	call   100 <stosb>
  return dst;
 234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 238:	c9                   	leave
 239:	c3                   	ret

000000000000023a <strchr>:

char*
strchr(const char *s, char c)
{
 23a:	f3 0f 1e fa          	endbr64
 23e:	55                   	push   %rbp
 23f:	48 89 e5             	mov    %rsp,%rbp
 242:	48 83 ec 10          	sub    $0x10,%rsp
 246:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 24a:	89 f0                	mov    %esi,%eax
 24c:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 24f:	eb 17                	jmp    268 <strchr+0x2e>
    if(*s == c)
 251:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 255:	0f b6 00             	movzbl (%rax),%eax
 258:	38 45 f4             	cmp    %al,-0xc(%rbp)
 25b:	75 06                	jne    263 <strchr+0x29>
      return (char*)s;
 25d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 261:	eb 15                	jmp    278 <strchr+0x3e>
  for(; *s; s++)
 263:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 268:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 26c:	0f b6 00             	movzbl (%rax),%eax
 26f:	84 c0                	test   %al,%al
 271:	75 de                	jne    251 <strchr+0x17>
  return 0;
 273:	b8 00 00 00 00       	mov    $0x0,%eax
}
 278:	c9                   	leave
 279:	c3                   	ret

000000000000027a <gets>:

char*
gets(char *buf, int max)
{
 27a:	f3 0f 1e fa          	endbr64
 27e:	55                   	push   %rbp
 27f:	48 89 e5             	mov    %rsp,%rbp
 282:	48 83 ec 20          	sub    $0x20,%rsp
 286:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 28a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 294:	eb 48                	jmp    2de <gets+0x64>
    cc = read(0, &c, 1);
 296:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 29a:	ba 01 00 00 00       	mov    $0x1,%edx
 29f:	48 89 c6             	mov    %rax,%rsi
 2a2:	bf 00 00 00 00       	mov    $0x0,%edi
 2a7:	e8 83 01 00 00       	call   42f <read>
 2ac:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 2af:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 2b3:	7e 36                	jle    2eb <gets+0x71>
      break;
    buf[i++] = c;
 2b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2b8:	8d 50 01             	lea    0x1(%rax),%edx
 2bb:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2be:	48 63 d0             	movslq %eax,%rdx
 2c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2c5:	48 01 c2             	add    %rax,%rdx
 2c8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2cc:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 2ce:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2d2:	3c 0a                	cmp    $0xa,%al
 2d4:	74 16                	je     2ec <gets+0x72>
 2d6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2da:	3c 0d                	cmp    $0xd,%al
 2dc:	74 0e                	je     2ec <gets+0x72>
  for(i=0; i+1 < max; ){
 2de:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2e1:	83 c0 01             	add    $0x1,%eax
 2e4:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 2e7:	7f ad                	jg     296 <gets+0x1c>
 2e9:	eb 01                	jmp    2ec <gets+0x72>
      break;
 2eb:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2ef:	48 63 d0             	movslq %eax,%rdx
 2f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f6:	48 01 d0             	add    %rdx,%rax
 2f9:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 2fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 300:	c9                   	leave
 301:	c3                   	ret

0000000000000302 <stat>:

int
stat(char *n, struct stat *st)
{
 302:	f3 0f 1e fa          	endbr64
 306:	55                   	push   %rbp
 307:	48 89 e5             	mov    %rsp,%rbp
 30a:	48 83 ec 20          	sub    $0x20,%rsp
 30e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 312:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31a:	be 00 00 00 00       	mov    $0x0,%esi
 31f:	48 89 c7             	mov    %rax,%rdi
 322:	e8 30 01 00 00       	call   457 <open>
 327:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 32a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 32e:	79 07                	jns    337 <stat+0x35>
    return -1;
 330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 335:	eb 21                	jmp    358 <stat+0x56>
  r = fstat(fd, st);
 337:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 33b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 33e:	48 89 d6             	mov    %rdx,%rsi
 341:	89 c7                	mov    %eax,%edi
 343:	e8 27 01 00 00       	call   46f <fstat>
 348:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 34b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 34e:	89 c7                	mov    %eax,%edi
 350:	e8 ea 00 00 00       	call   43f <close>
  return r;
 355:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 358:	c9                   	leave
 359:	c3                   	ret

000000000000035a <atoi>:

int
atoi(const char *s)
{
 35a:	f3 0f 1e fa          	endbr64
 35e:	55                   	push   %rbp
 35f:	48 89 e5             	mov    %rsp,%rbp
 362:	48 83 ec 18          	sub    $0x18,%rsp
 366:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 36a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 371:	eb 28                	jmp    39b <atoi+0x41>
    n = n*10 + *s++ - '0';
 373:	8b 55 fc             	mov    -0x4(%rbp),%edx
 376:	89 d0                	mov    %edx,%eax
 378:	c1 e0 02             	shl    $0x2,%eax
 37b:	01 d0                	add    %edx,%eax
 37d:	01 c0                	add    %eax,%eax
 37f:	89 c1                	mov    %eax,%ecx
 381:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 385:	48 8d 50 01          	lea    0x1(%rax),%rdx
 389:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 38d:	0f b6 00             	movzbl (%rax),%eax
 390:	0f be c0             	movsbl %al,%eax
 393:	01 c8                	add    %ecx,%eax
 395:	83 e8 30             	sub    $0x30,%eax
 398:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 39b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 39f:	0f b6 00             	movzbl (%rax),%eax
 3a2:	3c 2f                	cmp    $0x2f,%al
 3a4:	7e 0b                	jle    3b1 <atoi+0x57>
 3a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3aa:	0f b6 00             	movzbl (%rax),%eax
 3ad:	3c 39                	cmp    $0x39,%al
 3af:	7e c2                	jle    373 <atoi+0x19>
  return n;
 3b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 3b4:	c9                   	leave
 3b5:	c3                   	ret

00000000000003b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b6:	f3 0f 1e fa          	endbr64
 3ba:	55                   	push   %rbp
 3bb:	48 89 e5             	mov    %rsp,%rbp
 3be:	48 83 ec 28          	sub    $0x28,%rsp
 3c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3c6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3ca:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 3cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 3d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 3d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 3dd:	eb 1d                	jmp    3fc <memmove+0x46>
    *dst++ = *src++;
 3df:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 3e3:	48 8d 42 01          	lea    0x1(%rdx),%rax
 3e7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 3eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3ef:	48 8d 48 01          	lea    0x1(%rax),%rcx
 3f3:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 3f7:	0f b6 12             	movzbl (%rdx),%edx
 3fa:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 3fc:	8b 45 dc             	mov    -0x24(%rbp),%eax
 3ff:	8d 50 ff             	lea    -0x1(%rax),%edx
 402:	89 55 dc             	mov    %edx,-0x24(%rbp)
 405:	85 c0                	test   %eax,%eax
 407:	7f d6                	jg     3df <memmove+0x29>
  return vdst;
 409:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 40d:	c9                   	leave
 40e:	c3                   	ret

000000000000040f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 40f:	b8 01 00 00 00       	mov    $0x1,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <exit>:
SYSCALL(exit)
 417:	b8 02 00 00 00       	mov    $0x2,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <wait>:
SYSCALL(wait)
 41f:	b8 03 00 00 00       	mov    $0x3,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

0000000000000427 <pipe>:
SYSCALL(pipe)
 427:	b8 04 00 00 00       	mov    $0x4,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

000000000000042f <read>:
SYSCALL(read)
 42f:	b8 05 00 00 00       	mov    $0x5,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

0000000000000437 <write>:
SYSCALL(write)
 437:	b8 10 00 00 00       	mov    $0x10,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

000000000000043f <close>:
SYSCALL(close)
 43f:	b8 15 00 00 00       	mov    $0x15,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret

0000000000000447 <kill>:
SYSCALL(kill)
 447:	b8 06 00 00 00       	mov    $0x6,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret

000000000000044f <exec>:
SYSCALL(exec)
 44f:	b8 07 00 00 00       	mov    $0x7,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret

0000000000000457 <open>:
SYSCALL(open)
 457:	b8 0f 00 00 00       	mov    $0xf,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret

000000000000045f <mknod>:
SYSCALL(mknod)
 45f:	b8 11 00 00 00       	mov    $0x11,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret

0000000000000467 <unlink>:
SYSCALL(unlink)
 467:	b8 12 00 00 00       	mov    $0x12,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret

000000000000046f <fstat>:
SYSCALL(fstat)
 46f:	b8 08 00 00 00       	mov    $0x8,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret

0000000000000477 <link>:
SYSCALL(link)
 477:	b8 13 00 00 00       	mov    $0x13,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret

000000000000047f <mkdir>:
SYSCALL(mkdir)
 47f:	b8 14 00 00 00       	mov    $0x14,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret

0000000000000487 <chdir>:
SYSCALL(chdir)
 487:	b8 09 00 00 00       	mov    $0x9,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret

000000000000048f <dup>:
SYSCALL(dup)
 48f:	b8 0a 00 00 00       	mov    $0xa,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret

0000000000000497 <getpid>:
SYSCALL(getpid)
 497:	b8 0b 00 00 00       	mov    $0xb,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret

000000000000049f <sbrk>:
SYSCALL(sbrk)
 49f:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret

00000000000004a7 <sleep>:
SYSCALL(sleep)
 4a7:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret

00000000000004af <uptime>:
SYSCALL(uptime)
 4af:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret

00000000000004b7 <getpinfo>:
SYSCALL(getpinfo)
 4b7:	b8 18 00 00 00       	mov    $0x18,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret

00000000000004bf <settickets>:
SYSCALL(settickets)
 4bf:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret

00000000000004c7 <getfavnum>:
SYSCALL(getfavnum)
 4c7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret

00000000000004cf <halt>:
SYSCALL(halt)
 4cf:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret

00000000000004d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d7:	f3 0f 1e fa          	endbr64
 4db:	55                   	push   %rbp
 4dc:	48 89 e5             	mov    %rsp,%rbp
 4df:	48 83 ec 10          	sub    $0x10,%rsp
 4e3:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4e6:	89 f0                	mov    %esi,%eax
 4e8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4eb:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f2:	ba 01 00 00 00       	mov    $0x1,%edx
 4f7:	48 89 ce             	mov    %rcx,%rsi
 4fa:	89 c7                	mov    %eax,%edi
 4fc:	e8 36 ff ff ff       	call   437 <write>
}
 501:	90                   	nop
 502:	c9                   	leave
 503:	c3                   	ret

0000000000000504 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 504:	f3 0f 1e fa          	endbr64
 508:	55                   	push   %rbp
 509:	48 89 e5             	mov    %rsp,%rbp
 50c:	48 83 ec 30          	sub    $0x30,%rsp
 510:	89 7d dc             	mov    %edi,-0x24(%rbp)
 513:	89 75 d8             	mov    %esi,-0x28(%rbp)
 516:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 519:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 51c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 523:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 527:	74 17                	je     540 <printint+0x3c>
 529:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 52d:	79 11                	jns    540 <printint+0x3c>
    neg = 1;
 52f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 536:	8b 45 d8             	mov    -0x28(%rbp),%eax
 539:	f7 d8                	neg    %eax
 53b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 53e:	eb 06                	jmp    546 <printint+0x42>
  } else {
    x = xx;
 540:	8b 45 d8             	mov    -0x28(%rbp),%eax
 543:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 54d:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 550:	8b 45 f4             	mov    -0xc(%rbp),%eax
 553:	ba 00 00 00 00       	mov    $0x0,%edx
 558:	f7 f6                	div    %esi
 55a:	89 d1                	mov    %edx,%ecx
 55c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 55f:	8d 50 01             	lea    0x1(%rax),%edx
 562:	89 55 fc             	mov    %edx,-0x4(%rbp)
 565:	89 ca                	mov    %ecx,%edx
 567:	0f b6 92 50 0e 00 00 	movzbl 0xe50(%rdx),%edx
 56e:	48 98                	cltq
 570:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 574:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 577:	8b 45 f4             	mov    -0xc(%rbp),%eax
 57a:	ba 00 00 00 00       	mov    $0x0,%edx
 57f:	f7 f7                	div    %edi
 581:	89 45 f4             	mov    %eax,-0xc(%rbp)
 584:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 588:	75 c3                	jne    54d <printint+0x49>
  if(neg)
 58a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 58e:	74 2b                	je     5bb <printint+0xb7>
    buf[i++] = '-';
 590:	8b 45 fc             	mov    -0x4(%rbp),%eax
 593:	8d 50 01             	lea    0x1(%rax),%edx
 596:	89 55 fc             	mov    %edx,-0x4(%rbp)
 599:	48 98                	cltq
 59b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5a0:	eb 19                	jmp    5bb <printint+0xb7>
    putc(fd, buf[i]);
 5a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5a5:	48 98                	cltq
 5a7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5ac:	0f be d0             	movsbl %al,%edx
 5af:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5b2:	89 d6                	mov    %edx,%esi
 5b4:	89 c7                	mov    %eax,%edi
 5b6:	e8 1c ff ff ff       	call   4d7 <putc>
  while(--i >= 0)
 5bb:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5c3:	79 dd                	jns    5a2 <printint+0x9e>
}
 5c5:	90                   	nop
 5c6:	90                   	nop
 5c7:	c9                   	leave
 5c8:	c3                   	ret

00000000000005c9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c9:	f3 0f 1e fa          	endbr64
 5cd:	55                   	push   %rbp
 5ce:	48 89 e5             	mov    %rsp,%rbp
 5d1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5d8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5de:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5e5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5ec:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5f3:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5fa:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 601:	84 c0                	test   %al,%al
 603:	74 20                	je     625 <printf+0x5c>
 605:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 609:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 60d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 611:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 615:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 619:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 61d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 621:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 625:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 62c:	00 00 00 
 62f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 636:	00 00 00 
 639:	48 8d 45 10          	lea    0x10(%rbp),%rax
 63d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 644:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 64b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 652:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 659:	00 00 00 
  for(i = 0; fmt[i]; i++){
 65c:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 663:	00 00 00 
 666:	e9 a8 02 00 00       	jmp    913 <printf+0x34a>
    c = fmt[i] & 0xff;
 66b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 671:	48 63 d0             	movslq %eax,%rdx
 674:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 67b:	48 01 d0             	add    %rdx,%rax
 67e:	0f b6 00             	movzbl (%rax),%eax
 681:	0f be c0             	movsbl %al,%eax
 684:	25 ff 00 00 00       	and    $0xff,%eax
 689:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 68f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 696:	75 35                	jne    6cd <printf+0x104>
      if(c == '%'){
 698:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 69f:	75 0f                	jne    6b0 <printf+0xe7>
        state = '%';
 6a1:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6a8:	00 00 00 
 6ab:	e9 5c 02 00 00       	jmp    90c <printf+0x343>
      } else {
        putc(fd, c);
 6b0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6b6:	0f be d0             	movsbl %al,%edx
 6b9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6bf:	89 d6                	mov    %edx,%esi
 6c1:	89 c7                	mov    %eax,%edi
 6c3:	e8 0f fe ff ff       	call   4d7 <putc>
 6c8:	e9 3f 02 00 00       	jmp    90c <printf+0x343>
      }
    } else if(state == '%'){
 6cd:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6d4:	0f 85 32 02 00 00    	jne    90c <printf+0x343>
      if(c == 'd'){
 6da:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6e1:	75 5e                	jne    741 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 6e3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e9:	83 f8 2f             	cmp    $0x2f,%eax
 6ec:	77 23                	ja     711 <printf+0x148>
 6ee:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fb:	89 d2                	mov    %edx,%edx
 6fd:	48 01 d0             	add    %rdx,%rax
 700:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 706:	83 c2 08             	add    $0x8,%edx
 709:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 70f:	eb 12                	jmp    723 <printf+0x15a>
 711:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 718:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 723:	8b 30                	mov    (%rax),%esi
 725:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 72b:	b9 01 00 00 00       	mov    $0x1,%ecx
 730:	ba 0a 00 00 00       	mov    $0xa,%edx
 735:	89 c7                	mov    %eax,%edi
 737:	e8 c8 fd ff ff       	call   504 <printint>
 73c:	e9 c1 01 00 00       	jmp    902 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 741:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 748:	74 09                	je     753 <printf+0x18a>
 74a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 751:	75 5e                	jne    7b1 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 753:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 759:	83 f8 2f             	cmp    $0x2f,%eax
 75c:	77 23                	ja     781 <printf+0x1b8>
 75e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 765:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76b:	89 d2                	mov    %edx,%edx
 76d:	48 01 d0             	add    %rdx,%rax
 770:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 776:	83 c2 08             	add    $0x8,%edx
 779:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77f:	eb 12                	jmp    793 <printf+0x1ca>
 781:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 788:	48 8d 50 08          	lea    0x8(%rax),%rdx
 78c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 793:	8b 30                	mov    (%rax),%esi
 795:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 79b:	b9 00 00 00 00       	mov    $0x0,%ecx
 7a0:	ba 10 00 00 00       	mov    $0x10,%edx
 7a5:	89 c7                	mov    %eax,%edi
 7a7:	e8 58 fd ff ff       	call   504 <printint>
 7ac:	e9 51 01 00 00       	jmp    902 <printf+0x339>
      } else if(c == 's'){
 7b1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7b8:	0f 85 98 00 00 00    	jne    856 <printf+0x28d>
        s = va_arg(ap, char*);
 7be:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7c4:	83 f8 2f             	cmp    $0x2f,%eax
 7c7:	77 23                	ja     7ec <printf+0x223>
 7c9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7d0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d6:	89 d2                	mov    %edx,%edx
 7d8:	48 01 d0             	add    %rdx,%rax
 7db:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e1:	83 c2 08             	add    $0x8,%edx
 7e4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7ea:	eb 12                	jmp    7fe <printf+0x235>
 7ec:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7f3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7f7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7fe:	48 8b 00             	mov    (%rax),%rax
 801:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 808:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 80f:	00 
 810:	75 31                	jne    843 <printf+0x27a>
          s = "(null)";
 812:	48 c7 85 48 ff ff ff 	movq   $0xc10,-0xb8(%rbp)
 819:	10 0c 00 00 
        while(*s != 0){
 81d:	eb 24                	jmp    843 <printf+0x27a>
          putc(fd, *s);
 81f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 826:	0f b6 00             	movzbl (%rax),%eax
 829:	0f be d0             	movsbl %al,%edx
 82c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 832:	89 d6                	mov    %edx,%esi
 834:	89 c7                	mov    %eax,%edi
 836:	e8 9c fc ff ff       	call   4d7 <putc>
          s++;
 83b:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 842:	01 
        while(*s != 0){
 843:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 84a:	0f b6 00             	movzbl (%rax),%eax
 84d:	84 c0                	test   %al,%al
 84f:	75 ce                	jne    81f <printf+0x256>
 851:	e9 ac 00 00 00       	jmp    902 <printf+0x339>
        }
      } else if(c == 'c'){
 856:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 85d:	75 56                	jne    8b5 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 85f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 865:	83 f8 2f             	cmp    $0x2f,%eax
 868:	77 23                	ja     88d <printf+0x2c4>
 86a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 871:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 877:	89 d2                	mov    %edx,%edx
 879:	48 01 d0             	add    %rdx,%rax
 87c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 882:	83 c2 08             	add    $0x8,%edx
 885:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 88b:	eb 12                	jmp    89f <printf+0x2d6>
 88d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 894:	48 8d 50 08          	lea    0x8(%rax),%rdx
 898:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 89f:	8b 00                	mov    (%rax),%eax
 8a1:	0f be d0             	movsbl %al,%edx
 8a4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8aa:	89 d6                	mov    %edx,%esi
 8ac:	89 c7                	mov    %eax,%edi
 8ae:	e8 24 fc ff ff       	call   4d7 <putc>
 8b3:	eb 4d                	jmp    902 <printf+0x339>
      } else if(c == '%'){
 8b5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8bc:	75 1a                	jne    8d8 <printf+0x30f>
        putc(fd, c);
 8be:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8c4:	0f be d0             	movsbl %al,%edx
 8c7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8cd:	89 d6                	mov    %edx,%esi
 8cf:	89 c7                	mov    %eax,%edi
 8d1:	e8 01 fc ff ff       	call   4d7 <putc>
 8d6:	eb 2a                	jmp    902 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8de:	be 25 00 00 00       	mov    $0x25,%esi
 8e3:	89 c7                	mov    %eax,%edi
 8e5:	e8 ed fb ff ff       	call   4d7 <putc>
        putc(fd, c);
 8ea:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8f0:	0f be d0             	movsbl %al,%edx
 8f3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8f9:	89 d6                	mov    %edx,%esi
 8fb:	89 c7                	mov    %eax,%edi
 8fd:	e8 d5 fb ff ff       	call   4d7 <putc>
      }
      state = 0;
 902:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 909:	00 00 00 
  for(i = 0; fmt[i]; i++){
 90c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 913:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 919:	48 63 d0             	movslq %eax,%rdx
 91c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 923:	48 01 d0             	add    %rdx,%rax
 926:	0f b6 00             	movzbl (%rax),%eax
 929:	84 c0                	test   %al,%al
 92b:	0f 85 3a fd ff ff    	jne    66b <printf+0xa2>
    }
  }
}
 931:	90                   	nop
 932:	90                   	nop
 933:	c9                   	leave
 934:	c3                   	ret

0000000000000935 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 935:	f3 0f 1e fa          	endbr64
 939:	55                   	push   %rbp
 93a:	48 89 e5             	mov    %rsp,%rbp
 93d:	48 83 ec 18          	sub    $0x18,%rsp
 941:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 945:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 949:	48 83 e8 10          	sub    $0x10,%rax
 94d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	48 8b 05 28 05 00 00 	mov    0x528(%rip),%rax        # e80 <freep>
 958:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 95c:	eb 2f                	jmp    98d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 962:	48 8b 00             	mov    (%rax),%rax
 965:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 969:	72 17                	jb     982 <free+0x4d>
 96b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 973:	72 2f                	jb     9a4 <free+0x6f>
 975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 979:	48 8b 00             	mov    (%rax),%rax
 97c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 980:	72 22                	jb     9a4 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 986:	48 8b 00             	mov    (%rax),%rax
 989:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 98d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 991:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 995:	73 c7                	jae    95e <free+0x29>
 997:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99b:	48 8b 00             	mov    (%rax),%rax
 99e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9a2:	73 ba                	jae    95e <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a8:	8b 40 08             	mov    0x8(%rax),%eax
 9ab:	89 c0                	mov    %eax,%eax
 9ad:	48 c1 e0 04          	shl    $0x4,%rax
 9b1:	48 89 c2             	mov    %rax,%rdx
 9b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b8:	48 01 c2             	add    %rax,%rdx
 9bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bf:	48 8b 00             	mov    (%rax),%rax
 9c2:	48 39 c2             	cmp    %rax,%rdx
 9c5:	75 2d                	jne    9f4 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9cb:	8b 50 08             	mov    0x8(%rax),%edx
 9ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d2:	48 8b 00             	mov    (%rax),%rax
 9d5:	8b 40 08             	mov    0x8(%rax),%eax
 9d8:	01 c2                	add    %eax,%edx
 9da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9de:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e5:	48 8b 00             	mov    (%rax),%rax
 9e8:	48 8b 10             	mov    (%rax),%rdx
 9eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ef:	48 89 10             	mov    %rdx,(%rax)
 9f2:	eb 0e                	jmp    a02 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 9f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f8:	48 8b 10             	mov    (%rax),%rdx
 9fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ff:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a06:	8b 40 08             	mov    0x8(%rax),%eax
 a09:	89 c0                	mov    %eax,%eax
 a0b:	48 c1 e0 04          	shl    $0x4,%rax
 a0f:	48 89 c2             	mov    %rax,%rdx
 a12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a16:	48 01 d0             	add    %rdx,%rax
 a19:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a1d:	75 27                	jne    a46 <free+0x111>
    p->s.size += bp->s.size;
 a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a23:	8b 50 08             	mov    0x8(%rax),%edx
 a26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2a:	8b 40 08             	mov    0x8(%rax),%eax
 a2d:	01 c2                	add    %eax,%edx
 a2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a33:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3a:	48 8b 10             	mov    (%rax),%rdx
 a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a41:	48 89 10             	mov    %rdx,(%rax)
 a44:	eb 0b                	jmp    a51 <free+0x11c>
  } else
    p->s.ptr = bp;
 a46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a4e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a55:	48 89 05 24 04 00 00 	mov    %rax,0x424(%rip)        # e80 <freep>
}
 a5c:	90                   	nop
 a5d:	c9                   	leave
 a5e:	c3                   	ret

0000000000000a5f <morecore>:

static Header*
morecore(uint nu)
{
 a5f:	f3 0f 1e fa          	endbr64
 a63:	55                   	push   %rbp
 a64:	48 89 e5             	mov    %rsp,%rbp
 a67:	48 83 ec 20          	sub    $0x20,%rsp
 a6b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a6e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a75:	77 07                	ja     a7e <morecore+0x1f>
    nu = 4096;
 a77:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a81:	c1 e0 04             	shl    $0x4,%eax
 a84:	89 c7                	mov    %eax,%edi
 a86:	e8 14 fa ff ff       	call   49f <sbrk>
 a8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a8f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a94:	75 07                	jne    a9d <morecore+0x3e>
    return 0;
 a96:	b8 00 00 00 00       	mov    $0x0,%eax
 a9b:	eb 29                	jmp    ac6 <morecore+0x67>
  hp = (Header*)p;
 a9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 aa5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aac:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 aaf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab3:	48 83 c0 10          	add    $0x10,%rax
 ab7:	48 89 c7             	mov    %rax,%rdi
 aba:	e8 76 fe ff ff       	call   935 <free>
  return freep;
 abf:	48 8b 05 ba 03 00 00 	mov    0x3ba(%rip),%rax        # e80 <freep>
}
 ac6:	c9                   	leave
 ac7:	c3                   	ret

0000000000000ac8 <malloc>:

void*
malloc(uint nbytes)
{
 ac8:	f3 0f 1e fa          	endbr64
 acc:	55                   	push   %rbp
 acd:	48 89 e5             	mov    %rsp,%rbp
 ad0:	48 83 ec 30          	sub    $0x30,%rsp
 ad4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ad7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 ada:	48 83 c0 0f          	add    $0xf,%rax
 ade:	48 c1 e8 04          	shr    $0x4,%rax
 ae2:	83 c0 01             	add    $0x1,%eax
 ae5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 ae8:	48 8b 05 91 03 00 00 	mov    0x391(%rip),%rax        # e80 <freep>
 aef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 af3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 af8:	75 2b                	jne    b25 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 afa:	48 c7 45 f0 70 0e 00 	movq   $0xe70,-0x10(%rbp)
 b01:	00 
 b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b06:	48 89 05 73 03 00 00 	mov    %rax,0x373(%rip)        # e80 <freep>
 b0d:	48 8b 05 6c 03 00 00 	mov    0x36c(%rip),%rax        # e80 <freep>
 b14:	48 89 05 55 03 00 00 	mov    %rax,0x355(%rip)        # e70 <base>
    base.s.size = 0;
 b1b:	c7 05 53 03 00 00 00 	movl   $0x0,0x353(%rip)        # e78 <base+0x8>
 b22:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b29:	48 8b 00             	mov    (%rax),%rax
 b2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b34:	8b 40 08             	mov    0x8(%rax),%eax
 b37:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b3a:	72 5f                	jb     b9b <malloc+0xd3>
      if(p->s.size == nunits)
 b3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b40:	8b 40 08             	mov    0x8(%rax),%eax
 b43:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b46:	75 10                	jne    b58 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4c:	48 8b 10             	mov    (%rax),%rdx
 b4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b53:	48 89 10             	mov    %rdx,(%rax)
 b56:	eb 2e                	jmp    b86 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5c:	8b 40 08             	mov    0x8(%rax),%eax
 b5f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b62:	89 c2                	mov    %eax,%edx
 b64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b68:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6f:	8b 40 08             	mov    0x8(%rax),%eax
 b72:	89 c0                	mov    %eax,%eax
 b74:	48 c1 e0 04          	shl    $0x4,%rax
 b78:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b80:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b83:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b8a:	48 89 05 ef 02 00 00 	mov    %rax,0x2ef(%rip)        # e80 <freep>
      return (void*)(p + 1);
 b91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b95:	48 83 c0 10          	add    $0x10,%rax
 b99:	eb 41                	jmp    bdc <malloc+0x114>
    }
    if(p == freep)
 b9b:	48 8b 05 de 02 00 00 	mov    0x2de(%rip),%rax        # e80 <freep>
 ba2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ba6:	75 1c                	jne    bc4 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ba8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bab:	89 c7                	mov    %eax,%edi
 bad:	e8 ad fe ff ff       	call   a5f <morecore>
 bb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bb6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bbb:	75 07                	jne    bc4 <malloc+0xfc>
        return 0;
 bbd:	b8 00 00 00 00       	mov    $0x0,%eax
 bc2:	eb 18                	jmp    bdc <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd0:	48 8b 00             	mov    (%rax),%rax
 bd3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bd7:	e9 54 ff ff ff       	jmp    b30 <malloc+0x68>
  }
}
 bdc:	c9                   	leave
 bdd:	c3                   	ret
