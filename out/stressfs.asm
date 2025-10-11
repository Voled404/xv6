
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
  30:	48 c7 c6 31 0c 00 00 	mov    $0xc31,%rsi
  37:	bf 01 00 00 00       	mov    $0x1,%edi
  3c:	b8 00 00 00 00       	mov    $0x0,%eax
  41:	e8 d6 05 00 00       	call   61c <printf>
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
  83:	48 c7 c6 44 0c 00 00 	mov    $0xc44,%rsi
  8a:	bf 01 00 00 00       	mov    $0x1,%edi
  8f:	b8 00 00 00 00       	mov    $0x0,%eax
  94:	e8 83 05 00 00       	call   61c <printf>

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
  f1:	48 c7 c6 4e 0c 00 00 	mov    $0xc4e,%rsi
  f8:	bf 01 00 00 00       	mov    $0x1,%edi
  fd:	b8 00 00 00 00       	mov    $0x0,%eax
 102:	e8 15 05 00 00       	call   61c <printf>

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

000000000000052a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 52a:	f3 0f 1e fa          	endbr64
 52e:	55                   	push   %rbp
 52f:	48 89 e5             	mov    %rsp,%rbp
 532:	48 83 ec 10          	sub    $0x10,%rsp
 536:	89 7d fc             	mov    %edi,-0x4(%rbp)
 539:	89 f0                	mov    %esi,%eax
 53b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 53e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 542:	8b 45 fc             	mov    -0x4(%rbp),%eax
 545:	ba 01 00 00 00       	mov    $0x1,%edx
 54a:	48 89 ce             	mov    %rcx,%rsi
 54d:	89 c7                	mov    %eax,%edi
 54f:	e8 3e ff ff ff       	call   492 <write>
}
 554:	90                   	nop
 555:	c9                   	leave
 556:	c3                   	ret

0000000000000557 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 557:	f3 0f 1e fa          	endbr64
 55b:	55                   	push   %rbp
 55c:	48 89 e5             	mov    %rsp,%rbp
 55f:	48 83 ec 30          	sub    $0x30,%rsp
 563:	89 7d dc             	mov    %edi,-0x24(%rbp)
 566:	89 75 d8             	mov    %esi,-0x28(%rbp)
 569:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 56c:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 56f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 576:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 57a:	74 17                	je     593 <printint+0x3c>
 57c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 580:	79 11                	jns    593 <printint+0x3c>
    neg = 1;
 582:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 589:	8b 45 d8             	mov    -0x28(%rbp),%eax
 58c:	f7 d8                	neg    %eax
 58e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 591:	eb 06                	jmp    599 <printint+0x42>
  } else {
    x = xx;
 593:	8b 45 d8             	mov    -0x28(%rbp),%eax
 596:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 599:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 5a0:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 5a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5a6:	ba 00 00 00 00       	mov    $0x0,%edx
 5ab:	f7 f6                	div    %esi
 5ad:	89 d1                	mov    %edx,%ecx
 5af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b2:	8d 50 01             	lea    0x1(%rax),%edx
 5b5:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5b8:	89 ca                	mov    %ecx,%edx
 5ba:	0f b6 92 a0 0e 00 00 	movzbl 0xea0(%rdx),%edx
 5c1:	48 98                	cltq
 5c3:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 5c7:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 5ca:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5cd:	ba 00 00 00 00       	mov    $0x0,%edx
 5d2:	f7 f7                	div    %edi
 5d4:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 5db:	75 c3                	jne    5a0 <printint+0x49>
  if(neg)
 5dd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5e1:	74 2b                	je     60e <printint+0xb7>
    buf[i++] = '-';
 5e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5e6:	8d 50 01             	lea    0x1(%rax),%edx
 5e9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5ec:	48 98                	cltq
 5ee:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5f3:	eb 19                	jmp    60e <printint+0xb7>
    putc(fd, buf[i]);
 5f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5f8:	48 98                	cltq
 5fa:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5ff:	0f be d0             	movsbl %al,%edx
 602:	8b 45 dc             	mov    -0x24(%rbp),%eax
 605:	89 d6                	mov    %edx,%esi
 607:	89 c7                	mov    %eax,%edi
 609:	e8 1c ff ff ff       	call   52a <putc>
  while(--i >= 0)
 60e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 612:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 616:	79 dd                	jns    5f5 <printint+0x9e>
}
 618:	90                   	nop
 619:	90                   	nop
 61a:	c9                   	leave
 61b:	c3                   	ret

000000000000061c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 61c:	f3 0f 1e fa          	endbr64
 620:	55                   	push   %rbp
 621:	48 89 e5             	mov    %rsp,%rbp
 624:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 62b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 631:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 638:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 63f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 646:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 64d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 654:	84 c0                	test   %al,%al
 656:	74 20                	je     678 <printf+0x5c>
 658:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 65c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 660:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 664:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 668:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 66c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 670:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 674:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 678:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 67f:	00 00 00 
 682:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 689:	00 00 00 
 68c:	48 8d 45 10          	lea    0x10(%rbp),%rax
 690:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 697:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 69e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 6a5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 6ac:	00 00 00 
  for(i = 0; fmt[i]; i++){
 6af:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 6b6:	00 00 00 
 6b9:	e9 a8 02 00 00       	jmp    966 <printf+0x34a>
    c = fmt[i] & 0xff;
 6be:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 6c4:	48 63 d0             	movslq %eax,%rdx
 6c7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 6ce:	48 01 d0             	add    %rdx,%rax
 6d1:	0f b6 00             	movzbl (%rax),%eax
 6d4:	0f be c0             	movsbl %al,%eax
 6d7:	25 ff 00 00 00       	and    $0xff,%eax
 6dc:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6e2:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6e9:	75 35                	jne    720 <printf+0x104>
      if(c == '%'){
 6eb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6f2:	75 0f                	jne    703 <printf+0xe7>
        state = '%';
 6f4:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6fb:	00 00 00 
 6fe:	e9 5c 02 00 00       	jmp    95f <printf+0x343>
      } else {
        putc(fd, c);
 703:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 709:	0f be d0             	movsbl %al,%edx
 70c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 712:	89 d6                	mov    %edx,%esi
 714:	89 c7                	mov    %eax,%edi
 716:	e8 0f fe ff ff       	call   52a <putc>
 71b:	e9 3f 02 00 00       	jmp    95f <printf+0x343>
      }
    } else if(state == '%'){
 720:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 727:	0f 85 32 02 00 00    	jne    95f <printf+0x343>
      if(c == 'd'){
 72d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 734:	75 5e                	jne    794 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 736:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 73c:	83 f8 2f             	cmp    $0x2f,%eax
 73f:	77 23                	ja     764 <printf+0x148>
 741:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 748:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 74e:	89 d2                	mov    %edx,%edx
 750:	48 01 d0             	add    %rdx,%rax
 753:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 759:	83 c2 08             	add    $0x8,%edx
 75c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 762:	eb 12                	jmp    776 <printf+0x15a>
 764:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 76b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 76f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 776:	8b 30                	mov    (%rax),%esi
 778:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77e:	b9 01 00 00 00       	mov    $0x1,%ecx
 783:	ba 0a 00 00 00       	mov    $0xa,%edx
 788:	89 c7                	mov    %eax,%edi
 78a:	e8 c8 fd ff ff       	call   557 <printint>
 78f:	e9 c1 01 00 00       	jmp    955 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 794:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 79b:	74 09                	je     7a6 <printf+0x18a>
 79d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 7a4:	75 5e                	jne    804 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 7a6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ac:	83 f8 2f             	cmp    $0x2f,%eax
 7af:	77 23                	ja     7d4 <printf+0x1b8>
 7b1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7be:	89 d2                	mov    %edx,%edx
 7c0:	48 01 d0             	add    %rdx,%rax
 7c3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7c9:	83 c2 08             	add    $0x8,%edx
 7cc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7d2:	eb 12                	jmp    7e6 <printf+0x1ca>
 7d4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7db:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7df:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7e6:	8b 30                	mov    (%rax),%esi
 7e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ee:	b9 00 00 00 00       	mov    $0x0,%ecx
 7f3:	ba 10 00 00 00       	mov    $0x10,%edx
 7f8:	89 c7                	mov    %eax,%edi
 7fa:	e8 58 fd ff ff       	call   557 <printint>
 7ff:	e9 51 01 00 00       	jmp    955 <printf+0x339>
      } else if(c == 's'){
 804:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 80b:	0f 85 98 00 00 00    	jne    8a9 <printf+0x28d>
        s = va_arg(ap, char*);
 811:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 817:	83 f8 2f             	cmp    $0x2f,%eax
 81a:	77 23                	ja     83f <printf+0x223>
 81c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 823:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 829:	89 d2                	mov    %edx,%edx
 82b:	48 01 d0             	add    %rdx,%rax
 82e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 834:	83 c2 08             	add    $0x8,%edx
 837:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 83d:	eb 12                	jmp    851 <printf+0x235>
 83f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 846:	48 8d 50 08          	lea    0x8(%rax),%rdx
 84a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 851:	48 8b 00             	mov    (%rax),%rax
 854:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 85b:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 862:	00 
 863:	75 31                	jne    896 <printf+0x27a>
          s = "(null)";
 865:	48 c7 85 48 ff ff ff 	movq   $0xc54,-0xb8(%rbp)
 86c:	54 0c 00 00 
        while(*s != 0){
 870:	eb 24                	jmp    896 <printf+0x27a>
          putc(fd, *s);
 872:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 879:	0f b6 00             	movzbl (%rax),%eax
 87c:	0f be d0             	movsbl %al,%edx
 87f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 885:	89 d6                	mov    %edx,%esi
 887:	89 c7                	mov    %eax,%edi
 889:	e8 9c fc ff ff       	call   52a <putc>
          s++;
 88e:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 895:	01 
        while(*s != 0){
 896:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 89d:	0f b6 00             	movzbl (%rax),%eax
 8a0:	84 c0                	test   %al,%al
 8a2:	75 ce                	jne    872 <printf+0x256>
 8a4:	e9 ac 00 00 00       	jmp    955 <printf+0x339>
        }
      } else if(c == 'c'){
 8a9:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 8b0:	75 56                	jne    908 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 8b2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 8b8:	83 f8 2f             	cmp    $0x2f,%eax
 8bb:	77 23                	ja     8e0 <printf+0x2c4>
 8bd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8c4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8ca:	89 d2                	mov    %edx,%edx
 8cc:	48 01 d0             	add    %rdx,%rax
 8cf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8d5:	83 c2 08             	add    $0x8,%edx
 8d8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8de:	eb 12                	jmp    8f2 <printf+0x2d6>
 8e0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8e7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8eb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8f2:	8b 00                	mov    (%rax),%eax
 8f4:	0f be d0             	movsbl %al,%edx
 8f7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8fd:	89 d6                	mov    %edx,%esi
 8ff:	89 c7                	mov    %eax,%edi
 901:	e8 24 fc ff ff       	call   52a <putc>
 906:	eb 4d                	jmp    955 <printf+0x339>
      } else if(c == '%'){
 908:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 90f:	75 1a                	jne    92b <printf+0x30f>
        putc(fd, c);
 911:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 917:	0f be d0             	movsbl %al,%edx
 91a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 920:	89 d6                	mov    %edx,%esi
 922:	89 c7                	mov    %eax,%edi
 924:	e8 01 fc ff ff       	call   52a <putc>
 929:	eb 2a                	jmp    955 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 92b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 931:	be 25 00 00 00       	mov    $0x25,%esi
 936:	89 c7                	mov    %eax,%edi
 938:	e8 ed fb ff ff       	call   52a <putc>
        putc(fd, c);
 93d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 943:	0f be d0             	movsbl %al,%edx
 946:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 94c:	89 d6                	mov    %edx,%esi
 94e:	89 c7                	mov    %eax,%edi
 950:	e8 d5 fb ff ff       	call   52a <putc>
      }
      state = 0;
 955:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 95c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 95f:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 966:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 96c:	48 63 d0             	movslq %eax,%rdx
 96f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 976:	48 01 d0             	add    %rdx,%rax
 979:	0f b6 00             	movzbl (%rax),%eax
 97c:	84 c0                	test   %al,%al
 97e:	0f 85 3a fd ff ff    	jne    6be <printf+0xa2>
    }
  }
}
 984:	90                   	nop
 985:	90                   	nop
 986:	c9                   	leave
 987:	c3                   	ret

