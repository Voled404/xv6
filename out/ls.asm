
fs/ls:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	53                   	push   %rbx
   9:	48 83 ec 28          	sub    $0x28,%rsp
   d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  11:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  15:	48 89 c7             	mov    %rax,%rdi
  18:	e8 68 04 00 00       	call   485 <strlen>
  1d:	89 c2                	mov    %eax,%edx
  1f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  23:	48 01 d0             	add    %rdx,%rax
  26:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  2a:	eb 05                	jmp    31 <fmtname+0x31>
  2c:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  35:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  39:	72 0b                	jb     46 <fmtname+0x46>
  3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  3f:	0f b6 00             	movzbl (%rax),%eax
  42:	3c 2f                	cmp    $0x2f,%al
  44:	75 e6                	jne    2c <fmtname+0x2c>
    ;
  p++;
  46:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4f:	48 89 c7             	mov    %rax,%rdi
  52:	e8 2e 04 00 00       	call   485 <strlen>
  57:	83 f8 0d             	cmp    $0xd,%eax
  5a:	76 06                	jbe    62 <fmtname+0x62>
    return p;
  5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  60:	eb 60                	jmp    c2 <fmtname+0xc2>
  memmove(buf, p, strlen(p));
  62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  66:	48 89 c7             	mov    %rax,%rdi
  69:	e8 17 04 00 00       	call   485 <strlen>
  6e:	89 c2                	mov    %eax,%edx
  70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  74:	48 89 c6             	mov    %rax,%rsi
  77:	48 c7 c7 90 11 00 00 	mov    $0x1190,%rdi
  7e:	e8 e4 05 00 00       	call   667 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  87:	48 89 c7             	mov    %rax,%rdi
  8a:	e8 f6 03 00 00       	call   485 <strlen>
  8f:	ba 0e 00 00 00       	mov    $0xe,%edx
  94:	89 d3                	mov    %edx,%ebx
  96:	29 c3                	sub    %eax,%ebx
  98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  9c:	48 89 c7             	mov    %rax,%rdi
  9f:	e8 e1 03 00 00       	call   485 <strlen>
  a4:	89 c0                	mov    %eax,%eax
  a6:	48 05 90 11 00 00    	add    $0x1190,%rax
  ac:	89 da                	mov    %ebx,%edx
  ae:	be 20 00 00 00       	mov    $0x20,%esi
  b3:	48 89 c7             	mov    %rax,%rdi
  b6:	e8 00 04 00 00       	call   4bb <memset>
  return buf;
  bb:	48 c7 c0 90 11 00 00 	mov    $0x1190,%rax
}
  c2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  c6:	c9                   	leave
  c7:	c3                   	ret

00000000000000c8 <ls>:

void
ls(char *path)
{
  c8:	f3 0f 1e fa          	endbr64
  cc:	55                   	push   %rbp
  cd:	48 89 e5             	mov    %rsp,%rbp
  d0:	41 55                	push   %r13
  d2:	41 54                	push   %r12
  d4:	53                   	push   %rbx
  d5:	48 81 ec 58 02 00 00 	sub    $0x258,%rsp
  dc:	48 89 bd 98 fd ff ff 	mov    %rdi,-0x268(%rbp)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  e3:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
  ea:	be 00 00 00 00       	mov    $0x0,%esi
  ef:	48 89 c7             	mov    %rax,%rdi
  f2:	e8 11 06 00 00       	call   708 <open>
  f7:	89 45 dc             	mov    %eax,-0x24(%rbp)
  fa:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  fe:	79 25                	jns    125 <ls+0x5d>
    printf(2, "ls: cannot open %s\n", path);
 100:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 107:	48 89 c2             	mov    %rax,%rdx
 10a:	48 c7 c6 97 0e 00 00 	mov    $0xe97,%rsi
 111:	bf 02 00 00 00       	mov    $0x2,%edi
 116:	b8 00 00 00 00       	mov    $0x0,%eax
 11b:	e8 62 07 00 00       	call   882 <printf>
    return;
 120:	e9 1b 02 00 00       	jmp    340 <ls+0x278>
  }
  
  if(fstat(fd, &st) < 0){
 125:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
 12c:	8b 45 dc             	mov    -0x24(%rbp),%eax
 12f:	48 89 d6             	mov    %rdx,%rsi
 132:	89 c7                	mov    %eax,%edi
 134:	e8 e7 05 00 00       	call   720 <fstat>
 139:	85 c0                	test   %eax,%eax
 13b:	79 2f                	jns    16c <ls+0xa4>
    printf(2, "ls: cannot stat %s\n", path);
 13d:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 144:	48 89 c2             	mov    %rax,%rdx
 147:	48 c7 c6 ab 0e 00 00 	mov    $0xeab,%rsi
 14e:	bf 02 00 00 00       	mov    $0x2,%edi
 153:	b8 00 00 00 00       	mov    $0x0,%eax
 158:	e8 25 07 00 00       	call   882 <printf>
    close(fd);
 15d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 160:	89 c7                	mov    %eax,%edi
 162:	e8 89 05 00 00       	call   6f0 <close>
    return;
 167:	e9 d4 01 00 00       	jmp    340 <ls+0x278>
  }
  
  switch(st.type){
 16c:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 173:	98                   	cwtl
 174:	83 f8 01             	cmp    $0x1,%eax
 177:	74 56                	je     1cf <ls+0x107>
 179:	83 f8 02             	cmp    $0x2,%eax
 17c:	0f 85 b4 01 00 00    	jne    336 <ls+0x26e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 182:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
 189:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
 190:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 197:	0f bf d8             	movswl %ax,%ebx
 19a:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 1a1:	48 89 c7             	mov    %rax,%rdi
 1a4:	e8 57 fe ff ff       	call   0 <fmtname>
 1a9:	45 89 e9             	mov    %r13d,%r9d
 1ac:	45 89 e0             	mov    %r12d,%r8d
 1af:	89 d9                	mov    %ebx,%ecx
 1b1:	48 89 c2             	mov    %rax,%rdx
 1b4:	48 c7 c6 bf 0e 00 00 	mov    $0xebf,%rsi
 1bb:	bf 01 00 00 00       	mov    $0x1,%edi
 1c0:	b8 00 00 00 00       	mov    $0x0,%eax
 1c5:	e8 b8 06 00 00       	call   882 <printf>
    break;
 1ca:	e9 67 01 00 00       	jmp    336 <ls+0x26e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1cf:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 1d6:	48 89 c7             	mov    %rax,%rdi
 1d9:	e8 a7 02 00 00       	call   485 <strlen>
 1de:	83 c0 10             	add    $0x10,%eax
 1e1:	3d 00 02 00 00       	cmp    $0x200,%eax
 1e6:	76 1b                	jbe    203 <ls+0x13b>
      printf(1, "ls: path too long\n");
 1e8:	48 c7 c6 cc 0e 00 00 	mov    $0xecc,%rsi
 1ef:	bf 01 00 00 00       	mov    $0x1,%edi
 1f4:	b8 00 00 00 00       	mov    $0x0,%eax
 1f9:	e8 84 06 00 00       	call   882 <printf>
      break;
 1fe:	e9 33 01 00 00       	jmp    336 <ls+0x26e>
    }
    strcpy(buf, path);
 203:	48 8b 95 98 fd ff ff 	mov    -0x268(%rbp),%rdx
 20a:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 211:	48 89 d6             	mov    %rdx,%rsi
 214:	48 89 c7             	mov    %rax,%rdi
 217:	e8 cb 01 00 00       	call   3e7 <strcpy>
    p = buf+strlen(buf);
 21c:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 223:	48 89 c7             	mov    %rax,%rdi
 226:	e8 5a 02 00 00       	call   485 <strlen>
 22b:	89 c2                	mov    %eax,%edx
 22d:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 234:	48 01 d0             	add    %rdx,%rax
 237:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    *p++ = '/';
 23b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 23f:	48 8d 50 01          	lea    0x1(%rax),%rdx
 243:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
 247:	c6 00 2f             	movb   $0x2f,(%rax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 24a:	e9 c4 00 00 00       	jmp    313 <ls+0x24b>
      if(de.inum == 0)
 24f:	0f b7 85 c0 fd ff ff 	movzwl -0x240(%rbp),%eax
 256:	66 85 c0             	test   %ax,%ax
 259:	0f 84 b3 00 00 00    	je     312 <ls+0x24a>
        continue;
      memmove(p, de.name, DIRSIZ);
 25f:	48 8d 85 c0 fd ff ff 	lea    -0x240(%rbp),%rax
 266:	48 8d 48 02          	lea    0x2(%rax),%rcx
 26a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 26e:	ba 0e 00 00 00       	mov    $0xe,%edx
 273:	48 89 ce             	mov    %rcx,%rsi
 276:	48 89 c7             	mov    %rax,%rdi
 279:	e8 e9 03 00 00       	call   667 <memmove>
      p[DIRSIZ] = 0;
 27e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 282:	48 83 c0 0e          	add    $0xe,%rax
 286:	c6 00 00             	movb   $0x0,(%rax)
      if(stat(buf, &st) < 0){
 289:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
 290:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 297:	48 89 d6             	mov    %rdx,%rsi
 29a:	48 89 c7             	mov    %rax,%rdi
 29d:	e8 11 03 00 00       	call   5b3 <stat>
 2a2:	85 c0                	test   %eax,%eax
 2a4:	79 22                	jns    2c8 <ls+0x200>
        printf(1, "ls: cannot stat %s\n", buf);
 2a6:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 2ad:	48 89 c2             	mov    %rax,%rdx
 2b0:	48 c7 c6 ab 0e 00 00 	mov    $0xeab,%rsi
 2b7:	bf 01 00 00 00       	mov    $0x1,%edi
 2bc:	b8 00 00 00 00       	mov    $0x0,%eax
 2c1:	e8 bc 05 00 00       	call   882 <printf>
        continue;
 2c6:	eb 4b                	jmp    313 <ls+0x24b>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2c8:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
 2cf:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
 2d6:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 2dd:	0f bf d8             	movswl %ax,%ebx
 2e0:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 2e7:	48 89 c7             	mov    %rax,%rdi
 2ea:	e8 11 fd ff ff       	call   0 <fmtname>
 2ef:	45 89 e9             	mov    %r13d,%r9d
 2f2:	45 89 e0             	mov    %r12d,%r8d
 2f5:	89 d9                	mov    %ebx,%ecx
 2f7:	48 89 c2             	mov    %rax,%rdx
 2fa:	48 c7 c6 bf 0e 00 00 	mov    $0xebf,%rsi
 301:	bf 01 00 00 00       	mov    $0x1,%edi
 306:	b8 00 00 00 00       	mov    $0x0,%eax
 30b:	e8 72 05 00 00       	call   882 <printf>
 310:	eb 01                	jmp    313 <ls+0x24b>
        continue;
 312:	90                   	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 313:	48 8d 8d c0 fd ff ff 	lea    -0x240(%rbp),%rcx
 31a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 31d:	ba 10 00 00 00       	mov    $0x10,%edx
 322:	48 89 ce             	mov    %rcx,%rsi
 325:	89 c7                	mov    %eax,%edi
 327:	e8 b4 03 00 00       	call   6e0 <read>
 32c:	83 f8 10             	cmp    $0x10,%eax
 32f:	0f 84 1a ff ff ff    	je     24f <ls+0x187>
    }
    break;
 335:	90                   	nop
  }
  close(fd);
 336:	8b 45 dc             	mov    -0x24(%rbp),%eax
 339:	89 c7                	mov    %eax,%edi
 33b:	e8 b0 03 00 00       	call   6f0 <close>
}
 340:	48 81 c4 58 02 00 00 	add    $0x258,%rsp
 347:	5b                   	pop    %rbx
 348:	41 5c                	pop    %r12
 34a:	41 5d                	pop    %r13
 34c:	5d                   	pop    %rbp
 34d:	c3                   	ret

000000000000034e <main>:

int
main(int argc, char *argv[])
{
 34e:	f3 0f 1e fa          	endbr64
 352:	55                   	push   %rbp
 353:	48 89 e5             	mov    %rsp,%rbp
 356:	48 83 ec 20          	sub    $0x20,%rsp
 35a:	89 7d ec             	mov    %edi,-0x14(%rbp)
 35d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
 361:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
 365:	7f 11                	jg     378 <main+0x2a>
    ls(".");
 367:	48 c7 c7 df 0e 00 00 	mov    $0xedf,%rdi
 36e:	e8 55 fd ff ff       	call   c8 <ls>
    exit();
 373:	e8 50 03 00 00       	call   6c8 <exit>
  }
  for(i=1; i<argc; i++)
 378:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 37f:	eb 23                	jmp    3a4 <main+0x56>
    ls(argv[i]);
 381:	8b 45 fc             	mov    -0x4(%rbp),%eax
 384:	48 98                	cltq
 386:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 38d:	00 
 38e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 392:	48 01 d0             	add    %rdx,%rax
 395:	48 8b 00             	mov    (%rax),%rax
 398:	48 89 c7             	mov    %rax,%rdi
 39b:	e8 28 fd ff ff       	call   c8 <ls>
  for(i=1; i<argc; i++)
 3a0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 3a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3a7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 3aa:	7c d5                	jl     381 <main+0x33>
  exit();
 3ac:	e8 17 03 00 00       	call   6c8 <exit>

00000000000003b1 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3b1:	55                   	push   %rbp
 3b2:	48 89 e5             	mov    %rsp,%rbp
 3b5:	48 83 ec 10          	sub    $0x10,%rsp
 3b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3bd:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3c0:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3c3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3c7:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3ca:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3cd:	48 89 ce             	mov    %rcx,%rsi
 3d0:	48 89 f7             	mov    %rsi,%rdi
 3d3:	89 d1                	mov    %edx,%ecx
 3d5:	fc                   	cld
 3d6:	f3 aa                	rep stos %al,%es:(%rdi)
 3d8:	89 ca                	mov    %ecx,%edx
 3da:	48 89 fe             	mov    %rdi,%rsi
 3dd:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 3e1:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3e4:	90                   	nop
 3e5:	c9                   	leave
 3e6:	c3                   	ret

00000000000003e7 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3e7:	f3 0f 1e fa          	endbr64
 3eb:	55                   	push   %rbp
 3ec:	48 89 e5             	mov    %rsp,%rbp
 3ef:	48 83 ec 20          	sub    $0x20,%rsp
 3f3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3f7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 3fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 403:	90                   	nop
 404:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 408:	48 8d 42 01          	lea    0x1(%rdx),%rax
 40c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 410:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 414:	48 8d 48 01          	lea    0x1(%rax),%rcx
 418:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 41c:	0f b6 12             	movzbl (%rdx),%edx
 41f:	88 10                	mov    %dl,(%rax)
 421:	0f b6 00             	movzbl (%rax),%eax
 424:	84 c0                	test   %al,%al
 426:	75 dc                	jne    404 <strcpy+0x1d>
    ;
  return os;
 428:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 42c:	c9                   	leave
 42d:	c3                   	ret

000000000000042e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 42e:	f3 0f 1e fa          	endbr64
 432:	55                   	push   %rbp
 433:	48 89 e5             	mov    %rsp,%rbp
 436:	48 83 ec 10          	sub    $0x10,%rsp
 43a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 43e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 442:	eb 0a                	jmp    44e <strcmp+0x20>
    p++, q++;
 444:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 449:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 44e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 452:	0f b6 00             	movzbl (%rax),%eax
 455:	84 c0                	test   %al,%al
 457:	74 12                	je     46b <strcmp+0x3d>
 459:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 45d:	0f b6 10             	movzbl (%rax),%edx
 460:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 464:	0f b6 00             	movzbl (%rax),%eax
 467:	38 c2                	cmp    %al,%dl
 469:	74 d9                	je     444 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 46b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 46f:	0f b6 00             	movzbl (%rax),%eax
 472:	0f b6 d0             	movzbl %al,%edx
 475:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 479:	0f b6 00             	movzbl (%rax),%eax
 47c:	0f b6 c0             	movzbl %al,%eax
 47f:	29 c2                	sub    %eax,%edx
 481:	89 d0                	mov    %edx,%eax
}
 483:	c9                   	leave
 484:	c3                   	ret

0000000000000485 <strlen>:

uint
strlen(char *s)
{
 485:	f3 0f 1e fa          	endbr64
 489:	55                   	push   %rbp
 48a:	48 89 e5             	mov    %rsp,%rbp
 48d:	48 83 ec 18          	sub    $0x18,%rsp
 491:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 495:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 49c:	eb 04                	jmp    4a2 <strlen+0x1d>
 49e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 4a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a5:	48 63 d0             	movslq %eax,%rdx
 4a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4ac:	48 01 d0             	add    %rdx,%rax
 4af:	0f b6 00             	movzbl (%rax),%eax
 4b2:	84 c0                	test   %al,%al
 4b4:	75 e8                	jne    49e <strlen+0x19>
    ;
  return n;
 4b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4b9:	c9                   	leave
 4ba:	c3                   	ret

00000000000004bb <memset>:

void*
memset(void *dst, int c, uint n)
{
 4bb:	f3 0f 1e fa          	endbr64
 4bf:	55                   	push   %rbp
 4c0:	48 89 e5             	mov    %rsp,%rbp
 4c3:	48 83 ec 10          	sub    $0x10,%rsp
 4c7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4cb:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4ce:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4d1:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4d4:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4db:	89 ce                	mov    %ecx,%esi
 4dd:	48 89 c7             	mov    %rax,%rdi
 4e0:	e8 cc fe ff ff       	call   3b1 <stosb>
  return dst;
 4e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 4e9:	c9                   	leave
 4ea:	c3                   	ret

00000000000004eb <strchr>:

char*
strchr(const char *s, char c)
{
 4eb:	f3 0f 1e fa          	endbr64
 4ef:	55                   	push   %rbp
 4f0:	48 89 e5             	mov    %rsp,%rbp
 4f3:	48 83 ec 10          	sub    $0x10,%rsp
 4f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4fb:	89 f0                	mov    %esi,%eax
 4fd:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 500:	eb 17                	jmp    519 <strchr+0x2e>
    if(*s == c)
 502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 506:	0f b6 00             	movzbl (%rax),%eax
 509:	38 45 f4             	cmp    %al,-0xc(%rbp)
 50c:	75 06                	jne    514 <strchr+0x29>
      return (char*)s;
 50e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 512:	eb 15                	jmp    529 <strchr+0x3e>
  for(; *s; s++)
 514:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 519:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 51d:	0f b6 00             	movzbl (%rax),%eax
 520:	84 c0                	test   %al,%al
 522:	75 de                	jne    502 <strchr+0x17>
  return 0;
 524:	b8 00 00 00 00       	mov    $0x0,%eax
}
 529:	c9                   	leave
 52a:	c3                   	ret

000000000000052b <gets>:

char*
gets(char *buf, int max)
{
 52b:	f3 0f 1e fa          	endbr64
 52f:	55                   	push   %rbp
 530:	48 89 e5             	mov    %rsp,%rbp
 533:	48 83 ec 20          	sub    $0x20,%rsp
 537:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 53b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 53e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 545:	eb 48                	jmp    58f <gets+0x64>
    cc = read(0, &c, 1);
 547:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 54b:	ba 01 00 00 00       	mov    $0x1,%edx
 550:	48 89 c6             	mov    %rax,%rsi
 553:	bf 00 00 00 00       	mov    $0x0,%edi
 558:	e8 83 01 00 00       	call   6e0 <read>
 55d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 560:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 564:	7e 36                	jle    59c <gets+0x71>
      break;
    buf[i++] = c;
 566:	8b 45 fc             	mov    -0x4(%rbp),%eax
 569:	8d 50 01             	lea    0x1(%rax),%edx
 56c:	89 55 fc             	mov    %edx,-0x4(%rbp)
 56f:	48 63 d0             	movslq %eax,%rdx
 572:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 576:	48 01 c2             	add    %rax,%rdx
 579:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 57d:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 57f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 583:	3c 0a                	cmp    $0xa,%al
 585:	74 16                	je     59d <gets+0x72>
 587:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 58b:	3c 0d                	cmp    $0xd,%al
 58d:	74 0e                	je     59d <gets+0x72>
  for(i=0; i+1 < max; ){
 58f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 592:	83 c0 01             	add    $0x1,%eax
 595:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 598:	7f ad                	jg     547 <gets+0x1c>
 59a:	eb 01                	jmp    59d <gets+0x72>
      break;
 59c:	90                   	nop
      break;
  }
  buf[i] = '\0';
 59d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5a0:	48 63 d0             	movslq %eax,%rdx
 5a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5a7:	48 01 d0             	add    %rdx,%rax
 5aa:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 5ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 5b1:	c9                   	leave
 5b2:	c3                   	ret

00000000000005b3 <stat>:

int
stat(char *n, struct stat *st)
{
 5b3:	f3 0f 1e fa          	endbr64
 5b7:	55                   	push   %rbp
 5b8:	48 89 e5             	mov    %rsp,%rbp
 5bb:	48 83 ec 20          	sub    $0x20,%rsp
 5bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 5c3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5cb:	be 00 00 00 00       	mov    $0x0,%esi
 5d0:	48 89 c7             	mov    %rax,%rdi
 5d3:	e8 30 01 00 00       	call   708 <open>
 5d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5df:	79 07                	jns    5e8 <stat+0x35>
    return -1;
 5e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5e6:	eb 21                	jmp    609 <stat+0x56>
  r = fstat(fd, st);
 5e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 5ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5ef:	48 89 d6             	mov    %rdx,%rsi
 5f2:	89 c7                	mov    %eax,%edi
 5f4:	e8 27 01 00 00       	call   720 <fstat>
 5f9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 5fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5ff:	89 c7                	mov    %eax,%edi
 601:	e8 ea 00 00 00       	call   6f0 <close>
  return r;
 606:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 609:	c9                   	leave
 60a:	c3                   	ret

000000000000060b <atoi>:

int
atoi(const char *s)
{
 60b:	f3 0f 1e fa          	endbr64
 60f:	55                   	push   %rbp
 610:	48 89 e5             	mov    %rsp,%rbp
 613:	48 83 ec 18          	sub    $0x18,%rsp
 617:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 61b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 622:	eb 28                	jmp    64c <atoi+0x41>
    n = n*10 + *s++ - '0';
 624:	8b 55 fc             	mov    -0x4(%rbp),%edx
 627:	89 d0                	mov    %edx,%eax
 629:	c1 e0 02             	shl    $0x2,%eax
 62c:	01 d0                	add    %edx,%eax
 62e:	01 c0                	add    %eax,%eax
 630:	89 c1                	mov    %eax,%ecx
 632:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 636:	48 8d 50 01          	lea    0x1(%rax),%rdx
 63a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 63e:	0f b6 00             	movzbl (%rax),%eax
 641:	0f be c0             	movsbl %al,%eax
 644:	01 c8                	add    %ecx,%eax
 646:	83 e8 30             	sub    $0x30,%eax
 649:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 64c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 650:	0f b6 00             	movzbl (%rax),%eax
 653:	3c 2f                	cmp    $0x2f,%al
 655:	7e 0b                	jle    662 <atoi+0x57>
 657:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 65b:	0f b6 00             	movzbl (%rax),%eax
 65e:	3c 39                	cmp    $0x39,%al
 660:	7e c2                	jle    624 <atoi+0x19>
  return n;
 662:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 665:	c9                   	leave
 666:	c3                   	ret

0000000000000667 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 667:	f3 0f 1e fa          	endbr64
 66b:	55                   	push   %rbp
 66c:	48 89 e5             	mov    %rsp,%rbp
 66f:	48 83 ec 28          	sub    $0x28,%rsp
 673:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 677:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 67b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 67e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 682:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 686:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 68a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 68e:	eb 1d                	jmp    6ad <memmove+0x46>
    *dst++ = *src++;
 690:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 694:	48 8d 42 01          	lea    0x1(%rdx),%rax
 698:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 69c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 6a0:	48 8d 48 01          	lea    0x1(%rax),%rcx
 6a4:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 6a8:	0f b6 12             	movzbl (%rdx),%edx
 6ab:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 6ad:	8b 45 dc             	mov    -0x24(%rbp),%eax
 6b0:	8d 50 ff             	lea    -0x1(%rax),%edx
 6b3:	89 55 dc             	mov    %edx,-0x24(%rbp)
 6b6:	85 c0                	test   %eax,%eax
 6b8:	7f d6                	jg     690 <memmove+0x29>
  return vdst;
 6ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 6be:	c9                   	leave
 6bf:	c3                   	ret

00000000000006c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6c0:	b8 01 00 00 00       	mov    $0x1,%eax
 6c5:	cd 40                	int    $0x40
 6c7:	c3                   	ret

00000000000006c8 <exit>:
SYSCALL(exit)
 6c8:	b8 02 00 00 00       	mov    $0x2,%eax
 6cd:	cd 40                	int    $0x40
 6cf:	c3                   	ret

00000000000006d0 <wait>:
SYSCALL(wait)
 6d0:	b8 03 00 00 00       	mov    $0x3,%eax
 6d5:	cd 40                	int    $0x40
 6d7:	c3                   	ret

00000000000006d8 <pipe>:
SYSCALL(pipe)
 6d8:	b8 04 00 00 00       	mov    $0x4,%eax
 6dd:	cd 40                	int    $0x40
 6df:	c3                   	ret

00000000000006e0 <read>:
SYSCALL(read)
 6e0:	b8 05 00 00 00       	mov    $0x5,%eax
 6e5:	cd 40                	int    $0x40
 6e7:	c3                   	ret

00000000000006e8 <write>:
SYSCALL(write)
 6e8:	b8 10 00 00 00       	mov    $0x10,%eax
 6ed:	cd 40                	int    $0x40
 6ef:	c3                   	ret

00000000000006f0 <close>:
SYSCALL(close)
 6f0:	b8 15 00 00 00       	mov    $0x15,%eax
 6f5:	cd 40                	int    $0x40
 6f7:	c3                   	ret

00000000000006f8 <kill>:
SYSCALL(kill)
 6f8:	b8 06 00 00 00       	mov    $0x6,%eax
 6fd:	cd 40                	int    $0x40
 6ff:	c3                   	ret

0000000000000700 <exec>:
SYSCALL(exec)
 700:	b8 07 00 00 00       	mov    $0x7,%eax
 705:	cd 40                	int    $0x40
 707:	c3                   	ret

0000000000000708 <open>:
SYSCALL(open)
 708:	b8 0f 00 00 00       	mov    $0xf,%eax
 70d:	cd 40                	int    $0x40
 70f:	c3                   	ret

0000000000000710 <mknod>:
SYSCALL(mknod)
 710:	b8 11 00 00 00       	mov    $0x11,%eax
 715:	cd 40                	int    $0x40
 717:	c3                   	ret

0000000000000718 <unlink>:
SYSCALL(unlink)
 718:	b8 12 00 00 00       	mov    $0x12,%eax
 71d:	cd 40                	int    $0x40
 71f:	c3                   	ret

0000000000000720 <fstat>:
SYSCALL(fstat)
 720:	b8 08 00 00 00       	mov    $0x8,%eax
 725:	cd 40                	int    $0x40
 727:	c3                   	ret

0000000000000728 <link>:
SYSCALL(link)
 728:	b8 13 00 00 00       	mov    $0x13,%eax
 72d:	cd 40                	int    $0x40
 72f:	c3                   	ret

0000000000000730 <mkdir>:
SYSCALL(mkdir)
 730:	b8 14 00 00 00       	mov    $0x14,%eax
 735:	cd 40                	int    $0x40
 737:	c3                   	ret

0000000000000738 <chdir>:
SYSCALL(chdir)
 738:	b8 09 00 00 00       	mov    $0x9,%eax
 73d:	cd 40                	int    $0x40
 73f:	c3                   	ret

0000000000000740 <dup>:
SYSCALL(dup)
 740:	b8 0a 00 00 00       	mov    $0xa,%eax
 745:	cd 40                	int    $0x40
 747:	c3                   	ret

0000000000000748 <getpid>:
SYSCALL(getpid)
 748:	b8 0b 00 00 00       	mov    $0xb,%eax
 74d:	cd 40                	int    $0x40
 74f:	c3                   	ret

0000000000000750 <sbrk>:
SYSCALL(sbrk)
 750:	b8 0c 00 00 00       	mov    $0xc,%eax
 755:	cd 40                	int    $0x40
 757:	c3                   	ret

0000000000000758 <sleep>:
SYSCALL(sleep)
 758:	b8 0d 00 00 00       	mov    $0xd,%eax
 75d:	cd 40                	int    $0x40
 75f:	c3                   	ret

0000000000000760 <uptime>:
SYSCALL(uptime)
 760:	b8 0e 00 00 00       	mov    $0xe,%eax
 765:	cd 40                	int    $0x40
 767:	c3                   	ret

0000000000000768 <getpinfo>:
SYSCALL(getpinfo)
 768:	b8 18 00 00 00       	mov    $0x18,%eax
 76d:	cd 40                	int    $0x40
 76f:	c3                   	ret

0000000000000770 <settickets>:
SYSCALL(settickets)
 770:	b8 1b 00 00 00       	mov    $0x1b,%eax
 775:	cd 40                	int    $0x40
 777:	c3                   	ret

0000000000000778 <getfavnum>:
SYSCALL(getfavnum)
 778:	b8 1c 00 00 00       	mov    $0x1c,%eax
 77d:	cd 40                	int    $0x40
 77f:	c3                   	ret

0000000000000780 <halt>:
SYSCALL(halt)
 780:	b8 1d 00 00 00       	mov    $0x1d,%eax
 785:	cd 40                	int    $0x40
 787:	c3                   	ret

0000000000000788 <getcount>:
SYSCALL(getcount)
 788:	b8 1e 00 00 00       	mov    $0x1e,%eax
 78d:	cd 40                	int    $0x40
 78f:	c3                   	ret

0000000000000790 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 790:	f3 0f 1e fa          	endbr64
 794:	55                   	push   %rbp
 795:	48 89 e5             	mov    %rsp,%rbp
 798:	48 83 ec 10          	sub    $0x10,%rsp
 79c:	89 7d fc             	mov    %edi,-0x4(%rbp)
 79f:	89 f0                	mov    %esi,%eax
 7a1:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7a4:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7ab:	ba 01 00 00 00       	mov    $0x1,%edx
 7b0:	48 89 ce             	mov    %rcx,%rsi
 7b3:	89 c7                	mov    %eax,%edi
 7b5:	e8 2e ff ff ff       	call   6e8 <write>
}
 7ba:	90                   	nop
 7bb:	c9                   	leave
 7bc:	c3                   	ret

00000000000007bd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7bd:	f3 0f 1e fa          	endbr64
 7c1:	55                   	push   %rbp
 7c2:	48 89 e5             	mov    %rsp,%rbp
 7c5:	48 83 ec 30          	sub    $0x30,%rsp
 7c9:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7cc:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7cf:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7d2:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7dc:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7e0:	74 17                	je     7f9 <printint+0x3c>
 7e2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7e6:	79 11                	jns    7f9 <printint+0x3c>
    neg = 1;
 7e8:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7ef:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7f2:	f7 d8                	neg    %eax
 7f4:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7f7:	eb 06                	jmp    7ff <printint+0x42>
  } else {
    x = xx;
 7f9:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7fc:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 806:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 809:	8b 45 f4             	mov    -0xc(%rbp),%eax
 80c:	ba 00 00 00 00       	mov    $0x0,%edx
 811:	f7 f6                	div    %esi
 813:	89 d1                	mov    %edx,%ecx
 815:	8b 45 fc             	mov    -0x4(%rbp),%eax
 818:	8d 50 01             	lea    0x1(%rax),%edx
 81b:	89 55 fc             	mov    %edx,-0x4(%rbp)
 81e:	89 ca                	mov    %ecx,%edx
 820:	0f b6 92 70 11 00 00 	movzbl 0x1170(%rdx),%edx
 827:	48 98                	cltq
 829:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 82d:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 830:	8b 45 f4             	mov    -0xc(%rbp),%eax
 833:	ba 00 00 00 00       	mov    $0x0,%edx
 838:	f7 f7                	div    %edi
 83a:	89 45 f4             	mov    %eax,-0xc(%rbp)
 83d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 841:	75 c3                	jne    806 <printint+0x49>
  if(neg)
 843:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 847:	74 2b                	je     874 <printint+0xb7>
    buf[i++] = '-';
 849:	8b 45 fc             	mov    -0x4(%rbp),%eax
 84c:	8d 50 01             	lea    0x1(%rax),%edx
 84f:	89 55 fc             	mov    %edx,-0x4(%rbp)
 852:	48 98                	cltq
 854:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 859:	eb 19                	jmp    874 <printint+0xb7>
    putc(fd, buf[i]);
 85b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 85e:	48 98                	cltq
 860:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 865:	0f be d0             	movsbl %al,%edx
 868:	8b 45 dc             	mov    -0x24(%rbp),%eax
 86b:	89 d6                	mov    %edx,%esi
 86d:	89 c7                	mov    %eax,%edi
 86f:	e8 1c ff ff ff       	call   790 <putc>
  while(--i >= 0)
 874:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 878:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 87c:	79 dd                	jns    85b <printint+0x9e>
}
 87e:	90                   	nop
 87f:	90                   	nop
 880:	c9                   	leave
 881:	c3                   	ret

0000000000000882 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 882:	f3 0f 1e fa          	endbr64
 886:	55                   	push   %rbp
 887:	48 89 e5             	mov    %rsp,%rbp
 88a:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 891:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 897:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 89e:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8a5:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8ac:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8b3:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8ba:	84 c0                	test   %al,%al
 8bc:	74 20                	je     8de <printf+0x5c>
 8be:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8c2:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8c6:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8ca:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8ce:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8d2:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8d6:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8da:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8de:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8e5:	00 00 00 
 8e8:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8ef:	00 00 00 
 8f2:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8f6:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8fd:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 904:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 90b:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 912:	00 00 00 
  for(i = 0; fmt[i]; i++){
 915:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 91c:	00 00 00 
 91f:	e9 a8 02 00 00       	jmp    bcc <printf+0x34a>
    c = fmt[i] & 0xff;
 924:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 92a:	48 63 d0             	movslq %eax,%rdx
 92d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 934:	48 01 d0             	add    %rdx,%rax
 937:	0f b6 00             	movzbl (%rax),%eax
 93a:	0f be c0             	movsbl %al,%eax
 93d:	25 ff 00 00 00       	and    $0xff,%eax
 942:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 948:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 94f:	75 35                	jne    986 <printf+0x104>
      if(c == '%'){
 951:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 958:	75 0f                	jne    969 <printf+0xe7>
        state = '%';
 95a:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 961:	00 00 00 
 964:	e9 5c 02 00 00       	jmp    bc5 <printf+0x343>
      } else {
        putc(fd, c);
 969:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 96f:	0f be d0             	movsbl %al,%edx
 972:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 978:	89 d6                	mov    %edx,%esi
 97a:	89 c7                	mov    %eax,%edi
 97c:	e8 0f fe ff ff       	call   790 <putc>
 981:	e9 3f 02 00 00       	jmp    bc5 <printf+0x343>
      }
    } else if(state == '%'){
 986:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 98d:	0f 85 32 02 00 00    	jne    bc5 <printf+0x343>
      if(c == 'd'){
 993:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 99a:	75 5e                	jne    9fa <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 99c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9a2:	83 f8 2f             	cmp    $0x2f,%eax
 9a5:	77 23                	ja     9ca <printf+0x148>
 9a7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9ae:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9b4:	89 d2                	mov    %edx,%edx
 9b6:	48 01 d0             	add    %rdx,%rax
 9b9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9bf:	83 c2 08             	add    $0x8,%edx
 9c2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9c8:	eb 12                	jmp    9dc <printf+0x15a>
 9ca:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9d1:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9d5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9dc:	8b 30                	mov    (%rax),%esi
 9de:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9e4:	b9 01 00 00 00       	mov    $0x1,%ecx
 9e9:	ba 0a 00 00 00       	mov    $0xa,%edx
 9ee:	89 c7                	mov    %eax,%edi
 9f0:	e8 c8 fd ff ff       	call   7bd <printint>
 9f5:	e9 c1 01 00 00       	jmp    bbb <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 9fa:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a01:	74 09                	je     a0c <printf+0x18a>
 a03:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a0a:	75 5e                	jne    a6a <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a0c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a12:	83 f8 2f             	cmp    $0x2f,%eax
 a15:	77 23                	ja     a3a <printf+0x1b8>
 a17:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a1e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a24:	89 d2                	mov    %edx,%edx
 a26:	48 01 d0             	add    %rdx,%rax
 a29:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a2f:	83 c2 08             	add    $0x8,%edx
 a32:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a38:	eb 12                	jmp    a4c <printf+0x1ca>
 a3a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a41:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a45:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a4c:	8b 30                	mov    (%rax),%esi
 a4e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a54:	b9 00 00 00 00       	mov    $0x0,%ecx
 a59:	ba 10 00 00 00       	mov    $0x10,%edx
 a5e:	89 c7                	mov    %eax,%edi
 a60:	e8 58 fd ff ff       	call   7bd <printint>
 a65:	e9 51 01 00 00       	jmp    bbb <printf+0x339>
      } else if(c == 's'){
 a6a:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a71:	0f 85 98 00 00 00    	jne    b0f <printf+0x28d>
        s = va_arg(ap, char*);
 a77:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a7d:	83 f8 2f             	cmp    $0x2f,%eax
 a80:	77 23                	ja     aa5 <printf+0x223>
 a82:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a89:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a8f:	89 d2                	mov    %edx,%edx
 a91:	48 01 d0             	add    %rdx,%rax
 a94:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a9a:	83 c2 08             	add    $0x8,%edx
 a9d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 aa3:	eb 12                	jmp    ab7 <printf+0x235>
 aa5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 aac:	48 8d 50 08          	lea    0x8(%rax),%rdx
 ab0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ab7:	48 8b 00             	mov    (%rax),%rax
 aba:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 ac1:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 ac8:	00 
 ac9:	75 31                	jne    afc <printf+0x27a>
          s = "(null)";
 acb:	48 c7 85 48 ff ff ff 	movq   $0xee1,-0xb8(%rbp)
 ad2:	e1 0e 00 00 
        while(*s != 0){
 ad6:	eb 24                	jmp    afc <printf+0x27a>
          putc(fd, *s);
 ad8:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 adf:	0f b6 00             	movzbl (%rax),%eax
 ae2:	0f be d0             	movsbl %al,%edx
 ae5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 aeb:	89 d6                	mov    %edx,%esi
 aed:	89 c7                	mov    %eax,%edi
 aef:	e8 9c fc ff ff       	call   790 <putc>
          s++;
 af4:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 afb:	01 
        while(*s != 0){
 afc:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b03:	0f b6 00             	movzbl (%rax),%eax
 b06:	84 c0                	test   %al,%al
 b08:	75 ce                	jne    ad8 <printf+0x256>
 b0a:	e9 ac 00 00 00       	jmp    bbb <printf+0x339>
        }
      } else if(c == 'c'){
 b0f:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b16:	75 56                	jne    b6e <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b18:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b1e:	83 f8 2f             	cmp    $0x2f,%eax
 b21:	77 23                	ja     b46 <printf+0x2c4>
 b23:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b2a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b30:	89 d2                	mov    %edx,%edx
 b32:	48 01 d0             	add    %rdx,%rax
 b35:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b3b:	83 c2 08             	add    $0x8,%edx
 b3e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b44:	eb 12                	jmp    b58 <printf+0x2d6>
 b46:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b4d:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b51:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b58:	8b 00                	mov    (%rax),%eax
 b5a:	0f be d0             	movsbl %al,%edx
 b5d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b63:	89 d6                	mov    %edx,%esi
 b65:	89 c7                	mov    %eax,%edi
 b67:	e8 24 fc ff ff       	call   790 <putc>
 b6c:	eb 4d                	jmp    bbb <printf+0x339>
      } else if(c == '%'){
 b6e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b75:	75 1a                	jne    b91 <printf+0x30f>
        putc(fd, c);
 b77:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b7d:	0f be d0             	movsbl %al,%edx
 b80:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b86:	89 d6                	mov    %edx,%esi
 b88:	89 c7                	mov    %eax,%edi
 b8a:	e8 01 fc ff ff       	call   790 <putc>
 b8f:	eb 2a                	jmp    bbb <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b91:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b97:	be 25 00 00 00       	mov    $0x25,%esi
 b9c:	89 c7                	mov    %eax,%edi
 b9e:	e8 ed fb ff ff       	call   790 <putc>
        putc(fd, c);
 ba3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 ba9:	0f be d0             	movsbl %al,%edx
 bac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bb2:	89 d6                	mov    %edx,%esi
 bb4:	89 c7                	mov    %eax,%edi
 bb6:	e8 d5 fb ff ff       	call   790 <putc>
      }
      state = 0;
 bbb:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bc2:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bc5:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bcc:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bd2:	48 63 d0             	movslq %eax,%rdx
 bd5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bdc:	48 01 d0             	add    %rdx,%rax
 bdf:	0f b6 00             	movzbl (%rax),%eax
 be2:	84 c0                	test   %al,%al
 be4:	0f 85 3a fd ff ff    	jne    924 <printf+0xa2>
    }
  }
}
 bea:	90                   	nop
 beb:	90                   	nop
 bec:	c9                   	leave
 bed:	c3                   	ret

0000000000000bee <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bee:	f3 0f 1e fa          	endbr64
 bf2:	55                   	push   %rbp
 bf3:	48 89 e5             	mov    %rsp,%rbp
 bf6:	48 83 ec 18          	sub    $0x18,%rsp
 bfa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c02:	48 83 e8 10          	sub    $0x10,%rax
 c06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c0a:	48 8b 05 9f 05 00 00 	mov    0x59f(%rip),%rax        # 11b0 <freep>
 c11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c15:	eb 2f                	jmp    c46 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c1b:	48 8b 00             	mov    (%rax),%rax
 c1e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c22:	72 17                	jb     c3b <free+0x4d>
 c24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c28:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c2c:	72 2f                	jb     c5d <free+0x6f>
 c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c32:	48 8b 00             	mov    (%rax),%rax
 c35:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c39:	72 22                	jb     c5d <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3f:	48 8b 00             	mov    (%rax),%rax
 c42:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c4a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c4e:	73 c7                	jae    c17 <free+0x29>
 c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c54:	48 8b 00             	mov    (%rax),%rax
 c57:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c5b:	73 ba                	jae    c17 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c61:	8b 40 08             	mov    0x8(%rax),%eax
 c64:	89 c0                	mov    %eax,%eax
 c66:	48 c1 e0 04          	shl    $0x4,%rax
 c6a:	48 89 c2             	mov    %rax,%rdx
 c6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c71:	48 01 c2             	add    %rax,%rdx
 c74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c78:	48 8b 00             	mov    (%rax),%rax
 c7b:	48 39 c2             	cmp    %rax,%rdx
 c7e:	75 2d                	jne    cad <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c84:	8b 50 08             	mov    0x8(%rax),%edx
 c87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c8b:	48 8b 00             	mov    (%rax),%rax
 c8e:	8b 40 08             	mov    0x8(%rax),%eax
 c91:	01 c2                	add    %eax,%edx
 c93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c97:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9e:	48 8b 00             	mov    (%rax),%rax
 ca1:	48 8b 10             	mov    (%rax),%rdx
 ca4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ca8:	48 89 10             	mov    %rdx,(%rax)
 cab:	eb 0e                	jmp    cbb <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 cad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb1:	48 8b 10             	mov    (%rax),%rdx
 cb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cb8:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbf:	8b 40 08             	mov    0x8(%rax),%eax
 cc2:	89 c0                	mov    %eax,%eax
 cc4:	48 c1 e0 04          	shl    $0x4,%rax
 cc8:	48 89 c2             	mov    %rax,%rdx
 ccb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ccf:	48 01 d0             	add    %rdx,%rax
 cd2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 cd6:	75 27                	jne    cff <free+0x111>
    p->s.size += bp->s.size;
 cd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cdc:	8b 50 08             	mov    0x8(%rax),%edx
 cdf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce3:	8b 40 08             	mov    0x8(%rax),%eax
 ce6:	01 c2                	add    %eax,%edx
 ce8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cec:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 cef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cf3:	48 8b 10             	mov    (%rax),%rdx
 cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfa:	48 89 10             	mov    %rdx,(%rax)
 cfd:	eb 0b                	jmp    d0a <free+0x11c>
  } else
    p->s.ptr = bp;
 cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d03:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d07:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0e:	48 89 05 9b 04 00 00 	mov    %rax,0x49b(%rip)        # 11b0 <freep>
}
 d15:	90                   	nop
 d16:	c9                   	leave
 d17:	c3                   	ret

