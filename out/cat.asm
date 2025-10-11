
fs/cat:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   f:	eb 16                	jmp    27 <cat+0x27>
    write(1, buf, n);
  11:	8b 45 fc             	mov    -0x4(%rbp),%eax
  14:	89 c2                	mov    %eax,%edx
  16:	48 c7 c6 c0 0e 00 00 	mov    $0xec0,%rsi
  1d:	bf 01 00 00 00       	mov    $0x1,%edi
  22:	e8 36 04 00 00       	call   45d <write>
  while((n = read(fd, buf, sizeof(buf))) > 0)
  27:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2a:	ba 00 02 00 00       	mov    $0x200,%edx
  2f:	48 c7 c6 c0 0e 00 00 	mov    $0xec0,%rsi
  36:	89 c7                	mov    %eax,%edi
  38:	e8 18 04 00 00       	call   455 <read>
  3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  40:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  44:	7f cb                	jg     11 <cat+0x11>
  if(n < 0){
  46:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4a:	79 1b                	jns    67 <cat+0x67>
    printf(1, "cat: read error\n");
  4c:	48 c7 c6 14 0c 00 00 	mov    $0xc14,%rsi
  53:	bf 01 00 00 00       	mov    $0x1,%edi
  58:	b8 00 00 00 00       	mov    $0x0,%eax
  5d:	e8 9d 05 00 00       	call   5ff <printf>
    exit();
  62:	e8 d6 03 00 00       	call   43d <exit>
  }
}
  67:	90                   	nop
  68:	c9                   	leave
  69:	c3                   	ret

000000000000006a <main>:

int
main(int argc, char *argv[])
{
  6a:	f3 0f 1e fa          	endbr64
  6e:	55                   	push   %rbp
  6f:	48 89 e5             	mov    %rsp,%rbp
  72:	48 83 ec 20          	sub    $0x20,%rsp
  76:	89 7d ec             	mov    %edi,-0x14(%rbp)
  79:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
  7d:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  81:	7f 0f                	jg     92 <main+0x28>
    cat(0);
  83:	bf 00 00 00 00       	mov    $0x0,%edi
  88:	e8 73 ff ff ff       	call   0 <cat>
    exit();
  8d:	e8 ab 03 00 00       	call   43d <exit>
  }

  for(i = 1; i < argc; i++){
  92:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  99:	eb 7a                	jmp    115 <main+0xab>
    if((fd = open(argv[i], 0)) < 0){
  9b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  9e:	48 98                	cltq
  a0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  a7:	00 
  a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  ac:	48 01 d0             	add    %rdx,%rax
  af:	48 8b 00             	mov    (%rax),%rax
  b2:	be 00 00 00 00       	mov    $0x0,%esi
  b7:	48 89 c7             	mov    %rax,%rdi
  ba:	e8 be 03 00 00       	call   47d <open>
  bf:	89 45 f8             	mov    %eax,-0x8(%rbp)
  c2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  c6:	79 35                	jns    fd <main+0x93>
      printf(1, "cat: cannot open %s\n", argv[i]);
  c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  cb:	48 98                	cltq
  cd:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  d4:	00 
  d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  d9:	48 01 d0             	add    %rdx,%rax
  dc:	48 8b 00             	mov    (%rax),%rax
  df:	48 89 c2             	mov    %rax,%rdx
  e2:	48 c7 c6 25 0c 00 00 	mov    $0xc25,%rsi
  e9:	bf 01 00 00 00       	mov    $0x1,%edi
  ee:	b8 00 00 00 00       	mov    $0x0,%eax
  f3:	e8 07 05 00 00       	call   5ff <printf>
      exit();
  f8:	e8 40 03 00 00       	call   43d <exit>
    }
    cat(fd);
  fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
 100:	89 c7                	mov    %eax,%edi
 102:	e8 f9 fe ff ff       	call   0 <cat>
    close(fd);
 107:	8b 45 f8             	mov    -0x8(%rbp),%eax
 10a:	89 c7                	mov    %eax,%edi
 10c:	e8 54 03 00 00       	call   465 <close>
  for(i = 1; i < argc; i++){
 111:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 115:	8b 45 fc             	mov    -0x4(%rbp),%eax
 118:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 11b:	0f 8c 7a ff ff ff    	jl     9b <main+0x31>
  }
  exit();
 121:	e8 17 03 00 00       	call   43d <exit>

0000000000000126 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 126:	55                   	push   %rbp
 127:	48 89 e5             	mov    %rsp,%rbp
 12a:	48 83 ec 10          	sub    $0x10,%rsp
 12e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 132:	89 75 f4             	mov    %esi,-0xc(%rbp)
 135:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 138:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 13c:	8b 55 f0             	mov    -0x10(%rbp),%edx
 13f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 142:	48 89 ce             	mov    %rcx,%rsi
 145:	48 89 f7             	mov    %rsi,%rdi
 148:	89 d1                	mov    %edx,%ecx
 14a:	fc                   	cld
 14b:	f3 aa                	rep stos %al,%es:(%rdi)
 14d:	89 ca                	mov    %ecx,%edx
 14f:	48 89 fe             	mov    %rdi,%rsi
 152:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 156:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 159:	90                   	nop
 15a:	c9                   	leave
 15b:	c3                   	ret

000000000000015c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 15c:	f3 0f 1e fa          	endbr64
 160:	55                   	push   %rbp
 161:	48 89 e5             	mov    %rsp,%rbp
 164:	48 83 ec 20          	sub    $0x20,%rsp
 168:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 16c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 170:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 174:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 178:	90                   	nop
 179:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 17d:	48 8d 42 01          	lea    0x1(%rdx),%rax
 181:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 185:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 189:	48 8d 48 01          	lea    0x1(%rax),%rcx
 18d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 191:	0f b6 12             	movzbl (%rdx),%edx
 194:	88 10                	mov    %dl,(%rax)
 196:	0f b6 00             	movzbl (%rax),%eax
 199:	84 c0                	test   %al,%al
 19b:	75 dc                	jne    179 <strcpy+0x1d>
    ;
  return os;
 19d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1a1:	c9                   	leave
 1a2:	c3                   	ret

00000000000001a3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a3:	f3 0f 1e fa          	endbr64
 1a7:	55                   	push   %rbp
 1a8:	48 89 e5             	mov    %rsp,%rbp
 1ab:	48 83 ec 10          	sub    $0x10,%rsp
 1af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1b3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 1b7:	eb 0a                	jmp    1c3 <strcmp+0x20>
    p++, q++;
 1b9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1be:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 1c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c7:	0f b6 00             	movzbl (%rax),%eax
 1ca:	84 c0                	test   %al,%al
 1cc:	74 12                	je     1e0 <strcmp+0x3d>
 1ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d2:	0f b6 10             	movzbl (%rax),%edx
 1d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1d9:	0f b6 00             	movzbl (%rax),%eax
 1dc:	38 c2                	cmp    %al,%dl
 1de:	74 d9                	je     1b9 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 1e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e4:	0f b6 00             	movzbl (%rax),%eax
 1e7:	0f b6 d0             	movzbl %al,%edx
 1ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1ee:	0f b6 00             	movzbl (%rax),%eax
 1f1:	0f b6 c0             	movzbl %al,%eax
 1f4:	29 c2                	sub    %eax,%edx
 1f6:	89 d0                	mov    %edx,%eax
}
 1f8:	c9                   	leave
 1f9:	c3                   	ret

