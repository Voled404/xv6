
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
  35:	48 c7 c6 f0 0b 00 00 	mov    $0xbf0,%rsi
  3c:	bf 02 00 00 00       	mov    $0x2,%edi
  41:	b8 00 00 00 00       	mov    $0x0,%eax
  46:	e8 8e 05 00 00       	call   5d9 <printf>
    exit();
  4b:	e8 c7 03 00 00       	call   417 <exit>
  }

  while(time > 0){
    printf(2, "%d\n", time);
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	89 c2                	mov    %eax,%edx
  55:	48 c7 c6 15 0c 00 00 	mov    $0xc15,%rsi
  5c:	bf 02 00 00 00       	mov    $0x2,%edi
  61:	b8 00 00 00 00       	mov    $0x0,%eax
  66:	e8 6e 05 00 00       	call   5d9 <printf>
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
  a2:	48 c7 c6 19 0c 00 00 	mov    $0xc19,%rsi
  a9:	bf 02 00 00 00       	mov    $0x2,%edi
  ae:	b8 00 00 00 00       	mov    $0x0,%eax
  b3:	e8 21 05 00 00       	call   5d9 <printf>
    if(i < argc - 1){
  b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  bb:	83 e8 01             	sub    $0x1,%eax
  be:	39 45 f8             	cmp    %eax,-0x8(%rbp)
  c1:	7d 16                	jge    d9 <main+0xd9>
      printf(2, " ");
  c3:	48 c7 c6 1c 0c 00 00 	mov    $0xc1c,%rsi
  ca:	bf 02 00 00 00       	mov    $0x2,%edi
  cf:	b8 00 00 00 00       	mov    $0x0,%eax
  d4:	e8 00 05 00 00       	call   5d9 <printf>
  for(int i = 2; i < argc; i++){
  d9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  e3:	7c a3                	jl     88 <main+0x88>
    }
  }
  printf(2, "\n");
  e5:	48 c7 c6 1e 0c 00 00 	mov    $0xc1e,%rsi
  ec:	bf 02 00 00 00       	mov    $0x2,%edi
  f1:	b8 00 00 00 00       	mov    $0x0,%eax
  f6:	e8 de 04 00 00       	call   5d9 <printf>
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

00000000000004d7 <getcount>:
SYSCALL(getcount)
 4d7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret

00000000000004df <killrandom>:
SYSCALL(killrandom)
 4df:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret

00000000000004e7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e7:	f3 0f 1e fa          	endbr64
 4eb:	55                   	push   %rbp
 4ec:	48 89 e5             	mov    %rsp,%rbp
 4ef:	48 83 ec 10          	sub    $0x10,%rsp
 4f3:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4f6:	89 f0                	mov    %esi,%eax
 4f8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4fb:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
 502:	ba 01 00 00 00       	mov    $0x1,%edx
 507:	48 89 ce             	mov    %rcx,%rsi
 50a:	89 c7                	mov    %eax,%edi
 50c:	e8 26 ff ff ff       	call   437 <write>
}
 511:	90                   	nop
 512:	c9                   	leave
 513:	c3                   	ret

