
fs/grep:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 30          	sub    $0x30,%rsp
   c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  int n, m;
  char *p, *q;
  
  m = 0;
  13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  1a:	e9 bc 00 00 00       	jmp    db <grep+0xdb>
    m += n;
  1f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  22:	01 45 fc             	add    %eax,-0x4(%rbp)
    p = buf;
  25:	48 c7 45 f0 a0 11 00 	movq   $0x11a0,-0x10(%rbp)
  2c:	00 
    while((q = strchr(p, '\n')) != 0){
  2d:	eb 50                	jmp    7f <grep+0x7f>
      *q = 0;
  2f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  33:	c6 00 00             	movb   $0x0,(%rax)
      if(match(pattern, p)){
  36:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  3a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  3e:	48 89 d6             	mov    %rdx,%rsi
  41:	48 89 c7             	mov    %rax,%rdi
  44:	e8 c0 01 00 00       	call   209 <match>
  49:	85 c0                	test   %eax,%eax
  4b:	74 26                	je     73 <grep+0x73>
        *q = '\n';
  4d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  51:	c6 00 0a             	movb   $0xa,(%rax)
        write(1, p, q+1 - p);
  54:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  58:	48 83 c0 01          	add    $0x1,%rax
  5c:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
  60:	89 c2                	mov    %eax,%edx
  62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  66:	48 89 c6             	mov    %rax,%rsi
  69:	bf 01 00 00 00       	mov    $0x1,%edi
  6e:	e8 72 06 00 00       	call   6e5 <write>
      }
      p = q+1;
  73:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  77:	48 83 c0 01          	add    $0x1,%rax
  7b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
  7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  83:	be 0a 00 00 00       	mov    $0xa,%esi
  88:	48 89 c7             	mov    %rax,%rdi
  8b:	e8 58 04 00 00       	call   4e8 <strchr>
  90:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  94:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  99:	75 94                	jne    2f <grep+0x2f>
    }
    if(p == buf)
  9b:	48 81 7d f0 a0 11 00 	cmpq   $0x11a0,-0x10(%rbp)
  a2:	00 
  a3:	75 07                	jne    ac <grep+0xac>
      m = 0;
  a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(m > 0){
  ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  b0:	7e 29                	jle    db <grep+0xdb>
      m -= p - buf;
  b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  b5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  b9:	48 81 ea a0 11 00 00 	sub    $0x11a0,%rdx
  c0:	29 d0                	sub    %edx,%eax
  c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
  c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
  c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  cc:	48 89 c6             	mov    %rax,%rsi
  cf:	48 c7 c7 a0 11 00 00 	mov    $0x11a0,%rdi
  d6:	e8 89 05 00 00       	call   664 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  de:	ba 00 04 00 00       	mov    $0x400,%edx
  e3:	29 c2                	sub    %eax,%edx
  e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  e8:	48 98                	cltq
  ea:	48 8d 88 a0 11 00 00 	lea    0x11a0(%rax),%rcx
  f1:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  f4:	48 89 ce             	mov    %rcx,%rsi
  f7:	89 c7                	mov    %eax,%edi
  f9:	e8 df 05 00 00       	call   6dd <read>
  fe:	89 45 ec             	mov    %eax,-0x14(%rbp)
 101:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
 105:	0f 8f 14 ff ff ff    	jg     1f <grep+0x1f>
    }
  }
}
 10b:	90                   	nop
 10c:	90                   	nop
 10d:	c9                   	leave
 10e:	c3                   	ret

000000000000010f <main>:

int
main(int argc, char *argv[])
{
 10f:	f3 0f 1e fa          	endbr64
 113:	55                   	push   %rbp
 114:	48 89 e5             	mov    %rsp,%rbp
 117:	48 83 ec 30          	sub    $0x30,%rsp
 11b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 11e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 122:	83 7d dc 01          	cmpl   $0x1,-0x24(%rbp)
 126:	7f 1b                	jg     143 <main+0x34>
    printf(2, "usage: grep pattern [file ...]\n");
 128:	48 c7 c6 80 0e 00 00 	mov    $0xe80,%rsi
 12f:	bf 02 00 00 00       	mov    $0x2,%edi
 134:	b8 00 00 00 00       	mov    $0x0,%eax
 139:	e8 29 07 00 00       	call   867 <printf>
    exit();
 13e:	e8 82 05 00 00       	call   6c5 <exit>
  }
  pattern = argv[1];
 143:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 147:	48 8b 40 08          	mov    0x8(%rax),%rax
 14b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  
  if(argc <= 2){
 14f:	83 7d dc 02          	cmpl   $0x2,-0x24(%rbp)
 153:	7f 16                	jg     16b <main+0x5c>
    grep(pattern, 0);
 155:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 159:	be 00 00 00 00       	mov    $0x0,%esi
 15e:	48 89 c7             	mov    %rax,%rdi
 161:	e8 9a fe ff ff       	call   0 <grep>
    exit();
 166:	e8 5a 05 00 00       	call   6c5 <exit>
  }

  for(i = 2; i < argc; i++){
 16b:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
 172:	e9 81 00 00 00       	jmp    1f8 <main+0xe9>
    if((fd = open(argv[i], 0)) < 0){
 177:	8b 45 fc             	mov    -0x4(%rbp),%eax
 17a:	48 98                	cltq
 17c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 183:	00 
 184:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 188:	48 01 d0             	add    %rdx,%rax
 18b:	48 8b 00             	mov    (%rax),%rax
 18e:	be 00 00 00 00       	mov    $0x0,%esi
 193:	48 89 c7             	mov    %rax,%rdi
 196:	e8 6a 05 00 00       	call   705 <open>
 19b:	89 45 ec             	mov    %eax,-0x14(%rbp)
 19e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
 1a2:	79 35                	jns    1d9 <main+0xca>
      printf(1, "grep: cannot open %s\n", argv[i]);
 1a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1a7:	48 98                	cltq
 1a9:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 1b0:	00 
 1b1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 1b5:	48 01 d0             	add    %rdx,%rax
 1b8:	48 8b 00             	mov    (%rax),%rax
 1bb:	48 89 c2             	mov    %rax,%rdx
 1be:	48 c7 c6 a0 0e 00 00 	mov    $0xea0,%rsi
 1c5:	bf 01 00 00 00       	mov    $0x1,%edi
 1ca:	b8 00 00 00 00       	mov    $0x0,%eax
 1cf:	e8 93 06 00 00       	call   867 <printf>
      exit();
 1d4:	e8 ec 04 00 00       	call   6c5 <exit>
    }
    grep(pattern, fd);
 1d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 1dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1e0:	89 d6                	mov    %edx,%esi
 1e2:	48 89 c7             	mov    %rax,%rdi
 1e5:	e8 16 fe ff ff       	call   0 <grep>
    close(fd);
 1ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
 1ed:	89 c7                	mov    %eax,%edi
 1ef:	e8 f9 04 00 00       	call   6ed <close>
  for(i = 2; i < argc; i++){
 1f4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1fb:	3b 45 dc             	cmp    -0x24(%rbp),%eax
 1fe:	0f 8c 73 ff ff ff    	jl     177 <main+0x68>
  }
  exit();
 204:	e8 bc 04 00 00       	call   6c5 <exit>

0000000000000209 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 209:	f3 0f 1e fa          	endbr64
 20d:	55                   	push   %rbp
 20e:	48 89 e5             	mov    %rsp,%rbp
 211:	48 83 ec 10          	sub    $0x10,%rsp
 215:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 219:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '^')
 21d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 221:	0f b6 00             	movzbl (%rax),%eax
 224:	3c 5e                	cmp    $0x5e,%al
 226:	75 19                	jne    241 <match+0x38>
    return matchhere(re+1, text);
 228:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22c:	48 8d 50 01          	lea    0x1(%rax),%rdx
 230:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 234:	48 89 c6             	mov    %rax,%rsi
 237:	48 89 d7             	mov    %rdx,%rdi
 23a:	e8 3a 00 00 00       	call   279 <matchhere>
 23f:	eb 36                	jmp    277 <match+0x6e>
  do{  // must look at empty string
    if(matchhere(re, text))
 241:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 249:	48 89 d6             	mov    %rdx,%rsi
 24c:	48 89 c7             	mov    %rax,%rdi
 24f:	e8 25 00 00 00       	call   279 <matchhere>
 254:	85 c0                	test   %eax,%eax
 256:	74 07                	je     25f <match+0x56>
      return 1;
 258:	b8 01 00 00 00       	mov    $0x1,%eax
 25d:	eb 18                	jmp    277 <match+0x6e>
  }while(*text++ != '\0');
 25f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 263:	48 8d 50 01          	lea    0x1(%rax),%rdx
 267:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
 26b:	0f b6 00             	movzbl (%rax),%eax
 26e:	84 c0                	test   %al,%al
 270:	75 cf                	jne    241 <match+0x38>
  return 0;
 272:	b8 00 00 00 00       	mov    $0x0,%eax
}
 277:	c9                   	leave
 278:	c3                   	ret

