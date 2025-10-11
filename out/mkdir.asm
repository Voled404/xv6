
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
  19:	48 c7 c6 91 0b 00 00 	mov    $0xb91,%rsi
  20:	bf 02 00 00 00       	mov    $0x2,%edi
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 4d 05 00 00       	call   57c <printf>
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
  7a:	48 c7 c6 a8 0b 00 00 	mov    $0xba8,%rsi
  81:	bf 02 00 00 00       	mov    $0x2,%edi
  86:	b8 00 00 00 00       	mov    $0x0,%eax
  8b:	e8 ec 04 00 00       	call   57c <printf>
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

000000000000046a <getfavnum>:
SYSCALL(getfavnum)
 46a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret

0000000000000472 <halt>:
SYSCALL(halt)
 472:	b8 1d 00 00 00       	mov    $0x1d,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

000000000000047a <getcount>:
SYSCALL(getcount)
 47a:	b8 1e 00 00 00       	mov    $0x1e,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret

0000000000000482 <killrandom>:
SYSCALL(killrandom)
 482:	b8 1f 00 00 00       	mov    $0x1f,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret

000000000000048a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 48a:	f3 0f 1e fa          	endbr64
 48e:	55                   	push   %rbp
 48f:	48 89 e5             	mov    %rsp,%rbp
 492:	48 83 ec 10          	sub    $0x10,%rsp
 496:	89 7d fc             	mov    %edi,-0x4(%rbp)
 499:	89 f0                	mov    %esi,%eax
 49b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 49e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a5:	ba 01 00 00 00       	mov    $0x1,%edx
 4aa:	48 89 ce             	mov    %rcx,%rsi
 4ad:	89 c7                	mov    %eax,%edi
 4af:	e8 26 ff ff ff       	call   3da <write>
}
 4b4:	90                   	nop
 4b5:	c9                   	leave
 4b6:	c3                   	ret

00000000000004b7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b7:	f3 0f 1e fa          	endbr64
 4bb:	55                   	push   %rbp
 4bc:	48 89 e5             	mov    %rsp,%rbp
 4bf:	48 83 ec 30          	sub    $0x30,%rsp
 4c3:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4c6:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4c9:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4cc:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4d6:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4da:	74 17                	je     4f3 <printint+0x3c>
 4dc:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4e0:	79 11                	jns    4f3 <printint+0x3c>
    neg = 1;
 4e2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4e9:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4ec:	f7 d8                	neg    %eax
 4ee:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4f1:	eb 06                	jmp    4f9 <printint+0x42>
  } else {
    x = xx;
 4f3:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4f6:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 500:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 503:	8b 45 f4             	mov    -0xc(%rbp),%eax
 506:	ba 00 00 00 00       	mov    $0x0,%edx
 50b:	f7 f6                	div    %esi
 50d:	89 d1                	mov    %edx,%ecx
 50f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 512:	8d 50 01             	lea    0x1(%rax),%edx
 515:	89 55 fc             	mov    %edx,-0x4(%rbp)
 518:	89 ca                	mov    %ecx,%edx
 51a:	0f b6 92 10 0e 00 00 	movzbl 0xe10(%rdx),%edx
 521:	48 98                	cltq
 523:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 527:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 52a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 52d:	ba 00 00 00 00       	mov    $0x0,%edx
 532:	f7 f7                	div    %edi
 534:	89 45 f4             	mov    %eax,-0xc(%rbp)
 537:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 53b:	75 c3                	jne    500 <printint+0x49>
  if(neg)
 53d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 541:	74 2b                	je     56e <printint+0xb7>
    buf[i++] = '-';
 543:	8b 45 fc             	mov    -0x4(%rbp),%eax
 546:	8d 50 01             	lea    0x1(%rax),%edx
 549:	89 55 fc             	mov    %edx,-0x4(%rbp)
 54c:	48 98                	cltq
 54e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 553:	eb 19                	jmp    56e <printint+0xb7>
    putc(fd, buf[i]);
 555:	8b 45 fc             	mov    -0x4(%rbp),%eax
 558:	48 98                	cltq
 55a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 55f:	0f be d0             	movsbl %al,%edx
 562:	8b 45 dc             	mov    -0x24(%rbp),%eax
 565:	89 d6                	mov    %edx,%esi
 567:	89 c7                	mov    %eax,%edi
 569:	e8 1c ff ff ff       	call   48a <putc>
  while(--i >= 0)
 56e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 572:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 576:	79 dd                	jns    555 <printint+0x9e>
}
 578:	90                   	nop
 579:	90                   	nop
 57a:	c9                   	leave
 57b:	c3                   	ret