0000000000000514 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 514:	f3 0f 1e fa          	endbr64
 518:	55                   	push   %rbp
 519:	48 89 e5             	mov    %rsp,%rbp
 51c:	48 83 ec 30          	sub    $0x30,%rsp
 520:	89 7d dc             	mov    %edi,-0x24(%rbp)
 523:	89 75 d8             	mov    %esi,-0x28(%rbp)
 526:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 529:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 52c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 533:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 537:	74 17                	je     550 <printint+0x3c>
 539:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 53d:	79 11                	jns    550 <printint+0x3c>
    neg = 1;
 53f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 546:	8b 45 d8             	mov    -0x28(%rbp),%eax
 549:	f7 d8                	neg    %eax
 54b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 54e:	eb 06                	jmp    556 <printint+0x42>
  } else {
    x = xx;
 550:	8b 45 d8             	mov    -0x28(%rbp),%eax
 553:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 556:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 55d:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 560:	8b 45 f4             	mov    -0xc(%rbp),%eax
 563:	ba 00 00 00 00       	mov    $0x0,%edx
 568:	f7 f6                	div    %esi
 56a:	89 d1                	mov    %edx,%ecx
 56c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 56f:	8d 50 01             	lea    0x1(%rax),%edx
 572:	89 55 fc             	mov    %edx,-0x4(%rbp)
 575:	89 ca                	mov    %ecx,%edx
 577:	0f b6 92 60 0e 00 00 	movzbl 0xe60(%rdx),%edx
 57e:	48 98                	cltq
 580:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 584:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 587:	8b 45 f4             	mov    -0xc(%rbp),%eax
 58a:	ba 00 00 00 00       	mov    $0x0,%edx
 58f:	f7 f7                	div    %edi
 591:	89 45 f4             	mov    %eax,-0xc(%rbp)
 594:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 598:	75 c3                	jne    55d <printint+0x49>
  if(neg)
 59a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 59e:	74 2b                	je     5cb <printint+0xb7>
    buf[i++] = '-';
 5a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5a3:	8d 50 01             	lea    0x1(%rax),%edx
 5a6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5a9:	48 98                	cltq
 5ab:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5b0:	eb 19                	jmp    5cb <printint+0xb7>
    putc(fd, buf[i]);
 5b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b5:	48 98                	cltq
 5b7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5bc:	0f be d0             	movsbl %al,%edx
 5bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5c2:	89 d6                	mov    %edx,%esi
 5c4:	89 c7                	mov    %eax,%edi
 5c6:	e8 1c ff ff ff       	call   4e7 <putc>
  while(--i >= 0)
 5cb:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5d3:	79 dd                	jns    5b2 <printint+0x9e>
}
 5d5:	90                   	nop
 5d6:	90                   	nop
 5d7:	c9                   	leave
 5d8:	c3                   	ret

