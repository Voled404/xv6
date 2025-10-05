
fs/mkdir:     file format elf64-x86-64


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
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
  13:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  17:	7f 1b                	jg     34 <main+0x34>
    printf(2, "Usage: mkdir files...\n");
  19:	48 c7 c6 71 0b 00 00 	mov    $0xb71,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 2d 05 00 00       	call   55c <printf>
    exit();
  2f:	e8 86 03 00 00       	call   3ba <exit>
  }

  for(i = 1; i < argc; i++){
  34:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  3b:	eb 59                	jmp    96 <main+0x96>
    if(mkdir(argv[i]) < 0){
  3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  40:	48 98                	cltq
  42:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  49:	00 
  4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  4e:	48 01 d0             	add    %rdx,%rax
  51:	48 8b 00             	mov    (%rax),%rax
  54:	48 89 c7             	mov    %rax,%rdi
  57:	e8 c6 03 00 00       	call   422 <mkdir>
  5c:	85 c0                	test   %eax,%eax
  5e:	79 32                	jns    92 <main+0x92>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  60:	8b 45 fc             	mov    -0x4(%rbp),%eax
  63:	48 98                	cltq
  65:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  6c:	00 
  6d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  71:	48 01 d0             	add    %rdx,%rax
  74:	48 8b 00             	mov    (%rax),%rax
  77:	48 89 c2             	mov    %rax,%rdx
  7a:	48 c7 c6 88 0b 00 00 	mov    $0xb88,%rsi
  81:	bf 02 00 00 00       	mov    $0x2,%edi
  86:	b8 00 00 00 00       	mov    $0x0,%eax
  8b:	e8 cc 04 00 00       	call   55c <printf>
      break;
  90:	eb 0c                	jmp    9e <main+0x9e>
  for(i = 1; i < argc; i++){
  92:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  96:	8b 45 fc             	mov    -0x4(%rbp),%eax
  99:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  9c:	7c 9f                	jl     3d <main+0x3d>
    }
  }

  exit();
  9e:	e8 17 03 00 00       	call   3ba <exit>

00000000000000a3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  a3:	55                   	push   %rbp
  a4:	48 89 e5             	mov    %rsp,%rbp
  a7:	48 83 ec 10          	sub    $0x10,%rsp
  ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  af:	89 75 f4             	mov    %esi,-0xc(%rbp)
  b2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  b5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  b9:	8b 55 f0             	mov    -0x10(%rbp),%edx
  bc:	8b 45 f4             	mov    -0xc(%rbp),%eax
  bf:	48 89 ce             	mov    %rcx,%rsi
  c2:	48 89 f7             	mov    %rsi,%rdi
  c5:	89 d1                	mov    %edx,%ecx
  c7:	fc                   	cld
  c8:	f3 aa                	rep stos %al,%es:(%rdi)
  ca:	89 ca                	mov    %ecx,%edx
  cc:	48 89 fe             	mov    %rdi,%rsi
  cf:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  d3:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  d6:	90                   	nop
  d7:	c9                   	leave
  d8:	c3                   	ret

00000000000000d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d9:	f3 0f 1e fa          	endbr64
  dd:	55                   	push   %rbp
  de:	48 89 e5             	mov    %rsp,%rbp
  e1:	48 83 ec 20          	sub    $0x20,%rsp
  e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  e9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  f5:	90                   	nop
  f6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  fa:	48 8d 42 01          	lea    0x1(%rdx),%rax
  fe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 102:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 106:	48 8d 48 01          	lea    0x1(%rax),%rcx
 10a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 10e:	0f b6 12             	movzbl (%rdx),%edx
 111:	88 10                	mov    %dl,(%rax)
 113:	0f b6 00             	movzbl (%rax),%eax
 116:	84 c0                	test   %al,%al
 118:	75 dc                	jne    f6 <strcpy+0x1d>
    ;
  return os;
 11a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 11e:	c9                   	leave
 11f:	c3                   	ret

0000000000000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	f3 0f 1e fa          	endbr64
 124:	55                   	push   %rbp
 125:	48 89 e5             	mov    %rsp,%rbp
 128:	48 83 ec 10          	sub    $0x10,%rsp
 12c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 130:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 134:	eb 0a                	jmp    140 <strcmp+0x20>
    p++, q++;
 136:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 13b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 144:	0f b6 00             	movzbl (%rax),%eax
 147:	84 c0                	test   %al,%al
 149:	74 12                	je     15d <strcmp+0x3d>
 14b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 14f:	0f b6 10             	movzbl (%rax),%edx
 152:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 156:	0f b6 00             	movzbl (%rax),%eax
 159:	38 c2                	cmp    %al,%dl
 15b:	74 d9                	je     136 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 15d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 161:	0f b6 00             	movzbl (%rax),%eax
 164:	0f b6 d0             	movzbl %al,%edx
 167:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 16b:	0f b6 00             	movzbl (%rax),%eax
 16e:	0f b6 c0             	movzbl %al,%eax
 171:	29 c2                	sub    %eax,%edx
 173:	89 d0                	mov    %edx,%eax
}
 175:	c9                   	leave
 176:	c3                   	ret

