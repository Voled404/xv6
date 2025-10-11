
fs/sh:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	f3 0f 1e fa          	endbr64
       4:	55                   	push   %rbp
       5:	48 89 e5             	mov    %rsp,%rbp
       8:	48 83 ec 40          	sub    $0x40,%rsp
       c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
      10:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
      15:	75 05                	jne    1c <runcmd+0x1c>
    exit();
      17:	e8 45 11 00 00       	call   1161 <exit>
  
  switch(cmd->type){
      1c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      20:	8b 00                	mov    (%rax),%eax
      22:	83 f8 05             	cmp    $0x5,%eax
      25:	77 0d                	ja     34 <runcmd+0x34>
      27:	89 c0                	mov    %eax,%eax
      29:	48 8b 04 c5 60 19 00 	mov    0x1960(,%rax,8),%rax
      30:	00 
      31:	3e ff e0             	notrack jmp *%rax
  default:
    panic("runcmd");
      34:	48 c7 c7 30 19 00 00 	mov    $0x1930,%rdi
      3b:	e8 48 03 00 00       	call   388 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      40:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      44:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if(ecmd->argv[0] == 0)
      48:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      4c:	48 8b 40 08          	mov    0x8(%rax),%rax
      50:	48 85 c0             	test   %rax,%rax
      53:	75 05                	jne    5a <runcmd+0x5a>
      exit();
      55:	e8 07 11 00 00       	call   1161 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      5e:	48 8d 50 08          	lea    0x8(%rax),%rdx
      62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      66:	48 8b 40 08          	mov    0x8(%rax),%rax
      6a:	48 89 d6             	mov    %rdx,%rsi
      6d:	48 89 c7             	mov    %rax,%rdi
      70:	e8 24 11 00 00       	call   1199 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      79:	48 8b 40 08          	mov    0x8(%rax),%rax
      7d:	48 89 c2             	mov    %rax,%rdx
      80:	48 c7 c6 37 19 00 00 	mov    $0x1937,%rsi
      87:	bf 02 00 00 00       	mov    $0x2,%edi
      8c:	b8 00 00 00 00       	mov    $0x0,%eax
      91:	e8 85 12 00 00       	call   131b <printf>
    break;
      96:	e9 91 01 00 00       	jmp    22c <runcmd+0x22c>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      9f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    close(rcmd->fd);
      a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      a7:	8b 40 24             	mov    0x24(%rax),%eax
      aa:	89 c7                	mov    %eax,%edi
      ac:	e8 d8 10 00 00       	call   1189 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      b1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      b5:	8b 50 20             	mov    0x20(%rax),%edx
      b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      bc:	48 8b 40 10          	mov    0x10(%rax),%rax
      c0:	89 d6                	mov    %edx,%esi
      c2:	48 89 c7             	mov    %rax,%rdi
      c5:	e8 d7 10 00 00       	call   11a1 <open>
      ca:	85 c0                	test   %eax,%eax
      cc:	79 26                	jns    f4 <runcmd+0xf4>
      printf(2, "open %s failed\n", rcmd->file);
      ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      d2:	48 8b 40 10          	mov    0x10(%rax),%rax
      d6:	48 89 c2             	mov    %rax,%rdx
      d9:	48 c7 c6 47 19 00 00 	mov    $0x1947,%rsi
      e0:	bf 02 00 00 00       	mov    $0x2,%edi
      e5:	b8 00 00 00 00       	mov    $0x0,%eax
      ea:	e8 2c 12 00 00       	call   131b <printf>
      exit();
      ef:	e8 6d 10 00 00       	call   1161 <exit>
    }
    runcmd(rcmd->cmd);
      f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      f8:	48 8b 40 08          	mov    0x8(%rax),%rax
      fc:	48 89 c7             	mov    %rax,%rdi
      ff:	e8 fc fe ff ff       	call   0 <runcmd>
    break;
     104:	e9 23 01 00 00       	jmp    22c <runcmd+0x22c>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     109:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     10d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(fork1() == 0)
     111:	e8 a4 02 00 00       	call   3ba <fork1>
     116:	85 c0                	test   %eax,%eax
     118:	75 10                	jne    12a <runcmd+0x12a>
      runcmd(lcmd->left);
     11a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     11e:	48 8b 40 08          	mov    0x8(%rax),%rax
     122:	48 89 c7             	mov    %rax,%rdi
     125:	e8 d6 fe ff ff       	call   0 <runcmd>
    wait();
     12a:	e8 3a 10 00 00       	call   1169 <wait>
    runcmd(lcmd->right);
     12f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     133:	48 8b 40 10          	mov    0x10(%rax),%rax
     137:	48 89 c7             	mov    %rax,%rdi
     13a:	e8 c1 fe ff ff       	call   0 <runcmd>
    break;
     13f:	e9 e8 00 00 00       	jmp    22c <runcmd+0x22c>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     144:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     148:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(pipe(p) < 0)
     14c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
     150:	48 89 c7             	mov    %rax,%rdi
     153:	e8 19 10 00 00       	call   1171 <pipe>
     158:	85 c0                	test   %eax,%eax
     15a:	79 0c                	jns    168 <runcmd+0x168>
      panic("pipe");
     15c:	48 c7 c7 57 19 00 00 	mov    $0x1957,%rdi
     163:	e8 20 02 00 00       	call   388 <panic>
    if(fork1() == 0){
     168:	e8 4d 02 00 00       	call   3ba <fork1>
     16d:	85 c0                	test   %eax,%eax
     16f:	75 38                	jne    1a9 <runcmd+0x1a9>
      close(1);
     171:	bf 01 00 00 00       	mov    $0x1,%edi
     176:	e8 0e 10 00 00       	call   1189 <close>
      dup(p[1]);
     17b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     17e:	89 c7                	mov    %eax,%edi
     180:	e8 54 10 00 00       	call   11d9 <dup>
      close(p[0]);
     185:	8b 45 d0             	mov    -0x30(%rbp),%eax
     188:	89 c7                	mov    %eax,%edi
     18a:	e8 fa 0f 00 00       	call   1189 <close>
      close(p[1]);
     18f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     192:	89 c7                	mov    %eax,%edi
     194:	e8 f0 0f 00 00       	call   1189 <close>
      runcmd(pcmd->left);
     199:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     19d:	48 8b 40 08          	mov    0x8(%rax),%rax
     1a1:	48 89 c7             	mov    %rax,%rdi
     1a4:	e8 57 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     1a9:	e8 0c 02 00 00       	call   3ba <fork1>
     1ae:	85 c0                	test   %eax,%eax
     1b0:	75 38                	jne    1ea <runcmd+0x1ea>
      close(0);
     1b2:	bf 00 00 00 00       	mov    $0x0,%edi
     1b7:	e8 cd 0f 00 00       	call   1189 <close>
      dup(p[0]);
     1bc:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1bf:	89 c7                	mov    %eax,%edi
     1c1:	e8 13 10 00 00       	call   11d9 <dup>
      close(p[0]);
     1c6:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1c9:	89 c7                	mov    %eax,%edi
     1cb:	e8 b9 0f 00 00       	call   1189 <close>
      close(p[1]);
     1d0:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     1d3:	89 c7                	mov    %eax,%edi
     1d5:	e8 af 0f 00 00       	call   1189 <close>
      runcmd(pcmd->right);
     1da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     1de:	48 8b 40 10          	mov    0x10(%rax),%rax
     1e2:	48 89 c7             	mov    %rax,%rdi
     1e5:	e8 16 fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1ea:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1ed:	89 c7                	mov    %eax,%edi
     1ef:	e8 95 0f 00 00       	call   1189 <close>
    close(p[1]);
     1f4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     1f7:	89 c7                	mov    %eax,%edi
     1f9:	e8 8b 0f 00 00       	call   1189 <close>
    wait();
     1fe:	e8 66 0f 00 00       	call   1169 <wait>
    wait();
     203:	e8 61 0f 00 00       	call   1169 <wait>
    break;
     208:	eb 22                	jmp    22c <runcmd+0x22c>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     20a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     20e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(fork1() == 0)
     212:	e8 a3 01 00 00       	call   3ba <fork1>
     217:	85 c0                	test   %eax,%eax
     219:	75 10                	jne    22b <runcmd+0x22b>
      runcmd(bcmd->cmd);
     21b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     21f:	48 8b 40 08          	mov    0x8(%rax),%rax
     223:	48 89 c7             	mov    %rax,%rdi
     226:	e8 d5 fd ff ff       	call   0 <runcmd>
    break;
     22b:	90                   	nop
  }
  exit();
     22c:	e8 30 0f 00 00       	call   1161 <exit>

0000000000000231 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     231:	f3 0f 1e fa          	endbr64
     235:	55                   	push   %rbp
     236:	48 89 e5             	mov    %rsp,%rbp
     239:	48 83 ec 10          	sub    $0x10,%rsp
     23d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     241:	89 75 f4             	mov    %esi,-0xc(%rbp)
  printf(2, "$ ");
     244:	48 c7 c6 90 19 00 00 	mov    $0x1990,%rsi
     24b:	bf 02 00 00 00       	mov    $0x2,%edi
     250:	b8 00 00 00 00       	mov    $0x0,%eax
     255:	e8 c1 10 00 00       	call   131b <printf>
  memset(buf, 0, nbuf);
     25a:	8b 55 f4             	mov    -0xc(%rbp),%edx
     25d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     261:	be 00 00 00 00       	mov    $0x0,%esi
     266:	48 89 c7             	mov    %rax,%rdi
     269:	e8 e6 0c 00 00       	call   f54 <memset>
  gets(buf, nbuf);
     26e:	8b 55 f4             	mov    -0xc(%rbp),%edx
     271:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     275:	89 d6                	mov    %edx,%esi
     277:	48 89 c7             	mov    %rax,%rdi
     27a:	e8 45 0d 00 00       	call   fc4 <gets>
  if(buf[0] == 0) // EOF
     27f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     283:	0f b6 00             	movzbl (%rax),%eax
     286:	84 c0                	test   %al,%al
     288:	75 07                	jne    291 <getcmd+0x60>
    return -1;
     28a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     28f:	eb 05                	jmp    296 <getcmd+0x65>
  return 0;
     291:	b8 00 00 00 00       	mov    $0x0,%eax
}
     296:	c9                   	leave
     297:	c3                   	ret

0000000000000298 <main>:

int
main(void)
{
     298:	f3 0f 1e fa          	endbr64
     29c:	55                   	push   %rbp
     29d:	48 89 e5             	mov    %rsp,%rbp
     2a0:	48 83 ec 10          	sub    $0x10,%rsp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2a4:	eb 12                	jmp    2b8 <main+0x20>
    if(fd >= 3){
     2a6:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
     2aa:	7e 0c                	jle    2b8 <main+0x20>
      close(fd);
     2ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
     2af:	89 c7                	mov    %eax,%edi
     2b1:	e8 d3 0e 00 00       	call   1189 <close>
      break;
     2b6:	eb 1a                	jmp    2d2 <main+0x3a>
  while((fd = open("console", O_RDWR)) >= 0){
     2b8:	be 02 00 00 00       	mov    $0x2,%esi
     2bd:	48 c7 c7 93 19 00 00 	mov    $0x1993,%rdi
     2c4:	e8 d8 0e 00 00       	call   11a1 <open>
     2c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
     2cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     2d0:	79 d4                	jns    2a6 <main+0xe>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2d2:	e9 93 00 00 00       	jmp    36a <main+0xd2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2d7:	0f b6 05 22 1c 00 00 	movzbl 0x1c22(%rip),%eax        # 1f00 <buf.0>
     2de:	3c 63                	cmp    $0x63,%al
     2e0:	75 63                	jne    345 <main+0xad>
     2e2:	0f b6 05 18 1c 00 00 	movzbl 0x1c18(%rip),%eax        # 1f01 <buf.0+0x1>
     2e9:	3c 64                	cmp    $0x64,%al
     2eb:	75 58                	jne    345 <main+0xad>
     2ed:	0f b6 05 0e 1c 00 00 	movzbl 0x1c0e(%rip),%eax        # 1f02 <buf.0+0x2>
     2f4:	3c 20                	cmp    $0x20,%al
     2f6:	75 4d                	jne    345 <main+0xad>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2f8:	48 c7 c7 00 1f 00 00 	mov    $0x1f00,%rdi
     2ff:	e8 1a 0c 00 00       	call   f1e <strlen>
     304:	83 e8 01             	sub    $0x1,%eax
     307:	89 c0                	mov    %eax,%eax
     309:	c6 80 00 1f 00 00 00 	movb   $0x0,0x1f00(%rax)
      if(chdir(buf+3) < 0)
     310:	48 c7 c0 03 1f 00 00 	mov    $0x1f03,%rax
     317:	48 89 c7             	mov    %rax,%rdi
     31a:	e8 b2 0e 00 00       	call   11d1 <chdir>
     31f:	85 c0                	test   %eax,%eax
     321:	79 46                	jns    369 <main+0xd1>
        printf(2, "cannot cd %s\n", buf+3);
     323:	48 c7 c0 03 1f 00 00 	mov    $0x1f03,%rax
     32a:	48 89 c2             	mov    %rax,%rdx
     32d:	48 c7 c6 9b 19 00 00 	mov    $0x199b,%rsi
     334:	bf 02 00 00 00       	mov    $0x2,%edi
     339:	b8 00 00 00 00       	mov    $0x0,%eax
     33e:	e8 d8 0f 00 00       	call   131b <printf>
      continue;
     343:	eb 24                	jmp    369 <main+0xd1>
    }
    if(fork1() == 0)
     345:	e8 70 00 00 00       	call   3ba <fork1>
     34a:	85 c0                	test   %eax,%eax
     34c:	75 14                	jne    362 <main+0xca>
      runcmd(parsecmd(buf));
     34e:	48 c7 c7 00 1f 00 00 	mov    $0x1f00,%rdi
     355:	e8 77 04 00 00       	call   7d1 <parsecmd>
     35a:	48 89 c7             	mov    %rax,%rdi
     35d:	e8 9e fc ff ff       	call   0 <runcmd>
    wait();
     362:	e8 02 0e 00 00       	call   1169 <wait>
     367:	eb 01                	jmp    36a <main+0xd2>
      continue;
     369:	90                   	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     36a:	be 64 00 00 00       	mov    $0x64,%esi
     36f:	48 c7 c7 00 1f 00 00 	mov    $0x1f00,%rdi
     376:	e8 b6 fe ff ff       	call   231 <getcmd>
     37b:	85 c0                	test   %eax,%eax
     37d:	0f 89 54 ff ff ff    	jns    2d7 <main+0x3f>
  }
  exit();
     383:	e8 d9 0d 00 00       	call   1161 <exit>

0000000000000388 <panic>:
}

void
panic(char *s)
{
     388:	f3 0f 1e fa          	endbr64
     38c:	55                   	push   %rbp
     38d:	48 89 e5             	mov    %rsp,%rbp
     390:	48 83 ec 10          	sub    $0x10,%rsp
     394:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  printf(2, "%s\n", s);
     398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     39c:	48 89 c2             	mov    %rax,%rdx
     39f:	48 c7 c6 a9 19 00 00 	mov    $0x19a9,%rsi
     3a6:	bf 02 00 00 00       	mov    $0x2,%edi
     3ab:	b8 00 00 00 00       	mov    $0x0,%eax
     3b0:	e8 66 0f 00 00       	call   131b <printf>
  exit();
     3b5:	e8 a7 0d 00 00       	call   1161 <exit>

00000000000003ba <fork1>:
}

int
fork1(void)
{
     3ba:	f3 0f 1e fa          	endbr64
     3be:	55                   	push   %rbp
     3bf:	48 89 e5             	mov    %rsp,%rbp
     3c2:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;
  
  pid = fork();
     3c6:	e8 8e 0d 00 00       	call   1159 <fork>
     3cb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid == -1)
     3ce:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
     3d2:	75 0c                	jne    3e0 <fork1+0x26>
    panic("fork");
     3d4:	48 c7 c7 ad 19 00 00 	mov    $0x19ad,%rdi
     3db:	e8 a8 ff ff ff       	call   388 <panic>
  return pid;
     3e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     3e3:	c9                   	leave
     3e4:	c3                   	ret

00000000000003e5 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3e5:	f3 0f 1e fa          	endbr64
     3e9:	55                   	push   %rbp
     3ea:	48 89 e5             	mov    %rsp,%rbp
     3ed:	48 83 ec 10          	sub    $0x10,%rsp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f1:	bf a8 00 00 00       	mov    $0xa8,%edi
     3f6:	e8 1f 14 00 00       	call   181a <malloc>
     3fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     3ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     403:	ba a8 00 00 00       	mov    $0xa8,%edx
     408:	be 00 00 00 00       	mov    $0x0,%esi
     40d:	48 89 c7             	mov    %rax,%rdi
     410:	e8 3f 0b 00 00       	call   f54 <memset>
  cmd->type = EXEC;
     415:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     419:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  return (struct cmd*)cmd;
     41f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     423:	c9                   	leave
     424:	c3                   	ret

0000000000000425 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     425:	f3 0f 1e fa          	endbr64
     429:	55                   	push   %rbp
     42a:	48 89 e5             	mov    %rsp,%rbp
     42d:	48 83 ec 30          	sub    $0x30,%rsp
     431:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     435:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     439:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
     43d:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
     440:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     444:	bf 28 00 00 00       	mov    $0x28,%edi
     449:	e8 cc 13 00 00       	call   181a <malloc>
     44e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     452:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     456:	ba 28 00 00 00       	mov    $0x28,%edx
     45b:	be 00 00 00 00       	mov    $0x0,%esi
     460:	48 89 c7             	mov    %rax,%rdi
     463:	e8 ec 0a 00 00       	call   f54 <memset>
  cmd->type = REDIR;
     468:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     46c:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  cmd->cmd = subcmd;
     472:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     476:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     47a:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->file = file;
     47e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     482:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     486:	48 89 50 10          	mov    %rdx,0x10(%rax)
  cmd->efile = efile;
     48a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     48e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
     492:	48 89 50 18          	mov    %rdx,0x18(%rax)
  cmd->mode = mode;
     496:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     49a:	8b 55 d4             	mov    -0x2c(%rbp),%edx
     49d:	89 50 20             	mov    %edx,0x20(%rax)
  cmd->fd = fd;
     4a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4a4:	8b 55 d0             	mov    -0x30(%rbp),%edx
     4a7:	89 50 24             	mov    %edx,0x24(%rax)
  return (struct cmd*)cmd;
     4aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     4ae:	c9                   	leave
     4af:	c3                   	ret

00000000000004b0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4b0:	f3 0f 1e fa          	endbr64
     4b4:	55                   	push   %rbp
     4b5:	48 89 e5             	mov    %rsp,%rbp
     4b8:	48 83 ec 20          	sub    $0x20,%rsp
     4bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     4c0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4c4:	bf 18 00 00 00       	mov    $0x18,%edi
     4c9:	e8 4c 13 00 00       	call   181a <malloc>
     4ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     4d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4d6:	ba 18 00 00 00       	mov    $0x18,%edx
     4db:	be 00 00 00 00       	mov    $0x0,%esi
     4e0:	48 89 c7             	mov    %rax,%rdi
     4e3:	e8 6c 0a 00 00       	call   f54 <memset>
  cmd->type = PIPE;
     4e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4ec:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
  cmd->left = left;
     4f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4f6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     4fa:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
     4fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     502:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     506:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
     50a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     50e:	c9                   	leave
     50f:	c3                   	ret

0000000000000510 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     510:	f3 0f 1e fa          	endbr64
     514:	55                   	push   %rbp
     515:	48 89 e5             	mov    %rsp,%rbp
     518:	48 83 ec 20          	sub    $0x20,%rsp
     51c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     520:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     524:	bf 18 00 00 00       	mov    $0x18,%edi
     529:	e8 ec 12 00 00       	call   181a <malloc>
     52e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     532:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     536:	ba 18 00 00 00       	mov    $0x18,%edx
     53b:	be 00 00 00 00       	mov    $0x0,%esi
     540:	48 89 c7             	mov    %rax,%rdi
     543:	e8 0c 0a 00 00       	call   f54 <memset>
  cmd->type = LIST;
     548:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     54c:	c7 00 04 00 00 00    	movl   $0x4,(%rax)
  cmd->left = left;
     552:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     556:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     55a:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
     55e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     562:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     566:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
     56a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     56e:	c9                   	leave
     56f:	c3                   	ret

0000000000000570 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     570:	f3 0f 1e fa          	endbr64
     574:	55                   	push   %rbp
     575:	48 89 e5             	mov    %rsp,%rbp
     578:	48 83 ec 20          	sub    $0x20,%rsp
     57c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     580:	bf 10 00 00 00       	mov    $0x10,%edi
     585:	e8 90 12 00 00       	call   181a <malloc>
     58a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     58e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     592:	ba 10 00 00 00       	mov    $0x10,%edx
     597:	be 00 00 00 00       	mov    $0x0,%esi
     59c:	48 89 c7             	mov    %rax,%rdi
     59f:	e8 b0 09 00 00       	call   f54 <memset>
  cmd->type = BACK;
     5a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5a8:	c7 00 05 00 00 00    	movl   $0x5,(%rax)
  cmd->cmd = subcmd;
     5ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5b2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     5b6:	48 89 50 08          	mov    %rdx,0x8(%rax)
  return (struct cmd*)cmd;
     5ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     5be:	c9                   	leave
     5bf:	c3                   	ret