000000000000057c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 57c:	f3 0f 1e fa          	endbr64
 580:	55                   	push   %rbp
 581:	48 89 e5             	mov    %rsp,%rbp
 584:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 58b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 591:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 598:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 59f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5a6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5ad:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5b4:	84 c0                	test   %al,%al
 5b6:	74 20                	je     5d8 <printf+0x5c>
 5b8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5bc:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5c0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5c4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5c8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5cc:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5d0:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5d4:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5d8:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5df:	00 00 00 
 5e2:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5e9:	00 00 00 
 5ec:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5f0:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5f7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5fe:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 605:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 60c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 60f:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 616:	00 00 00 
 619:	e9 a8 02 00 00       	jmp    8c6 <printf+0x34a>
    c = fmt[i] & 0xff;
 61e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 624:	48 63 d0             	movslq %eax,%rdx
 627:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 62e:	48 01 d0             	add    %rdx,%rax
 631:	0f b6 00             	movzbl (%rax),%eax
 634:	0f be c0             	movsbl %al,%eax
 637:	25 ff 00 00 00       	and    $0xff,%eax
 63c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 642:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 649:	75 35                	jne    680 <printf+0x104>
      if(c == '%'){
 64b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 652:	75 0f                	jne    663 <printf+0xe7>
        state = '%';
 654:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 65b:	00 00 00 
 65e:	e9 5c 02 00 00       	jmp    8bf <printf+0x343>
      } else {
        putc(fd, c);
 663:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 669:	0f be d0             	movsbl %al,%edx
 66c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 672:	89 d6                	mov    %edx,%esi
 674:	89 c7                	mov    %eax,%edi
 676:	e8 0f fe ff ff       	call   48a <putc>
 67b:	e9 3f 02 00 00       	jmp    8bf <printf+0x343>
      }
    } else if(state == '%'){
 680:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 687:	0f 85 32 02 00 00    	jne    8bf <printf+0x343>
      if(c == 'd'){
 68d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 694:	75 5e                	jne    6f4 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 696:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 69c:	83 f8 2f             	cmp    $0x2f,%eax
 69f:	77 23                	ja     6c4 <printf+0x148>
 6a1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6a8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ae:	89 d2                	mov    %edx,%edx
 6b0:	48 01 d0             	add    %rdx,%rax
 6b3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b9:	83 c2 08             	add    $0x8,%edx
 6bc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6c2:	eb 12                	jmp    6d6 <printf+0x15a>
 6c4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6cb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6cf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6d6:	8b 30                	mov    (%rax),%esi
 6d8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6de:	b9 01 00 00 00       	mov    $0x1,%ecx
 6e3:	ba 0a 00 00 00       	mov    $0xa,%edx
 6e8:	89 c7                	mov    %eax,%edi
 6ea:	e8 c8 fd ff ff       	call   4b7 <printint>
 6ef:	e9 c1 01 00 00       	jmp    8b5 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6f4:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6fb:	74 09                	je     706 <printf+0x18a>
 6fd:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 704:	75 5e                	jne    764 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 706:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 70c:	83 f8 2f             	cmp    $0x2f,%eax
 70f:	77 23                	ja     734 <printf+0x1b8>
 711:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 718:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71e:	89 d2                	mov    %edx,%edx
 720:	48 01 d0             	add    %rdx,%rax
 723:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 729:	83 c2 08             	add    $0x8,%edx
 72c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 732:	eb 12                	jmp    746 <printf+0x1ca>
 734:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 73b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 73f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 746:	8b 30                	mov    (%rax),%esi
 748:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 74e:	b9 00 00 00 00       	mov    $0x0,%ecx
 753:	ba 10 00 00 00       	mov    $0x10,%edx
 758:	89 c7                	mov    %eax,%edi
 75a:	e8 58 fd ff ff       	call   4b7 <printint>
 75f:	e9 51 01 00 00       	jmp    8b5 <printf+0x339>
      } else if(c == 's'){
 764:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 76b:	0f 85 98 00 00 00    	jne    809 <printf+0x28d>
        s = va_arg(ap, char*);
 771:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 777:	83 f8 2f             	cmp    $0x2f,%eax
 77a:	77 23                	ja     79f <printf+0x223>
 77c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 783:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 789:	89 d2                	mov    %edx,%edx
 78b:	48 01 d0             	add    %rdx,%rax
 78e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 794:	83 c2 08             	add    $0x8,%edx
 797:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 79d:	eb 12                	jmp    7b1 <printf+0x235>
 79f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7a6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7aa:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7b1:	48 8b 00             	mov    (%rax),%rax
 7b4:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7bb:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7c2:	00 
 7c3:	75 31                	jne    7f6 <printf+0x27a>
          s = "(null)";
 7c5:	48 c7 85 48 ff ff ff 	movq   $0xbc4,-0xb8(%rbp)
 7cc:	c4 0b 00 00 
        while(*s != 0){
 7d0:	eb 24                	jmp    7f6 <printf+0x27a>
          putc(fd, *s);
 7d2:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7d9:	0f b6 00             	movzbl (%rax),%eax
 7dc:	0f be d0             	movsbl %al,%edx
 7df:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e5:	89 d6                	mov    %edx,%esi
 7e7:	89 c7                	mov    %eax,%edi
 7e9:	e8 9c fc ff ff       	call   48a <putc>
          s++;
 7ee:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7f5:	01 
        while(*s != 0){
 7f6:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7fd:	0f b6 00             	movzbl (%rax),%eax
 800:	84 c0                	test   %al,%al
 802:	75 ce                	jne    7d2 <printf+0x256>
 804:	e9 ac 00 00 00       	jmp    8b5 <printf+0x339>
        }
      } else if(c == 'c'){
 809:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 810:	75 56                	jne    868 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 812:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 818:	83 f8 2f             	cmp    $0x2f,%eax
 81b:	77 23                	ja     840 <printf+0x2c4>
 81d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 824:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 82a:	89 d2                	mov    %edx,%edx
 82c:	48 01 d0             	add    %rdx,%rax
 82f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 835:	83 c2 08             	add    $0x8,%edx
 838:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 83e:	eb 12                	jmp    852 <printf+0x2d6>
 840:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 847:	48 8d 50 08          	lea    0x8(%rax),%rdx
 84b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 852:	8b 00                	mov    (%rax),%eax
 854:	0f be d0             	movsbl %al,%edx
 857:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85d:	89 d6                	mov    %edx,%esi
 85f:	89 c7                	mov    %eax,%edi
 861:	e8 24 fc ff ff       	call   48a <putc>
 866:	eb 4d                	jmp    8b5 <printf+0x339>
      } else if(c == '%'){
 868:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 86f:	75 1a                	jne    88b <printf+0x30f>
        putc(fd, c);
 871:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 877:	0f be d0             	movsbl %al,%edx
 87a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 880:	89 d6                	mov    %edx,%esi
 882:	89 c7                	mov    %eax,%edi
 884:	e8 01 fc ff ff       	call   48a <putc>
 889:	eb 2a                	jmp    8b5 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 88b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 891:	be 25 00 00 00       	mov    $0x25,%esi
 896:	89 c7                	mov    %eax,%edi
 898:	e8 ed fb ff ff       	call   48a <putc>
        putc(fd, c);
 89d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8a3:	0f be d0             	movsbl %al,%edx
 8a6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ac:	89 d6                	mov    %edx,%esi
 8ae:	89 c7                	mov    %eax,%edi
 8b0:	e8 d5 fb ff ff       	call   48a <putc>
      }
      state = 0;
 8b5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8bc:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8bf:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8c6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8cc:	48 63 d0             	movslq %eax,%rdx
 8cf:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8d6:	48 01 d0             	add    %rdx,%rax
 8d9:	0f b6 00             	movzbl (%rax),%eax
 8dc:	84 c0                	test   %al,%al
 8de:	0f 85 3a fd ff ff    	jne    61e <printf+0xa2>
    }
  }
}
 8e4:	90                   	nop
 8e5:	90                   	nop
 8e6:	c9                   	leave
 8e7:	c3                   	ret