0000000000000177 <strlen>:

uint
strlen(char *s)
{
 177:	f3 0f 1e fa          	endbr64
 17b:	55                   	push   %rbp
 17c:	48 89 e5             	mov    %rsp,%rbp
 17f:	48 83 ec 18          	sub    $0x18,%rsp
 183:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 187:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 18e:	eb 04                	jmp    194 <strlen+0x1d>
 190:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 194:	8b 45 fc             	mov    -0x4(%rbp),%eax
 197:	48 63 d0             	movslq %eax,%rdx
 19a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 19e:	48 01 d0             	add    %rdx,%rax
 1a1:	0f b6 00             	movzbl (%rax),%eax
 1a4:	84 c0                	test   %al,%al
 1a6:	75 e8                	jne    190 <strlen+0x19>
    ;
  return n;
 1a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 1ab:	c9                   	leave
 1ac:	c3                   	ret

00000000000001ad <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ad:	f3 0f 1e fa          	endbr64
 1b1:	55                   	push   %rbp
 1b2:	48 89 e5             	mov    %rsp,%rbp
 1b5:	48 83 ec 10          	sub    $0x10,%rsp
 1b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1bd:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1c0:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 1c3:	8b 55 f0             	mov    -0x10(%rbp),%edx
 1c6:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 1c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1cd:	89 ce                	mov    %ecx,%esi
 1cf:	48 89 c7             	mov    %rax,%rdi
 1d2:	e8 cc fe ff ff       	call   a3 <stosb>
  return dst;
 1d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1db:	c9                   	leave
 1dc:	c3                   	ret

00000000000001dd <strchr>:

char*
strchr(const char *s, char c)
{
 1dd:	f3 0f 1e fa          	endbr64
 1e1:	55                   	push   %rbp
 1e2:	48 89 e5             	mov    %rsp,%rbp
 1e5:	48 83 ec 10          	sub    $0x10,%rsp
 1e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1ed:	89 f0                	mov    %esi,%eax
 1ef:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1f2:	eb 17                	jmp    20b <strchr+0x2e>
    if(*s == c)
 1f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1f8:	0f b6 00             	movzbl (%rax),%eax
 1fb:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1fe:	75 06                	jne    206 <strchr+0x29>
      return (char*)s;
 200:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 204:	eb 15                	jmp    21b <strchr+0x3e>
  for(; *s; s++)
 206:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 20b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 20f:	0f b6 00             	movzbl (%rax),%eax
 212:	84 c0                	test   %al,%al
 214:	75 de                	jne    1f4 <strchr+0x17>
  return 0;
 216:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21b:	c9                   	leave
 21c:	c3                   	ret

000000000000021d <gets>:

char*
gets(char *buf, int max)
{
 21d:	f3 0f 1e fa          	endbr64
 221:	55                   	push   %rbp
 222:	48 89 e5             	mov    %rsp,%rbp
 225:	48 83 ec 20          	sub    $0x20,%rsp
 229:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 22d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 237:	eb 48                	jmp    281 <gets+0x64>
    cc = read(0, &c, 1);
 239:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 23d:	ba 01 00 00 00       	mov    $0x1,%edx
 242:	48 89 c6             	mov    %rax,%rsi
 245:	bf 00 00 00 00       	mov    $0x0,%edi
 24a:	e8 83 01 00 00       	call   3d2 <read>
 24f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 252:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 256:	7e 36                	jle    28e <gets+0x71>
      break;
    buf[i++] = c;
 258:	8b 45 fc             	mov    -0x4(%rbp),%eax
 25b:	8d 50 01             	lea    0x1(%rax),%edx
 25e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 261:	48 63 d0             	movslq %eax,%rdx
 264:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 268:	48 01 c2             	add    %rax,%rdx
 26b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 26f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 271:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 275:	3c 0a                	cmp    $0xa,%al
 277:	74 16                	je     28f <gets+0x72>
 279:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 27d:	3c 0d                	cmp    $0xd,%al
 27f:	74 0e                	je     28f <gets+0x72>
  for(i=0; i+1 < max; ){
 281:	8b 45 fc             	mov    -0x4(%rbp),%eax
 284:	83 c0 01             	add    $0x1,%eax
 287:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 28a:	7f ad                	jg     239 <gets+0x1c>
 28c:	eb 01                	jmp    28f <gets+0x72>
      break;
 28e:	90                   	nop
      break;
  }
  buf[i] = '\0';
 28f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 292:	48 63 d0             	movslq %eax,%rdx
 295:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 299:	48 01 d0             	add    %rdx,%rax
 29c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 29f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 2a3:	c9                   	leave
 2a4:	c3                   	ret

00000000000002a5 <stat>:

int
stat(char *n, struct stat *st)
{
 2a5:	f3 0f 1e fa          	endbr64
 2a9:	55                   	push   %rbp
 2aa:	48 89 e5             	mov    %rsp,%rbp
 2ad:	48 83 ec 20          	sub    $0x20,%rsp
 2b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2bd:	be 00 00 00 00       	mov    $0x0,%esi
 2c2:	48 89 c7             	mov    %rax,%rdi
 2c5:	e8 30 01 00 00       	call   3fa <open>
 2ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 2cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2d1:	79 07                	jns    2da <stat+0x35>
    return -1;
 2d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d8:	eb 21                	jmp    2fb <stat+0x56>
  r = fstat(fd, st);
 2da:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2de:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2e1:	48 89 d6             	mov    %rdx,%rsi
 2e4:	89 c7                	mov    %eax,%edi
 2e6:	e8 27 01 00 00       	call   412 <fstat>
 2eb:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2f1:	89 c7                	mov    %eax,%edi
 2f3:	e8 ea 00 00 00       	call   3e2 <close>
  return r;
 2f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2fb:	c9                   	leave
 2fc:	c3                   	ret

00000000000002fd <atoi>:

int
atoi(const char *s)
{
 2fd:	f3 0f 1e fa          	endbr64
 301:	55                   	push   %rbp
 302:	48 89 e5             	mov    %rsp,%rbp
 305:	48 83 ec 18          	sub    $0x18,%rsp
 309:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 30d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 314:	eb 28                	jmp    33e <atoi+0x41>
    n = n*10 + *s++ - '0';
 316:	8b 55 fc             	mov    -0x4(%rbp),%edx
 319:	89 d0                	mov    %edx,%eax
 31b:	c1 e0 02             	shl    $0x2,%eax
 31e:	01 d0                	add    %edx,%eax
 320:	01 c0                	add    %eax,%eax
 322:	89 c1                	mov    %eax,%ecx
 324:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 328:	48 8d 50 01          	lea    0x1(%rax),%rdx
 32c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 330:	0f b6 00             	movzbl (%rax),%eax
 333:	0f be c0             	movsbl %al,%eax
 336:	01 c8                	add    %ecx,%eax
 338:	83 e8 30             	sub    $0x30,%eax
 33b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 33e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 342:	0f b6 00             	movzbl (%rax),%eax
 345:	3c 2f                	cmp    $0x2f,%al
 347:	7e 0b                	jle    354 <atoi+0x57>
 349:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 34d:	0f b6 00             	movzbl (%rax),%eax
 350:	3c 39                	cmp    $0x39,%al
 352:	7e c2                	jle    316 <atoi+0x19>
  return n;
 354:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 357:	c9                   	leave
 358:	c3                   	ret

0000000000000359 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 359:	f3 0f 1e fa          	endbr64
 35d:	55                   	push   %rbp
 35e:	48 89 e5             	mov    %rsp,%rbp
 361:	48 83 ec 28          	sub    $0x28,%rsp
 365:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 369:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 36d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 370:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 374:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 378:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 37c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 380:	eb 1d                	jmp    39f <memmove+0x46>
    *dst++ = *src++;
 382:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 386:	48 8d 42 01          	lea    0x1(%rdx),%rax
 38a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 38e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 392:	48 8d 48 01          	lea    0x1(%rax),%rcx
 396:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 39a:	0f b6 12             	movzbl (%rdx),%edx
 39d:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 39f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 3a2:	8d 50 ff             	lea    -0x1(%rax),%edx
 3a5:	89 55 dc             	mov    %edx,-0x24(%rbp)
 3a8:	85 c0                	test   %eax,%eax
 3aa:	7f d6                	jg     382 <memmove+0x29>
  return vdst;
 3ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 3b0:	c9                   	leave
 3b1:	c3                   	ret

00000000000003b2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3b2:	b8 01 00 00 00       	mov    $0x1,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

00000000000003ba <exit>:
SYSCALL(exit)
 3ba:	b8 02 00 00 00       	mov    $0x2,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

00000000000003c2 <wait>:
SYSCALL(wait)
 3c2:	b8 03 00 00 00       	mov    $0x3,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

00000000000003ca <pipe>:
SYSCALL(pipe)
 3ca:	b8 04 00 00 00       	mov    $0x4,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

00000000000003d2 <read>:
SYSCALL(read)
 3d2:	b8 05 00 00 00       	mov    $0x5,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

00000000000003da <write>:
SYSCALL(write)
 3da:	b8 10 00 00 00       	mov    $0x10,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

00000000000003e2 <close>:
SYSCALL(close)
 3e2:	b8 15 00 00 00       	mov    $0x15,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

00000000000003ea <kill>:
SYSCALL(kill)
 3ea:	b8 06 00 00 00       	mov    $0x6,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

00000000000003f2 <exec>:
SYSCALL(exec)
 3f2:	b8 07 00 00 00       	mov    $0x7,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

00000000000003fa <open>:
SYSCALL(open)
 3fa:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

0000000000000402 <mknod>:
SYSCALL(mknod)
 402:	b8 11 00 00 00       	mov    $0x11,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

000000000000040a <unlink>:
SYSCALL(unlink)
 40a:	b8 12 00 00 00       	mov    $0x12,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

0000000000000412 <fstat>:
SYSCALL(fstat)
 412:	b8 08 00 00 00       	mov    $0x8,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

000000000000041a <link>:
SYSCALL(link)
 41a:	b8 13 00 00 00       	mov    $0x13,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

0000000000000422 <mkdir>:
SYSCALL(mkdir)
 422:	b8 14 00 00 00       	mov    $0x14,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

000000000000042a <chdir>:
SYSCALL(chdir)
 42a:	b8 09 00 00 00       	mov    $0x9,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

0000000000000432 <dup>:
SYSCALL(dup)
 432:	b8 0a 00 00 00       	mov    $0xa,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

000000000000043a <getpid>:
SYSCALL(getpid)
 43a:	b8 0b 00 00 00       	mov    $0xb,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret

0000000000000442 <sbrk>:
SYSCALL(sbrk)
 442:	b8 0c 00 00 00       	mov    $0xc,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

000000000000044a <sleep>:
SYSCALL(sleep)
 44a:	b8 0d 00 00 00       	mov    $0xd,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

0000000000000452 <uptime>:
SYSCALL(uptime)
 452:	b8 0e 00 00 00       	mov    $0xe,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

000000000000045a <getpinfo>:
SYSCALL(getpinfo)
 45a:	b8 18 00 00 00       	mov    $0x18,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret

0000000000000462 <settickets>:
SYSCALL(settickets)
 462:	b8 1b 00 00 00       	mov    $0x1b,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret

000000000000046a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 46a:	f3 0f 1e fa          	endbr64
 46e:	55                   	push   %rbp
 46f:	48 89 e5             	mov    %rsp,%rbp
 472:	48 83 ec 10          	sub    $0x10,%rsp
 476:	89 7d fc             	mov    %edi,-0x4(%rbp)
 479:	89 f0                	mov    %esi,%eax
 47b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 47e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 482:	8b 45 fc             	mov    -0x4(%rbp),%eax
 485:	ba 01 00 00 00       	mov    $0x1,%edx
 48a:	48 89 ce             	mov    %rcx,%rsi
 48d:	89 c7                	mov    %eax,%edi
 48f:	e8 46 ff ff ff       	call   3da <write>
}
 494:	90                   	nop
 495:	c9                   	leave
 496:	c3                   	ret

0000000000000497 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 497:	f3 0f 1e fa          	endbr64
 49b:	55                   	push   %rbp
 49c:	48 89 e5             	mov    %rsp,%rbp
 49f:	48 83 ec 30          	sub    $0x30,%rsp
 4a3:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4a6:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4a9:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4ac:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4b6:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4ba:	74 17                	je     4d3 <printint+0x3c>
 4bc:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4c0:	79 11                	jns    4d3 <printint+0x3c>
    neg = 1;
 4c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4c9:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4cc:	f7 d8                	neg    %eax
 4ce:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4d1:	eb 06                	jmp    4d9 <printint+0x42>
  } else {
    x = xx;
 4d3:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4d6:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4e0:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4e3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4e6:	ba 00 00 00 00       	mov    $0x0,%edx
 4eb:	f7 f6                	div    %esi
 4ed:	89 d1                	mov    %edx,%ecx
 4ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f2:	8d 50 01             	lea    0x1(%rax),%edx
 4f5:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4f8:	89 ca                	mov    %ecx,%edx
 4fa:	0f b6 92 f0 0d 00 00 	movzbl 0xdf0(%rdx),%edx
 501:	48 98                	cltq
 503:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 507:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 50a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 50d:	ba 00 00 00 00       	mov    $0x0,%edx
 512:	f7 f7                	div    %edi
 514:	89 45 f4             	mov    %eax,-0xc(%rbp)
 517:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 51b:	75 c3                	jne    4e0 <printint+0x49>
  if(neg)
 51d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 521:	74 2b                	je     54e <printint+0xb7>
    buf[i++] = '-';
 523:	8b 45 fc             	mov    -0x4(%rbp),%eax
 526:	8d 50 01             	lea    0x1(%rax),%edx
 529:	89 55 fc             	mov    %edx,-0x4(%rbp)
 52c:	48 98                	cltq
 52e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 533:	eb 19                	jmp    54e <printint+0xb7>
    putc(fd, buf[i]);
 535:	8b 45 fc             	mov    -0x4(%rbp),%eax
 538:	48 98                	cltq
 53a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 53f:	0f be d0             	movsbl %al,%edx
 542:	8b 45 dc             	mov    -0x24(%rbp),%eax
 545:	89 d6                	mov    %edx,%esi
 547:	89 c7                	mov    %eax,%edi
 549:	e8 1c ff ff ff       	call   46a <putc>
  while(--i >= 0)
 54e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 552:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 556:	79 dd                	jns    535 <printint+0x9e>
}
 558:	90                   	nop
 559:	90                   	nop
 55a:	c9                   	leave
 55b:	c3                   	ret

000000000000055c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 55c:	f3 0f 1e fa          	endbr64
 560:	55                   	push   %rbp
 561:	48 89 e5             	mov    %rsp,%rbp
 564:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 56b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 571:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 578:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 57f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 586:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 58d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 594:	84 c0                	test   %al,%al
 596:	74 20                	je     5b8 <printf+0x5c>
 598:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 59c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5a0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5a4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5a8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5ac:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5b0:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5b4:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5b8:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5bf:	00 00 00 
 5c2:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5c9:	00 00 00 
 5cc:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5d0:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5d7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5de:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5e5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5ec:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5ef:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5f6:	00 00 00 
 5f9:	e9 a8 02 00 00       	jmp    8a6 <printf+0x34a>
    c = fmt[i] & 0xff;
 5fe:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 604:	48 63 d0             	movslq %eax,%rdx
 607:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 60e:	48 01 d0             	add    %rdx,%rax
 611:	0f b6 00             	movzbl (%rax),%eax
 614:	0f be c0             	movsbl %al,%eax
 617:	25 ff 00 00 00       	and    $0xff,%eax
 61c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 622:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 629:	75 35                	jne    660 <printf+0x104>
      if(c == '%'){
 62b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 632:	75 0f                	jne    643 <printf+0xe7>
        state = '%';
 634:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 63b:	00 00 00 
 63e:	e9 5c 02 00 00       	jmp    89f <printf+0x343>
      } else {
        putc(fd, c);
 643:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 649:	0f be d0             	movsbl %al,%edx
 64c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 652:	89 d6                	mov    %edx,%esi
 654:	89 c7                	mov    %eax,%edi
 656:	e8 0f fe ff ff       	call   46a <putc>
 65b:	e9 3f 02 00 00       	jmp    89f <printf+0x343>
      }
    } else if(state == '%'){
 660:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 667:	0f 85 32 02 00 00    	jne    89f <printf+0x343>
      if(c == 'd'){
 66d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 674:	75 5e                	jne    6d4 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 676:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 67c:	83 f8 2f             	cmp    $0x2f,%eax
 67f:	77 23                	ja     6a4 <printf+0x148>
 681:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 688:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 68e:	89 d2                	mov    %edx,%edx
 690:	48 01 d0             	add    %rdx,%rax
 693:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 699:	83 c2 08             	add    $0x8,%edx
 69c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6a2:	eb 12                	jmp    6b6 <printf+0x15a>
 6a4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6ab:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6af:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6b6:	8b 30                	mov    (%rax),%esi
 6b8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6be:	b9 01 00 00 00       	mov    $0x1,%ecx
 6c3:	ba 0a 00 00 00       	mov    $0xa,%edx
 6c8:	89 c7                	mov    %eax,%edi
 6ca:	e8 c8 fd ff ff       	call   497 <printint>
 6cf:	e9 c1 01 00 00       	jmp    895 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6d4:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6db:	74 09                	je     6e6 <printf+0x18a>
 6dd:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6e4:	75 5e                	jne    744 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6e6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6ec:	83 f8 2f             	cmp    $0x2f,%eax
 6ef:	77 23                	ja     714 <printf+0x1b8>
 6f1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	89 d2                	mov    %edx,%edx
 700:	48 01 d0             	add    %rdx,%rax
 703:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 709:	83 c2 08             	add    $0x8,%edx
 70c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 712:	eb 12                	jmp    726 <printf+0x1ca>
 714:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 71b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 726:	8b 30                	mov    (%rax),%esi
 728:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 72e:	b9 00 00 00 00       	mov    $0x0,%ecx
 733:	ba 10 00 00 00       	mov    $0x10,%edx
 738:	89 c7                	mov    %eax,%edi
 73a:	e8 58 fd ff ff       	call   497 <printint>
 73f:	e9 51 01 00 00       	jmp    895 <printf+0x339>
      } else if(c == 's'){
 744:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 74b:	0f 85 98 00 00 00    	jne    7e9 <printf+0x28d>
        s = va_arg(ap, char*);
 751:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 757:	83 f8 2f             	cmp    $0x2f,%eax
 75a:	77 23                	ja     77f <printf+0x223>
 75c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 763:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 769:	89 d2                	mov    %edx,%edx
 76b:	48 01 d0             	add    %rdx,%rax
 76e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 774:	83 c2 08             	add    $0x8,%edx
 777:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77d:	eb 12                	jmp    791 <printf+0x235>
 77f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 786:	48 8d 50 08          	lea    0x8(%rax),%rdx
 78a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 791:	48 8b 00             	mov    (%rax),%rax
 794:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 79b:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7a2:	00 
 7a3:	75 31                	jne    7d6 <printf+0x27a>
          s = "(null)";
 7a5:	48 c7 85 48 ff ff ff 	movq   $0xba4,-0xb8(%rbp)
 7ac:	a4 0b 00 00 
        while(*s != 0){
 7b0:	eb 24                	jmp    7d6 <printf+0x27a>
          putc(fd, *s);
 7b2:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7b9:	0f b6 00             	movzbl (%rax),%eax
 7bc:	0f be d0             	movsbl %al,%edx
 7bf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7c5:	89 d6                	mov    %edx,%esi
 7c7:	89 c7                	mov    %eax,%edi
 7c9:	e8 9c fc ff ff       	call   46a <putc>
          s++;
 7ce:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7d5:	01 
        while(*s != 0){
 7d6:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7dd:	0f b6 00             	movzbl (%rax),%eax
 7e0:	84 c0                	test   %al,%al
 7e2:	75 ce                	jne    7b2 <printf+0x256>
 7e4:	e9 ac 00 00 00       	jmp    895 <printf+0x339>
        }
      } else if(c == 'c'){
 7e9:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7f0:	75 56                	jne    848 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7f2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7f8:	83 f8 2f             	cmp    $0x2f,%eax
 7fb:	77 23                	ja     820 <printf+0x2c4>
 7fd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 804:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 80a:	89 d2                	mov    %edx,%edx
 80c:	48 01 d0             	add    %rdx,%rax
 80f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 815:	83 c2 08             	add    $0x8,%edx
 818:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 81e:	eb 12                	jmp    832 <printf+0x2d6>
 820:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 827:	48 8d 50 08          	lea    0x8(%rax),%rdx
 82b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 832:	8b 00                	mov    (%rax),%eax
 834:	0f be d0             	movsbl %al,%edx
 837:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 83d:	89 d6                	mov    %edx,%esi
 83f:	89 c7                	mov    %eax,%edi
 841:	e8 24 fc ff ff       	call   46a <putc>
 846:	eb 4d                	jmp    895 <printf+0x339>
      } else if(c == '%'){
 848:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 84f:	75 1a                	jne    86b <printf+0x30f>
        putc(fd, c);
 851:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 857:	0f be d0             	movsbl %al,%edx
 85a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 860:	89 d6                	mov    %edx,%esi
 862:	89 c7                	mov    %eax,%edi
 864:	e8 01 fc ff ff       	call   46a <putc>
 869:	eb 2a                	jmp    895 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 86b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 871:	be 25 00 00 00       	mov    $0x25,%esi
 876:	89 c7                	mov    %eax,%edi
 878:	e8 ed fb ff ff       	call   46a <putc>
        putc(fd, c);
 87d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 883:	0f be d0             	movsbl %al,%edx
 886:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 88c:	89 d6                	mov    %edx,%esi
 88e:	89 c7                	mov    %eax,%edi
 890:	e8 d5 fb ff ff       	call   46a <putc>
      }
      state = 0;
 895:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 89c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 89f:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8a6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8ac:	48 63 d0             	movslq %eax,%rdx
 8af:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8b6:	48 01 d0             	add    %rdx,%rax
 8b9:	0f b6 00             	movzbl (%rax),%eax
 8bc:	84 c0                	test   %al,%al
 8be:	0f 85 3a fd ff ff    	jne    5fe <printf+0xa2>
    }
  }
}
 8c4:	90                   	nop
 8c5:	90                   	nop
 8c6:	c9                   	leave
 8c7:	c3                   	ret

00000000000008c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c8:	f3 0f 1e fa          	endbr64
 8cc:	55                   	push   %rbp
 8cd:	48 89 e5             	mov    %rsp,%rbp
 8d0:	48 83 ec 18          	sub    $0x18,%rsp
 8d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8dc:	48 83 e8 10          	sub    $0x10,%rax
 8e0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e4:	48 8b 05 35 05 00 00 	mov    0x535(%rip),%rax        # e20 <freep>
 8eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8ef:	eb 2f                	jmp    920 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f5:	48 8b 00             	mov    (%rax),%rax
 8f8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8fc:	72 17                	jb     915 <free+0x4d>
 8fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 902:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 906:	72 2f                	jb     937 <free+0x6f>
 908:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90c:	48 8b 00             	mov    (%rax),%rax
 90f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 913:	72 22                	jb     937 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 915:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 919:	48 8b 00             	mov    (%rax),%rax
 91c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 920:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 924:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 928:	73 c7                	jae    8f1 <free+0x29>
 92a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92e:	48 8b 00             	mov    (%rax),%rax
 931:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 935:	73 ba                	jae    8f1 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 937:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93b:	8b 40 08             	mov    0x8(%rax),%eax
 93e:	89 c0                	mov    %eax,%eax
 940:	48 c1 e0 04          	shl    $0x4,%rax
 944:	48 89 c2             	mov    %rax,%rdx
 947:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94b:	48 01 c2             	add    %rax,%rdx
 94e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 952:	48 8b 00             	mov    (%rax),%rax
 955:	48 39 c2             	cmp    %rax,%rdx
 958:	75 2d                	jne    987 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 95a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95e:	8b 50 08             	mov    0x8(%rax),%edx
 961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 965:	48 8b 00             	mov    (%rax),%rax
 968:	8b 40 08             	mov    0x8(%rax),%eax
 96b:	01 c2                	add    %eax,%edx
 96d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 971:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 974:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 978:	48 8b 00             	mov    (%rax),%rax
 97b:	48 8b 10             	mov    (%rax),%rdx
 97e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 982:	48 89 10             	mov    %rdx,(%rax)
 985:	eb 0e                	jmp    995 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 987:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98b:	48 8b 10             	mov    (%rax),%rdx
 98e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 992:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 999:	8b 40 08             	mov    0x8(%rax),%eax
 99c:	89 c0                	mov    %eax,%eax
 99e:	48 c1 e0 04          	shl    $0x4,%rax
 9a2:	48 89 c2             	mov    %rax,%rdx
 9a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a9:	48 01 d0             	add    %rdx,%rax
 9ac:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9b0:	75 27                	jne    9d9 <free+0x111>
    p->s.size += bp->s.size;
 9b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b6:	8b 50 08             	mov    0x8(%rax),%edx
 9b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9bd:	8b 40 08             	mov    0x8(%rax),%eax
 9c0:	01 c2                	add    %eax,%edx
 9c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c6:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9cd:	48 8b 10             	mov    (%rax),%rdx
 9d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d4:	48 89 10             	mov    %rdx,(%rax)
 9d7:	eb 0b                	jmp    9e4 <free+0x11c>
  } else
    p->s.ptr = bp;
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9e1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e8:	48 89 05 31 04 00 00 	mov    %rax,0x431(%rip)        # e20 <freep>
}
 9ef:	90                   	nop
 9f0:	c9                   	leave
 9f1:	c3                   	ret