00000000000001fa <strlen>:

uint
strlen(char *s)
{
 1fa:	f3 0f 1e fa          	endbr64
 1fe:	55                   	push   %rbp
 1ff:	48 89 e5             	mov    %rsp,%rbp
 202:	48 83 ec 18          	sub    $0x18,%rsp
 206:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 20a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 211:	eb 04                	jmp    217 <strlen+0x1d>
 213:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 217:	8b 45 fc             	mov    -0x4(%rbp),%eax
 21a:	48 63 d0             	movslq %eax,%rdx
 21d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 221:	48 01 d0             	add    %rdx,%rax
 224:	0f b6 00             	movzbl (%rax),%eax
 227:	84 c0                	test   %al,%al
 229:	75 e8                	jne    213 <strlen+0x19>
    ;
  return n;
 22b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 22e:	c9                   	leave
 22f:	c3                   	ret

0000000000000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	f3 0f 1e fa          	endbr64
 234:	55                   	push   %rbp
 235:	48 89 e5             	mov    %rsp,%rbp
 238:	48 83 ec 10          	sub    $0x10,%rsp
 23c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 240:	89 75 f4             	mov    %esi,-0xc(%rbp)
 243:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 246:	8b 55 f0             	mov    -0x10(%rbp),%edx
 249:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 24c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 250:	89 ce                	mov    %ecx,%esi
 252:	48 89 c7             	mov    %rax,%rdi
 255:	e8 cc fe ff ff       	call   126 <stosb>
  return dst;
 25a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 25e:	c9                   	leave
 25f:	c3                   	ret

0000000000000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	f3 0f 1e fa          	endbr64
 264:	55                   	push   %rbp
 265:	48 89 e5             	mov    %rsp,%rbp
 268:	48 83 ec 10          	sub    $0x10,%rsp
 26c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 270:	89 f0                	mov    %esi,%eax
 272:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 275:	eb 17                	jmp    28e <strchr+0x2e>
    if(*s == c)
 277:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 27b:	0f b6 00             	movzbl (%rax),%eax
 27e:	38 45 f4             	cmp    %al,-0xc(%rbp)
 281:	75 06                	jne    289 <strchr+0x29>
      return (char*)s;
 283:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 287:	eb 15                	jmp    29e <strchr+0x3e>
  for(; *s; s++)
 289:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 28e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 292:	0f b6 00             	movzbl (%rax),%eax
 295:	84 c0                	test   %al,%al
 297:	75 de                	jne    277 <strchr+0x17>
  return 0;
 299:	b8 00 00 00 00       	mov    $0x0,%eax
}
 29e:	c9                   	leave
 29f:	c3                   	ret