0000000000000279 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 279:	f3 0f 1e fa          	endbr64
 27d:	55                   	push   %rbp
 27e:	48 89 e5             	mov    %rsp,%rbp
 281:	48 83 ec 10          	sub    $0x10,%rsp
 285:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 289:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '\0')
 28d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 291:	0f b6 00             	movzbl (%rax),%eax
 294:	84 c0                	test   %al,%al
 296:	75 0a                	jne    2a2 <matchhere+0x29>
    return 1;
 298:	b8 01 00 00 00       	mov    $0x1,%eax
 29d:	e9 a6 00 00 00       	jmp    348 <matchhere+0xcf>
  if(re[1] == '*')
 2a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2a6:	48 83 c0 01          	add    $0x1,%rax
 2aa:	0f b6 00             	movzbl (%rax),%eax
 2ad:	3c 2a                	cmp    $0x2a,%al
 2af:	75 22                	jne    2d3 <matchhere+0x5a>
    return matchstar(re[0], re+2, text);
 2b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2b5:	48 8d 48 02          	lea    0x2(%rax),%rcx
 2b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2bd:	0f b6 00             	movzbl (%rax),%eax
 2c0:	0f be c0             	movsbl %al,%eax
 2c3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 2c7:	48 89 ce             	mov    %rcx,%rsi
 2ca:	89 c7                	mov    %eax,%edi
 2cc:	e8 79 00 00 00       	call   34a <matchstar>
 2d1:	eb 75                	jmp    348 <matchhere+0xcf>
  if(re[0] == '$' && re[1] == '\0')
 2d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2d7:	0f b6 00             	movzbl (%rax),%eax
 2da:	3c 24                	cmp    $0x24,%al
 2dc:	75 20                	jne    2fe <matchhere+0x85>
 2de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2e2:	48 83 c0 01          	add    $0x1,%rax
 2e6:	0f b6 00             	movzbl (%rax),%eax
 2e9:	84 c0                	test   %al,%al
 2eb:	75 11                	jne    2fe <matchhere+0x85>
    return *text == '\0';
 2ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 2f1:	0f b6 00             	movzbl (%rax),%eax
 2f4:	84 c0                	test   %al,%al
 2f6:	0f 94 c0             	sete   %al
 2f9:	0f b6 c0             	movzbl %al,%eax
 2fc:	eb 4a                	jmp    348 <matchhere+0xcf>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 302:	0f b6 00             	movzbl (%rax),%eax
 305:	84 c0                	test   %al,%al
 307:	74 3a                	je     343 <matchhere+0xca>
 309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 30d:	0f b6 00             	movzbl (%rax),%eax
 310:	3c 2e                	cmp    $0x2e,%al
 312:	74 12                	je     326 <matchhere+0xad>
 314:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 318:	0f b6 10             	movzbl (%rax),%edx
 31b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 31f:	0f b6 00             	movzbl (%rax),%eax
 322:	38 c2                	cmp    %al,%dl
 324:	75 1d                	jne    343 <matchhere+0xca>
    return matchhere(re+1, text+1);
 326:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 32a:	48 8d 50 01          	lea    0x1(%rax),%rdx
 32e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 332:	48 83 c0 01          	add    $0x1,%rax
 336:	48 89 d6             	mov    %rdx,%rsi
 339:	48 89 c7             	mov    %rax,%rdi
 33c:	e8 38 ff ff ff       	call   279 <matchhere>
 341:	eb 05                	jmp    348 <matchhere+0xcf>
  return 0;
 343:	b8 00 00 00 00       	mov    $0x0,%eax
}
 348:	c9                   	leave
 349:	c3                   	ret