00000000000009f2 <morecore>:

static Header*
morecore(uint nu)
{
 9f2:	f3 0f 1e fa          	endbr64
 9f6:	55                   	push   %rbp
 9f7:	48 89 e5             	mov    %rsp,%rbp
 9fa:	48 83 ec 20          	sub    $0x20,%rsp
 9fe:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a01:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a08:	77 07                	ja     a11 <morecore+0x1f>
    nu = 4096;
 a0a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a11:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a14:	c1 e0 04             	shl    $0x4,%eax
 a17:	89 c7                	mov    %eax,%edi
 a19:	e8 24 fa ff ff       	call   442 <sbrk>
 a1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a22:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a27:	75 07                	jne    a30 <morecore+0x3e>
    return 0;
 a29:	b8 00 00 00 00       	mov    $0x0,%eax
 a2e:	eb 29                	jmp    a59 <morecore+0x67>
  hp = (Header*)p;
 a30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a34:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a3f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a46:	48 83 c0 10          	add    $0x10,%rax
 a4a:	48 89 c7             	mov    %rax,%rdi
 a4d:	e8 76 fe ff ff       	call   8c8 <free>
  return freep;
 a52:	48 8b 05 c7 03 00 00 	mov    0x3c7(%rip),%rax        # e20 <freep>
}
 a59:	c9                   	leave
 a5a:	c3                   	ret