0000000000000988 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 988:	f3 0f 1e fa          	endbr64
 98c:	55                   	push   %rbp
 98d:	48 89 e5             	mov    %rsp,%rbp
 990:	48 83 ec 18          	sub    $0x18,%rsp
 994:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 998:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 99c:	48 83 e8 10          	sub    $0x10,%rax
 9a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a4:	48 8b 05 25 05 00 00 	mov    0x525(%rip),%rax        # ed0 <freep>
 9ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9af:	eb 2f                	jmp    9e0 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b5:	48 8b 00             	mov    (%rax),%rax
 9b8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9bc:	72 17                	jb     9d5 <free+0x4d>
 9be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9c6:	72 2f                	jb     9f7 <free+0x6f>
 9c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cc:	48 8b 00             	mov    (%rax),%rax
 9cf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9d3:	72 22                	jb     9f7 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d9:	48 8b 00             	mov    (%rax),%rax
 9dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9e8:	73 c7                	jae    9b1 <free+0x29>
 9ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ee:	48 8b 00             	mov    (%rax),%rax
 9f1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9f5:	73 ba                	jae    9b1 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fb:	8b 40 08             	mov    0x8(%rax),%eax
 9fe:	89 c0                	mov    %eax,%eax
 a00:	48 c1 e0 04          	shl    $0x4,%rax
 a04:	48 89 c2             	mov    %rax,%rdx
 a07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0b:	48 01 c2             	add    %rax,%rdx
 a0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a12:	48 8b 00             	mov    (%rax),%rax
 a15:	48 39 c2             	cmp    %rax,%rdx
 a18:	75 2d                	jne    a47 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 a1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1e:	8b 50 08             	mov    0x8(%rax),%edx
 a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a25:	48 8b 00             	mov    (%rax),%rax
 a28:	8b 40 08             	mov    0x8(%rax),%eax
 a2b:	01 c2                	add    %eax,%edx
 a2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a31:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a38:	48 8b 00             	mov    (%rax),%rax
 a3b:	48 8b 10             	mov    (%rax),%rdx
 a3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a42:	48 89 10             	mov    %rdx,(%rax)
 a45:	eb 0e                	jmp    a55 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 a47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4b:	48 8b 10             	mov    (%rax),%rdx
 a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a52:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a59:	8b 40 08             	mov    0x8(%rax),%eax
 a5c:	89 c0                	mov    %eax,%eax
 a5e:	48 c1 e0 04          	shl    $0x4,%rax
 a62:	48 89 c2             	mov    %rax,%rdx
 a65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a69:	48 01 d0             	add    %rdx,%rax
 a6c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a70:	75 27                	jne    a99 <free+0x111>
    p->s.size += bp->s.size;
 a72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a76:	8b 50 08             	mov    0x8(%rax),%edx
 a79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a7d:	8b 40 08             	mov    0x8(%rax),%eax
 a80:	01 c2                	add    %eax,%edx
 a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a86:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8d:	48 8b 10             	mov    (%rax),%rdx
 a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a94:	48 89 10             	mov    %rdx,(%rax)
 a97:	eb 0b                	jmp    aa4 <free+0x11c>
  } else
    p->s.ptr = bp;
 a99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 aa1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 aa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa8:	48 89 05 21 04 00 00 	mov    %rax,0x421(%rip)        # ed0 <freep>
}
 aaf:	90                   	nop
 ab0:	c9                   	leave
 ab1:	c3                   	ret

