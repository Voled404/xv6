
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
  41:	0f b6 80 a0 0f 00 00 	movzbl 0xfa0(%rax),%eax
  48:	3c 0a                	cmp    $0xa,%al
  4a:	75 04                	jne    50 <wc+0x50>
        l++;
  4c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
  50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  53:	48 98                	cltq
  55:	0f b6 80 a0 0f 00 00 	movzbl 0xfa0(%rax),%eax
  5c:	0f be c0             	movsbl %al,%eax
  5f:	89 c6                	mov    %eax,%esi
  61:	48 c7 c7 ca 0c 00 00 	mov    $0xcca,%rdi
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
  a0:	48 c7 c6 a0 0f 00 00 	mov    $0xfa0,%rsi
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
  c1:	48 c7 c6 d0 0c 00 00 	mov    $0xcd0,%rsi
  c8:	bf 01 00 00 00       	mov    $0x1,%edi
  cd:	b8 00 00 00 00       	mov    $0x0,%eax
  d2:	e8 de 05 00 00       	call   6b5 <printf>
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
  f3:	48 c7 c6 e0 0c 00 00 	mov    $0xce0,%rsi
  fa:	bf 01 00 00 00       	mov    $0x1,%edi
  ff:	b8 00 00 00 00       	mov    $0x0,%eax
 104:	e8 ac 05 00 00       	call   6b5 <printf>
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
 125:	48 c7 c6 ed 0c 00 00 	mov    $0xced,%rsi
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
 18e:	48 c7 c6 ee 0c 00 00 	mov    $0xcee,%rsi
 195:	bf 01 00 00 00       	mov    $0x1,%edi
 19a:	b8 00 00 00 00       	mov    $0x0,%eax
 19f:	e8 11 05 00 00       	call   6b5 <printf>
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

00000000000005bb <halt>:
SYSCALL(halt)
 5bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

00000000000005c3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5c3:	f3 0f 1e fa          	endbr64
 5c7:	55                   	push   %rbp
 5c8:	48 89 e5             	mov    %rsp,%rbp
 5cb:	48 83 ec 10          	sub    $0x10,%rsp
 5cf:	89 7d fc             	mov    %edi,-0x4(%rbp)
 5d2:	89 f0                	mov    %esi,%eax
 5d4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 5d7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 5db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5de:	ba 01 00 00 00       	mov    $0x1,%edx
 5e3:	48 89 ce             	mov    %rcx,%rsi
 5e6:	89 c7                	mov    %eax,%edi
 5e8:	e8 36 ff ff ff       	call   523 <write>
}
 5ed:	90                   	nop
 5ee:	c9                   	leave
 5ef:	c3                   	ret

00000000000005f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	f3 0f 1e fa          	endbr64
 5f4:	55                   	push   %rbp
 5f5:	48 89 e5             	mov    %rsp,%rbp
 5f8:	48 83 ec 30          	sub    $0x30,%rsp
 5fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
 5ff:	89 75 d8             	mov    %esi,-0x28(%rbp)
 602:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 605:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 608:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 60f:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 613:	74 17                	je     62c <printint+0x3c>
 615:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 619:	79 11                	jns    62c <printint+0x3c>
    neg = 1;
 61b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 622:	8b 45 d8             	mov    -0x28(%rbp),%eax
 625:	f7 d8                	neg    %eax
 627:	89 45 f4             	mov    %eax,-0xc(%rbp)
 62a:	eb 06                	jmp    632 <printint+0x42>
  } else {
    x = xx;
 62c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 62f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 632:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 639:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 63c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 63f:	ba 00 00 00 00       	mov    $0x0,%edx
 644:	f7 f6                	div    %esi
 646:	89 d1                	mov    %edx,%ecx
 648:	8b 45 fc             	mov    -0x4(%rbp),%eax
 64b:	8d 50 01             	lea    0x1(%rax),%edx
 64e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 651:	89 ca                	mov    %ecx,%edx
 653:	0f b6 92 70 0f 00 00 	movzbl 0xf70(%rdx),%edx
 65a:	48 98                	cltq
 65c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 660:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 663:	8b 45 f4             	mov    -0xc(%rbp),%eax
 666:	ba 00 00 00 00       	mov    $0x0,%edx
 66b:	f7 f7                	div    %edi
 66d:	89 45 f4             	mov    %eax,-0xc(%rbp)
 670:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 674:	75 c3                	jne    639 <printint+0x49>
  if(neg)
 676:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 67a:	74 2b                	je     6a7 <printint+0xb7>
    buf[i++] = '-';
 67c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 67f:	8d 50 01             	lea    0x1(%rax),%edx
 682:	89 55 fc             	mov    %edx,-0x4(%rbp)
 685:	48 98                	cltq
 687:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 68c:	eb 19                	jmp    6a7 <printint+0xb7>
    putc(fd, buf[i]);
 68e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 691:	48 98                	cltq
 693:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 698:	0f be d0             	movsbl %al,%edx
 69b:	8b 45 dc             	mov    -0x24(%rbp),%eax
 69e:	89 d6                	mov    %edx,%esi
 6a0:	89 c7                	mov    %eax,%edi
 6a2:	e8 1c ff ff ff       	call   5c3 <putc>
  while(--i >= 0)
 6a7:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 6ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 6af:	79 dd                	jns    68e <printint+0x9e>
}
 6b1:	90                   	nop
 6b2:	90                   	nop
 6b3:	c9                   	leave
 6b4:	c3                   	ret

00000000000006b5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6b5:	f3 0f 1e fa          	endbr64
 6b9:	55                   	push   %rbp
 6ba:	48 89 e5             	mov    %rsp,%rbp
 6bd:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 6c4:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 6ca:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 6d1:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 6d8:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 6df:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 6e6:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 6ed:	84 c0                	test   %al,%al
 6ef:	74 20                	je     711 <printf+0x5c>
 6f1:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 6f5:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 6f9:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 6fd:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 701:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 705:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 709:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 70d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 711:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 718:	00 00 00 
 71b:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 722:	00 00 00 
 725:	48 8d 45 10          	lea    0x10(%rbp),%rax
 729:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 730:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 737:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 73e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 745:	00 00 00 
  for(i = 0; fmt[i]; i++){
 748:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 74f:	00 00 00 
 752:	e9 a8 02 00 00       	jmp    9ff <printf+0x34a>
    c = fmt[i] & 0xff;
 757:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 75d:	48 63 d0             	movslq %eax,%rdx
 760:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 767:	48 01 d0             	add    %rdx,%rax
 76a:	0f b6 00             	movzbl (%rax),%eax
 76d:	0f be c0             	movsbl %al,%eax
 770:	25 ff 00 00 00       	and    $0xff,%eax
 775:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 77b:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 782:	75 35                	jne    7b9 <printf+0x104>
      if(c == '%'){
 784:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 78b:	75 0f                	jne    79c <printf+0xe7>
        state = '%';
 78d:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 794:	00 00 00 
 797:	e9 5c 02 00 00       	jmp    9f8 <printf+0x343>
      } else {
        putc(fd, c);
 79c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7a2:	0f be d0             	movsbl %al,%edx
 7a5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ab:	89 d6                	mov    %edx,%esi
 7ad:	89 c7                	mov    %eax,%edi
 7af:	e8 0f fe ff ff       	call   5c3 <putc>
 7b4:	e9 3f 02 00 00       	jmp    9f8 <printf+0x343>
      }
    } else if(state == '%'){
 7b9:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 7c0:	0f 85 32 02 00 00    	jne    9f8 <printf+0x343>
      if(c == 'd'){
 7c6:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 7cd:	75 5e                	jne    82d <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 7cf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7d5:	83 f8 2f             	cmp    $0x2f,%eax
 7d8:	77 23                	ja     7fd <printf+0x148>
 7da:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e7:	89 d2                	mov    %edx,%edx
 7e9:	48 01 d0             	add    %rdx,%rax
 7ec:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f2:	83 c2 08             	add    $0x8,%edx
 7f5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7fb:	eb 12                	jmp    80f <printf+0x15a>
 7fd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 804:	48 8d 50 08          	lea    0x8(%rax),%rdx
 808:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 80f:	8b 30                	mov    (%rax),%esi
 811:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 817:	b9 01 00 00 00       	mov    $0x1,%ecx
 81c:	ba 0a 00 00 00       	mov    $0xa,%edx
 821:	89 c7                	mov    %eax,%edi
 823:	e8 c8 fd ff ff       	call   5f0 <printint>
 828:	e9 c1 01 00 00       	jmp    9ee <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 82d:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 834:	74 09                	je     83f <printf+0x18a>
 836:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 83d:	75 5e                	jne    89d <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 83f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 845:	83 f8 2f             	cmp    $0x2f,%eax
 848:	77 23                	ja     86d <printf+0x1b8>
 84a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 851:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 857:	89 d2                	mov    %edx,%edx
 859:	48 01 d0             	add    %rdx,%rax
 85c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 862:	83 c2 08             	add    $0x8,%edx
 865:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 86b:	eb 12                	jmp    87f <printf+0x1ca>
 86d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 874:	48 8d 50 08          	lea    0x8(%rax),%rdx
 878:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 87f:	8b 30                	mov    (%rax),%esi
 881:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 887:	b9 00 00 00 00       	mov    $0x0,%ecx
 88c:	ba 10 00 00 00       	mov    $0x10,%edx
 891:	89 c7                	mov    %eax,%edi
 893:	e8 58 fd ff ff       	call   5f0 <printint>
 898:	e9 51 01 00 00       	jmp    9ee <printf+0x339>
      } else if(c == 's'){
 89d:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 8a4:	0f 85 98 00 00 00    	jne    942 <printf+0x28d>
        s = va_arg(ap, char*);
 8aa:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 8b0:	83 f8 2f             	cmp    $0x2f,%eax
 8b3:	77 23                	ja     8d8 <printf+0x223>
 8b5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8c2:	89 d2                	mov    %edx,%edx
 8c4:	48 01 d0             	add    %rdx,%rax
 8c7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8cd:	83 c2 08             	add    $0x8,%edx
 8d0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8d6:	eb 12                	jmp    8ea <printf+0x235>
 8d8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8df:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8e3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8ea:	48 8b 00             	mov    (%rax),%rax
 8ed:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 8f4:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 8fb:	00 
 8fc:	75 31                	jne    92f <printf+0x27a>
          s = "(null)";
 8fe:	48 c7 85 48 ff ff ff 	movq   $0xd02,-0xb8(%rbp)
 905:	02 0d 00 00 
        while(*s != 0){
 909:	eb 24                	jmp    92f <printf+0x27a>
          putc(fd, *s);
 90b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 912:	0f b6 00             	movzbl (%rax),%eax
 915:	0f be d0             	movsbl %al,%edx
 918:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 91e:	89 d6                	mov    %edx,%esi
 920:	89 c7                	mov    %eax,%edi
 922:	e8 9c fc ff ff       	call   5c3 <putc>
          s++;
 927:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 92e:	01 
        while(*s != 0){
 92f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 936:	0f b6 00             	movzbl (%rax),%eax
 939:	84 c0                	test   %al,%al
 93b:	75 ce                	jne    90b <printf+0x256>
 93d:	e9 ac 00 00 00       	jmp    9ee <printf+0x339>
        }
      } else if(c == 'c'){
 942:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 949:	75 56                	jne    9a1 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 94b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 951:	83 f8 2f             	cmp    $0x2f,%eax
 954:	77 23                	ja     979 <printf+0x2c4>
 956:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 95d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 963:	89 d2                	mov    %edx,%edx
 965:	48 01 d0             	add    %rdx,%rax
 968:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 96e:	83 c2 08             	add    $0x8,%edx
 971:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 977:	eb 12                	jmp    98b <printf+0x2d6>
 979:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 980:	48 8d 50 08          	lea    0x8(%rax),%rdx
 984:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 98b:	8b 00                	mov    (%rax),%eax
 98d:	0f be d0             	movsbl %al,%edx
 990:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 996:	89 d6                	mov    %edx,%esi
 998:	89 c7                	mov    %eax,%edi
 99a:	e8 24 fc ff ff       	call   5c3 <putc>
 99f:	eb 4d                	jmp    9ee <printf+0x339>
      } else if(c == '%'){
 9a1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 9a8:	75 1a                	jne    9c4 <printf+0x30f>
        putc(fd, c);
 9aa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 9b0:	0f be d0             	movsbl %al,%edx
 9b3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9b9:	89 d6                	mov    %edx,%esi
 9bb:	89 c7                	mov    %eax,%edi
 9bd:	e8 01 fc ff ff       	call   5c3 <putc>
 9c2:	eb 2a                	jmp    9ee <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9c4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9ca:	be 25 00 00 00       	mov    $0x25,%esi
 9cf:	89 c7                	mov    %eax,%edi
 9d1:	e8 ed fb ff ff       	call   5c3 <putc>
        putc(fd, c);
 9d6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 9dc:	0f be d0             	movsbl %al,%edx
 9df:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9e5:	89 d6                	mov    %edx,%esi
 9e7:	89 c7                	mov    %eax,%edi
 9e9:	e8 d5 fb ff ff       	call   5c3 <putc>
      }
      state = 0;
 9ee:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 9f5:	00 00 00 
  for(i = 0; fmt[i]; i++){
 9f8:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 9ff:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 a05:	48 63 d0             	movslq %eax,%rdx
 a08:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 a0f:	48 01 d0             	add    %rdx,%rax
 a12:	0f b6 00             	movzbl (%rax),%eax
 a15:	84 c0                	test   %al,%al
 a17:	0f 85 3a fd ff ff    	jne    757 <printf+0xa2>
    }
  }
}
 a1d:	90                   	nop
 a1e:	90                   	nop
 a1f:	c9                   	leave
 a20:	c3                   	ret

