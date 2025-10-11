
fs/init:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	be 02 00 00 00       	mov    $0x2,%esi
  11:	48 c7 c7 f5 0b 00 00 	mov    $0xbf5,%rdi
  18:	e8 3e 04 00 00       	call   45b <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 27                	jns    48 <main+0x48>
    mknod("console", 1, 1);
  21:	ba 01 00 00 00       	mov    $0x1,%edx
  26:	be 01 00 00 00       	mov    $0x1,%esi
  2b:	48 c7 c7 f5 0b 00 00 	mov    $0xbf5,%rdi
  32:	e8 2c 04 00 00       	call   463 <mknod>
    open("console", O_RDWR);
  37:	be 02 00 00 00       	mov    $0x2,%esi
  3c:	48 c7 c7 f5 0b 00 00 	mov    $0xbf5,%rdi
  43:	e8 13 04 00 00       	call   45b <open>
  }
  dup(0);  // stdout
  48:	bf 00 00 00 00       	mov    $0x0,%edi
  4d:	e8 41 04 00 00       	call   493 <dup>
  dup(0);  // stderr
  52:	bf 00 00 00 00       	mov    $0x0,%edi
  57:	e8 37 04 00 00       	call   493 <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  5c:	48 c7 c6 fd 0b 00 00 	mov    $0xbfd,%rsi
  63:	bf 01 00 00 00       	mov    $0x1,%edi
  68:	b8 00 00 00 00       	mov    $0x0,%eax
  6d:	e8 6b 05 00 00       	call   5dd <printf>
    pid = fork();
  72:	e8 9c 03 00 00       	call   413 <fork>
  77:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
  7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  7e:	79 1b                	jns    9b <main+0x9b>
      printf(1, "init: fork failed\n");
  80:	48 c7 c6 10 0c 00 00 	mov    $0xc10,%rsi
  87:	bf 01 00 00 00       	mov    $0x1,%edi
  8c:	b8 00 00 00 00       	mov    $0x0,%eax
  91:	e8 47 05 00 00       	call   5dd <printf>
      exit();
  96:	e8 80 03 00 00       	call   41b <exit>
    }
    if(pid == 0){
  9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  9f:	75 44                	jne    e5 <main+0xe5>
      exec("sh", argv);
  a1:	48 c7 c6 90 0e 00 00 	mov    $0xe90,%rsi
  a8:	48 c7 c7 f2 0b 00 00 	mov    $0xbf2,%rdi
  af:	e8 9f 03 00 00       	call   453 <exec>
      printf(1, "init: exec sh failed\n");
  b4:	48 c7 c6 23 0c 00 00 	mov    $0xc23,%rsi
  bb:	bf 01 00 00 00       	mov    $0x1,%edi
  c0:	b8 00 00 00 00       	mov    $0x0,%eax
  c5:	e8 13 05 00 00       	call   5dd <printf>
      exit();
  ca:	e8 4c 03 00 00       	call   41b <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  cf:	48 c7 c6 39 0c 00 00 	mov    $0xc39,%rsi
  d6:	bf 01 00 00 00       	mov    $0x1,%edi
  db:	b8 00 00 00 00       	mov    $0x0,%eax
  e0:	e8 f8 04 00 00       	call   5dd <printf>
    while((wpid=wait()) >= 0 && wpid != pid)
  e5:	e8 39 03 00 00       	call   423 <wait>
  ea:	89 45 f8             	mov    %eax,-0x8(%rbp)
  ed:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  f1:	0f 88 65 ff ff ff    	js     5c <main+0x5c>
  f7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  fa:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  fd:	75 d0                	jne    cf <main+0xcf>
    printf(1, "init: starting sh\n");
  ff:	e9 58 ff ff ff       	jmp    5c <main+0x5c>

0000000000000104 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 104:	55                   	push   %rbp
 105:	48 89 e5             	mov    %rsp,%rbp
 108:	48 83 ec 10          	sub    $0x10,%rsp
 10c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 110:	89 75 f4             	mov    %esi,-0xc(%rbp)
 113:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 116:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 11a:	8b 55 f0             	mov    -0x10(%rbp),%edx
 11d:	8b 45 f4             	mov    -0xc(%rbp),%eax
 120:	48 89 ce             	mov    %rcx,%rsi
 123:	48 89 f7             	mov    %rsi,%rdi
 126:	89 d1                	mov    %edx,%ecx
 128:	fc                   	cld
 129:	f3 aa                	rep stos %al,%es:(%rdi)
 12b:	89 ca                	mov    %ecx,%edx
 12d:	48 89 fe             	mov    %rdi,%rsi
 130:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 134:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 137:	90                   	nop
 138:	c9                   	leave
 139:	c3                   	ret

000000000000013a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 13a:	f3 0f 1e fa          	endbr64
 13e:	55                   	push   %rbp
 13f:	48 89 e5             	mov    %rsp,%rbp
 142:	48 83 ec 20          	sub    $0x20,%rsp
 146:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 14a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 14e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 152:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 156:	90                   	nop
 157:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 15b:	48 8d 42 01          	lea    0x1(%rdx),%rax
 15f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 163:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 167:	48 8d 48 01          	lea    0x1(%rax),%rcx
 16b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 16f:	0f b6 12             	movzbl (%rdx),%edx
 172:	88 10                	mov    %dl,(%rax)
 174:	0f b6 00             	movzbl (%rax),%eax
 177:	84 c0                	test   %al,%al
 179:	75 dc                	jne    157 <strcpy+0x1d>
    ;
  return os;
 17b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 17f:	c9                   	leave
 180:	c3                   	ret

0000000000000181 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 181:	f3 0f 1e fa          	endbr64
 185:	55                   	push   %rbp
 186:	48 89 e5             	mov    %rsp,%rbp
 189:	48 83 ec 10          	sub    $0x10,%rsp
 18d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 191:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 195:	eb 0a                	jmp    1a1 <strcmp+0x20>
    p++, q++;
 197:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 19c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 1a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a5:	0f b6 00             	movzbl (%rax),%eax
 1a8:	84 c0                	test   %al,%al
 1aa:	74 12                	je     1be <strcmp+0x3d>
 1ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b0:	0f b6 10             	movzbl (%rax),%edx
 1b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1b7:	0f b6 00             	movzbl (%rax),%eax
 1ba:	38 c2                	cmp    %al,%dl
 1bc:	74 d9                	je     197 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 1be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c2:	0f b6 00             	movzbl (%rax),%eax
 1c5:	0f b6 d0             	movzbl %al,%edx
 1c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1cc:	0f b6 00             	movzbl (%rax),%eax
 1cf:	0f b6 c0             	movzbl %al,%eax
 1d2:	29 c2                	sub    %eax,%edx
 1d4:	89 d0                	mov    %edx,%eax
}
 1d6:	c9                   	leave
 1d7:	c3                   	ret