00000000000008e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e8:	f3 0f 1e fa          	endbr64
 8ec:	55                   	push   %rbp
 8ed:	48 89 e5             	mov    %rsp,%rbp
 8f0:	48 83 ec 18          	sub    $0x18,%rsp
 8f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8fc:	48 83 e8 10          	sub    $0x10,%rax
 900:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 904:	48 8b 05 35 05 00 00 	mov    0x535(%rip),%rax        # e40 <freep>
 90b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 90f:	eb 2f                	jmp    940 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 911:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 915:	48 8b 00             	mov    (%rax),%rax
 918:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 91c:	72 17                	jb     935 <free+0x4d>
 91e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 922:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 926:	72 2f                	jb     957 <free+0x6f>
 928:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92c:	48 8b 00             	mov    (%rax),%rax
 92f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 933:	72 22                	jb     957 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 935:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 939:	48 8b 00             	mov    (%rax),%rax
 93c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 940:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 944:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 948:	73 c7                	jae    911 <free+0x29>
 94a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94e:	48 8b 00             	mov    (%rax),%rax
 951:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 955:	73 ba                	jae    911 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 957:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95b:	8b 40 08             	mov    0x8(%rax),%eax
 95e:	89 c0                	mov    %eax,%eax
 960:	48 c1 e0 04          	shl    $0x4,%rax
 964:	48 89 c2             	mov    %rax,%rdx
 967:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96b:	48 01 c2             	add    %rax,%rdx
 96e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 972:	48 8b 00             	mov    (%rax),%rax
 975:	48 39 c2             	cmp    %rax,%rdx
 978:	75 2d                	jne    9a7 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 97a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97e:	8b 50 08             	mov    0x8(%rax),%edx
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	48 8b 00             	mov    (%rax),%rax
 988:	8b 40 08             	mov    0x8(%rax),%eax
 98b:	01 c2                	add    %eax,%edx
 98d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 991:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 994:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 998:	48 8b 00             	mov    (%rax),%rax
 99b:	48 8b 10             	mov    (%rax),%rdx
 99e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a2:	48 89 10             	mov    %rdx,(%rax)
 9a5:	eb 0e                	jmp    9b5 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 9a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ab:	48 8b 10             	mov    (%rax),%rdx
 9ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b2:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b9:	8b 40 08             	mov    0x8(%rax),%eax
 9bc:	89 c0                	mov    %eax,%eax
 9be:	48 c1 e0 04          	shl    $0x4,%rax
 9c2:	48 89 c2             	mov    %rax,%rdx
 9c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c9:	48 01 d0             	add    %rdx,%rax
 9cc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9d0:	75 27                	jne    9f9 <free+0x111>
    p->s.size += bp->s.size;
 9d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d6:	8b 50 08             	mov    0x8(%rax),%edx
 9d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9dd:	8b 40 08             	mov    0x8(%rax),%eax
 9e0:	01 c2                	add    %eax,%edx
 9e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e6:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ed:	48 8b 10             	mov    (%rax),%rdx
 9f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f4:	48 89 10             	mov    %rdx,(%rax)
 9f7:	eb 0b                	jmp    a04 <free+0x11c>
  } else
    p->s.ptr = bp;
 9f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a01:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a08:	48 89 05 31 04 00 00 	mov    %rax,0x431(%rip)        # e40 <freep>
}
 a0f:	90                   	nop
 a10:	c9                   	leave
 a11:	c3                   	ret