00000000000005c0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     5c0:	f3 0f 1e fa          	endbr64
     5c4:	55                   	push   %rbp
     5c5:	48 89 e5             	mov    %rsp,%rbp
     5c8:	48 83 ec 30          	sub    $0x30,%rsp
     5cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     5d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     5d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
     5d8:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
  char *s;
  int ret;
  
  s = *ps;
     5dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     5e0:	48 8b 00             	mov    (%rax),%rax
     5e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     5e7:	eb 05                	jmp    5ee <gettoken+0x2e>
    s++;
     5e9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     5ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5f2:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     5f6:	73 1d                	jae    615 <gettoken+0x55>
     5f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5fc:	0f b6 00             	movzbl (%rax),%eax
     5ff:	0f be c0             	movsbl %al,%eax
     602:	89 c6                	mov    %eax,%esi
     604:	48 c7 c7 d0 1e 00 00 	mov    $0x1ed0,%rdi
     60b:	e8 74 09 00 00       	call   f84 <strchr>
     610:	48 85 c0             	test   %rax,%rax
     613:	75 d4                	jne    5e9 <gettoken+0x29>
  if(q)
     615:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
     61a:	74 0b                	je     627 <gettoken+0x67>
    *q = s;
     61c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     620:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     624:	48 89 10             	mov    %rdx,(%rax)
  ret = *s;
     627:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     62b:	0f b6 00             	movzbl (%rax),%eax
     62e:	0f be c0             	movsbl %al,%eax
     631:	89 45 f4             	mov    %eax,-0xc(%rbp)
  switch(*s){
     634:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     638:	0f b6 00             	movzbl (%rax),%eax
     63b:	0f be c0             	movsbl %al,%eax
     63e:	83 f8 7c             	cmp    $0x7c,%eax
     641:	74 2c                	je     66f <gettoken+0xaf>
     643:	83 f8 7c             	cmp    $0x7c,%eax
     646:	7f 4c                	jg     694 <gettoken+0xd4>
     648:	83 f8 3e             	cmp    $0x3e,%eax
     64b:	74 29                	je     676 <gettoken+0xb6>
     64d:	83 f8 3e             	cmp    $0x3e,%eax
     650:	7f 42                	jg     694 <gettoken+0xd4>
     652:	83 f8 3c             	cmp    $0x3c,%eax
     655:	7f 3d                	jg     694 <gettoken+0xd4>
     657:	83 f8 3b             	cmp    $0x3b,%eax
     65a:	7d 13                	jge    66f <gettoken+0xaf>
     65c:	83 f8 29             	cmp    $0x29,%eax
     65f:	7f 33                	jg     694 <gettoken+0xd4>
     661:	83 f8 28             	cmp    $0x28,%eax
     664:	7d 09                	jge    66f <gettoken+0xaf>
     666:	85 c0                	test   %eax,%eax
     668:	74 7e                	je     6e8 <gettoken+0x128>
     66a:	83 f8 26             	cmp    $0x26,%eax
     66d:	75 25                	jne    694 <gettoken+0xd4>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     66f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    break;
     674:	eb 79                	jmp    6ef <gettoken+0x12f>
  case '>':
    s++;
     676:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    if(*s == '>'){
     67b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     67f:	0f b6 00             	movzbl (%rax),%eax
     682:	3c 3e                	cmp    $0x3e,%al
     684:	75 65                	jne    6eb <gettoken+0x12b>
      ret = '+';
     686:	c7 45 f4 2b 00 00 00 	movl   $0x2b,-0xc(%rbp)
      s++;
     68d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    }
    break;
     692:	eb 57                	jmp    6eb <gettoken+0x12b>
  default:
    ret = 'a';
     694:	c7 45 f4 61 00 00 00 	movl   $0x61,-0xc(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     69b:	eb 05                	jmp    6a2 <gettoken+0xe2>
      s++;
     69d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6a6:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     6aa:	73 42                	jae    6ee <gettoken+0x12e>
     6ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6b0:	0f b6 00             	movzbl (%rax),%eax
     6b3:	0f be c0             	movsbl %al,%eax
     6b6:	89 c6                	mov    %eax,%esi
     6b8:	48 c7 c7 d0 1e 00 00 	mov    $0x1ed0,%rdi
     6bf:	e8 c0 08 00 00       	call   f84 <strchr>
     6c4:	48 85 c0             	test   %rax,%rax
     6c7:	75 25                	jne    6ee <gettoken+0x12e>
     6c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6cd:	0f b6 00             	movzbl (%rax),%eax
     6d0:	0f be c0             	movsbl %al,%eax
     6d3:	89 c6                	mov    %eax,%esi
     6d5:	48 c7 c7 d8 1e 00 00 	mov    $0x1ed8,%rdi
     6dc:	e8 a3 08 00 00       	call   f84 <strchr>
     6e1:	48 85 c0             	test   %rax,%rax
     6e4:	74 b7                	je     69d <gettoken+0xdd>
    break;
     6e6:	eb 06                	jmp    6ee <gettoken+0x12e>
    break;
     6e8:	90                   	nop
     6e9:	eb 04                	jmp    6ef <gettoken+0x12f>
    break;
     6eb:	90                   	nop
     6ec:	eb 01                	jmp    6ef <gettoken+0x12f>
    break;
     6ee:	90                   	nop
  }
  if(eq)
     6ef:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
     6f4:	74 12                	je     708 <gettoken+0x148>
    *eq = s;
     6f6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     6fa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     6fe:	48 89 10             	mov    %rdx,(%rax)
  
  while(s < es && strchr(whitespace, *s))
     701:	eb 05                	jmp    708 <gettoken+0x148>
    s++;
     703:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     708:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     70c:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     710:	73 1d                	jae    72f <gettoken+0x16f>
     712:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     716:	0f b6 00             	movzbl (%rax),%eax
     719:	0f be c0             	movsbl %al,%eax
     71c:	89 c6                	mov    %eax,%esi
     71e:	48 c7 c7 d0 1e 00 00 	mov    $0x1ed0,%rdi
     725:	e8 5a 08 00 00       	call   f84 <strchr>
     72a:	48 85 c0             	test   %rax,%rax
     72d:	75 d4                	jne    703 <gettoken+0x143>
  *ps = s;
     72f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     733:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     737:	48 89 10             	mov    %rdx,(%rax)
  return ret;
     73a:	8b 45 f4             	mov    -0xc(%rbp),%eax
}
     73d:	c9                   	leave
     73e:	c3                   	ret

000000000000073f <peek>:

int
peek(char **ps, char *es, char *toks)
{
     73f:	f3 0f 1e fa          	endbr64
     743:	55                   	push   %rbp
     744:	48 89 e5             	mov    %rsp,%rbp
     747:	48 83 ec 30          	sub    $0x30,%rsp
     74b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     74f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     753:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *s;
  
  s = *ps;
     757:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     75b:	48 8b 00             	mov    (%rax),%rax
     75e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     762:	eb 05                	jmp    769 <peek+0x2a>
    s++;
     764:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     769:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     76d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     771:	73 1d                	jae    790 <peek+0x51>
     773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     777:	0f b6 00             	movzbl (%rax),%eax
     77a:	0f be c0             	movsbl %al,%eax
     77d:	89 c6                	mov    %eax,%esi
     77f:	48 c7 c7 d0 1e 00 00 	mov    $0x1ed0,%rdi
     786:	e8 f9 07 00 00       	call   f84 <strchr>
     78b:	48 85 c0             	test   %rax,%rax
     78e:	75 d4                	jne    764 <peek+0x25>
  *ps = s;
     790:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     794:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     798:	48 89 10             	mov    %rdx,(%rax)
  return *s && strchr(toks, *s);
     79b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     79f:	0f b6 00             	movzbl (%rax),%eax
     7a2:	84 c0                	test   %al,%al
     7a4:	74 24                	je     7ca <peek+0x8b>
     7a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     7aa:	0f b6 00             	movzbl (%rax),%eax
     7ad:	0f be d0             	movsbl %al,%edx
     7b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     7b4:	89 d6                	mov    %edx,%esi
     7b6:	48 89 c7             	mov    %rax,%rdi
     7b9:	e8 c6 07 00 00       	call   f84 <strchr>
     7be:	48 85 c0             	test   %rax,%rax
     7c1:	74 07                	je     7ca <peek+0x8b>
     7c3:	b8 01 00 00 00       	mov    $0x1,%eax
     7c8:	eb 05                	jmp    7cf <peek+0x90>
     7ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
     7cf:	c9                   	leave
     7d0:	c3                   	ret

00000000000007d1 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     7d1:	f3 0f 1e fa          	endbr64
     7d5:	55                   	push   %rbp
     7d6:	48 89 e5             	mov    %rsp,%rbp
     7d9:	53                   	push   %rbx
     7da:	48 83 ec 28          	sub    $0x28,%rsp
     7de:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     7e2:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx
     7e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     7ea:	48 89 c7             	mov    %rax,%rdi
     7ed:	e8 2c 07 00 00       	call   f1e <strlen>
     7f2:	89 c0                	mov    %eax,%eax
     7f4:	48 01 d8             	add    %rbx,%rax
     7f7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  cmd = parseline(&s, es);
     7fb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     7ff:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
     803:	48 89 d6             	mov    %rdx,%rsi
     806:	48 89 c7             	mov    %rax,%rdi
     809:	e8 67 00 00 00       	call   875 <parseline>
     80e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  peek(&s, es, "");
     812:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
     816:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
     81a:	48 c7 c2 b2 19 00 00 	mov    $0x19b2,%rdx
     821:	48 89 ce             	mov    %rcx,%rsi
     824:	48 89 c7             	mov    %rax,%rdi
     827:	e8 13 ff ff ff       	call   73f <peek>
  if(s != es){
     82c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     830:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
     834:	74 29                	je     85f <parsecmd+0x8e>
    printf(2, "leftovers: %s\n", s);
     836:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     83a:	48 89 c2             	mov    %rax,%rdx
     83d:	48 c7 c6 b3 19 00 00 	mov    $0x19b3,%rsi
     844:	bf 02 00 00 00       	mov    $0x2,%edi
     849:	b8 00 00 00 00       	mov    $0x0,%eax
     84e:	e8 c8 0a 00 00       	call   131b <printf>
    panic("syntax");
     853:	48 c7 c7 c2 19 00 00 	mov    $0x19c2,%rdi
     85a:	e8 29 fb ff ff       	call   388 <panic>
  }
  nulterminate(cmd);
     85f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     863:	48 89 c7             	mov    %rax,%rdi
     866:	e8 c6 04 00 00       	call   d31 <nulterminate>
  return cmd;
     86b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
}
     86f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     873:	c9                   	leave
     874:	c3                   	ret