00000000000001d8 <strlen>:

uint
strlen(char *s)
{
 1d8:	f3 0f 1e fa          	endbr64
 1dc:	55                   	push   %rbp
 1dd:	48 89 e5             	mov    %rsp,%rbp
 1e0:	48 83 ec 18          	sub    $0x18,%rsp
 1e4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 1e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1ef:	eb 04                	jmp    1f5 <strlen+0x1d>
 1f1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f8:	48 63 d0             	movslq %eax,%rdx
 1fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1ff:	48 01 d0             	add    %rdx,%rax
 202:	0f b6 00             	movzbl (%rax),%eax
 205:	84 c0                	test   %al,%al
 207:	75 e8                	jne    1f1 <strlen+0x19>
    ;
  return n;
 209:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 20c:	c9                   	leave
 20d:	c3                   	ret

000000000000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	f3 0f 1e fa          	endbr64
 212:	55                   	push   %rbp
 213:	48 89 e5             	mov    %rsp,%rbp
 216:	48 83 ec 10          	sub    $0x10,%rsp
 21a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 21e:	89 75 f4             	mov    %esi,-0xc(%rbp)
 221:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 224:	8b 55 f0             	mov    -0x10(%rbp),%edx
 227:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 22a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22e:	89 ce                	mov    %ecx,%esi
 230:	48 89 c7             	mov    %rax,%rdi
 233:	e8 cc fe ff ff       	call   104 <stosb>
  return dst;
 238:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 23c:	c9                   	leave
 23d:	c3                   	ret

000000000000023e <strchr>:

char*
strchr(const char *s, char c)
{
 23e:	f3 0f 1e fa          	endbr64
 242:	55                   	push   %rbp
 243:	48 89 e5             	mov    %rsp,%rbp
 246:	48 83 ec 10          	sub    $0x10,%rsp
 24a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 24e:	89 f0                	mov    %esi,%eax
 250:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 253:	eb 17                	jmp    26c <strchr+0x2e>
    if(*s == c)
 255:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 259:	0f b6 00             	movzbl (%rax),%eax
 25c:	38 45 f4             	cmp    %al,-0xc(%rbp)
 25f:	75 06                	jne    267 <strchr+0x29>
      return (char*)s;
 261:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 265:	eb 15                	jmp    27c <strchr+0x3e>
  for(; *s; s++)
 267:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 26c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 270:	0f b6 00             	movzbl (%rax),%eax
 273:	84 c0                	test   %al,%al
 275:	75 de                	jne    255 <strchr+0x17>
  return 0;
 277:	b8 00 00 00 00       	mov    $0x0,%eax
}
 27c:	c9                   	leave
 27d:	c3                   	ret

000000000000027e <gets>:

char*
gets(char *buf, int max)
{
 27e:	f3 0f 1e fa          	endbr64
 282:	55                   	push   %rbp
 283:	48 89 e5             	mov    %rsp,%rbp
 286:	48 83 ec 20          	sub    $0x20,%rsp
 28a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 28e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 291:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 298:	eb 48                	jmp    2e2 <gets+0x64>
    cc = read(0, &c, 1);
 29a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 29e:	ba 01 00 00 00       	mov    $0x1,%edx
 2a3:	48 89 c6             	mov    %rax,%rsi
 2a6:	bf 00 00 00 00       	mov    $0x0,%edi
 2ab:	e8 83 01 00 00       	call   433 <read>
 2b0:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 2b3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 2b7:	7e 36                	jle    2ef <gets+0x71>
      break;
    buf[i++] = c;
 2b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2bc:	8d 50 01             	lea    0x1(%rax),%edx
 2bf:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2c2:	48 63 d0             	movslq %eax,%rdx
 2c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2c9:	48 01 c2             	add    %rax,%rdx
 2cc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2d0:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 2d2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2d6:	3c 0a                	cmp    $0xa,%al
 2d8:	74 16                	je     2f0 <gets+0x72>
 2da:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2de:	3c 0d                	cmp    $0xd,%al
 2e0:	74 0e                	je     2f0 <gets+0x72>
  for(i=0; i+1 < max; ){
 2e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2e5:	83 c0 01             	add    $0x1,%eax
 2e8:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 2eb:	7f ad                	jg     29a <gets+0x1c>
 2ed:	eb 01                	jmp    2f0 <gets+0x72>
      break;
 2ef:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2f3:	48 63 d0             	movslq %eax,%rdx
 2f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fa:	48 01 d0             	add    %rdx,%rax
 2fd:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 300:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 304:	c9                   	leave
 305:	c3                   	ret

0000000000000306 <stat>:

int
stat(char *n, struct stat *st)
{
 306:	f3 0f 1e fa          	endbr64
 30a:	55                   	push   %rbp
 30b:	48 89 e5             	mov    %rsp,%rbp
 30e:	48 83 ec 20          	sub    $0x20,%rsp
 312:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 316:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31e:	be 00 00 00 00       	mov    $0x0,%esi
 323:	48 89 c7             	mov    %rax,%rdi
 326:	e8 30 01 00 00       	call   45b <open>
 32b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 32e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 332:	79 07                	jns    33b <stat+0x35>
    return -1;
 334:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 339:	eb 21                	jmp    35c <stat+0x56>
  r = fstat(fd, st);
 33b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 33f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 342:	48 89 d6             	mov    %rdx,%rsi
 345:	89 c7                	mov    %eax,%edi
 347:	e8 27 01 00 00       	call   473 <fstat>
 34c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 34f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 352:	89 c7                	mov    %eax,%edi
 354:	e8 ea 00 00 00       	call   443 <close>
  return r;
 359:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 35c:	c9                   	leave
 35d:	c3                   	ret

000000000000035e <atoi>:

int
atoi(const char *s)
{
 35e:	f3 0f 1e fa          	endbr64
 362:	55                   	push   %rbp
 363:	48 89 e5             	mov    %rsp,%rbp
 366:	48 83 ec 18          	sub    $0x18,%rsp
 36a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 36e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 375:	eb 28                	jmp    39f <atoi+0x41>
    n = n*10 + *s++ - '0';
 377:	8b 55 fc             	mov    -0x4(%rbp),%edx
 37a:	89 d0                	mov    %edx,%eax
 37c:	c1 e0 02             	shl    $0x2,%eax
 37f:	01 d0                	add    %edx,%eax
 381:	01 c0                	add    %eax,%eax
 383:	89 c1                	mov    %eax,%ecx
 385:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 389:	48 8d 50 01          	lea    0x1(%rax),%rdx
 38d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 391:	0f b6 00             	movzbl (%rax),%eax
 394:	0f be c0             	movsbl %al,%eax
 397:	01 c8                	add    %ecx,%eax
 399:	83 e8 30             	sub    $0x30,%eax
 39c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 39f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3a3:	0f b6 00             	movzbl (%rax),%eax
 3a6:	3c 2f                	cmp    $0x2f,%al
 3a8:	7e 0b                	jle    3b5 <atoi+0x57>
 3aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3ae:	0f b6 00             	movzbl (%rax),%eax
 3b1:	3c 39                	cmp    $0x39,%al
 3b3:	7e c2                	jle    377 <atoi+0x19>
  return n;
 3b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 3b8:	c9                   	leave
 3b9:	c3                   	ret

00000000000003ba <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3ba:	f3 0f 1e fa          	endbr64
 3be:	55                   	push   %rbp
 3bf:	48 89 e5             	mov    %rsp,%rbp
 3c2:	48 83 ec 28          	sub    $0x28,%rsp
 3c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3ce:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 3d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 3d9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 3dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 3e1:	eb 1d                	jmp    400 <memmove+0x46>
    *dst++ = *src++;
 3e3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 3e7:	48 8d 42 01          	lea    0x1(%rdx),%rax
 3eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 3ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3f3:	48 8d 48 01          	lea    0x1(%rax),%rcx
 3f7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 3fb:	0f b6 12             	movzbl (%rdx),%edx
 3fe:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 400:	8b 45 dc             	mov    -0x24(%rbp),%eax
 403:	8d 50 ff             	lea    -0x1(%rax),%edx
 406:	89 55 dc             	mov    %edx,-0x24(%rbp)
 409:	85 c0                	test   %eax,%eax
 40b:	7f d6                	jg     3e3 <memmove+0x29>
  return vdst;
 40d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 411:	c9                   	leave
 412:	c3                   	ret

0000000000000413 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 413:	b8 01 00 00 00       	mov    $0x1,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

000000000000041b <exit>:
SYSCALL(exit)
 41b:	b8 02 00 00 00       	mov    $0x2,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

0000000000000423 <wait>:
SYSCALL(wait)
 423:	b8 03 00 00 00       	mov    $0x3,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

000000000000042b <pipe>:
SYSCALL(pipe)
 42b:	b8 04 00 00 00       	mov    $0x4,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

0000000000000433 <read>:
SYSCALL(read)
 433:	b8 05 00 00 00       	mov    $0x5,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

000000000000043b <write>:
SYSCALL(write)
 43b:	b8 10 00 00 00       	mov    $0x10,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

0000000000000443 <close>:
SYSCALL(close)
 443:	b8 15 00 00 00       	mov    $0x15,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

000000000000044b <kill>:
SYSCALL(kill)
 44b:	b8 06 00 00 00       	mov    $0x6,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

0000000000000453 <exec>:
SYSCALL(exec)
 453:	b8 07 00 00 00       	mov    $0x7,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

000000000000045b <open>:
SYSCALL(open)
 45b:	b8 0f 00 00 00       	mov    $0xf,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

0000000000000463 <mknod>:
SYSCALL(mknod)
 463:	b8 11 00 00 00       	mov    $0x11,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

000000000000046b <unlink>:
SYSCALL(unlink)
 46b:	b8 12 00 00 00       	mov    $0x12,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

0000000000000473 <fstat>:
SYSCALL(fstat)
 473:	b8 08 00 00 00       	mov    $0x8,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

000000000000047b <link>:
SYSCALL(link)
 47b:	b8 13 00 00 00       	mov    $0x13,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

0000000000000483 <mkdir>:
SYSCALL(mkdir)
 483:	b8 14 00 00 00       	mov    $0x14,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

000000000000048b <chdir>:
SYSCALL(chdir)
 48b:	b8 09 00 00 00       	mov    $0x9,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

0000000000000493 <dup>:
SYSCALL(dup)
 493:	b8 0a 00 00 00       	mov    $0xa,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

000000000000049b <getpid>:
SYSCALL(getpid)
 49b:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

00000000000004a3 <sbrk>:
SYSCALL(sbrk)
 4a3:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

00000000000004ab <sleep>:
SYSCALL(sleep)
 4ab:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

00000000000004b3 <uptime>:
SYSCALL(uptime)
 4b3:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

00000000000004bb <getpinfo>:
SYSCALL(getpinfo)
 4bb:	b8 18 00 00 00       	mov    $0x18,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

00000000000004c3 <settickets>:
SYSCALL(settickets)
 4c3:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

00000000000004cb <getfavnum>:
SYSCALL(getfavnum)
 4cb:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

00000000000004d3 <halt>:
SYSCALL(halt)
 4d3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret

00000000000004db <getcount>:
SYSCALL(getcount)
 4db:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret

00000000000004e3 <killrandom>:
SYSCALL(killrandom)
 4e3:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret

00000000000004eb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4eb:	f3 0f 1e fa          	endbr64
 4ef:	55                   	push   %rbp
 4f0:	48 89 e5             	mov    %rsp,%rbp
 4f3:	48 83 ec 10          	sub    $0x10,%rsp
 4f7:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4fa:	89 f0                	mov    %esi,%eax
 4fc:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4ff:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 503:	8b 45 fc             	mov    -0x4(%rbp),%eax
 506:	ba 01 00 00 00       	mov    $0x1,%edx
 50b:	48 89 ce             	mov    %rcx,%rsi
 50e:	89 c7                	mov    %eax,%edi
 510:	e8 26 ff ff ff       	call   43b <write>
}
 515:	90                   	nop
 516:	c9                   	leave
 517:	c3                   	ret

0000000000000518 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 518:	f3 0f 1e fa          	endbr64
 51c:	55                   	push   %rbp
 51d:	48 89 e5             	mov    %rsp,%rbp
 520:	48 83 ec 30          	sub    $0x30,%rsp
 524:	89 7d dc             	mov    %edi,-0x24(%rbp)
 527:	89 75 d8             	mov    %esi,-0x28(%rbp)
 52a:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 52d:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 530:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 537:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 53b:	74 17                	je     554 <printint+0x3c>
 53d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 541:	79 11                	jns    554 <printint+0x3c>
    neg = 1;
 543:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 54a:	8b 45 d8             	mov    -0x28(%rbp),%eax
 54d:	f7 d8                	neg    %eax
 54f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 552:	eb 06                	jmp    55a <printint+0x42>
  } else {
    x = xx;
 554:	8b 45 d8             	mov    -0x28(%rbp),%eax
 557:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 55a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 561:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 564:	8b 45 f4             	mov    -0xc(%rbp),%eax
 567:	ba 00 00 00 00       	mov    $0x0,%edx
 56c:	f7 f6                	div    %esi
 56e:	89 d1                	mov    %edx,%ecx
 570:	8b 45 fc             	mov    -0x4(%rbp),%eax
 573:	8d 50 01             	lea    0x1(%rax),%edx
 576:	89 55 fc             	mov    %edx,-0x4(%rbp)
 579:	89 ca                	mov    %ecx,%edx
 57b:	0f b6 92 a0 0e 00 00 	movzbl 0xea0(%rdx),%edx
 582:	48 98                	cltq
 584:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 588:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 58b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 58e:	ba 00 00 00 00       	mov    $0x0,%edx
 593:	f7 f7                	div    %edi
 595:	89 45 f4             	mov    %eax,-0xc(%rbp)
 598:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 59c:	75 c3                	jne    561 <printint+0x49>
  if(neg)
 59e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5a2:	74 2b                	je     5cf <printint+0xb7>
    buf[i++] = '-';
 5a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5a7:	8d 50 01             	lea    0x1(%rax),%edx
 5aa:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5ad:	48 98                	cltq
 5af:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5b4:	eb 19                	jmp    5cf <printint+0xb7>
    putc(fd, buf[i]);
 5b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b9:	48 98                	cltq
 5bb:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5c0:	0f be d0             	movsbl %al,%edx
 5c3:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5c6:	89 d6                	mov    %edx,%esi
 5c8:	89 c7                	mov    %eax,%edi
 5ca:	e8 1c ff ff ff       	call   4eb <putc>
  while(--i >= 0)
 5cf:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5d7:	79 dd                	jns    5b6 <printint+0x9e>
}
 5d9:	90                   	nop
 5da:	90                   	nop
 5db:	c9                   	leave
 5dc:	c3                   	ret

00000000000005dd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5dd:	f3 0f 1e fa          	endbr64
 5e1:	55                   	push   %rbp
 5e2:	48 89 e5             	mov    %rsp,%rbp
 5e5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5ec:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5f2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5f9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 600:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 607:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 60e:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 615:	84 c0                	test   %al,%al
 617:	74 20                	je     639 <printf+0x5c>
 619:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 61d:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 621:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 625:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 629:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 62d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 631:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 635:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 639:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 640:	00 00 00 
 643:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 64a:	00 00 00 
 64d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 651:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 658:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 65f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 666:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 66d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 670:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 677:	00 00 00 
 67a:	e9 a8 02 00 00       	jmp    927 <printf+0x34a>
    c = fmt[i] & 0xff;
 67f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 685:	48 63 d0             	movslq %eax,%rdx
 688:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 68f:	48 01 d0             	add    %rdx,%rax
 692:	0f b6 00             	movzbl (%rax),%eax
 695:	0f be c0             	movsbl %al,%eax
 698:	25 ff 00 00 00       	and    $0xff,%eax
 69d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6a3:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6aa:	75 35                	jne    6e1 <printf+0x104>
      if(c == '%'){
 6ac:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6b3:	75 0f                	jne    6c4 <printf+0xe7>
        state = '%';
 6b5:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6bc:	00 00 00 
 6bf:	e9 5c 02 00 00       	jmp    920 <printf+0x343>
      } else {
        putc(fd, c);
 6c4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6ca:	0f be d0             	movsbl %al,%edx
 6cd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6d3:	89 d6                	mov    %edx,%esi
 6d5:	89 c7                	mov    %eax,%edi
 6d7:	e8 0f fe ff ff       	call   4eb <putc>
 6dc:	e9 3f 02 00 00       	jmp    920 <printf+0x343>
      }
    } else if(state == '%'){
 6e1:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6e8:	0f 85 32 02 00 00    	jne    920 <printf+0x343>
      if(c == 'd'){
 6ee:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6f5:	75 5e                	jne    755 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 6f7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6fd:	83 f8 2f             	cmp    $0x2f,%eax
 700:	77 23                	ja     725 <printf+0x148>
 702:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 709:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70f:	89 d2                	mov    %edx,%edx
 711:	48 01 d0             	add    %rdx,%rax
 714:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71a:	83 c2 08             	add    $0x8,%edx
 71d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 723:	eb 12                	jmp    737 <printf+0x15a>
 725:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 72c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 730:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 737:	8b 30                	mov    (%rax),%esi
 739:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 73f:	b9 01 00 00 00       	mov    $0x1,%ecx
 744:	ba 0a 00 00 00       	mov    $0xa,%edx
 749:	89 c7                	mov    %eax,%edi
 74b:	e8 c8 fd ff ff       	call   518 <printint>
 750:	e9 c1 01 00 00       	jmp    916 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 755:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 75c:	74 09                	je     767 <printf+0x18a>
 75e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 765:	75 5e                	jne    7c5 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 767:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 76d:	83 f8 2f             	cmp    $0x2f,%eax
 770:	77 23                	ja     795 <printf+0x1b8>
 772:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 779:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 77f:	89 d2                	mov    %edx,%edx
 781:	48 01 d0             	add    %rdx,%rax
 784:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 78a:	83 c2 08             	add    $0x8,%edx
 78d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 793:	eb 12                	jmp    7a7 <printf+0x1ca>
 795:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 79c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7a0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7a7:	8b 30                	mov    (%rax),%esi
 7a9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7af:	b9 00 00 00 00       	mov    $0x0,%ecx
 7b4:	ba 10 00 00 00       	mov    $0x10,%edx
 7b9:	89 c7                	mov    %eax,%edi
 7bb:	e8 58 fd ff ff       	call   518 <printint>
 7c0:	e9 51 01 00 00       	jmp    916 <printf+0x339>
      } else if(c == 's'){
 7c5:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7cc:	0f 85 98 00 00 00    	jne    86a <printf+0x28d>
        s = va_arg(ap, char*);
 7d2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7d8:	83 f8 2f             	cmp    $0x2f,%eax
 7db:	77 23                	ja     800 <printf+0x223>
 7dd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ea:	89 d2                	mov    %edx,%edx
 7ec:	48 01 d0             	add    %rdx,%rax
 7ef:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f5:	83 c2 08             	add    $0x8,%edx
 7f8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7fe:	eb 12                	jmp    812 <printf+0x235>
 800:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 807:	48 8d 50 08          	lea    0x8(%rax),%rdx
 80b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 812:	48 8b 00             	mov    (%rax),%rax
 815:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 81c:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 823:	00 
 824:	75 31                	jne    857 <printf+0x27a>
          s = "(null)";
 826:	48 c7 85 48 ff ff ff 	movq   $0xc42,-0xb8(%rbp)
 82d:	42 0c 00 00 
        while(*s != 0){
 831:	eb 24                	jmp    857 <printf+0x27a>
          putc(fd, *s);
 833:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 83a:	0f b6 00             	movzbl (%rax),%eax
 83d:	0f be d0             	movsbl %al,%edx
 840:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 846:	89 d6                	mov    %edx,%esi
 848:	89 c7                	mov    %eax,%edi
 84a:	e8 9c fc ff ff       	call   4eb <putc>
          s++;
 84f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 856:	01 
        while(*s != 0){
 857:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 85e:	0f b6 00             	movzbl (%rax),%eax
 861:	84 c0                	test   %al,%al
 863:	75 ce                	jne    833 <printf+0x256>
 865:	e9 ac 00 00 00       	jmp    916 <printf+0x339>
        }
      } else if(c == 'c'){
 86a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 871:	75 56                	jne    8c9 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 873:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 879:	83 f8 2f             	cmp    $0x2f,%eax
 87c:	77 23                	ja     8a1 <printf+0x2c4>
 87e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 885:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 88b:	89 d2                	mov    %edx,%edx
 88d:	48 01 d0             	add    %rdx,%rax
 890:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 896:	83 c2 08             	add    $0x8,%edx
 899:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 89f:	eb 12                	jmp    8b3 <printf+0x2d6>
 8a1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8a8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8ac:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8b3:	8b 00                	mov    (%rax),%eax
 8b5:	0f be d0             	movsbl %al,%edx
 8b8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8be:	89 d6                	mov    %edx,%esi
 8c0:	89 c7                	mov    %eax,%edi
 8c2:	e8 24 fc ff ff       	call   4eb <putc>
 8c7:	eb 4d                	jmp    916 <printf+0x339>
      } else if(c == '%'){
 8c9:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8d0:	75 1a                	jne    8ec <printf+0x30f>
        putc(fd, c);
 8d2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8d8:	0f be d0             	movsbl %al,%edx
 8db:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8e1:	89 d6                	mov    %edx,%esi
 8e3:	89 c7                	mov    %eax,%edi
 8e5:	e8 01 fc ff ff       	call   4eb <putc>
 8ea:	eb 2a                	jmp    916 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ec:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8f2:	be 25 00 00 00       	mov    $0x25,%esi
 8f7:	89 c7                	mov    %eax,%edi
 8f9:	e8 ed fb ff ff       	call   4eb <putc>
        putc(fd, c);
 8fe:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 904:	0f be d0             	movsbl %al,%edx
 907:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 90d:	89 d6                	mov    %edx,%esi
 90f:	89 c7                	mov    %eax,%edi
 911:	e8 d5 fb ff ff       	call   4eb <putc>
      }
      state = 0;
 916:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 91d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 920:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 927:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 92d:	48 63 d0             	movslq %eax,%rdx
 930:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 937:	48 01 d0             	add    %rdx,%rax
 93a:	0f b6 00             	movzbl (%rax),%eax
 93d:	84 c0                	test   %al,%al
 93f:	0f 85 3a fd ff ff    	jne    67f <printf+0xa2>
    }
  }
}
 945:	90                   	nop
 946:	90                   	nop
 947:	c9                   	leave
 948:	c3                   	ret

0000000000000949 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 949:	f3 0f 1e fa          	endbr64
 94d:	55                   	push   %rbp
 94e:	48 89 e5             	mov    %rsp,%rbp
 951:	48 83 ec 18          	sub    $0x18,%rsp
 955:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 959:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 95d:	48 83 e8 10          	sub    $0x10,%rax
 961:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 965:	48 8b 05 64 05 00 00 	mov    0x564(%rip),%rax        # ed0 <freep>
 96c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 970:	eb 2f                	jmp    9a1 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 972:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 976:	48 8b 00             	mov    (%rax),%rax
 979:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 97d:	72 17                	jb     996 <free+0x4d>
 97f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 983:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 987:	72 2f                	jb     9b8 <free+0x6f>
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	48 8b 00             	mov    (%rax),%rax
 990:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 994:	72 22                	jb     9b8 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 996:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99a:	48 8b 00             	mov    (%rax),%rax
 99d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9a9:	73 c7                	jae    972 <free+0x29>
 9ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9af:	48 8b 00             	mov    (%rax),%rax
 9b2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9b6:	73 ba                	jae    972 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9bc:	8b 40 08             	mov    0x8(%rax),%eax
 9bf:	89 c0                	mov    %eax,%eax
 9c1:	48 c1 e0 04          	shl    $0x4,%rax
 9c5:	48 89 c2             	mov    %rax,%rdx
 9c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9cc:	48 01 c2             	add    %rax,%rdx
 9cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d3:	48 8b 00             	mov    (%rax),%rax
 9d6:	48 39 c2             	cmp    %rax,%rdx
 9d9:	75 2d                	jne    a08 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9df:	8b 50 08             	mov    0x8(%rax),%edx
 9e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e6:	48 8b 00             	mov    (%rax),%rax
 9e9:	8b 40 08             	mov    0x8(%rax),%eax
 9ec:	01 c2                	add    %eax,%edx
 9ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f2:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f9:	48 8b 00             	mov    (%rax),%rax
 9fc:	48 8b 10             	mov    (%rax),%rdx
 9ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a03:	48 89 10             	mov    %rdx,(%rax)
 a06:	eb 0e                	jmp    a16 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 a08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a0c:	48 8b 10             	mov    (%rax),%rdx
 a0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a13:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1a:	8b 40 08             	mov    0x8(%rax),%eax
 a1d:	89 c0                	mov    %eax,%eax
 a1f:	48 c1 e0 04          	shl    $0x4,%rax
 a23:	48 89 c2             	mov    %rax,%rdx
 a26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a2a:	48 01 d0             	add    %rdx,%rax
 a2d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a31:	75 27                	jne    a5a <free+0x111>
    p->s.size += bp->s.size;
 a33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a37:	8b 50 08             	mov    0x8(%rax),%edx
 a3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3e:	8b 40 08             	mov    0x8(%rax),%eax
 a41:	01 c2                	add    %eax,%edx
 a43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a47:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a4e:	48 8b 10             	mov    (%rax),%rdx
 a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a55:	48 89 10             	mov    %rdx,(%rax)
 a58:	eb 0b                	jmp    a65 <free+0x11c>
  } else
    p->s.ptr = bp;
 a5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a62:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a69:	48 89 05 60 04 00 00 	mov    %rax,0x460(%rip)        # ed0 <freep>
}
 a70:	90                   	nop
 a71:	c9                   	leave
 a72:	c3                   	ret

