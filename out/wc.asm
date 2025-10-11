
fs/wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 30          	sub    $0x30,%rsp
   c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  13:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  1a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  1d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  20:	8b 45 f4             	mov    -0xc(%rbp),%eax
  23:	89 45 f8             	mov    %eax,-0x8(%rbp)
  inword = 0;
  26:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2d:	eb 69                	jmp    98 <wc+0x98>
    for(i=0; i<n; i++){
  2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  36:	eb 58                	jmp    90 <wc+0x90>
      c++;
  38:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
      if(buf[i] == '\n')
  3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3f:	48 98                	cltq
  41:	0f b6 80 80 0f 00 00 	movzbl 0xf80(%rax),%eax
  48:	3c 0a                	cmp    $0xa,%al
  4a:	75 04                	jne    50 <wc+0x50>
        l++;
  4c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	48 98                	cltq
  55:	0f b6 80 80 0f 00 00 	movzbl 0xf80(%rax),%eax
  5c:	0f be c0             	movsbl %al,%eax
  5f:	89 c6                	mov    %eax,%esi
  61:	48 c7 c7 c2 0c 00 00 	mov    $0xcc2,%rdi
  68:	e8 b9 02 00 00       	call   326 <strchr>
  6d:	48 85 c0             	test   %rax,%rax
  70:	74 09                	je     7b <wc+0x7b>
        inword = 0;
  72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  79:	eb 11                	jmp    8c <wc+0x8c>
      else if(!inword){
  7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  7f:	75 0b                	jne    8c <wc+0x8c>
        w++;
  81:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
        inword = 1;
  85:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    for(i=0; i<n; i++){
  8c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  90:	8b 45 fc             	mov    -0x4(%rbp),%eax
  93:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  96:	7c a0                	jl     38 <wc+0x38>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  98:	8b 45 dc             	mov    -0x24(%rbp),%eax
  9b:	ba 00 02 00 00       	mov    $0x200,%edx
  a0:	48 c7 c6 80 0f 00 00 	mov    $0xf80,%rsi
  a7:	89 c7                	mov    %eax,%edi
  a9:	e8 6d 04 00 00       	call   51b <read>
  ae:	89 45 e8             	mov    %eax,-0x18(%rbp)
  b1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  b5:	0f 8f 74 ff ff ff    	jg     2f <wc+0x2f>
      }
    }
  }
  if(n < 0){
  bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  bf:	79 1b                	jns    dc <wc+0xdc>
    printf(1, "wc: read error\n");
  c1:	48 c7 c6 c8 0c 00 00 	mov    $0xcc8,%rsi
  c8:	bf 01 00 00 00       	mov    $0x1,%edi
  cd:	b8 00 00 00 00       	mov    $0x0,%eax
  d2:	e8 d6 05 00 00       	call   6ad <printf>
    exit();
  d7:	e8 27 04 00 00       	call   503 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  dc:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  e0:	8b 4d f0             	mov    -0x10(%rbp),%ecx
  e3:	8b 55 f4             	mov    -0xc(%rbp),%edx
  e6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e9:	49 89 f1             	mov    %rsi,%r9
  ec:	41 89 c8             	mov    %ecx,%r8d
  ef:	89 d1                	mov    %edx,%ecx
  f1:	89 c2                	mov    %eax,%edx
  f3:	48 c7 c6 d8 0c 00 00 	mov    $0xcd8,%rsi
  fa:	bf 01 00 00 00       	mov    $0x1,%edi
  ff:	b8 00 00 00 00       	mov    $0x0,%eax
 104:	e8 a4 05 00 00       	call   6ad <printf>
}
 109:	90                   	nop
 10a:	c9                   	leave
 10b:	c3                   	ret

000000000000010c <main>:

int
main(int argc, char *argv[])
{
 10c:	f3 0f 1e fa          	endbr64
 110:	55                   	push   %rbp
 111:	48 89 e5             	mov    %rsp,%rbp
 114:	48 83 ec 20          	sub    $0x20,%rsp
 118:	89 7d ec             	mov    %edi,-0x14(%rbp)
 11b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
 11f:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
 123:	7f 16                	jg     13b <main+0x2f>
    wc(0, "");
 125:	48 c7 c6 e5 0c 00 00 	mov    $0xce5,%rsi
 12c:	bf 00 00 00 00       	mov    $0x0,%edi
 131:	e8 ca fe ff ff       	call   0 <wc>
    exit();
 136:	e8 c8 03 00 00       	call   503 <exit>
  }

  for(i = 1; i < argc; i++){
 13b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 142:	e9 94 00 00 00       	jmp    1db <main+0xcf>
    if((fd = open(argv[i], 0)) < 0){
 147:	8b 45 fc             	mov    -0x4(%rbp),%eax
 14a:	48 98                	cltq
 14c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 153:	00 
 154:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 158:	48 01 d0             	add    %rdx,%rax
 15b:	48 8b 00             	mov    (%rax),%rax
 15e:	be 00 00 00 00       	mov    $0x0,%esi
 163:	48 89 c7             	mov    %rax,%rdi
 166:	e8 d8 03 00 00       	call   543 <open>
 16b:	89 45 f8             	mov    %eax,-0x8(%rbp)
 16e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 172:	79 35                	jns    1a9 <main+0x9d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 174:	8b 45 fc             	mov    -0x4(%rbp),%eax
 177:	48 98                	cltq
 179:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 180:	00 
 181:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 185:	48 01 d0             	add    %rdx,%rax
 188:	48 8b 00             	mov    (%rax),%rax
 18b:	48 89 c2             	mov    %rax,%rdx
 18e:	48 c7 c6 e6 0c 00 00 	mov    $0xce6,%rsi
 195:	bf 01 00 00 00       	mov    $0x1,%edi
 19a:	b8 00 00 00 00       	mov    $0x0,%eax
 19f:	e8 09 05 00 00       	call   6ad <printf>
      exit();
 1a4:	e8 5a 03 00 00       	call   503 <exit>
    }
    wc(fd, argv[i]);
 1a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1ac:	48 98                	cltq
 1ae:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 1b5:	00 
 1b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 1ba:	48 01 d0             	add    %rdx,%rax
 1bd:	48 8b 10             	mov    (%rax),%rdx
 1c0:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1c3:	48 89 d6             	mov    %rdx,%rsi
 1c6:	89 c7                	mov    %eax,%edi
 1c8:	e8 33 fe ff ff       	call   0 <wc>
    close(fd);
 1cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1d0:	89 c7                	mov    %eax,%edi
 1d2:	e8 54 03 00 00       	call   52b <close>
  for(i = 1; i < argc; i++){
 1d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1de:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 1e1:	0f 8c 60 ff ff ff    	jl     147 <main+0x3b>
  }
  exit();
 1e7:	e8 17 03 00 00       	call   503 <exit>

00000000000001ec <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1ec:	55                   	push   %rbp
 1ed:	48 89 e5             	mov    %rsp,%rbp
 1f0:	48 83 ec 10          	sub    $0x10,%rsp
 1f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1f8:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1fb:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 1fe:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 202:	8b 55 f0             	mov    -0x10(%rbp),%edx
 205:	8b 45 f4             	mov    -0xc(%rbp),%eax
 208:	48 89 ce             	mov    %rcx,%rsi
 20b:	48 89 f7             	mov    %rsi,%rdi
 20e:	89 d1                	mov    %edx,%ecx
 210:	fc                   	cld
 211:	f3 aa                	rep stos %al,%es:(%rdi)
 213:	89 ca                	mov    %ecx,%edx
 215:	48 89 fe             	mov    %rdi,%rsi
 218:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 21c:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 21f:	90                   	nop
 220:	c9                   	leave
 221:	c3                   	ret

0000000000000222 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 222:	f3 0f 1e fa          	endbr64
 226:	55                   	push   %rbp
 227:	48 89 e5             	mov    %rsp,%rbp
 22a:	48 83 ec 20          	sub    $0x20,%rsp
 22e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 232:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 236:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 23a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 23e:	90                   	nop
 23f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 243:	48 8d 42 01          	lea    0x1(%rdx),%rax
 247:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 24b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 24f:	48 8d 48 01          	lea    0x1(%rax),%rcx
 253:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 257:	0f b6 12             	movzbl (%rdx),%edx
 25a:	88 10                	mov    %dl,(%rax)
 25c:	0f b6 00             	movzbl (%rax),%eax
 25f:	84 c0                	test   %al,%al
 261:	75 dc                	jne    23f <strcpy+0x1d>
    ;
  return os;
 263:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 267:	c9                   	leave
 268:	c3                   	ret

0000000000000269 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 269:	f3 0f 1e fa          	endbr64
 26d:	55                   	push   %rbp
 26e:	48 89 e5             	mov    %rsp,%rbp
 271:	48 83 ec 10          	sub    $0x10,%rsp
 275:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 279:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 27d:	eb 0a                	jmp    289 <strcmp+0x20>
    p++, q++;
 27f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 284:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 289:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 28d:	0f b6 00             	movzbl (%rax),%eax
 290:	84 c0                	test   %al,%al
 292:	74 12                	je     2a6 <strcmp+0x3d>
 294:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 298:	0f b6 10             	movzbl (%rax),%edx
 29b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 29f:	0f b6 00             	movzbl (%rax),%eax
 2a2:	38 c2                	cmp    %al,%dl
 2a4:	74 d9                	je     27f <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 2a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2aa:	0f b6 00             	movzbl (%rax),%eax
 2ad:	0f b6 d0             	movzbl %al,%edx
 2b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 2b4:	0f b6 00             	movzbl (%rax),%eax
 2b7:	0f b6 c0             	movzbl %al,%eax
 2ba:	29 c2                	sub    %eax,%edx
 2bc:	89 d0                	mov    %edx,%eax
}
 2be:	c9                   	leave
 2bf:	c3                   	ret

00000000000002c0 <strlen>:

uint
strlen(char *s)
{
 2c0:	f3 0f 1e fa          	endbr64
 2c4:	55                   	push   %rbp
 2c5:	48 89 e5             	mov    %rsp,%rbp
 2c8:	48 83 ec 18          	sub    $0x18,%rsp
 2cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 2d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2d7:	eb 04                	jmp    2dd <strlen+0x1d>
 2d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 2dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2e0:	48 63 d0             	movslq %eax,%rdx
 2e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2e7:	48 01 d0             	add    %rdx,%rax
 2ea:	0f b6 00             	movzbl (%rax),%eax
 2ed:	84 c0                	test   %al,%al
 2ef:	75 e8                	jne    2d9 <strlen+0x19>
    ;
  return n;
 2f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2f4:	c9                   	leave
 2f5:	c3                   	ret

00000000000002f6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f6:	f3 0f 1e fa          	endbr64
 2fa:	55                   	push   %rbp
 2fb:	48 89 e5             	mov    %rsp,%rbp
 2fe:	48 83 ec 10          	sub    $0x10,%rsp
 302:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 306:	89 75 f4             	mov    %esi,-0xc(%rbp)
 309:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 30c:	8b 55 f0             	mov    -0x10(%rbp),%edx
 30f:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 316:	89 ce                	mov    %ecx,%esi
 318:	48 89 c7             	mov    %rax,%rdi
 31b:	e8 cc fe ff ff       	call   1ec <stosb>
  return dst;
 320:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 324:	c9                   	leave
 325:	c3                   	ret

0000000000000326 <strchr>:

char*
strchr(const char *s, char c)
{
 326:	f3 0f 1e fa          	endbr64
 32a:	55                   	push   %rbp
 32b:	48 89 e5             	mov    %rsp,%rbp
 32e:	48 83 ec 10          	sub    $0x10,%rsp
 332:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 336:	89 f0                	mov    %esi,%eax
 338:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 33b:	eb 17                	jmp    354 <strchr+0x2e>
    if(*s == c)
 33d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 341:	0f b6 00             	movzbl (%rax),%eax
 344:	38 45 f4             	cmp    %al,-0xc(%rbp)
 347:	75 06                	jne    34f <strchr+0x29>
      return (char*)s;
 349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 34d:	eb 15                	jmp    364 <strchr+0x3e>
  for(; *s; s++)
 34f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 358:	0f b6 00             	movzbl (%rax),%eax
 35b:	84 c0                	test   %al,%al
 35d:	75 de                	jne    33d <strchr+0x17>
  return 0;
 35f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 364:	c9                   	leave
 365:	c3                   	ret

0000000000000366 <gets>:

char*
gets(char *buf, int max)
{
 366:	f3 0f 1e fa          	endbr64
 36a:	55                   	push   %rbp
 36b:	48 89 e5             	mov    %rsp,%rbp
 36e:	48 83 ec 20          	sub    $0x20,%rsp
 372:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 376:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 379:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 380:	eb 48                	jmp    3ca <gets+0x64>
    cc = read(0, &c, 1);
 382:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 386:	ba 01 00 00 00       	mov    $0x1,%edx
 38b:	48 89 c6             	mov    %rax,%rsi
 38e:	bf 00 00 00 00       	mov    $0x0,%edi
 393:	e8 83 01 00 00       	call   51b <read>
 398:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 39b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 39f:	7e 36                	jle    3d7 <gets+0x71>
      break;
    buf[i++] = c;
 3a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3a4:	8d 50 01             	lea    0x1(%rax),%edx
 3a7:	89 55 fc             	mov    %edx,-0x4(%rbp)
 3aa:	48 63 d0             	movslq %eax,%rdx
 3ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3b1:	48 01 c2             	add    %rax,%rdx
 3b4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 3b8:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 3ba:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 3be:	3c 0a                	cmp    $0xa,%al
 3c0:	74 16                	je     3d8 <gets+0x72>
 3c2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 3c6:	3c 0d                	cmp    $0xd,%al
 3c8:	74 0e                	je     3d8 <gets+0x72>
  for(i=0; i+1 < max; ){
 3ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3cd:	83 c0 01             	add    $0x1,%eax
 3d0:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 3d3:	7f ad                	jg     382 <gets+0x1c>
 3d5:	eb 01                	jmp    3d8 <gets+0x72>
      break;
 3d7:	90                   	nop
      break;
  }
  buf[i] = '\0';
 3d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3db:	48 63 d0             	movslq %eax,%rdx
 3de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3e2:	48 01 d0             	add    %rdx,%rax
 3e5:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 3e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 3ec:	c9                   	leave
 3ed:	c3                   	ret

00000000000003ee <stat>:

int
stat(char *n, struct stat *st)
{
 3ee:	f3 0f 1e fa          	endbr64
 3f2:	55                   	push   %rbp
 3f3:	48 89 e5             	mov    %rsp,%rbp
 3f6:	48 83 ec 20          	sub    $0x20,%rsp
 3fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3fe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 402:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 406:	be 00 00 00 00       	mov    $0x0,%esi
 40b:	48 89 c7             	mov    %rax,%rdi
 40e:	e8 30 01 00 00       	call   543 <open>
 413:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 416:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 41a:	79 07                	jns    423 <stat+0x35>
    return -1;
 41c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 421:	eb 21                	jmp    444 <stat+0x56>
  r = fstat(fd, st);
 423:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 427:	8b 45 fc             	mov    -0x4(%rbp),%eax
 42a:	48 89 d6             	mov    %rdx,%rsi
 42d:	89 c7                	mov    %eax,%edi
 42f:	e8 27 01 00 00       	call   55b <fstat>
 434:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 437:	8b 45 fc             	mov    -0x4(%rbp),%eax
 43a:	89 c7                	mov    %eax,%edi
 43c:	e8 ea 00 00 00       	call   52b <close>
  return r;
 441:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 444:	c9                   	leave
 445:	c3                   	ret

0000000000000446 <atoi>:

int
atoi(const char *s)
{
 446:	f3 0f 1e fa          	endbr64
 44a:	55                   	push   %rbp
 44b:	48 89 e5             	mov    %rsp,%rbp
 44e:	48 83 ec 18          	sub    $0x18,%rsp
 452:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 456:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 45d:	eb 28                	jmp    487 <atoi+0x41>
    n = n*10 + *s++ - '0';
 45f:	8b 55 fc             	mov    -0x4(%rbp),%edx
 462:	89 d0                	mov    %edx,%eax
 464:	c1 e0 02             	shl    $0x2,%eax
 467:	01 d0                	add    %edx,%eax
 469:	01 c0                	add    %eax,%eax
 46b:	89 c1                	mov    %eax,%ecx
 46d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 471:	48 8d 50 01          	lea    0x1(%rax),%rdx
 475:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 479:	0f b6 00             	movzbl (%rax),%eax
 47c:	0f be c0             	movsbl %al,%eax
 47f:	01 c8                	add    %ecx,%eax
 481:	83 e8 30             	sub    $0x30,%eax
 484:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 487:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 48b:	0f b6 00             	movzbl (%rax),%eax
 48e:	3c 2f                	cmp    $0x2f,%al
 490:	7e 0b                	jle    49d <atoi+0x57>
 492:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 496:	0f b6 00             	movzbl (%rax),%eax
 499:	3c 39                	cmp    $0x39,%al
 49b:	7e c2                	jle    45f <atoi+0x19>
  return n;
 49d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4a0:	c9                   	leave
 4a1:	c3                   	ret

00000000000004a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4a2:	f3 0f 1e fa          	endbr64
 4a6:	55                   	push   %rbp
 4a7:	48 89 e5             	mov    %rsp,%rbp
 4aa:	48 83 ec 28          	sub    $0x28,%rsp
 4ae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 4b2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 4b6:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 4b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 4c1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 4c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 4c9:	eb 1d                	jmp    4e8 <memmove+0x46>
    *dst++ = *src++;
 4cb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 4cf:	48 8d 42 01          	lea    0x1(%rdx),%rax
 4d3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 4d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4db:	48 8d 48 01          	lea    0x1(%rax),%rcx
 4df:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 4e3:	0f b6 12             	movzbl (%rdx),%edx
 4e6:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 4e8:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4eb:	8d 50 ff             	lea    -0x1(%rax),%edx
 4ee:	89 55 dc             	mov    %edx,-0x24(%rbp)
 4f1:	85 c0                	test   %eax,%eax
 4f3:	7f d6                	jg     4cb <memmove+0x29>
  return vdst;
 4f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 4f9:	c9                   	leave
 4fa:	c3                   	ret

00000000000004fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4fb:	b8 01 00 00 00       	mov    $0x1,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret

0000000000000503 <exit>:
SYSCALL(exit)
 503:	b8 02 00 00 00       	mov    $0x2,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret

000000000000050b <wait>:
SYSCALL(wait)
 50b:	b8 03 00 00 00       	mov    $0x3,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret

0000000000000513 <pipe>:
SYSCALL(pipe)
 513:	b8 04 00 00 00       	mov    $0x4,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret

000000000000051b <read>:
SYSCALL(read)
 51b:	b8 05 00 00 00       	mov    $0x5,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret

0000000000000523 <write>:
SYSCALL(write)
 523:	b8 10 00 00 00       	mov    $0x10,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret

000000000000052b <close>:
SYSCALL(close)
 52b:	b8 15 00 00 00       	mov    $0x15,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret

0000000000000533 <kill>:
SYSCALL(kill)
 533:	b8 06 00 00 00       	mov    $0x6,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret

000000000000053b <exec>:
SYSCALL(exec)
 53b:	b8 07 00 00 00       	mov    $0x7,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret

0000000000000543 <open>:
SYSCALL(open)
 543:	b8 0f 00 00 00       	mov    $0xf,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret

000000000000054b <mknod>:
SYSCALL(mknod)
 54b:	b8 11 00 00 00       	mov    $0x11,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret

0000000000000553 <unlink>:
SYSCALL(unlink)
 553:	b8 12 00 00 00       	mov    $0x12,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret

000000000000055b <fstat>:
SYSCALL(fstat)
 55b:	b8 08 00 00 00       	mov    $0x8,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret

0000000000000563 <link>:
SYSCALL(link)
 563:	b8 13 00 00 00       	mov    $0x13,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret

000000000000056b <mkdir>:
SYSCALL(mkdir)
 56b:	b8 14 00 00 00       	mov    $0x14,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret

0000000000000573 <chdir>:
SYSCALL(chdir)
 573:	b8 09 00 00 00       	mov    $0x9,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret

000000000000057b <dup>:
SYSCALL(dup)
 57b:	b8 0a 00 00 00       	mov    $0xa,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret

0000000000000583 <getpid>:
SYSCALL(getpid)
 583:	b8 0b 00 00 00       	mov    $0xb,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret

000000000000058b <sbrk>:
SYSCALL(sbrk)
 58b:	b8 0c 00 00 00       	mov    $0xc,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret

0000000000000593 <sleep>:
SYSCALL(sleep)
 593:	b8 0d 00 00 00       	mov    $0xd,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret

000000000000059b <uptime>:
SYSCALL(uptime)
 59b:	b8 0e 00 00 00       	mov    $0xe,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret

00000000000005a3 <getpinfo>:
SYSCALL(getpinfo)
 5a3:	b8 18 00 00 00       	mov    $0x18,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret

00000000000005ab <settickets>:
SYSCALL(settickets)
 5ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

00000000000005b3 <getfavnum>:
SYSCALL(getfavnum)
 5b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

00000000000005bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5bb:	f3 0f 1e fa          	endbr64
 5bf:	55                   	push   %rbp
 5c0:	48 89 e5             	mov    %rsp,%rbp
 5c3:	48 83 ec 10          	sub    $0x10,%rsp
 5c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
 5ca:	89 f0                	mov    %esi,%eax
 5cc:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 5cf:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 5d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5d6:	ba 01 00 00 00       	mov    $0x1,%edx
 5db:	48 89 ce             	mov    %rcx,%rsi
 5de:	89 c7                	mov    %eax,%edi
 5e0:	e8 3e ff ff ff       	call   523 <write>
}
 5e5:	90                   	nop
 5e6:	c9                   	leave
 5e7:	c3                   	ret

00000000000005e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e8:	f3 0f 1e fa          	endbr64
 5ec:	55                   	push   %rbp
 5ed:	48 89 e5             	mov    %rsp,%rbp
 5f0:	48 83 ec 30          	sub    $0x30,%rsp
 5f4:	89 7d dc             	mov    %edi,-0x24(%rbp)
 5f7:	89 75 d8             	mov    %esi,-0x28(%rbp)
 5fa:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 5fd:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 600:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 607:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 60b:	74 17                	je     624 <printint+0x3c>
 60d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 611:	79 11                	jns    624 <printint+0x3c>
    neg = 1;
 613:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 61a:	8b 45 d8             	mov    -0x28(%rbp),%eax
 61d:	f7 d8                	neg    %eax
 61f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 622:	eb 06                	jmp    62a <printint+0x42>
  } else {
    x = xx;
 624:	8b 45 d8             	mov    -0x28(%rbp),%eax
 627:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 62a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 631:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 634:	8b 45 f4             	mov    -0xc(%rbp),%eax
 637:	ba 00 00 00 00       	mov    $0x0,%edx
 63c:	f7 f6                	div    %esi
 63e:	89 d1                	mov    %edx,%ecx
 640:	8b 45 fc             	mov    -0x4(%rbp),%eax
 643:	8d 50 01             	lea    0x1(%rax),%edx
 646:	89 55 fc             	mov    %edx,-0x4(%rbp)
 649:	89 ca                	mov    %ecx,%edx
 64b:	0f b6 92 60 0f 00 00 	movzbl 0xf60(%rdx),%edx
 652:	48 98                	cltq
 654:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 658:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 65b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 65e:	ba 00 00 00 00       	mov    $0x0,%edx
 663:	f7 f7                	div    %edi
 665:	89 45 f4             	mov    %eax,-0xc(%rbp)
 668:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 66c:	75 c3                	jne    631 <printint+0x49>
  if(neg)
 66e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 672:	74 2b                	je     69f <printint+0xb7>
    buf[i++] = '-';
 674:	8b 45 fc             	mov    -0x4(%rbp),%eax
 677:	8d 50 01             	lea    0x1(%rax),%edx
 67a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 67d:	48 98                	cltq
 67f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 684:	eb 19                	jmp    69f <printint+0xb7>
    putc(fd, buf[i]);
 686:	8b 45 fc             	mov    -0x4(%rbp),%eax
 689:	48 98                	cltq
 68b:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 690:	0f be d0             	movsbl %al,%edx
 693:	8b 45 dc             	mov    -0x24(%rbp),%eax
 696:	89 d6                	mov    %edx,%esi
 698:	89 c7                	mov    %eax,%edi
 69a:	e8 1c ff ff ff       	call   5bb <putc>
  while(--i >= 0)
 69f:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 6a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 6a7:	79 dd                	jns    686 <printint+0x9e>
}
 6a9:	90                   	nop
 6aa:	90                   	nop
 6ab:	c9                   	leave
 6ac:	c3                   	ret

00000000000006ad <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ad:	f3 0f 1e fa          	endbr64
 6b1:	55                   	push   %rbp
 6b2:	48 89 e5             	mov    %rsp,%rbp
 6b5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 6bc:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 6c2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 6c9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 6d0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 6d7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 6de:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 6e5:	84 c0                	test   %al,%al
 6e7:	74 20                	je     709 <printf+0x5c>
 6e9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 6ed:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 6f1:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 6f5:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 6f9:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 6fd:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 701:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 705:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 709:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 710:	00 00 00 
 713:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 71a:	00 00 00 
 71d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 721:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 728:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 72f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 736:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 73d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 740:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 747:	00 00 00 
 74a:	e9 a8 02 00 00       	jmp    9f7 <printf+0x34a>
    c = fmt[i] & 0xff;
 74f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 755:	48 63 d0             	movslq %eax,%rdx
 758:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 75f:	48 01 d0             	add    %rdx,%rax
 762:	0f b6 00             	movzbl (%rax),%eax
 765:	0f be c0             	movsbl %al,%eax
 768:	25 ff 00 00 00       	and    $0xff,%eax
 76d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 773:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 77a:	75 35                	jne    7b1 <printf+0x104>
      if(c == '%'){
 77c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 783:	75 0f                	jne    794 <printf+0xe7>
        state = '%';
 785:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 78c:	00 00 00 
 78f:	e9 5c 02 00 00       	jmp    9f0 <printf+0x343>
      } else {
        putc(fd, c);
 794:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 79a:	0f be d0             	movsbl %al,%edx
 79d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7a3:	89 d6                	mov    %edx,%esi
 7a5:	89 c7                	mov    %eax,%edi
 7a7:	e8 0f fe ff ff       	call   5bb <putc>
 7ac:	e9 3f 02 00 00       	jmp    9f0 <printf+0x343>
      }
    } else if(state == '%'){
 7b1:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 7b8:	0f 85 32 02 00 00    	jne    9f0 <printf+0x343>
      if(c == 'd'){
 7be:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 7c5:	75 5e                	jne    825 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 7c7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7cd:	83 f8 2f             	cmp    $0x2f,%eax
 7d0:	77 23                	ja     7f5 <printf+0x148>
 7d2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7d9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7df:	89 d2                	mov    %edx,%edx
 7e1:	48 01 d0             	add    %rdx,%rax
 7e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ea:	83 c2 08             	add    $0x8,%edx
 7ed:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7f3:	eb 12                	jmp    807 <printf+0x15a>
 7f5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7fc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 800:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 807:	8b 30                	mov    (%rax),%esi
 809:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 80f:	b9 01 00 00 00       	mov    $0x1,%ecx
 814:	ba 0a 00 00 00       	mov    $0xa,%edx
 819:	89 c7                	mov    %eax,%edi
 81b:	e8 c8 fd ff ff       	call   5e8 <printint>
 820:	e9 c1 01 00 00       	jmp    9e6 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 825:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 82c:	74 09                	je     837 <printf+0x18a>
 82e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 835:	75 5e                	jne    895 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 837:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 83d:	83 f8 2f             	cmp    $0x2f,%eax
 840:	77 23                	ja     865 <printf+0x1b8>
 842:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 849:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 84f:	89 d2                	mov    %edx,%edx
 851:	48 01 d0             	add    %rdx,%rax
 854:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 85a:	83 c2 08             	add    $0x8,%edx
 85d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 863:	eb 12                	jmp    877 <printf+0x1ca>
 865:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 86c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 870:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 877:	8b 30                	mov    (%rax),%esi
 879:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 87f:	b9 00 00 00 00       	mov    $0x0,%ecx
 884:	ba 10 00 00 00       	mov    $0x10,%edx
 889:	89 c7                	mov    %eax,%edi
 88b:	e8 58 fd ff ff       	call   5e8 <printint>
 890:	e9 51 01 00 00       	jmp    9e6 <printf+0x339>
      } else if(c == 's'){
 895:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 89c:	0f 85 98 00 00 00    	jne    93a <printf+0x28d>
        s = va_arg(ap, char*);
 8a2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 8a8:	83 f8 2f             	cmp    $0x2f,%eax
 8ab:	77 23                	ja     8d0 <printf+0x223>
 8ad:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8b4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8ba:	89 d2                	mov    %edx,%edx
 8bc:	48 01 d0             	add    %rdx,%rax
 8bf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8c5:	83 c2 08             	add    $0x8,%edx
 8c8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8ce:	eb 12                	jmp    8e2 <printf+0x235>
 8d0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8d7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8db:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8e2:	48 8b 00             	mov    (%rax),%rax
 8e5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 8ec:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 8f3:	00 
 8f4:	75 31                	jne    927 <printf+0x27a>
          s = "(null)";
 8f6:	48 c7 85 48 ff ff ff 	movq   $0xcfa,-0xb8(%rbp)
 8fd:	fa 0c 00 00 
        while(*s != 0){
 901:	eb 24                	jmp    927 <printf+0x27a>
          putc(fd, *s);
 903:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 90a:	0f b6 00             	movzbl (%rax),%eax
 90d:	0f be d0             	movsbl %al,%edx
 910:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 916:	89 d6                	mov    %edx,%esi
 918:	89 c7                	mov    %eax,%edi
 91a:	e8 9c fc ff ff       	call   5bb <putc>
          s++;
 91f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 926:	01 
        while(*s != 0){
 927:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 92e:	0f b6 00             	movzbl (%rax),%eax
 931:	84 c0                	test   %al,%al
 933:	75 ce                	jne    903 <printf+0x256>
 935:	e9 ac 00 00 00       	jmp    9e6 <printf+0x339>
        }
      } else if(c == 'c'){
 93a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 941:	75 56                	jne    999 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 943:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 949:	83 f8 2f             	cmp    $0x2f,%eax
 94c:	77 23                	ja     971 <printf+0x2c4>
 94e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 955:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 95b:	89 d2                	mov    %edx,%edx
 95d:	48 01 d0             	add    %rdx,%rax
 960:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 966:	83 c2 08             	add    $0x8,%edx
 969:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 96f:	eb 12                	jmp    983 <printf+0x2d6>
 971:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 978:	48 8d 50 08          	lea    0x8(%rax),%rdx
 97c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 983:	8b 00                	mov    (%rax),%eax
 985:	0f be d0             	movsbl %al,%edx
 988:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 98e:	89 d6                	mov    %edx,%esi
 990:	89 c7                	mov    %eax,%edi
 992:	e8 24 fc ff ff       	call   5bb <putc>
 997:	eb 4d                	jmp    9e6 <printf+0x339>
      } else if(c == '%'){
 999:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 9a0:	75 1a                	jne    9bc <printf+0x30f>
        putc(fd, c);
 9a2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 9a8:	0f be d0             	movsbl %al,%edx
 9ab:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9b1:	89 d6                	mov    %edx,%esi
 9b3:	89 c7                	mov    %eax,%edi
 9b5:	e8 01 fc ff ff       	call   5bb <putc>
 9ba:	eb 2a                	jmp    9e6 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9bc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9c2:	be 25 00 00 00       	mov    $0x25,%esi
 9c7:	89 c7                	mov    %eax,%edi
 9c9:	e8 ed fb ff ff       	call   5bb <putc>
        putc(fd, c);
 9ce:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 9d4:	0f be d0             	movsbl %al,%edx
 9d7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9dd:	89 d6                	mov    %edx,%esi
 9df:	89 c7                	mov    %eax,%edi
 9e1:	e8 d5 fb ff ff       	call   5bb <putc>
      }
      state = 0;
 9e6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 9ed:	00 00 00 
  for(i = 0; fmt[i]; i++){
 9f0:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 9f7:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 9fd:	48 63 d0             	movslq %eax,%rdx
 a00:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 a07:	48 01 d0             	add    %rdx,%rax
 a0a:	0f b6 00             	movzbl (%rax),%eax
 a0d:	84 c0                	test   %al,%al
 a0f:	0f 85 3a fd ff ff    	jne    74f <printf+0xa2>
    }
  }
}
 a15:	90                   	nop
 a16:	90                   	nop
 a17:	c9                   	leave
 a18:	c3                   	ret

0000000000000a19 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a19:	f3 0f 1e fa          	endbr64
 a1d:	55                   	push   %rbp
 a1e:	48 89 e5             	mov    %rsp,%rbp
 a21:	48 83 ec 18          	sub    $0x18,%rsp
 a25:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 a2d:	48 83 e8 10          	sub    $0x10,%rax
 a31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a35:	48 8b 05 54 07 00 00 	mov    0x754(%rip),%rax        # 1190 <freep>
 a3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a40:	eb 2f                	jmp    a71 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a46:	48 8b 00             	mov    (%rax),%rax
 a49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a4d:	72 17                	jb     a66 <free+0x4d>
 a4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a53:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a57:	72 2f                	jb     a88 <free+0x6f>
 a59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5d:	48 8b 00             	mov    (%rax),%rax
 a60:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a64:	72 22                	jb     a88 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6a:	48 8b 00             	mov    (%rax),%rax
 a6d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a75:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a79:	73 c7                	jae    a42 <free+0x29>
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	48 8b 00             	mov    (%rax),%rax
 a82:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a86:	73 ba                	jae    a42 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8c:	8b 40 08             	mov    0x8(%rax),%eax
 a8f:	89 c0                	mov    %eax,%eax
 a91:	48 c1 e0 04          	shl    $0x4,%rax
 a95:	48 89 c2             	mov    %rax,%rdx
 a98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9c:	48 01 c2             	add    %rax,%rdx
 a9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa3:	48 8b 00             	mov    (%rax),%rax
 aa6:	48 39 c2             	cmp    %rax,%rdx
 aa9:	75 2d                	jne    ad8 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 aab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aaf:	8b 50 08             	mov    0x8(%rax),%edx
 ab2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab6:	48 8b 00             	mov    (%rax),%rax
 ab9:	8b 40 08             	mov    0x8(%rax),%eax
 abc:	01 c2                	add    %eax,%edx
 abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac2:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 ac5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac9:	48 8b 00             	mov    (%rax),%rax
 acc:	48 8b 10             	mov    (%rax),%rdx
 acf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad3:	48 89 10             	mov    %rdx,(%rax)
 ad6:	eb 0e                	jmp    ae6 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 ad8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adc:	48 8b 10             	mov    (%rax),%rdx
 adf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae3:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aea:	8b 40 08             	mov    0x8(%rax),%eax
 aed:	89 c0                	mov    %eax,%eax
 aef:	48 c1 e0 04          	shl    $0x4,%rax
 af3:	48 89 c2             	mov    %rax,%rdx
 af6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afa:	48 01 d0             	add    %rdx,%rax
 afd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 b01:	75 27                	jne    b2a <free+0x111>
    p->s.size += bp->s.size;
 b03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b07:	8b 50 08             	mov    0x8(%rax),%edx
 b0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b0e:	8b 40 08             	mov    0x8(%rax),%eax
 b11:	01 c2                	add    %eax,%edx
 b13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b17:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 b1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1e:	48 8b 10             	mov    (%rax),%rdx
 b21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b25:	48 89 10             	mov    %rdx,(%rax)
 b28:	eb 0b                	jmp    b35 <free+0x11c>
  } else
    p->s.ptr = bp;
 b2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b32:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 b35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b39:	48 89 05 50 06 00 00 	mov    %rax,0x650(%rip)        # 1190 <freep>
}
 b40:	90                   	nop
 b41:	c9                   	leave
 b42:	c3                   	ret