00000000000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	f3 0f 1e fa          	endbr64
 2a4:	55                   	push   %rbp
 2a5:	48 89 e5             	mov    %rsp,%rbp
 2a8:	48 83 ec 20          	sub    $0x20,%rsp
 2ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2b0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2ba:	eb 48                	jmp    304 <gets+0x64>
    cc = read(0, &c, 1);
 2bc:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 2c0:	ba 01 00 00 00       	mov    $0x1,%edx
 2c5:	48 89 c6             	mov    %rax,%rsi
 2c8:	bf 00 00 00 00       	mov    $0x0,%edi
 2cd:	e8 83 01 00 00       	call   455 <read>
 2d2:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 2d5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 2d9:	7e 36                	jle    311 <gets+0x71>
      break;
    buf[i++] = c;
 2db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2de:	8d 50 01             	lea    0x1(%rax),%edx
 2e1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2e4:	48 63 d0             	movslq %eax,%rdx
 2e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2eb:	48 01 c2             	add    %rax,%rdx
 2ee:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2f2:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 2f4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2f8:	3c 0a                	cmp    $0xa,%al
 2fa:	74 16                	je     312 <gets+0x72>
 2fc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 300:	3c 0d                	cmp    $0xd,%al
 302:	74 0e                	je     312 <gets+0x72>
  for(i=0; i+1 < max; ){
 304:	8b 45 fc             	mov    -0x4(%rbp),%eax
 307:	83 c0 01             	add    $0x1,%eax
 30a:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 30d:	7f ad                	jg     2bc <gets+0x1c>
 30f:	eb 01                	jmp    312 <gets+0x72>
      break;
 311:	90                   	nop
      break;
  }
  buf[i] = '\0';
 312:	8b 45 fc             	mov    -0x4(%rbp),%eax
 315:	48 63 d0             	movslq %eax,%rdx
 318:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31c:	48 01 d0             	add    %rdx,%rax
 31f:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 322:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 326:	c9                   	leave
 327:	c3                   	ret

0000000000000328 <stat>:

int
stat(char *n, struct stat *st)
{
 328:	f3 0f 1e fa          	endbr64
 32c:	55                   	push   %rbp
 32d:	48 89 e5             	mov    %rsp,%rbp
 330:	48 83 ec 20          	sub    $0x20,%rsp
 334:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 338:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 340:	be 00 00 00 00       	mov    $0x0,%esi
 345:	48 89 c7             	mov    %rax,%rdi
 348:	e8 30 01 00 00       	call   47d <open>
 34d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 350:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 354:	79 07                	jns    35d <stat+0x35>
    return -1;
 356:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 35b:	eb 21                	jmp    37e <stat+0x56>
  r = fstat(fd, st);
 35d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 361:	8b 45 fc             	mov    -0x4(%rbp),%eax
 364:	48 89 d6             	mov    %rdx,%rsi
 367:	89 c7                	mov    %eax,%edi
 369:	e8 27 01 00 00       	call   495 <fstat>
 36e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 371:	8b 45 fc             	mov    -0x4(%rbp),%eax
 374:	89 c7                	mov    %eax,%edi
 376:	e8 ea 00 00 00       	call   465 <close>
  return r;
 37b:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 37e:	c9                   	leave
 37f:	c3                   	ret

0000000000000380 <atoi>:

int
atoi(const char *s)
{
 380:	f3 0f 1e fa          	endbr64
 384:	55                   	push   %rbp
 385:	48 89 e5             	mov    %rsp,%rbp
 388:	48 83 ec 18          	sub    $0x18,%rsp
 38c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 390:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 397:	eb 28                	jmp    3c1 <atoi+0x41>
    n = n*10 + *s++ - '0';
 399:	8b 55 fc             	mov    -0x4(%rbp),%edx
 39c:	89 d0                	mov    %edx,%eax
 39e:	c1 e0 02             	shl    $0x2,%eax
 3a1:	01 d0                	add    %edx,%eax
 3a3:	01 c0                	add    %eax,%eax
 3a5:	89 c1                	mov    %eax,%ecx
 3a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3ab:	48 8d 50 01          	lea    0x1(%rax),%rdx
 3af:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 3b3:	0f b6 00             	movzbl (%rax),%eax
 3b6:	0f be c0             	movsbl %al,%eax
 3b9:	01 c8                	add    %ecx,%eax
 3bb:	83 e8 30             	sub    $0x30,%eax
 3be:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3c5:	0f b6 00             	movzbl (%rax),%eax
 3c8:	3c 2f                	cmp    $0x2f,%al
 3ca:	7e 0b                	jle    3d7 <atoi+0x57>
 3cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3d0:	0f b6 00             	movzbl (%rax),%eax
 3d3:	3c 39                	cmp    $0x39,%al
 3d5:	7e c2                	jle    399 <atoi+0x19>
  return n;
 3d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 3da:	c9                   	leave
 3db:	c3                   	ret

00000000000003dc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3dc:	f3 0f 1e fa          	endbr64
 3e0:	55                   	push   %rbp
 3e1:	48 89 e5             	mov    %rsp,%rbp
 3e4:	48 83 ec 28          	sub    $0x28,%rsp
 3e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3f0:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 3f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 3fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 3ff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 403:	eb 1d                	jmp    422 <memmove+0x46>
    *dst++ = *src++;
 405:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 409:	48 8d 42 01          	lea    0x1(%rdx),%rax
 40d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 411:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 415:	48 8d 48 01          	lea    0x1(%rax),%rcx
 419:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 41d:	0f b6 12             	movzbl (%rdx),%edx
 420:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 422:	8b 45 dc             	mov    -0x24(%rbp),%eax
 425:	8d 50 ff             	lea    -0x1(%rax),%edx
 428:	89 55 dc             	mov    %edx,-0x24(%rbp)
 42b:	85 c0                	test   %eax,%eax
 42d:	7f d6                	jg     405 <memmove+0x29>
  return vdst;
 42f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 433:	c9                   	leave
 434:	c3                   	ret

0000000000000435 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 435:	b8 01 00 00 00       	mov    $0x1,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret

000000000000043d <exit>:
SYSCALL(exit)
 43d:	b8 02 00 00 00       	mov    $0x2,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret

0000000000000445 <wait>:
SYSCALL(wait)
 445:	b8 03 00 00 00       	mov    $0x3,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret

000000000000044d <pipe>:
SYSCALL(pipe)
 44d:	b8 04 00 00 00       	mov    $0x4,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret

0000000000000455 <read>:
SYSCALL(read)
 455:	b8 05 00 00 00       	mov    $0x5,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret

000000000000045d <write>:
SYSCALL(write)
 45d:	b8 10 00 00 00       	mov    $0x10,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret

0000000000000465 <close>:
SYSCALL(close)
 465:	b8 15 00 00 00       	mov    $0x15,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret

000000000000046d <kill>:
SYSCALL(kill)
 46d:	b8 06 00 00 00       	mov    $0x6,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret

0000000000000475 <exec>:
SYSCALL(exec)
 475:	b8 07 00 00 00       	mov    $0x7,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret

000000000000047d <open>:
SYSCALL(open)
 47d:	b8 0f 00 00 00       	mov    $0xf,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret

0000000000000485 <mknod>:
SYSCALL(mknod)
 485:	b8 11 00 00 00       	mov    $0x11,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret

000000000000048d <unlink>:
SYSCALL(unlink)
 48d:	b8 12 00 00 00       	mov    $0x12,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret

0000000000000495 <fstat>:
SYSCALL(fstat)
 495:	b8 08 00 00 00       	mov    $0x8,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret

000000000000049d <link>:
SYSCALL(link)
 49d:	b8 13 00 00 00       	mov    $0x13,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret

00000000000004a5 <mkdir>:
SYSCALL(mkdir)
 4a5:	b8 14 00 00 00       	mov    $0x14,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret

00000000000004ad <chdir>:
SYSCALL(chdir)
 4ad:	b8 09 00 00 00       	mov    $0x9,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret

00000000000004b5 <dup>:
SYSCALL(dup)
 4b5:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret

00000000000004bd <getpid>:
SYSCALL(getpid)
 4bd:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret

00000000000004c5 <sbrk>:
SYSCALL(sbrk)
 4c5:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret

00000000000004cd <sleep>:
SYSCALL(sleep)
 4cd:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret

00000000000004d5 <uptime>:
SYSCALL(uptime)
 4d5:	b8 0e 00 00 00       	mov    $0xe,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret

00000000000004dd <getpinfo>:
SYSCALL(getpinfo)
 4dd:	b8 18 00 00 00       	mov    $0x18,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret

00000000000004e5 <settickets>:
SYSCALL(settickets)
 4e5:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret

00000000000004ed <getfavnum>:
SYSCALL(getfavnum)
 4ed:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret

00000000000004f5 <halt>:
SYSCALL(halt)
 4f5:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret

00000000000004fd <getcount>:
SYSCALL(getcount)
 4fd:	b8 1e 00 00 00       	mov    $0x1e,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret

0000000000000505 <killrandom>:
SYSCALL(killrandom)
 505:	b8 1f 00 00 00       	mov    $0x1f,%eax
 50a:	cd 40                	int    $0x40
 50c:	c3                   	ret

000000000000050d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 50d:	f3 0f 1e fa          	endbr64
 511:	55                   	push   %rbp
 512:	48 89 e5             	mov    %rsp,%rbp
 515:	48 83 ec 10          	sub    $0x10,%rsp
 519:	89 7d fc             	mov    %edi,-0x4(%rbp)
 51c:	89 f0                	mov    %esi,%eax
 51e:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 521:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 525:	8b 45 fc             	mov    -0x4(%rbp),%eax
 528:	ba 01 00 00 00       	mov    $0x1,%edx
 52d:	48 89 ce             	mov    %rcx,%rsi
 530:	89 c7                	mov    %eax,%edi
 532:	e8 26 ff ff ff       	call   45d <write>
}
 537:	90                   	nop
 538:	c9                   	leave
 539:	c3                   	ret

000000000000053a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53a:	f3 0f 1e fa          	endbr64
 53e:	55                   	push   %rbp
 53f:	48 89 e5             	mov    %rsp,%rbp
 542:	48 83 ec 30          	sub    $0x30,%rsp
 546:	89 7d dc             	mov    %edi,-0x24(%rbp)
 549:	89 75 d8             	mov    %esi,-0x28(%rbp)
 54c:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 54f:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 552:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 559:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 55d:	74 17                	je     576 <printint+0x3c>
 55f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 563:	79 11                	jns    576 <printint+0x3c>
    neg = 1;
 565:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 56c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 56f:	f7 d8                	neg    %eax
 571:	89 45 f4             	mov    %eax,-0xc(%rbp)
 574:	eb 06                	jmp    57c <printint+0x42>
  } else {
    x = xx;
 576:	8b 45 d8             	mov    -0x28(%rbp),%eax
 579:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 57c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 583:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 586:	8b 45 f4             	mov    -0xc(%rbp),%eax
 589:	ba 00 00 00 00       	mov    $0x0,%edx
 58e:	f7 f6                	div    %esi
 590:	89 d1                	mov    %edx,%ecx
 592:	8b 45 fc             	mov    -0x4(%rbp),%eax
 595:	8d 50 01             	lea    0x1(%rax),%edx
 598:	89 55 fc             	mov    %edx,-0x4(%rbp)
 59b:	89 ca                	mov    %ecx,%edx
 59d:	0f b6 92 a0 0e 00 00 	movzbl 0xea0(%rdx),%edx
 5a4:	48 98                	cltq
 5a6:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 5aa:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 5ad:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5b0:	ba 00 00 00 00       	mov    $0x0,%edx
 5b5:	f7 f7                	div    %edi
 5b7:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 5be:	75 c3                	jne    583 <printint+0x49>
  if(neg)
 5c0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5c4:	74 2b                	je     5f1 <printint+0xb7>
    buf[i++] = '-';
 5c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5c9:	8d 50 01             	lea    0x1(%rax),%edx
 5cc:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5cf:	48 98                	cltq
 5d1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5d6:	eb 19                	jmp    5f1 <printint+0xb7>
    putc(fd, buf[i]);
 5d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5db:	48 98                	cltq
 5dd:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5e2:	0f be d0             	movsbl %al,%edx
 5e5:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5e8:	89 d6                	mov    %edx,%esi
 5ea:	89 c7                	mov    %eax,%edi
 5ec:	e8 1c ff ff ff       	call   50d <putc>
  while(--i >= 0)
 5f1:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5f9:	79 dd                	jns    5d8 <printint+0x9e>
}
 5fb:	90                   	nop
 5fc:	90                   	nop
 5fd:	c9                   	leave
 5fe:	c3                   	ret

