
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
  35:	48 c7 c6 d8 0b 00 00 	mov    $0xbd8,%rsi
  3c:	bf 02 00 00 00       	mov    $0x2,%edi
  41:	b8 00 00 00 00       	mov    $0x0,%eax
  46:	e8 76 05 00 00       	call   5c1 <printf>
    exit();
  4b:	e8 c7 03 00 00       	call   417 <exit>
  }

  while(time > 0){
    printf(2, "%d\n", time);
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	89 c2                	mov    %eax,%edx
  55:	48 c7 c6 fd 0b 00 00 	mov    $0xbfd,%rsi
  5c:	bf 02 00 00 00       	mov    $0x2,%edi
  61:	b8 00 00 00 00       	mov    $0x0,%eax
  66:	e8 56 05 00 00       	call   5c1 <printf>
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
  a2:	48 c7 c6 01 0c 00 00 	mov    $0xc01,%rsi
  a9:	bf 02 00 00 00       	mov    $0x2,%edi
  ae:	b8 00 00 00 00       	mov    $0x0,%eax
  b3:	e8 09 05 00 00       	call   5c1 <printf>
    if(i < argc - 1){
  b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  bb:	83 e8 01             	sub    $0x1,%eax
  be:	39 45 f8             	cmp    %eax,-0x8(%rbp)
  c1:	7d 16                	jge    d9 <main+0xd9>
      printf(2, " ");
  c3:	48 c7 c6 04 0c 00 00 	mov    $0xc04,%rsi
  ca:	bf 02 00 00 00       	mov    $0x2,%edi
  cf:	b8 00 00 00 00       	mov    $0x0,%eax
  d4:	e8 e8 04 00 00       	call   5c1 <printf>
  for(int i = 2; i < argc; i++){
  d9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  e3:	7c a3                	jl     88 <main+0x88>
    }
  }
  printf(2, "\n");
  e5:	48 c7 c6 06 0c 00 00 	mov    $0xc06,%rsi
  ec:	bf 02 00 00 00       	mov    $0x2,%edi
  f1:	b8 00 00 00 00       	mov    $0x0,%eax
  f6:	e8 c6 04 00 00       	call   5c1 <printf>
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

00000000000004cf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4cf:	f3 0f 1e fa          	endbr64
 4d3:	55                   	push   %rbp
 4d4:	48 89 e5             	mov    %rsp,%rbp
 4d7:	48 83 ec 10          	sub    $0x10,%rsp
 4db:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4de:	89 f0                	mov    %esi,%eax
 4e0:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4e3:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ea:	ba 01 00 00 00       	mov    $0x1,%edx
 4ef:	48 89 ce             	mov    %rcx,%rsi
 4f2:	89 c7                	mov    %eax,%edi
 4f4:	e8 3e ff ff ff       	call   437 <write>
}
 4f9:	90                   	nop
 4fa:	c9                   	leave
 4fb:	c3                   	ret

00000000000004fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fc:	f3 0f 1e fa          	endbr64
 500:	55                   	push   %rbp
 501:	48 89 e5             	mov    %rsp,%rbp
 504:	48 83 ec 30          	sub    $0x30,%rsp
 508:	89 7d dc             	mov    %edi,-0x24(%rbp)
 50b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 50e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 511:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 514:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 51b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 51f:	74 17                	je     538 <printint+0x3c>
 521:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 525:	79 11                	jns    538 <printint+0x3c>
    neg = 1;
 527:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 52e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 531:	f7 d8                	neg    %eax
 533:	89 45 f4             	mov    %eax,-0xc(%rbp)
 536:	eb 06                	jmp    53e <printint+0x42>
  } else {
    x = xx;
 538:	8b 45 d8             	mov    -0x28(%rbp),%eax
 53b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 53e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 545:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 548:	8b 45 f4             	mov    -0xc(%rbp),%eax
 54b:	ba 00 00 00 00       	mov    $0x0,%edx
 550:	f7 f6                	div    %esi
 552:	89 d1                	mov    %edx,%ecx
 554:	8b 45 fc             	mov    -0x4(%rbp),%eax
 557:	8d 50 01             	lea    0x1(%rax),%edx
 55a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 55d:	89 ca                	mov    %ecx,%edx
 55f:	0f b6 92 50 0e 00 00 	movzbl 0xe50(%rdx),%edx
 566:	48 98                	cltq
 568:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 56c:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 56f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 572:	ba 00 00 00 00       	mov    $0x0,%edx
 577:	f7 f7                	div    %edi
 579:	89 45 f4             	mov    %eax,-0xc(%rbp)
 57c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 580:	75 c3                	jne    545 <printint+0x49>
  if(neg)
 582:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 586:	74 2b                	je     5b3 <printint+0xb7>
    buf[i++] = '-';
 588:	8b 45 fc             	mov    -0x4(%rbp),%eax
 58b:	8d 50 01             	lea    0x1(%rax),%edx
 58e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 591:	48 98                	cltq
 593:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 598:	eb 19                	jmp    5b3 <printint+0xb7>
    putc(fd, buf[i]);
 59a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 59d:	48 98                	cltq
 59f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5a4:	0f be d0             	movsbl %al,%edx
 5a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5aa:	89 d6                	mov    %edx,%esi
 5ac:	89 c7                	mov    %eax,%edi
 5ae:	e8 1c ff ff ff       	call   4cf <putc>
  while(--i >= 0)
 5b3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5bb:	79 dd                	jns    59a <printint+0x9e>
}
 5bd:	90                   	nop
 5be:	90                   	nop
 5bf:	c9                   	leave
 5c0:	c3                   	ret