0000000000000b43 <morecore>:

static Header*
morecore(uint nu)
{
 b43:	f3 0f 1e fa          	endbr64
 b47:	55                   	push   %rbp
 b48:	48 89 e5             	mov    %rsp,%rbp
 b4b:	48 83 ec 20          	sub    $0x20,%rsp
 b4f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 b52:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 b59:	77 07                	ja     b62 <morecore+0x1f>
    nu = 4096;
 b5b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 b62:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b65:	c1 e0 04             	shl    $0x4,%eax
 b68:	89 c7                	mov    %eax,%edi
 b6a:	e8 1c fa ff ff       	call   58b <sbrk>
 b6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 b73:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 b78:	75 07                	jne    b81 <morecore+0x3e>
    return 0;
 b7a:	b8 00 00 00 00       	mov    $0x0,%eax
 b7f:	eb 29                	jmp    baa <morecore+0x67>
  hp = (Header*)p;
 b81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b85:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 b89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b8d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b90:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b97:	48 83 c0 10          	add    $0x10,%rax
 b9b:	48 89 c7             	mov    %rax,%rdi
 b9e:	e8 76 fe ff ff       	call   a19 <free>
  return freep;
 ba3:	48 8b 05 e6 05 00 00 	mov    0x5e6(%rip),%rax        # 1190 <freep>
}
 baa:	c9                   	leave
 bab:	c3                   	ret