00000000000005d9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d9:	f3 0f 1e fa          	endbr64
 5dd:	55                   	push   %rbp
 5de:	48 89 e5             	mov    %rsp,%rbp
 5e1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5e8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5ee:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5f5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5fc:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 603:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 60a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 611:	84 c0                	test   %al,%al
 613:	74 20                	je     635 <printf+0x5c>
 615:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 619:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 61d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 621:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 625:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 629:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 62d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 631:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 635:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 63c:	00 00 00 
 63f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 646:	00 00 00 
 649:	48 8d 45 10          	lea    0x10(%rbp),%rax
 64d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 654:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 65b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 662:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 669:	00 00 00 
  for(i = 0; fmt[i]; i++){
 66c:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 673:	00 00 00 
 676:	e9 a8 02 00 00       	jmp    923 <printf+0x34a>
    c = fmt[i] & 0xff;
 67b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 681:	48 63 d0             	movslq %eax,%rdx
 684:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 68b:	48 01 d0             	add    %rdx,%rax
 68e:	0f b6 00             	movzbl (%rax),%eax
 691:	0f be c0             	movsbl %al,%eax
 694:	25 ff 00 00 00       	and    $0xff,%eax
 699:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 69f:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6a6:	75 35                	jne    6dd <printf+0x104>
      if(c == '%'){
 6a8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6af:	75 0f                	jne    6c0 <printf+0xe7>
        state = '%';
 6b1:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6b8:	00 00 00 
 6bb:	e9 5c 02 00 00       	jmp    91c <printf+0x343>
      } else {
        putc(fd, c);
 6c0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6c6:	0f be d0             	movsbl %al,%edx
 6c9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6cf:	89 d6                	mov    %edx,%esi
 6d1:	89 c7                	mov    %eax,%edi
 6d3:	e8 0f fe ff ff       	call   4e7 <putc>
 6d8:	e9 3f 02 00 00       	jmp    91c <printf+0x343>
      }
    } else if(state == '%'){
 6dd:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6e4:	0f 85 32 02 00 00    	jne    91c <printf+0x343>
      if(c == 'd'){
 6ea:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6f1:	75 5e                	jne    751 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 6f3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f9:	83 f8 2f             	cmp    $0x2f,%eax
 6fc:	77 23                	ja     721 <printf+0x148>
 6fe:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 705:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70b:	89 d2                	mov    %edx,%edx
 70d:	48 01 d0             	add    %rdx,%rax
 710:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 716:	83 c2 08             	add    $0x8,%edx
 719:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 71f:	eb 12                	jmp    733 <printf+0x15a>
 721:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 728:	48 8d 50 08          	lea    0x8(%rax),%rdx
 72c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 733:	8b 30                	mov    (%rax),%esi
 735:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 73b:	b9 01 00 00 00       	mov    $0x1,%ecx
 740:	ba 0a 00 00 00       	mov    $0xa,%edx
 745:	89 c7                	mov    %eax,%edi
 747:	e8 c8 fd ff ff       	call   514 <printint>
 74c:	e9 c1 01 00 00       	jmp    912 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 751:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 758:	74 09                	je     763 <printf+0x18a>
 75a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 761:	75 5e                	jne    7c1 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 763:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 769:	83 f8 2f             	cmp    $0x2f,%eax
 76c:	77 23                	ja     791 <printf+0x1b8>
 76e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 775:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 77b:	89 d2                	mov    %edx,%edx
 77d:	48 01 d0             	add    %rdx,%rax
 780:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 786:	83 c2 08             	add    $0x8,%edx
 789:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 78f:	eb 12                	jmp    7a3 <printf+0x1ca>
 791:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 798:	48 8d 50 08          	lea    0x8(%rax),%rdx
 79c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7a3:	8b 30                	mov    (%rax),%esi
 7a5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ab:	b9 00 00 00 00       	mov    $0x0,%ecx
 7b0:	ba 10 00 00 00       	mov    $0x10,%edx
 7b5:	89 c7                	mov    %eax,%edi
 7b7:	e8 58 fd ff ff       	call   514 <printint>
 7bc:	e9 51 01 00 00       	jmp    912 <printf+0x339>
      } else if(c == 's'){
 7c1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7c8:	0f 85 98 00 00 00    	jne    866 <printf+0x28d>
        s = va_arg(ap, char*);
 7ce:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7d4:	83 f8 2f             	cmp    $0x2f,%eax
 7d7:	77 23                	ja     7fc <printf+0x223>
 7d9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e6:	89 d2                	mov    %edx,%edx
 7e8:	48 01 d0             	add    %rdx,%rax
 7eb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f1:	83 c2 08             	add    $0x8,%edx
 7f4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7fa:	eb 12                	jmp    80e <printf+0x235>
 7fc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 803:	48 8d 50 08          	lea    0x8(%rax),%rdx
 807:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 80e:	48 8b 00             	mov    (%rax),%rax
 811:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 818:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 81f:	00 
 820:	75 31                	jne    853 <printf+0x27a>
          s = "(null)";
 822:	48 c7 85 48 ff ff ff 	movq   $0xc20,-0xb8(%rbp)
 829:	20 0c 00 00 
        while(*s != 0){
 82d:	eb 24                	jmp    853 <printf+0x27a>
          putc(fd, *s);
 82f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 836:	0f b6 00             	movzbl (%rax),%eax
 839:	0f be d0             	movsbl %al,%edx
 83c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 842:	89 d6                	mov    %edx,%esi
 844:	89 c7                	mov    %eax,%edi
 846:	e8 9c fc ff ff       	call   4e7 <putc>
          s++;
 84b:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 852:	01 
        while(*s != 0){
 853:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 85a:	0f b6 00             	movzbl (%rax),%eax
 85d:	84 c0                	test   %al,%al
 85f:	75 ce                	jne    82f <printf+0x256>
 861:	e9 ac 00 00 00       	jmp    912 <printf+0x339>
        }
      } else if(c == 'c'){
 866:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 86d:	75 56                	jne    8c5 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 86f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 875:	83 f8 2f             	cmp    $0x2f,%eax
 878:	77 23                	ja     89d <printf+0x2c4>
 87a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 881:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 887:	89 d2                	mov    %edx,%edx
 889:	48 01 d0             	add    %rdx,%rax
 88c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 892:	83 c2 08             	add    $0x8,%edx
 895:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 89b:	eb 12                	jmp    8af <printf+0x2d6>
 89d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8a4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8a8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8af:	8b 00                	mov    (%rax),%eax
 8b1:	0f be d0             	movsbl %al,%edx
 8b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ba:	89 d6                	mov    %edx,%esi
 8bc:	89 c7                	mov    %eax,%edi
 8be:	e8 24 fc ff ff       	call   4e7 <putc>
 8c3:	eb 4d                	jmp    912 <printf+0x339>
      } else if(c == '%'){
 8c5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8cc:	75 1a                	jne    8e8 <printf+0x30f>
        putc(fd, c);
 8ce:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8d4:	0f be d0             	movsbl %al,%edx
 8d7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8dd:	89 d6                	mov    %edx,%esi
 8df:	89 c7                	mov    %eax,%edi
 8e1:	e8 01 fc ff ff       	call   4e7 <putc>
 8e6:	eb 2a                	jmp    912 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ee:	be 25 00 00 00       	mov    $0x25,%esi
 8f3:	89 c7                	mov    %eax,%edi
 8f5:	e8 ed fb ff ff       	call   4e7 <putc>
        putc(fd, c);
 8fa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 900:	0f be d0             	movsbl %al,%edx
 903:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 909:	89 d6                	mov    %edx,%esi
 90b:	89 c7                	mov    %eax,%edi
 90d:	e8 d5 fb ff ff       	call   4e7 <putc>
      }
      state = 0;
 912:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 919:	00 00 00 
  for(i = 0; fmt[i]; i++){
 91c:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 923:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 929:	48 63 d0             	movslq %eax,%rdx
 92c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 933:	48 01 d0             	add    %rdx,%rax
 936:	0f b6 00             	movzbl (%rax),%eax
 939:	84 c0                	test   %al,%al
 93b:	0f 85 3a fd ff ff    	jne    67b <printf+0xa2>
    }
  }
}
 941:	90                   	nop
 942:	90                   	nop
 943:	c9                   	leave
 944:	c3                   	ret