000000000000034a <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 34a:	f3 0f 1e fa          	endbr64
 34e:	55                   	push   %rbp
 34f:	48 89 e5             	mov    %rsp,%rbp
 352:	48 83 ec 20          	sub    $0x20,%rsp
 356:	89 7d fc             	mov    %edi,-0x4(%rbp)
 359:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 35d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 361:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 365:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 369:	48 89 d6             	mov    %rdx,%rsi
 36c:	48 89 c7             	mov    %rax,%rdi
 36f:	e8 05 ff ff ff       	call   279 <matchhere>
 374:	85 c0                	test   %eax,%eax
 376:	74 07                	je     37f <matchstar+0x35>
      return 1;
 378:	b8 01 00 00 00       	mov    $0x1,%eax
 37d:	eb 2d                	jmp    3ac <matchstar+0x62>
  }while(*text!='\0' && (*text++==c || c=='.'));
 37f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 383:	0f b6 00             	movzbl (%rax),%eax
 386:	84 c0                	test   %al,%al
 388:	74 1d                	je     3a7 <matchstar+0x5d>
 38a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 38e:	48 8d 50 01          	lea    0x1(%rax),%rdx
 392:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 396:	0f b6 00             	movzbl (%rax),%eax
 399:	0f be c0             	movsbl %al,%eax
 39c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
 39f:	74 c0                	je     361 <matchstar+0x17>
 3a1:	83 7d fc 2e          	cmpl   $0x2e,-0x4(%rbp)
 3a5:	74 ba                	je     361 <matchstar+0x17>
  return 0;
 3a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3ac:	c9                   	leave
 3ad:	c3                   	ret

00000000000003ae <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3ae:	55                   	push   %rbp
 3af:	48 89 e5             	mov    %rsp,%rbp
 3b2:	48 83 ec 10          	sub    $0x10,%rsp
 3b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3ba:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3bd:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3c0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3c4:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3ca:	48 89 ce             	mov    %rcx,%rsi
 3cd:	48 89 f7             	mov    %rsi,%rdi
 3d0:	89 d1                	mov    %edx,%ecx
 3d2:	fc                   	cld
 3d3:	f3 aa                	rep stos %al,%es:(%rdi)
 3d5:	89 ca                	mov    %ecx,%edx
 3d7:	48 89 fe             	mov    %rdi,%rsi
 3da:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 3de:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3e1:	90                   	nop
 3e2:	c9                   	leave
 3e3:	c3                   	ret

00000000000003e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3e4:	f3 0f 1e fa          	endbr64
 3e8:	55                   	push   %rbp
 3e9:	48 89 e5             	mov    %rsp,%rbp
 3ec:	48 83 ec 20          	sub    $0x20,%rsp
 3f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3f4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 3f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 400:	90                   	nop
 401:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 405:	48 8d 42 01          	lea    0x1(%rdx),%rax
 409:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 40d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 411:	48 8d 48 01          	lea    0x1(%rax),%rcx
 415:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 419:	0f b6 12             	movzbl (%rdx),%edx
 41c:	88 10                	mov    %dl,(%rax)
 41e:	0f b6 00             	movzbl (%rax),%eax
 421:	84 c0                	test   %al,%al
 423:	75 dc                	jne    401 <strcpy+0x1d>
    ;
  return os;
 425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 429:	c9                   	leave
 42a:	c3                   	ret

000000000000042b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 42b:	f3 0f 1e fa          	endbr64
 42f:	55                   	push   %rbp
 430:	48 89 e5             	mov    %rsp,%rbp
 433:	48 83 ec 10          	sub    $0x10,%rsp
 437:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 43b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 43f:	eb 0a                	jmp    44b <strcmp+0x20>
    p++, q++;
 441:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 446:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 44b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 44f:	0f b6 00             	movzbl (%rax),%eax
 452:	84 c0                	test   %al,%al
 454:	74 12                	je     468 <strcmp+0x3d>
 456:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 45a:	0f b6 10             	movzbl (%rax),%edx
 45d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 461:	0f b6 00             	movzbl (%rax),%eax
 464:	38 c2                	cmp    %al,%dl
 466:	74 d9                	je     441 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 468:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 46c:	0f b6 00             	movzbl (%rax),%eax
 46f:	0f b6 d0             	movzbl %al,%edx
 472:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 476:	0f b6 00             	movzbl (%rax),%eax
 479:	0f b6 c0             	movzbl %al,%eax
 47c:	29 c2                	sub    %eax,%edx
 47e:	89 d0                	mov    %edx,%eax
}
 480:	c9                   	leave
 481:	c3                   	ret

0000000000000482 <strlen>:

uint
strlen(char *s)
{
 482:	f3 0f 1e fa          	endbr64
 486:	55                   	push   %rbp
 487:	48 89 e5             	mov    %rsp,%rbp
 48a:	48 83 ec 18          	sub    $0x18,%rsp
 48e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 499:	eb 04                	jmp    49f <strlen+0x1d>
 49b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 49f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a2:	48 63 d0             	movslq %eax,%rdx
 4a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4a9:	48 01 d0             	add    %rdx,%rax
 4ac:	0f b6 00             	movzbl (%rax),%eax
 4af:	84 c0                	test   %al,%al
 4b1:	75 e8                	jne    49b <strlen+0x19>
    ;
  return n;
 4b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4b6:	c9                   	leave
 4b7:	c3                   	ret

00000000000004b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4b8:	f3 0f 1e fa          	endbr64
 4bc:	55                   	push   %rbp
 4bd:	48 89 e5             	mov    %rsp,%rbp
 4c0:	48 83 ec 10          	sub    $0x10,%rsp
 4c4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4c8:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4cb:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4ce:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4d1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4d8:	89 ce                	mov    %ecx,%esi
 4da:	48 89 c7             	mov    %rax,%rdi
 4dd:	e8 cc fe ff ff       	call   3ae <stosb>
  return dst;
 4e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 4e6:	c9                   	leave
 4e7:	c3                   	ret

00000000000004e8 <strchr>:

char*
strchr(const char *s, char c)
{
 4e8:	f3 0f 1e fa          	endbr64
 4ec:	55                   	push   %rbp
 4ed:	48 89 e5             	mov    %rsp,%rbp
 4f0:	48 83 ec 10          	sub    $0x10,%rsp
 4f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4f8:	89 f0                	mov    %esi,%eax
 4fa:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 4fd:	eb 17                	jmp    516 <strchr+0x2e>
    if(*s == c)
 4ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 503:	0f b6 00             	movzbl (%rax),%eax
 506:	38 45 f4             	cmp    %al,-0xc(%rbp)
 509:	75 06                	jne    511 <strchr+0x29>
      return (char*)s;
 50b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 50f:	eb 15                	jmp    526 <strchr+0x3e>
  for(; *s; s++)
 511:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 516:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 51a:	0f b6 00             	movzbl (%rax),%eax
 51d:	84 c0                	test   %al,%al
 51f:	75 de                	jne    4ff <strchr+0x17>
  return 0;
 521:	b8 00 00 00 00       	mov    $0x0,%eax
}
 526:	c9                   	leave
 527:	c3                   	ret

0000000000000528 <gets>:

char*
gets(char *buf, int max)
{
 528:	f3 0f 1e fa          	endbr64
 52c:	55                   	push   %rbp
 52d:	48 89 e5             	mov    %rsp,%rbp
 530:	48 83 ec 20          	sub    $0x20,%rsp
 534:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 538:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 53b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 542:	eb 48                	jmp    58c <gets+0x64>
    cc = read(0, &c, 1);
 544:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 548:	ba 01 00 00 00       	mov    $0x1,%edx
 54d:	48 89 c6             	mov    %rax,%rsi
 550:	bf 00 00 00 00       	mov    $0x0,%edi
 555:	e8 83 01 00 00       	call   6dd <read>
 55a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 55d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 561:	7e 36                	jle    599 <gets+0x71>
      break;
    buf[i++] = c;
 563:	8b 45 fc             	mov    -0x4(%rbp),%eax
 566:	8d 50 01             	lea    0x1(%rax),%edx
 569:	89 55 fc             	mov    %edx,-0x4(%rbp)
 56c:	48 63 d0             	movslq %eax,%rdx
 56f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 573:	48 01 c2             	add    %rax,%rdx
 576:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 57a:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 57c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 580:	3c 0a                	cmp    $0xa,%al
 582:	74 16                	je     59a <gets+0x72>
 584:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 588:	3c 0d                	cmp    $0xd,%al
 58a:	74 0e                	je     59a <gets+0x72>
  for(i=0; i+1 < max; ){
 58c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 58f:	83 c0 01             	add    $0x1,%eax
 592:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 595:	7f ad                	jg     544 <gets+0x1c>
 597:	eb 01                	jmp    59a <gets+0x72>
      break;
 599:	90                   	nop
      break;
  }
  buf[i] = '\0';
 59a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 59d:	48 63 d0             	movslq %eax,%rdx
 5a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5a4:	48 01 d0             	add    %rdx,%rax
 5a7:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 5aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 5ae:	c9                   	leave
 5af:	c3                   	ret

00000000000005b0 <stat>:

int
stat(char *n, struct stat *st)
{
 5b0:	f3 0f 1e fa          	endbr64
 5b4:	55                   	push   %rbp
 5b5:	48 89 e5             	mov    %rsp,%rbp
 5b8:	48 83 ec 20          	sub    $0x20,%rsp
 5bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 5c0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5c8:	be 00 00 00 00       	mov    $0x0,%esi
 5cd:	48 89 c7             	mov    %rax,%rdi
 5d0:	e8 30 01 00 00       	call   705 <open>
 5d5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5dc:	79 07                	jns    5e5 <stat+0x35>
    return -1;
 5de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5e3:	eb 21                	jmp    606 <stat+0x56>
  r = fstat(fd, st);
 5e5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 5e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5ec:	48 89 d6             	mov    %rdx,%rsi
 5ef:	89 c7                	mov    %eax,%edi
 5f1:	e8 27 01 00 00       	call   71d <fstat>
 5f6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 5f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5fc:	89 c7                	mov    %eax,%edi
 5fe:	e8 ea 00 00 00       	call   6ed <close>
  return r;
 603:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 606:	c9                   	leave
 607:	c3                   	ret

0000000000000608 <atoi>:

int
atoi(const char *s)
{
 608:	f3 0f 1e fa          	endbr64
 60c:	55                   	push   %rbp
 60d:	48 89 e5             	mov    %rsp,%rbp
 610:	48 83 ec 18          	sub    $0x18,%rsp
 614:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 618:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 61f:	eb 28                	jmp    649 <atoi+0x41>
    n = n*10 + *s++ - '0';
 621:	8b 55 fc             	mov    -0x4(%rbp),%edx
 624:	89 d0                	mov    %edx,%eax
 626:	c1 e0 02             	shl    $0x2,%eax
 629:	01 d0                	add    %edx,%eax
 62b:	01 c0                	add    %eax,%eax
 62d:	89 c1                	mov    %eax,%ecx
 62f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 633:	48 8d 50 01          	lea    0x1(%rax),%rdx
 637:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 63b:	0f b6 00             	movzbl (%rax),%eax
 63e:	0f be c0             	movsbl %al,%eax
 641:	01 c8                	add    %ecx,%eax
 643:	83 e8 30             	sub    $0x30,%eax
 646:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 649:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 64d:	0f b6 00             	movzbl (%rax),%eax
 650:	3c 2f                	cmp    $0x2f,%al
 652:	7e 0b                	jle    65f <atoi+0x57>
 654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 658:	0f b6 00             	movzbl (%rax),%eax
 65b:	3c 39                	cmp    $0x39,%al
 65d:	7e c2                	jle    621 <atoi+0x19>
  return n;
 65f:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 662:	c9                   	leave
 663:	c3                   	ret

0000000000000664 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 664:	f3 0f 1e fa          	endbr64
 668:	55                   	push   %rbp
 669:	48 89 e5             	mov    %rsp,%rbp
 66c:	48 83 ec 28          	sub    $0x28,%rsp
 670:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 674:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 678:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 67b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 67f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 683:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 687:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 68b:	eb 1d                	jmp    6aa <memmove+0x46>
    *dst++ = *src++;
 68d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 691:	48 8d 42 01          	lea    0x1(%rdx),%rax
 695:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 699:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 69d:	48 8d 48 01          	lea    0x1(%rax),%rcx
 6a1:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 6a5:	0f b6 12             	movzbl (%rdx),%edx
 6a8:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 6aa:	8b 45 dc             	mov    -0x24(%rbp),%eax
 6ad:	8d 50 ff             	lea    -0x1(%rax),%edx
 6b0:	89 55 dc             	mov    %edx,-0x24(%rbp)
 6b3:	85 c0                	test   %eax,%eax
 6b5:	7f d6                	jg     68d <memmove+0x29>
  return vdst;
 6b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 6bb:	c9                   	leave
 6bc:	c3                   	ret

00000000000006bd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6bd:	b8 01 00 00 00       	mov    $0x1,%eax
 6c2:	cd 40                	int    $0x40
 6c4:	c3                   	ret

00000000000006c5 <exit>:
SYSCALL(exit)
 6c5:	b8 02 00 00 00       	mov    $0x2,%eax
 6ca:	cd 40                	int    $0x40
 6cc:	c3                   	ret

00000000000006cd <wait>:
SYSCALL(wait)
 6cd:	b8 03 00 00 00       	mov    $0x3,%eax
 6d2:	cd 40                	int    $0x40
 6d4:	c3                   	ret

00000000000006d5 <pipe>:
SYSCALL(pipe)
 6d5:	b8 04 00 00 00       	mov    $0x4,%eax
 6da:	cd 40                	int    $0x40
 6dc:	c3                   	ret

00000000000006dd <read>:
SYSCALL(read)
 6dd:	b8 05 00 00 00       	mov    $0x5,%eax
 6e2:	cd 40                	int    $0x40
 6e4:	c3                   	ret

00000000000006e5 <write>:
SYSCALL(write)
 6e5:	b8 10 00 00 00       	mov    $0x10,%eax
 6ea:	cd 40                	int    $0x40
 6ec:	c3                   	ret

00000000000006ed <close>:
SYSCALL(close)
 6ed:	b8 15 00 00 00       	mov    $0x15,%eax
 6f2:	cd 40                	int    $0x40
 6f4:	c3                   	ret

00000000000006f5 <kill>:
SYSCALL(kill)
 6f5:	b8 06 00 00 00       	mov    $0x6,%eax
 6fa:	cd 40                	int    $0x40
 6fc:	c3                   	ret

00000000000006fd <exec>:
SYSCALL(exec)
 6fd:	b8 07 00 00 00       	mov    $0x7,%eax
 702:	cd 40                	int    $0x40
 704:	c3                   	ret

0000000000000705 <open>:
SYSCALL(open)
 705:	b8 0f 00 00 00       	mov    $0xf,%eax
 70a:	cd 40                	int    $0x40
 70c:	c3                   	ret

000000000000070d <mknod>:
SYSCALL(mknod)
 70d:	b8 11 00 00 00       	mov    $0x11,%eax
 712:	cd 40                	int    $0x40
 714:	c3                   	ret

0000000000000715 <unlink>:
SYSCALL(unlink)
 715:	b8 12 00 00 00       	mov    $0x12,%eax
 71a:	cd 40                	int    $0x40
 71c:	c3                   	ret

000000000000071d <fstat>:
SYSCALL(fstat)
 71d:	b8 08 00 00 00       	mov    $0x8,%eax
 722:	cd 40                	int    $0x40
 724:	c3                   	ret

0000000000000725 <link>:
SYSCALL(link)
 725:	b8 13 00 00 00       	mov    $0x13,%eax
 72a:	cd 40                	int    $0x40
 72c:	c3                   	ret

000000000000072d <mkdir>:
SYSCALL(mkdir)
 72d:	b8 14 00 00 00       	mov    $0x14,%eax
 732:	cd 40                	int    $0x40
 734:	c3                   	ret

0000000000000735 <chdir>:
SYSCALL(chdir)
 735:	b8 09 00 00 00       	mov    $0x9,%eax
 73a:	cd 40                	int    $0x40
 73c:	c3                   	ret

000000000000073d <dup>:
SYSCALL(dup)
 73d:	b8 0a 00 00 00       	mov    $0xa,%eax
 742:	cd 40                	int    $0x40
 744:	c3                   	ret

0000000000000745 <getpid>:
SYSCALL(getpid)
 745:	b8 0b 00 00 00       	mov    $0xb,%eax
 74a:	cd 40                	int    $0x40
 74c:	c3                   	ret

000000000000074d <sbrk>:
SYSCALL(sbrk)
 74d:	b8 0c 00 00 00       	mov    $0xc,%eax
 752:	cd 40                	int    $0x40
 754:	c3                   	ret

0000000000000755 <sleep>:
SYSCALL(sleep)
 755:	b8 0d 00 00 00       	mov    $0xd,%eax
 75a:	cd 40                	int    $0x40
 75c:	c3                   	ret

000000000000075d <uptime>:
SYSCALL(uptime)
 75d:	b8 0e 00 00 00       	mov    $0xe,%eax
 762:	cd 40                	int    $0x40
 764:	c3                   	ret

0000000000000765 <getpinfo>:
SYSCALL(getpinfo)
 765:	b8 18 00 00 00       	mov    $0x18,%eax
 76a:	cd 40                	int    $0x40
 76c:	c3                   	ret

000000000000076d <settickets>:
SYSCALL(settickets)
 76d:	b8 1b 00 00 00       	mov    $0x1b,%eax
 772:	cd 40                	int    $0x40
 774:	c3                   	ret

0000000000000775 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 775:	f3 0f 1e fa          	endbr64
 779:	55                   	push   %rbp
 77a:	48 89 e5             	mov    %rsp,%rbp
 77d:	48 83 ec 10          	sub    $0x10,%rsp
 781:	89 7d fc             	mov    %edi,-0x4(%rbp)
 784:	89 f0                	mov    %esi,%eax
 786:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 789:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 78d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 790:	ba 01 00 00 00       	mov    $0x1,%edx
 795:	48 89 ce             	mov    %rcx,%rsi
 798:	89 c7                	mov    %eax,%edi
 79a:	e8 46 ff ff ff       	call   6e5 <write>
}
 79f:	90                   	nop
 7a0:	c9                   	leave
 7a1:	c3                   	ret

00000000000007a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7a2:	f3 0f 1e fa          	endbr64
 7a6:	55                   	push   %rbp
 7a7:	48 89 e5             	mov    %rsp,%rbp
 7aa:	48 83 ec 30          	sub    $0x30,%rsp
 7ae:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7b1:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7b4:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7b7:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7c1:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7c5:	74 17                	je     7de <printint+0x3c>
 7c7:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7cb:	79 11                	jns    7de <printint+0x3c>
    neg = 1;
 7cd:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7d4:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7d7:	f7 d8                	neg    %eax
 7d9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7dc:	eb 06                	jmp    7e4 <printint+0x42>
  } else {
    x = xx;
 7de:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7e1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 7eb:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 7ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7f1:	ba 00 00 00 00       	mov    $0x0,%edx
 7f6:	f7 f6                	div    %esi
 7f8:	89 d1                	mov    %edx,%ecx
 7fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7fd:	8d 50 01             	lea    0x1(%rax),%edx
 800:	89 55 fc             	mov    %edx,-0x4(%rbp)
 803:	89 ca                	mov    %ecx,%edx
 805:	0f b6 92 80 11 00 00 	movzbl 0x1180(%rdx),%edx
 80c:	48 98                	cltq
 80e:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 812:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 815:	8b 45 f4             	mov    -0xc(%rbp),%eax
 818:	ba 00 00 00 00       	mov    $0x0,%edx
 81d:	f7 f7                	div    %edi
 81f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 822:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 826:	75 c3                	jne    7eb <printint+0x49>
  if(neg)
 828:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 82c:	74 2b                	je     859 <printint+0xb7>
    buf[i++] = '-';
 82e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 831:	8d 50 01             	lea    0x1(%rax),%edx
 834:	89 55 fc             	mov    %edx,-0x4(%rbp)
 837:	48 98                	cltq
 839:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 83e:	eb 19                	jmp    859 <printint+0xb7>
    putc(fd, buf[i]);
 840:	8b 45 fc             	mov    -0x4(%rbp),%eax
 843:	48 98                	cltq
 845:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 84a:	0f be d0             	movsbl %al,%edx
 84d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 850:	89 d6                	mov    %edx,%esi
 852:	89 c7                	mov    %eax,%edi
 854:	e8 1c ff ff ff       	call   775 <putc>
  while(--i >= 0)
 859:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 85d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 861:	79 dd                	jns    840 <printint+0x9e>
}
 863:	90                   	nop
 864:	90                   	nop
 865:	c9                   	leave
 866:	c3                   	ret

0000000000000867 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 867:	f3 0f 1e fa          	endbr64
 86b:	55                   	push   %rbp
 86c:	48 89 e5             	mov    %rsp,%rbp
 86f:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 876:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 87c:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 883:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 88a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 891:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 898:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 89f:	84 c0                	test   %al,%al
 8a1:	74 20                	je     8c3 <printf+0x5c>
 8a3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8a7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8ab:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8af:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8b3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8b7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8bb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8bf:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8c3:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8ca:	00 00 00 
 8cd:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8d4:	00 00 00 
 8d7:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8db:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8e2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 8e9:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 8f0:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8f7:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8fa:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 901:	00 00 00 
 904:	e9 a8 02 00 00       	jmp    bb1 <printf+0x34a>
    c = fmt[i] & 0xff;
 909:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 90f:	48 63 d0             	movslq %eax,%rdx
 912:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 919:	48 01 d0             	add    %rdx,%rax
 91c:	0f b6 00             	movzbl (%rax),%eax
 91f:	0f be c0             	movsbl %al,%eax
 922:	25 ff 00 00 00       	and    $0xff,%eax
 927:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 92d:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 934:	75 35                	jne    96b <printf+0x104>
      if(c == '%'){
 936:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 93d:	75 0f                	jne    94e <printf+0xe7>
        state = '%';
 93f:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 946:	00 00 00 
 949:	e9 5c 02 00 00       	jmp    baa <printf+0x343>
      } else {
        putc(fd, c);
 94e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 954:	0f be d0             	movsbl %al,%edx
 957:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 95d:	89 d6                	mov    %edx,%esi
 95f:	89 c7                	mov    %eax,%edi
 961:	e8 0f fe ff ff       	call   775 <putc>
 966:	e9 3f 02 00 00       	jmp    baa <printf+0x343>
      }
    } else if(state == '%'){
 96b:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 972:	0f 85 32 02 00 00    	jne    baa <printf+0x343>
      if(c == 'd'){
 978:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 97f:	75 5e                	jne    9df <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 981:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 987:	83 f8 2f             	cmp    $0x2f,%eax
 98a:	77 23                	ja     9af <printf+0x148>
 98c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 993:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 999:	89 d2                	mov    %edx,%edx
 99b:	48 01 d0             	add    %rdx,%rax
 99e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9a4:	83 c2 08             	add    $0x8,%edx
 9a7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9ad:	eb 12                	jmp    9c1 <printf+0x15a>
 9af:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9b6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9ba:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9c1:	8b 30                	mov    (%rax),%esi
 9c3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9c9:	b9 01 00 00 00       	mov    $0x1,%ecx
 9ce:	ba 0a 00 00 00       	mov    $0xa,%edx
 9d3:	89 c7                	mov    %eax,%edi
 9d5:	e8 c8 fd ff ff       	call   7a2 <printint>
 9da:	e9 c1 01 00 00       	jmp    ba0 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 9df:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 9e6:	74 09                	je     9f1 <printf+0x18a>
 9e8:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 9ef:	75 5e                	jne    a4f <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 9f1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9f7:	83 f8 2f             	cmp    $0x2f,%eax
 9fa:	77 23                	ja     a1f <printf+0x1b8>
 9fc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a03:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a09:	89 d2                	mov    %edx,%edx
 a0b:	48 01 d0             	add    %rdx,%rax
 a0e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a14:	83 c2 08             	add    $0x8,%edx
 a17:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a1d:	eb 12                	jmp    a31 <printf+0x1ca>
 a1f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a26:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a2a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a31:	8b 30                	mov    (%rax),%esi
 a33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a39:	b9 00 00 00 00       	mov    $0x0,%ecx
 a3e:	ba 10 00 00 00       	mov    $0x10,%edx
 a43:	89 c7                	mov    %eax,%edi
 a45:	e8 58 fd ff ff       	call   7a2 <printint>
 a4a:	e9 51 01 00 00       	jmp    ba0 <printf+0x339>
      } else if(c == 's'){
 a4f:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a56:	0f 85 98 00 00 00    	jne    af4 <printf+0x28d>
        s = va_arg(ap, char*);
 a5c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a62:	83 f8 2f             	cmp    $0x2f,%eax
 a65:	77 23                	ja     a8a <printf+0x223>
 a67:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a6e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a74:	89 d2                	mov    %edx,%edx
 a76:	48 01 d0             	add    %rdx,%rax
 a79:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a7f:	83 c2 08             	add    $0x8,%edx
 a82:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a88:	eb 12                	jmp    a9c <printf+0x235>
 a8a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a91:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a95:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a9c:	48 8b 00             	mov    (%rax),%rax
 a9f:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 aa6:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 aad:	00 
 aae:	75 31                	jne    ae1 <printf+0x27a>
          s = "(null)";
 ab0:	48 c7 85 48 ff ff ff 	movq   $0xeb6,-0xb8(%rbp)
 ab7:	b6 0e 00 00 
        while(*s != 0){
 abb:	eb 24                	jmp    ae1 <printf+0x27a>
          putc(fd, *s);
 abd:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ac4:	0f b6 00             	movzbl (%rax),%eax
 ac7:	0f be d0             	movsbl %al,%edx
 aca:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ad0:	89 d6                	mov    %edx,%esi
 ad2:	89 c7                	mov    %eax,%edi
 ad4:	e8 9c fc ff ff       	call   775 <putc>
          s++;
 ad9:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 ae0:	01 
        while(*s != 0){
 ae1:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ae8:	0f b6 00             	movzbl (%rax),%eax
 aeb:	84 c0                	test   %al,%al
 aed:	75 ce                	jne    abd <printf+0x256>
 aef:	e9 ac 00 00 00       	jmp    ba0 <printf+0x339>
        }
      } else if(c == 'c'){
 af4:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 afb:	75 56                	jne    b53 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 afd:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b03:	83 f8 2f             	cmp    $0x2f,%eax
 b06:	77 23                	ja     b2b <printf+0x2c4>
 b08:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b0f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b15:	89 d2                	mov    %edx,%edx
 b17:	48 01 d0             	add    %rdx,%rax
 b1a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b20:	83 c2 08             	add    $0x8,%edx
 b23:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b29:	eb 12                	jmp    b3d <printf+0x2d6>
 b2b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b32:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b36:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b3d:	8b 00                	mov    (%rax),%eax
 b3f:	0f be d0             	movsbl %al,%edx
 b42:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b48:	89 d6                	mov    %edx,%esi
 b4a:	89 c7                	mov    %eax,%edi
 b4c:	e8 24 fc ff ff       	call   775 <putc>
 b51:	eb 4d                	jmp    ba0 <printf+0x339>
      } else if(c == '%'){
 b53:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b5a:	75 1a                	jne    b76 <printf+0x30f>
        putc(fd, c);
 b5c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b62:	0f be d0             	movsbl %al,%edx
 b65:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b6b:	89 d6                	mov    %edx,%esi
 b6d:	89 c7                	mov    %eax,%edi
 b6f:	e8 01 fc ff ff       	call   775 <putc>
 b74:	eb 2a                	jmp    ba0 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b76:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b7c:	be 25 00 00 00       	mov    $0x25,%esi
 b81:	89 c7                	mov    %eax,%edi
 b83:	e8 ed fb ff ff       	call   775 <putc>
        putc(fd, c);
 b88:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b8e:	0f be d0             	movsbl %al,%edx
 b91:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b97:	89 d6                	mov    %edx,%esi
 b99:	89 c7                	mov    %eax,%edi
 b9b:	e8 d5 fb ff ff       	call   775 <putc>
      }
      state = 0;
 ba0:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 ba7:	00 00 00 
  for(i = 0; fmt[i]; i++){
 baa:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bb1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bb7:	48 63 d0             	movslq %eax,%rdx
 bba:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bc1:	48 01 d0             	add    %rdx,%rax
 bc4:	0f b6 00             	movzbl (%rax),%eax
 bc7:	84 c0                	test   %al,%al
 bc9:	0f 85 3a fd ff ff    	jne    909 <printf+0xa2>
    }
  }
}
 bcf:	90                   	nop
 bd0:	90                   	nop
 bd1:	c9                   	leave
 bd2:	c3                   	ret

0000000000000bd3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bd3:	f3 0f 1e fa          	endbr64
 bd7:	55                   	push   %rbp
 bd8:	48 89 e5             	mov    %rsp,%rbp
 bdb:	48 83 ec 18          	sub    $0x18,%rsp
 bdf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 be3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 be7:	48 83 e8 10          	sub    $0x10,%rax
 beb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bef:	48 8b 05 ba 09 00 00 	mov    0x9ba(%rip),%rax        # 15b0 <freep>
 bf6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bfa:	eb 2f                	jmp    c2b <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c00:	48 8b 00             	mov    (%rax),%rax
 c03:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c07:	72 17                	jb     c20 <free+0x4d>
 c09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c0d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c11:	72 2f                	jb     c42 <free+0x6f>
 c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c17:	48 8b 00             	mov    (%rax),%rax
 c1a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c1e:	72 22                	jb     c42 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c24:	48 8b 00             	mov    (%rax),%rax
 c27:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c33:	73 c7                	jae    bfc <free+0x29>
 c35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c39:	48 8b 00             	mov    (%rax),%rax
 c3c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c40:	73 ba                	jae    bfc <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c46:	8b 40 08             	mov    0x8(%rax),%eax
 c49:	89 c0                	mov    %eax,%eax
 c4b:	48 c1 e0 04          	shl    $0x4,%rax
 c4f:	48 89 c2             	mov    %rax,%rdx
 c52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c56:	48 01 c2             	add    %rax,%rdx
 c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5d:	48 8b 00             	mov    (%rax),%rax
 c60:	48 39 c2             	cmp    %rax,%rdx
 c63:	75 2d                	jne    c92 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c69:	8b 50 08             	mov    0x8(%rax),%edx
 c6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c70:	48 8b 00             	mov    (%rax),%rax
 c73:	8b 40 08             	mov    0x8(%rax),%eax
 c76:	01 c2                	add    %eax,%edx
 c78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c7c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c83:	48 8b 00             	mov    (%rax),%rax
 c86:	48 8b 10             	mov    (%rax),%rdx
 c89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c8d:	48 89 10             	mov    %rdx,(%rax)
 c90:	eb 0e                	jmp    ca0 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c96:	48 8b 10             	mov    (%rax),%rdx
 c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9d:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca4:	8b 40 08             	mov    0x8(%rax),%eax
 ca7:	89 c0                	mov    %eax,%eax
 ca9:	48 c1 e0 04          	shl    $0x4,%rax
 cad:	48 89 c2             	mov    %rax,%rdx
 cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb4:	48 01 d0             	add    %rdx,%rax
 cb7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 cbb:	75 27                	jne    ce4 <free+0x111>
    p->s.size += bp->s.size;
 cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc1:	8b 50 08             	mov    0x8(%rax),%edx
 cc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cc8:	8b 40 08             	mov    0x8(%rax),%eax
 ccb:	01 c2                	add    %eax,%edx
 ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd1:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 cd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cd8:	48 8b 10             	mov    (%rax),%rdx
 cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cdf:	48 89 10             	mov    %rdx,(%rax)
 ce2:	eb 0b                	jmp    cef <free+0x11c>
  } else
    p->s.ptr = bp;
 ce4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 cec:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 cef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf3:	48 89 05 b6 08 00 00 	mov    %rax,0x8b6(%rip)        # 15b0 <freep>
}
 cfa:	90                   	nop
 cfb:	c9                   	leave
 cfc:	c3                   	ret