0000000000000a12 <morecore>:

static Header*
morecore(uint nu)
{
 a12:	f3 0f 1e fa          	endbr64
 a16:	55                   	push   %rbp
 a17:	48 89 e5             	mov    %rsp,%rbp
 a1a:	48 83 ec 20          	sub    $0x20,%rsp
 a1e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a21:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a28:	77 07                	ja     a31 <morecore+0x1f>
    nu = 4096;
 a2a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a31:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a34:	c1 e0 04             	shl    $0x4,%eax
 a37:	89 c7                	mov    %eax,%edi
 a39:	e8 04 fa ff ff       	call   442 <sbrk>
 a3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a42:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a47:	75 07                	jne    a50 <morecore+0x3e>
    return 0;
 a49:	b8 00 00 00 00       	mov    $0x0,%eax
 a4e:	eb 29                	jmp    a79 <morecore+0x67>
  hp = (Header*)p;
 a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a54:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a5c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a5f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a66:	48 83 c0 10          	add    $0x10,%rax
 a6a:	48 89 c7             	mov    %rax,%rdi
 a6d:	e8 76 fe ff ff       	call   8e8 <free>
  return freep;
 a72:	48 8b 05 c7 03 00 00 	mov    0x3c7(%rip),%rax        # e40 <freep>
}
 a79:	c9                   	leave
 a7a:	c3                   	ret

