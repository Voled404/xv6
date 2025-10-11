
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
      29:	48 8b 04 c5 58 19 00 	mov    0x1958(,%rax,8),%rax
      30:	00 
      31:	3e ff e0             	notrack jmp *%rax
  default:
    panic("runcmd");
      34:	48 c7 c7 28 19 00 00 	mov    $0x1928,%rdi
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
      80:	48 c7 c6 2f 19 00 00 	mov    $0x192f,%rsi
      87:	bf 02 00 00 00       	mov    $0x2,%edi
      8c:	b8 00 00 00 00       	mov    $0x0,%eax
      91:	e8 7d 12 00 00       	call   1313 <printf>
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
      d9:	48 c7 c6 3f 19 00 00 	mov    $0x193f,%rsi
      e0:	bf 02 00 00 00       	mov    $0x2,%edi
      e5:	b8 00 00 00 00       	mov    $0x0,%eax
      ea:	e8 24 12 00 00       	call   1313 <printf>
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
     15c:	48 c7 c7 4f 19 00 00 	mov    $0x194f,%rdi
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
     244:	48 c7 c6 88 19 00 00 	mov    $0x1988,%rsi
     24b:	bf 02 00 00 00       	mov    $0x2,%edi
     250:	b8 00 00 00 00       	mov    $0x0,%eax
     255:	e8 b9 10 00 00       	call   1313 <printf>
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
     2bd:	48 c7 c7 8b 19 00 00 	mov    $0x198b,%rdi
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
     32d:	48 c7 c6 93 19 00 00 	mov    $0x1993,%rsi
     334:	bf 02 00 00 00       	mov    $0x2,%edi
     339:	b8 00 00 00 00       	mov    $0x0,%eax
     33e:	e8 d0 0f 00 00       	call   1313 <printf>
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
     39f:	48 c7 c6 a1 19 00 00 	mov    $0x19a1,%rsi
     3a6:	bf 02 00 00 00       	mov    $0x2,%edi
     3ab:	b8 00 00 00 00       	mov    $0x0,%eax
     3b0:	e8 5e 0f 00 00       	call   1313 <printf>
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
     3d4:	48 c7 c7 a5 19 00 00 	mov    $0x19a5,%rdi
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
     3f6:	e8 17 14 00 00       	call   1812 <malloc>
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
     449:	e8 c4 13 00 00       	call   1812 <malloc>
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
     4c9:	e8 44 13 00 00       	call   1812 <malloc>
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
     529:	e8 e4 12 00 00       	call   1812 <malloc>
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
     585:	e8 88 12 00 00       	call   1812 <malloc>
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
     81a:	48 c7 c2 aa 19 00 00 	mov    $0x19aa,%rdx
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
     83d:	48 c7 c6 ab 19 00 00 	mov    $0x19ab,%rsi
     844:	bf 02 00 00 00       	mov    $0x2,%edi
     849:	b8 00 00 00 00       	mov    $0x0,%eax
     84e:	e8 c0 0a 00 00       	call   1313 <printf>
    panic("syntax");
     853:	48 c7 c7 ba 19 00 00 	mov    $0x19ba,%rdi
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
     8d4:	48 c7 c2 c1 19 00 00 	mov    $0x19c1,%rdx
     8db:	48 89 ce             	mov    %rcx,%rsi
     8de:	48 89 c7             	mov    %rax,%rdi
     8e1:	e8 59 fe ff ff       	call   73f <peek>
     8e6:	85 c0                	test   %eax,%eax
     8e8:	75 b8                	jne    8a2 <parseline+0x2d>
  }
  if(peek(ps, es, ";")){
     8ea:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     8ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8f2:	48 c7 c2 c3 19 00 00 	mov    $0x19c3,%rdx
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
     984:	48 c7 c2 c5 19 00 00 	mov    $0x19c5,%rdx
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
     a3a:	48 c7 c7 c7 19 00 00 	mov    $0x19c7,%rdi
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
     ad4:	48 c7 c2 e4 19 00 00 	mov    $0x19e4,%rdx
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
     b10:	48 c7 c2 e7 19 00 00 	mov    $0x19e7,%rdx
     b17:	48 89 ce             	mov    %rcx,%rsi
     b1a:	48 89 c7             	mov    %rax,%rdi
     b1d:	e8 1d fc ff ff       	call   73f <peek>
     b22:	85 c0                	test   %eax,%eax
     b24:	75 0c                	jne    b32 <parseblock+0x3e>
    panic("parseblock");
     b26:	48 c7 c7 e9 19 00 00 	mov    $0x19e9,%rdi
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
     b6b:	48 c7 c2 f4 19 00 00 	mov    $0x19f4,%rdx
     b72:	48 89 ce             	mov    %rcx,%rsi
     b75:	48 89 c7             	mov    %rax,%rdi
     b78:	e8 c2 fb ff ff       	call   73f <peek>
     b7d:	85 c0                	test   %eax,%eax
     b7f:	75 0c                	jne    b8d <parseblock+0x99>
    panic("syntax - missing )");
     b81:	48 c7 c7 f6 19 00 00 	mov    $0x19f6,%rdi
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
     be4:	48 c7 c2 e7 19 00 00 	mov    $0x19e7,%rdx
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
     c75:	48 c7 c7 ba 19 00 00 	mov    $0x19ba,%rdi
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
     cb5:	48 c7 c7 09 1a 00 00 	mov    $0x1a09,%rdi
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
     ce4:	48 c7 c2 17 1a 00 00 	mov    $0x1a17,%rdx
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
     d63:	48 8b 04 c5 20 1a 00 	mov    0x1a20(,%rax,8),%rax
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

0000000000001221 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1221:	f3 0f 1e fa          	endbr64
    1225:	55                   	push   %rbp
    1226:	48 89 e5             	mov    %rsp,%rbp
    1229:	48 83 ec 10          	sub    $0x10,%rsp
    122d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1230:	89 f0                	mov    %esi,%eax
    1232:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1235:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1239:	8b 45 fc             	mov    -0x4(%rbp),%eax
    123c:	ba 01 00 00 00       	mov    $0x1,%edx
    1241:	48 89 ce             	mov    %rcx,%rsi
    1244:	89 c7                	mov    %eax,%edi
    1246:	e8 36 ff ff ff       	call   1181 <write>
}
    124b:	90                   	nop
    124c:	c9                   	leave
    124d:	c3                   	ret