00000000000005c1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c1:	f3 0f 1e fa          	endbr64
 5c5:	55                   	push   %rbp
 5c6:	48 89 e5             	mov    %rsp,%rbp
 5c9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5d0:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5d6:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5dd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5e4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5eb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5f2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5f9:	84 c0                	test   %al,%al
 5fb:	74 20                	je     61d <printf+0x5c>
 5fd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 601:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 605:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 609:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 60d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 611:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 615:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 619:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 61d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 624:	00 00 00 
 627:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 62e:	00 00 00 
 631:	48 8d 45 10          	lea    0x10(%rbp),%rax
 635:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 63c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 643:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 64a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 651:	00 00 00 
  for(i = 0; fmt[i]; i++){
 654:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 65b:	00 00 00 
 65e:	e9 a8 02 00 00       	jmp    90b <printf+0x34a>
    c = fmt[i] & 0xff;
 663:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 669:	48 63 d0             	movslq %eax,%rdx
 66c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 673:	48 01 d0             	add    %rdx,%rax
 676:	0f b6 00             	movzbl (%rax),%eax
 679:	0f be c0             	movsbl %al,%eax
 67c:	25 ff 00 00 00       	and    $0xff,%eax
 681:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 687:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 68e:	75 35                	jne    6c5 <printf+0x104>
      if(c == '%'){
 690:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 697:	75 0f                	jne    6a8 <printf+0xe7>
        state = '%';
 699:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6a0:	00 00 00 
 6a3:	e9 5c 02 00 00       	jmp    904 <printf+0x343>
      } else {
        putc(fd, c);
 6a8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6ae:	0f be d0             	movsbl %al,%edx
 6b1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b7:	89 d6                	mov    %edx,%esi
 6b9:	89 c7                	mov    %eax,%edi
 6bb:	e8 0f fe ff ff       	call   4cf <putc>
 6c0:	e9 3f 02 00 00       	jmp    904 <printf+0x343>
      }
    } else if(state == '%'){
 6c5:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6cc:	0f 85 32 02 00 00    	jne    904 <printf+0x343>
      if(c == 'd'){
 6d2:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6d9:	75 5e                	jne    739 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 6db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6e1:	83 f8 2f             	cmp    $0x2f,%eax
 6e4:	77 23                	ja     709 <printf+0x148>
 6e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f3:	89 d2                	mov    %edx,%edx
 6f5:	48 01 d0             	add    %rdx,%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	83 c2 08             	add    $0x8,%edx
 701:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 707:	eb 12                	jmp    71b <printf+0x15a>
 709:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 710:	48 8d 50 08          	lea    0x8(%rax),%rdx
 714:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 71b:	8b 30                	mov    (%rax),%esi
 71d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 723:	b9 01 00 00 00       	mov    $0x1,%ecx
 728:	ba 0a 00 00 00       	mov    $0xa,%edx
 72d:	89 c7                	mov    %eax,%edi
 72f:	e8 c8 fd ff ff       	call   4fc <printint>
 734:	e9 c1 01 00 00       	jmp    8fa <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 739:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 740:	74 09                	je     74b <printf+0x18a>
 742:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 749:	75 5e                	jne    7a9 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 74b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 751:	83 f8 2f             	cmp    $0x2f,%eax
 754:	77 23                	ja     779 <printf+0x1b8>
 756:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 75d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 763:	89 d2                	mov    %edx,%edx
 765:	48 01 d0             	add    %rdx,%rax
 768:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76e:	83 c2 08             	add    $0x8,%edx
 771:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 777:	eb 12                	jmp    78b <printf+0x1ca>
 779:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 780:	48 8d 50 08          	lea    0x8(%rax),%rdx
 784:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 78b:	8b 30                	mov    (%rax),%esi
 78d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 793:	b9 00 00 00 00       	mov    $0x0,%ecx
 798:	ba 10 00 00 00       	mov    $0x10,%edx
 79d:	89 c7                	mov    %eax,%edi
 79f:	e8 58 fd ff ff       	call   4fc <printint>
 7a4:	e9 51 01 00 00       	jmp    8fa <printf+0x339>
      } else if(c == 's'){
 7a9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7b0:	0f 85 98 00 00 00    	jne    84e <printf+0x28d>
        s = va_arg(ap, char*);
 7b6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7bc:	83 f8 2f             	cmp    $0x2f,%eax
 7bf:	77 23                	ja     7e4 <printf+0x223>
 7c1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7c8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ce:	89 d2                	mov    %edx,%edx
 7d0:	48 01 d0             	add    %rdx,%rax
 7d3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d9:	83 c2 08             	add    $0x8,%edx
 7dc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7e2:	eb 12                	jmp    7f6 <printf+0x235>
 7e4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7eb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7ef:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7f6:	48 8b 00             	mov    (%rax),%rax
 7f9:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 800:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 807:	00 
 808:	75 31                	jne    83b <printf+0x27a>
          s = "(null)";
 80a:	48 c7 85 48 ff ff ff 	movq   $0xc08,-0xb8(%rbp)
 811:	08 0c 00 00 
        while(*s != 0){
 815:	eb 24                	jmp    83b <printf+0x27a>
          putc(fd, *s);
 817:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 81e:	0f b6 00             	movzbl (%rax),%eax
 821:	0f be d0             	movsbl %al,%edx
 824:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 82a:	89 d6                	mov    %edx,%esi
 82c:	89 c7                	mov    %eax,%edi
 82e:	e8 9c fc ff ff       	call   4cf <putc>
          s++;
 833:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 83a:	01 
        while(*s != 0){
 83b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 842:	0f b6 00             	movzbl (%rax),%eax
 845:	84 c0                	test   %al,%al
 847:	75 ce                	jne    817 <printf+0x256>
 849:	e9 ac 00 00 00       	jmp    8fa <printf+0x339>
        }
      } else if(c == 'c'){
 84e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 855:	75 56                	jne    8ad <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 857:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 85d:	83 f8 2f             	cmp    $0x2f,%eax
 860:	77 23                	ja     885 <printf+0x2c4>
 862:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 869:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 86f:	89 d2                	mov    %edx,%edx
 871:	48 01 d0             	add    %rdx,%rax
 874:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 87a:	83 c2 08             	add    $0x8,%edx
 87d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 883:	eb 12                	jmp    897 <printf+0x2d6>
 885:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 88c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 890:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 897:	8b 00                	mov    (%rax),%eax
 899:	0f be d0             	movsbl %al,%edx
 89c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8a2:	89 d6                	mov    %edx,%esi
 8a4:	89 c7                	mov    %eax,%edi
 8a6:	e8 24 fc ff ff       	call   4cf <putc>
 8ab:	eb 4d                	jmp    8fa <printf+0x339>
      } else if(c == '%'){
 8ad:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8b4:	75 1a                	jne    8d0 <printf+0x30f>
        putc(fd, c);
 8b6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8bc:	0f be d0             	movsbl %al,%edx
 8bf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8c5:	89 d6                	mov    %edx,%esi
 8c7:	89 c7                	mov    %eax,%edi
 8c9:	e8 01 fc ff ff       	call   4cf <putc>
 8ce:	eb 2a                	jmp    8fa <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8d6:	be 25 00 00 00       	mov    $0x25,%esi
 8db:	89 c7                	mov    %eax,%edi
 8dd:	e8 ed fb ff ff       	call   4cf <putc>
        putc(fd, c);
 8e2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8e8:	0f be d0             	movsbl %al,%edx
 8eb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8f1:	89 d6                	mov    %edx,%esi
 8f3:	89 c7                	mov    %eax,%edi
 8f5:	e8 d5 fb ff ff       	call   4cf <putc>
      }
      state = 0;
 8fa:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 901:	00 00 00 
  for(i = 0; fmt[i]; i++){
 904:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 90b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 911:	48 63 d0             	movslq %eax,%rdx
 914:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 91b:	48 01 d0             	add    %rdx,%rax
 91e:	0f b6 00             	movzbl (%rax),%eax
 921:	84 c0                	test   %al,%al
 923:	0f 85 3a fd ff ff    	jne    663 <printf+0xa2>
    }
  }
}
 929:	90                   	nop
 92a:	90                   	nop
 92b:	c9                   	leave
 92c:	c3                   	ret