00000000000005ff <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5ff:	f3 0f 1e fa          	endbr64
 603:	55                   	push   %rbp
 604:	48 89 e5             	mov    %rsp,%rbp
 607:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 60e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 614:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 61b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 622:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 629:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 630:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 637:	84 c0                	test   %al,%al
 639:	74 20                	je     65b <printf+0x5c>
 63b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 63f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 643:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 647:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 64b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 64f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 653:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 657:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 65b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 662:	00 00 00 
 665:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 66c:	00 00 00 
 66f:	48 8d 45 10          	lea    0x10(%rbp),%rax
 673:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 67a:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 681:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 688:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 68f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 692:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 699:	00 00 00 
 69c:	e9 a8 02 00 00       	jmp    949 <printf+0x34a>
    c = fmt[i] & 0xff;
 6a1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 6a7:	48 63 d0             	movslq %eax,%rdx
 6aa:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 6b1:	48 01 d0             	add    %rdx,%rax
 6b4:	0f b6 00             	movzbl (%rax),%eax
 6b7:	0f be c0             	movsbl %al,%eax
 6ba:	25 ff 00 00 00       	and    $0xff,%eax
 6bf:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6c5:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6cc:	75 35                	jne    703 <printf+0x104>
      if(c == '%'){
 6ce:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6d5:	75 0f                	jne    6e6 <printf+0xe7>
        state = '%';
 6d7:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6de:	00 00 00 
 6e1:	e9 5c 02 00 00       	jmp    942 <printf+0x343>
      } else {
        putc(fd, c);
 6e6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6ec:	0f be d0             	movsbl %al,%edx
 6ef:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6f5:	89 d6                	mov    %edx,%esi
 6f7:	89 c7                	mov    %eax,%edi
 6f9:	e8 0f fe ff ff       	call   50d <putc>
 6fe:	e9 3f 02 00 00       	jmp    942 <printf+0x343>
      }
    } else if(state == '%'){
 703:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 70a:	0f 85 32 02 00 00    	jne    942 <printf+0x343>
      if(c == 'd'){
 710:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 717:	75 5e                	jne    777 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 719:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 71f:	83 f8 2f             	cmp    $0x2f,%eax
 722:	77 23                	ja     747 <printf+0x148>
 724:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 72b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 731:	89 d2                	mov    %edx,%edx
 733:	48 01 d0             	add    %rdx,%rax
 736:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 73c:	83 c2 08             	add    $0x8,%edx
 73f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 745:	eb 12                	jmp    759 <printf+0x15a>
 747:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 74e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 752:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 759:	8b 30                	mov    (%rax),%esi
 75b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 761:	b9 01 00 00 00       	mov    $0x1,%ecx
 766:	ba 0a 00 00 00       	mov    $0xa,%edx
 76b:	89 c7                	mov    %eax,%edi
 76d:	e8 c8 fd ff ff       	call   53a <printint>
 772:	e9 c1 01 00 00       	jmp    938 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 777:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 77e:	74 09                	je     789 <printf+0x18a>
 780:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 787:	75 5e                	jne    7e7 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 789:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 78f:	83 f8 2f             	cmp    $0x2f,%eax
 792:	77 23                	ja     7b7 <printf+0x1b8>
 794:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 79b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a1:	89 d2                	mov    %edx,%edx
 7a3:	48 01 d0             	add    %rdx,%rax
 7a6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ac:	83 c2 08             	add    $0x8,%edx
 7af:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7b5:	eb 12                	jmp    7c9 <printf+0x1ca>
 7b7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7be:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7c2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7c9:	8b 30                	mov    (%rax),%esi
 7cb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d1:	b9 00 00 00 00       	mov    $0x0,%ecx
 7d6:	ba 10 00 00 00       	mov    $0x10,%edx
 7db:	89 c7                	mov    %eax,%edi
 7dd:	e8 58 fd ff ff       	call   53a <printint>
 7e2:	e9 51 01 00 00       	jmp    938 <printf+0x339>
      } else if(c == 's'){
 7e7:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7ee:	0f 85 98 00 00 00    	jne    88c <printf+0x28d>
        s = va_arg(ap, char*);
 7f4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7fa:	83 f8 2f             	cmp    $0x2f,%eax
 7fd:	77 23                	ja     822 <printf+0x223>
 7ff:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 806:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 80c:	89 d2                	mov    %edx,%edx
 80e:	48 01 d0             	add    %rdx,%rax
 811:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 817:	83 c2 08             	add    $0x8,%edx
 81a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 820:	eb 12                	jmp    834 <printf+0x235>
 822:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 829:	48 8d 50 08          	lea    0x8(%rax),%rdx
 82d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 834:	48 8b 00             	mov    (%rax),%rax
 837:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 83e:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 845:	00 
 846:	75 31                	jne    879 <printf+0x27a>
          s = "(null)";
 848:	48 c7 85 48 ff ff ff 	movq   $0xc3a,-0xb8(%rbp)
 84f:	3a 0c 00 00 
        while(*s != 0){
 853:	eb 24                	jmp    879 <printf+0x27a>
          putc(fd, *s);
 855:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 85c:	0f b6 00             	movzbl (%rax),%eax
 85f:	0f be d0             	movsbl %al,%edx
 862:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 868:	89 d6                	mov    %edx,%esi
 86a:	89 c7                	mov    %eax,%edi
 86c:	e8 9c fc ff ff       	call   50d <putc>
          s++;
 871:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 878:	01 
        while(*s != 0){
 879:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 880:	0f b6 00             	movzbl (%rax),%eax
 883:	84 c0                	test   %al,%al
 885:	75 ce                	jne    855 <printf+0x256>
 887:	e9 ac 00 00 00       	jmp    938 <printf+0x339>
        }
      } else if(c == 'c'){
 88c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 893:	75 56                	jne    8eb <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 895:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 89b:	83 f8 2f             	cmp    $0x2f,%eax
 89e:	77 23                	ja     8c3 <printf+0x2c4>
 8a0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8a7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8ad:	89 d2                	mov    %edx,%edx
 8af:	48 01 d0             	add    %rdx,%rax
 8b2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8b8:	83 c2 08             	add    $0x8,%edx
 8bb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8c1:	eb 12                	jmp    8d5 <printf+0x2d6>
 8c3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8ca:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8ce:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8d5:	8b 00                	mov    (%rax),%eax
 8d7:	0f be d0             	movsbl %al,%edx
 8da:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8e0:	89 d6                	mov    %edx,%esi
 8e2:	89 c7                	mov    %eax,%edi
 8e4:	e8 24 fc ff ff       	call   50d <putc>
 8e9:	eb 4d                	jmp    938 <printf+0x339>
      } else if(c == '%'){
 8eb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8f2:	75 1a                	jne    90e <printf+0x30f>
        putc(fd, c);
 8f4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8fa:	0f be d0             	movsbl %al,%edx
 8fd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 903:	89 d6                	mov    %edx,%esi
 905:	89 c7                	mov    %eax,%edi
 907:	e8 01 fc ff ff       	call   50d <putc>
 90c:	eb 2a                	jmp    938 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 90e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 914:	be 25 00 00 00       	mov    $0x25,%esi
 919:	89 c7                	mov    %eax,%edi
 91b:	e8 ed fb ff ff       	call   50d <putc>
        putc(fd, c);
 920:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 926:	0f be d0             	movsbl %al,%edx
 929:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 92f:	89 d6                	mov    %edx,%esi
 931:	89 c7                	mov    %eax,%edi
 933:	e8 d5 fb ff ff       	call   50d <putc>
      }
      state = 0;
 938:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 93f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 942:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 949:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 94f:	48 63 d0             	movslq %eax,%rdx
 952:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 959:	48 01 d0             	add    %rdx,%rax
 95c:	0f b6 00             	movzbl (%rax),%eax
 95f:	84 c0                	test   %al,%al
 961:	0f 85 3a fd ff ff    	jne    6a1 <printf+0xa2>
    }
  }
}
 967:	90                   	nop
 968:	90                   	nop
 969:	c9                   	leave
 96a:	c3                   	ret