000000000000124e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    124e:	f3 0f 1e fa          	endbr64
    1252:	55                   	push   %rbp
    1253:	48 89 e5             	mov    %rsp,%rbp
    1256:	48 83 ec 30          	sub    $0x30,%rsp
    125a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    125d:	89 75 d8             	mov    %esi,-0x28(%rbp)
    1260:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    1263:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1266:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
    126d:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    1271:	74 17                	je     128a <printint+0x3c>
    1273:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1277:	79 11                	jns    128a <printint+0x3c>
    neg = 1;
    1279:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
    1280:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1283:	f7 d8                	neg    %eax
    1285:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1288:	eb 06                	jmp    1290 <printint+0x42>
  } else {
    x = xx;
    128a:	8b 45 d8             	mov    -0x28(%rbp),%eax
    128d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
    1290:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
    1297:	8b 75 d4             	mov    -0x2c(%rbp),%esi
    129a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    129d:	ba 00 00 00 00       	mov    $0x0,%edx
    12a2:	f7 f6                	div    %esi
    12a4:	89 d1                	mov    %edx,%ecx
    12a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12a9:	8d 50 01             	lea    0x1(%rax),%edx
    12ac:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12af:	89 ca                	mov    %ecx,%edx
    12b1:	0f b6 92 e0 1e 00 00 	movzbl 0x1ee0(%rdx),%edx
    12b8:	48 98                	cltq
    12ba:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
    12be:	8b 7d d4             	mov    -0x2c(%rbp),%edi
    12c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    12c4:	ba 00 00 00 00       	mov    $0x0,%edx
    12c9:	f7 f7                	div    %edi
    12cb:	89 45 f4             	mov    %eax,-0xc(%rbp)
    12ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    12d2:	75 c3                	jne    1297 <printint+0x49>
  if(neg)
    12d4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    12d8:	74 2b                	je     1305 <printint+0xb7>
    buf[i++] = '-';
    12da:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12dd:	8d 50 01             	lea    0x1(%rax),%edx
    12e0:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12e3:	48 98                	cltq
    12e5:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
    12ea:	eb 19                	jmp    1305 <printint+0xb7>
    putc(fd, buf[i]);
    12ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12ef:	48 98                	cltq
    12f1:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    12f6:	0f be d0             	movsbl %al,%edx
    12f9:	8b 45 dc             	mov    -0x24(%rbp),%eax
    12fc:	89 d6                	mov    %edx,%esi
    12fe:	89 c7                	mov    %eax,%edi
    1300:	e8 1c ff ff ff       	call   1221 <putc>
  while(--i >= 0)
    1305:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    1309:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    130d:	79 dd                	jns    12ec <printint+0x9e>
}
    130f:	90                   	nop
    1310:	90                   	nop
    1311:	c9                   	leave
    1312:	c3                   	ret

