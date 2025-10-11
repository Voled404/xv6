
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
  25:	48 c7 45 f0 c0 11 00 	movq   $0x11c0,-0x10(%rbp)
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
  9b:	48 81 7d f0 c0 11 00 	cmpq   $0x11c0,-0x10(%rbp)
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
  b9:	48 81 ea c0 11 00 00 	sub    $0x11c0,%rdx
  c0:	29 d0                	sub    %edx,%eax
  c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
  c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
  c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  cc:	48 89 c6             	mov    %rax,%rsi
  cf:	48 c7 c7 c0 11 00 00 	mov    $0x11c0,%rdi
  d6:	e8 89 05 00 00       	call   664 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  de:	ba 00 04 00 00       	mov    $0x400,%edx
  e3:	29 c2                	sub    %eax,%edx
  e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  e8:	48 98                	cltq
  ea:	48 8d 88 c0 11 00 00 	lea    0x11c0(%rax),%rcx
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
 128:	48 c7 c6 90 0e 00 00 	mov    $0xe90,%rsi
 12f:	bf 02 00 00 00       	mov    $0x2,%edi
 134:	b8 00 00 00 00       	mov    $0x0,%eax
 139:	e8 39 07 00 00       	call   877 <printf>
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
 1be:	48 c7 c6 b0 0e 00 00 	mov    $0xeb0,%rsi
 1c5:	bf 01 00 00 00       	mov    $0x1,%edi
 1ca:	b8 00 00 00 00       	mov    $0x0,%eax
 1cf:	e8 a3 06 00 00       	call   877 <printf>
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

0000000000000775 <getfavnum>:
SYSCALL(getfavnum)
 775:	b8 1c 00 00 00       	mov    $0x1c,%eax
 77a:	cd 40                	int    $0x40
 77c:	c3                   	ret

000000000000077d <halt>:
SYSCALL(halt)
 77d:	b8 1d 00 00 00       	mov    $0x1d,%eax
 782:	cd 40                	int    $0x40
 784:	c3                   	ret

0000000000000785 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 785:	f3 0f 1e fa          	endbr64
 789:	55                   	push   %rbp
 78a:	48 89 e5             	mov    %rsp,%rbp
 78d:	48 83 ec 10          	sub    $0x10,%rsp
 791:	89 7d fc             	mov    %edi,-0x4(%rbp)
 794:	89 f0                	mov    %esi,%eax
 796:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 799:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 79d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7a0:	ba 01 00 00 00       	mov    $0x1,%edx
 7a5:	48 89 ce             	mov    %rcx,%rsi
 7a8:	89 c7                	mov    %eax,%edi
 7aa:	e8 36 ff ff ff       	call   6e5 <write>
}
 7af:	90                   	nop
 7b0:	c9                   	leave
 7b1:	c3                   	ret

00000000000007b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7b2:	f3 0f 1e fa          	endbr64
 7b6:	55                   	push   %rbp
 7b7:	48 89 e5             	mov    %rsp,%rbp
 7ba:	48 83 ec 30          	sub    $0x30,%rsp
 7be:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7c1:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7c4:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7c7:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7d1:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7d5:	74 17                	je     7ee <printint+0x3c>
 7d7:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7db:	79 11                	jns    7ee <printint+0x3c>
    neg = 1;
 7dd:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7e4:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7e7:	f7 d8                	neg    %eax
 7e9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7ec:	eb 06                	jmp    7f4 <printint+0x42>
  } else {
    x = xx;
 7ee:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7f1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 7fb:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 7fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
 801:	ba 00 00 00 00       	mov    $0x0,%edx
 806:	f7 f6                	div    %esi
 808:	89 d1                	mov    %edx,%ecx
 80a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 80d:	8d 50 01             	lea    0x1(%rax),%edx
 810:	89 55 fc             	mov    %edx,-0x4(%rbp)
 813:	89 ca                	mov    %ecx,%edx
 815:	0f b6 92 90 11 00 00 	movzbl 0x1190(%rdx),%edx
 81c:	48 98                	cltq
 81e:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 822:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 825:	8b 45 f4             	mov    -0xc(%rbp),%eax
 828:	ba 00 00 00 00       	mov    $0x0,%edx
 82d:	f7 f7                	div    %edi
 82f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 832:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 836:	75 c3                	jne    7fb <printint+0x49>
  if(neg)
 838:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 83c:	74 2b                	je     869 <printint+0xb7>
    buf[i++] = '-';
 83e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 841:	8d 50 01             	lea    0x1(%rax),%edx
 844:	89 55 fc             	mov    %edx,-0x4(%rbp)
 847:	48 98                	cltq
 849:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 84e:	eb 19                	jmp    869 <printint+0xb7>
    putc(fd, buf[i]);
 850:	8b 45 fc             	mov    -0x4(%rbp),%eax
 853:	48 98                	cltq
 855:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 85a:	0f be d0             	movsbl %al,%edx
 85d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 860:	89 d6                	mov    %edx,%esi
 862:	89 c7                	mov    %eax,%edi
 864:	e8 1c ff ff ff       	call   785 <putc>
  while(--i >= 0)
 869:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 86d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 871:	79 dd                	jns    850 <printint+0x9e>
}
 873:	90                   	nop
 874:	90                   	nop
 875:	c9                   	leave
 876:	c3                   	ret