0000000000000a21 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a21:	f3 0f 1e fa          	endbr64
 a25:	55                   	push   %rbp
 a26:	48 89 e5             	mov    %rsp,%rbp
 a29:	48 83 ec 18          	sub    $0x18,%rsp
 a2d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 a35:	48 83 e8 10          	sub    $0x10,%rax
 a39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a3d:	48 8b 05 6c 07 00 00 	mov    0x76c(%rip),%rax        # 11b0 <freep>
 a44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a48:	eb 2f                	jmp    a79 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4e:	48 8b 00             	mov    (%rax),%rax
 a51:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a55:	72 17                	jb     a6e <free+0x4d>
 a57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a5b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a5f:	72 2f                	jb     a90 <free+0x6f>
 a61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a65:	48 8b 00             	mov    (%rax),%rax
 a68:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a6c:	72 22                	jb     a90 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a72:	48 8b 00             	mov    (%rax),%rax
 a75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a7d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a81:	73 c7                	jae    a4a <free+0x29>
 a83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a87:	48 8b 00             	mov    (%rax),%rax
 a8a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a8e:	73 ba                	jae    a4a <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a94:	8b 40 08             	mov    0x8(%rax),%eax
 a97:	89 c0                	mov    %eax,%eax
 a99:	48 c1 e0 04          	shl    $0x4,%rax
 a9d:	48 89 c2             	mov    %rax,%rdx
 aa0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa4:	48 01 c2             	add    %rax,%rdx
 aa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aab:	48 8b 00             	mov    (%rax),%rax
 aae:	48 39 c2             	cmp    %rax,%rdx
 ab1:	75 2d                	jne    ae0 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 ab3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab7:	8b 50 08             	mov    0x8(%rax),%edx
 aba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abe:	48 8b 00             	mov    (%rax),%rax
 ac1:	8b 40 08             	mov    0x8(%rax),%eax
 ac4:	01 c2                	add    %eax,%edx
 ac6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aca:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 acd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad1:	48 8b 00             	mov    (%rax),%rax
 ad4:	48 8b 10             	mov    (%rax),%rdx
 ad7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 adb:	48 89 10             	mov    %rdx,(%rax)
 ade:	eb 0e                	jmp    aee <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	48 8b 10             	mov    (%rax),%rdx
 ae7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aeb:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 aee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af2:	8b 40 08             	mov    0x8(%rax),%eax
 af5:	89 c0                	mov    %eax,%eax
 af7:	48 c1 e0 04          	shl    $0x4,%rax
 afb:	48 89 c2             	mov    %rax,%rdx
 afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b02:	48 01 d0             	add    %rdx,%rax
 b05:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 b09:	75 27                	jne    b32 <free+0x111>
    p->s.size += bp->s.size;
 b0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0f:	8b 50 08             	mov    0x8(%rax),%edx
 b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b16:	8b 40 08             	mov    0x8(%rax),%eax
 b19:	01 c2                	add    %eax,%edx
 b1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1f:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 b22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b26:	48 8b 10             	mov    (%rax),%rdx
 b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2d:	48 89 10             	mov    %rdx,(%rax)
 b30:	eb 0b                	jmp    b3d <free+0x11c>
  } else
    p->s.ptr = bp;
 b32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b36:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b3a:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 b3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b41:	48 89 05 68 06 00 00 	mov    %rax,0x668(%rip)        # 11b0 <freep>
}
 b48:	90                   	nop
 b49:	c9                   	leave
 b4a:	c3                   	ret