000000000000096b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 96b:	f3 0f 1e fa          	endbr64
 96f:	55                   	push   %rbp
 970:	48 89 e5             	mov    %rsp,%rbp
 973:	48 83 ec 18          	sub    $0x18,%rsp
 977:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 97b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 97f:	48 83 e8 10          	sub    $0x10,%rax
 983:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 987:	48 8b 05 42 07 00 00 	mov    0x742(%rip),%rax        # 10d0 <freep>
 98e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 992:	eb 2f                	jmp    9c3 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 994:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 998:	48 8b 00             	mov    (%rax),%rax
 99b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 99f:	72 17                	jb     9b8 <free+0x4d>
 9a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9a9:	72 2f                	jb     9da <free+0x6f>
 9ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9af:	48 8b 00             	mov    (%rax),%rax
 9b2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9b6:	72 22                	jb     9da <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bc:	48 8b 00             	mov    (%rax),%rax
 9bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9cb:	73 c7                	jae    994 <free+0x29>
 9cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d1:	48 8b 00             	mov    (%rax),%rax
 9d4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9d8:	73 ba                	jae    994 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9de:	8b 40 08             	mov    0x8(%rax),%eax
 9e1:	89 c0                	mov    %eax,%eax
 9e3:	48 c1 e0 04          	shl    $0x4,%rax
 9e7:	48 89 c2             	mov    %rax,%rdx
 9ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ee:	48 01 c2             	add    %rax,%rdx
 9f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f5:	48 8b 00             	mov    (%rax),%rax
 9f8:	48 39 c2             	cmp    %rax,%rdx
 9fb:	75 2d                	jne    a2a <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a01:	8b 50 08             	mov    0x8(%rax),%edx
 a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a08:	48 8b 00             	mov    (%rax),%rax
 a0b:	8b 40 08             	mov    0x8(%rax),%eax
 a0e:	01 c2                	add    %eax,%edx
 a10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a14:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1b:	48 8b 00             	mov    (%rax),%rax
 a1e:	48 8b 10             	mov    (%rax),%rdx
 a21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a25:	48 89 10             	mov    %rdx,(%rax)
 a28:	eb 0e                	jmp    a38 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 a2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a2e:	48 8b 10             	mov    (%rax),%rdx
 a31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a35:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3c:	8b 40 08             	mov    0x8(%rax),%eax
 a3f:	89 c0                	mov    %eax,%eax
 a41:	48 c1 e0 04          	shl    $0x4,%rax
 a45:	48 89 c2             	mov    %rax,%rdx
 a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4c:	48 01 d0             	add    %rdx,%rax
 a4f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a53:	75 27                	jne    a7c <free+0x111>
    p->s.size += bp->s.size;
 a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a59:	8b 50 08             	mov    0x8(%rax),%edx
 a5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a60:	8b 40 08             	mov    0x8(%rax),%eax
 a63:	01 c2                	add    %eax,%edx
 a65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a69:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a70:	48 8b 10             	mov    (%rax),%rdx
 a73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a77:	48 89 10             	mov    %rdx,(%rax)
 a7a:	eb 0b                	jmp    a87 <free+0x11c>
  } else
    p->s.ptr = bp;
 a7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a80:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a84:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8b:	48 89 05 3e 06 00 00 	mov    %rax,0x63e(%rip)        # 10d0 <freep>
}
 a92:	90                   	nop
 a93:	c9                   	leave
 a94:	c3                   	ret