0000000000000945 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 945:	f3 0f 1e fa          	endbr64
 949:	55                   	push   %rbp
 94a:	48 89 e5             	mov    %rsp,%rbp
 94d:	48 83 ec 18          	sub    $0x18,%rsp
 951:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 955:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 959:	48 83 e8 10          	sub    $0x10,%rax
 95d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 961:	48 8b 05 28 05 00 00 	mov    0x528(%rip),%rax        # e90 <freep>
 968:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 96c:	eb 2f                	jmp    99d <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 972:	48 8b 00             	mov    (%rax),%rax
 975:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 979:	72 17                	jb     992 <free+0x4d>
 97b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 983:	72 2f                	jb     9b4 <free+0x6f>
 985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 989:	48 8b 00             	mov    (%rax),%rax
 98c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 990:	72 22                	jb     9b4 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 992:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 996:	48 8b 00             	mov    (%rax),%rax
 999:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 99d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9a5:	73 c7                	jae    96e <free+0x29>
 9a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ab:	48 8b 00             	mov    (%rax),%rax
 9ae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9b2:	73 ba                	jae    96e <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b8:	8b 40 08             	mov    0x8(%rax),%eax
 9bb:	89 c0                	mov    %eax,%eax
 9bd:	48 c1 e0 04          	shl    $0x4,%rax
 9c1:	48 89 c2             	mov    %rax,%rdx
 9c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c8:	48 01 c2             	add    %rax,%rdx
 9cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cf:	48 8b 00             	mov    (%rax),%rax
 9d2:	48 39 c2             	cmp    %rax,%rdx
 9d5:	75 2d                	jne    a04 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9db:	8b 50 08             	mov    0x8(%rax),%edx
 9de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e2:	48 8b 00             	mov    (%rax),%rax
 9e5:	8b 40 08             	mov    0x8(%rax),%eax
 9e8:	01 c2                	add    %eax,%edx
 9ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ee:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f5:	48 8b 00             	mov    (%rax),%rax
 9f8:	48 8b 10             	mov    (%rax),%rdx
 9fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ff:	48 89 10             	mov    %rdx,(%rax)
 a02:	eb 0e                	jmp    a12 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a08:	48 8b 10             	mov    (%rax),%rdx
 a0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a16:	8b 40 08             	mov    0x8(%rax),%eax
 a19:	89 c0                	mov    %eax,%eax
 a1b:	48 c1 e0 04          	shl    $0x4,%rax
 a1f:	48 89 c2             	mov    %rax,%rdx
 a22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a26:	48 01 d0             	add    %rdx,%rax
 a29:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a2d:	75 27                	jne    a56 <free+0x111>
    p->s.size += bp->s.size;
 a2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a33:	8b 50 08             	mov    0x8(%rax),%edx
 a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3a:	8b 40 08             	mov    0x8(%rax),%eax
 a3d:	01 c2                	add    %eax,%edx
 a3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a43:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a4a:	48 8b 10             	mov    (%rax),%rdx
 a4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a51:	48 89 10             	mov    %rdx,(%rax)
 a54:	eb 0b                	jmp    a61 <free+0x11c>
  } else
    p->s.ptr = bp;
 a56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a5e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a65:	48 89 05 24 04 00 00 	mov    %rax,0x424(%rip)        # e90 <freep>
}
 a6c:	90                   	nop
 a6d:	c9                   	leave
 a6e:	c3                   	ret

0000000000000a6f <morecore>:

static Header*
morecore(uint nu)
{
 a6f:	f3 0f 1e fa          	endbr64
 a73:	55                   	push   %rbp
 a74:	48 89 e5             	mov    %rsp,%rbp
 a77:	48 83 ec 20          	sub    $0x20,%rsp
 a7b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a7e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a85:	77 07                	ja     a8e <morecore+0x1f>
    nu = 4096;
 a87:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a8e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a91:	c1 e0 04             	shl    $0x4,%eax
 a94:	89 c7                	mov    %eax,%edi
 a96:	e8 04 fa ff ff       	call   49f <sbrk>
 a9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a9f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 aa4:	75 07                	jne    aad <morecore+0x3e>
    return 0;
 aa6:	b8 00 00 00 00       	mov    $0x0,%eax
 aab:	eb 29                	jmp    ad6 <morecore+0x67>
  hp = (Header*)p;
 aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 abc:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 abf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac3:	48 83 c0 10          	add    $0x10,%rax
 ac7:	48 89 c7             	mov    %rax,%rdi
 aca:	e8 76 fe ff ff       	call   945 <free>
  return freep;
 acf:	48 8b 05 ba 03 00 00 	mov    0x3ba(%rip),%rax        # e90 <freep>
}
 ad6:	c9                   	leave
 ad7:	c3                   	ret

0000000000000ad8 <malloc>:

void*
malloc(uint nbytes)
{
 ad8:	f3 0f 1e fa          	endbr64
 adc:	55                   	push   %rbp
 add:	48 89 e5             	mov    %rsp,%rbp
 ae0:	48 83 ec 30          	sub    $0x30,%rsp
 ae4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 aea:	48 83 c0 0f          	add    $0xf,%rax
 aee:	48 c1 e8 04          	shr    $0x4,%rax
 af2:	83 c0 01             	add    $0x1,%eax
 af5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 af8:	48 8b 05 91 03 00 00 	mov    0x391(%rip),%rax        # e90 <freep>
 aff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b03:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b08:	75 2b                	jne    b35 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 b0a:	48 c7 45 f0 80 0e 00 	movq   $0xe80,-0x10(%rbp)
 b11:	00 
 b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b16:	48 89 05 73 03 00 00 	mov    %rax,0x373(%rip)        # e90 <freep>
 b1d:	48 8b 05 6c 03 00 00 	mov    0x36c(%rip),%rax        # e90 <freep>
 b24:	48 89 05 55 03 00 00 	mov    %rax,0x355(%rip)        # e80 <base>
    base.s.size = 0;
 b2b:	c7 05 53 03 00 00 00 	movl   $0x0,0x353(%rip)        # e88 <base+0x8>
 b32:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b39:	48 8b 00             	mov    (%rax),%rax
 b3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b44:	8b 40 08             	mov    0x8(%rax),%eax
 b47:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b4a:	72 5f                	jb     bab <malloc+0xd3>
      if(p->s.size == nunits)
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	8b 40 08             	mov    0x8(%rax),%eax
 b53:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b56:	75 10                	jne    b68 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5c:	48 8b 10             	mov    (%rax),%rdx
 b5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b63:	48 89 10             	mov    %rdx,(%rax)
 b66:	eb 2e                	jmp    b96 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6c:	8b 40 08             	mov    0x8(%rax),%eax
 b6f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b72:	89 c2                	mov    %eax,%edx
 b74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b78:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7f:	8b 40 08             	mov    0x8(%rax),%eax
 b82:	89 c0                	mov    %eax,%eax
 b84:	48 c1 e0 04          	shl    $0x4,%rax
 b88:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b90:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b93:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9a:	48 89 05 ef 02 00 00 	mov    %rax,0x2ef(%rip)        # e90 <freep>
      return (void*)(p + 1);
 ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba5:	48 83 c0 10          	add    $0x10,%rax
 ba9:	eb 41                	jmp    bec <malloc+0x114>
    }
    if(p == freep)
 bab:	48 8b 05 de 02 00 00 	mov    0x2de(%rip),%rax        # e90 <freep>
 bb2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bb6:	75 1c                	jne    bd4 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 bb8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bbb:	89 c7                	mov    %eax,%edi
 bbd:	e8 ad fe ff ff       	call   a6f <morecore>
 bc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bc6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bcb:	75 07                	jne    bd4 <malloc+0xfc>
        return 0;
 bcd:	b8 00 00 00 00       	mov    $0x0,%eax
 bd2:	eb 18                	jmp    bec <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be0:	48 8b 00             	mov    (%rax),%rax
 be3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 be7:	e9 54 ff ff ff       	jmp    b40 <malloc+0x68>
  }
}
 bec:	c9                   	leave
 bed:	c3                   	ret