0000000000000cfd <morecore>:

static Header*
morecore(uint nu)
{
 cfd:	f3 0f 1e fa          	endbr64
 d01:	55                   	push   %rbp
 d02:	48 89 e5             	mov    %rsp,%rbp
 d05:	48 83 ec 20          	sub    $0x20,%rsp
 d09:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d0c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d13:	77 07                	ja     d1c <morecore+0x1f>
    nu = 4096;
 d15:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d1c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d1f:	c1 e0 04             	shl    $0x4,%eax
 d22:	89 c7                	mov    %eax,%edi
 d24:	e8 24 fa ff ff       	call   74d <sbrk>
 d29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d2d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d32:	75 07                	jne    d3b <morecore+0x3e>
    return 0;
 d34:	b8 00 00 00 00       	mov    $0x0,%eax
 d39:	eb 29                	jmp    d64 <morecore+0x67>
  hp = (Header*)p;
 d3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d47:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d4a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d51:	48 83 c0 10          	add    $0x10,%rax
 d55:	48 89 c7             	mov    %rax,%rdi
 d58:	e8 76 fe ff ff       	call   bd3 <free>
  return freep;
 d5d:	48 8b 05 4c 08 00 00 	mov    0x84c(%rip),%rax        # 15b0 <freep>
}
 d64:	c9                   	leave
 d65:	c3                   	ret