0000000000000877 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 877:	f3 0f 1e fa          	endbr64
 87b:	55                   	push   %rbp
 87c:	48 89 e5             	mov    %rsp,%rbp
 87f:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 886:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 88c:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 893:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 89a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8a1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8a8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8af:	84 c0                	test   %al,%al
 8b1:	74 20                	je     8d3 <printf+0x5c>
 8b3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8b7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8bb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8bf:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8c3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8c7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8cb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8cf:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8d3:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8da:	00 00 00 
 8dd:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8e4:	00 00 00 
 8e7:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8eb:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8f2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 8f9:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 900:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 907:	00 00 00 
  for(i = 0; fmt[i]; i++){
 90a:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 911:	00 00 00 
 914:	e9 a8 02 00 00       	jmp    bc1 <printf+0x34a>
    c = fmt[i] & 0xff;
 919:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 91f:	48 63 d0             	movslq %eax,%rdx
 922:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 929:	48 01 d0             	add    %rdx,%rax
 92c:	0f b6 00             	movzbl (%rax),%eax
 92f:	0f be c0             	movsbl %al,%eax
 932:	25 ff 00 00 00       	and    $0xff,%eax
 937:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 93d:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 944:	75 35                	jne    97b <printf+0x104>
      if(c == '%'){
 946:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 94d:	75 0f                	jne    95e <printf+0xe7>
        state = '%';
 94f:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 956:	00 00 00 
 959:	e9 5c 02 00 00       	jmp    bba <printf+0x343>
      } else {
        putc(fd, c);
 95e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 964:	0f be d0             	movsbl %al,%edx
 967:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 96d:	89 d6                	mov    %edx,%esi
 96f:	89 c7                	mov    %eax,%edi
 971:	e8 0f fe ff ff       	call   785 <putc>
 976:	e9 3f 02 00 00       	jmp    bba <printf+0x343>
      }
    } else if(state == '%'){
 97b:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 982:	0f 85 32 02 00 00    	jne    bba <printf+0x343>
      if(c == 'd'){
 988:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 98f:	75 5e                	jne    9ef <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 991:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 997:	83 f8 2f             	cmp    $0x2f,%eax
 99a:	77 23                	ja     9bf <printf+0x148>
 99c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9a3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9a9:	89 d2                	mov    %edx,%edx
 9ab:	48 01 d0             	add    %rdx,%rax
 9ae:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9b4:	83 c2 08             	add    $0x8,%edx
 9b7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9bd:	eb 12                	jmp    9d1 <printf+0x15a>
 9bf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9c6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9ca:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9d1:	8b 30                	mov    (%rax),%esi
 9d3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9d9:	b9 01 00 00 00       	mov    $0x1,%ecx
 9de:	ba 0a 00 00 00       	mov    $0xa,%edx
 9e3:	89 c7                	mov    %eax,%edi
 9e5:	e8 c8 fd ff ff       	call   7b2 <printint>
 9ea:	e9 c1 01 00 00       	jmp    bb0 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 9ef:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 9f6:	74 09                	je     a01 <printf+0x18a>
 9f8:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 9ff:	75 5e                	jne    a5f <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a01:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a07:	83 f8 2f             	cmp    $0x2f,%eax
 a0a:	77 23                	ja     a2f <printf+0x1b8>
 a0c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a13:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a19:	89 d2                	mov    %edx,%edx
 a1b:	48 01 d0             	add    %rdx,%rax
 a1e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a24:	83 c2 08             	add    $0x8,%edx
 a27:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a2d:	eb 12                	jmp    a41 <printf+0x1ca>
 a2f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a36:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a3a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a41:	8b 30                	mov    (%rax),%esi
 a43:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a49:	b9 00 00 00 00       	mov    $0x0,%ecx
 a4e:	ba 10 00 00 00       	mov    $0x10,%edx
 a53:	89 c7                	mov    %eax,%edi
 a55:	e8 58 fd ff ff       	call   7b2 <printint>
 a5a:	e9 51 01 00 00       	jmp    bb0 <printf+0x339>
      } else if(c == 's'){
 a5f:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a66:	0f 85 98 00 00 00    	jne    b04 <printf+0x28d>
        s = va_arg(ap, char*);
 a6c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a72:	83 f8 2f             	cmp    $0x2f,%eax
 a75:	77 23                	ja     a9a <printf+0x223>
 a77:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a7e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a84:	89 d2                	mov    %edx,%edx
 a86:	48 01 d0             	add    %rdx,%rax
 a89:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a8f:	83 c2 08             	add    $0x8,%edx
 a92:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a98:	eb 12                	jmp    aac <printf+0x235>
 a9a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 aa1:	48 8d 50 08          	lea    0x8(%rax),%rdx
 aa5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 aac:	48 8b 00             	mov    (%rax),%rax
 aaf:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 ab6:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 abd:	00 
 abe:	75 31                	jne    af1 <printf+0x27a>
          s = "(null)";
 ac0:	48 c7 85 48 ff ff ff 	movq   $0xec6,-0xb8(%rbp)
 ac7:	c6 0e 00 00 
        while(*s != 0){
 acb:	eb 24                	jmp    af1 <printf+0x27a>
          putc(fd, *s);
 acd:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ad4:	0f b6 00             	movzbl (%rax),%eax
 ad7:	0f be d0             	movsbl %al,%edx
 ada:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ae0:	89 d6                	mov    %edx,%esi
 ae2:	89 c7                	mov    %eax,%edi
 ae4:	e8 9c fc ff ff       	call   785 <putc>
          s++;
 ae9:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 af0:	01 
        while(*s != 0){
 af1:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 af8:	0f b6 00             	movzbl (%rax),%eax
 afb:	84 c0                	test   %al,%al
 afd:	75 ce                	jne    acd <printf+0x256>
 aff:	e9 ac 00 00 00       	jmp    bb0 <printf+0x339>
        }
      } else if(c == 'c'){
 b04:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b0b:	75 56                	jne    b63 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b0d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b13:	83 f8 2f             	cmp    $0x2f,%eax
 b16:	77 23                	ja     b3b <printf+0x2c4>
 b18:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b1f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b25:	89 d2                	mov    %edx,%edx
 b27:	48 01 d0             	add    %rdx,%rax
 b2a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b30:	83 c2 08             	add    $0x8,%edx
 b33:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b39:	eb 12                	jmp    b4d <printf+0x2d6>
 b3b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b42:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b46:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b4d:	8b 00                	mov    (%rax),%eax
 b4f:	0f be d0             	movsbl %al,%edx
 b52:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b58:	89 d6                	mov    %edx,%esi
 b5a:	89 c7                	mov    %eax,%edi
 b5c:	e8 24 fc ff ff       	call   785 <putc>
 b61:	eb 4d                	jmp    bb0 <printf+0x339>
      } else if(c == '%'){
 b63:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b6a:	75 1a                	jne    b86 <printf+0x30f>
        putc(fd, c);
 b6c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b72:	0f be d0             	movsbl %al,%edx
 b75:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b7b:	89 d6                	mov    %edx,%esi
 b7d:	89 c7                	mov    %eax,%edi
 b7f:	e8 01 fc ff ff       	call   785 <putc>
 b84:	eb 2a                	jmp    bb0 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b86:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b8c:	be 25 00 00 00       	mov    $0x25,%esi
 b91:	89 c7                	mov    %eax,%edi
 b93:	e8 ed fb ff ff       	call   785 <putc>
        putc(fd, c);
 b98:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b9e:	0f be d0             	movsbl %al,%edx
 ba1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ba7:	89 d6                	mov    %edx,%esi
 ba9:	89 c7                	mov    %eax,%edi
 bab:	e8 d5 fb ff ff       	call   785 <putc>
      }
      state = 0;
 bb0:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bb7:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bba:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bc1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bc7:	48 63 d0             	movslq %eax,%rdx
 bca:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bd1:	48 01 d0             	add    %rdx,%rax
 bd4:	0f b6 00             	movzbl (%rax),%eax
 bd7:	84 c0                	test   %al,%al
 bd9:	0f 85 3a fd ff ff    	jne    919 <printf+0xa2>
    }
  }
}
 bdf:	90                   	nop
 be0:	90                   	nop
 be1:	c9                   	leave
 be2:	c3                   	ret