000000000000092d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92d:	f3 0f 1e fa          	endbr64
 931:	55                   	push   %rbp
 932:	48 89 e5             	mov    %rsp,%rbp
 935:	48 83 ec 18          	sub    $0x18,%rsp
 939:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 941:	48 83 e8 10          	sub    $0x10,%rax
 945:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 949:	48 8b 05 30 05 00 00 	mov    0x530(%rip),%rax        # e80 <freep>
 950:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 954:	eb 2f                	jmp    985 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 8b 00             	mov    (%rax),%rax
 95d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 961:	72 17                	jb     97a <free+0x4d>
 963:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 967:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 96b:	72 2f                	jb     99c <free+0x6f>
 96d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 971:	48 8b 00             	mov    (%rax),%rax
 974:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 978:	72 22                	jb     99c <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97e:	48 8b 00             	mov    (%rax),%rax
 981:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 985:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 989:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 98d:	73 c7                	jae    956 <free+0x29>
 98f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 993:	48 8b 00             	mov    (%rax),%rax
 996:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 99a:	73 ba                	jae    956 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 99c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a0:	8b 40 08             	mov    0x8(%rax),%eax
 9a3:	89 c0                	mov    %eax,%eax
 9a5:	48 c1 e0 04          	shl    $0x4,%rax
 9a9:	48 89 c2             	mov    %rax,%rdx
 9ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b0:	48 01 c2             	add    %rax,%rdx
 9b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b7:	48 8b 00             	mov    (%rax),%rax
 9ba:	48 39 c2             	cmp    %rax,%rdx
 9bd:	75 2d                	jne    9ec <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c3:	8b 50 08             	mov    0x8(%rax),%edx
 9c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ca:	48 8b 00             	mov    (%rax),%rax
 9cd:	8b 40 08             	mov    0x8(%rax),%eax
 9d0:	01 c2                	add    %eax,%edx
 9d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d6:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 8b 00             	mov    (%rax),%rax
 9e0:	48 8b 10             	mov    (%rax),%rdx
 9e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e7:	48 89 10             	mov    %rdx,(%rax)
 9ea:	eb 0e                	jmp    9fa <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 9ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f0:	48 8b 10             	mov    (%rax),%rdx
 9f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f7:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fe:	8b 40 08             	mov    0x8(%rax),%eax
 a01:	89 c0                	mov    %eax,%eax
 a03:	48 c1 e0 04          	shl    $0x4,%rax
 a07:	48 89 c2             	mov    %rax,%rdx
 a0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a0e:	48 01 d0             	add    %rdx,%rax
 a11:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a15:	75 27                	jne    a3e <free+0x111>
    p->s.size += bp->s.size;
 a17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1b:	8b 50 08             	mov    0x8(%rax),%edx
 a1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a22:	8b 40 08             	mov    0x8(%rax),%eax
 a25:	01 c2                	add    %eax,%edx
 a27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a2b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a32:	48 8b 10             	mov    (%rax),%rdx
 a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a39:	48 89 10             	mov    %rdx,(%rax)
 a3c:	eb 0b                	jmp    a49 <free+0x11c>
  } else
    p->s.ptr = bp;
 a3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a42:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a46:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4d:	48 89 05 2c 04 00 00 	mov    %rax,0x42c(%rip)        # e80 <freep>
}
 a54:	90                   	nop
 a55:	c9                   	leave
 a56:	c3                   	ret