0000000000000d18 <morecore>:

static Header*
morecore(uint nu)
{
 d18:	f3 0f 1e fa          	endbr64
 d1c:	55                   	push   %rbp
 d1d:	48 89 e5             	mov    %rsp,%rbp
 d20:	48 83 ec 20          	sub    $0x20,%rsp
 d24:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d27:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d2e:	77 07                	ja     d37 <morecore+0x1f>
    nu = 4096;
 d30:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d37:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d3a:	c1 e0 04             	shl    $0x4,%eax
 d3d:	89 c7                	mov    %eax,%edi
 d3f:	e8 0c fa ff ff       	call   750 <sbrk>
 d44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d48:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d4d:	75 07                	jne    d56 <morecore+0x3e>
    return 0;
 d4f:	b8 00 00 00 00       	mov    $0x0,%eax
 d54:	eb 29                	jmp    d7f <morecore+0x67>
  hp = (Header*)p;
 d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d62:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d65:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d6c:	48 83 c0 10          	add    $0x10,%rax
 d70:	48 89 c7             	mov    %rax,%rdi
 d73:	e8 76 fe ff ff       	call   bee <free>
  return freep;
 d78:	48 8b 05 31 04 00 00 	mov    0x431(%rip),%rax        # 11b0 <freep>
}
 d7f:	c9                   	leave
 d80:	c3                   	ret

0000000000000d81 <malloc>:

void*
malloc(uint nbytes)
{
 d81:	f3 0f 1e fa          	endbr64
 d85:	55                   	push   %rbp
 d86:	48 89 e5             	mov    %rsp,%rbp
 d89:	48 83 ec 30          	sub    $0x30,%rsp
 d8d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d90:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d93:	48 83 c0 0f          	add    $0xf,%rax
 d97:	48 c1 e8 04          	shr    $0x4,%rax
 d9b:	83 c0 01             	add    $0x1,%eax
 d9e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 da1:	48 8b 05 08 04 00 00 	mov    0x408(%rip),%rax        # 11b0 <freep>
 da8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 dac:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 db1:	75 2b                	jne    dde <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 db3:	48 c7 45 f0 a0 11 00 	movq   $0x11a0,-0x10(%rbp)
 dba:	00 
 dbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dbf:	48 89 05 ea 03 00 00 	mov    %rax,0x3ea(%rip)        # 11b0 <freep>
 dc6:	48 8b 05 e3 03 00 00 	mov    0x3e3(%rip),%rax        # 11b0 <freep>
 dcd:	48 89 05 cc 03 00 00 	mov    %rax,0x3cc(%rip)        # 11a0 <base>
    base.s.size = 0;
 dd4:	c7 05 ca 03 00 00 00 	movl   $0x0,0x3ca(%rip)        # 11a8 <base+0x8>
 ddb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 de2:	48 8b 00             	mov    (%rax),%rax
 de5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ded:	8b 40 08             	mov    0x8(%rax),%eax
 df0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 df3:	72 5f                	jb     e54 <malloc+0xd3>
      if(p->s.size == nunits)
 df5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 df9:	8b 40 08             	mov    0x8(%rax),%eax
 dfc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 dff:	75 10                	jne    e11 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e05:	48 8b 10             	mov    (%rax),%rdx
 e08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e0c:	48 89 10             	mov    %rdx,(%rax)
 e0f:	eb 2e                	jmp    e3f <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e15:	8b 40 08             	mov    0x8(%rax),%eax
 e18:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e1b:	89 c2                	mov    %eax,%edx
 e1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e21:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e28:	8b 40 08             	mov    0x8(%rax),%eax
 e2b:	89 c0                	mov    %eax,%eax
 e2d:	48 c1 e0 04          	shl    $0x4,%rax
 e31:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e39:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e3c:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e43:	48 89 05 66 03 00 00 	mov    %rax,0x366(%rip)        # 11b0 <freep>
      return (void*)(p + 1);
 e4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e4e:	48 83 c0 10          	add    $0x10,%rax
 e52:	eb 41                	jmp    e95 <malloc+0x114>
    }
    if(p == freep)
 e54:	48 8b 05 55 03 00 00 	mov    0x355(%rip),%rax        # 11b0 <freep>
 e5b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e5f:	75 1c                	jne    e7d <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e61:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e64:	89 c7                	mov    %eax,%edi
 e66:	e8 ad fe ff ff       	call   d18 <morecore>
 e6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e6f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e74:	75 07                	jne    e7d <malloc+0xfc>
        return 0;
 e76:	b8 00 00 00 00       	mov    $0x0,%eax
 e7b:	eb 18                	jmp    e95 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e89:	48 8b 00             	mov    (%rax),%rax
 e8c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e90:	e9 54 ff ff ff       	jmp    de9 <malloc+0x68>
  }
}
 e95:	c9                   	leave
 e96:	c3                   	ret