0000000000000be3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be3:	f3 0f 1e fa          	endbr64
 be7:	55                   	push   %rbp
 be8:	48 89 e5             	mov    %rsp,%rbp
 beb:	48 83 ec 18          	sub    $0x18,%rsp
 bef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bf3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 bf7:	48 83 e8 10          	sub    $0x10,%rax
 bfb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bff:	48 8b 05 ca 09 00 00 	mov    0x9ca(%rip),%rax        # 15d0 <freep>
 c06:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c0a:	eb 2f                	jmp    c3b <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c10:	48 8b 00             	mov    (%rax),%rax
 c13:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c17:	72 17                	jb     c30 <free+0x4d>
 c19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c1d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c21:	72 2f                	jb     c52 <free+0x6f>
 c23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c27:	48 8b 00             	mov    (%rax),%rax
 c2a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c2e:	72 22                	jb     c52 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c34:	48 8b 00             	mov    (%rax),%rax
 c37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c3f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c43:	73 c7                	jae    c0c <free+0x29>
 c45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c49:	48 8b 00             	mov    (%rax),%rax
 c4c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c50:	73 ba                	jae    c0c <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c56:	8b 40 08             	mov    0x8(%rax),%eax
 c59:	89 c0                	mov    %eax,%eax
 c5b:	48 c1 e0 04          	shl    $0x4,%rax
 c5f:	48 89 c2             	mov    %rax,%rdx
 c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c66:	48 01 c2             	add    %rax,%rdx
 c69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c6d:	48 8b 00             	mov    (%rax),%rax
 c70:	48 39 c2             	cmp    %rax,%rdx
 c73:	75 2d                	jne    ca2 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c79:	8b 50 08             	mov    0x8(%rax),%edx
 c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c80:	48 8b 00             	mov    (%rax),%rax
 c83:	8b 40 08             	mov    0x8(%rax),%eax
 c86:	01 c2                	add    %eax,%edx
 c88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c8c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c93:	48 8b 00             	mov    (%rax),%rax
 c96:	48 8b 10             	mov    (%rax),%rdx
 c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9d:	48 89 10             	mov    %rdx,(%rax)
 ca0:	eb 0e                	jmp    cb0 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca6:	48 8b 10             	mov    (%rax),%rdx
 ca9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cad:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb4:	8b 40 08             	mov    0x8(%rax),%eax
 cb7:	89 c0                	mov    %eax,%eax
 cb9:	48 c1 e0 04          	shl    $0x4,%rax
 cbd:	48 89 c2             	mov    %rax,%rdx
 cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc4:	48 01 d0             	add    %rdx,%rax
 cc7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 ccb:	75 27                	jne    cf4 <free+0x111>
    p->s.size += bp->s.size;
 ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd1:	8b 50 08             	mov    0x8(%rax),%edx
 cd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cd8:	8b 40 08             	mov    0x8(%rax),%eax
 cdb:	01 c2                	add    %eax,%edx
 cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce1:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce8:	48 8b 10             	mov    (%rax),%rdx
 ceb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cef:	48 89 10             	mov    %rdx,(%rax)
 cf2:	eb 0b                	jmp    cff <free+0x11c>
  } else
    p->s.ptr = bp;
 cf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 cfc:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d03:	48 89 05 c6 08 00 00 	mov    %rax,0x8c6(%rip)        # 15d0 <freep>
}
 d0a:	90                   	nop
 d0b:	c9                   	leave
 d0c:	c3                   	ret