0000000000000a57 <morecore>:

static Header*
morecore(uint nu)
{
 a57:	f3 0f 1e fa          	endbr64
 a5b:	55                   	push   %rbp
 a5c:	48 89 e5             	mov    %rsp,%rbp
 a5f:	48 83 ec 20          	sub    $0x20,%rsp
 a63:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a66:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a6d:	77 07                	ja     a76 <morecore+0x1f>
    nu = 4096;
 a6f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a76:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a79:	c1 e0 04             	shl    $0x4,%eax
 a7c:	89 c7                	mov    %eax,%edi
 a7e:	e8 1c fa ff ff       	call   49f <sbrk>
 a83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a87:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a8c:	75 07                	jne    a95 <morecore+0x3e>
    return 0;
 a8e:	b8 00 00 00 00       	mov    $0x0,%eax
 a93:	eb 29                	jmp    abe <morecore+0x67>
  hp = (Header*)p;
 a95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aa4:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 aa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aab:	48 83 c0 10          	add    $0x10,%rax
 aaf:	48 89 c7             	mov    %rax,%rdi
 ab2:	e8 76 fe ff ff       	call   92d <free>
  return freep;
 ab7:	48 8b 05 c2 03 00 00 	mov    0x3c2(%rip),%rax        # e80 <freep>
}
 abe:	c9                   	leave
 abf:	c3                   	ret