0000000000000bac <malloc>:

void*
malloc(uint nbytes)
{
 bac:	f3 0f 1e fa          	endbr64
 bb0:	55                   	push   %rbp
 bb1:	48 89 e5             	mov    %rsp,%rbp
 bb4:	48 83 ec 30          	sub    $0x30,%rsp
 bb8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bbb:	8b 45 dc             	mov    -0x24(%rbp),%eax
 bbe:	48 83 c0 0f          	add    $0xf,%rax
 bc2:	48 c1 e8 04          	shr    $0x4,%rax
 bc6:	83 c0 01             	add    $0x1,%eax
 bc9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 bcc:	48 8b 05 bd 05 00 00 	mov    0x5bd(%rip),%rax        # 1190 <freep>
 bd3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bd7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 bdc:	75 2b                	jne    c09 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 bde:	48 c7 45 f0 80 11 00 	movq   $0x1180,-0x10(%rbp)
 be5:	00 
 be6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bea:	48 89 05 9f 05 00 00 	mov    %rax,0x59f(%rip)        # 1190 <freep>
 bf1:	48 8b 05 98 05 00 00 	mov    0x598(%rip),%rax        # 1190 <freep>
 bf8:	48 89 05 81 05 00 00 	mov    %rax,0x581(%rip)        # 1180 <base>
    base.s.size = 0;
 bff:	c7 05 7f 05 00 00 00 	movl   $0x0,0x57f(%rip)        # 1188 <base+0x8>
 c06:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c0d:	48 8b 00             	mov    (%rax),%rax
 c10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c18:	8b 40 08             	mov    0x8(%rax),%eax
 c1b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 c1e:	72 5f                	jb     c7f <malloc+0xd3>
      if(p->s.size == nunits)
 c20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c24:	8b 40 08             	mov    0x8(%rax),%eax
 c27:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c2a:	75 10                	jne    c3c <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 c2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c30:	48 8b 10             	mov    (%rax),%rdx
 c33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c37:	48 89 10             	mov    %rdx,(%rax)
 c3a:	eb 2e                	jmp    c6a <malloc+0xbe>
      else {
        p->s.size -= nunits;
 c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c40:	8b 40 08             	mov    0x8(%rax),%eax
 c43:	2b 45 ec             	sub    -0x14(%rbp),%eax
 c46:	89 c2                	mov    %eax,%edx
 c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c4c:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 c4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c53:	8b 40 08             	mov    0x8(%rax),%eax
 c56:	89 c0                	mov    %eax,%eax
 c58:	48 c1 e0 04          	shl    $0x4,%rax
 c5c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c64:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c67:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 c6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c6e:	48 89 05 1b 05 00 00 	mov    %rax,0x51b(%rip)        # 1190 <freep>
      return (void*)(p + 1);
 c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c79:	48 83 c0 10          	add    $0x10,%rax
 c7d:	eb 41                	jmp    cc0 <malloc+0x114>
    }
    if(p == freep)
 c7f:	48 8b 05 0a 05 00 00 	mov    0x50a(%rip),%rax        # 1190 <freep>
 c86:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c8a:	75 1c                	jne    ca8 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 c8c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 c8f:	89 c7                	mov    %eax,%edi
 c91:	e8 ad fe ff ff       	call   b43 <morecore>
 c96:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c9a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c9f:	75 07                	jne    ca8 <malloc+0xfc>
        return 0;
 ca1:	b8 00 00 00 00       	mov    $0x0,%eax
 ca6:	eb 18                	jmp    cc0 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb4:	48 8b 00             	mov    (%rax),%rax
 cb7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 cbb:	e9 54 ff ff ff       	jmp    c14 <malloc+0x68>
  }
}
 cc0:	c9                   	leave
 cc1:	c3                   	ret