0000000000001313 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1313:	f3 0f 1e fa          	endbr64
    1317:	55                   	push   %rbp
    1318:	48 89 e5             	mov    %rsp,%rbp
    131b:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1322:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1328:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    132f:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1336:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    133d:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1344:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    134b:	84 c0                	test   %al,%al
    134d:	74 20                	je     136f <printf+0x5c>
    134f:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1353:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1357:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    135b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    135f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1363:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1367:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    136b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
    136f:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1376:	00 00 00 
    1379:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1380:	00 00 00 
    1383:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1387:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    138e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1395:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
    139c:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    13a3:	00 00 00 
  for(i = 0; fmt[i]; i++){
    13a6:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    13ad:	00 00 00 
    13b0:	e9 a8 02 00 00       	jmp    165d <printf+0x34a>
    c = fmt[i] & 0xff;
    13b5:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    13bb:	48 63 d0             	movslq %eax,%rdx
    13be:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    13c5:	48 01 d0             	add    %rdx,%rax
    13c8:	0f b6 00             	movzbl (%rax),%eax
    13cb:	0f be c0             	movsbl %al,%eax
    13ce:	25 ff 00 00 00       	and    $0xff,%eax
    13d3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
    13d9:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
    13e0:	75 35                	jne    1417 <printf+0x104>
      if(c == '%'){
    13e2:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    13e9:	75 0f                	jne    13fa <printf+0xe7>
        state = '%';
    13eb:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
    13f2:	00 00 00 
    13f5:	e9 5c 02 00 00       	jmp    1656 <printf+0x343>
      } else {
        putc(fd, c);
    13fa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1400:	0f be d0             	movsbl %al,%edx
    1403:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1409:	89 d6                	mov    %edx,%esi
    140b:	89 c7                	mov    %eax,%edi
    140d:	e8 0f fe ff ff       	call   1221 <putc>
    1412:	e9 3f 02 00 00       	jmp    1656 <printf+0x343>
      }
    } else if(state == '%'){
    1417:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
    141e:	0f 85 32 02 00 00    	jne    1656 <printf+0x343>
      if(c == 'd'){
    1424:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    142b:	75 5e                	jne    148b <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
    142d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1433:	83 f8 2f             	cmp    $0x2f,%eax
    1436:	77 23                	ja     145b <printf+0x148>
    1438:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    143f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1445:	89 d2                	mov    %edx,%edx
    1447:	48 01 d0             	add    %rdx,%rax
    144a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1450:	83 c2 08             	add    $0x8,%edx
    1453:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1459:	eb 12                	jmp    146d <printf+0x15a>
    145b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1462:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1466:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    146d:	8b 30                	mov    (%rax),%esi
    146f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1475:	b9 01 00 00 00       	mov    $0x1,%ecx
    147a:	ba 0a 00 00 00       	mov    $0xa,%edx
    147f:	89 c7                	mov    %eax,%edi
    1481:	e8 c8 fd ff ff       	call   124e <printint>
    1486:	e9 c1 01 00 00       	jmp    164c <printf+0x339>
      } else if(c == 'x' || c == 'p'){
    148b:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1492:	74 09                	je     149d <printf+0x18a>
    1494:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    149b:	75 5e                	jne    14fb <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
    149d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    14a3:	83 f8 2f             	cmp    $0x2f,%eax
    14a6:	77 23                	ja     14cb <printf+0x1b8>
    14a8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    14af:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    14b5:	89 d2                	mov    %edx,%edx
    14b7:	48 01 d0             	add    %rdx,%rax
    14ba:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    14c0:	83 c2 08             	add    $0x8,%edx
    14c3:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    14c9:	eb 12                	jmp    14dd <printf+0x1ca>
    14cb:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    14d2:	48 8d 50 08          	lea    0x8(%rax),%rdx
    14d6:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    14dd:	8b 30                	mov    (%rax),%esi
    14df:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    14e5:	b9 00 00 00 00       	mov    $0x0,%ecx
    14ea:	ba 10 00 00 00       	mov    $0x10,%edx
    14ef:	89 c7                	mov    %eax,%edi
    14f1:	e8 58 fd ff ff       	call   124e <printint>
    14f6:	e9 51 01 00 00       	jmp    164c <printf+0x339>
      } else if(c == 's'){
    14fb:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1502:	0f 85 98 00 00 00    	jne    15a0 <printf+0x28d>
        s = va_arg(ap, char*);
    1508:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    150e:	83 f8 2f             	cmp    $0x2f,%eax
    1511:	77 23                	ja     1536 <printf+0x223>
    1513:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    151a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1520:	89 d2                	mov    %edx,%edx
    1522:	48 01 d0             	add    %rdx,%rax
    1525:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    152b:	83 c2 08             	add    $0x8,%edx
    152e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1534:	eb 12                	jmp    1548 <printf+0x235>
    1536:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    153d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1541:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1548:	48 8b 00             	mov    (%rax),%rax
    154b:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
    1552:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
    1559:	00 
    155a:	75 31                	jne    158d <printf+0x27a>
          s = "(null)";
    155c:	48 c7 85 48 ff ff ff 	movq   $0x1a50,-0xb8(%rbp)
    1563:	50 1a 00 00 
        while(*s != 0){
    1567:	eb 24                	jmp    158d <printf+0x27a>
          putc(fd, *s);
    1569:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    1570:	0f b6 00             	movzbl (%rax),%eax
    1573:	0f be d0             	movsbl %al,%edx
    1576:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    157c:	89 d6                	mov    %edx,%esi
    157e:	89 c7                	mov    %eax,%edi
    1580:	e8 9c fc ff ff       	call   1221 <putc>
          s++;
    1585:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
    158c:	01 
        while(*s != 0){
    158d:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    1594:	0f b6 00             	movzbl (%rax),%eax
    1597:	84 c0                	test   %al,%al
    1599:	75 ce                	jne    1569 <printf+0x256>
    159b:	e9 ac 00 00 00       	jmp    164c <printf+0x339>
        }
      } else if(c == 'c'){
    15a0:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    15a7:	75 56                	jne    15ff <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
    15a9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    15af:	83 f8 2f             	cmp    $0x2f,%eax
    15b2:	77 23                	ja     15d7 <printf+0x2c4>
    15b4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    15bb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    15c1:	89 d2                	mov    %edx,%edx
    15c3:	48 01 d0             	add    %rdx,%rax
    15c6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    15cc:	83 c2 08             	add    $0x8,%edx
    15cf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    15d5:	eb 12                	jmp    15e9 <printf+0x2d6>
    15d7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    15de:	48 8d 50 08          	lea    0x8(%rax),%rdx
    15e2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    15e9:	8b 00                	mov    (%rax),%eax
    15eb:	0f be d0             	movsbl %al,%edx
    15ee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    15f4:	89 d6                	mov    %edx,%esi
    15f6:	89 c7                	mov    %eax,%edi
    15f8:	e8 24 fc ff ff       	call   1221 <putc>
    15fd:	eb 4d                	jmp    164c <printf+0x339>
      } else if(c == '%'){
    15ff:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1606:	75 1a                	jne    1622 <printf+0x30f>
        putc(fd, c);
    1608:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    160e:	0f be d0             	movsbl %al,%edx
    1611:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1617:	89 d6                	mov    %edx,%esi
    1619:	89 c7                	mov    %eax,%edi
    161b:	e8 01 fc ff ff       	call   1221 <putc>
    1620:	eb 2a                	jmp    164c <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1622:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1628:	be 25 00 00 00       	mov    $0x25,%esi
    162d:	89 c7                	mov    %eax,%edi
    162f:	e8 ed fb ff ff       	call   1221 <putc>
        putc(fd, c);
    1634:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    163a:	0f be d0             	movsbl %al,%edx
    163d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1643:	89 d6                	mov    %edx,%esi
    1645:	89 c7                	mov    %eax,%edi
    1647:	e8 d5 fb ff ff       	call   1221 <putc>
      }
      state = 0;
    164c:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    1653:	00 00 00 
  for(i = 0; fmt[i]; i++){
    1656:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
    165d:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    1663:	48 63 d0             	movslq %eax,%rdx
    1666:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    166d:	48 01 d0             	add    %rdx,%rax
    1670:	0f b6 00             	movzbl (%rax),%eax
    1673:	84 c0                	test   %al,%al
    1675:	0f 85 3a fd ff ff    	jne    13b5 <printf+0xa2>
    }
  }
}
    167b:	90                   	nop
    167c:	90                   	nop
    167d:	c9                   	leave
    167e:	c3                   	ret