0000000000000a5b <malloc>:

void*
malloc(uint nbytes)
{
 a5b:	f3 0f 1e fa          	endbr64
 a5f:	55                   	push   %rbp
 a60:	48 89 e5             	mov    %rsp,%rbp
 a63:	48 83 ec 30          	sub    $0x30,%rsp
 a67:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a6d:	48 83 c0 0f          	add    $0xf,%rax
 a71:	48 c1 e8 04          	shr    $0x4,%rax
 a75:	83 c0 01             	add    $0x1,%eax
 a78:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a7b:	48 8b 05 9e 03 00 00 	mov    0x39e(%rip),%rax        # e20 <freep>
 a82:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a86:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a8b:	75 2b                	jne    ab8 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a8d:	48 c7 45 f0 10 0e 00 	movq   $0xe10,-0x10(%rbp)
 a94:	00 
 a95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a99:	48 89 05 80 03 00 00 	mov    %rax,0x380(%rip)        # e20 <freep>
 aa0:	48 8b 05 79 03 00 00 	mov    0x379(%rip),%rax        # e20 <freep>
 aa7:	48 89 05 62 03 00 00 	mov    %rax,0x362(%rip)        # e10 <base>
    base.s.size = 0;
 aae:	c7 05 60 03 00 00 00 	movl   $0x0,0x360(%rip)        # e18 <base+0x8>
 ab5:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 abc:	48 8b 00             	mov    (%rax),%rax
 abf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac7:	8b 40 08             	mov    0x8(%rax),%eax
 aca:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 acd:	72 5f                	jb     b2e <malloc+0xd3>
      if(p->s.size == nunits)
 acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad3:	8b 40 08             	mov    0x8(%rax),%eax
 ad6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ad9:	75 10                	jne    aeb <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 adb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adf:	48 8b 10             	mov    (%rax),%rdx
 ae2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae6:	48 89 10             	mov    %rdx,(%rax)
 ae9:	eb 2e                	jmp    b19 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 aeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aef:	8b 40 08             	mov    0x8(%rax),%eax
 af2:	2b 45 ec             	sub    -0x14(%rbp),%eax
 af5:	89 c2                	mov    %eax,%edx
 af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afb:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b02:	8b 40 08             	mov    0x8(%rax),%eax
 b05:	89 c0                	mov    %eax,%eax
 b07:	48 c1 e0 04          	shl    $0x4,%rax
 b0b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b13:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b16:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1d:	48 89 05 fc 02 00 00 	mov    %rax,0x2fc(%rip)        # e20 <freep>
      return (void*)(p + 1);
 b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b28:	48 83 c0 10          	add    $0x10,%rax
 b2c:	eb 41                	jmp    b6f <malloc+0x114>
    }
    if(p == freep)
 b2e:	48 8b 05 eb 02 00 00 	mov    0x2eb(%rip),%rax        # e20 <freep>
 b35:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b39:	75 1c                	jne    b57 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b3e:	89 c7                	mov    %eax,%edi
 b40:	e8 ad fe ff ff       	call   9f2 <morecore>
 b45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b49:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b4e:	75 07                	jne    b57 <malloc+0xfc>
        return 0;
 b50:	b8 00 00 00 00       	mov    $0x0,%eax
 b55:	eb 18                	jmp    b6f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b63:	48 8b 00             	mov    (%rax),%rax
 b66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b6a:	e9 54 ff ff ff       	jmp    ac3 <malloc+0x68>
  }
}
 b6f:	c9                   	leave
 b70:	c3                   	ret