0000000000000d0d <morecore>:

static Header*
morecore(uint nu)
{
 d0d:	f3 0f 1e fa          	endbr64
 d11:	55                   	push   %rbp
 d12:	48 89 e5             	mov    %rsp,%rbp
 d15:	48 83 ec 20          	sub    $0x20,%rsp
 d19:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d1c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d23:	77 07                	ja     d2c <morecore+0x1f>
    nu = 4096;
 d25:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d2f:	c1 e0 04             	shl    $0x4,%eax
 d32:	89 c7                	mov    %eax,%edi
 d34:	e8 14 fa ff ff       	call   74d <sbrk>
 d39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d3d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d42:	75 07                	jne    d4b <morecore+0x3e>
    return 0;
 d44:	b8 00 00 00 00       	mov    $0x0,%eax
 d49:	eb 29                	jmp    d74 <morecore+0x67>
  hp = (Header*)p;
 d4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d4f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d57:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d5a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d61:	48 83 c0 10          	add    $0x10,%rax
 d65:	48 89 c7             	mov    %rax,%rdi
 d68:	e8 76 fe ff ff       	call   be3 <free>
  return freep;
 d6d:	48 8b 05 5c 08 00 00 	mov    0x85c(%rip),%rax        # 15d0 <freep>
}
 d74:	c9                   	leave
 d75:	c3                   	ret

0000000000000d76 <malloc>:

void*
malloc(uint nbytes)
{
 d76:	f3 0f 1e fa          	endbr64
 d7a:	55                   	push   %rbp
 d7b:	48 89 e5             	mov    %rsp,%rbp
 d7e:	48 83 ec 30          	sub    $0x30,%rsp
 d82:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d85:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d88:	48 83 c0 0f          	add    $0xf,%rax
 d8c:	48 c1 e8 04          	shr    $0x4,%rax
 d90:	83 c0 01             	add    $0x1,%eax
 d93:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d96:	48 8b 05 33 08 00 00 	mov    0x833(%rip),%rax        # 15d0 <freep>
 d9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 da1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 da6:	75 2b                	jne    dd3 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 da8:	48 c7 45 f0 c0 15 00 	movq   $0x15c0,-0x10(%rbp)
 daf:	00 
 db0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 db4:	48 89 05 15 08 00 00 	mov    %rax,0x815(%rip)        # 15d0 <freep>
 dbb:	48 8b 05 0e 08 00 00 	mov    0x80e(%rip),%rax        # 15d0 <freep>
 dc2:	48 89 05 f7 07 00 00 	mov    %rax,0x7f7(%rip)        # 15c0 <base>
    base.s.size = 0;
 dc9:	c7 05 f5 07 00 00 00 	movl   $0x0,0x7f5(%rip)        # 15c8 <base+0x8>
 dd0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dd7:	48 8b 00             	mov    (%rax),%rax
 dda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 dde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 de2:	8b 40 08             	mov    0x8(%rax),%eax
 de5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 de8:	72 5f                	jb     e49 <malloc+0xd3>
      if(p->s.size == nunits)
 dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dee:	8b 40 08             	mov    0x8(%rax),%eax
 df1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 df4:	75 10                	jne    e06 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dfa:	48 8b 10             	mov    (%rax),%rdx
 dfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e01:	48 89 10             	mov    %rdx,(%rax)
 e04:	eb 2e                	jmp    e34 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0a:	8b 40 08             	mov    0x8(%rax),%eax
 e0d:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e10:	89 c2                	mov    %eax,%edx
 e12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e16:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1d:	8b 40 08             	mov    0x8(%rax),%eax
 e20:	89 c0                	mov    %eax,%eax
 e22:	48 c1 e0 04          	shl    $0x4,%rax
 e26:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2e:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e31:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e38:	48 89 05 91 07 00 00 	mov    %rax,0x791(%rip)        # 15d0 <freep>
      return (void*)(p + 1);
 e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e43:	48 83 c0 10          	add    $0x10,%rax
 e47:	eb 41                	jmp    e8a <malloc+0x114>
    }
    if(p == freep)
 e49:	48 8b 05 80 07 00 00 	mov    0x780(%rip),%rax        # 15d0 <freep>
 e50:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e54:	75 1c                	jne    e72 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e56:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e59:	89 c7                	mov    %eax,%edi
 e5b:	e8 ad fe ff ff       	call   d0d <morecore>
 e60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e64:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e69:	75 07                	jne    e72 <malloc+0xfc>
        return 0;
 e6b:	b8 00 00 00 00       	mov    $0x0,%eax
 e70:	eb 18                	jmp    e8a <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e76:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e7e:	48 8b 00             	mov    (%rax),%rax
 e81:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e85:	e9 54 ff ff ff       	jmp    dde <malloc+0x68>
  }
}
 e8a:	c9                   	leave
 e8b:	c3                   	ret