0000000000000ab2 <morecore>:

static Header*
morecore(uint nu)
{
 ab2:	f3 0f 1e fa          	endbr64
 ab6:	55                   	push   %rbp
 ab7:	48 89 e5             	mov    %rsp,%rbp
 aba:	48 83 ec 20          	sub    $0x20,%rsp
 abe:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 ac1:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 ac8:	77 07                	ja     ad1 <morecore+0x1f>
    nu = 4096;
 aca:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 ad1:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ad4:	c1 e0 04             	shl    $0x4,%eax
 ad7:	89 c7                	mov    %eax,%edi
 ad9:	e8 1c fa ff ff       	call   4fa <sbrk>
 ade:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 ae2:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 ae7:	75 07                	jne    af0 <morecore+0x3e>
    return 0;
 ae9:	b8 00 00 00 00       	mov    $0x0,%eax
 aee:	eb 29                	jmp    b19 <morecore+0x67>
  hp = (Header*)p;
 af0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 af8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 afc:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aff:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b06:	48 83 c0 10          	add    $0x10,%rax
 b0a:	48 89 c7             	mov    %rax,%rdi
 b0d:	e8 76 fe ff ff       	call   988 <free>
  return freep;
 b12:	48 8b 05 b7 03 00 00 	mov    0x3b7(%rip),%rax        # ed0 <freep>
}
 b19:	c9                   	leave
 b1a:	c3                   	ret