0000000000000875 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     875:	f3 0f 1e fa          	endbr64
     879:	55                   	push   %rbp
     87a:	48 89 e5             	mov    %rsp,%rbp
     87d:	48 83 ec 20          	sub    $0x20,%rsp
     881:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     885:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     889:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     88d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     891:	48 89 d6             	mov    %rdx,%rsi
     894:	48 89 c7             	mov    %rax,%rdi
     897:	e8 b5 00 00 00       	call   951 <parsepipe>
     89c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
     8a0:	eb 2a                	jmp    8cc <parseline+0x57>
    gettoken(ps, es, 0, 0);
     8a2:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     8a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8aa:	b9 00 00 00 00       	mov    $0x0,%ecx
     8af:	ba 00 00 00 00       	mov    $0x0,%edx
     8b4:	48 89 c7             	mov    %rax,%rdi
     8b7:	e8 04 fd ff ff       	call   5c0 <gettoken>
    cmd = backcmd(cmd);
     8bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     8c0:	48 89 c7             	mov    %rax,%rdi
     8c3:	e8 a8 fc ff ff       	call   570 <backcmd>
     8c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
     8cc:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     8d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8d4:	48 c7 c2 c9 19 00 00 	mov    $0x19c9,%rdx
     8db:	48 89 ce             	mov    %rcx,%rsi
     8de:	48 89 c7             	mov    %rax,%rdi
     8e1:	e8 59 fe ff ff       	call   73f <peek>
     8e6:	85 c0                	test   %eax,%eax
     8e8:	75 b8                	jne    8a2 <parseline+0x2d>
  }
  if(peek(ps, es, ";")){
     8ea:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     8ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8f2:	48 c7 c2 cb 19 00 00 	mov    $0x19cb,%rdx
     8f9:	48 89 ce             	mov    %rcx,%rsi
     8fc:	48 89 c7             	mov    %rax,%rdi
     8ff:	e8 3b fe ff ff       	call   73f <peek>
     904:	85 c0                	test   %eax,%eax
     906:	74 43                	je     94b <parseline+0xd6>
    gettoken(ps, es, 0, 0);
     908:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     90c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     910:	b9 00 00 00 00       	mov    $0x0,%ecx
     915:	ba 00 00 00 00       	mov    $0x0,%edx
     91a:	48 89 c7             	mov    %rax,%rdi
     91d:	e8 9e fc ff ff       	call   5c0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     922:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     926:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     92a:	48 89 d6             	mov    %rdx,%rsi
     92d:	48 89 c7             	mov    %rax,%rdi
     930:	e8 40 ff ff ff       	call   875 <parseline>
     935:	48 89 c2             	mov    %rax,%rdx
     938:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     93c:	48 89 d6             	mov    %rdx,%rsi
     93f:	48 89 c7             	mov    %rax,%rdi
     942:	e8 c9 fb ff ff       	call   510 <listcmd>
     947:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
     94b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     94f:	c9                   	leave
     950:	c3                   	ret

0000000000000951 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     951:	f3 0f 1e fa          	endbr64
     955:	55                   	push   %rbp
     956:	48 89 e5             	mov    %rsp,%rbp
     959:	48 83 ec 20          	sub    $0x20,%rsp
     95d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     961:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     965:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     969:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     96d:	48 89 d6             	mov    %rdx,%rsi
     970:	48 89 c7             	mov    %rax,%rdi
     973:	e8 50 02 00 00       	call   bc8 <parseexec>
     978:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(peek(ps, es, "|")){
     97c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     980:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     984:	48 c7 c2 cd 19 00 00 	mov    $0x19cd,%rdx
     98b:	48 89 ce             	mov    %rcx,%rsi
     98e:	48 89 c7             	mov    %rax,%rdi
     991:	e8 a9 fd ff ff       	call   73f <peek>
     996:	85 c0                	test   %eax,%eax
     998:	74 43                	je     9dd <parsepipe+0x8c>
    gettoken(ps, es, 0, 0);
     99a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     99e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     9a2:	b9 00 00 00 00       	mov    $0x0,%ecx
     9a7:	ba 00 00 00 00       	mov    $0x0,%edx
     9ac:	48 89 c7             	mov    %rax,%rdi
     9af:	e8 0c fc ff ff       	call   5c0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9b4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     9b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     9bc:	48 89 d6             	mov    %rdx,%rsi
     9bf:	48 89 c7             	mov    %rax,%rdi
     9c2:	e8 8a ff ff ff       	call   951 <parsepipe>
     9c7:	48 89 c2             	mov    %rax,%rdx
     9ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     9ce:	48 89 d6             	mov    %rdx,%rsi
     9d1:	48 89 c7             	mov    %rax,%rdi
     9d4:	e8 d7 fa ff ff       	call   4b0 <pipecmd>
     9d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
     9dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     9e1:	c9                   	leave
     9e2:	c3                   	ret

00000000000009e3 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9e3:	f3 0f 1e fa          	endbr64
     9e7:	55                   	push   %rbp
     9e8:	48 89 e5             	mov    %rsp,%rbp
     9eb:	48 83 ec 40          	sub    $0x40,%rsp
     9ef:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     9f3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     9f7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9fb:	e9 cc 00 00 00       	jmp    acc <parseredirs+0xe9>
    tok = gettoken(ps, es, 0, 0);
     a00:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
     a04:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     a08:	b9 00 00 00 00       	mov    $0x0,%ecx
     a0d:	ba 00 00 00 00       	mov    $0x0,%edx
     a12:	48 89 c7             	mov    %rax,%rdi
     a15:	e8 a6 fb ff ff       	call   5c0 <gettoken>
     a1a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     a1d:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
     a21:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
     a25:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
     a29:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     a2d:	48 89 c7             	mov    %rax,%rdi
     a30:	e8 8b fb ff ff       	call   5c0 <gettoken>
     a35:	83 f8 61             	cmp    $0x61,%eax
     a38:	74 0c                	je     a46 <parseredirs+0x63>
      panic("missing file for redirection");
     a3a:	48 c7 c7 cf 19 00 00 	mov    $0x19cf,%rdi
     a41:	e8 42 f9 ff ff       	call   388 <panic>
    switch(tok){
     a46:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
     a4a:	74 37                	je     a83 <parseredirs+0xa0>
     a4c:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
     a50:	7f 7a                	jg     acc <parseredirs+0xe9>
     a52:	83 7d fc 2b          	cmpl   $0x2b,-0x4(%rbp)
     a56:	74 50                	je     aa8 <parseredirs+0xc5>
     a58:	83 7d fc 3c          	cmpl   $0x3c,-0x4(%rbp)
     a5c:	75 6e                	jne    acc <parseredirs+0xe9>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a5e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     a62:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     a66:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     a6a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
     a70:	b9 00 00 00 00       	mov    $0x0,%ecx
     a75:	48 89 c7             	mov    %rax,%rdi
     a78:	e8 a8 f9 ff ff       	call   425 <redircmd>
     a7d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     a81:	eb 49                	jmp    acc <parseredirs+0xe9>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a83:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     a87:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     a8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     a8f:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     a95:	b9 01 02 00 00       	mov    $0x201,%ecx
     a9a:	48 89 c7             	mov    %rax,%rdi
     a9d:	e8 83 f9 ff ff       	call   425 <redircmd>
     aa2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     aa6:	eb 24                	jmp    acc <parseredirs+0xe9>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     aa8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     aac:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     ab0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     ab4:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     aba:	b9 01 02 00 00       	mov    $0x201,%ecx
     abf:	48 89 c7             	mov    %rax,%rdi
     ac2:	e8 5e f9 ff ff       	call   425 <redircmd>
     ac7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     acb:	90                   	nop
  while(peek(ps, es, "<>")){
     acc:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     ad0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     ad4:	48 c7 c2 ec 19 00 00 	mov    $0x19ec,%rdx
     adb:	48 89 ce             	mov    %rcx,%rsi
     ade:	48 89 c7             	mov    %rax,%rdi
     ae1:	e8 59 fc ff ff       	call   73f <peek>
     ae6:	85 c0                	test   %eax,%eax
     ae8:	0f 85 12 ff ff ff    	jne    a00 <parseredirs+0x1d>
    }
  }
  return cmd;
     aee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
     af2:	c9                   	leave
     af3:	c3                   	ret

0000000000000af4 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     af4:	f3 0f 1e fa          	endbr64
     af8:	55                   	push   %rbp
     af9:	48 89 e5             	mov    %rsp,%rbp
     afc:	48 83 ec 20          	sub    $0x20,%rsp
     b00:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     b04:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     b08:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     b0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b10:	48 c7 c2 ef 19 00 00 	mov    $0x19ef,%rdx
     b17:	48 89 ce             	mov    %rcx,%rsi
     b1a:	48 89 c7             	mov    %rax,%rdi
     b1d:	e8 1d fc ff ff       	call   73f <peek>
     b22:	85 c0                	test   %eax,%eax
     b24:	75 0c                	jne    b32 <parseblock+0x3e>
    panic("parseblock");
     b26:	48 c7 c7 f1 19 00 00 	mov    $0x19f1,%rdi
     b2d:	e8 56 f8 ff ff       	call   388 <panic>
  gettoken(ps, es, 0, 0);
     b32:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     b36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b3a:	b9 00 00 00 00       	mov    $0x0,%ecx
     b3f:	ba 00 00 00 00       	mov    $0x0,%edx
     b44:	48 89 c7             	mov    %rax,%rdi
     b47:	e8 74 fa ff ff       	call   5c0 <gettoken>
  cmd = parseline(ps, es);
     b4c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     b50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b54:	48 89 d6             	mov    %rdx,%rsi
     b57:	48 89 c7             	mov    %rax,%rdi
     b5a:	e8 16 fd ff ff       	call   875 <parseline>
     b5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!peek(ps, es, ")"))
     b63:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     b67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b6b:	48 c7 c2 fc 19 00 00 	mov    $0x19fc,%rdx
     b72:	48 89 ce             	mov    %rcx,%rsi
     b75:	48 89 c7             	mov    %rax,%rdi
     b78:	e8 c2 fb ff ff       	call   73f <peek>
     b7d:	85 c0                	test   %eax,%eax
     b7f:	75 0c                	jne    b8d <parseblock+0x99>
    panic("syntax - missing )");
     b81:	48 c7 c7 fe 19 00 00 	mov    $0x19fe,%rdi
     b88:	e8 fb f7 ff ff       	call   388 <panic>
  gettoken(ps, es, 0, 0);
     b8d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     b91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b95:	b9 00 00 00 00       	mov    $0x0,%ecx
     b9a:	ba 00 00 00 00       	mov    $0x0,%edx
     b9f:	48 89 c7             	mov    %rax,%rdi
     ba2:	e8 19 fa ff ff       	call   5c0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ba7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     bab:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
     baf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bb3:	48 89 ce             	mov    %rcx,%rsi
     bb6:	48 89 c7             	mov    %rax,%rdi
     bb9:	e8 25 fe ff ff       	call   9e3 <parseredirs>
     bbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return cmd;
     bc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     bc6:	c9                   	leave
     bc7:	c3                   	ret

0000000000000bc8 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     bc8:	f3 0f 1e fa          	endbr64
     bcc:	55                   	push   %rbp
     bcd:	48 89 e5             	mov    %rsp,%rbp
     bd0:	48 83 ec 40          	sub    $0x40,%rsp
     bd4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
     bd8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     bdc:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
     be0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     be4:	48 c7 c2 ef 19 00 00 	mov    $0x19ef,%rdx
     beb:	48 89 ce             	mov    %rcx,%rsi
     bee:	48 89 c7             	mov    %rax,%rdi
     bf1:	e8 49 fb ff ff       	call   73f <peek>
     bf6:	85 c0                	test   %eax,%eax
     bf8:	74 18                	je     c12 <parseexec+0x4a>
    return parseblock(ps, es);
     bfa:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     bfe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     c02:	48 89 d6             	mov    %rdx,%rsi
     c05:	48 89 c7             	mov    %rax,%rdi
     c08:	e8 e7 fe ff ff       	call   af4 <parseblock>
     c0d:	e9 1d 01 00 00       	jmp    d2f <parseexec+0x167>

  ret = execcmd();
     c12:	e8 ce f7 ff ff       	call   3e5 <execcmd>
     c17:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  cmd = (struct execcmd*)ret;
     c1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c1f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  argc = 0;
     c23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  ret = parseredirs(ret, ps, es);
     c2a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     c2e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     c32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c36:	48 89 ce             	mov    %rcx,%rsi
     c39:	48 89 c7             	mov    %rax,%rdi
     c3c:	e8 a2 fd ff ff       	call   9e3 <parseredirs>
     c41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
     c45:	e9 92 00 00 00       	jmp    cdc <parseexec+0x114>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     c4a:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
     c4e:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
     c52:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
     c56:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     c5a:	48 89 c7             	mov    %rax,%rdi
     c5d:	e8 5e f9 ff ff       	call   5c0 <gettoken>
     c62:	89 45 e4             	mov    %eax,-0x1c(%rbp)
     c65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
     c69:	0f 84 91 00 00 00    	je     d00 <parseexec+0x138>
      break;
    if(tok != 'a')
     c6f:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
     c73:	74 0c                	je     c81 <parseexec+0xb9>
      panic("syntax");
     c75:	48 c7 c7 c2 19 00 00 	mov    $0x19c2,%rdi
     c7c:	e8 07 f7 ff ff       	call   388 <panic>
    cmd->argv[argc] = q;
     c81:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
     c85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c89:	8b 55 fc             	mov    -0x4(%rbp),%edx
     c8c:	48 63 d2             	movslq %edx,%rdx
     c8f:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cmd->eargv[argc] = eq;
     c94:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
     c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c9c:	8b 4d fc             	mov    -0x4(%rbp),%ecx
     c9f:	48 63 c9             	movslq %ecx,%rcx
     ca2:	48 83 c1 0a          	add    $0xa,%rcx
     ca6:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
    argc++;
     cab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(argc >= MAXARGS)
     caf:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
     cb3:	7e 0c                	jle    cc1 <parseexec+0xf9>
      panic("too many args");
     cb5:	48 c7 c7 11 1a 00 00 	mov    $0x1a11,%rdi
     cbc:	e8 c7 f6 ff ff       	call   388 <panic>
    ret = parseredirs(ret, ps, es);
     cc1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     cc5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     cc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ccd:	48 89 ce             	mov    %rcx,%rsi
     cd0:	48 89 c7             	mov    %rax,%rdi
     cd3:	e8 0b fd ff ff       	call   9e3 <parseredirs>
     cd8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
     cdc:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
     ce0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     ce4:	48 c7 c2 1f 1a 00 00 	mov    $0x1a1f,%rdx
     ceb:	48 89 ce             	mov    %rcx,%rsi
     cee:	48 89 c7             	mov    %rax,%rdi
     cf1:	e8 49 fa ff ff       	call   73f <peek>
     cf6:	85 c0                	test   %eax,%eax
     cf8:	0f 84 4c ff ff ff    	je     c4a <parseexec+0x82>
     cfe:	eb 01                	jmp    d01 <parseexec+0x139>
      break;
     d00:	90                   	nop
  }
  cmd->argv[argc] = 0;
     d01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     d05:	8b 55 fc             	mov    -0x4(%rbp),%edx
     d08:	48 63 d2             	movslq %edx,%rdx
     d0b:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
     d12:	00 00 
  cmd->eargv[argc] = 0;
     d14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     d18:	8b 55 fc             	mov    -0x4(%rbp),%edx
     d1b:	48 63 d2             	movslq %edx,%rdx
     d1e:	48 83 c2 0a          	add    $0xa,%rdx
     d22:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
     d29:	00 00 
  return ret;
     d2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
     d2f:	c9                   	leave
     d30:	c3                   	ret

