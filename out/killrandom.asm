
fs/killrandom:     file format elf64-x86-64


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
  printf(2, "Killing random process...\n");
  13:	48 c7 c6 48 0b 00 00 	mov    $0xb48,%rsi
  1a:	bf 02 00 00 00       	mov    $0x2,%edi
  1f:	b8 00 00 00 00       	mov    $0x0,%eax
  24:	e8 06 05 00 00       	call   52f <printf>
  int randomPid = killrandom();
  29:	b8 00 00 00 00       	mov    $0x0,%eax
  2e:	e8 02 04 00 00       	call   435 <killrandom>
  33:	89 45 fc             	mov    %eax,-0x4(%rbp)
  printf(2, "Killed random process with id %d\n", randomPid);
  36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  39:	89 c2                	mov    %eax,%edx
  3b:	48 c7 c6 68 0b 00 00 	mov    $0xb68,%rsi
  42:	bf 02 00 00 00       	mov    $0x2,%edi
  47:	b8 00 00 00 00       	mov    $0x0,%eax
  4c:	e8 de 04 00 00       	call   52f <printf>
  exit();
  51:	e8 17 03 00 00       	call   36d <exit>

0000000000000056 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  56:	55                   	push   %rbp
  57:	48 89 e5             	mov    %rsp,%rbp
  5a:	48 83 ec 10          	sub    $0x10,%rsp
  5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  62:	89 75 f4             	mov    %esi,-0xc(%rbp)
  65:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  68:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  6c:	8b 55 f0             	mov    -0x10(%rbp),%edx
  6f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  72:	48 89 ce             	mov    %rcx,%rsi
  75:	48 89 f7             	mov    %rsi,%rdi
  78:	89 d1                	mov    %edx,%ecx
  7a:	fc                   	cld
  7b:	f3 aa                	rep stos %al,%es:(%rdi)
  7d:	89 ca                	mov    %ecx,%edx
  7f:	48 89 fe             	mov    %rdi,%rsi
  82:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  86:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	90                   	nop
  8a:	c9                   	leave
  8b:	c3                   	ret

000000000000008c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8c:	f3 0f 1e fa          	endbr64
  90:	55                   	push   %rbp
  91:	48 89 e5             	mov    %rsp,%rbp
  94:	48 83 ec 20          	sub    $0x20,%rsp
  98:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  9c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  a8:	90                   	nop
  a9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  ad:	48 8d 42 01          	lea    0x1(%rdx),%rax
  b1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  b9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  bd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  c1:	0f b6 12             	movzbl (%rdx),%edx
  c4:	88 10                	mov    %dl,(%rax)
  c6:	0f b6 00             	movzbl (%rax),%eax
  c9:	84 c0                	test   %al,%al
  cb:	75 dc                	jne    a9 <strcpy+0x1d>
    ;
  return os;
  cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  d1:	c9                   	leave
  d2:	c3                   	ret

00000000000000d3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d3:	f3 0f 1e fa          	endbr64
  d7:	55                   	push   %rbp
  d8:	48 89 e5             	mov    %rsp,%rbp
  db:	48 83 ec 10          	sub    $0x10,%rsp
  df:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  e3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  e7:	eb 0a                	jmp    f3 <strcmp+0x20>
    p++, q++;
  e9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  ee:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  f7:	0f b6 00             	movzbl (%rax),%eax
  fa:	84 c0                	test   %al,%al
  fc:	74 12                	je     110 <strcmp+0x3d>
  fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 102:	0f b6 10             	movzbl (%rax),%edx
 105:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 109:	0f b6 00             	movzbl (%rax),%eax
 10c:	38 c2                	cmp    %al,%dl
 10e:	74 d9                	je     e9 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 110:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 114:	0f b6 00             	movzbl (%rax),%eax
 117:	0f b6 d0             	movzbl %al,%edx
 11a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 11e:	0f b6 00             	movzbl (%rax),%eax
 121:	0f b6 c0             	movzbl %al,%eax
 124:	29 c2                	sub    %eax,%edx
 126:	89 d0                	mov    %edx,%eax
}
 128:	c9                   	leave
 129:	c3                   	ret

000000000000012a <strlen>:

uint
strlen(char *s)
{
 12a:	f3 0f 1e fa          	endbr64
 12e:	55                   	push   %rbp
 12f:	48 89 e5             	mov    %rsp,%rbp
 132:	48 83 ec 18          	sub    $0x18,%rsp
 136:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 13a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 141:	eb 04                	jmp    147 <strlen+0x1d>
 143:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 147:	8b 45 fc             	mov    -0x4(%rbp),%eax
 14a:	48 63 d0             	movslq %eax,%rdx
 14d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 151:	48 01 d0             	add    %rdx,%rax
 154:	0f b6 00             	movzbl (%rax),%eax
 157:	84 c0                	test   %al,%al
 159:	75 e8                	jne    143 <strlen+0x19>
    ;
  return n;
 15b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 15e:	c9                   	leave
 15f:	c3                   	ret

0000000000000160 <memset>:

void*
memset(void *dst, int c, uint n)
{
 160:	f3 0f 1e fa          	endbr64
 164:	55                   	push   %rbp
 165:	48 89 e5             	mov    %rsp,%rbp
 168:	48 83 ec 10          	sub    $0x10,%rsp
 16c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 170:	89 75 f4             	mov    %esi,-0xc(%rbp)
 173:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 176:	8b 55 f0             	mov    -0x10(%rbp),%edx
 179:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 17c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 180:	89 ce                	mov    %ecx,%esi
 182:	48 89 c7             	mov    %rax,%rdi
 185:	e8 cc fe ff ff       	call   56 <stosb>
  return dst;
 18a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 18e:	c9                   	leave
 18f:	c3                   	ret

0000000000000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	f3 0f 1e fa          	endbr64
 194:	55                   	push   %rbp
 195:	48 89 e5             	mov    %rsp,%rbp
 198:	48 83 ec 10          	sub    $0x10,%rsp
 19c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1a0:	89 f0                	mov    %esi,%eax
 1a2:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1a5:	eb 17                	jmp    1be <strchr+0x2e>
    if(*s == c)
 1a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1ab:	0f b6 00             	movzbl (%rax),%eax
 1ae:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1b1:	75 06                	jne    1b9 <strchr+0x29>
      return (char*)s;
 1b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b7:	eb 15                	jmp    1ce <strchr+0x3e>
  for(; *s; s++)
 1b9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c2:	0f b6 00             	movzbl (%rax),%eax
 1c5:	84 c0                	test   %al,%al
 1c7:	75 de                	jne    1a7 <strchr+0x17>
  return 0;
 1c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ce:	c9                   	leave
 1cf:	c3                   	ret

00000000000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	f3 0f 1e fa          	endbr64
 1d4:	55                   	push   %rbp
 1d5:	48 89 e5             	mov    %rsp,%rbp
 1d8:	48 83 ec 20          	sub    $0x20,%rsp
 1dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1e0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1ea:	eb 48                	jmp    234 <gets+0x64>
    cc = read(0, &c, 1);
 1ec:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1f0:	ba 01 00 00 00       	mov    $0x1,%edx
 1f5:	48 89 c6             	mov    %rax,%rsi
 1f8:	bf 00 00 00 00       	mov    $0x0,%edi
 1fd:	e8 83 01 00 00       	call   385 <read>
 202:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 205:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 209:	7e 36                	jle    241 <gets+0x71>
      break;
    buf[i++] = c;
 20b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 20e:	8d 50 01             	lea    0x1(%rax),%edx
 211:	89 55 fc             	mov    %edx,-0x4(%rbp)
 214:	48 63 d0             	movslq %eax,%rdx
 217:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 21b:	48 01 c2             	add    %rax,%rdx
 21e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 222:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 224:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 228:	3c 0a                	cmp    $0xa,%al
 22a:	74 16                	je     242 <gets+0x72>
 22c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 230:	3c 0d                	cmp    $0xd,%al
 232:	74 0e                	je     242 <gets+0x72>
  for(i=0; i+1 < max; ){
 234:	8b 45 fc             	mov    -0x4(%rbp),%eax
 237:	83 c0 01             	add    $0x1,%eax
 23a:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 23d:	7f ad                	jg     1ec <gets+0x1c>
 23f:	eb 01                	jmp    242 <gets+0x72>
      break;
 241:	90                   	nop
      break;
  }
  buf[i] = '\0';
 242:	8b 45 fc             	mov    -0x4(%rbp),%eax
 245:	48 63 d0             	movslq %eax,%rdx
 248:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 24c:	48 01 d0             	add    %rdx,%rax
 24f:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 252:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 256:	c9                   	leave
 257:	c3                   	ret

0000000000000258 <stat>:

int
stat(char *n, struct stat *st)
{
 258:	f3 0f 1e fa          	endbr64
 25c:	55                   	push   %rbp
 25d:	48 89 e5             	mov    %rsp,%rbp
 260:	48 83 ec 20          	sub    $0x20,%rsp
 264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 270:	be 00 00 00 00       	mov    $0x0,%esi
 275:	48 89 c7             	mov    %rax,%rdi
 278:	e8 30 01 00 00       	call   3ad <open>
 27d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 280:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 284:	79 07                	jns    28d <stat+0x35>
    return -1;
 286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28b:	eb 21                	jmp    2ae <stat+0x56>
  r = fstat(fd, st);
 28d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 291:	8b 45 fc             	mov    -0x4(%rbp),%eax
 294:	48 89 d6             	mov    %rdx,%rsi
 297:	89 c7                	mov    %eax,%edi
 299:	e8 27 01 00 00       	call   3c5 <fstat>
 29e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2a4:	89 c7                	mov    %eax,%edi
 2a6:	e8 ea 00 00 00       	call   395 <close>
  return r;
 2ab:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2ae:	c9                   	leave
 2af:	c3                   	ret

00000000000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	f3 0f 1e fa          	endbr64
 2b4:	55                   	push   %rbp
 2b5:	48 89 e5             	mov    %rsp,%rbp
 2b8:	48 83 ec 18          	sub    $0x18,%rsp
 2bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2c7:	eb 28                	jmp    2f1 <atoi+0x41>
    n = n*10 + *s++ - '0';
 2c9:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2cc:	89 d0                	mov    %edx,%eax
 2ce:	c1 e0 02             	shl    $0x2,%eax
 2d1:	01 d0                	add    %edx,%eax
 2d3:	01 c0                	add    %eax,%eax
 2d5:	89 c1                	mov    %eax,%ecx
 2d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2db:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2df:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2e3:	0f b6 00             	movzbl (%rax),%eax
 2e6:	0f be c0             	movsbl %al,%eax
 2e9:	01 c8                	add    %ecx,%eax
 2eb:	83 e8 30             	sub    $0x30,%eax
 2ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f5:	0f b6 00             	movzbl (%rax),%eax
 2f8:	3c 2f                	cmp    $0x2f,%al
 2fa:	7e 0b                	jle    307 <atoi+0x57>
 2fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 300:	0f b6 00             	movzbl (%rax),%eax
 303:	3c 39                	cmp    $0x39,%al
 305:	7e c2                	jle    2c9 <atoi+0x19>
  return n;
 307:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 30a:	c9                   	leave
 30b:	c3                   	ret

000000000000030c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 30c:	f3 0f 1e fa          	endbr64
 310:	55                   	push   %rbp
 311:	48 89 e5             	mov    %rsp,%rbp
 314:	48 83 ec 28          	sub    $0x28,%rsp
 318:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 31c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 320:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 323:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 327:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 32b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 32f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 333:	eb 1d                	jmp    352 <memmove+0x46>
    *dst++ = *src++;
 335:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 339:	48 8d 42 01          	lea    0x1(%rdx),%rax
 33d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 341:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 345:	48 8d 48 01          	lea    0x1(%rax),%rcx
 349:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 34d:	0f b6 12             	movzbl (%rdx),%edx
 350:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 352:	8b 45 dc             	mov    -0x24(%rbp),%eax
 355:	8d 50 ff             	lea    -0x1(%rax),%edx
 358:	89 55 dc             	mov    %edx,-0x24(%rbp)
 35b:	85 c0                	test   %eax,%eax
 35d:	7f d6                	jg     335 <memmove+0x29>
  return vdst;
 35f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 363:	c9                   	leave
 364:	c3                   	ret

0000000000000365 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 365:	b8 01 00 00 00       	mov    $0x1,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret

000000000000036d <exit>:
SYSCALL(exit)
 36d:	b8 02 00 00 00       	mov    $0x2,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret

0000000000000375 <wait>:
SYSCALL(wait)
 375:	b8 03 00 00 00       	mov    $0x3,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret

000000000000037d <pipe>:
SYSCALL(pipe)
 37d:	b8 04 00 00 00       	mov    $0x4,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret

0000000000000385 <read>:
SYSCALL(read)
 385:	b8 05 00 00 00       	mov    $0x5,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret

000000000000038d <write>:
SYSCALL(write)
 38d:	b8 10 00 00 00       	mov    $0x10,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret

0000000000000395 <close>:
SYSCALL(close)
 395:	b8 15 00 00 00       	mov    $0x15,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret

000000000000039d <kill>:
SYSCALL(kill)
 39d:	b8 06 00 00 00       	mov    $0x6,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret

00000000000003a5 <exec>:
SYSCALL(exec)
 3a5:	b8 07 00 00 00       	mov    $0x7,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret

00000000000003ad <open>:
SYSCALL(open)
 3ad:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret

00000000000003b5 <mknod>:
SYSCALL(mknod)
 3b5:	b8 11 00 00 00       	mov    $0x11,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret

00000000000003bd <unlink>:
SYSCALL(unlink)
 3bd:	b8 12 00 00 00       	mov    $0x12,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret

00000000000003c5 <fstat>:
SYSCALL(fstat)
 3c5:	b8 08 00 00 00       	mov    $0x8,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret

00000000000003cd <link>:
SYSCALL(link)
 3cd:	b8 13 00 00 00       	mov    $0x13,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret

00000000000003d5 <mkdir>:
SYSCALL(mkdir)
 3d5:	b8 14 00 00 00       	mov    $0x14,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret

00000000000003dd <chdir>:
SYSCALL(chdir)
 3dd:	b8 09 00 00 00       	mov    $0x9,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret

00000000000003e5 <dup>:
SYSCALL(dup)
 3e5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret

00000000000003ed <getpid>:
SYSCALL(getpid)
 3ed:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret

00000000000003f5 <sbrk>:
SYSCALL(sbrk)
 3f5:	b8 0c 00 00 00       	mov    $0xc,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret

00000000000003fd <sleep>:
SYSCALL(sleep)
 3fd:	b8 0d 00 00 00       	mov    $0xd,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret

0000000000000405 <uptime>:
SYSCALL(uptime)
 405:	b8 0e 00 00 00       	mov    $0xe,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret

000000000000040d <getpinfo>:
SYSCALL(getpinfo)
 40d:	b8 18 00 00 00       	mov    $0x18,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret

0000000000000415 <settickets>:
SYSCALL(settickets)
 415:	b8 1b 00 00 00       	mov    $0x1b,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret

000000000000041d <getfavnum>:
SYSCALL(getfavnum)
 41d:	b8 1c 00 00 00       	mov    $0x1c,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret

0000000000000425 <halt>:
SYSCALL(halt)
 425:	b8 1d 00 00 00       	mov    $0x1d,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret

000000000000042d <getcount>:
SYSCALL(getcount)
 42d:	b8 1e 00 00 00       	mov    $0x1e,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret

0000000000000435 <killrandom>:
SYSCALL(killrandom)
 435:	b8 1f 00 00 00       	mov    $0x1f,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret

000000000000043d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 43d:	f3 0f 1e fa          	endbr64
 441:	55                   	push   %rbp
 442:	48 89 e5             	mov    %rsp,%rbp
 445:	48 83 ec 10          	sub    $0x10,%rsp
 449:	89 7d fc             	mov    %edi,-0x4(%rbp)
 44c:	89 f0                	mov    %esi,%eax
 44e:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 451:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 455:	8b 45 fc             	mov    -0x4(%rbp),%eax
 458:	ba 01 00 00 00       	mov    $0x1,%edx
 45d:	48 89 ce             	mov    %rcx,%rsi
 460:	89 c7                	mov    %eax,%edi
 462:	e8 26 ff ff ff       	call   38d <write>
}
 467:	90                   	nop
 468:	c9                   	leave
 469:	c3                   	ret

000000000000046a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 46a:	f3 0f 1e fa          	endbr64
 46e:	55                   	push   %rbp
 46f:	48 89 e5             	mov    %rsp,%rbp
 472:	48 83 ec 30          	sub    $0x30,%rsp
 476:	89 7d dc             	mov    %edi,-0x24(%rbp)
 479:	89 75 d8             	mov    %esi,-0x28(%rbp)
 47c:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 47f:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 482:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 489:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 48d:	74 17                	je     4a6 <printint+0x3c>
 48f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 493:	79 11                	jns    4a6 <printint+0x3c>
    neg = 1;
 495:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 49c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 49f:	f7 d8                	neg    %eax
 4a1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4a4:	eb 06                	jmp    4ac <printint+0x42>
  } else {
    x = xx;
 4a6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4a9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4b3:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4b6:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4b9:	ba 00 00 00 00       	mov    $0x0,%edx
 4be:	f7 f6                	div    %esi
 4c0:	89 d1                	mov    %edx,%ecx
 4c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c5:	8d 50 01             	lea    0x1(%rax),%edx
 4c8:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4cb:	89 ca                	mov    %ecx,%edx
 4cd:	0f b6 92 d0 0d 00 00 	movzbl 0xdd0(%rdx),%edx
 4d4:	48 98                	cltq
 4d6:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4da:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 4dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4e0:	ba 00 00 00 00       	mov    $0x0,%edx
 4e5:	f7 f7                	div    %edi
 4e7:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4ee:	75 c3                	jne    4b3 <printint+0x49>
  if(neg)
 4f0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4f4:	74 2b                	je     521 <printint+0xb7>
    buf[i++] = '-';
 4f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f9:	8d 50 01             	lea    0x1(%rax),%edx
 4fc:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ff:	48 98                	cltq
 501:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 506:	eb 19                	jmp    521 <printint+0xb7>
    putc(fd, buf[i]);
 508:	8b 45 fc             	mov    -0x4(%rbp),%eax
 50b:	48 98                	cltq
 50d:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 512:	0f be d0             	movsbl %al,%edx
 515:	8b 45 dc             	mov    -0x24(%rbp),%eax
 518:	89 d6                	mov    %edx,%esi
 51a:	89 c7                	mov    %eax,%edi
 51c:	e8 1c ff ff ff       	call   43d <putc>
  while(--i >= 0)
 521:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 525:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 529:	79 dd                	jns    508 <printint+0x9e>
}
 52b:	90                   	nop
 52c:	90                   	nop
 52d:	c9                   	leave
 52e:	c3                   	ret

000000000000052f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 52f:	f3 0f 1e fa          	endbr64
 533:	55                   	push   %rbp
 534:	48 89 e5             	mov    %rsp,%rbp
 537:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 53e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 544:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 54b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 552:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 559:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 560:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 567:	84 c0                	test   %al,%al
 569:	74 20                	je     58b <printf+0x5c>
 56b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 56f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 573:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 577:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 57b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 57f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 583:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 587:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 58b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 592:	00 00 00 
 595:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 59c:	00 00 00 
 59f:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5a3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5aa:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5b1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5b8:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5bf:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5c2:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5c9:	00 00 00 
 5cc:	e9 a8 02 00 00       	jmp    879 <printf+0x34a>
    c = fmt[i] & 0xff;
 5d1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5d7:	48 63 d0             	movslq %eax,%rdx
 5da:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5e1:	48 01 d0             	add    %rdx,%rax
 5e4:	0f b6 00             	movzbl (%rax),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	25 ff 00 00 00       	and    $0xff,%eax
 5ef:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5f5:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5fc:	75 35                	jne    633 <printf+0x104>
      if(c == '%'){
 5fe:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 605:	75 0f                	jne    616 <printf+0xe7>
        state = '%';
 607:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 60e:	00 00 00 
 611:	e9 5c 02 00 00       	jmp    872 <printf+0x343>
      } else {
        putc(fd, c);
 616:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 61c:	0f be d0             	movsbl %al,%edx
 61f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 625:	89 d6                	mov    %edx,%esi
 627:	89 c7                	mov    %eax,%edi
 629:	e8 0f fe ff ff       	call   43d <putc>
 62e:	e9 3f 02 00 00       	jmp    872 <printf+0x343>
      }
    } else if(state == '%'){
 633:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 63a:	0f 85 32 02 00 00    	jne    872 <printf+0x343>
      if(c == 'd'){
 640:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 647:	75 5e                	jne    6a7 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 649:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 64f:	83 f8 2f             	cmp    $0x2f,%eax
 652:	77 23                	ja     677 <printf+0x148>
 654:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 65b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 661:	89 d2                	mov    %edx,%edx
 663:	48 01 d0             	add    %rdx,%rax
 666:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 66c:	83 c2 08             	add    $0x8,%edx
 66f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 675:	eb 12                	jmp    689 <printf+0x15a>
 677:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 67e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 682:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 689:	8b 30                	mov    (%rax),%esi
 68b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 691:	b9 01 00 00 00       	mov    $0x1,%ecx
 696:	ba 0a 00 00 00       	mov    $0xa,%edx
 69b:	89 c7                	mov    %eax,%edi
 69d:	e8 c8 fd ff ff       	call   46a <printint>
 6a2:	e9 c1 01 00 00       	jmp    868 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 6a7:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6ae:	74 09                	je     6b9 <printf+0x18a>
 6b0:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6b7:	75 5e                	jne    717 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 6b9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6bf:	83 f8 2f             	cmp    $0x2f,%eax
 6c2:	77 23                	ja     6e7 <printf+0x1b8>
 6c4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6cb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6d1:	89 d2                	mov    %edx,%edx
 6d3:	48 01 d0             	add    %rdx,%rax
 6d6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6dc:	83 c2 08             	add    $0x8,%edx
 6df:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6e5:	eb 12                	jmp    6f9 <printf+0x1ca>
 6e7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6ee:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6f2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6f9:	8b 30                	mov    (%rax),%esi
 6fb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 701:	b9 00 00 00 00       	mov    $0x0,%ecx
 706:	ba 10 00 00 00       	mov    $0x10,%edx
 70b:	89 c7                	mov    %eax,%edi
 70d:	e8 58 fd ff ff       	call   46a <printint>
 712:	e9 51 01 00 00       	jmp    868 <printf+0x339>
      } else if(c == 's'){
 717:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 71e:	0f 85 98 00 00 00    	jne    7bc <printf+0x28d>
        s = va_arg(ap, char*);
 724:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 72a:	83 f8 2f             	cmp    $0x2f,%eax
 72d:	77 23                	ja     752 <printf+0x223>
 72f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 736:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 73c:	89 d2                	mov    %edx,%edx
 73e:	48 01 d0             	add    %rdx,%rax
 741:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 747:	83 c2 08             	add    $0x8,%edx
 74a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 750:	eb 12                	jmp    764 <printf+0x235>
 752:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 759:	48 8d 50 08          	lea    0x8(%rax),%rdx
 75d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 764:	48 8b 00             	mov    (%rax),%rax
 767:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 76e:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 775:	00 
 776:	75 31                	jne    7a9 <printf+0x27a>
          s = "(null)";
 778:	48 c7 85 48 ff ff ff 	movq   $0xb8a,-0xb8(%rbp)
 77f:	8a 0b 00 00 
        while(*s != 0){
 783:	eb 24                	jmp    7a9 <printf+0x27a>
          putc(fd, *s);
 785:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 78c:	0f b6 00             	movzbl (%rax),%eax
 78f:	0f be d0             	movsbl %al,%edx
 792:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 798:	89 d6                	mov    %edx,%esi
 79a:	89 c7                	mov    %eax,%edi
 79c:	e8 9c fc ff ff       	call   43d <putc>
          s++;
 7a1:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7a8:	01 
        while(*s != 0){
 7a9:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7b0:	0f b6 00             	movzbl (%rax),%eax
 7b3:	84 c0                	test   %al,%al
 7b5:	75 ce                	jne    785 <printf+0x256>
 7b7:	e9 ac 00 00 00       	jmp    868 <printf+0x339>
        }
      } else if(c == 'c'){
 7bc:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7c3:	75 56                	jne    81b <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 7c5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7cb:	83 f8 2f             	cmp    $0x2f,%eax
 7ce:	77 23                	ja     7f3 <printf+0x2c4>
 7d0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7d7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7dd:	89 d2                	mov    %edx,%edx
 7df:	48 01 d0             	add    %rdx,%rax
 7e2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e8:	83 c2 08             	add    $0x8,%edx
 7eb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7f1:	eb 12                	jmp    805 <printf+0x2d6>
 7f3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7fa:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7fe:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 805:	8b 00                	mov    (%rax),%eax
 807:	0f be d0             	movsbl %al,%edx
 80a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 810:	89 d6                	mov    %edx,%esi
 812:	89 c7                	mov    %eax,%edi
 814:	e8 24 fc ff ff       	call   43d <putc>
 819:	eb 4d                	jmp    868 <printf+0x339>
      } else if(c == '%'){
 81b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 822:	75 1a                	jne    83e <printf+0x30f>
        putc(fd, c);
 824:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 82a:	0f be d0             	movsbl %al,%edx
 82d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 833:	89 d6                	mov    %edx,%esi
 835:	89 c7                	mov    %eax,%edi
 837:	e8 01 fc ff ff       	call   43d <putc>
 83c:	eb 2a                	jmp    868 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 83e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 844:	be 25 00 00 00       	mov    $0x25,%esi
 849:	89 c7                	mov    %eax,%edi
 84b:	e8 ed fb ff ff       	call   43d <putc>
        putc(fd, c);
 850:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 856:	0f be d0             	movsbl %al,%edx
 859:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85f:	89 d6                	mov    %edx,%esi
 861:	89 c7                	mov    %eax,%edi
 863:	e8 d5 fb ff ff       	call   43d <putc>
      }
      state = 0;
 868:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 86f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 872:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 879:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 87f:	48 63 d0             	movslq %eax,%rdx
 882:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 889:	48 01 d0             	add    %rdx,%rax
 88c:	0f b6 00             	movzbl (%rax),%eax
 88f:	84 c0                	test   %al,%al
 891:	0f 85 3a fd ff ff    	jne    5d1 <printf+0xa2>
    }
  }
}
 897:	90                   	nop
 898:	90                   	nop
 899:	c9                   	leave
 89a:	c3                   	ret

000000000000089b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89b:	f3 0f 1e fa          	endbr64
 89f:	55                   	push   %rbp
 8a0:	48 89 e5             	mov    %rsp,%rbp
 8a3:	48 83 ec 18          	sub    $0x18,%rsp
 8a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8af:	48 83 e8 10          	sub    $0x10,%rax
 8b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b7:	48 8b 05 42 05 00 00 	mov    0x542(%rip),%rax        # e00 <freep>
 8be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8c2:	eb 2f                	jmp    8f3 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c8:	48 8b 00             	mov    (%rax),%rax
 8cb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8cf:	72 17                	jb     8e8 <free+0x4d>
 8d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d9:	72 2f                	jb     90a <free+0x6f>
 8db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8df:	48 8b 00             	mov    (%rax),%rax
 8e2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8e6:	72 22                	jb     90a <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ec:	48 8b 00             	mov    (%rax),%rax
 8ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8fb:	73 c7                	jae    8c4 <free+0x29>
 8fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 901:	48 8b 00             	mov    (%rax),%rax
 904:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 908:	73 ba                	jae    8c4 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 90a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90e:	8b 40 08             	mov    0x8(%rax),%eax
 911:	89 c0                	mov    %eax,%eax
 913:	48 c1 e0 04          	shl    $0x4,%rax
 917:	48 89 c2             	mov    %rax,%rdx
 91a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91e:	48 01 c2             	add    %rax,%rdx
 921:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 925:	48 8b 00             	mov    (%rax),%rax
 928:	48 39 c2             	cmp    %rax,%rdx
 92b:	75 2d                	jne    95a <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 92d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 931:	8b 50 08             	mov    0x8(%rax),%edx
 934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 938:	48 8b 00             	mov    (%rax),%rax
 93b:	8b 40 08             	mov    0x8(%rax),%eax
 93e:	01 c2                	add    %eax,%edx
 940:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 944:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94b:	48 8b 00             	mov    (%rax),%rax
 94e:	48 8b 10             	mov    (%rax),%rdx
 951:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 955:	48 89 10             	mov    %rdx,(%rax)
 958:	eb 0e                	jmp    968 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 95a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95e:	48 8b 10             	mov    (%rax),%rdx
 961:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 965:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 968:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96c:	8b 40 08             	mov    0x8(%rax),%eax
 96f:	89 c0                	mov    %eax,%eax
 971:	48 c1 e0 04          	shl    $0x4,%rax
 975:	48 89 c2             	mov    %rax,%rdx
 978:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97c:	48 01 d0             	add    %rdx,%rax
 97f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 983:	75 27                	jne    9ac <free+0x111>
    p->s.size += bp->s.size;
 985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 989:	8b 50 08             	mov    0x8(%rax),%edx
 98c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 990:	8b 40 08             	mov    0x8(%rax),%eax
 993:	01 c2                	add    %eax,%edx
 995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 999:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 99c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a0:	48 8b 10             	mov    (%rax),%rdx
 9a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a7:	48 89 10             	mov    %rdx,(%rax)
 9aa:	eb 0b                	jmp    9b7 <free+0x11c>
  } else
    p->s.ptr = bp;
 9ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9b4:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bb:	48 89 05 3e 04 00 00 	mov    %rax,0x43e(%rip)        # e00 <freep>
}
 9c2:	90                   	nop
 9c3:	c9                   	leave
 9c4:	c3                   	ret

00000000000009c5 <morecore>:

static Header*
morecore(uint nu)
{
 9c5:	f3 0f 1e fa          	endbr64
 9c9:	55                   	push   %rbp
 9ca:	48 89 e5             	mov    %rsp,%rbp
 9cd:	48 83 ec 20          	sub    $0x20,%rsp
 9d1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9d4:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9db:	77 07                	ja     9e4 <morecore+0x1f>
    nu = 4096;
 9dd:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9e7:	c1 e0 04             	shl    $0x4,%eax
 9ea:	89 c7                	mov    %eax,%edi
 9ec:	e8 04 fa ff ff       	call   3f5 <sbrk>
 9f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9f5:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9fa:	75 07                	jne    a03 <morecore+0x3e>
    return 0;
 9fc:	b8 00 00 00 00       	mov    $0x0,%eax
 a01:	eb 29                	jmp    a2c <morecore+0x67>
  hp = (Header*)p;
 a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a07:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0f:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a12:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a19:	48 83 c0 10          	add    $0x10,%rax
 a1d:	48 89 c7             	mov    %rax,%rdi
 a20:	e8 76 fe ff ff       	call   89b <free>
  return freep;
 a25:	48 8b 05 d4 03 00 00 	mov    0x3d4(%rip),%rax        # e00 <freep>
}
 a2c:	c9                   	leave
 a2d:	c3                   	ret

0000000000000a2e <malloc>:

void*
malloc(uint nbytes)
{
 a2e:	f3 0f 1e fa          	endbr64
 a32:	55                   	push   %rbp
 a33:	48 89 e5             	mov    %rsp,%rbp
 a36:	48 83 ec 30          	sub    $0x30,%rsp
 a3a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a3d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a40:	48 83 c0 0f          	add    $0xf,%rax
 a44:	48 c1 e8 04          	shr    $0x4,%rax
 a48:	83 c0 01             	add    $0x1,%eax
 a4b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a4e:	48 8b 05 ab 03 00 00 	mov    0x3ab(%rip),%rax        # e00 <freep>
 a55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a59:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a5e:	75 2b                	jne    a8b <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 a60:	48 c7 45 f0 f0 0d 00 	movq   $0xdf0,-0x10(%rbp)
 a67:	00 
 a68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a6c:	48 89 05 8d 03 00 00 	mov    %rax,0x38d(%rip)        # e00 <freep>
 a73:	48 8b 05 86 03 00 00 	mov    0x386(%rip),%rax        # e00 <freep>
 a7a:	48 89 05 6f 03 00 00 	mov    %rax,0x36f(%rip)        # df0 <base>
    base.s.size = 0;
 a81:	c7 05 6d 03 00 00 00 	movl   $0x0,0x36d(%rip)        # df8 <base+0x8>
 a88:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8f:	48 8b 00             	mov    (%rax),%rax
 a92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9a:	8b 40 08             	mov    0x8(%rax),%eax
 a9d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aa0:	72 5f                	jb     b01 <malloc+0xd3>
      if(p->s.size == nunits)
 aa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa6:	8b 40 08             	mov    0x8(%rax),%eax
 aa9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 aac:	75 10                	jne    abe <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 aae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab2:	48 8b 10             	mov    (%rax),%rdx
 ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab9:	48 89 10             	mov    %rdx,(%rax)
 abc:	eb 2e                	jmp    aec <malloc+0xbe>
      else {
        p->s.size -= nunits;
 abe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac2:	8b 40 08             	mov    0x8(%rax),%eax
 ac5:	2b 45 ec             	sub    -0x14(%rbp),%eax
 ac8:	89 c2                	mov    %eax,%edx
 aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ace:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad5:	8b 40 08             	mov    0x8(%rax),%eax
 ad8:	89 c0                	mov    %eax,%eax
 ada:	48 c1 e0 04          	shl    $0x4,%rax
 ade:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ae2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae6:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ae9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af0:	48 89 05 09 03 00 00 	mov    %rax,0x309(%rip)        # e00 <freep>
      return (void*)(p + 1);
 af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 afb:	48 83 c0 10          	add    $0x10,%rax
 aff:	eb 41                	jmp    b42 <malloc+0x114>
    }
    if(p == freep)
 b01:	48 8b 05 f8 02 00 00 	mov    0x2f8(%rip),%rax        # e00 <freep>
 b08:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b0c:	75 1c                	jne    b2a <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b11:	89 c7                	mov    %eax,%edi
 b13:	e8 ad fe ff ff       	call   9c5 <morecore>
 b18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b1c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b21:	75 07                	jne    b2a <malloc+0xfc>
        return 0;
 b23:	b8 00 00 00 00       	mov    $0x0,%eax
 b28:	eb 18                	jmp    b42 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b36:	48 8b 00             	mov    (%rax),%rax
 b39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b3d:	e9 54 ff ff ff       	jmp    a96 <malloc+0x68>
  }
}
 b42:	c9                   	leave
 b43:	c3                   	ret