0000000000000b1b <malloc>:

void*
malloc(uint nbytes)
{
 b1b:	f3 0f 1e fa          	endbr64
 b1f:	55                   	push   %rbp
 b20:	48 89 e5             	mov    %rsp,%rbp
 b23:	48 83 ec 30          	sub    $0x30,%rsp
 b27:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b2a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 b2d:	48 83 c0 0f          	add    $0xf,%rax
 b31:	48 c1 e8 04          	shr    $0x4,%rax
 b35:	83 c0 01             	add    $0x1,%eax
 b38:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b3b:	48 8b 05 8e 03 00 00 	mov    0x38e(%rip),%rax        # ed0 <freep>
 b42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b46:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b4b:	75 2b                	jne    b78 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 b4d:	48 c7 45 f0 c0 0e 00 	movq   $0xec0,-0x10(%rbp)
 b54:	00 
 b55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b59:	48 89 05 70 03 00 00 	mov    %rax,0x370(%rip)        # ed0 <freep>
 b60:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # ed0 <freep>
 b67:	48 89 05 52 03 00 00 	mov    %rax,0x352(%rip)        # ec0 <base>
    base.s.size = 0;
 b6e:	c7 05 50 03 00 00 00 	movl   $0x0,0x350(%rip)        # ec8 <base+0x8>
 b75:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b7c:	48 8b 00             	mov    (%rax),%rax
 b7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b87:	8b 40 08             	mov    0x8(%rax),%eax
 b8a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b8d:	72 5f                	jb     bee <malloc+0xd3>
      if(p->s.size == nunits)
 b8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b93:	8b 40 08             	mov    0x8(%rax),%eax
 b96:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b99:	75 10                	jne    bab <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b9f:	48 8b 10             	mov    (%rax),%rdx
 ba2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ba6:	48 89 10             	mov    %rdx,(%rax)
 ba9:	eb 2e                	jmp    bd9 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 baf:	8b 40 08             	mov    0x8(%rax),%eax
 bb2:	2b 45 ec             	sub    -0x14(%rbp),%eax
 bb5:	89 c2                	mov    %eax,%edx
 bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbb:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 bbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc2:	8b 40 08             	mov    0x8(%rax),%eax
 bc5:	89 c0                	mov    %eax,%eax
 bc7:	48 c1 e0 04          	shl    $0x4,%rax
 bcb:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd3:	8b 55 ec             	mov    -0x14(%rbp),%edx
 bd6:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 bd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bdd:	48 89 05 ec 02 00 00 	mov    %rax,0x2ec(%rip)        # ed0 <freep>
      return (void*)(p + 1);
 be4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be8:	48 83 c0 10          	add    $0x10,%rax
 bec:	eb 41                	jmp    c2f <malloc+0x114>
    }
    if(p == freep)
 bee:	48 8b 05 db 02 00 00 	mov    0x2db(%rip),%rax        # ed0 <freep>
 bf5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bf9:	75 1c                	jne    c17 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 bfb:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bfe:	89 c7                	mov    %eax,%edi
 c00:	e8 ad fe ff ff       	call   ab2 <morecore>
 c05:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c09:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c0e:	75 07                	jne    c17 <malloc+0xfc>
        return 0;
 c10:	b8 00 00 00 00       	mov    $0x0,%eax
 c15:	eb 18                	jmp    c2f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 c1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c23:	48 8b 00             	mov    (%rax),%rax
 c26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c2a:	e9 54 ff ff ff       	jmp    b83 <malloc+0x68>
  }
}
 c2f:	c9                   	leave
 c30:	c3                   	ret