0000000000000d31 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d31:	f3 0f 1e fa          	endbr64
     d35:	55                   	push   %rbp
     d36:	48 89 e5             	mov    %rsp,%rbp
     d39:	48 83 ec 40          	sub    $0x40,%rsp
     d3d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d41:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
     d46:	75 0a                	jne    d52 <nulterminate+0x21>
    return 0;
     d48:	b8 00 00 00 00       	mov    $0x0,%eax
     d4d:	e9 f6 00 00 00       	jmp    e48 <nulterminate+0x117>
  
  switch(cmd->type){
     d52:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d56:	8b 00                	mov    (%rax),%eax
     d58:	83 f8 05             	cmp    $0x5,%eax
     d5b:	0f 87 e3 00 00 00    	ja     e44 <nulterminate+0x113>
     d61:	89 c0                	mov    %eax,%eax
     d63:	48 8b 04 c5 28 1a 00 	mov    0x1a28(,%rax,8),%rax
     d6a:	00 
     d6b:	3e ff e0             	notrack jmp *%rax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     d6e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d72:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    for(i=0; ecmd->argv[i]; i++)
     d76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     d7d:	eb 1a                	jmp    d99 <nulterminate+0x68>
      *ecmd->eargv[i] = 0;
     d7f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     d83:	8b 55 fc             	mov    -0x4(%rbp),%edx
     d86:	48 63 d2             	movslq %edx,%rdx
     d89:	48 83 c2 0a          	add    $0xa,%rdx
     d8d:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
     d92:	c6 00 00             	movb   $0x0,(%rax)
    for(i=0; ecmd->argv[i]; i++)
     d95:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     d99:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     d9d:	8b 55 fc             	mov    -0x4(%rbp),%edx
     da0:	48 63 d2             	movslq %edx,%rdx
     da3:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
     da8:	48 85 c0             	test   %rax,%rax
     dab:	75 d2                	jne    d7f <nulterminate+0x4e>
    break;
     dad:	e9 92 00 00 00       	jmp    e44 <nulterminate+0x113>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     db2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     db6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    nulterminate(rcmd->cmd);
     dba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     dbe:	48 8b 40 08          	mov    0x8(%rax),%rax
     dc2:	48 89 c7             	mov    %rax,%rdi
     dc5:	e8 67 ff ff ff       	call   d31 <nulterminate>
    *rcmd->efile = 0;
     dca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     dce:	48 8b 40 18          	mov    0x18(%rax),%rax
     dd2:	c6 00 00             	movb   $0x0,(%rax)
    break;
     dd5:	eb 6d                	jmp    e44 <nulterminate+0x113>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     dd7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     ddb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    nulterminate(pcmd->left);
     ddf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     de3:	48 8b 40 08          	mov    0x8(%rax),%rax
     de7:	48 89 c7             	mov    %rax,%rdi
     dea:	e8 42 ff ff ff       	call   d31 <nulterminate>
    nulterminate(pcmd->right);
     def:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     df3:	48 8b 40 10          	mov    0x10(%rax),%rax
     df7:	48 89 c7             	mov    %rax,%rdi
     dfa:	e8 32 ff ff ff       	call   d31 <nulterminate>
    break;
     dff:	eb 43                	jmp    e44 <nulterminate+0x113>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     e01:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     e05:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    nulterminate(lcmd->left);
     e09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e0d:	48 8b 40 08          	mov    0x8(%rax),%rax
     e11:	48 89 c7             	mov    %rax,%rdi
     e14:	e8 18 ff ff ff       	call   d31 <nulterminate>
    nulterminate(lcmd->right);
     e19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e1d:	48 8b 40 10          	mov    0x10(%rax),%rax
     e21:	48 89 c7             	mov    %rax,%rdi
     e24:	e8 08 ff ff ff       	call   d31 <nulterminate>
    break;
     e29:	eb 19                	jmp    e44 <nulterminate+0x113>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     e2b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     e2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    nulterminate(bcmd->cmd);
     e33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     e37:	48 8b 40 08          	mov    0x8(%rax),%rax
     e3b:	48 89 c7             	mov    %rax,%rdi
     e3e:	e8 ee fe ff ff       	call   d31 <nulterminate>
    break;
     e43:	90                   	nop
  }
  return cmd;
     e44:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
     e48:	c9                   	leave
     e49:	c3                   	ret

0000000000000e4a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     e4a:	55                   	push   %rbp
     e4b:	48 89 e5             	mov    %rsp,%rbp
     e4e:	48 83 ec 10          	sub    $0x10,%rsp
     e52:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     e56:	89 75 f4             	mov    %esi,-0xc(%rbp)
     e59:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
     e5c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     e60:	8b 55 f0             	mov    -0x10(%rbp),%edx
     e63:	8b 45 f4             	mov    -0xc(%rbp),%eax
     e66:	48 89 ce             	mov    %rcx,%rsi
     e69:	48 89 f7             	mov    %rsi,%rdi
     e6c:	89 d1                	mov    %edx,%ecx
     e6e:	fc                   	cld
     e6f:	f3 aa                	rep stos %al,%es:(%rdi)
     e71:	89 ca                	mov    %ecx,%edx
     e73:	48 89 fe             	mov    %rdi,%rsi
     e76:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
     e7a:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     e7d:	90                   	nop
     e7e:	c9                   	leave
     e7f:	c3                   	ret

0000000000000e80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     e80:	f3 0f 1e fa          	endbr64
     e84:	55                   	push   %rbp
     e85:	48 89 e5             	mov    %rsp,%rbp
     e88:	48 83 ec 20          	sub    $0x20,%rsp
     e8c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     e90:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
     e94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e98:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
     e9c:	90                   	nop
     e9d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     ea1:	48 8d 42 01          	lea    0x1(%rdx),%rax
     ea5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
     ea9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ead:	48 8d 48 01          	lea    0x1(%rax),%rcx
     eb1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
     eb5:	0f b6 12             	movzbl (%rdx),%edx
     eb8:	88 10                	mov    %dl,(%rax)
     eba:	0f b6 00             	movzbl (%rax),%eax
     ebd:	84 c0                	test   %al,%al
     ebf:	75 dc                	jne    e9d <strcpy+0x1d>
    ;
  return os;
     ec1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     ec5:	c9                   	leave
     ec6:	c3                   	ret

0000000000000ec7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ec7:	f3 0f 1e fa          	endbr64
     ecb:	55                   	push   %rbp
     ecc:	48 89 e5             	mov    %rsp,%rbp
     ecf:	48 83 ec 10          	sub    $0x10,%rsp
     ed3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     ed7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
     edb:	eb 0a                	jmp    ee7 <strcmp+0x20>
    p++, q++;
     edd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     ee2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
     ee7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     eeb:	0f b6 00             	movzbl (%rax),%eax
     eee:	84 c0                	test   %al,%al
     ef0:	74 12                	je     f04 <strcmp+0x3d>
     ef2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ef6:	0f b6 10             	movzbl (%rax),%edx
     ef9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     efd:	0f b6 00             	movzbl (%rax),%eax
     f00:	38 c2                	cmp    %al,%dl
     f02:	74 d9                	je     edd <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
     f04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f08:	0f b6 00             	movzbl (%rax),%eax
     f0b:	0f b6 d0             	movzbl %al,%edx
     f0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f12:	0f b6 00             	movzbl (%rax),%eax
     f15:	0f b6 c0             	movzbl %al,%eax
     f18:	29 c2                	sub    %eax,%edx
     f1a:	89 d0                	mov    %edx,%eax
}
     f1c:	c9                   	leave
     f1d:	c3                   	ret

0000000000000f1e <strlen>:

uint
strlen(char *s)
{
     f1e:	f3 0f 1e fa          	endbr64
     f22:	55                   	push   %rbp
     f23:	48 89 e5             	mov    %rsp,%rbp
     f26:	48 83 ec 18          	sub    $0x18,%rsp
     f2a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
     f2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     f35:	eb 04                	jmp    f3b <strlen+0x1d>
     f37:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     f3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
     f3e:	48 63 d0             	movslq %eax,%rdx
     f41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     f45:	48 01 d0             	add    %rdx,%rax
     f48:	0f b6 00             	movzbl (%rax),%eax
     f4b:	84 c0                	test   %al,%al
     f4d:	75 e8                	jne    f37 <strlen+0x19>
    ;
  return n;
     f4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     f52:	c9                   	leave
     f53:	c3                   	ret

0000000000000f54 <memset>:

void*
memset(void *dst, int c, uint n)
{
     f54:	f3 0f 1e fa          	endbr64
     f58:	55                   	push   %rbp
     f59:	48 89 e5             	mov    %rsp,%rbp
     f5c:	48 83 ec 10          	sub    $0x10,%rsp
     f60:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f64:	89 75 f4             	mov    %esi,-0xc(%rbp)
     f67:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
     f6a:	8b 55 f0             	mov    -0x10(%rbp),%edx
     f6d:	8b 4d f4             	mov    -0xc(%rbp),%ecx
     f70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f74:	89 ce                	mov    %ecx,%esi
     f76:	48 89 c7             	mov    %rax,%rdi
     f79:	e8 cc fe ff ff       	call   e4a <stosb>
  return dst;
     f7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     f82:	c9                   	leave
     f83:	c3                   	ret

0000000000000f84 <strchr>:

char*
strchr(const char *s, char c)
{
     f84:	f3 0f 1e fa          	endbr64
     f88:	55                   	push   %rbp
     f89:	48 89 e5             	mov    %rsp,%rbp
     f8c:	48 83 ec 10          	sub    $0x10,%rsp
     f90:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f94:	89 f0                	mov    %esi,%eax
     f96:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
     f99:	eb 17                	jmp    fb2 <strchr+0x2e>
    if(*s == c)
     f9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f9f:	0f b6 00             	movzbl (%rax),%eax
     fa2:	38 45 f4             	cmp    %al,-0xc(%rbp)
     fa5:	75 06                	jne    fad <strchr+0x29>
      return (char*)s;
     fa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fab:	eb 15                	jmp    fc2 <strchr+0x3e>
  for(; *s; s++)
     fad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     fb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fb6:	0f b6 00             	movzbl (%rax),%eax
     fb9:	84 c0                	test   %al,%al
     fbb:	75 de                	jne    f9b <strchr+0x17>
  return 0;
     fbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fc2:	c9                   	leave
     fc3:	c3                   	ret

0000000000000fc4 <gets>:

char*
gets(char *buf, int max)
{
     fc4:	f3 0f 1e fa          	endbr64
     fc8:	55                   	push   %rbp
     fc9:	48 89 e5             	mov    %rsp,%rbp
     fcc:	48 83 ec 20          	sub    $0x20,%rsp
     fd0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     fd4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     fd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     fde:	eb 48                	jmp    1028 <gets+0x64>
    cc = read(0, &c, 1);
     fe0:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
     fe4:	ba 01 00 00 00       	mov    $0x1,%edx
     fe9:	48 89 c6             	mov    %rax,%rsi
     fec:	bf 00 00 00 00       	mov    $0x0,%edi
     ff1:	e8 83 01 00 00       	call   1179 <read>
     ff6:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
     ff9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     ffd:	7e 36                	jle    1035 <gets+0x71>
      break;
    buf[i++] = c;
     fff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1002:	8d 50 01             	lea    0x1(%rax),%edx
    1005:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1008:	48 63 d0             	movslq %eax,%rdx
    100b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    100f:	48 01 c2             	add    %rax,%rdx
    1012:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1016:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1018:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    101c:	3c 0a                	cmp    $0xa,%al
    101e:	74 16                	je     1036 <gets+0x72>
    1020:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1024:	3c 0d                	cmp    $0xd,%al
    1026:	74 0e                	je     1036 <gets+0x72>
  for(i=0; i+1 < max; ){
    1028:	8b 45 fc             	mov    -0x4(%rbp),%eax
    102b:	83 c0 01             	add    $0x1,%eax
    102e:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1031:	7f ad                	jg     fe0 <gets+0x1c>
    1033:	eb 01                	jmp    1036 <gets+0x72>
      break;
    1035:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1036:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1039:	48 63 d0             	movslq %eax,%rdx
    103c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1040:	48 01 d0             	add    %rdx,%rax
    1043:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1046:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    104a:	c9                   	leave
    104b:	c3                   	ret

000000000000104c <stat>:

int
stat(char *n, struct stat *st)
{
    104c:	f3 0f 1e fa          	endbr64
    1050:	55                   	push   %rbp
    1051:	48 89 e5             	mov    %rsp,%rbp
    1054:	48 83 ec 20          	sub    $0x20,%rsp
    1058:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    105c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1060:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1064:	be 00 00 00 00       	mov    $0x0,%esi
    1069:	48 89 c7             	mov    %rax,%rdi
    106c:	e8 30 01 00 00       	call   11a1 <open>
    1071:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1074:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1078:	79 07                	jns    1081 <stat+0x35>
    return -1;
    107a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    107f:	eb 21                	jmp    10a2 <stat+0x56>
  r = fstat(fd, st);
    1081:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1085:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1088:	48 89 d6             	mov    %rdx,%rsi
    108b:	89 c7                	mov    %eax,%edi
    108d:	e8 27 01 00 00       	call   11b9 <fstat>
    1092:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1095:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1098:	89 c7                	mov    %eax,%edi
    109a:	e8 ea 00 00 00       	call   1189 <close>
  return r;
    109f:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    10a2:	c9                   	leave
    10a3:	c3                   	ret

00000000000010a4 <atoi>:

int
atoi(const char *s)
{
    10a4:	f3 0f 1e fa          	endbr64
    10a8:	55                   	push   %rbp
    10a9:	48 89 e5             	mov    %rsp,%rbp
    10ac:	48 83 ec 18          	sub    $0x18,%rsp
    10b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    10b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    10bb:	eb 28                	jmp    10e5 <atoi+0x41>
    n = n*10 + *s++ - '0';
    10bd:	8b 55 fc             	mov    -0x4(%rbp),%edx
    10c0:	89 d0                	mov    %edx,%eax
    10c2:	c1 e0 02             	shl    $0x2,%eax
    10c5:	01 d0                	add    %edx,%eax
    10c7:	01 c0                	add    %eax,%eax
    10c9:	89 c1                	mov    %eax,%ecx
    10cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10cf:	48 8d 50 01          	lea    0x1(%rax),%rdx
    10d3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    10d7:	0f b6 00             	movzbl (%rax),%eax
    10da:	0f be c0             	movsbl %al,%eax
    10dd:	01 c8                	add    %ecx,%eax
    10df:	83 e8 30             	sub    $0x30,%eax
    10e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    10e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10e9:	0f b6 00             	movzbl (%rax),%eax
    10ec:	3c 2f                	cmp    $0x2f,%al
    10ee:	7e 0b                	jle    10fb <atoi+0x57>
    10f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10f4:	0f b6 00             	movzbl (%rax),%eax
    10f7:	3c 39                	cmp    $0x39,%al
    10f9:	7e c2                	jle    10bd <atoi+0x19>
  return n;
    10fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    10fe:	c9                   	leave
    10ff:	c3                   	ret

0000000000001100 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1100:	f3 0f 1e fa          	endbr64
    1104:	55                   	push   %rbp
    1105:	48 89 e5             	mov    %rsp,%rbp
    1108:	48 83 ec 28          	sub    $0x28,%rsp
    110c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1110:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1114:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
    1117:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    111b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    111f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1123:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1127:	eb 1d                	jmp    1146 <memmove+0x46>
    *dst++ = *src++;
    1129:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    112d:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1131:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1139:	48 8d 48 01          	lea    0x1(%rax),%rcx
    113d:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1141:	0f b6 12             	movzbl (%rdx),%edx
    1144:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1146:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1149:	8d 50 ff             	lea    -0x1(%rax),%edx
    114c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    114f:	85 c0                	test   %eax,%eax
    1151:	7f d6                	jg     1129 <memmove+0x29>
  return vdst;
    1153:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1157:	c9                   	leave
    1158:	c3                   	ret

0000000000001159 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1159:	b8 01 00 00 00       	mov    $0x1,%eax
    115e:	cd 40                	int    $0x40
    1160:	c3                   	ret

0000000000001161 <exit>:
SYSCALL(exit)
    1161:	b8 02 00 00 00       	mov    $0x2,%eax
    1166:	cd 40                	int    $0x40
    1168:	c3                   	ret

0000000000001169 <wait>:
SYSCALL(wait)
    1169:	b8 03 00 00 00       	mov    $0x3,%eax
    116e:	cd 40                	int    $0x40
    1170:	c3                   	ret

0000000000001171 <pipe>:
SYSCALL(pipe)
    1171:	b8 04 00 00 00       	mov    $0x4,%eax
    1176:	cd 40                	int    $0x40
    1178:	c3                   	ret

0000000000001179 <read>:
SYSCALL(read)
    1179:	b8 05 00 00 00       	mov    $0x5,%eax
    117e:	cd 40                	int    $0x40
    1180:	c3                   	ret

0000000000001181 <write>:
SYSCALL(write)
    1181:	b8 10 00 00 00       	mov    $0x10,%eax
    1186:	cd 40                	int    $0x40
    1188:	c3                   	ret

0000000000001189 <close>:
SYSCALL(close)
    1189:	b8 15 00 00 00       	mov    $0x15,%eax
    118e:	cd 40                	int    $0x40
    1190:	c3                   	ret

0000000000001191 <kill>:
SYSCALL(kill)
    1191:	b8 06 00 00 00       	mov    $0x6,%eax
    1196:	cd 40                	int    $0x40
    1198:	c3                   	ret

0000000000001199 <exec>:
SYSCALL(exec)
    1199:	b8 07 00 00 00       	mov    $0x7,%eax
    119e:	cd 40                	int    $0x40
    11a0:	c3                   	ret

00000000000011a1 <open>:
SYSCALL(open)
    11a1:	b8 0f 00 00 00       	mov    $0xf,%eax
    11a6:	cd 40                	int    $0x40
    11a8:	c3                   	ret

00000000000011a9 <mknod>:
SYSCALL(mknod)
    11a9:	b8 11 00 00 00       	mov    $0x11,%eax
    11ae:	cd 40                	int    $0x40
    11b0:	c3                   	ret

00000000000011b1 <unlink>:
SYSCALL(unlink)
    11b1:	b8 12 00 00 00       	mov    $0x12,%eax
    11b6:	cd 40                	int    $0x40
    11b8:	c3                   	ret

00000000000011b9 <fstat>:
SYSCALL(fstat)
    11b9:	b8 08 00 00 00       	mov    $0x8,%eax
    11be:	cd 40                	int    $0x40
    11c0:	c3                   	ret

00000000000011c1 <link>:
SYSCALL(link)
    11c1:	b8 13 00 00 00       	mov    $0x13,%eax
    11c6:	cd 40                	int    $0x40
    11c8:	c3                   	ret

00000000000011c9 <mkdir>:
SYSCALL(mkdir)
    11c9:	b8 14 00 00 00       	mov    $0x14,%eax
    11ce:	cd 40                	int    $0x40
    11d0:	c3                   	ret

00000000000011d1 <chdir>:
SYSCALL(chdir)
    11d1:	b8 09 00 00 00       	mov    $0x9,%eax
    11d6:	cd 40                	int    $0x40
    11d8:	c3                   	ret

00000000000011d9 <dup>:
SYSCALL(dup)
    11d9:	b8 0a 00 00 00       	mov    $0xa,%eax
    11de:	cd 40                	int    $0x40
    11e0:	c3                   	ret

00000000000011e1 <getpid>:
SYSCALL(getpid)
    11e1:	b8 0b 00 00 00       	mov    $0xb,%eax
    11e6:	cd 40                	int    $0x40
    11e8:	c3                   	ret

00000000000011e9 <sbrk>:
SYSCALL(sbrk)
    11e9:	b8 0c 00 00 00       	mov    $0xc,%eax
    11ee:	cd 40                	int    $0x40
    11f0:	c3                   	ret

00000000000011f1 <sleep>:
SYSCALL(sleep)
    11f1:	b8 0d 00 00 00       	mov    $0xd,%eax
    11f6:	cd 40                	int    $0x40
    11f8:	c3                   	ret

00000000000011f9 <uptime>:
SYSCALL(uptime)
    11f9:	b8 0e 00 00 00       	mov    $0xe,%eax
    11fe:	cd 40                	int    $0x40
    1200:	c3                   	ret

0000000000001201 <getpinfo>:
SYSCALL(getpinfo)
    1201:	b8 18 00 00 00       	mov    $0x18,%eax
    1206:	cd 40                	int    $0x40
    1208:	c3                   	ret

0000000000001209 <settickets>:
SYSCALL(settickets)
    1209:	b8 1b 00 00 00       	mov    $0x1b,%eax
    120e:	cd 40                	int    $0x40
    1210:	c3                   	ret

0000000000001211 <getfavnum>:
SYSCALL(getfavnum)
    1211:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1216:	cd 40                	int    $0x40
    1218:	c3                   	ret

0000000000001219 <halt>:
SYSCALL(halt)
    1219:	b8 1d 00 00 00       	mov    $0x1d,%eax
    121e:	cd 40                	int    $0x40
    1220:	c3                   	ret

0000000000001221 <getcount>:
SYSCALL(getcount)
    1221:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1226:	cd 40                	int    $0x40
    1228:	c3                   	ret

0000000000001229 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1229:	f3 0f 1e fa          	endbr64
    122d:	55                   	push   %rbp
    122e:	48 89 e5             	mov    %rsp,%rbp
    1231:	48 83 ec 10          	sub    $0x10,%rsp
    1235:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1238:	89 f0                	mov    %esi,%eax
    123a:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    123d:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1241:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1244:	ba 01 00 00 00       	mov    $0x1,%edx
    1249:	48 89 ce             	mov    %rcx,%rsi
    124c:	89 c7                	mov    %eax,%edi
    124e:	e8 2e ff ff ff       	call   1181 <write>
}
    1253:	90                   	nop
    1254:	c9                   	leave
    1255:	c3                   	ret

0000000000001256 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1256:	f3 0f 1e fa          	endbr64
    125a:	55                   	push   %rbp
    125b:	48 89 e5             	mov    %rsp,%rbp
    125e:	48 83 ec 30          	sub    $0x30,%rsp
    1262:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1265:	89 75 d8             	mov    %esi,-0x28(%rbp)
    1268:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    126b:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    126e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
    1275:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    1279:	74 17                	je     1292 <printint+0x3c>
    127b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    127f:	79 11                	jns    1292 <printint+0x3c>
    neg = 1;
    1281:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
    1288:	8b 45 d8             	mov    -0x28(%rbp),%eax
    128b:	f7 d8                	neg    %eax
    128d:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1290:	eb 06                	jmp    1298 <printint+0x42>
  } else {
    x = xx;
    1292:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1295:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
    1298:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
    129f:	8b 75 d4             	mov    -0x2c(%rbp),%esi
    12a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    12a5:	ba 00 00 00 00       	mov    $0x0,%edx
    12aa:	f7 f6                	div    %esi
    12ac:	89 d1                	mov    %edx,%ecx
    12ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12b1:	8d 50 01             	lea    0x1(%rax),%edx
    12b4:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12b7:	89 ca                	mov    %ecx,%edx
    12b9:	0f b6 92 e0 1e 00 00 	movzbl 0x1ee0(%rdx),%edx
    12c0:	48 98                	cltq
    12c2:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
    12c6:	8b 7d d4             	mov    -0x2c(%rbp),%edi
    12c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    12cc:	ba 00 00 00 00       	mov    $0x0,%edx
    12d1:	f7 f7                	div    %edi
    12d3:	89 45 f4             	mov    %eax,-0xc(%rbp)
    12d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    12da:	75 c3                	jne    129f <printint+0x49>
  if(neg)
    12dc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    12e0:	74 2b                	je     130d <printint+0xb7>
    buf[i++] = '-';
    12e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12e5:	8d 50 01             	lea    0x1(%rax),%edx
    12e8:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12eb:	48 98                	cltq
    12ed:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
    12f2:	eb 19                	jmp    130d <printint+0xb7>
    putc(fd, buf[i]);
    12f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12f7:	48 98                	cltq
    12f9:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    12fe:	0f be d0             	movsbl %al,%edx
    1301:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1304:	89 d6                	mov    %edx,%esi
    1306:	89 c7                	mov    %eax,%edi
    1308:	e8 1c ff ff ff       	call   1229 <putc>
  while(--i >= 0)
    130d:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    1311:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1315:	79 dd                	jns    12f4 <printint+0x9e>
}
    1317:	90                   	nop
    1318:	90                   	nop
    1319:	c9                   	leave
    131a:	c3                   	ret

000000000000131b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    131b:	f3 0f 1e fa          	endbr64
    131f:	55                   	push   %rbp
    1320:	48 89 e5             	mov    %rsp,%rbp
    1323:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    132a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1330:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1337:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    133e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1345:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    134c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1353:	84 c0                	test   %al,%al
    1355:	74 20                	je     1377 <printf+0x5c>
    1357:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    135b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    135f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1363:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1367:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    136b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    136f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1373:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
    1377:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    137e:	00 00 00 
    1381:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1388:	00 00 00 
    138b:	48 8d 45 10          	lea    0x10(%rbp),%rax
    138f:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1396:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    139d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
    13a4:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    13ab:	00 00 00 
  for(i = 0; fmt[i]; i++){
    13ae:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    13b5:	00 00 00 
    13b8:	e9 a8 02 00 00       	jmp    1665 <printf+0x34a>
    c = fmt[i] & 0xff;
    13bd:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    13c3:	48 63 d0             	movslq %eax,%rdx
    13c6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    13cd:	48 01 d0             	add    %rdx,%rax
    13d0:	0f b6 00             	movzbl (%rax),%eax
    13d3:	0f be c0             	movsbl %al,%eax
    13d6:	25 ff 00 00 00       	and    $0xff,%eax
    13db:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
    13e1:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
    13e8:	75 35                	jne    141f <printf+0x104>
      if(c == '%'){
    13ea:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    13f1:	75 0f                	jne    1402 <printf+0xe7>
        state = '%';
    13f3:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
    13fa:	00 00 00 
    13fd:	e9 5c 02 00 00       	jmp    165e <printf+0x343>
      } else {
        putc(fd, c);
    1402:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1408:	0f be d0             	movsbl %al,%edx
    140b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1411:	89 d6                	mov    %edx,%esi
    1413:	89 c7                	mov    %eax,%edi
    1415:	e8 0f fe ff ff       	call   1229 <putc>
    141a:	e9 3f 02 00 00       	jmp    165e <printf+0x343>
      }
    } else if(state == '%'){
    141f:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
    1426:	0f 85 32 02 00 00    	jne    165e <printf+0x343>
      if(c == 'd'){
    142c:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1433:	75 5e                	jne    1493 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
    1435:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    143b:	83 f8 2f             	cmp    $0x2f,%eax
    143e:	77 23                	ja     1463 <printf+0x148>
    1440:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1447:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    144d:	89 d2                	mov    %edx,%edx
    144f:	48 01 d0             	add    %rdx,%rax
    1452:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1458:	83 c2 08             	add    $0x8,%edx
    145b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1461:	eb 12                	jmp    1475 <printf+0x15a>
    1463:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    146a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    146e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1475:	8b 30                	mov    (%rax),%esi
    1477:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    147d:	b9 01 00 00 00       	mov    $0x1,%ecx
    1482:	ba 0a 00 00 00       	mov    $0xa,%edx
    1487:	89 c7                	mov    %eax,%edi
    1489:	e8 c8 fd ff ff       	call   1256 <printint>
    148e:	e9 c1 01 00 00       	jmp    1654 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
    1493:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    149a:	74 09                	je     14a5 <printf+0x18a>
    149c:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    14a3:	75 5e                	jne    1503 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
    14a5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    14ab:	83 f8 2f             	cmp    $0x2f,%eax
    14ae:	77 23                	ja     14d3 <printf+0x1b8>
    14b0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    14b7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    14bd:	89 d2                	mov    %edx,%edx
    14bf:	48 01 d0             	add    %rdx,%rax
    14c2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    14c8:	83 c2 08             	add    $0x8,%edx
    14cb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    14d1:	eb 12                	jmp    14e5 <printf+0x1ca>
    14d3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    14da:	48 8d 50 08          	lea    0x8(%rax),%rdx
    14de:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    14e5:	8b 30                	mov    (%rax),%esi
    14e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    14ed:	b9 00 00 00 00       	mov    $0x0,%ecx
    14f2:	ba 10 00 00 00       	mov    $0x10,%edx
    14f7:	89 c7                	mov    %eax,%edi
    14f9:	e8 58 fd ff ff       	call   1256 <printint>
    14fe:	e9 51 01 00 00       	jmp    1654 <printf+0x339>
      } else if(c == 's'){
    1503:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    150a:	0f 85 98 00 00 00    	jne    15a8 <printf+0x28d>
        s = va_arg(ap, char*);
    1510:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1516:	83 f8 2f             	cmp    $0x2f,%eax
    1519:	77 23                	ja     153e <printf+0x223>
    151b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1522:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1528:	89 d2                	mov    %edx,%edx
    152a:	48 01 d0             	add    %rdx,%rax
    152d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1533:	83 c2 08             	add    $0x8,%edx
    1536:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    153c:	eb 12                	jmp    1550 <printf+0x235>
    153e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1545:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1549:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1550:	48 8b 00             	mov    (%rax),%rax
    1553:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
    155a:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
    1561:	00 
    1562:	75 31                	jne    1595 <printf+0x27a>
          s = "(null)";
    1564:	48 c7 85 48 ff ff ff 	movq   $0x1a58,-0xb8(%rbp)
    156b:	58 1a 00 00 
        while(*s != 0){
    156f:	eb 24                	jmp    1595 <printf+0x27a>
          putc(fd, *s);
    1571:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    1578:	0f b6 00             	movzbl (%rax),%eax
    157b:	0f be d0             	movsbl %al,%edx
    157e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1584:	89 d6                	mov    %edx,%esi
    1586:	89 c7                	mov    %eax,%edi
    1588:	e8 9c fc ff ff       	call   1229 <putc>
          s++;
    158d:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
    1594:	01 
        while(*s != 0){
    1595:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    159c:	0f b6 00             	movzbl (%rax),%eax
    159f:	84 c0                	test   %al,%al
    15a1:	75 ce                	jne    1571 <printf+0x256>
    15a3:	e9 ac 00 00 00       	jmp    1654 <printf+0x339>
        }
      } else if(c == 'c'){
    15a8:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    15af:	75 56                	jne    1607 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
    15b1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    15b7:	83 f8 2f             	cmp    $0x2f,%eax
    15ba:	77 23                	ja     15df <printf+0x2c4>
    15bc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    15c3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    15c9:	89 d2                	mov    %edx,%edx
    15cb:	48 01 d0             	add    %rdx,%rax
    15ce:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    15d4:	83 c2 08             	add    $0x8,%edx
    15d7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    15dd:	eb 12                	jmp    15f1 <printf+0x2d6>
    15df:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    15e6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    15ea:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    15f1:	8b 00                	mov    (%rax),%eax
    15f3:	0f be d0             	movsbl %al,%edx
    15f6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    15fc:	89 d6                	mov    %edx,%esi
    15fe:	89 c7                	mov    %eax,%edi
    1600:	e8 24 fc ff ff       	call   1229 <putc>
    1605:	eb 4d                	jmp    1654 <printf+0x339>
      } else if(c == '%'){
    1607:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    160e:	75 1a                	jne    162a <printf+0x30f>
        putc(fd, c);
    1610:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1616:	0f be d0             	movsbl %al,%edx
    1619:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    161f:	89 d6                	mov    %edx,%esi
    1621:	89 c7                	mov    %eax,%edi
    1623:	e8 01 fc ff ff       	call   1229 <putc>
    1628:	eb 2a                	jmp    1654 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    162a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1630:	be 25 00 00 00       	mov    $0x25,%esi
    1635:	89 c7                	mov    %eax,%edi
    1637:	e8 ed fb ff ff       	call   1229 <putc>
        putc(fd, c);
    163c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1642:	0f be d0             	movsbl %al,%edx
    1645:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    164b:	89 d6                	mov    %edx,%esi
    164d:	89 c7                	mov    %eax,%edi
    164f:	e8 d5 fb ff ff       	call   1229 <putc>
      }
      state = 0;
    1654:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    165b:	00 00 00 
  for(i = 0; fmt[i]; i++){
    165e:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
    1665:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    166b:	48 63 d0             	movslq %eax,%rdx
    166e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1675:	48 01 d0             	add    %rdx,%rax
    1678:	0f b6 00             	movzbl (%rax),%eax
    167b:	84 c0                	test   %al,%al
    167d:	0f 85 3a fd ff ff    	jne    13bd <printf+0xa2>
    }
  }
}
    1683:	90                   	nop
    1684:	90                   	nop
    1685:	c9                   	leave
    1686:	c3                   	ret

0000000000001687 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1687:	f3 0f 1e fa          	endbr64
    168b:	55                   	push   %rbp
    168c:	48 89 e5             	mov    %rsp,%rbp
    168f:	48 83 ec 18          	sub    $0x18,%rsp
    1693:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1697:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    169b:	48 83 e8 10          	sub    $0x10,%rax
    169f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a3:	48 8b 05 d6 08 00 00 	mov    0x8d6(%rip),%rax        # 1f80 <freep>
    16aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    16ae:	eb 2f                	jmp    16df <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16b4:	48 8b 00             	mov    (%rax),%rax
    16b7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16bb:	72 17                	jb     16d4 <free+0x4d>
    16bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16c1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16c5:	72 2f                	jb     16f6 <free+0x6f>
    16c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16cb:	48 8b 00             	mov    (%rax),%rax
    16ce:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    16d2:	72 22                	jb     16f6 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16d8:	48 8b 00             	mov    (%rax),%rax
    16db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    16df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16e3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16e7:	73 c7                	jae    16b0 <free+0x29>
    16e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16ed:	48 8b 00             	mov    (%rax),%rax
    16f0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    16f4:	73 ba                	jae    16b0 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16fa:	8b 40 08             	mov    0x8(%rax),%eax
    16fd:	89 c0                	mov    %eax,%eax
    16ff:	48 c1 e0 04          	shl    $0x4,%rax
    1703:	48 89 c2             	mov    %rax,%rdx
    1706:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    170a:	48 01 c2             	add    %rax,%rdx
    170d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1711:	48 8b 00             	mov    (%rax),%rax
    1714:	48 39 c2             	cmp    %rax,%rdx
    1717:	75 2d                	jne    1746 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
    1719:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    171d:	8b 50 08             	mov    0x8(%rax),%edx
    1720:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1724:	48 8b 00             	mov    (%rax),%rax
    1727:	8b 40 08             	mov    0x8(%rax),%eax
    172a:	01 c2                	add    %eax,%edx
    172c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1730:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1733:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1737:	48 8b 00             	mov    (%rax),%rax
    173a:	48 8b 10             	mov    (%rax),%rdx
    173d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1741:	48 89 10             	mov    %rdx,(%rax)
    1744:	eb 0e                	jmp    1754 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
    1746:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    174a:	48 8b 10             	mov    (%rax),%rdx
    174d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1751:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1754:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1758:	8b 40 08             	mov    0x8(%rax),%eax
    175b:	89 c0                	mov    %eax,%eax
    175d:	48 c1 e0 04          	shl    $0x4,%rax
    1761:	48 89 c2             	mov    %rax,%rdx
    1764:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1768:	48 01 d0             	add    %rdx,%rax
    176b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    176f:	75 27                	jne    1798 <free+0x111>
    p->s.size += bp->s.size;
    1771:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1775:	8b 50 08             	mov    0x8(%rax),%edx
    1778:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    177c:	8b 40 08             	mov    0x8(%rax),%eax
    177f:	01 c2                	add    %eax,%edx
    1781:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1785:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1788:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    178c:	48 8b 10             	mov    (%rax),%rdx
    178f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1793:	48 89 10             	mov    %rdx,(%rax)
    1796:	eb 0b                	jmp    17a3 <free+0x11c>
  } else
    p->s.ptr = bp;
    1798:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    179c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    17a0:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    17a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17a7:	48 89 05 d2 07 00 00 	mov    %rax,0x7d2(%rip)        # 1f80 <freep>
}
    17ae:	90                   	nop
    17af:	c9                   	leave
    17b0:	c3                   	ret

00000000000017b1 <morecore>:

static Header*
morecore(uint nu)
{
    17b1:	f3 0f 1e fa          	endbr64
    17b5:	55                   	push   %rbp
    17b6:	48 89 e5             	mov    %rsp,%rbp
    17b9:	48 83 ec 20          	sub    $0x20,%rsp
    17bd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    17c0:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    17c7:	77 07                	ja     17d0 <morecore+0x1f>
    nu = 4096;
    17c9:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    17d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
    17d3:	c1 e0 04             	shl    $0x4,%eax
    17d6:	89 c7                	mov    %eax,%edi
    17d8:	e8 0c fa ff ff       	call   11e9 <sbrk>
    17dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    17e1:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    17e6:	75 07                	jne    17ef <morecore+0x3e>
    return 0;
    17e8:	b8 00 00 00 00       	mov    $0x0,%eax
    17ed:	eb 29                	jmp    1818 <morecore+0x67>
  hp = (Header*)p;
    17ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    17f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17fb:	8b 55 ec             	mov    -0x14(%rbp),%edx
    17fe:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1801:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1805:	48 83 c0 10          	add    $0x10,%rax
    1809:	48 89 c7             	mov    %rax,%rdi
    180c:	e8 76 fe ff ff       	call   1687 <free>
  return freep;
    1811:	48 8b 05 68 07 00 00 	mov    0x768(%rip),%rax        # 1f80 <freep>
}
    1818:	c9                   	leave
    1819:	c3                   	ret

000000000000181a <malloc>:

void*
malloc(uint nbytes)
{
    181a:	f3 0f 1e fa          	endbr64
    181e:	55                   	push   %rbp
    181f:	48 89 e5             	mov    %rsp,%rbp
    1822:	48 83 ec 30          	sub    $0x30,%rsp
    1826:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1829:	8b 45 dc             	mov    -0x24(%rbp),%eax
    182c:	48 83 c0 0f          	add    $0xf,%rax
    1830:	48 c1 e8 04          	shr    $0x4,%rax
    1834:	83 c0 01             	add    $0x1,%eax
    1837:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    183a:	48 8b 05 3f 07 00 00 	mov    0x73f(%rip),%rax        # 1f80 <freep>
    1841:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1845:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    184a:	75 2b                	jne    1877 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
    184c:	48 c7 45 f0 70 1f 00 	movq   $0x1f70,-0x10(%rbp)
    1853:	00 
    1854:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1858:	48 89 05 21 07 00 00 	mov    %rax,0x721(%rip)        # 1f80 <freep>
    185f:	48 8b 05 1a 07 00 00 	mov    0x71a(%rip),%rax        # 1f80 <freep>
    1866:	48 89 05 03 07 00 00 	mov    %rax,0x703(%rip)        # 1f70 <base>
    base.s.size = 0;
    186d:	c7 05 01 07 00 00 00 	movl   $0x0,0x701(%rip)        # 1f78 <base+0x8>
    1874:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1877:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    187b:	48 8b 00             	mov    (%rax),%rax
    187e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1882:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1886:	8b 40 08             	mov    0x8(%rax),%eax
    1889:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    188c:	72 5f                	jb     18ed <malloc+0xd3>
      if(p->s.size == nunits)
    188e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1892:	8b 40 08             	mov    0x8(%rax),%eax
    1895:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1898:	75 10                	jne    18aa <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
    189a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    189e:	48 8b 10             	mov    (%rax),%rdx
    18a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    18a5:	48 89 10             	mov    %rdx,(%rax)
    18a8:	eb 2e                	jmp    18d8 <malloc+0xbe>
      else {
        p->s.size -= nunits;
    18aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18ae:	8b 40 08             	mov    0x8(%rax),%eax
    18b1:	2b 45 ec             	sub    -0x14(%rbp),%eax
    18b4:	89 c2                	mov    %eax,%edx
    18b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18ba:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    18bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18c1:	8b 40 08             	mov    0x8(%rax),%eax
    18c4:	89 c0                	mov    %eax,%eax
    18c6:	48 c1 e0 04          	shl    $0x4,%rax
    18ca:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    18ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18d2:	8b 55 ec             	mov    -0x14(%rbp),%edx
    18d5:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    18d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    18dc:	48 89 05 9d 06 00 00 	mov    %rax,0x69d(%rip)        # 1f80 <freep>
      return (void*)(p + 1);
    18e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18e7:	48 83 c0 10          	add    $0x10,%rax
    18eb:	eb 41                	jmp    192e <malloc+0x114>
    }
    if(p == freep)
    18ed:	48 8b 05 8c 06 00 00 	mov    0x68c(%rip),%rax        # 1f80 <freep>
    18f4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    18f8:	75 1c                	jne    1916 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
    18fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
    18fd:	89 c7                	mov    %eax,%edi
    18ff:	e8 ad fe ff ff       	call   17b1 <morecore>
    1904:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1908:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    190d:	75 07                	jne    1916 <malloc+0xfc>
        return 0;
    190f:	b8 00 00 00 00       	mov    $0x0,%eax
    1914:	eb 18                	jmp    192e <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    191a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    191e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1922:	48 8b 00             	mov    (%rax),%rax
    1925:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1929:	e9 54 ff ff ff       	jmp    1882 <malloc+0x68>
  }
}
    192e:	c9                   	leave
    192f:	c3                   	ret