0000000000000a73 <morecore>:

static Header*
morecore(uint nu)
{
 a73:	f3 0f 1e fa          	endbr64
 a77:	55                   	push   %rbp
 a78:	48 89 e5             	mov    %rsp,%rbp
 a7b:	48 83 ec 20          	sub    $0x20,%rsp
 a7f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a82:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a89:	77 07                	ja     a92 <morecore+0x1f>
    nu = 4096;
 a8b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a92:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a95:	c1 e0 04             	shl    $0x4,%eax
 a98:	89 c7                	mov    %eax,%edi
 a9a:	e8 04 fa ff ff       	call   4a3 <sbrk>
 a9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 aa3:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 aa8:	75 07                	jne    ab1 <morecore+0x3e>
    return 0;
 aaa:	b8 00 00 00 00       	mov    $0x0,%eax
 aaf:	eb 29                	jmp    ada <morecore+0x67>
  hp = (Header*)p;
 ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 ab9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 abd:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ac0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 ac3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac7:	48 83 c0 10          	add    $0x10,%rax
 acb:	48 89 c7             	mov    %rax,%rdi
 ace:	e8 76 fe ff ff       	call   949 <free>
  return freep;
 ad3:	48 8b 05 f6 03 00 00 	mov    0x3f6(%rip),%rax        # ed0 <freep>
}
 ada:	c9                   	leave
 adb:	c3                   	ret