0000000000000a7b <malloc>:

void*
malloc(uint nbytes)
{
 a7b:	f3 0f 1e fa          	endbr64
 a7f:	55                   	push   %rbp
 a80:	48 89 e5             	mov    %rsp,%rbp
 a83:	48 83 ec 30          	sub    $0x30,%rsp
 a87:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a8a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a8d:	48 83 c0 0f          	add    $0xf,%rax
 a91:	48 c1 e8 04          	shr    $0x4,%rax
 a95:	83 c0 01             	add    $0x1,%eax
 a98:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a9b:	48 8b 05 9e 03 00 00 	mov    0x39e(%rip),%rax        # e40 <freep>
 aa2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 aa6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 aab:	75 2b                	jne    ad8 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 aad:	48 c7 45 f0 30 0e 00 	movq   $0xe30,-0x10(%rbp)
 ab4:	00 
 ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab9:	48 89 05 80 03 00 00 	mov    %rax,0x380(%rip)        # e40 <freep>
 ac0:	48 8b 05 79 03 00 00 	mov    0x379(%rip),%rax        # e40 <freep>
 ac7:	48 89 05 62 03 00 00 	mov    %rax,0x362(%rip)        # e30 <base>
    base.s.size = 0;
 ace:	c7 05 60 03 00 00 00 	movl   $0x0,0x360(%rip)        # e38 <base+0x8>
 ad5:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 adc:	48 8b 00             	mov    (%rax),%rax
 adf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae7:	8b 40 08             	mov    0x8(%rax),%eax
 aea:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aed:	72 5f                	jb     b4e <malloc+0xd3>
      if(p->s.size == nunits)
 aef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af3:	8b 40 08             	mov    0x8(%rax),%eax
 af6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 af9:	75 10                	jne    b0b <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aff:	48 8b 10             	mov    (%rax),%rdx
 b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b06:	48 89 10             	mov    %rdx,(%rax)
 b09:	eb 2e                	jmp    b39 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0f:	8b 40 08             	mov    0x8(%rax),%eax
 b12:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b15:	89 c2                	mov    %eax,%edx
 b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b22:	8b 40 08             	mov    0x8(%rax),%eax
 b25:	89 c0                	mov    %eax,%eax
 b27:	48 c1 e0 04          	shl    $0x4,%rax
 b2b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b33:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b36:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b3d:	48 89 05 fc 02 00 00 	mov    %rax,0x2fc(%rip)        # e40 <freep>
      return (void*)(p + 1);
 b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b48:	48 83 c0 10          	add    $0x10,%rax
 b4c:	eb 41                	jmp    b8f <malloc+0x114>
    }
    if(p == freep)
 b4e:	48 8b 05 eb 02 00 00 	mov    0x2eb(%rip),%rax        # e40 <freep>
 b55:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b59:	75 1c                	jne    b77 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b5e:	89 c7                	mov    %eax,%edi
 b60:	e8 ad fe ff ff       	call   a12 <morecore>
 b65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b69:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b6e:	75 07                	jne    b77 <malloc+0xfc>
        return 0;
 b70:	b8 00 00 00 00       	mov    $0x0,%eax
 b75:	eb 18                	jmp    b8f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b83:	48 8b 00             	mov    (%rax),%rax
 b86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b8a:	e9 54 ff ff ff       	jmp    ae3 <malloc+0x68>
  }
}
 b8f:	c9                   	leave
 b90:	c3                   	ret