0000000000000b4b <morecore>:

static Header*
morecore(uint nu)
{
 b4b:	f3 0f 1e fa          	endbr64
 b4f:	55                   	push   %rbp
 b50:	48 89 e5             	mov    %rsp,%rbp
 b53:	48 83 ec 20          	sub    $0x20,%rsp
 b57:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 b5a:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 b61:	77 07                	ja     b6a <morecore+0x1f>
    nu = 4096;
 b63:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 b6a:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b6d:	c1 e0 04             	shl    $0x4,%eax
 b70:	89 c7                	mov    %eax,%edi
 b72:	e8 14 fa ff ff       	call   58b <sbrk>
 b77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 b7b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 b80:	75 07                	jne    b89 <morecore+0x3e>
    return 0;
 b82:	b8 00 00 00 00       	mov    $0x0,%eax
 b87:	eb 29                	jmp    bb2 <morecore+0x67>
  hp = (Header*)p;
 b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b8d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 b91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b95:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b98:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9f:	48 83 c0 10          	add    $0x10,%rax
 ba3:	48 89 c7             	mov    %rax,%rdi
 ba6:	e8 76 fe ff ff       	call   a21 <free>
  return freep;
 bab:	48 8b 05 fe 05 00 00 	mov    0x5fe(%rip),%rax        # 11b0 <freep>
}
 bb2:	c9                   	leave
 bb3:	c3                   	ret