0000000000000a95 <morecore>:

static Header*
morecore(uint nu)
{
 a95:	f3 0f 1e fa          	endbr64
 a99:	55                   	push   %rbp
 a9a:	48 89 e5             	mov    %rsp,%rbp
 a9d:	48 83 ec 20          	sub    $0x20,%rsp
 aa1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 aa4:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 aab:	77 07                	ja     ab4 <morecore+0x1f>
    nu = 4096;
 aad:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 ab4:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ab7:	c1 e0 04             	shl    $0x4,%eax
 aba:	89 c7                	mov    %eax,%edi
 abc:	e8 04 fa ff ff       	call   4c5 <sbrk>
 ac1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 ac5:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 aca:	75 07                	jne    ad3 <morecore+0x3e>
    return 0;
 acc:	b8 00 00 00 00       	mov    $0x0,%eax
 ad1:	eb 29                	jmp    afc <morecore+0x67>
  hp = (Header*)p;
 ad3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 adb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 adf:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ae2:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 ae5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae9:	48 83 c0 10          	add    $0x10,%rax
 aed:	48 89 c7             	mov    %rax,%rdi
 af0:	e8 76 fe ff ff       	call   96b <free>
  return freep;
 af5:	48 8b 05 d4 05 00 00 	mov    0x5d4(%rip),%rax        # 10d0 <freep>
}
 afc:	c9                   	leave
 afd:	c3                   	ret

0000000000000afe <malloc>:

void*
malloc(uint nbytes)
{
 afe:	f3 0f 1e fa          	endbr64
 b02:	55                   	push   %rbp
 b03:	48 89 e5             	mov    %rsp,%rbp
 b06:	48 83 ec 30          	sub    $0x30,%rsp
 b0a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b0d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 b10:	48 83 c0 0f          	add    $0xf,%rax
 b14:	48 c1 e8 04          	shr    $0x4,%rax
 b18:	83 c0 01             	add    $0x1,%eax
 b1b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b1e:	48 8b 05 ab 05 00 00 	mov    0x5ab(%rip),%rax        # 10d0 <freep>
 b25:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b29:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b2e:	75 2b                	jne    b5b <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 b30:	48 c7 45 f0 c0 10 00 	movq   $0x10c0,-0x10(%rbp)
 b37:	00 
 b38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b3c:	48 89 05 8d 05 00 00 	mov    %rax,0x58d(%rip)        # 10d0 <freep>
 b43:	48 8b 05 86 05 00 00 	mov    0x586(%rip),%rax        # 10d0 <freep>
 b4a:	48 89 05 6f 05 00 00 	mov    %rax,0x56f(%rip)        # 10c0 <base>
    base.s.size = 0;
 b51:	c7 05 6d 05 00 00 00 	movl   $0x0,0x56d(%rip)        # 10c8 <base+0x8>
 b58:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b5f:	48 8b 00             	mov    (%rax),%rax
 b62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6a:	8b 40 08             	mov    0x8(%rax),%eax
 b6d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b70:	72 5f                	jb     bd1 <malloc+0xd3>
      if(p->s.size == nunits)
 b72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b76:	8b 40 08             	mov    0x8(%rax),%eax
 b79:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b7c:	75 10                	jne    b8e <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b82:	48 8b 10             	mov    (%rax),%rdx
 b85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b89:	48 89 10             	mov    %rdx,(%rax)
 b8c:	eb 2e                	jmp    bbc <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b92:	8b 40 08             	mov    0x8(%rax),%eax
 b95:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b98:	89 c2                	mov    %eax,%edx
 b9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b9e:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba5:	8b 40 08             	mov    0x8(%rax),%eax
 ba8:	89 c0                	mov    %eax,%eax
 baa:	48 c1 e0 04          	shl    $0x4,%rax
 bae:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb6:	8b 55 ec             	mov    -0x14(%rbp),%edx
 bb9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 bbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bc0:	48 89 05 09 05 00 00 	mov    %rax,0x509(%rip)        # 10d0 <freep>
      return (void*)(p + 1);
 bc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcb:	48 83 c0 10          	add    $0x10,%rax
 bcf:	eb 41                	jmp    c12 <malloc+0x114>
    }
    if(p == freep)
 bd1:	48 8b 05 f8 04 00 00 	mov    0x4f8(%rip),%rax        # 10d0 <freep>
 bd8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bdc:	75 1c                	jne    bfa <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 bde:	8b 45 ec             	mov    -0x14(%rbp),%eax
 be1:	89 c7                	mov    %eax,%edi
 be3:	e8 ad fe ff ff       	call   a95 <morecore>
 be8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bec:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bf1:	75 07                	jne    bfa <malloc+0xfc>
        return 0;
 bf3:	b8 00 00 00 00       	mov    $0x0,%eax
 bf8:	eb 18                	jmp    c12 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bfe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 c02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c06:	48 8b 00             	mov    (%rax),%rax
 c09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c0d:	e9 54 ff ff ff       	jmp    b66 <malloc+0x68>
  }
}
 c12:	c9                   	leave
 c13:	c3                   	ret