0000000000000adc <malloc>:

void*
malloc(uint nbytes)
{
 adc:	f3 0f 1e fa          	endbr64
 ae0:	55                   	push   %rbp
 ae1:	48 89 e5             	mov    %rsp,%rbp
 ae4:	48 83 ec 30          	sub    $0x30,%rsp
 ae8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aeb:	8b 45 dc             	mov    -0x24(%rbp),%eax
 aee:	48 83 c0 0f          	add    $0xf,%rax
 af2:	48 c1 e8 04          	shr    $0x4,%rax
 af6:	83 c0 01             	add    $0x1,%eax
 af9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 afc:	48 8b 05 cd 03 00 00 	mov    0x3cd(%rip),%rax        # ed0 <freep>
 b03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b07:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b0c:	75 2b                	jne    b39 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 b0e:	48 c7 45 f0 c0 0e 00 	movq   $0xec0,-0x10(%rbp)
 b15:	00 
 b16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1a:	48 89 05 af 03 00 00 	mov    %rax,0x3af(%rip)        # ed0 <freep>
 b21:	48 8b 05 a8 03 00 00 	mov    0x3a8(%rip),%rax        # ed0 <freep>
 b28:	48 89 05 91 03 00 00 	mov    %rax,0x391(%rip)        # ec0 <base>
    base.s.size = 0;
 b2f:	c7 05 8f 03 00 00 00 	movl   $0x0,0x38f(%rip)        # ec8 <base+0x8>
 b36:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b3d:	48 8b 00             	mov    (%rax),%rax
 b40:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b48:	8b 40 08             	mov    0x8(%rax),%eax
 b4b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b4e:	72 5f                	jb     baf <malloc+0xd3>
      if(p->s.size == nunits)
 b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b54:	8b 40 08             	mov    0x8(%rax),%eax
 b57:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b5a:	75 10                	jne    b6c <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b60:	48 8b 10             	mov    (%rax),%rdx
 b63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b67:	48 89 10             	mov    %rdx,(%rax)
 b6a:	eb 2e                	jmp    b9a <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b70:	8b 40 08             	mov    0x8(%rax),%eax
 b73:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b76:	89 c2                	mov    %eax,%edx
 b78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7c:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b83:	8b 40 08             	mov    0x8(%rax),%eax
 b86:	89 c0                	mov    %eax,%eax
 b88:	48 c1 e0 04          	shl    $0x4,%rax
 b8c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b94:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b97:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9e:	48 89 05 2b 03 00 00 	mov    %rax,0x32b(%rip)        # ed0 <freep>
      return (void*)(p + 1);
 ba5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba9:	48 83 c0 10          	add    $0x10,%rax
 bad:	eb 41                	jmp    bf0 <malloc+0x114>
    }
    if(p == freep)
 baf:	48 8b 05 1a 03 00 00 	mov    0x31a(%rip),%rax        # ed0 <freep>
 bb6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bba:	75 1c                	jne    bd8 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 bbc:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bbf:	89 c7                	mov    %eax,%edi
 bc1:	e8 ad fe ff ff       	call   a73 <morecore>
 bc6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bca:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bcf:	75 07                	jne    bd8 <malloc+0xfc>
        return 0;
 bd1:	b8 00 00 00 00       	mov    $0x0,%eax
 bd6:	eb 18                	jmp    bf0 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bdc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be4:	48 8b 00             	mov    (%rax),%rax
 be7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 beb:	e9 54 ff ff ff       	jmp    b44 <malloc+0x68>
  }
}
 bf0:	c9                   	leave
 bf1:	c3                   	ret