0000000000000d66 <malloc>:

void*
malloc(uint nbytes)
{
 d66:	f3 0f 1e fa          	endbr64
 d6a:	55                   	push   %rbp
 d6b:	48 89 e5             	mov    %rsp,%rbp
 d6e:	48 83 ec 30          	sub    $0x30,%rsp
 d72:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d75:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d78:	48 83 c0 0f          	add    $0xf,%rax
 d7c:	48 c1 e8 04          	shr    $0x4,%rax
 d80:	83 c0 01             	add    $0x1,%eax
 d83:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d86:	48 8b 05 23 08 00 00 	mov    0x823(%rip),%rax        # 15b0 <freep>
 d8d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 d91:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 d96:	75 2b                	jne    dc3 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 d98:	48 c7 45 f0 a0 15 00 	movq   $0x15a0,-0x10(%rbp)
 d9f:	00 
 da0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 da4:	48 89 05 05 08 00 00 	mov    %rax,0x805(%rip)        # 15b0 <freep>
 dab:	48 8b 05 fe 07 00 00 	mov    0x7fe(%rip),%rax        # 15b0 <freep>
 db2:	48 89 05 e7 07 00 00 	mov    %rax,0x7e7(%rip)        # 15a0 <base>
    base.s.size = 0;
 db9:	c7 05 e5 07 00 00 00 	movl   $0x0,0x7e5(%rip)        # 15a8 <base+0x8>
 dc0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dc7:	48 8b 00             	mov    (%rax),%rax
 dca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 dce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dd2:	8b 40 08             	mov    0x8(%rax),%eax
 dd5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 dd8:	72 5f                	jb     e39 <malloc+0xd3>
      if(p->s.size == nunits)
 dda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dde:	8b 40 08             	mov    0x8(%rax),%eax
 de1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 de4:	75 10                	jne    df6 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 de6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dea:	48 8b 10             	mov    (%rax),%rdx
 ded:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 df1:	48 89 10             	mov    %rdx,(%rax)
 df4:	eb 2e                	jmp    e24 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dfa:	8b 40 08             	mov    0x8(%rax),%eax
 dfd:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e00:	89 c2                	mov    %eax,%edx
 e02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e06:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0d:	8b 40 08             	mov    0x8(%rax),%eax
 e10:	89 c0                	mov    %eax,%eax
 e12:	48 c1 e0 04          	shl    $0x4,%rax
 e16:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1e:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e21:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e28:	48 89 05 81 07 00 00 	mov    %rax,0x781(%rip)        # 15b0 <freep>
      return (void*)(p + 1);
 e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e33:	48 83 c0 10          	add    $0x10,%rax
 e37:	eb 41                	jmp    e7a <malloc+0x114>
    }
    if(p == freep)
 e39:	48 8b 05 70 07 00 00 	mov    0x770(%rip),%rax        # 15b0 <freep>
 e40:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e44:	75 1c                	jne    e62 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e46:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e49:	89 c7                	mov    %eax,%edi
 e4b:	e8 ad fe ff ff       	call   cfd <morecore>
 e50:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e54:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e59:	75 07                	jne    e62 <malloc+0xfc>
        return 0;
 e5b:	b8 00 00 00 00       	mov    $0x0,%eax
 e60:	eb 18                	jmp    e7a <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e66:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e6e:	48 8b 00             	mov    (%rax),%rax
 e71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e75:	e9 54 ff ff ff       	jmp    dce <malloc+0x68>
  }
}
 e7a:	c9                   	leave
 e7b:	c3                   	ret
