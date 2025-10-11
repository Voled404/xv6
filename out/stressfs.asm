
fs/stressfs:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
   f:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
  15:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
  int fd, i;
  char path[] = "stressfs0";
  1c:	48 b8 73 74 72 65 73 	movabs $0x7366737365727473,%rax
  23:	73 66 73 
  26:	48 89 45 ee          	mov    %rax,-0x12(%rbp)
  2a:	66 c7 45 f6 30 00    	movw   $0x30,-0xa(%rbp)
  char data[512];

  printf(1, "stressfs starting\n");
  30:	48 c7 c6 41 0c 00 00 	mov    $0xc41,%rsi
  37:	bf 01 00 00 00       	mov    $0x1,%edi
  3c:	b8 00 00 00 00       	mov    $0x0,%eax
  41:	e8 e6 05 00 00       	call   62c <printf>
  memset(data, 'a', sizeof(data));
  46:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
  4d:	ba 00 02 00 00       	mov    $0x200,%edx
  52:	be 61 00 00 00       	mov    $0x61,%esi
  57:	48 89 c7             	mov    %rax,%rdi
  5a:	e8 06 02 00 00       	call   265 <memset>

  for(i = 0; i < 4; i++)
  5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  66:	eb 0d                	jmp    75 <main+0x75>
    if(fork() > 0)
  68:	e8 fd 03 00 00       	call   46a <fork>
  6d:	85 c0                	test   %eax,%eax
  6f:	7f 0c                	jg     7d <main+0x7d>
  for(i = 0; i < 4; i++)
  71:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  75:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  79:	7e ed                	jle    68 <main+0x68>
  7b:	eb 01                	jmp    7e <main+0x7e>
      break;
  7d:	90                   	nop

  printf(1, "write %d\n", i);
  7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  81:	89 c2                	mov    %eax,%edx
  83:	48 c7 c6 54 0c 00 00 	mov    $0xc54,%rsi
  8a:	bf 01 00 00 00       	mov    $0x1,%edi
  8f:	b8 00 00 00 00       	mov    $0x0,%eax
  94:	e8 93 05 00 00       	call   62c <printf>

  path[8] += i;
  99:	0f b6 45 f6          	movzbl -0xa(%rbp),%eax
  9d:	89 c2                	mov    %eax,%edx
  9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  a2:	01 d0                	add    %edx,%eax
  a4:	88 45 f6             	mov    %al,-0xa(%rbp)
  fd = open(path, O_CREATE | O_RDWR);
  a7:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
  ab:	be 02 02 00 00       	mov    $0x202,%esi
  b0:	48 89 c7             	mov    %rax,%rdi
  b3:	e8 fa 03 00 00       	call   4b2 <open>
  b8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++)
  bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  c2:	eb 1d                	jmp    e1 <main+0xe1>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  c4:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
  cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  ce:	ba 00 02 00 00       	mov    $0x200,%edx
  d3:	48 89 ce             	mov    %rcx,%rsi
  d6:	89 c7                	mov    %eax,%edi
  d8:	e8 b5 03 00 00       	call   492 <write>
  for(i = 0; i < 20; i++)
  dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  e1:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
  e5:	7e dd                	jle    c4 <main+0xc4>
  close(fd);
  e7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  ea:	89 c7                	mov    %eax,%edi
  ec:	e8 a9 03 00 00       	call   49a <close>

  printf(1, "read\n");
  f1:	48 c7 c6 5e 0c 00 00 	mov    $0xc5e,%rsi
  f8:	bf 01 00 00 00       	mov    $0x1,%edi
  fd:	b8 00 00 00 00       	mov    $0x0,%eax
 102:	e8 25 05 00 00       	call   62c <printf>

  fd = open(path, O_RDONLY);
 107:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
 10b:	be 00 00 00 00       	mov    $0x0,%esi
 110:	48 89 c7             	mov    %rax,%rdi
 113:	e8 9a 03 00 00       	call   4b2 <open>
 118:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < 20; i++)
 11b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 122:	eb 1d                	jmp    141 <main+0x141>
    read(fd, data, sizeof(data));
 124:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
 12b:	8b 45 f8             	mov    -0x8(%rbp),%eax
 12e:	ba 00 02 00 00       	mov    $0x200,%edx
 133:	48 89 ce             	mov    %rcx,%rsi
 136:	89 c7                	mov    %eax,%edi
 138:	e8 4d 03 00 00       	call   48a <read>
  for (i = 0; i < 20; i++)
 13d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 141:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
 145:	7e dd                	jle    124 <main+0x124>
  close(fd);
 147:	8b 45 f8             	mov    -0x8(%rbp),%eax
 14a:	89 c7                	mov    %eax,%edi
 14c:	e8 49 03 00 00       	call   49a <close>

  wait();
 151:	e8 24 03 00 00       	call   47a <wait>
  
  exit();
 156:	e8 17 03 00 00       	call   472 <exit>

