
fs/forktest:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
   f:	89 bd 4c ff ff ff    	mov    %edi,-0xb4(%rbp)
  15:	48 89 b5 40 ff ff ff 	mov    %rsi,-0xc0(%rbp)
  1c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  23:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  2a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  31:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  38:	84 c0                	test   %al,%al
  3a:	74 20                	je     5c <printf+0x5c>
  3c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  40:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  44:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  48:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  4c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  50:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  54:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  58:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  write(fd, s, strlen(s));
  5c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
  63:	48 89 c7             	mov    %rax,%rdi
  66:	e8 eb 01 00 00       	call   256 <strlen>
  6b:	89 c2                	mov    %eax,%edx
  6d:	48 8b 8d 40 ff ff ff 	mov    -0xc0(%rbp),%rcx
  74:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  7a:	48 89 ce             	mov    %rcx,%rsi
  7d:	89 c7                	mov    %eax,%edi
  7f:	e8 35 04 00 00       	call   4b9 <write>
}
  84:	90                   	nop
  85:	c9                   	leave
  86:	c3                   	ret

0000000000000087 <forktest>:

void
forktest(void)
{
  87:	f3 0f 1e fa          	endbr64
  8b:	55                   	push   %rbp
  8c:	48 89 e5             	mov    %rsp,%rbp
  8f:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
  93:	48 c7 c6 68 05 00 00 	mov    $0x568,%rsi
  9a:	bf 01 00 00 00       	mov    $0x1,%edi
  9f:	b8 00 00 00 00       	mov    $0x0,%eax
  a4:	e8 57 ff ff ff       	call   0 <printf>

  for(n=0; n<N; n++){
  a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  b0:	eb 1d                	jmp    cf <forktest+0x48>
    pid = fork();
  b2:	e8 da 03 00 00       	call   491 <fork>
  b7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
  ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  be:	78 1a                	js     da <forktest+0x53>
      break;
    if(pid == 0)
  c0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  c4:	75 05                	jne    cb <forktest+0x44>
      exit();
  c6:	e8 ce 03 00 00       	call   499 <exit>
  for(n=0; n<N; n++){
  cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  cf:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
  d6:	7e da                	jle    b2 <forktest+0x2b>
  d8:	eb 01                	jmp    db <forktest+0x54>
      break;
  da:	90                   	nop
  }
  
  if(n == N){
  db:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
  e2:	75 48                	jne    12c <forktest+0xa5>
    printf(1, "fork claimed to work N times!\n", N);
  e4:	ba e8 03 00 00       	mov    $0x3e8,%edx
  e9:	48 c7 c6 78 05 00 00 	mov    $0x578,%rsi
  f0:	bf 01 00 00 00       	mov    $0x1,%edi
  f5:	b8 00 00 00 00       	mov    $0x0,%eax
  fa:	e8 01 ff ff ff       	call   0 <printf>
    exit();
  ff:	e8 95 03 00 00       	call   499 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
 104:	e8 98 03 00 00       	call   4a1 <wait>
 109:	85 c0                	test   %eax,%eax
 10b:	79 1b                	jns    128 <forktest+0xa1>
      printf(1, "wait stopped early\n");
 10d:	48 c7 c6 97 05 00 00 	mov    $0x597,%rsi
 114:	bf 01 00 00 00       	mov    $0x1,%edi
 119:	b8 00 00 00 00       	mov    $0x0,%eax
 11e:	e8 dd fe ff ff       	call   0 <printf>
      exit();
 123:	e8 71 03 00 00       	call   499 <exit>
  for(; n > 0; n--){
 128:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 12c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 130:	7f d2                	jg     104 <forktest+0x7d>
    }
  }
  
  if(wait() != -1){
 132:	e8 6a 03 00 00       	call   4a1 <wait>
 137:	83 f8 ff             	cmp    $0xffffffff,%eax
 13a:	74 1b                	je     157 <forktest+0xd0>
    printf(1, "wait got too many\n");
 13c:	48 c7 c6 ab 05 00 00 	mov    $0x5ab,%rsi
 143:	bf 01 00 00 00       	mov    $0x1,%edi
 148:	b8 00 00 00 00       	mov    $0x0,%eax
 14d:	e8 ae fe ff ff       	call   0 <printf>
    exit();
 152:	e8 42 03 00 00       	call   499 <exit>
  }
  
  printf(1, "fork test OK\n");
 157:	48 c7 c6 be 05 00 00 	mov    $0x5be,%rsi
 15e:	bf 01 00 00 00       	mov    $0x1,%edi
 163:	b8 00 00 00 00       	mov    $0x0,%eax
 168:	e8 93 fe ff ff       	call   0 <printf>
}
 16d:	90                   	nop
 16e:	c9                   	leave
 16f:	c3                   	ret

0000000000000170 <main>:

int
main(void)
{
 170:	f3 0f 1e fa          	endbr64
 174:	55                   	push   %rbp
 175:	48 89 e5             	mov    %rsp,%rbp
  forktest();
 178:	e8 0a ff ff ff       	call   87 <forktest>
  exit();
 17d:	e8 17 03 00 00       	call   499 <exit>

0000000000000182 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 182:	55                   	push   %rbp
 183:	48 89 e5             	mov    %rsp,%rbp
 186:	48 83 ec 10          	sub    $0x10,%rsp
 18a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 18e:	89 75 f4             	mov    %esi,-0xc(%rbp)
 191:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 194:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 198:	8b 55 f0             	mov    -0x10(%rbp),%edx
 19b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 19e:	48 89 ce             	mov    %rcx,%rsi
 1a1:	48 89 f7             	mov    %rsi,%rdi
 1a4:	89 d1                	mov    %edx,%ecx
 1a6:	fc                   	cld
 1a7:	f3 aa                	rep stos %al,%es:(%rdi)
 1a9:	89 ca                	mov    %ecx,%edx
 1ab:	48 89 fe             	mov    %rdi,%rsi
 1ae:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 1b2:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1b5:	90                   	nop
 1b6:	c9                   	leave
 1b7:	c3                   	ret

00000000000001b8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1b8:	f3 0f 1e fa          	endbr64
 1bc:	55                   	push   %rbp
 1bd:	48 89 e5             	mov    %rsp,%rbp
 1c0:	48 83 ec 20          	sub    $0x20,%rsp
 1c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1c8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 1cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 1d4:	90                   	nop
 1d5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 1d9:	48 8d 42 01          	lea    0x1(%rdx),%rax
 1dd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 1e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1e5:	48 8d 48 01          	lea    0x1(%rax),%rcx
 1e9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 1ed:	0f b6 12             	movzbl (%rdx),%edx
 1f0:	88 10                	mov    %dl,(%rax)
 1f2:	0f b6 00             	movzbl (%rax),%eax
 1f5:	84 c0                	test   %al,%al
 1f7:	75 dc                	jne    1d5 <strcpy+0x1d>
    ;
  return os;
 1f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1fd:	c9                   	leave
 1fe:	c3                   	ret

00000000000001ff <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ff:	f3 0f 1e fa          	endbr64
 203:	55                   	push   %rbp
 204:	48 89 e5             	mov    %rsp,%rbp
 207:	48 83 ec 10          	sub    $0x10,%rsp
 20b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 20f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 213:	eb 0a                	jmp    21f <strcmp+0x20>
    p++, q++;
 215:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 21a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 21f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 223:	0f b6 00             	movzbl (%rax),%eax
 226:	84 c0                	test   %al,%al
 228:	74 12                	je     23c <strcmp+0x3d>
 22a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22e:	0f b6 10             	movzbl (%rax),%edx
 231:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 235:	0f b6 00             	movzbl (%rax),%eax
 238:	38 c2                	cmp    %al,%dl
 23a:	74 d9                	je     215 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 23c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 240:	0f b6 00             	movzbl (%rax),%eax
 243:	0f b6 d0             	movzbl %al,%edx
 246:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 24a:	0f b6 00             	movzbl (%rax),%eax
 24d:	0f b6 c0             	movzbl %al,%eax
 250:	29 c2                	sub    %eax,%edx
 252:	89 d0                	mov    %edx,%eax
}
 254:	c9                   	leave
 255:	c3                   	ret

0000000000000256 <strlen>:

uint
strlen(char *s)
{
 256:	f3 0f 1e fa          	endbr64
 25a:	55                   	push   %rbp
 25b:	48 89 e5             	mov    %rsp,%rbp
 25e:	48 83 ec 18          	sub    $0x18,%rsp
 262:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 266:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 26d:	eb 04                	jmp    273 <strlen+0x1d>
 26f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 273:	8b 45 fc             	mov    -0x4(%rbp),%eax
 276:	48 63 d0             	movslq %eax,%rdx
 279:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 27d:	48 01 d0             	add    %rdx,%rax
 280:	0f b6 00             	movzbl (%rax),%eax
 283:	84 c0                	test   %al,%al
 285:	75 e8                	jne    26f <strlen+0x19>
    ;
  return n;
 287:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 28a:	c9                   	leave
 28b:	c3                   	ret

000000000000028c <memset>:

void*
memset(void *dst, int c, uint n)
{
 28c:	f3 0f 1e fa          	endbr64
 290:	55                   	push   %rbp
 291:	48 89 e5             	mov    %rsp,%rbp
 294:	48 83 ec 10          	sub    $0x10,%rsp
 298:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 29c:	89 75 f4             	mov    %esi,-0xc(%rbp)
 29f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 2a2:	8b 55 f0             	mov    -0x10(%rbp),%edx
 2a5:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 2a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2ac:	89 ce                	mov    %ecx,%esi
 2ae:	48 89 c7             	mov    %rax,%rdi
 2b1:	e8 cc fe ff ff       	call   182 <stosb>
  return dst;
 2b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 2ba:	c9                   	leave
 2bb:	c3                   	ret

00000000000002bc <strchr>:

char*
strchr(const char *s, char c)
{
 2bc:	f3 0f 1e fa          	endbr64
 2c0:	55                   	push   %rbp
 2c1:	48 89 e5             	mov    %rsp,%rbp
 2c4:	48 83 ec 10          	sub    $0x10,%rsp
 2c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2cc:	89 f0                	mov    %esi,%eax
 2ce:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 2d1:	eb 17                	jmp    2ea <strchr+0x2e>
    if(*s == c)
 2d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2d7:	0f b6 00             	movzbl (%rax),%eax
 2da:	38 45 f4             	cmp    %al,-0xc(%rbp)
 2dd:	75 06                	jne    2e5 <strchr+0x29>
      return (char*)s;
 2df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2e3:	eb 15                	jmp    2fa <strchr+0x3e>
  for(; *s; s++)
 2e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 2ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2ee:	0f b6 00             	movzbl (%rax),%eax
 2f1:	84 c0                	test   %al,%al
 2f3:	75 de                	jne    2d3 <strchr+0x17>
  return 0;
 2f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2fa:	c9                   	leave
 2fb:	c3                   	ret

00000000000002fc <gets>:

char*
gets(char *buf, int max)
{
 2fc:	f3 0f 1e fa          	endbr64
 300:	55                   	push   %rbp
 301:	48 89 e5             	mov    %rsp,%rbp
 304:	48 83 ec 20          	sub    $0x20,%rsp
 308:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 30c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 316:	eb 48                	jmp    360 <gets+0x64>
    cc = read(0, &c, 1);
 318:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 31c:	ba 01 00 00 00       	mov    $0x1,%edx
 321:	48 89 c6             	mov    %rax,%rsi
 324:	bf 00 00 00 00       	mov    $0x0,%edi
 329:	e8 83 01 00 00       	call   4b1 <read>
 32e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 331:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 335:	7e 36                	jle    36d <gets+0x71>
      break;
    buf[i++] = c;
 337:	8b 45 fc             	mov    -0x4(%rbp),%eax
 33a:	8d 50 01             	lea    0x1(%rax),%edx
 33d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 340:	48 63 d0             	movslq %eax,%rdx
 343:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 347:	48 01 c2             	add    %rax,%rdx
 34a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 34e:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 350:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 354:	3c 0a                	cmp    $0xa,%al
 356:	74 16                	je     36e <gets+0x72>
 358:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 35c:	3c 0d                	cmp    $0xd,%al
 35e:	74 0e                	je     36e <gets+0x72>
  for(i=0; i+1 < max; ){
 360:	8b 45 fc             	mov    -0x4(%rbp),%eax
 363:	83 c0 01             	add    $0x1,%eax
 366:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 369:	7f ad                	jg     318 <gets+0x1c>
 36b:	eb 01                	jmp    36e <gets+0x72>
      break;
 36d:	90                   	nop
      break;
  }
  buf[i] = '\0';
 36e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 371:	48 63 d0             	movslq %eax,%rdx
 374:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 378:	48 01 d0             	add    %rdx,%rax
 37b:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 37e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 382:	c9                   	leave
 383:	c3                   	ret

0000000000000384 <stat>:

int
stat(char *n, struct stat *st)
{
 384:	f3 0f 1e fa          	endbr64
 388:	55                   	push   %rbp
 389:	48 89 e5             	mov    %rsp,%rbp
 38c:	48 83 ec 20          	sub    $0x20,%rsp
 390:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 394:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 398:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 39c:	be 00 00 00 00       	mov    $0x0,%esi
 3a1:	48 89 c7             	mov    %rax,%rdi
 3a4:	e8 30 01 00 00       	call   4d9 <open>
 3a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 3ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 3b0:	79 07                	jns    3b9 <stat+0x35>
    return -1;
 3b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3b7:	eb 21                	jmp    3da <stat+0x56>
  r = fstat(fd, st);
 3b9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 3bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3c0:	48 89 d6             	mov    %rdx,%rsi
 3c3:	89 c7                	mov    %eax,%edi
 3c5:	e8 27 01 00 00       	call   4f1 <fstat>
 3ca:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 3cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3d0:	89 c7                	mov    %eax,%edi
 3d2:	e8 ea 00 00 00       	call   4c1 <close>
  return r;
 3d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 3da:	c9                   	leave
 3db:	c3                   	ret

00000000000003dc <atoi>:

int
atoi(const char *s)
{
 3dc:	f3 0f 1e fa          	endbr64
 3e0:	55                   	push   %rbp
 3e1:	48 89 e5             	mov    %rsp,%rbp
 3e4:	48 83 ec 18          	sub    $0x18,%rsp
 3e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 3ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3f3:	eb 28                	jmp    41d <atoi+0x41>
    n = n*10 + *s++ - '0';
 3f5:	8b 55 fc             	mov    -0x4(%rbp),%edx
 3f8:	89 d0                	mov    %edx,%eax
 3fa:	c1 e0 02             	shl    $0x2,%eax
 3fd:	01 d0                	add    %edx,%eax
 3ff:	01 c0                	add    %eax,%eax
 401:	89 c1                	mov    %eax,%ecx
 403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 407:	48 8d 50 01          	lea    0x1(%rax),%rdx
 40b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 40f:	0f b6 00             	movzbl (%rax),%eax
 412:	0f be c0             	movsbl %al,%eax
 415:	01 c8                	add    %ecx,%eax
 417:	83 e8 30             	sub    $0x30,%eax
 41a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 41d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 421:	0f b6 00             	movzbl (%rax),%eax
 424:	3c 2f                	cmp    $0x2f,%al
 426:	7e 0b                	jle    433 <atoi+0x57>
 428:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 42c:	0f b6 00             	movzbl (%rax),%eax
 42f:	3c 39                	cmp    $0x39,%al
 431:	7e c2                	jle    3f5 <atoi+0x19>
  return n;
 433:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 436:	c9                   	leave
 437:	c3                   	ret

0000000000000438 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 438:	f3 0f 1e fa          	endbr64
 43c:	55                   	push   %rbp
 43d:	48 89 e5             	mov    %rsp,%rbp
 440:	48 83 ec 28          	sub    $0x28,%rsp
 444:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 448:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 44c:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 44f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 453:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 457:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 45b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 45f:	eb 1d                	jmp    47e <memmove+0x46>
    *dst++ = *src++;
 461:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 465:	48 8d 42 01          	lea    0x1(%rdx),%rax
 469:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 46d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 471:	48 8d 48 01          	lea    0x1(%rax),%rcx
 475:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 479:	0f b6 12             	movzbl (%rdx),%edx
 47c:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 47e:	8b 45 dc             	mov    -0x24(%rbp),%eax
 481:	8d 50 ff             	lea    -0x1(%rax),%edx
 484:	89 55 dc             	mov    %edx,-0x24(%rbp)
 487:	85 c0                	test   %eax,%eax
 489:	7f d6                	jg     461 <memmove+0x29>
  return vdst;
 48b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 48f:	c9                   	leave
 490:	c3                   	ret

0000000000000491 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 491:	b8 01 00 00 00       	mov    $0x1,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret

0000000000000499 <exit>:
SYSCALL(exit)
 499:	b8 02 00 00 00       	mov    $0x2,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret

00000000000004a1 <wait>:
SYSCALL(wait)
 4a1:	b8 03 00 00 00       	mov    $0x3,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret

00000000000004a9 <pipe>:
SYSCALL(pipe)
 4a9:	b8 04 00 00 00       	mov    $0x4,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret

00000000000004b1 <read>:
SYSCALL(read)
 4b1:	b8 05 00 00 00       	mov    $0x5,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret

00000000000004b9 <write>:
SYSCALL(write)
 4b9:	b8 10 00 00 00       	mov    $0x10,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret

00000000000004c1 <close>:
SYSCALL(close)
 4c1:	b8 15 00 00 00       	mov    $0x15,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret

00000000000004c9 <kill>:
SYSCALL(kill)
 4c9:	b8 06 00 00 00       	mov    $0x6,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret

00000000000004d1 <exec>:
SYSCALL(exec)
 4d1:	b8 07 00 00 00       	mov    $0x7,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret

00000000000004d9 <open>:
SYSCALL(open)
 4d9:	b8 0f 00 00 00       	mov    $0xf,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret

00000000000004e1 <mknod>:
SYSCALL(mknod)
 4e1:	b8 11 00 00 00       	mov    $0x11,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret

00000000000004e9 <unlink>:
SYSCALL(unlink)
 4e9:	b8 12 00 00 00       	mov    $0x12,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret

00000000000004f1 <fstat>:
SYSCALL(fstat)
 4f1:	b8 08 00 00 00       	mov    $0x8,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret

00000000000004f9 <link>:
SYSCALL(link)
 4f9:	b8 13 00 00 00       	mov    $0x13,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret

0000000000000501 <mkdir>:
SYSCALL(mkdir)
 501:	b8 14 00 00 00       	mov    $0x14,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret

0000000000000509 <chdir>:
SYSCALL(chdir)
 509:	b8 09 00 00 00       	mov    $0x9,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret

0000000000000511 <dup>:
SYSCALL(dup)
 511:	b8 0a 00 00 00       	mov    $0xa,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret

0000000000000519 <getpid>:
SYSCALL(getpid)
 519:	b8 0b 00 00 00       	mov    $0xb,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret

0000000000000521 <sbrk>:
SYSCALL(sbrk)
 521:	b8 0c 00 00 00       	mov    $0xc,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret

0000000000000529 <sleep>:
SYSCALL(sleep)
 529:	b8 0d 00 00 00       	mov    $0xd,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret

0000000000000531 <uptime>:
SYSCALL(uptime)
 531:	b8 0e 00 00 00       	mov    $0xe,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret

0000000000000539 <getpinfo>:
SYSCALL(getpinfo)
 539:	b8 18 00 00 00       	mov    $0x18,%eax
 53e:	cd 40                	int    $0x40
 540:	c3                   	ret

0000000000000541 <settickets>:
SYSCALL(settickets)
 541:	b8 1b 00 00 00       	mov    $0x1b,%eax
 546:	cd 40                	int    $0x40
 548:	c3                   	ret

0000000000000549 <getfavnum>:
SYSCALL(getfavnum)
 549:	b8 1c 00 00 00       	mov    $0x1c,%eax
 54e:	cd 40                	int    $0x40
 550:	c3                   	ret

0000000000000551 <halt>:
SYSCALL(halt)
 551:	b8 1d 00 00 00       	mov    $0x1d,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret

0000000000000559 <getcount>:
SYSCALL(getcount)
 559:	b8 1e 00 00 00       	mov    $0x1e,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret
