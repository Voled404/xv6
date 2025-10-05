
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
  11:	48 c7 c7 d5 0b 00 00 	mov    $0xbd5,%rdi
  18:	e8 3e 04 00 00       	call   45b <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 27                	jns    48 <main+0x48>
    mknod("console", 1, 1);
  21:	ba 01 00 00 00       	mov    $0x1,%edx
  26:	be 01 00 00 00       	mov    $0x1,%esi
  2b:	48 c7 c7 d5 0b 00 00 	mov    $0xbd5,%rdi
  32:	e8 2c 04 00 00       	call   463 <mknod>
    open("console", O_RDWR);
  37:	be 02 00 00 00       	mov    $0x2,%esi
  3c:	48 c7 c7 d5 0b 00 00 	mov    $0xbd5,%rdi
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
  5c:	48 c7 c6 dd 0b 00 00 	mov    $0xbdd,%rsi
  63:	bf 01 00 00 00       	mov    $0x1,%edi
  68:	b8 00 00 00 00       	mov    $0x0,%eax
  6d:	e8 4b 05 00 00       	call   5bd <printf>
    pid = fork();
  72:	e8 9c 03 00 00       	call   413 <fork>
  77:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
  7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  7e:	79 1b                	jns    9b <main+0x9b>
      printf(1, "init: fork failed\n");
  80:	48 c7 c6 f0 0b 00 00 	mov    $0xbf0,%rsi
  87:	bf 01 00 00 00       	mov    $0x1,%edi
  8c:	b8 00 00 00 00       	mov    $0x0,%eax
  91:	e8 27 05 00 00       	call   5bd <printf>
      exit();
  96:	e8 80 03 00 00       	call   41b <exit>
    }
    if(pid == 0){
  9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  9f:	75 44                	jne    e5 <main+0xe5>
      exec("sh", argv);
  a1:	48 c7 c6 70 0e 00 00 	mov    $0xe70,%rsi
  a8:	48 c7 c7 d2 0b 00 00 	mov    $0xbd2,%rdi
  af:	e8 9f 03 00 00       	call   453 <exec>
      printf(1, "init: exec sh failed\n");
  b4:	48 c7 c6 03 0c 00 00 	mov    $0xc03,%rsi
  bb:	bf 01 00 00 00       	mov    $0x1,%edi
  c0:	b8 00 00 00 00       	mov    $0x0,%eax
  c5:	e8 f3 04 00 00       	call   5bd <printf>
      exit();
  ca:	e8 4c 03 00 00       	call   41b <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  cf:	48 c7 c6 19 0c 00 00 	mov    $0xc19,%rsi
  d6:	bf 01 00 00 00       	mov    $0x1,%edi
  db:	b8 00 00 00 00       	mov    $0x0,%eax
  e0:	e8 d8 04 00 00       	call   5bd <printf>
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

00000000000004cb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4cb:	f3 0f 1e fa          	endbr64
 4cf:	55                   	push   %rbp
 4d0:	48 89 e5             	mov    %rsp,%rbp
 4d3:	48 83 ec 10          	sub    $0x10,%rsp
 4d7:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4da:	89 f0                	mov    %esi,%eax
 4dc:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4df:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e6:	ba 01 00 00 00       	mov    $0x1,%edx
 4eb:	48 89 ce             	mov    %rcx,%rsi
 4ee:	89 c7                	mov    %eax,%edi
 4f0:	e8 46 ff ff ff       	call   43b <write>
}
 4f5:	90                   	nop
 4f6:	c9                   	leave
 4f7:	c3                   	ret

00000000000004f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f8:	f3 0f 1e fa          	endbr64
 4fc:	55                   	push   %rbp
 4fd:	48 89 e5             	mov    %rsp,%rbp
 500:	48 83 ec 30          	sub    $0x30,%rsp
 504:	89 7d dc             	mov    %edi,-0x24(%rbp)
 507:	89 75 d8             	mov    %esi,-0x28(%rbp)
 50a:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 50d:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 510:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 517:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 51b:	74 17                	je     534 <printint+0x3c>
 51d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 521:	79 11                	jns    534 <printint+0x3c>
    neg = 1;
 523:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 52a:	8b 45 d8             	mov    -0x28(%rbp),%eax
 52d:	f7 d8                	neg    %eax
 52f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 532:	eb 06                	jmp    53a <printint+0x42>
  } else {
    x = xx;
 534:	8b 45 d8             	mov    -0x28(%rbp),%eax
 537:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 53a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 541:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 544:	8b 45 f4             	mov    -0xc(%rbp),%eax
 547:	ba 00 00 00 00       	mov    $0x0,%edx
 54c:	f7 f6                	div    %esi
 54e:	89 d1                	mov    %edx,%ecx
 550:	8b 45 fc             	mov    -0x4(%rbp),%eax
 553:	8d 50 01             	lea    0x1(%rax),%edx
 556:	89 55 fc             	mov    %edx,-0x4(%rbp)
 559:	89 ca                	mov    %ecx,%edx
 55b:	0f b6 92 80 0e 00 00 	movzbl 0xe80(%rdx),%edx
 562:	48 98                	cltq
 564:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 568:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 56b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 56e:	ba 00 00 00 00       	mov    $0x0,%edx
 573:	f7 f7                	div    %edi
 575:	89 45 f4             	mov    %eax,-0xc(%rbp)
 578:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 57c:	75 c3                	jne    541 <printint+0x49>
  if(neg)
 57e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 582:	74 2b                	je     5af <printint+0xb7>
    buf[i++] = '-';
 584:	8b 45 fc             	mov    -0x4(%rbp),%eax
 587:	8d 50 01             	lea    0x1(%rax),%edx
 58a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 58d:	48 98                	cltq
 58f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 594:	eb 19                	jmp    5af <printint+0xb7>
    putc(fd, buf[i]);
 596:	8b 45 fc             	mov    -0x4(%rbp),%eax
 599:	48 98                	cltq
 59b:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5a0:	0f be d0             	movsbl %al,%edx
 5a3:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5a6:	89 d6                	mov    %edx,%esi
 5a8:	89 c7                	mov    %eax,%edi
 5aa:	e8 1c ff ff ff       	call   4cb <putc>
  while(--i >= 0)
 5af:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5b7:	79 dd                	jns    596 <printint+0x9e>
}
 5b9:	90                   	nop
 5ba:	90                   	nop
 5bb:	c9                   	leave
 5bc:	c3                   	ret

00000000000005bd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5bd:	f3 0f 1e fa          	endbr64
 5c1:	55                   	push   %rbp
 5c2:	48 89 e5             	mov    %rsp,%rbp
 5c5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5cc:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5d2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5d9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5e0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5e7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5ee:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5f5:	84 c0                	test   %al,%al
 5f7:	74 20                	je     619 <printf+0x5c>
 5f9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5fd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 601:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 605:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 609:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 60d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 611:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 615:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 619:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 620:	00 00 00 
 623:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 62a:	00 00 00 
 62d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 631:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 638:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 63f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 646:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 64d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 650:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 657:	00 00 00 
 65a:	e9 a8 02 00 00       	jmp    907 <printf+0x34a>
    c = fmt[i] & 0xff;
 65f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 665:	48 63 d0             	movslq %eax,%rdx
 668:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 66f:	48 01 d0             	add    %rdx,%rax
 672:	0f b6 00             	movzbl (%rax),%eax
 675:	0f be c0             	movsbl %al,%eax
 678:	25 ff 00 00 00       	and    $0xff,%eax
 67d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 683:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 68a:	75 35                	jne    6c1 <printf+0x104>
      if(c == '%'){
 68c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 693:	75 0f                	jne    6a4 <printf+0xe7>
        state = '%';
 695:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 69c:	00 00 00 
 69f:	e9 5c 02 00 00       	jmp    900 <printf+0x343>
      } else {
        putc(fd, c);
 6a4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6aa:	0f be d0             	movsbl %al,%edx
 6ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b3:	89 d6                	mov    %edx,%esi
 6b5:	89 c7                	mov    %eax,%edi
 6b7:	e8 0f fe ff ff       	call   4cb <putc>
 6bc:	e9 3f 02 00 00       	jmp    900 <printf+0x343>
      }
    } else if(state == '%'){
 6c1:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6c8:	0f 85 32 02 00 00    	jne    900 <printf+0x343>
      if(c == 'd'){
 6ce:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6d5:	75 5e                	jne    735 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 6d7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6dd:	83 f8 2f             	cmp    $0x2f,%eax
 6e0:	77 23                	ja     705 <printf+0x148>
 6e2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6e9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ef:	89 d2                	mov    %edx,%edx
 6f1:	48 01 d0             	add    %rdx,%rax
 6f4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fa:	83 c2 08             	add    $0x8,%edx
 6fd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 703:	eb 12                	jmp    717 <printf+0x15a>
 705:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 70c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 710:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 717:	8b 30                	mov    (%rax),%esi
 719:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 71f:	b9 01 00 00 00       	mov    $0x1,%ecx
 724:	ba 0a 00 00 00       	mov    $0xa,%edx
 729:	89 c7                	mov    %eax,%edi
 72b:	e8 c8 fd ff ff       	call   4f8 <printint>
 730:	e9 c1 01 00 00       	jmp    8f6 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 735:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 73c:	74 09                	je     747 <printf+0x18a>
 73e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 745:	75 5e                	jne    7a5 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 747:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74d:	83 f8 2f             	cmp    $0x2f,%eax
 750:	77 23                	ja     775 <printf+0x1b8>
 752:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 759:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 75f:	89 d2                	mov    %edx,%edx
 761:	48 01 d0             	add    %rdx,%rax
 764:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76a:	83 c2 08             	add    $0x8,%edx
 76d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 773:	eb 12                	jmp    787 <printf+0x1ca>
 775:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 780:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 787:	8b 30                	mov    (%rax),%esi
 789:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 78f:	b9 00 00 00 00       	mov    $0x0,%ecx
 794:	ba 10 00 00 00       	mov    $0x10,%edx
 799:	89 c7                	mov    %eax,%edi
 79b:	e8 58 fd ff ff       	call   4f8 <printint>
 7a0:	e9 51 01 00 00       	jmp    8f6 <printf+0x339>
      } else if(c == 's'){
 7a5:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7ac:	0f 85 98 00 00 00    	jne    84a <printf+0x28d>
        s = va_arg(ap, char*);
 7b2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7b8:	83 f8 2f             	cmp    $0x2f,%eax
 7bb:	77 23                	ja     7e0 <printf+0x223>
 7bd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7c4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ca:	89 d2                	mov    %edx,%edx
 7cc:	48 01 d0             	add    %rdx,%rax
 7cf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d5:	83 c2 08             	add    $0x8,%edx
 7d8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7de:	eb 12                	jmp    7f2 <printf+0x235>
 7e0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7e7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7eb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7f2:	48 8b 00             	mov    (%rax),%rax
 7f5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7fc:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 803:	00 
 804:	75 31                	jne    837 <printf+0x27a>
          s = "(null)";
 806:	48 c7 85 48 ff ff ff 	movq   $0xc22,-0xb8(%rbp)
 80d:	22 0c 00 00 
        while(*s != 0){
 811:	eb 24                	jmp    837 <printf+0x27a>
          putc(fd, *s);
 813:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 81a:	0f b6 00             	movzbl (%rax),%eax
 81d:	0f be d0             	movsbl %al,%edx
 820:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 826:	89 d6                	mov    %edx,%esi
 828:	89 c7                	mov    %eax,%edi
 82a:	e8 9c fc ff ff       	call   4cb <putc>
          s++;
 82f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 836:	01 
        while(*s != 0){
 837:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 83e:	0f b6 00             	movzbl (%rax),%eax
 841:	84 c0                	test   %al,%al
 843:	75 ce                	jne    813 <printf+0x256>
 845:	e9 ac 00 00 00       	jmp    8f6 <printf+0x339>
        }
      } else if(c == 'c'){
 84a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 851:	75 56                	jne    8a9 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 853:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 859:	83 f8 2f             	cmp    $0x2f,%eax
 85c:	77 23                	ja     881 <printf+0x2c4>
 85e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 865:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 86b:	89 d2                	mov    %edx,%edx
 86d:	48 01 d0             	add    %rdx,%rax
 870:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 876:	83 c2 08             	add    $0x8,%edx
 879:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 87f:	eb 12                	jmp    893 <printf+0x2d6>
 881:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 888:	48 8d 50 08          	lea    0x8(%rax),%rdx
 88c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 893:	8b 00                	mov    (%rax),%eax
 895:	0f be d0             	movsbl %al,%edx
 898:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 89e:	89 d6                	mov    %edx,%esi
 8a0:	89 c7                	mov    %eax,%edi
 8a2:	e8 24 fc ff ff       	call   4cb <putc>
 8a7:	eb 4d                	jmp    8f6 <printf+0x339>
      } else if(c == '%'){
 8a9:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8b0:	75 1a                	jne    8cc <printf+0x30f>
        putc(fd, c);
 8b2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8b8:	0f be d0             	movsbl %al,%edx
 8bb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8c1:	89 d6                	mov    %edx,%esi
 8c3:	89 c7                	mov    %eax,%edi
 8c5:	e8 01 fc ff ff       	call   4cb <putc>
 8ca:	eb 2a                	jmp    8f6 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8d2:	be 25 00 00 00       	mov    $0x25,%esi
 8d7:	89 c7                	mov    %eax,%edi
 8d9:	e8 ed fb ff ff       	call   4cb <putc>
        putc(fd, c);
 8de:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8e4:	0f be d0             	movsbl %al,%edx
 8e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ed:	89 d6                	mov    %edx,%esi
 8ef:	89 c7                	mov    %eax,%edi
 8f1:	e8 d5 fb ff ff       	call   4cb <putc>
      }
      state = 0;
 8f6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8fd:	00 00 00 
  for(i = 0; fmt[i]; i++){
 900:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 907:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 90d:	48 63 d0             	movslq %eax,%rdx
 910:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 917:	48 01 d0             	add    %rdx,%rax
 91a:	0f b6 00             	movzbl (%rax),%eax
 91d:	84 c0                	test   %al,%al
 91f:	0f 85 3a fd ff ff    	jne    65f <printf+0xa2>
    }
  }
}
 925:	90                   	nop
 926:	90                   	nop
 927:	c9                   	leave
 928:	c3                   	ret

0000000000000929 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 929:	f3 0f 1e fa          	endbr64
 92d:	55                   	push   %rbp
 92e:	48 89 e5             	mov    %rsp,%rbp
 931:	48 83 ec 18          	sub    $0x18,%rsp
 935:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 939:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 93d:	48 83 e8 10          	sub    $0x10,%rax
 941:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 945:	48 8b 05 64 05 00 00 	mov    0x564(%rip),%rax        # eb0 <freep>
 94c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 950:	eb 2f                	jmp    981 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 956:	48 8b 00             	mov    (%rax),%rax
 959:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 95d:	72 17                	jb     976 <free+0x4d>
 95f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 963:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 967:	72 2f                	jb     998 <free+0x6f>
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 8b 00             	mov    (%rax),%rax
 970:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 974:	72 22                	jb     998 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 976:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97a:	48 8b 00             	mov    (%rax),%rax
 97d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 981:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 985:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 989:	73 c7                	jae    952 <free+0x29>
 98b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98f:	48 8b 00             	mov    (%rax),%rax
 992:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 996:	73 ba                	jae    952 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 998:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99c:	8b 40 08             	mov    0x8(%rax),%eax
 99f:	89 c0                	mov    %eax,%eax
 9a1:	48 c1 e0 04          	shl    $0x4,%rax
 9a5:	48 89 c2             	mov    %rax,%rdx
 9a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ac:	48 01 c2             	add    %rax,%rdx
 9af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b3:	48 8b 00             	mov    (%rax),%rax
 9b6:	48 39 c2             	cmp    %rax,%rdx
 9b9:	75 2d                	jne    9e8 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 9bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9bf:	8b 50 08             	mov    0x8(%rax),%edx
 9c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c6:	48 8b 00             	mov    (%rax),%rax
 9c9:	8b 40 08             	mov    0x8(%rax),%eax
 9cc:	01 c2                	add    %eax,%edx
 9ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d2:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d9:	48 8b 00             	mov    (%rax),%rax
 9dc:	48 8b 10             	mov    (%rax),%rdx
 9df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e3:	48 89 10             	mov    %rdx,(%rax)
 9e6:	eb 0e                	jmp    9f6 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 9e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ec:	48 8b 10             	mov    (%rax),%rdx
 9ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f3:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fa:	8b 40 08             	mov    0x8(%rax),%eax
 9fd:	89 c0                	mov    %eax,%eax
 9ff:	48 c1 e0 04          	shl    $0x4,%rax
 a03:	48 89 c2             	mov    %rax,%rdx
 a06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a0a:	48 01 d0             	add    %rdx,%rax
 a0d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a11:	75 27                	jne    a3a <free+0x111>
    p->s.size += bp->s.size;
 a13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a17:	8b 50 08             	mov    0x8(%rax),%edx
 a1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1e:	8b 40 08             	mov    0x8(%rax),%eax
 a21:	01 c2                	add    %eax,%edx
 a23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a27:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2e:	48 8b 10             	mov    (%rax),%rdx
 a31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a35:	48 89 10             	mov    %rdx,(%rax)
 a38:	eb 0b                	jmp    a45 <free+0x11c>
  } else
    p->s.ptr = bp;
 a3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a42:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a49:	48 89 05 60 04 00 00 	mov    %rax,0x460(%rip)        # eb0 <freep>
}
 a50:	90                   	nop
 a51:	c9                   	leave
 a52:	c3                   	ret

0000000000000a53 <morecore>:

static Header*
morecore(uint nu)
{
 a53:	f3 0f 1e fa          	endbr64
 a57:	55                   	push   %rbp
 a58:	48 89 e5             	mov    %rsp,%rbp
 a5b:	48 83 ec 20          	sub    $0x20,%rsp
 a5f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a62:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a69:	77 07                	ja     a72 <morecore+0x1f>
    nu = 4096;
 a6b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a72:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a75:	c1 e0 04             	shl    $0x4,%eax
 a78:	89 c7                	mov    %eax,%edi
 a7a:	e8 24 fa ff ff       	call   4a3 <sbrk>
 a7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a83:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a88:	75 07                	jne    a91 <morecore+0x3e>
    return 0;
 a8a:	b8 00 00 00 00       	mov    $0x0,%eax
 a8f:	eb 29                	jmp    aba <morecore+0x67>
  hp = (Header*)p;
 a91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aa0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 aa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa7:	48 83 c0 10          	add    $0x10,%rax
 aab:	48 89 c7             	mov    %rax,%rdi
 aae:	e8 76 fe ff ff       	call   929 <free>
  return freep;
 ab3:	48 8b 05 f6 03 00 00 	mov    0x3f6(%rip),%rax        # eb0 <freep>
}
 aba:	c9                   	leave
 abb:	c3                   	ret

0000000000000abc <malloc>:

void*
malloc(uint nbytes)
{
 abc:	f3 0f 1e fa          	endbr64
 ac0:	55                   	push   %rbp
 ac1:	48 89 e5             	mov    %rsp,%rbp
 ac4:	48 83 ec 30          	sub    $0x30,%rsp
 ac8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 acb:	8b 45 dc             	mov    -0x24(%rbp),%eax
 ace:	48 83 c0 0f          	add    $0xf,%rax
 ad2:	48 c1 e8 04          	shr    $0x4,%rax
 ad6:	83 c0 01             	add    $0x1,%eax
 ad9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 adc:	48 8b 05 cd 03 00 00 	mov    0x3cd(%rip),%rax        # eb0 <freep>
 ae3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ae7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 aec:	75 2b                	jne    b19 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 aee:	48 c7 45 f0 a0 0e 00 	movq   $0xea0,-0x10(%rbp)
 af5:	00 
 af6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 afa:	48 89 05 af 03 00 00 	mov    %rax,0x3af(%rip)        # eb0 <freep>
 b01:	48 8b 05 a8 03 00 00 	mov    0x3a8(%rip),%rax        # eb0 <freep>
 b08:	48 89 05 91 03 00 00 	mov    %rax,0x391(%rip)        # ea0 <base>
    base.s.size = 0;
 b0f:	c7 05 8f 03 00 00 00 	movl   $0x0,0x38f(%rip)        # ea8 <base+0x8>
 b16:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1d:	48 8b 00             	mov    (%rax),%rax
 b20:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b28:	8b 40 08             	mov    0x8(%rax),%eax
 b2b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b2e:	72 5f                	jb     b8f <malloc+0xd3>
      if(p->s.size == nunits)
 b30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b34:	8b 40 08             	mov    0x8(%rax),%eax
 b37:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b3a:	75 10                	jne    b4c <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 b3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b40:	48 8b 10             	mov    (%rax),%rdx
 b43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b47:	48 89 10             	mov    %rdx,(%rax)
 b4a:	eb 2e                	jmp    b7a <malloc+0xbe>
      else {
        p->s.size -= nunits;
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	8b 40 08             	mov    0x8(%rax),%eax
 b53:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b56:	89 c2                	mov    %eax,%edx
 b58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5c:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b63:	8b 40 08             	mov    0x8(%rax),%eax
 b66:	89 c0                	mov    %eax,%eax
 b68:	48 c1 e0 04          	shl    $0x4,%rax
 b6c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b74:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b77:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b7e:	48 89 05 2b 03 00 00 	mov    %rax,0x32b(%rip)        # eb0 <freep>
      return (void*)(p + 1);
 b85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b89:	48 83 c0 10          	add    $0x10,%rax
 b8d:	eb 41                	jmp    bd0 <malloc+0x114>
    }
    if(p == freep)
 b8f:	48 8b 05 1a 03 00 00 	mov    0x31a(%rip),%rax        # eb0 <freep>
 b96:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b9a:	75 1c                	jne    bb8 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 b9c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b9f:	89 c7                	mov    %eax,%edi
 ba1:	e8 ad fe ff ff       	call   a53 <morecore>
 ba6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 baa:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 baf:	75 07                	jne    bb8 <malloc+0xfc>
        return 0;
 bb1:	b8 00 00 00 00       	mov    $0x0,%eax
 bb6:	eb 18                	jmp    bd0 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc4:	48 8b 00             	mov    (%rax),%rax
 bc7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bcb:	e9 54 ff ff ff       	jmp    b24 <malloc+0x68>
  }
}
 bd0:	c9                   	leave
 bd1:	c3                   	ret