000000000000167f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    167f:	f3 0f 1e fa          	endbr64
    1683:	55                   	push   %rbp
    1684:	48 89 e5             	mov    %rsp,%rbp
    1687:	48 83 ec 18          	sub    $0x18,%rsp
    168b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    168f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1693:	48 83 e8 10          	sub    $0x10,%rax
    1697:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    169b:	48 8b 05 de 08 00 00 	mov    0x8de(%rip),%rax        # 1f80 <freep>
    16a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    16a6:	eb 2f                	jmp    16d7 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16ac:	48 8b 00             	mov    (%rax),%rax
    16af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16b3:	72 17                	jb     16cc <free+0x4d>
    16b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16b9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16bd:	72 2f                	jb     16ee <free+0x6f>
    16bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16c3:	48 8b 00             	mov    (%rax),%rax
    16c6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    16ca:	72 22                	jb     16ee <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16d0:	48 8b 00             	mov    (%rax),%rax
    16d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    16d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16db:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    16df:	73 c7                	jae    16a8 <free+0x29>
    16e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16e5:	48 8b 00             	mov    (%rax),%rax
    16e8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    16ec:	73 ba                	jae    16a8 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16f2:	8b 40 08             	mov    0x8(%rax),%eax
    16f5:	89 c0                	mov    %eax,%eax
    16f7:	48 c1 e0 04          	shl    $0x4,%rax
    16fb:	48 89 c2             	mov    %rax,%rdx
    16fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1702:	48 01 c2             	add    %rax,%rdx
    1705:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1709:	48 8b 00             	mov    (%rax),%rax
    170c:	48 39 c2             	cmp    %rax,%rdx
    170f:	75 2d                	jne    173e <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
    1711:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1715:	8b 50 08             	mov    0x8(%rax),%edx
    1718:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    171c:	48 8b 00             	mov    (%rax),%rax
    171f:	8b 40 08             	mov    0x8(%rax),%eax
    1722:	01 c2                	add    %eax,%edx
    1724:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1728:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    172b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    172f:	48 8b 00             	mov    (%rax),%rax
    1732:	48 8b 10             	mov    (%rax),%rdx
    1735:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1739:	48 89 10             	mov    %rdx,(%rax)
    173c:	eb 0e                	jmp    174c <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
    173e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1742:	48 8b 10             	mov    (%rax),%rdx
    1745:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1749:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    174c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1750:	8b 40 08             	mov    0x8(%rax),%eax
    1753:	89 c0                	mov    %eax,%eax
    1755:	48 c1 e0 04          	shl    $0x4,%rax
    1759:	48 89 c2             	mov    %rax,%rdx
    175c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1760:	48 01 d0             	add    %rdx,%rax
    1763:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1767:	75 27                	jne    1790 <free+0x111>
    p->s.size += bp->s.size;
    1769:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    176d:	8b 50 08             	mov    0x8(%rax),%edx
    1770:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1774:	8b 40 08             	mov    0x8(%rax),%eax
    1777:	01 c2                	add    %eax,%edx
    1779:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    177d:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1780:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1784:	48 8b 10             	mov    (%rax),%rdx
    1787:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    178b:	48 89 10             	mov    %rdx,(%rax)
    178e:	eb 0b                	jmp    179b <free+0x11c>
  } else
    p->s.ptr = bp;
    1790:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1794:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1798:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    179b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    179f:	48 89 05 da 07 00 00 	mov    %rax,0x7da(%rip)        # 1f80 <freep>
}
    17a6:	90                   	nop
    17a7:	c9                   	leave
    17a8:	c3                   	ret