0000000000000bb4 <malloc>:

void*
malloc(uint nbytes)
{
 bb4:	f3 0f 1e fa          	endbr64
 bb8:	55                   	push   %rbp
 bb9:	48 89 e5             	mov    %rsp,%rbp
 bbc:	48 83 ec 30          	sub    $0x30,%rsp
 bc0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bc3:	8b 45 dc             	mov    -0x24(%rbp),%eax
 bc6:	48 83 c0 0f          	add    $0xf,%rax
 bca:	48 c1 e8 04          	shr    $0x4,%rax
 bce:	83 c0 01             	add    $0x1,%eax
 bd1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 bd4:	48 8b 05 d5 05 00 00 	mov    0x5d5(%rip),%rax        # 11b0 <freep>
 bdb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bdf:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 be4:	75 2b                	jne    c11 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 be6:	48 c7 45 f0 a0 11 00 	movq   $0x11a0,-0x10(%rbp)
 bed:	00 
 bee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bf2:	48 89 05 b7 05 00 00 	mov    %rax,0x5b7(%rip)        # 11b0 <freep>
 bf9:	48 8b 05 b0 05 00 00 	mov    0x5b0(%rip),%rax        # 11b0 <freep>
 c00:	48 89 05 99 05 00 00 	mov    %rax,0x599(%rip)        # 11a0 <base>
    base.s.size = 0;
 c07:	c7 05 97 05 00 00 00 	movl   $0x0,0x597(%rip)        # 11a8 <base+0x8>
 c0e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c15:	48 8b 00             	mov    (%rax),%rax
 c18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c20:	8b 40 08             	mov    0x8(%rax),%eax
 c23:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 c26:	72 5f                	jb     c87 <malloc+0xd3>
      if(p->s.size == nunits)
 c28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2c:	8b 40 08             	mov    0x8(%rax),%eax
 c2f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c32:	75 10                	jne    c44 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c38:	48 8b 10             	mov    (%rax),%rdx
 c3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c3f:	48 89 10             	mov    %rdx,(%rax)
 c42:	eb 2e                	jmp    c72 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 c44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c48:	8b 40 08             	mov    0x8(%rax),%eax
 c4b:	2b 45 ec             	sub    -0x14(%rbp),%eax
 c4e:	89 c2                	mov    %eax,%edx
 c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c54:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 c57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5b:	8b 40 08             	mov    0x8(%rax),%eax
 c5e:	89 c0                	mov    %eax,%eax
 c60:	48 c1 e0 04          	shl    $0x4,%rax
 c64:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c6c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c6f:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 c72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c76:	48 89 05 33 05 00 00 	mov    %rax,0x533(%rip)        # 11b0 <freep>
      return (void*)(p + 1);
 c7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c81:	48 83 c0 10          	add    $0x10,%rax
 c85:	eb 41                	jmp    cc8 <malloc+0x114>
    }
    if(p == freep)
 c87:	48 8b 05 22 05 00 00 	mov    0x522(%rip),%rax        # 11b0 <freep>
 c8e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c92:	75 1c                	jne    cb0 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 c94:	8b 45 ec             	mov    -0x14(%rbp),%eax
 c97:	89 c7                	mov    %eax,%edi
 c99:	e8 ad fe ff ff       	call   b4b <morecore>
 c9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ca2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ca7:	75 07                	jne    cb0 <malloc+0xfc>
        return 0;
 ca9:	b8 00 00 00 00       	mov    $0x0,%eax
 cae:	eb 18                	jmp    cc8 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbc:	48 8b 00             	mov    (%rax),%rax
 cbf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 cc3:	e9 54 ff ff ff       	jmp    c1c <malloc+0x68>
  }
}
 cc8:	c9                   	leave
 cc9:	c3                   	ret