0000000000000ac0 <malloc>:

void*
malloc(uint nbytes)
{
 ac0:	f3 0f 1e fa          	endbr64
 ac4:	55                   	push   %rbp
 ac5:	48 89 e5             	mov    %rsp,%rbp
 ac8:	48 83 ec 30          	sub    $0x30,%rsp
 acc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 acf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 ad2:	48 83 c0 0f          	add    $0xf,%rax
 ad6:	48 c1 e8 04          	shr    $0x4,%rax
 ada:	83 c0 01             	add    $0x1,%eax
 add:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 ae0:	48 8b 05 99 03 00 00 	mov    0x399(%rip),%rax        # e80 <freep>
 ae7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 aeb:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 af0:	75 2b                	jne    b1d <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 af2:	48 c7 45 f0 70 0e 00 	movq   $0xe70,-0x10(%rbp)
 af9:	00 
 afa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 afe:	48 89 05 7b 03 00 00 	mov    %rax,0x37b(%rip)        # e80 <freep>
 b05:	48 8b 05 74 03 00 00 	mov    0x374(%rip),%rax        # e80 <freep>
 b0c:	48 89 05 5d 03 00 00 	mov    %rax,0x35d(%rip)        # e70 <base>
    base.s.size = 0;
 b13:	c7 05 5b 03 00 00 00 	movl   $0x0,0x35b(%rip)        # e78 <base+0x8>
 b1a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b21:	48 8b 00             	mov    (%rax),%rax
 b24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2c:	8b 40 08             	mov    0x8(%rax),%eax
 b2f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b32:	72 5f                	jb     b93 <malloc+0xd3>
      if(p->s.size == nunits)
 b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b38:	8b 40 08             	mov    0x8(%rax),%eax
 b3b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b3e:	75 10                	jne    b50 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b44:	48 8b 10             	mov    (%rax),%rdx
 b47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b4b:	48 89 10             	mov    %rdx,(%rax)
 b4e:	eb 2e                	jmp    b7e <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b54:	8b 40 08             	mov    0x8(%rax),%eax
 b57:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b5a:	89 c2                	mov    %eax,%edx
 b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b60:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b67:	8b 40 08             	mov    0x8(%rax),%eax
 b6a:	89 c0                	mov    %eax,%eax
 b6c:	48 c1 e0 04          	shl    $0x4,%rax
 b70:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b78:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b7b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b82:	48 89 05 f7 02 00 00 	mov    %rax,0x2f7(%rip)        # e80 <freep>
      return (void*)(p + 1);
 b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b8d:	48 83 c0 10          	add    $0x10,%rax
 b91:	eb 41                	jmp    bd4 <malloc+0x114>
    }
    if(p == freep)
 b93:	48 8b 05 e6 02 00 00 	mov    0x2e6(%rip),%rax        # e80 <freep>
 b9a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b9e:	75 1c                	jne    bbc <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 ba0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ba3:	89 c7                	mov    %eax,%edi
 ba5:	e8 ad fe ff ff       	call   a57 <morecore>
 baa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bae:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bb3:	75 07                	jne    bbc <malloc+0xfc>
        return 0;
 bb5:	b8 00 00 00 00       	mov    $0x0,%eax
 bba:	eb 18                	jmp    bd4 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc8:	48 8b 00             	mov    (%rax),%rax
 bcb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bcf:	e9 54 ff ff ff       	jmp    b28 <malloc+0x68>
  }
}
 bd4:	c9                   	leave
 bd5:	c3                   	ret