000000000000015b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 15b:	55                   	push   %rbp
 15c:	48 89 e5             	mov    %rsp,%rbp
 15f:	48 83 ec 10          	sub    $0x10,%rsp
 163:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 167:	89 75 f4             	mov    %esi,-0xc(%rbp)
 16a:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 16d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 171:	8b 55 f0             	mov    -0x10(%rbp),%edx
 174:	8b 45 f4             	mov    -0xc(%rbp),%eax
 177:	48 89 ce             	mov    %rcx,%rsi
 17a:	48 89 f7             	mov    %rsi,%rdi
 17d:	89 d1                	mov    %edx,%ecx
 17f:	fc                   	cld
 180:	f3 aa                	rep stos %al,%es:(%rdi)
 182:	89 ca                	mov    %ecx,%edx
 184:	48 89 fe             	mov    %rdi,%rsi
 187:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 18b:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 18e:	90                   	nop
 18f:	c9                   	leave
 190:	c3                   	ret

0000000000000191 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 191:	f3 0f 1e fa          	endbr64
 195:	55                   	push   %rbp
 196:	48 89 e5             	mov    %rsp,%rbp
 199:	48 83 ec 20          	sub    $0x20,%rsp
 19d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 1a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 1ad:	90                   	nop
 1ae:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 1b2:	48 8d 42 01          	lea    0x1(%rdx),%rax
 1b6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 1ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1be:	48 8d 48 01          	lea    0x1(%rax),%rcx
 1c2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 1c6:	0f b6 12             	movzbl (%rdx),%edx
 1c9:	88 10                	mov    %dl,(%rax)
 1cb:	0f b6 00             	movzbl (%rax),%eax
 1ce:	84 c0                	test   %al,%al
 1d0:	75 dc                	jne    1ae <strcpy+0x1d>
    ;
  return os;
 1d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1d6:	c9                   	leave
 1d7:	c3                   	ret

00000000000001d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d8:	f3 0f 1e fa          	endbr64
 1dc:	55                   	push   %rbp
 1dd:	48 89 e5             	mov    %rsp,%rbp
 1e0:	48 83 ec 10          	sub    $0x10,%rsp
 1e4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1e8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 1ec:	eb 0a                	jmp    1f8 <strcmp+0x20>
    p++, q++;
 1ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1f3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 1f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1fc:	0f b6 00             	movzbl (%rax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	74 12                	je     215 <strcmp+0x3d>
 203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 207:	0f b6 10             	movzbl (%rax),%edx
 20a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 20e:	0f b6 00             	movzbl (%rax),%eax
 211:	38 c2                	cmp    %al,%dl
 213:	74 d9                	je     1ee <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 215:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 219:	0f b6 00             	movzbl (%rax),%eax
 21c:	0f b6 d0             	movzbl %al,%edx
 21f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 223:	0f b6 00             	movzbl (%rax),%eax
 226:	0f b6 c0             	movzbl %al,%eax
 229:	29 c2                	sub    %eax,%edx
 22b:	89 d0                	mov    %edx,%eax
}
 22d:	c9                   	leave
 22e:	c3                   	ret

000000000000022f <strlen>:

uint
strlen(char *s)
{
 22f:	f3 0f 1e fa          	endbr64
 233:	55                   	push   %rbp
 234:	48 89 e5             	mov    %rsp,%rbp
 237:	48 83 ec 18          	sub    $0x18,%rsp
 23b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 246:	eb 04                	jmp    24c <strlen+0x1d>
 248:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 24c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 24f:	48 63 d0             	movslq %eax,%rdx
 252:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 256:	48 01 d0             	add    %rdx,%rax
 259:	0f b6 00             	movzbl (%rax),%eax
 25c:	84 c0                	test   %al,%al
 25e:	75 e8                	jne    248 <strlen+0x19>
    ;
  return n;
 260:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 263:	c9                   	leave
 264:	c3                   	ret

0000000000000265 <memset>:

void*
memset(void *dst, int c, uint n)
{
 265:	f3 0f 1e fa          	endbr64
 269:	55                   	push   %rbp
 26a:	48 89 e5             	mov    %rsp,%rbp
 26d:	48 83 ec 10          	sub    $0x10,%rsp
 271:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 275:	89 75 f4             	mov    %esi,-0xc(%rbp)
 278:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 27b:	8b 55 f0             	mov    -0x10(%rbp),%edx
 27e:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 281:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 285:	89 ce                	mov    %ecx,%esi
 287:	48 89 c7             	mov    %rax,%rdi
 28a:	e8 cc fe ff ff       	call   15b <stosb>
  return dst;
 28f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 293:	c9                   	leave
 294:	c3                   	ret

0000000000000295 <strchr>:

char*
strchr(const char *s, char c)
{
 295:	f3 0f 1e fa          	endbr64
 299:	55                   	push   %rbp
 29a:	48 89 e5             	mov    %rsp,%rbp
 29d:	48 83 ec 10          	sub    $0x10,%rsp
 2a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2a5:	89 f0                	mov    %esi,%eax
 2a7:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 2aa:	eb 17                	jmp    2c3 <strchr+0x2e>
    if(*s == c)
 2ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2b0:	0f b6 00             	movzbl (%rax),%eax
 2b3:	38 45 f4             	cmp    %al,-0xc(%rbp)
 2b6:	75 06                	jne    2be <strchr+0x29>
      return (char*)s;
 2b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2bc:	eb 15                	jmp    2d3 <strchr+0x3e>
  for(; *s; s++)
 2be:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 2c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2c7:	0f b6 00             	movzbl (%rax),%eax
 2ca:	84 c0                	test   %al,%al
 2cc:	75 de                	jne    2ac <strchr+0x17>
  return 0;
 2ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2d3:	c9                   	leave
 2d4:	c3                   	ret

00000000000002d5 <gets>:

char*
gets(char *buf, int max)
{
 2d5:	f3 0f 1e fa          	endbr64
 2d9:	55                   	push   %rbp
 2da:	48 89 e5             	mov    %rsp,%rbp
 2dd:	48 83 ec 20          	sub    $0x20,%rsp
 2e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2e5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2ef:	eb 48                	jmp    339 <gets+0x64>
    cc = read(0, &c, 1);
 2f1:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 2f5:	ba 01 00 00 00       	mov    $0x1,%edx
 2fa:	48 89 c6             	mov    %rax,%rsi
 2fd:	bf 00 00 00 00       	mov    $0x0,%edi
 302:	e8 83 01 00 00       	call   48a <read>
 307:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 30a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 30e:	7e 36                	jle    346 <gets+0x71>
      break;
    buf[i++] = c;
 310:	8b 45 fc             	mov    -0x4(%rbp),%eax
 313:	8d 50 01             	lea    0x1(%rax),%edx
 316:	89 55 fc             	mov    %edx,-0x4(%rbp)
 319:	48 63 d0             	movslq %eax,%rdx
 31c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 320:	48 01 c2             	add    %rax,%rdx
 323:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 327:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 329:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 32d:	3c 0a                	cmp    $0xa,%al
 32f:	74 16                	je     347 <gets+0x72>
 331:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 335:	3c 0d                	cmp    $0xd,%al
 337:	74 0e                	je     347 <gets+0x72>
  for(i=0; i+1 < max; ){
 339:	8b 45 fc             	mov    -0x4(%rbp),%eax
 33c:	83 c0 01             	add    $0x1,%eax
 33f:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 342:	7f ad                	jg     2f1 <gets+0x1c>
 344:	eb 01                	jmp    347 <gets+0x72>
      break;
 346:	90                   	nop
      break;
  }
  buf[i] = '\0';
 347:	8b 45 fc             	mov    -0x4(%rbp),%eax
 34a:	48 63 d0             	movslq %eax,%rdx
 34d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 351:	48 01 d0             	add    %rdx,%rax
 354:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 357:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 35b:	c9                   	leave
 35c:	c3                   	ret

000000000000035d <stat>:

int
stat(char *n, struct stat *st)
{
 35d:	f3 0f 1e fa          	endbr64
 361:	55                   	push   %rbp
 362:	48 89 e5             	mov    %rsp,%rbp
 365:	48 83 ec 20          	sub    $0x20,%rsp
 369:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 36d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 375:	be 00 00 00 00       	mov    $0x0,%esi
 37a:	48 89 c7             	mov    %rax,%rdi
 37d:	e8 30 01 00 00       	call   4b2 <open>
 382:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 385:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 389:	79 07                	jns    392 <stat+0x35>
    return -1;
 38b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 390:	eb 21                	jmp    3b3 <stat+0x56>
  r = fstat(fd, st);
 392:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 396:	8b 45 fc             	mov    -0x4(%rbp),%eax
 399:	48 89 d6             	mov    %rdx,%rsi
 39c:	89 c7                	mov    %eax,%edi
 39e:	e8 27 01 00 00       	call   4ca <fstat>
 3a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 3a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3a9:	89 c7                	mov    %eax,%edi
 3ab:	e8 ea 00 00 00       	call   49a <close>
  return r;
 3b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 3b3:	c9                   	leave
 3b4:	c3                   	ret

00000000000003b5 <atoi>:

int
atoi(const char *s)
{
 3b5:	f3 0f 1e fa          	endbr64
 3b9:	55                   	push   %rbp
 3ba:	48 89 e5             	mov    %rsp,%rbp
 3bd:	48 83 ec 18          	sub    $0x18,%rsp
 3c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 3c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3cc:	eb 28                	jmp    3f6 <atoi+0x41>
    n = n*10 + *s++ - '0';
 3ce:	8b 55 fc             	mov    -0x4(%rbp),%edx
 3d1:	89 d0                	mov    %edx,%eax
 3d3:	c1 e0 02             	shl    $0x2,%eax
 3d6:	01 d0                	add    %edx,%eax
 3d8:	01 c0                	add    %eax,%eax
 3da:	89 c1                	mov    %eax,%ecx
 3dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3e0:	48 8d 50 01          	lea    0x1(%rax),%rdx
 3e4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 3e8:	0f b6 00             	movzbl (%rax),%eax
 3eb:	0f be c0             	movsbl %al,%eax
 3ee:	01 c8                	add    %ecx,%eax
 3f0:	83 e8 30             	sub    $0x30,%eax
 3f3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3fa:	0f b6 00             	movzbl (%rax),%eax
 3fd:	3c 2f                	cmp    $0x2f,%al
 3ff:	7e 0b                	jle    40c <atoi+0x57>
 401:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 405:	0f b6 00             	movzbl (%rax),%eax
 408:	3c 39                	cmp    $0x39,%al
 40a:	7e c2                	jle    3ce <atoi+0x19>
  return n;
 40c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 40f:	c9                   	leave
 410:	c3                   	ret

0000000000000411 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 411:	f3 0f 1e fa          	endbr64
 415:	55                   	push   %rbp
 416:	48 89 e5             	mov    %rsp,%rbp
 419:	48 83 ec 28          	sub    $0x28,%rsp
 41d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 421:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 425:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 428:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 42c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 430:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 434:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 438:	eb 1d                	jmp    457 <memmove+0x46>
    *dst++ = *src++;
 43a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 43e:	48 8d 42 01          	lea    0x1(%rdx),%rax
 442:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 446:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 44a:	48 8d 48 01          	lea    0x1(%rax),%rcx
 44e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 452:	0f b6 12             	movzbl (%rdx),%edx
 455:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 457:	8b 45 dc             	mov    -0x24(%rbp),%eax
 45a:	8d 50 ff             	lea    -0x1(%rax),%edx
 45d:	89 55 dc             	mov    %edx,-0x24(%rbp)
 460:	85 c0                	test   %eax,%eax
 462:	7f d6                	jg     43a <memmove+0x29>
  return vdst;
 464:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 468:	c9                   	leave
 469:	c3                   	ret

000000000000046a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 46a:	b8 01 00 00 00       	mov    $0x1,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret

0000000000000472 <exit>:
SYSCALL(exit)
 472:	b8 02 00 00 00       	mov    $0x2,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

000000000000047a <wait>:
SYSCALL(wait)
 47a:	b8 03 00 00 00       	mov    $0x3,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret

0000000000000482 <pipe>:
SYSCALL(pipe)
 482:	b8 04 00 00 00       	mov    $0x4,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret

000000000000048a <read>:
SYSCALL(read)
 48a:	b8 05 00 00 00       	mov    $0x5,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret

0000000000000492 <write>:
SYSCALL(write)
 492:	b8 10 00 00 00       	mov    $0x10,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret

000000000000049a <close>:
SYSCALL(close)
 49a:	b8 15 00 00 00       	mov    $0x15,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret

00000000000004a2 <kill>:
SYSCALL(kill)
 4a2:	b8 06 00 00 00       	mov    $0x6,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret

00000000000004aa <exec>:
SYSCALL(exec)
 4aa:	b8 07 00 00 00       	mov    $0x7,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret

00000000000004b2 <open>:
SYSCALL(open)
 4b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret

00000000000004ba <mknod>:
SYSCALL(mknod)
 4ba:	b8 11 00 00 00       	mov    $0x11,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret

00000000000004c2 <unlink>:
SYSCALL(unlink)
 4c2:	b8 12 00 00 00       	mov    $0x12,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret

00000000000004ca <fstat>:
SYSCALL(fstat)
 4ca:	b8 08 00 00 00       	mov    $0x8,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret

00000000000004d2 <link>:
SYSCALL(link)
 4d2:	b8 13 00 00 00       	mov    $0x13,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret

00000000000004da <mkdir>:
SYSCALL(mkdir)
 4da:	b8 14 00 00 00       	mov    $0x14,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret

00000000000004e2 <chdir>:
SYSCALL(chdir)
 4e2:	b8 09 00 00 00       	mov    $0x9,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret

00000000000004ea <dup>:
SYSCALL(dup)
 4ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret

00000000000004f2 <getpid>:
SYSCALL(getpid)
 4f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret

00000000000004fa <sbrk>:
SYSCALL(sbrk)
 4fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret

0000000000000502 <sleep>:
SYSCALL(sleep)
 502:	b8 0d 00 00 00       	mov    $0xd,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret

000000000000050a <uptime>:
SYSCALL(uptime)
 50a:	b8 0e 00 00 00       	mov    $0xe,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret

0000000000000512 <getpinfo>:
SYSCALL(getpinfo)
 512:	b8 18 00 00 00       	mov    $0x18,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret

000000000000051a <settickets>:
SYSCALL(settickets)
 51a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret

0000000000000522 <getfavnum>:
SYSCALL(getfavnum)
 522:	b8 1c 00 00 00       	mov    $0x1c,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret

000000000000052a <halt>:
SYSCALL(halt)
 52a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret

0000000000000532 <getcount>:
SYSCALL(getcount)
 532:	b8 1e 00 00 00       	mov    $0x1e,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret

000000000000053a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 53a:	f3 0f 1e fa          	endbr64
 53e:	55                   	push   %rbp
 53f:	48 89 e5             	mov    %rsp,%rbp
 542:	48 83 ec 10          	sub    $0x10,%rsp
 546:	89 7d fc             	mov    %edi,-0x4(%rbp)
 549:	89 f0                	mov    %esi,%eax
 54b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 54e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 552:	8b 45 fc             	mov    -0x4(%rbp),%eax
 555:	ba 01 00 00 00       	mov    $0x1,%edx
 55a:	48 89 ce             	mov    %rcx,%rsi
 55d:	89 c7                	mov    %eax,%edi
 55f:	e8 2e ff ff ff       	call   492 <write>
}
 564:	90                   	nop
 565:	c9                   	leave
 566:	c3                   	ret

0000000000000567 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 567:	f3 0f 1e fa          	endbr64
 56b:	55                   	push   %rbp
 56c:	48 89 e5             	mov    %rsp,%rbp
 56f:	48 83 ec 30          	sub    $0x30,%rsp
 573:	89 7d dc             	mov    %edi,-0x24(%rbp)
 576:	89 75 d8             	mov    %esi,-0x28(%rbp)
 579:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 57c:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 57f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 586:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 58a:	74 17                	je     5a3 <printint+0x3c>
 58c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 590:	79 11                	jns    5a3 <printint+0x3c>
    neg = 1;
 592:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 599:	8b 45 d8             	mov    -0x28(%rbp),%eax
 59c:	f7 d8                	neg    %eax
 59e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5a1:	eb 06                	jmp    5a9 <printint+0x42>
  } else {
    x = xx;
 5a3:	8b 45 d8             	mov    -0x28(%rbp),%eax
 5a6:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 5a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 5b0:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 5b3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5b6:	ba 00 00 00 00       	mov    $0x0,%edx
 5bb:	f7 f6                	div    %esi
 5bd:	89 d1                	mov    %edx,%ecx
 5bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5c2:	8d 50 01             	lea    0x1(%rax),%edx
 5c5:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5c8:	89 ca                	mov    %ecx,%edx
 5ca:	0f b6 92 b0 0e 00 00 	movzbl 0xeb0(%rdx),%edx
 5d1:	48 98                	cltq
 5d3:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 5d7:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 5da:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5dd:	ba 00 00 00 00       	mov    $0x0,%edx
 5e2:	f7 f7                	div    %edi
 5e4:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 5eb:	75 c3                	jne    5b0 <printint+0x49>
  if(neg)
 5ed:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5f1:	74 2b                	je     61e <printint+0xb7>
    buf[i++] = '-';
 5f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5f6:	8d 50 01             	lea    0x1(%rax),%edx
 5f9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5fc:	48 98                	cltq
 5fe:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 603:	eb 19                	jmp    61e <printint+0xb7>
    putc(fd, buf[i]);
 605:	8b 45 fc             	mov    -0x4(%rbp),%eax
 608:	48 98                	cltq
 60a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 60f:	0f be d0             	movsbl %al,%edx
 612:	8b 45 dc             	mov    -0x24(%rbp),%eax
 615:	89 d6                	mov    %edx,%esi
 617:	89 c7                	mov    %eax,%edi
 619:	e8 1c ff ff ff       	call   53a <putc>
  while(--i >= 0)
 61e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 622:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 626:	79 dd                	jns    605 <printint+0x9e>
}
 628:	90                   	nop
 629:	90                   	nop
 62a:	c9                   	leave
 62b:	c3                   	ret

000000000000062c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 62c:	f3 0f 1e fa          	endbr64
 630:	55                   	push   %rbp
 631:	48 89 e5             	mov    %rsp,%rbp
 634:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 63b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 641:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 648:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 64f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 656:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 65d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 664:	84 c0                	test   %al,%al
 666:	74 20                	je     688 <printf+0x5c>
 668:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 66c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 670:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 674:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 678:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 67c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 680:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 684:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 688:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 68f:	00 00 00 
 692:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 699:	00 00 00 
 69c:	48 8d 45 10          	lea    0x10(%rbp),%rax
 6a0:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 6a7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 6ae:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 6b5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 6bc:	00 00 00 
  for(i = 0; fmt[i]; i++){
 6bf:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 6c6:	00 00 00 
 6c9:	e9 a8 02 00 00       	jmp    976 <printf+0x34a>
    c = fmt[i] & 0xff;
 6ce:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 6d4:	48 63 d0             	movslq %eax,%rdx
 6d7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 6de:	48 01 d0             	add    %rdx,%rax
 6e1:	0f b6 00             	movzbl (%rax),%eax
 6e4:	0f be c0             	movsbl %al,%eax
 6e7:	25 ff 00 00 00       	and    $0xff,%eax
 6ec:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6f2:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6f9:	75 35                	jne    730 <printf+0x104>
      if(c == '%'){
 6fb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 702:	75 0f                	jne    713 <printf+0xe7>
        state = '%';
 704:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 70b:	00 00 00 
 70e:	e9 5c 02 00 00       	jmp    96f <printf+0x343>
      } else {
        putc(fd, c);
 713:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 719:	0f be d0             	movsbl %al,%edx
 71c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 722:	89 d6                	mov    %edx,%esi
 724:	89 c7                	mov    %eax,%edi
 726:	e8 0f fe ff ff       	call   53a <putc>
 72b:	e9 3f 02 00 00       	jmp    96f <printf+0x343>
      }
    } else if(state == '%'){
 730:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 737:	0f 85 32 02 00 00    	jne    96f <printf+0x343>
      if(c == 'd'){
 73d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 744:	75 5e                	jne    7a4 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 746:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74c:	83 f8 2f             	cmp    $0x2f,%eax
 74f:	77 23                	ja     774 <printf+0x148>
 751:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 758:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75e:	89 d2                	mov    %edx,%edx
 760:	48 01 d0             	add    %rdx,%rax
 763:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 769:	83 c2 08             	add    $0x8,%edx
 76c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 772:	eb 12                	jmp    786 <printf+0x15a>
 774:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 77f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 786:	8b 30                	mov    (%rax),%esi
 788:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 78e:	b9 01 00 00 00       	mov    $0x1,%ecx
 793:	ba 0a 00 00 00       	mov    $0xa,%edx
 798:	89 c7                	mov    %eax,%edi
 79a:	e8 c8 fd ff ff       	call   567 <printint>
 79f:	e9 c1 01 00 00       	jmp    965 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 7a4:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 7ab:	74 09                	je     7b6 <printf+0x18a>
 7ad:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 7b4:	75 5e                	jne    814 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 7b6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7bc:	83 f8 2f             	cmp    $0x2f,%eax
 7bf:	77 23                	ja     7e4 <printf+0x1b8>
 7c1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7c8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ce:	89 d2                	mov    %edx,%edx
 7d0:	48 01 d0             	add    %rdx,%rax
 7d3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d9:	83 c2 08             	add    $0x8,%edx
 7dc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7e2:	eb 12                	jmp    7f6 <printf+0x1ca>
 7e4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7eb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7ef:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7f6:	8b 30                	mov    (%rax),%esi
 7f8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7fe:	b9 00 00 00 00       	mov    $0x0,%ecx
 803:	ba 10 00 00 00       	mov    $0x10,%edx
 808:	89 c7                	mov    %eax,%edi
 80a:	e8 58 fd ff ff       	call   567 <printint>
 80f:	e9 51 01 00 00       	jmp    965 <printf+0x339>
      } else if(c == 's'){
 814:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 81b:	0f 85 98 00 00 00    	jne    8b9 <printf+0x28d>
        s = va_arg(ap, char*);
 821:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 827:	83 f8 2f             	cmp    $0x2f,%eax
 82a:	77 23                	ja     84f <printf+0x223>
 82c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 833:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 839:	89 d2                	mov    %edx,%edx
 83b:	48 01 d0             	add    %rdx,%rax
 83e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 844:	83 c2 08             	add    $0x8,%edx
 847:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 84d:	eb 12                	jmp    861 <printf+0x235>
 84f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 856:	48 8d 50 08          	lea    0x8(%rax),%rdx
 85a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 861:	48 8b 00             	mov    (%rax),%rax
 864:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 86b:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 872:	00 
 873:	75 31                	jne    8a6 <printf+0x27a>
          s = "(null)";
 875:	48 c7 85 48 ff ff ff 	movq   $0xc64,-0xb8(%rbp)
 87c:	64 0c 00 00 
        while(*s != 0){
 880:	eb 24                	jmp    8a6 <printf+0x27a>
          putc(fd, *s);
 882:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 889:	0f b6 00             	movzbl (%rax),%eax
 88c:	0f be d0             	movsbl %al,%edx
 88f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 895:	89 d6                	mov    %edx,%esi
 897:	89 c7                	mov    %eax,%edi
 899:	e8 9c fc ff ff       	call   53a <putc>
          s++;
 89e:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 8a5:	01 
        while(*s != 0){
 8a6:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 8ad:	0f b6 00             	movzbl (%rax),%eax
 8b0:	84 c0                	test   %al,%al
 8b2:	75 ce                	jne    882 <printf+0x256>
 8b4:	e9 ac 00 00 00       	jmp    965 <printf+0x339>
        }
      } else if(c == 'c'){
 8b9:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 8c0:	75 56                	jne    918 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 8c2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 8c8:	83 f8 2f             	cmp    $0x2f,%eax
 8cb:	77 23                	ja     8f0 <printf+0x2c4>
 8cd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8d4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8da:	89 d2                	mov    %edx,%edx
 8dc:	48 01 d0             	add    %rdx,%rax
 8df:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8e5:	83 c2 08             	add    $0x8,%edx
 8e8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8ee:	eb 12                	jmp    902 <printf+0x2d6>
 8f0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8f7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8fb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 902:	8b 00                	mov    (%rax),%eax
 904:	0f be d0             	movsbl %al,%edx
 907:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 90d:	89 d6                	mov    %edx,%esi
 90f:	89 c7                	mov    %eax,%edi
 911:	e8 24 fc ff ff       	call   53a <putc>
 916:	eb 4d                	jmp    965 <printf+0x339>
      } else if(c == '%'){
 918:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 91f:	75 1a                	jne    93b <printf+0x30f>
        putc(fd, c);
 921:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 927:	0f be d0             	movsbl %al,%edx
 92a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 930:	89 d6                	mov    %edx,%esi
 932:	89 c7                	mov    %eax,%edi
 934:	e8 01 fc ff ff       	call   53a <putc>
 939:	eb 2a                	jmp    965 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 93b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 941:	be 25 00 00 00       	mov    $0x25,%esi
 946:	89 c7                	mov    %eax,%edi
 948:	e8 ed fb ff ff       	call   53a <putc>
        putc(fd, c);
 94d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 953:	0f be d0             	movsbl %al,%edx
 956:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 95c:	89 d6                	mov    %edx,%esi
 95e:	89 c7                	mov    %eax,%edi
 960:	e8 d5 fb ff ff       	call   53a <putc>
      }
      state = 0;
 965:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 96c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 96f:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 976:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 97c:	48 63 d0             	movslq %eax,%rdx
 97f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 986:	48 01 d0             	add    %rdx,%rax
 989:	0f b6 00             	movzbl (%rax),%eax
 98c:	84 c0                	test   %al,%al
 98e:	0f 85 3a fd ff ff    	jne    6ce <printf+0xa2>
    }
  }
}
 994:	90                   	nop
 995:	90                   	nop
 996:	c9                   	leave
 997:	c3                   	ret

0000000000000998 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 998:	f3 0f 1e fa          	endbr64
 99c:	55                   	push   %rbp
 99d:	48 89 e5             	mov    %rsp,%rbp
 9a0:	48 83 ec 18          	sub    $0x18,%rsp
 9a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 9ac:	48 83 e8 10          	sub    $0x10,%rax
 9b0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b4:	48 8b 05 25 05 00 00 	mov    0x525(%rip),%rax        # ee0 <freep>
 9bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9bf:	eb 2f                	jmp    9f0 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c5:	48 8b 00             	mov    (%rax),%rax
 9c8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9cc:	72 17                	jb     9e5 <free+0x4d>
 9ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9d6:	72 2f                	jb     a07 <free+0x6f>
 9d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dc:	48 8b 00             	mov    (%rax),%rax
 9df:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9e3:	72 22                	jb     a07 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e9:	48 8b 00             	mov    (%rax),%rax
 9ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9f8:	73 c7                	jae    9c1 <free+0x29>
 9fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fe:	48 8b 00             	mov    (%rax),%rax
 a01:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a05:	73 ba                	jae    9c1 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0b:	8b 40 08             	mov    0x8(%rax),%eax
 a0e:	89 c0                	mov    %eax,%eax
 a10:	48 c1 e0 04          	shl    $0x4,%rax
 a14:	48 89 c2             	mov    %rax,%rdx
 a17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1b:	48 01 c2             	add    %rax,%rdx
 a1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a22:	48 8b 00             	mov    (%rax),%rax
 a25:	48 39 c2             	cmp    %rax,%rdx
 a28:	75 2d                	jne    a57 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 a2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2e:	8b 50 08             	mov    0x8(%rax),%edx
 a31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a35:	48 8b 00             	mov    (%rax),%rax
 a38:	8b 40 08             	mov    0x8(%rax),%eax
 a3b:	01 c2                	add    %eax,%edx
 a3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a41:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a48:	48 8b 00             	mov    (%rax),%rax
 a4b:	48 8b 10             	mov    (%rax),%rdx
 a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a52:	48 89 10             	mov    %rdx,(%rax)
 a55:	eb 0e                	jmp    a65 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 a57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5b:	48 8b 10             	mov    (%rax),%rdx
 a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a62:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a69:	8b 40 08             	mov    0x8(%rax),%eax
 a6c:	89 c0                	mov    %eax,%eax
 a6e:	48 c1 e0 04          	shl    $0x4,%rax
 a72:	48 89 c2             	mov    %rax,%rdx
 a75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a79:	48 01 d0             	add    %rdx,%rax
 a7c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a80:	75 27                	jne    aa9 <free+0x111>
    p->s.size += bp->s.size;
 a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a86:	8b 50 08             	mov    0x8(%rax),%edx
 a89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8d:	8b 40 08             	mov    0x8(%rax),%eax
 a90:	01 c2                	add    %eax,%edx
 a92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a96:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9d:	48 8b 10             	mov    (%rax),%rdx
 aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa4:	48 89 10             	mov    %rdx,(%rax)
 aa7:	eb 0b                	jmp    ab4 <free+0x11c>
  } else
    p->s.ptr = bp;
 aa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 ab1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	48 89 05 21 04 00 00 	mov    %rax,0x421(%rip)        # ee0 <freep>
}
 abf:	90                   	nop
 ac0:	c9                   	leave
 ac1:	c3                   	ret

0000000000000ac2 <morecore>:

static Header*
morecore(uint nu)
{
 ac2:	f3 0f 1e fa          	endbr64
 ac6:	55                   	push   %rbp
 ac7:	48 89 e5             	mov    %rsp,%rbp
 aca:	48 83 ec 20          	sub    $0x20,%rsp
 ace:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 ad1:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 ad8:	77 07                	ja     ae1 <morecore+0x1f>
    nu = 4096;
 ada:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 ae1:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae4:	c1 e0 04             	shl    $0x4,%eax
 ae7:	89 c7                	mov    %eax,%edi
 ae9:	e8 0c fa ff ff       	call   4fa <sbrk>
 aee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 af2:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 af7:	75 07                	jne    b00 <morecore+0x3e>
    return 0;
 af9:	b8 00 00 00 00       	mov    $0x0,%eax
 afe:	eb 29                	jmp    b29 <morecore+0x67>
  hp = (Header*)p;
 b00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b04:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 b08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b0c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b0f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b16:	48 83 c0 10          	add    $0x10,%rax
 b1a:	48 89 c7             	mov    %rax,%rdi
 b1d:	e8 76 fe ff ff       	call   998 <free>
  return freep;
 b22:	48 8b 05 b7 03 00 00 	mov    0x3b7(%rip),%rax        # ee0 <freep>
}
 b29:	c9                   	leave
 b2a:	c3                   	ret

0000000000000b2b <malloc>:

void*
malloc(uint nbytes)
{
 b2b:	f3 0f 1e fa          	endbr64
 b2f:	55                   	push   %rbp
 b30:	48 89 e5             	mov    %rsp,%rbp
 b33:	48 83 ec 30          	sub    $0x30,%rsp
 b37:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b3a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 b3d:	48 83 c0 0f          	add    $0xf,%rax
 b41:	48 c1 e8 04          	shr    $0x4,%rax
 b45:	83 c0 01             	add    $0x1,%eax
 b48:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b4b:	48 8b 05 8e 03 00 00 	mov    0x38e(%rip),%rax        # ee0 <freep>
 b52:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b56:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b5b:	75 2b                	jne    b88 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 b5d:	48 c7 45 f0 d0 0e 00 	movq   $0xed0,-0x10(%rbp)
 b64:	00 
 b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b69:	48 89 05 70 03 00 00 	mov    %rax,0x370(%rip)        # ee0 <freep>
 b70:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # ee0 <freep>
 b77:	48 89 05 52 03 00 00 	mov    %rax,0x352(%rip)        # ed0 <base>
    base.s.size = 0;
 b7e:	c7 05 50 03 00 00 00 	movl   $0x0,0x350(%rip)        # ed8 <base+0x8>
 b85:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b8c:	48 8b 00             	mov    (%rax),%rax
 b8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b97:	8b 40 08             	mov    0x8(%rax),%eax
 b9a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b9d:	72 5f                	jb     bfe <malloc+0xd3>
      if(p->s.size == nunits)
 b9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba3:	8b 40 08             	mov    0x8(%rax),%eax
 ba6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ba9:	75 10                	jne    bbb <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 baf:	48 8b 10             	mov    (%rax),%rdx
 bb2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bb6:	48 89 10             	mov    %rdx,(%rax)
 bb9:	eb 2e                	jmp    be9 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 bbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbf:	8b 40 08             	mov    0x8(%rax),%eax
 bc2:	2b 45 ec             	sub    -0x14(%rbp),%eax
 bc5:	89 c2                	mov    %eax,%edx
 bc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcb:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 bce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd2:	8b 40 08             	mov    0x8(%rax),%eax
 bd5:	89 c0                	mov    %eax,%eax
 bd7:	48 c1 e0 04          	shl    $0x4,%rax
 bdb:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 bdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be3:	8b 55 ec             	mov    -0x14(%rbp),%edx
 be6:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 be9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bed:	48 89 05 ec 02 00 00 	mov    %rax,0x2ec(%rip)        # ee0 <freep>
      return (void*)(p + 1);
 bf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf8:	48 83 c0 10          	add    $0x10,%rax
 bfc:	eb 41                	jmp    c3f <malloc+0x114>
    }
    if(p == freep)
 bfe:	48 8b 05 db 02 00 00 	mov    0x2db(%rip),%rax        # ee0 <freep>
 c05:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c09:	75 1c                	jne    c27 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 c0b:	8b 45 ec             	mov    -0x14(%rbp),%eax
 c0e:	89 c7                	mov    %eax,%edi
 c10:	e8 ad fe ff ff       	call   ac2 <morecore>
 c15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c19:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c1e:	75 07                	jne    c27 <malloc+0xfc>
        return 0;
 c20:	b8 00 00 00 00       	mov    $0x0,%eax
 c25:	eb 18                	jmp    c3f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c33:	48 8b 00             	mov    (%rax),%rax
 c36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c3a:	e9 54 ff ff ff       	jmp    b93 <malloc+0x68>
  }
}
 c3f:	c9                   	leave
 c40:	c3                   	ret