00000000000017a9 <morecore>:

static Header*
morecore(uint nu)
{
    17a9:	f3 0f 1e fa          	endbr64
    17ad:	55                   	push   %rbp
    17ae:	48 89 e5             	mov    %rsp,%rbp
    17b1:	48 83 ec 20          	sub    $0x20,%rsp
    17b5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    17b8:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    17bf:	77 07                	ja     17c8 <morecore+0x1f>
    nu = 4096;
    17c1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    17c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    17cb:	c1 e0 04             	shl    $0x4,%eax
    17ce:	89 c7                	mov    %eax,%edi
    17d0:	e8 14 fa ff ff       	call   11e9 <sbrk>
    17d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    17d9:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    17de:	75 07                	jne    17e7 <morecore+0x3e>
    return 0;
    17e0:	b8 00 00 00 00       	mov    $0x0,%eax
    17e5:	eb 29                	jmp    1810 <morecore+0x67>
  hp = (Header*)p;
    17e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    17ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17f3:	8b 55 ec             	mov    -0x14(%rbp),%edx
    17f6:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    17f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17fd:	48 83 c0 10          	add    $0x10,%rax
    1801:	48 89 c7             	mov    %rax,%rdi
    1804:	e8 76 fe ff ff       	call   167f <free>
  return freep;
    1809:	48 8b 05 70 07 00 00 	mov    0x770(%rip),%rax        # 1f80 <freep>
}
    1810:	c9                   	leave
    1811:	c3                   	ret

0000000000001812 <malloc>:

void*
malloc(uint nbytes)
{
    1812:	f3 0f 1e fa          	endbr64
    1816:	55                   	push   %rbp
    1817:	48 89 e5             	mov    %rsp,%rbp
    181a:	48 83 ec 30          	sub    $0x30,%rsp
    181e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1821:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1824:	48 83 c0 0f          	add    $0xf,%rax
    1828:	48 c1 e8 04          	shr    $0x4,%rax
    182c:	83 c0 01             	add    $0x1,%eax
    182f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1832:	48 8b 05 47 07 00 00 	mov    0x747(%rip),%rax        # 1f80 <freep>
    1839:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    183d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1842:	75 2b                	jne    186f <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
    1844:	48 c7 45 f0 70 1f 00 	movq   $0x1f70,-0x10(%rbp)
    184b:	00 
    184c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1850:	48 89 05 29 07 00 00 	mov    %rax,0x729(%rip)        # 1f80 <freep>
    1857:	48 8b 05 22 07 00 00 	mov    0x722(%rip),%rax        # 1f80 <freep>
    185e:	48 89 05 0b 07 00 00 	mov    %rax,0x70b(%rip)        # 1f70 <base>
    base.s.size = 0;
    1865:	c7 05 09 07 00 00 00 	movl   $0x0,0x709(%rip)        # 1f78 <base+0x8>
    186c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    186f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1873:	48 8b 00             	mov    (%rax),%rax
    1876:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    187a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    187e:	8b 40 08             	mov    0x8(%rax),%eax
    1881:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1884:	72 5f                	jb     18e5 <malloc+0xd3>
      if(p->s.size == nunits)
    1886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    188a:	8b 40 08             	mov    0x8(%rax),%eax
    188d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1890:	75 10                	jne    18a2 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
    1892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1896:	48 8b 10             	mov    (%rax),%rdx
    1899:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    189d:	48 89 10             	mov    %rdx,(%rax)
    18a0:	eb 2e                	jmp    18d0 <malloc+0xbe>
      else {
        p->s.size -= nunits;
    18a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18a6:	8b 40 08             	mov    0x8(%rax),%eax
    18a9:	2b 45 ec             	sub    -0x14(%rbp),%eax
    18ac:	89 c2                	mov    %eax,%edx
    18ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18b2:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    18b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18b9:	8b 40 08             	mov    0x8(%rax),%eax
    18bc:	89 c0                	mov    %eax,%eax
    18be:	48 c1 e0 04          	shl    $0x4,%rax
    18c2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    18c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18ca:	8b 55 ec             	mov    -0x14(%rbp),%edx
    18cd:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    18d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    18d4:	48 89 05 a5 06 00 00 	mov    %rax,0x6a5(%rip)        # 1f80 <freep>
      return (void*)(p + 1);
    18db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18df:	48 83 c0 10          	add    $0x10,%rax
    18e3:	eb 41                	jmp    1926 <malloc+0x114>
    }
    if(p == freep)
    18e5:	48 8b 05 94 06 00 00 	mov    0x694(%rip),%rax        # 1f80 <freep>
    18ec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    18f0:	75 1c                	jne    190e <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
    18f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    18f5:	89 c7                	mov    %eax,%edi
    18f7:	e8 ad fe ff ff       	call   17a9 <morecore>
    18fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1900:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1905:	75 07                	jne    190e <malloc+0xfc>
        return 0;
    1907:	b8 00 00 00 00       	mov    $0x0,%eax
    190c:	eb 18                	jmp    1926 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    190e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1912:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    191a:	48 8b 00             	mov    (%rax),%rax
    191d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1921:	e9 54 ff ff ff       	jmp    187a <malloc+0x68>
  }
}
    1926:	c9                   	leave
    1927:	c3                   	ret
