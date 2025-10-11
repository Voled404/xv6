
fs/usertests:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	f3 0f 1e fa          	endbr64
       4:	55                   	push   %rbp
       5:	48 89 e5             	mov    %rsp,%rbp
       8:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(stdout, "open test\n");
       c:	8b 05 f6 63 00 00    	mov    0x63f6(%rip),%eax        # 6408 <stdout>
      12:	48 c7 c6 9e 46 00 00 	mov    $0x469e,%rsi
      19:	89 c7                	mov    %eax,%edi
      1b:	b8 00 00 00 00       	mov    $0x0,%eax
      20:	e8 4d 40 00 00       	call   4072 <printf>
  fd = open("echo", 0);
      25:	be 00 00 00 00       	mov    $0x0,%esi
      2a:	48 c7 c7 88 46 00 00 	mov    $0x4688,%rdi
      31:	e8 ba 3e 00 00       	call   3ef0 <open>
      36:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
      39:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
      3d:	79 1e                	jns    5d <opentest+0x5d>
    printf(stdout, "open echo failed!\n");
      3f:	8b 05 c3 63 00 00    	mov    0x63c3(%rip),%eax        # 6408 <stdout>
      45:	48 c7 c6 a9 46 00 00 	mov    $0x46a9,%rsi
      4c:	89 c7                	mov    %eax,%edi
      4e:	b8 00 00 00 00       	mov    $0x0,%eax
      53:	e8 1a 40 00 00       	call   4072 <printf>
    exit();
      58:	e8 53 3e 00 00       	call   3eb0 <exit>
  }
  close(fd);
      5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
      60:	89 c7                	mov    %eax,%edi
      62:	e8 71 3e 00 00       	call   3ed8 <close>
  fd = open("doesnotexist", 0);
      67:	be 00 00 00 00       	mov    $0x0,%esi
      6c:	48 c7 c7 bc 46 00 00 	mov    $0x46bc,%rdi
      73:	e8 78 3e 00 00       	call   3ef0 <open>
      78:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
      7b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
      7f:	78 1e                	js     9f <opentest+0x9f>
    printf(stdout, "open doesnotexist succeeded!\n");
      81:	8b 05 81 63 00 00    	mov    0x6381(%rip),%eax        # 6408 <stdout>
      87:	48 c7 c6 c9 46 00 00 	mov    $0x46c9,%rsi
      8e:	89 c7                	mov    %eax,%edi
      90:	b8 00 00 00 00       	mov    $0x0,%eax
      95:	e8 d8 3f 00 00       	call   4072 <printf>
    exit();
      9a:	e8 11 3e 00 00       	call   3eb0 <exit>
  }
  printf(stdout, "open test ok\n");
      9f:	8b 05 63 63 00 00    	mov    0x6363(%rip),%eax        # 6408 <stdout>
      a5:	48 c7 c6 e7 46 00 00 	mov    $0x46e7,%rsi
      ac:	89 c7                	mov    %eax,%edi
      ae:	b8 00 00 00 00       	mov    $0x0,%eax
      b3:	e8 ba 3f 00 00       	call   4072 <printf>
}
      b8:	90                   	nop
      b9:	c9                   	leave
      ba:	c3                   	ret

00000000000000bb <writetest>:

void
writetest(void)
{
      bb:	f3 0f 1e fa          	endbr64
      bf:	55                   	push   %rbp
      c0:	48 89 e5             	mov    %rsp,%rbp
      c3:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      c7:	8b 05 3b 63 00 00    	mov    0x633b(%rip),%eax        # 6408 <stdout>
      cd:	48 c7 c6 f5 46 00 00 	mov    $0x46f5,%rsi
      d4:	89 c7                	mov    %eax,%edi
      d6:	b8 00 00 00 00       	mov    $0x0,%eax
      db:	e8 92 3f 00 00       	call   4072 <printf>
  fd = open("small", O_CREATE|O_RDWR);
      e0:	be 02 02 00 00       	mov    $0x202,%esi
      e5:	48 c7 c7 06 47 00 00 	mov    $0x4706,%rdi
      ec:	e8 ff 3d 00 00       	call   3ef0 <open>
      f1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd >= 0){
      f4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
      f8:	78 25                	js     11f <writetest+0x64>
    printf(stdout, "creat small succeeded; ok\n");
      fa:	8b 05 08 63 00 00    	mov    0x6308(%rip),%eax        # 6408 <stdout>
     100:	48 c7 c6 0c 47 00 00 	mov    $0x470c,%rsi
     107:	89 c7                	mov    %eax,%edi
     109:	b8 00 00 00 00       	mov    $0x0,%eax
     10e:	e8 5f 3f 00 00       	call   4072 <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     11a:	e9 9a 00 00 00       	jmp    1b9 <writetest+0xfe>
    printf(stdout, "error: creat small failed!\n");
     11f:	8b 05 e3 62 00 00    	mov    0x62e3(%rip),%eax        # 6408 <stdout>
     125:	48 c7 c6 27 47 00 00 	mov    $0x4727,%rsi
     12c:	89 c7                	mov    %eax,%edi
     12e:	b8 00 00 00 00       	mov    $0x0,%eax
     133:	e8 3a 3f 00 00       	call   4072 <printf>
    exit();
     138:	e8 73 3d 00 00       	call   3eb0 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     13d:	8b 45 f8             	mov    -0x8(%rbp),%eax
     140:	ba 0a 00 00 00       	mov    $0xa,%edx
     145:	48 c7 c6 43 47 00 00 	mov    $0x4743,%rsi
     14c:	89 c7                	mov    %eax,%edi
     14e:	e8 7d 3d 00 00       	call   3ed0 <write>
     153:	83 f8 0a             	cmp    $0xa,%eax
     156:	74 21                	je     179 <writetest+0xbe>
      printf(stdout, "error: write aa %d new file failed\n", i);
     158:	8b 05 aa 62 00 00    	mov    0x62aa(%rip),%eax        # 6408 <stdout>
     15e:	8b 55 fc             	mov    -0x4(%rbp),%edx
     161:	48 c7 c6 50 47 00 00 	mov    $0x4750,%rsi
     168:	89 c7                	mov    %eax,%edi
     16a:	b8 00 00 00 00       	mov    $0x0,%eax
     16f:	e8 fe 3e 00 00       	call   4072 <printf>
      exit();
     174:	e8 37 3d 00 00       	call   3eb0 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     179:	8b 45 f8             	mov    -0x8(%rbp),%eax
     17c:	ba 0a 00 00 00       	mov    $0xa,%edx
     181:	48 c7 c6 74 47 00 00 	mov    $0x4774,%rsi
     188:	89 c7                	mov    %eax,%edi
     18a:	e8 41 3d 00 00       	call   3ed0 <write>
     18f:	83 f8 0a             	cmp    $0xa,%eax
     192:	74 21                	je     1b5 <writetest+0xfa>
      printf(stdout, "error: write bb %d new file failed\n", i);
     194:	8b 05 6e 62 00 00    	mov    0x626e(%rip),%eax        # 6408 <stdout>
     19a:	8b 55 fc             	mov    -0x4(%rbp),%edx
     19d:	48 c7 c6 80 47 00 00 	mov    $0x4780,%rsi
     1a4:	89 c7                	mov    %eax,%edi
     1a6:	b8 00 00 00 00       	mov    $0x0,%eax
     1ab:	e8 c2 3e 00 00       	call   4072 <printf>
      exit();
     1b0:	e8 fb 3c 00 00       	call   3eb0 <exit>
  for(i = 0; i < 100; i++){
     1b5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     1b9:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
     1bd:	0f 8e 7a ff ff ff    	jle    13d <writetest+0x82>
    }
  }
  printf(stdout, "writes ok\n");
     1c3:	8b 05 3f 62 00 00    	mov    0x623f(%rip),%eax        # 6408 <stdout>
     1c9:	48 c7 c6 a4 47 00 00 	mov    $0x47a4,%rsi
     1d0:	89 c7                	mov    %eax,%edi
     1d2:	b8 00 00 00 00       	mov    $0x0,%eax
     1d7:	e8 96 3e 00 00       	call   4072 <printf>
  close(fd);
     1dc:	8b 45 f8             	mov    -0x8(%rbp),%eax
     1df:	89 c7                	mov    %eax,%edi
     1e1:	e8 f2 3c 00 00       	call   3ed8 <close>
  fd = open("small", O_RDONLY);
     1e6:	be 00 00 00 00       	mov    $0x0,%esi
     1eb:	48 c7 c7 06 47 00 00 	mov    $0x4706,%rdi
     1f2:	e8 f9 3c 00 00       	call   3ef0 <open>
     1f7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd >= 0){
     1fa:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     1fe:	78 3d                	js     23d <writetest+0x182>
    printf(stdout, "open small succeeded ok\n");
     200:	8b 05 02 62 00 00    	mov    0x6202(%rip),%eax        # 6408 <stdout>
     206:	48 c7 c6 af 47 00 00 	mov    $0x47af,%rsi
     20d:	89 c7                	mov    %eax,%edi
     20f:	b8 00 00 00 00       	mov    $0x0,%eax
     214:	e8 59 3e 00 00       	call   4072 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     219:	8b 45 f8             	mov    -0x8(%rbp),%eax
     21c:	ba d0 07 00 00       	mov    $0x7d0,%edx
     221:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     228:	89 c7                	mov    %eax,%edi
     22a:	e8 99 3c 00 00       	call   3ec8 <read>
     22f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(i == 2000){
     232:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,-0x4(%rbp)
     239:	75 55                	jne    290 <writetest+0x1d5>
     23b:	eb 1e                	jmp    25b <writetest+0x1a0>
    printf(stdout, "error: open small failed!\n");
     23d:	8b 05 c5 61 00 00    	mov    0x61c5(%rip),%eax        # 6408 <stdout>
     243:	48 c7 c6 c8 47 00 00 	mov    $0x47c8,%rsi
     24a:	89 c7                	mov    %eax,%edi
     24c:	b8 00 00 00 00       	mov    $0x0,%eax
     251:	e8 1c 3e 00 00       	call   4072 <printf>
    exit();
     256:	e8 55 3c 00 00       	call   3eb0 <exit>
    printf(stdout, "read succeeded ok\n");
     25b:	8b 05 a7 61 00 00    	mov    0x61a7(%rip),%eax        # 6408 <stdout>
     261:	48 c7 c6 e3 47 00 00 	mov    $0x47e3,%rsi
     268:	89 c7                	mov    %eax,%edi
     26a:	b8 00 00 00 00       	mov    $0x0,%eax
     26f:	e8 fe 3d 00 00       	call   4072 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     274:	8b 45 f8             	mov    -0x8(%rbp),%eax
     277:	89 c7                	mov    %eax,%edi
     279:	e8 5a 3c 00 00       	call   3ed8 <close>

  if(unlink("small") < 0){
     27e:	48 c7 c7 06 47 00 00 	mov    $0x4706,%rdi
     285:	e8 76 3c 00 00       	call   3f00 <unlink>
     28a:	85 c0                	test   %eax,%eax
     28c:	79 3e                	jns    2cc <writetest+0x211>
     28e:	eb 1e                	jmp    2ae <writetest+0x1f3>
    printf(stdout, "read failed\n");
     290:	8b 05 72 61 00 00    	mov    0x6172(%rip),%eax        # 6408 <stdout>
     296:	48 c7 c6 f6 47 00 00 	mov    $0x47f6,%rsi
     29d:	89 c7                	mov    %eax,%edi
     29f:	b8 00 00 00 00       	mov    $0x0,%eax
     2a4:	e8 c9 3d 00 00       	call   4072 <printf>
    exit();
     2a9:	e8 02 3c 00 00       	call   3eb0 <exit>
    printf(stdout, "unlink small failed\n");
     2ae:	8b 05 54 61 00 00    	mov    0x6154(%rip),%eax        # 6408 <stdout>
     2b4:	48 c7 c6 03 48 00 00 	mov    $0x4803,%rsi
     2bb:	89 c7                	mov    %eax,%edi
     2bd:	b8 00 00 00 00       	mov    $0x0,%eax
     2c2:	e8 ab 3d 00 00       	call   4072 <printf>
    exit();
     2c7:	e8 e4 3b 00 00       	call   3eb0 <exit>
  }
  printf(stdout, "small file test ok\n");
     2cc:	8b 05 36 61 00 00    	mov    0x6136(%rip),%eax        # 6408 <stdout>
     2d2:	48 c7 c6 18 48 00 00 	mov    $0x4818,%rsi
     2d9:	89 c7                	mov    %eax,%edi
     2db:	b8 00 00 00 00       	mov    $0x0,%eax
     2e0:	e8 8d 3d 00 00       	call   4072 <printf>
}
     2e5:	90                   	nop
     2e6:	c9                   	leave
     2e7:	c3                   	ret

00000000000002e8 <writetest1>:

void
writetest1(void)
{
     2e8:	f3 0f 1e fa          	endbr64
     2ec:	55                   	push   %rbp
     2ed:	48 89 e5             	mov    %rsp,%rbp
     2f0:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2f4:	8b 05 0e 61 00 00    	mov    0x610e(%rip),%eax        # 6408 <stdout>
     2fa:	48 c7 c6 2c 48 00 00 	mov    $0x482c,%rsi
     301:	89 c7                	mov    %eax,%edi
     303:	b8 00 00 00 00       	mov    $0x0,%eax
     308:	e8 65 3d 00 00       	call   4072 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     30d:	be 02 02 00 00       	mov    $0x202,%esi
     312:	48 c7 c7 3c 48 00 00 	mov    $0x483c,%rdi
     319:	e8 d2 3b 00 00       	call   3ef0 <open>
     31e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
     321:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     325:	79 1e                	jns    345 <writetest1+0x5d>
    printf(stdout, "error: creat big failed!\n");
     327:	8b 05 db 60 00 00    	mov    0x60db(%rip),%eax        # 6408 <stdout>
     32d:	48 c7 c6 40 48 00 00 	mov    $0x4840,%rsi
     334:	89 c7                	mov    %eax,%edi
     336:	b8 00 00 00 00       	mov    $0x0,%eax
     33b:	e8 32 3d 00 00       	call   4072 <printf>
    exit();
     340:	e8 6b 3b 00 00       	call   3eb0 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     345:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     34c:	eb 4e                	jmp    39c <writetest1+0xb4>
    ((int*)buf)[0] = i;
     34e:	48 c7 c2 40 64 00 00 	mov    $0x6440,%rdx
     355:	8b 45 fc             	mov    -0x4(%rbp),%eax
     358:	89 02                	mov    %eax,(%rdx)
    if(write(fd, buf, 512) != 512){
     35a:	8b 45 f4             	mov    -0xc(%rbp),%eax
     35d:	ba 00 02 00 00       	mov    $0x200,%edx
     362:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     369:	89 c7                	mov    %eax,%edi
     36b:	e8 60 3b 00 00       	call   3ed0 <write>
     370:	3d 00 02 00 00       	cmp    $0x200,%eax
     375:	74 21                	je     398 <writetest1+0xb0>
      printf(stdout, "error: write big file failed\n", i);
     377:	8b 05 8b 60 00 00    	mov    0x608b(%rip),%eax        # 6408 <stdout>
     37d:	8b 55 fc             	mov    -0x4(%rbp),%edx
     380:	48 c7 c6 5a 48 00 00 	mov    $0x485a,%rsi
     387:	89 c7                	mov    %eax,%edi
     389:	b8 00 00 00 00       	mov    $0x0,%eax
     38e:	e8 df 3c 00 00       	call   4072 <printf>
      exit();
     393:	e8 18 3b 00 00       	call   3eb0 <exit>
  for(i = 0; i < MAXFILE; i++){
     398:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     39c:	8b 45 fc             	mov    -0x4(%rbp),%eax
     39f:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     3a4:	76 a8                	jbe    34e <writetest1+0x66>
    }
  }

  close(fd);
     3a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
     3a9:	89 c7                	mov    %eax,%edi
     3ab:	e8 28 3b 00 00       	call   3ed8 <close>

  fd = open("big", O_RDONLY);
     3b0:	be 00 00 00 00       	mov    $0x0,%esi
     3b5:	48 c7 c7 3c 48 00 00 	mov    $0x483c,%rdi
     3bc:	e8 2f 3b 00 00       	call   3ef0 <open>
     3c1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
     3c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     3c8:	79 1e                	jns    3e8 <writetest1+0x100>
    printf(stdout, "error: open big failed!\n");
     3ca:	8b 05 38 60 00 00    	mov    0x6038(%rip),%eax        # 6408 <stdout>
     3d0:	48 c7 c6 78 48 00 00 	mov    $0x4878,%rsi
     3d7:	89 c7                	mov    %eax,%edi
     3d9:	b8 00 00 00 00       	mov    $0x0,%eax
     3de:	e8 8f 3c 00 00       	call   4072 <printf>
    exit();
     3e3:	e8 c8 3a 00 00       	call   3eb0 <exit>
  }

  n = 0;
     3e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(;;){
    i = read(fd, buf, 512);
     3ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
     3f2:	ba 00 02 00 00       	mov    $0x200,%edx
     3f7:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     3fe:	89 c7                	mov    %eax,%edi
     400:	e8 c3 3a 00 00       	call   3ec8 <read>
     405:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(i == 0){
     408:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     40c:	75 2e                	jne    43c <writetest1+0x154>
      if(n == MAXFILE - 1){
     40e:	81 7d f8 8b 00 00 00 	cmpl   $0x8b,-0x8(%rbp)
     415:	0f 85 8c 00 00 00    	jne    4a7 <writetest1+0x1bf>
        printf(stdout, "read only %d blocks from big", n);
     41b:	8b 05 e7 5f 00 00    	mov    0x5fe7(%rip),%eax        # 6408 <stdout>
     421:	8b 55 f8             	mov    -0x8(%rbp),%edx
     424:	48 c7 c6 91 48 00 00 	mov    $0x4891,%rsi
     42b:	89 c7                	mov    %eax,%edi
     42d:	b8 00 00 00 00       	mov    $0x0,%eax
     432:	e8 3b 3c 00 00       	call   4072 <printf>
        exit();
     437:	e8 74 3a 00 00       	call   3eb0 <exit>
      }
      break;
    } else if(i != 512){
     43c:	81 7d fc 00 02 00 00 	cmpl   $0x200,-0x4(%rbp)
     443:	74 21                	je     466 <writetest1+0x17e>
      printf(stdout, "read failed %d\n", i);
     445:	8b 05 bd 5f 00 00    	mov    0x5fbd(%rip),%eax        # 6408 <stdout>
     44b:	8b 55 fc             	mov    -0x4(%rbp),%edx
     44e:	48 c7 c6 ae 48 00 00 	mov    $0x48ae,%rsi
     455:	89 c7                	mov    %eax,%edi
     457:	b8 00 00 00 00       	mov    $0x0,%eax
     45c:	e8 11 3c 00 00       	call   4072 <printf>
      exit();
     461:	e8 4a 3a 00 00       	call   3eb0 <exit>
    }
    if(((int*)buf)[0] != n){
     466:	48 c7 c0 40 64 00 00 	mov    $0x6440,%rax
     46d:	8b 00                	mov    (%rax),%eax
     46f:	39 45 f8             	cmp    %eax,-0x8(%rbp)
     472:	74 2a                	je     49e <writetest1+0x1b6>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     474:	48 c7 c0 40 64 00 00 	mov    $0x6440,%rax
      printf(stdout, "read content of block %d is %d\n",
     47b:	8b 08                	mov    (%rax),%ecx
     47d:	8b 05 85 5f 00 00    	mov    0x5f85(%rip),%eax        # 6408 <stdout>
     483:	8b 55 f8             	mov    -0x8(%rbp),%edx
     486:	48 c7 c6 c0 48 00 00 	mov    $0x48c0,%rsi
     48d:	89 c7                	mov    %eax,%edi
     48f:	b8 00 00 00 00       	mov    $0x0,%eax
     494:	e8 d9 3b 00 00       	call   4072 <printf>
      exit();
     499:	e8 12 3a 00 00       	call   3eb0 <exit>
    }
    n++;
     49e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    i = read(fd, buf, 512);
     4a2:	e9 48 ff ff ff       	jmp    3ef <writetest1+0x107>
      break;
     4a7:	90                   	nop
  }
  close(fd);
     4a8:	8b 45 f4             	mov    -0xc(%rbp),%eax
     4ab:	89 c7                	mov    %eax,%edi
     4ad:	e8 26 3a 00 00       	call   3ed8 <close>
  if(unlink("big") < 0){
     4b2:	48 c7 c7 3c 48 00 00 	mov    $0x483c,%rdi
     4b9:	e8 42 3a 00 00       	call   3f00 <unlink>
     4be:	85 c0                	test   %eax,%eax
     4c0:	79 1e                	jns    4e0 <writetest1+0x1f8>
    printf(stdout, "unlink big failed\n");
     4c2:	8b 05 40 5f 00 00    	mov    0x5f40(%rip),%eax        # 6408 <stdout>
     4c8:	48 c7 c6 e0 48 00 00 	mov    $0x48e0,%rsi
     4cf:	89 c7                	mov    %eax,%edi
     4d1:	b8 00 00 00 00       	mov    $0x0,%eax
     4d6:	e8 97 3b 00 00       	call   4072 <printf>
    exit();
     4db:	e8 d0 39 00 00       	call   3eb0 <exit>
  }
  printf(stdout, "big files ok\n");
     4e0:	8b 05 22 5f 00 00    	mov    0x5f22(%rip),%eax        # 6408 <stdout>
     4e6:	48 c7 c6 f3 48 00 00 	mov    $0x48f3,%rsi
     4ed:	89 c7                	mov    %eax,%edi
     4ef:	b8 00 00 00 00       	mov    $0x0,%eax
     4f4:	e8 79 3b 00 00       	call   4072 <printf>
}
     4f9:	90                   	nop
     4fa:	c9                   	leave
     4fb:	c3                   	ret

00000000000004fc <createtest>:

void
createtest(void)
{
     4fc:	f3 0f 1e fa          	endbr64
     500:	55                   	push   %rbp
     501:	48 89 e5             	mov    %rsp,%rbp
     504:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     508:	8b 05 fa 5e 00 00    	mov    0x5efa(%rip),%eax        # 6408 <stdout>
     50e:	48 c7 c6 08 49 00 00 	mov    $0x4908,%rsi
     515:	89 c7                	mov    %eax,%edi
     517:	b8 00 00 00 00       	mov    $0x0,%eax
     51c:	e8 51 3b 00 00       	call   4072 <printf>

  name[0] = 'a';
     521:	c6 05 18 7f 00 00 61 	movb   $0x61,0x7f18(%rip)        # 8440 <name>
  name[2] = '\0';
     528:	c6 05 13 7f 00 00 00 	movb   $0x0,0x7f13(%rip)        # 8442 <name+0x2>
  for(i = 0; i < 52; i++){
     52f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     536:	eb 2e                	jmp    566 <createtest+0x6a>
    name[1] = '0' + i;
     538:	8b 45 fc             	mov    -0x4(%rbp),%eax
     53b:	83 c0 30             	add    $0x30,%eax
     53e:	88 05 fd 7e 00 00    	mov    %al,0x7efd(%rip)        # 8441 <name+0x1>
    fd = open(name, O_CREATE|O_RDWR);
     544:	be 02 02 00 00       	mov    $0x202,%esi
     549:	48 c7 c7 40 84 00 00 	mov    $0x8440,%rdi
     550:	e8 9b 39 00 00       	call   3ef0 <open>
     555:	89 45 f8             	mov    %eax,-0x8(%rbp)
    close(fd);
     558:	8b 45 f8             	mov    -0x8(%rbp),%eax
     55b:	89 c7                	mov    %eax,%edi
     55d:	e8 76 39 00 00       	call   3ed8 <close>
  for(i = 0; i < 52; i++){
     562:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     566:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
     56a:	7e cc                	jle    538 <createtest+0x3c>
  }
  name[0] = 'a';
     56c:	c6 05 cd 7e 00 00 61 	movb   $0x61,0x7ecd(%rip)        # 8440 <name>
  name[2] = '\0';
     573:	c6 05 c8 7e 00 00 00 	movb   $0x0,0x7ec8(%rip)        # 8442 <name+0x2>
  for(i = 0; i < 52; i++){
     57a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     581:	eb 1c                	jmp    59f <createtest+0xa3>
    name[1] = '0' + i;
     583:	8b 45 fc             	mov    -0x4(%rbp),%eax
     586:	83 c0 30             	add    $0x30,%eax
     589:	88 05 b2 7e 00 00    	mov    %al,0x7eb2(%rip)        # 8441 <name+0x1>
    unlink(name);
     58f:	48 c7 c7 40 84 00 00 	mov    $0x8440,%rdi
     596:	e8 65 39 00 00       	call   3f00 <unlink>
  for(i = 0; i < 52; i++){
     59b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     59f:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
     5a3:	7e de                	jle    583 <createtest+0x87>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     5a5:	8b 05 5d 5e 00 00    	mov    0x5e5d(%rip),%eax        # 6408 <stdout>
     5ab:	48 c7 c6 30 49 00 00 	mov    $0x4930,%rsi
     5b2:	89 c7                	mov    %eax,%edi
     5b4:	b8 00 00 00 00       	mov    $0x0,%eax
     5b9:	e8 b4 3a 00 00       	call   4072 <printf>
}
     5be:	90                   	nop
     5bf:	c9                   	leave
     5c0:	c3                   	ret

00000000000005c1 <dirtest>:

void dirtest(void)
{
     5c1:	f3 0f 1e fa          	endbr64
     5c5:	55                   	push   %rbp
     5c6:	48 89 e5             	mov    %rsp,%rbp
  printf(stdout, "mkdir test\n");
     5c9:	8b 05 39 5e 00 00    	mov    0x5e39(%rip),%eax        # 6408 <stdout>
     5cf:	48 c7 c6 56 49 00 00 	mov    $0x4956,%rsi
     5d6:	89 c7                	mov    %eax,%edi
     5d8:	b8 00 00 00 00       	mov    $0x0,%eax
     5dd:	e8 90 3a 00 00       	call   4072 <printf>

  if(mkdir("dir0") < 0){
     5e2:	48 c7 c7 62 49 00 00 	mov    $0x4962,%rdi
     5e9:	e8 2a 39 00 00       	call   3f18 <mkdir>
     5ee:	85 c0                	test   %eax,%eax
     5f0:	79 1e                	jns    610 <dirtest+0x4f>
    printf(stdout, "mkdir failed\n");
     5f2:	8b 05 10 5e 00 00    	mov    0x5e10(%rip),%eax        # 6408 <stdout>
     5f8:	48 c7 c6 67 49 00 00 	mov    $0x4967,%rsi
     5ff:	89 c7                	mov    %eax,%edi
     601:	b8 00 00 00 00       	mov    $0x0,%eax
     606:	e8 67 3a 00 00       	call   4072 <printf>
    exit();
     60b:	e8 a0 38 00 00       	call   3eb0 <exit>
  }

  if(chdir("dir0") < 0){
     610:	48 c7 c7 62 49 00 00 	mov    $0x4962,%rdi
     617:	e8 04 39 00 00       	call   3f20 <chdir>
     61c:	85 c0                	test   %eax,%eax
     61e:	79 1e                	jns    63e <dirtest+0x7d>
    printf(stdout, "chdir dir0 failed\n");
     620:	8b 05 e2 5d 00 00    	mov    0x5de2(%rip),%eax        # 6408 <stdout>
     626:	48 c7 c6 75 49 00 00 	mov    $0x4975,%rsi
     62d:	89 c7                	mov    %eax,%edi
     62f:	b8 00 00 00 00       	mov    $0x0,%eax
     634:	e8 39 3a 00 00       	call   4072 <printf>
    exit();
     639:	e8 72 38 00 00       	call   3eb0 <exit>
  }

  if(chdir("..") < 0){
     63e:	48 c7 c7 88 49 00 00 	mov    $0x4988,%rdi
     645:	e8 d6 38 00 00       	call   3f20 <chdir>
     64a:	85 c0                	test   %eax,%eax
     64c:	79 1e                	jns    66c <dirtest+0xab>
    printf(stdout, "chdir .. failed\n");
     64e:	8b 05 b4 5d 00 00    	mov    0x5db4(%rip),%eax        # 6408 <stdout>
     654:	48 c7 c6 8b 49 00 00 	mov    $0x498b,%rsi
     65b:	89 c7                	mov    %eax,%edi
     65d:	b8 00 00 00 00       	mov    $0x0,%eax
     662:	e8 0b 3a 00 00       	call   4072 <printf>
    exit();
     667:	e8 44 38 00 00       	call   3eb0 <exit>
  }

  if(unlink("dir0") < 0){
     66c:	48 c7 c7 62 49 00 00 	mov    $0x4962,%rdi
     673:	e8 88 38 00 00       	call   3f00 <unlink>
     678:	85 c0                	test   %eax,%eax
     67a:	79 1e                	jns    69a <dirtest+0xd9>
    printf(stdout, "unlink dir0 failed\n");
     67c:	8b 05 86 5d 00 00    	mov    0x5d86(%rip),%eax        # 6408 <stdout>
     682:	48 c7 c6 9c 49 00 00 	mov    $0x499c,%rsi
     689:	89 c7                	mov    %eax,%edi
     68b:	b8 00 00 00 00       	mov    $0x0,%eax
     690:	e8 dd 39 00 00       	call   4072 <printf>
    exit();
     695:	e8 16 38 00 00       	call   3eb0 <exit>
  }
  printf(stdout, "mkdir test\n");
     69a:	8b 05 68 5d 00 00    	mov    0x5d68(%rip),%eax        # 6408 <stdout>
     6a0:	48 c7 c6 56 49 00 00 	mov    $0x4956,%rsi
     6a7:	89 c7                	mov    %eax,%edi
     6a9:	b8 00 00 00 00       	mov    $0x0,%eax
     6ae:	e8 bf 39 00 00       	call   4072 <printf>
}
     6b3:	90                   	nop
     6b4:	5d                   	pop    %rbp
     6b5:	c3                   	ret

00000000000006b6 <exectest>:

void
exectest(void)
{
     6b6:	f3 0f 1e fa          	endbr64
     6ba:	55                   	push   %rbp
     6bb:	48 89 e5             	mov    %rsp,%rbp
  printf(stdout, "exec test\n");
     6be:	8b 05 44 5d 00 00    	mov    0x5d44(%rip),%eax        # 6408 <stdout>
     6c4:	48 c7 c6 b0 49 00 00 	mov    $0x49b0,%rsi
     6cb:	89 c7                	mov    %eax,%edi
     6cd:	b8 00 00 00 00       	mov    $0x0,%eax
     6d2:	e8 9b 39 00 00       	call   4072 <printf>
  if(exec("echo", echoargv) < 0){
     6d7:	48 c7 c6 e0 63 00 00 	mov    $0x63e0,%rsi
     6de:	48 c7 c7 88 46 00 00 	mov    $0x4688,%rdi
     6e5:	e8 fe 37 00 00       	call   3ee8 <exec>
     6ea:	85 c0                	test   %eax,%eax
     6ec:	79 1e                	jns    70c <exectest+0x56>
    printf(stdout, "exec echo failed\n");
     6ee:	8b 05 14 5d 00 00    	mov    0x5d14(%rip),%eax        # 6408 <stdout>
     6f4:	48 c7 c6 bb 49 00 00 	mov    $0x49bb,%rsi
     6fb:	89 c7                	mov    %eax,%edi
     6fd:	b8 00 00 00 00       	mov    $0x0,%eax
     702:	e8 6b 39 00 00       	call   4072 <printf>
    exit();
     707:	e8 a4 37 00 00       	call   3eb0 <exit>
  }
}
     70c:	90                   	nop
     70d:	5d                   	pop    %rbp
     70e:	c3                   	ret

000000000000070f <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     70f:	f3 0f 1e fa          	endbr64
     713:	55                   	push   %rbp
     714:	48 89 e5             	mov    %rsp,%rbp
     717:	48 83 ec 20          	sub    $0x20,%rsp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     71b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
     71f:	48 89 c7             	mov    %rax,%rdi
     722:	e8 99 37 00 00       	call   3ec0 <pipe>
     727:	85 c0                	test   %eax,%eax
     729:	74 1b                	je     746 <pipe1+0x37>
    printf(1, "pipe() failed\n");
     72b:	48 c7 c6 cd 49 00 00 	mov    $0x49cd,%rsi
     732:	bf 01 00 00 00       	mov    $0x1,%edi
     737:	b8 00 00 00 00       	mov    $0x0,%eax
     73c:	e8 31 39 00 00       	call   4072 <printf>
    exit();
     741:	e8 6a 37 00 00       	call   3eb0 <exit>
  }
  pid = fork();
     746:	e8 5d 37 00 00       	call   3ea8 <fork>
     74b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  seq = 0;
     74e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  if(pid == 0){
     755:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     759:	0f 85 86 00 00 00    	jne    7e5 <pipe1+0xd6>
    close(fds[0]);
     75f:	8b 45 e0             	mov    -0x20(%rbp),%eax
     762:	89 c7                	mov    %eax,%edi
     764:	e8 6f 37 00 00       	call   3ed8 <close>
    for(n = 0; n < 5; n++){
     769:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
     770:	eb 68                	jmp    7da <pipe1+0xcb>
      for(i = 0; i < 1033; i++)
     772:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     779:	eb 1a                	jmp    795 <pipe1+0x86>
        buf[i] = seq++;
     77b:	8b 45 fc             	mov    -0x4(%rbp),%eax
     77e:	8d 50 01             	lea    0x1(%rax),%edx
     781:	89 55 fc             	mov    %edx,-0x4(%rbp)
     784:	89 c2                	mov    %eax,%edx
     786:	8b 45 f8             	mov    -0x8(%rbp),%eax
     789:	48 98                	cltq
     78b:	88 90 40 64 00 00    	mov    %dl,0x6440(%rax)
      for(i = 0; i < 1033; i++)
     791:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     795:	81 7d f8 08 04 00 00 	cmpl   $0x408,-0x8(%rbp)
     79c:	7e dd                	jle    77b <pipe1+0x6c>
      if(write(fds[1], buf, 1033) != 1033){
     79e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     7a1:	ba 09 04 00 00       	mov    $0x409,%edx
     7a6:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     7ad:	89 c7                	mov    %eax,%edi
     7af:	e8 1c 37 00 00       	call   3ed0 <write>
     7b4:	3d 09 04 00 00       	cmp    $0x409,%eax
     7b9:	74 1b                	je     7d6 <pipe1+0xc7>
        printf(1, "pipe1 oops 1\n");
     7bb:	48 c7 c6 dc 49 00 00 	mov    $0x49dc,%rsi
     7c2:	bf 01 00 00 00       	mov    $0x1,%edi
     7c7:	b8 00 00 00 00       	mov    $0x0,%eax
     7cc:	e8 a1 38 00 00       	call   4072 <printf>
        exit();
     7d1:	e8 da 36 00 00       	call   3eb0 <exit>
    for(n = 0; n < 5; n++){
     7d6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
     7da:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
     7de:	7e 92                	jle    772 <pipe1+0x63>
      }
    }
    exit();
     7e0:	e8 cb 36 00 00       	call   3eb0 <exit>
  } else if(pid > 0){
     7e5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     7e9:	0f 8e f6 00 00 00    	jle    8e5 <pipe1+0x1d6>
    close(fds[1]);
     7ef:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     7f2:	89 c7                	mov    %eax,%edi
     7f4:	e8 df 36 00 00       	call   3ed8 <close>
    total = 0;
     7f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    cc = 1;
     800:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
     807:	eb 6b                	jmp    874 <pipe1+0x165>
      for(i = 0; i < n; i++){
     809:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     810:	eb 40                	jmp    852 <pipe1+0x143>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     812:	8b 45 f8             	mov    -0x8(%rbp),%eax
     815:	48 98                	cltq
     817:	0f b6 80 40 64 00 00 	movzbl 0x6440(%rax),%eax
     81e:	0f be c8             	movsbl %al,%ecx
     821:	8b 45 fc             	mov    -0x4(%rbp),%eax
     824:	8d 50 01             	lea    0x1(%rax),%edx
     827:	89 55 fc             	mov    %edx,-0x4(%rbp)
     82a:	31 c8                	xor    %ecx,%eax
     82c:	0f b6 c0             	movzbl %al,%eax
     82f:	85 c0                	test   %eax,%eax
     831:	74 1b                	je     84e <pipe1+0x13f>
          printf(1, "pipe1 oops 2\n");
     833:	48 c7 c6 ea 49 00 00 	mov    $0x49ea,%rsi
     83a:	bf 01 00 00 00       	mov    $0x1,%edi
     83f:	b8 00 00 00 00       	mov    $0x0,%eax
     844:	e8 29 38 00 00       	call   4072 <printf>
     849:	e9 b2 00 00 00       	jmp    900 <pipe1+0x1f1>
      for(i = 0; i < n; i++){
     84e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     852:	8b 45 f8             	mov    -0x8(%rbp),%eax
     855:	3b 45 f4             	cmp    -0xc(%rbp),%eax
     858:	7c b8                	jl     812 <pipe1+0x103>
          return;
        }
      }
      total += n;
     85a:	8b 45 f4             	mov    -0xc(%rbp),%eax
     85d:	01 45 ec             	add    %eax,-0x14(%rbp)
      cc = cc * 2;
     860:	d1 65 f0             	shll   $1,-0x10(%rbp)
      if(cc > sizeof(buf))
     863:	8b 45 f0             	mov    -0x10(%rbp),%eax
     866:	3d 00 20 00 00       	cmp    $0x2000,%eax
     86b:	76 07                	jbe    874 <pipe1+0x165>
        cc = sizeof(buf);
     86d:	c7 45 f0 00 20 00 00 	movl   $0x2000,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
     874:	8b 45 e0             	mov    -0x20(%rbp),%eax
     877:	8b 55 f0             	mov    -0x10(%rbp),%edx
     87a:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     881:	89 c7                	mov    %eax,%edi
     883:	e8 40 36 00 00       	call   3ec8 <read>
     888:	89 45 f4             	mov    %eax,-0xc(%rbp)
     88b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     88f:	0f 8f 74 ff ff ff    	jg     809 <pipe1+0xfa>
    }
    if(total != 5 * 1033){
     895:	81 7d ec 2d 14 00 00 	cmpl   $0x142d,-0x14(%rbp)
     89c:	74 20                	je     8be <pipe1+0x1af>
      printf(1, "pipe1 oops 3 total %d\n", total);
     89e:	8b 45 ec             	mov    -0x14(%rbp),%eax
     8a1:	89 c2                	mov    %eax,%edx
     8a3:	48 c7 c6 f8 49 00 00 	mov    $0x49f8,%rsi
     8aa:	bf 01 00 00 00       	mov    $0x1,%edi
     8af:	b8 00 00 00 00       	mov    $0x0,%eax
     8b4:	e8 b9 37 00 00       	call   4072 <printf>
      exit();
     8b9:	e8 f2 35 00 00       	call   3eb0 <exit>
    }
    close(fds[0]);
     8be:	8b 45 e0             	mov    -0x20(%rbp),%eax
     8c1:	89 c7                	mov    %eax,%edi
     8c3:	e8 10 36 00 00       	call   3ed8 <close>
    wait();
     8c8:	e8 eb 35 00 00       	call   3eb8 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     8cd:	48 c7 c6 1e 4a 00 00 	mov    $0x4a1e,%rsi
     8d4:	bf 01 00 00 00       	mov    $0x1,%edi
     8d9:	b8 00 00 00 00       	mov    $0x0,%eax
     8de:	e8 8f 37 00 00       	call   4072 <printf>
     8e3:	eb 1b                	jmp    900 <pipe1+0x1f1>
    printf(1, "fork() failed\n");
     8e5:	48 c7 c6 0f 4a 00 00 	mov    $0x4a0f,%rsi
     8ec:	bf 01 00 00 00       	mov    $0x1,%edi
     8f1:	b8 00 00 00 00       	mov    $0x0,%eax
     8f6:	e8 77 37 00 00       	call   4072 <printf>
    exit();
     8fb:	e8 b0 35 00 00       	call   3eb0 <exit>
}
     900:	c9                   	leave
     901:	c3                   	ret

0000000000000902 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     902:	f3 0f 1e fa          	endbr64
     906:	55                   	push   %rbp
     907:	48 89 e5             	mov    %rsp,%rbp
     90a:	48 83 ec 20          	sub    $0x20,%rsp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     90e:	48 c7 c6 28 4a 00 00 	mov    $0x4a28,%rsi
     915:	bf 01 00 00 00       	mov    $0x1,%edi
     91a:	b8 00 00 00 00       	mov    $0x0,%eax
     91f:	e8 4e 37 00 00       	call   4072 <printf>
  pid1 = fork();
     924:	e8 7f 35 00 00       	call   3ea8 <fork>
     929:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid1 == 0)
     92c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     930:	75 03                	jne    935 <preempt+0x33>
    for(;;)
     932:	90                   	nop
     933:	eb fd                	jmp    932 <preempt+0x30>
      ;

  pid2 = fork();
     935:	e8 6e 35 00 00       	call   3ea8 <fork>
     93a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid2 == 0)
     93d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     941:	75 03                	jne    946 <preempt+0x44>
    for(;;)
     943:	90                   	nop
     944:	eb fd                	jmp    943 <preempt+0x41>
      ;

  pipe(pfds);
     946:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
     94a:	48 89 c7             	mov    %rax,%rdi
     94d:	e8 6e 35 00 00       	call   3ec0 <pipe>
  pid3 = fork();
     952:	e8 51 35 00 00       	call   3ea8 <fork>
     957:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid3 == 0){
     95a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     95e:	75 48                	jne    9a8 <preempt+0xa6>
    close(pfds[0]);
     960:	8b 45 ec             	mov    -0x14(%rbp),%eax
     963:	89 c7                	mov    %eax,%edi
     965:	e8 6e 35 00 00       	call   3ed8 <close>
    if(write(pfds[1], "x", 1) != 1)
     96a:	8b 45 f0             	mov    -0x10(%rbp),%eax
     96d:	ba 01 00 00 00       	mov    $0x1,%edx
     972:	48 c7 c6 32 4a 00 00 	mov    $0x4a32,%rsi
     979:	89 c7                	mov    %eax,%edi
     97b:	e8 50 35 00 00       	call   3ed0 <write>
     980:	83 f8 01             	cmp    $0x1,%eax
     983:	74 16                	je     99b <preempt+0x99>
      printf(1, "preempt write error");
     985:	48 c7 c6 34 4a 00 00 	mov    $0x4a34,%rsi
     98c:	bf 01 00 00 00       	mov    $0x1,%edi
     991:	b8 00 00 00 00       	mov    $0x0,%eax
     996:	e8 d7 36 00 00       	call   4072 <printf>
    close(pfds[1]);
     99b:	8b 45 f0             	mov    -0x10(%rbp),%eax
     99e:	89 c7                	mov    %eax,%edi
     9a0:	e8 33 35 00 00       	call   3ed8 <close>
    for(;;)
     9a5:	90                   	nop
     9a6:	eb fd                	jmp    9a5 <preempt+0xa3>
      ;
  }

  close(pfds[1]);
     9a8:	8b 45 f0             	mov    -0x10(%rbp),%eax
     9ab:	89 c7                	mov    %eax,%edi
     9ad:	e8 26 35 00 00       	call   3ed8 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     9b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
     9b5:	ba 00 20 00 00       	mov    $0x2000,%edx
     9ba:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     9c1:	89 c7                	mov    %eax,%edi
     9c3:	e8 00 35 00 00       	call   3ec8 <read>
     9c8:	83 f8 01             	cmp    $0x1,%eax
     9cb:	74 18                	je     9e5 <preempt+0xe3>
    printf(1, "preempt read error");
     9cd:	48 c7 c6 48 4a 00 00 	mov    $0x4a48,%rsi
     9d4:	bf 01 00 00 00       	mov    $0x1,%edi
     9d9:	b8 00 00 00 00       	mov    $0x0,%eax
     9de:	e8 8f 36 00 00       	call   4072 <printf>
     9e3:	eb 79                	jmp    a5e <preempt+0x15c>
    return;
  }
  close(pfds[0]);
     9e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
     9e8:	89 c7                	mov    %eax,%edi
     9ea:	e8 e9 34 00 00       	call   3ed8 <close>
  printf(1, "kill... ");
     9ef:	48 c7 c6 5b 4a 00 00 	mov    $0x4a5b,%rsi
     9f6:	bf 01 00 00 00       	mov    $0x1,%edi
     9fb:	b8 00 00 00 00       	mov    $0x0,%eax
     a00:	e8 6d 36 00 00       	call   4072 <printf>
  kill(pid1);
     a05:	8b 45 fc             	mov    -0x4(%rbp),%eax
     a08:	89 c7                	mov    %eax,%edi
     a0a:	e8 d1 34 00 00       	call   3ee0 <kill>
  kill(pid2);
     a0f:	8b 45 f8             	mov    -0x8(%rbp),%eax
     a12:	89 c7                	mov    %eax,%edi
     a14:	e8 c7 34 00 00       	call   3ee0 <kill>
  kill(pid3);
     a19:	8b 45 f4             	mov    -0xc(%rbp),%eax
     a1c:	89 c7                	mov    %eax,%edi
     a1e:	e8 bd 34 00 00       	call   3ee0 <kill>
  printf(1, "wait... ");
     a23:	48 c7 c6 64 4a 00 00 	mov    $0x4a64,%rsi
     a2a:	bf 01 00 00 00       	mov    $0x1,%edi
     a2f:	b8 00 00 00 00       	mov    $0x0,%eax
     a34:	e8 39 36 00 00       	call   4072 <printf>
  wait();
     a39:	e8 7a 34 00 00       	call   3eb8 <wait>
  wait();
     a3e:	e8 75 34 00 00       	call   3eb8 <wait>
  wait();
     a43:	e8 70 34 00 00       	call   3eb8 <wait>
  printf(1, "preempt ok\n");
     a48:	48 c7 c6 6d 4a 00 00 	mov    $0x4a6d,%rsi
     a4f:	bf 01 00 00 00       	mov    $0x1,%edi
     a54:	b8 00 00 00 00       	mov    $0x0,%eax
     a59:	e8 14 36 00 00       	call   4072 <printf>
}
     a5e:	c9                   	leave
     a5f:	c3                   	ret

0000000000000a60 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a60:	f3 0f 1e fa          	endbr64
     a64:	55                   	push   %rbp
     a65:	48 89 e5             	mov    %rsp,%rbp
     a68:	48 83 ec 10          	sub    $0x10,%rsp
  int i, pid;

  for(i = 0; i < 100; i++){
     a6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     a73:	eb 57                	jmp    acc <exitwait+0x6c>
    pid = fork();
     a75:	e8 2e 34 00 00       	call   3ea8 <fork>
     a7a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0){
     a7d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     a81:	79 18                	jns    a9b <exitwait+0x3b>
      printf(1, "fork failed\n");
     a83:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
     a8a:	bf 01 00 00 00       	mov    $0x1,%edi
     a8f:	b8 00 00 00 00       	mov    $0x0,%eax
     a94:	e8 d9 35 00 00       	call   4072 <printf>
      return;
     a99:	eb 4d                	jmp    ae8 <exitwait+0x88>
    }
    if(pid){
     a9b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     a9f:	74 22                	je     ac3 <exitwait+0x63>
      if(wait() != pid){
     aa1:	e8 12 34 00 00       	call   3eb8 <wait>
     aa6:	39 45 f8             	cmp    %eax,-0x8(%rbp)
     aa9:	74 1d                	je     ac8 <exitwait+0x68>
        printf(1, "wait wrong pid\n");
     aab:	48 c7 c6 86 4a 00 00 	mov    $0x4a86,%rsi
     ab2:	bf 01 00 00 00       	mov    $0x1,%edi
     ab7:	b8 00 00 00 00       	mov    $0x0,%eax
     abc:	e8 b1 35 00 00       	call   4072 <printf>
        return;
     ac1:	eb 25                	jmp    ae8 <exitwait+0x88>
      }
    } else {
      exit();
     ac3:	e8 e8 33 00 00       	call   3eb0 <exit>
  for(i = 0; i < 100; i++){
     ac8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     acc:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
     ad0:	7e a3                	jle    a75 <exitwait+0x15>
    }
  }
  printf(1, "exitwait ok\n");
     ad2:	48 c7 c6 96 4a 00 00 	mov    $0x4a96,%rsi
     ad9:	bf 01 00 00 00       	mov    $0x1,%edi
     ade:	b8 00 00 00 00       	mov    $0x0,%eax
     ae3:	e8 8a 35 00 00       	call   4072 <printf>
}
     ae8:	c9                   	leave
     ae9:	c3                   	ret

0000000000000aea <mem>:

void
mem(void)
{
     aea:	f3 0f 1e fa          	endbr64
     aee:	55                   	push   %rbp
     aef:	48 89 e5             	mov    %rsp,%rbp
     af2:	48 83 ec 20          	sub    $0x20,%rsp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     af6:	48 c7 c6 a3 4a 00 00 	mov    $0x4aa3,%rsi
     afd:	bf 01 00 00 00       	mov    $0x1,%edi
     b02:	b8 00 00 00 00       	mov    $0x0,%eax
     b07:	e8 66 35 00 00       	call   4072 <printf>
  ppid = getpid();
     b0c:	e8 1f 34 00 00       	call   3f30 <getpid>
     b11:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((pid = fork()) == 0){
     b14:	e8 8f 33 00 00       	call   3ea8 <fork>
     b19:	89 45 f0             	mov    %eax,-0x10(%rbp)
     b1c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     b20:	0f 85 bb 00 00 00    	jne    be1 <mem+0xf7>
    m1 = 0;
     b26:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
     b2d:	00 
    while((m2 = malloc(10001)) != 0){
     b2e:	eb 13                	jmp    b43 <mem+0x59>
      *(char**)m2 = m1;
     b30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b34:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     b38:	48 89 10             	mov    %rdx,(%rax)
      m1 = m2;
     b3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while((m2 = malloc(10001)) != 0){
     b43:	bf 11 27 00 00       	mov    $0x2711,%edi
     b48:	e8 24 3a 00 00       	call   4571 <malloc>
     b4d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     b51:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     b56:	75 d8                	jne    b30 <mem+0x46>
    }
    while(m1){
     b58:	eb 1f                	jmp    b79 <mem+0x8f>
      m2 = *(char**)m1;
     b5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b5e:	48 8b 00             	mov    (%rax),%rax
     b61:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      free(m1);
     b65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b69:	48 89 c7             	mov    %rax,%rdi
     b6c:	e8 6d 38 00 00       	call   43de <free>
      m1 = m2;
     b71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while(m1){
     b79:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     b7e:	75 da                	jne    b5a <mem+0x70>
    }
    m1 = malloc(1024*20);
     b80:	bf 00 50 00 00       	mov    $0x5000,%edi
     b85:	e8 e7 39 00 00       	call   4571 <malloc>
     b8a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(m1 == 0){
     b8e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     b93:	75 25                	jne    bba <mem+0xd0>
      printf(1, "couldn't allocate mem?!!\n");
     b95:	48 c7 c6 ad 4a 00 00 	mov    $0x4aad,%rsi
     b9c:	bf 01 00 00 00       	mov    $0x1,%edi
     ba1:	b8 00 00 00 00       	mov    $0x0,%eax
     ba6:	e8 c7 34 00 00       	call   4072 <printf>
      kill(ppid);
     bab:	8b 45 f4             	mov    -0xc(%rbp),%eax
     bae:	89 c7                	mov    %eax,%edi
     bb0:	e8 2b 33 00 00       	call   3ee0 <kill>
      exit();
     bb5:	e8 f6 32 00 00       	call   3eb0 <exit>
    }
    free(m1);
     bba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bbe:	48 89 c7             	mov    %rax,%rdi
     bc1:	e8 18 38 00 00       	call   43de <free>
    printf(1, "mem ok\n");
     bc6:	48 c7 c6 c7 4a 00 00 	mov    $0x4ac7,%rsi
     bcd:	bf 01 00 00 00       	mov    $0x1,%edi
     bd2:	b8 00 00 00 00       	mov    $0x0,%eax
     bd7:	e8 96 34 00 00       	call   4072 <printf>
    exit();
     bdc:	e8 cf 32 00 00       	call   3eb0 <exit>
  } else {
    wait();
     be1:	e8 d2 32 00 00       	call   3eb8 <wait>
  }
}
     be6:	90                   	nop
     be7:	c9                   	leave
     be8:	c3                   	ret

0000000000000be9 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     be9:	f3 0f 1e fa          	endbr64
     bed:	55                   	push   %rbp
     bee:	48 89 e5             	mov    %rsp,%rbp
     bf1:	48 83 ec 30          	sub    $0x30,%rsp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     bf5:	48 c7 c6 cf 4a 00 00 	mov    $0x4acf,%rsi
     bfc:	bf 01 00 00 00       	mov    $0x1,%edi
     c01:	b8 00 00 00 00       	mov    $0x0,%eax
     c06:	e8 67 34 00 00       	call   4072 <printf>

  unlink("sharedfd");
     c0b:	48 c7 c7 de 4a 00 00 	mov    $0x4ade,%rdi
     c12:	e8 e9 32 00 00       	call   3f00 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     c17:	be 02 02 00 00       	mov    $0x202,%esi
     c1c:	48 c7 c7 de 4a 00 00 	mov    $0x4ade,%rdi
     c23:	e8 c8 32 00 00       	call   3ef0 <open>
     c28:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
     c2b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     c2f:	79 1b                	jns    c4c <sharedfd+0x63>
    printf(1, "fstests: cannot open sharedfd for writing");
     c31:	48 c7 c6 e8 4a 00 00 	mov    $0x4ae8,%rsi
     c38:	bf 01 00 00 00       	mov    $0x1,%edi
     c3d:	b8 00 00 00 00       	mov    $0x0,%eax
     c42:	e8 2b 34 00 00       	call   4072 <printf>
    return;
     c47:	e9 91 01 00 00       	jmp    ddd <sharedfd+0x1f4>
  }
  pid = fork();
     c4c:	e8 57 32 00 00       	call   3ea8 <fork>
     c51:	89 45 ec             	mov    %eax,-0x14(%rbp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     c54:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     c58:	75 07                	jne    c61 <sharedfd+0x78>
     c5a:	b9 63 00 00 00       	mov    $0x63,%ecx
     c5f:	eb 05                	jmp    c66 <sharedfd+0x7d>
     c61:	b9 70 00 00 00       	mov    $0x70,%ecx
     c66:	48 8d 45 de          	lea    -0x22(%rbp),%rax
     c6a:	ba 0a 00 00 00       	mov    $0xa,%edx
     c6f:	89 ce                	mov    %ecx,%esi
     c71:	48 89 c7             	mov    %rax,%rdi
     c74:	e8 2a 30 00 00       	call   3ca3 <memset>
  for(i = 0; i < 1000; i++){
     c79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     c80:	eb 37                	jmp    cb9 <sharedfd+0xd0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c82:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
     c86:	8b 45 f0             	mov    -0x10(%rbp),%eax
     c89:	ba 0a 00 00 00       	mov    $0xa,%edx
     c8e:	48 89 ce             	mov    %rcx,%rsi
     c91:	89 c7                	mov    %eax,%edi
     c93:	e8 38 32 00 00       	call   3ed0 <write>
     c98:	83 f8 0a             	cmp    $0xa,%eax
     c9b:	74 18                	je     cb5 <sharedfd+0xcc>
      printf(1, "fstests: write sharedfd failed\n");
     c9d:	48 c7 c6 18 4b 00 00 	mov    $0x4b18,%rsi
     ca4:	bf 01 00 00 00       	mov    $0x1,%edi
     ca9:	b8 00 00 00 00       	mov    $0x0,%eax
     cae:	e8 bf 33 00 00       	call   4072 <printf>
      break;
     cb3:	eb 0d                	jmp    cc2 <sharedfd+0xd9>
  for(i = 0; i < 1000; i++){
     cb5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     cb9:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
     cc0:	7e c0                	jle    c82 <sharedfd+0x99>
    }
  }
  if(pid == 0)
     cc2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     cc6:	75 05                	jne    ccd <sharedfd+0xe4>
    exit();
     cc8:	e8 e3 31 00 00       	call   3eb0 <exit>
  else
    wait();
     ccd:	e8 e6 31 00 00       	call   3eb8 <wait>
  close(fd);
     cd2:	8b 45 f0             	mov    -0x10(%rbp),%eax
     cd5:	89 c7                	mov    %eax,%edi
     cd7:	e8 fc 31 00 00       	call   3ed8 <close>
  fd = open("sharedfd", 0);
     cdc:	be 00 00 00 00       	mov    $0x0,%esi
     ce1:	48 c7 c7 de 4a 00 00 	mov    $0x4ade,%rdi
     ce8:	e8 03 32 00 00       	call   3ef0 <open>
     ced:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
     cf0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     cf4:	79 1b                	jns    d11 <sharedfd+0x128>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     cf6:	48 c7 c6 38 4b 00 00 	mov    $0x4b38,%rsi
     cfd:	bf 01 00 00 00       	mov    $0x1,%edi
     d02:	b8 00 00 00 00       	mov    $0x0,%eax
     d07:	e8 66 33 00 00       	call   4072 <printf>
    return;
     d0c:	e9 cc 00 00 00       	jmp    ddd <sharedfd+0x1f4>
  }
  nc = np = 0;
     d11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
     d18:	8b 45 f4             	mov    -0xc(%rbp),%eax
     d1b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     d1e:	eb 39                	jmp    d59 <sharedfd+0x170>
    for(i = 0; i < sizeof(buf); i++){
     d20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     d27:	eb 28                	jmp    d51 <sharedfd+0x168>
      if(buf[i] == 'c')
     d29:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d2c:	48 98                	cltq
     d2e:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
     d33:	3c 63                	cmp    $0x63,%al
     d35:	75 04                	jne    d3b <sharedfd+0x152>
        nc++;
     d37:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(buf[i] == 'p')
     d3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d3e:	48 98                	cltq
     d40:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
     d45:	3c 70                	cmp    $0x70,%al
     d47:	75 04                	jne    d4d <sharedfd+0x164>
        np++;
     d49:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    for(i = 0; i < sizeof(buf); i++){
     d4d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     d51:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d54:	83 f8 09             	cmp    $0x9,%eax
     d57:	76 d0                	jbe    d29 <sharedfd+0x140>
  while((n = read(fd, buf, sizeof(buf))) > 0){
     d59:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
     d5d:	8b 45 f0             	mov    -0x10(%rbp),%eax
     d60:	ba 0a 00 00 00       	mov    $0xa,%edx
     d65:	48 89 ce             	mov    %rcx,%rsi
     d68:	89 c7                	mov    %eax,%edi
     d6a:	e8 59 31 00 00       	call   3ec8 <read>
     d6f:	89 45 e8             	mov    %eax,-0x18(%rbp)
     d72:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     d76:	7f a8                	jg     d20 <sharedfd+0x137>
    }
  }
  close(fd);
     d78:	8b 45 f0             	mov    -0x10(%rbp),%eax
     d7b:	89 c7                	mov    %eax,%edi
     d7d:	e8 56 31 00 00       	call   3ed8 <close>
  unlink("sharedfd");
     d82:	48 c7 c7 de 4a 00 00 	mov    $0x4ade,%rdi
     d89:	e8 72 31 00 00       	call   3f00 <unlink>
  if(nc == 10000 && np == 10000){
     d8e:	81 7d f8 10 27 00 00 	cmpl   $0x2710,-0x8(%rbp)
     d95:	75 21                	jne    db8 <sharedfd+0x1cf>
     d97:	81 7d f4 10 27 00 00 	cmpl   $0x2710,-0xc(%rbp)
     d9e:	75 18                	jne    db8 <sharedfd+0x1cf>
    printf(1, "sharedfd ok\n");
     da0:	48 c7 c6 63 4b 00 00 	mov    $0x4b63,%rsi
     da7:	bf 01 00 00 00       	mov    $0x1,%edi
     dac:	b8 00 00 00 00       	mov    $0x0,%eax
     db1:	e8 bc 32 00 00       	call   4072 <printf>
     db6:	eb 25                	jmp    ddd <sharedfd+0x1f4>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     db8:	8b 55 f4             	mov    -0xc(%rbp),%edx
     dbb:	8b 45 f8             	mov    -0x8(%rbp),%eax
     dbe:	89 d1                	mov    %edx,%ecx
     dc0:	89 c2                	mov    %eax,%edx
     dc2:	48 c7 c6 70 4b 00 00 	mov    $0x4b70,%rsi
     dc9:	bf 01 00 00 00       	mov    $0x1,%edi
     dce:	b8 00 00 00 00       	mov    $0x0,%eax
     dd3:	e8 9a 32 00 00       	call   4072 <printf>
    exit();
     dd8:	e8 d3 30 00 00       	call   3eb0 <exit>
  }
}
     ddd:	c9                   	leave
     dde:	c3                   	ret

0000000000000ddf <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     ddf:	f3 0f 1e fa          	endbr64
     de3:	55                   	push   %rbp
     de4:	48 89 e5             	mov    %rsp,%rbp
     de7:	48 83 ec 20          	sub    $0x20,%rsp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     deb:	48 c7 c6 85 4b 00 00 	mov    $0x4b85,%rsi
     df2:	bf 01 00 00 00       	mov    $0x1,%edi
     df7:	b8 00 00 00 00       	mov    $0x0,%eax
     dfc:	e8 71 32 00 00       	call   4072 <printf>

  unlink("f1");
     e01:	48 c7 c7 94 4b 00 00 	mov    $0x4b94,%rdi
     e08:	e8 f3 30 00 00       	call   3f00 <unlink>
  unlink("f2");
     e0d:	48 c7 c7 97 4b 00 00 	mov    $0x4b97,%rdi
     e14:	e8 e7 30 00 00       	call   3f00 <unlink>

  pid = fork();
     e19:	e8 8a 30 00 00       	call   3ea8 <fork>
     e1e:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(pid < 0){
     e21:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     e25:	79 1b                	jns    e42 <twofiles+0x63>
    printf(1, "fork failed\n");
     e27:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
     e2e:	bf 01 00 00 00       	mov    $0x1,%edi
     e33:	b8 00 00 00 00       	mov    $0x0,%eax
     e38:	e8 35 32 00 00       	call   4072 <printf>
    exit();
     e3d:	e8 6e 30 00 00       	call   3eb0 <exit>
  }

  fname = pid ? "f1" : "f2";
     e42:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     e46:	74 09                	je     e51 <twofiles+0x72>
     e48:	48 c7 c0 94 4b 00 00 	mov    $0x4b94,%rax
     e4f:	eb 07                	jmp    e58 <twofiles+0x79>
     e51:	48 c7 c0 97 4b 00 00 	mov    $0x4b97,%rax
     e58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  fd = open(fname, O_CREATE | O_RDWR);
     e5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e60:	be 02 02 00 00       	mov    $0x202,%esi
     e65:	48 89 c7             	mov    %rax,%rdi
     e68:	e8 83 30 00 00       	call   3ef0 <open>
     e6d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(fd < 0){
     e70:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
     e74:	79 1b                	jns    e91 <twofiles+0xb2>
    printf(1, "create failed\n");
     e76:	48 c7 c6 9a 4b 00 00 	mov    $0x4b9a,%rsi
     e7d:	bf 01 00 00 00       	mov    $0x1,%edi
     e82:	b8 00 00 00 00       	mov    $0x0,%eax
     e87:	e8 e6 31 00 00       	call   4072 <printf>
    exit();
     e8c:	e8 1f 30 00 00       	call   3eb0 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     e91:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     e95:	74 07                	je     e9e <twofiles+0xbf>
     e97:	b8 70 00 00 00       	mov    $0x70,%eax
     e9c:	eb 05                	jmp    ea3 <twofiles+0xc4>
     e9e:	b8 63 00 00 00       	mov    $0x63,%eax
     ea3:	ba 00 02 00 00       	mov    $0x200,%edx
     ea8:	89 c6                	mov    %eax,%esi
     eaa:	48 c7 c7 40 64 00 00 	mov    $0x6440,%rdi
     eb1:	e8 ed 2d 00 00       	call   3ca3 <memset>
  for(i = 0; i < 12; i++){
     eb6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     ebd:	eb 46                	jmp    f05 <twofiles+0x126>
    if((n = write(fd, buf, 500)) != 500){
     ebf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     ec2:	ba f4 01 00 00       	mov    $0x1f4,%edx
     ec7:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     ece:	89 c7                	mov    %eax,%edi
     ed0:	e8 fb 2f 00 00       	call   3ed0 <write>
     ed5:	89 45 e0             	mov    %eax,-0x20(%rbp)
     ed8:	81 7d e0 f4 01 00 00 	cmpl   $0x1f4,-0x20(%rbp)
     edf:	74 20                	je     f01 <twofiles+0x122>
      printf(1, "write failed %d\n", n);
     ee1:	8b 45 e0             	mov    -0x20(%rbp),%eax
     ee4:	89 c2                	mov    %eax,%edx
     ee6:	48 c7 c6 a9 4b 00 00 	mov    $0x4ba9,%rsi
     eed:	bf 01 00 00 00       	mov    $0x1,%edi
     ef2:	b8 00 00 00 00       	mov    $0x0,%eax
     ef7:	e8 76 31 00 00       	call   4072 <printf>
      exit();
     efc:	e8 af 2f 00 00       	call   3eb0 <exit>
  for(i = 0; i < 12; i++){
     f01:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     f05:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
     f09:	7e b4                	jle    ebf <twofiles+0xe0>
    }
  }
  close(fd);
     f0b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     f0e:	89 c7                	mov    %eax,%edi
     f10:	e8 c3 2f 00 00       	call   3ed8 <close>
  if(pid)
     f15:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     f19:	74 11                	je     f2c <twofiles+0x14d>
    wait();
     f1b:	e8 98 2f 00 00       	call   3eb8 <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     f20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     f27:	e9 e5 00 00 00       	jmp    1011 <twofiles+0x232>
    exit();
     f2c:	e8 7f 2f 00 00       	call   3eb0 <exit>
    fd = open(i?"f1":"f2", 0);
     f31:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     f35:	74 09                	je     f40 <twofiles+0x161>
     f37:	48 c7 c0 94 4b 00 00 	mov    $0x4b94,%rax
     f3e:	eb 07                	jmp    f47 <twofiles+0x168>
     f40:	48 c7 c0 97 4b 00 00 	mov    $0x4b97,%rax
     f47:	be 00 00 00 00       	mov    $0x0,%esi
     f4c:	48 89 c7             	mov    %rax,%rdi
     f4f:	e8 9c 2f 00 00       	call   3ef0 <open>
     f54:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    total = 0;
     f57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f5e:	eb 5b                	jmp    fbb <twofiles+0x1dc>
      for(j = 0; j < n; j++){
     f60:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     f67:	eb 44                	jmp    fad <twofiles+0x1ce>
        if(buf[j] != (i?'p':'c')){
     f69:	8b 45 f8             	mov    -0x8(%rbp),%eax
     f6c:	48 98                	cltq
     f6e:	0f b6 80 40 64 00 00 	movzbl 0x6440(%rax),%eax
     f75:	0f be c0             	movsbl %al,%eax
     f78:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     f7c:	74 07                	je     f85 <twofiles+0x1a6>
     f7e:	ba 70 00 00 00       	mov    $0x70,%edx
     f83:	eb 05                	jmp    f8a <twofiles+0x1ab>
     f85:	ba 63 00 00 00       	mov    $0x63,%edx
     f8a:	39 c2                	cmp    %eax,%edx
     f8c:	74 1b                	je     fa9 <twofiles+0x1ca>
          printf(1, "wrong char\n");
     f8e:	48 c7 c6 ba 4b 00 00 	mov    $0x4bba,%rsi
     f95:	bf 01 00 00 00       	mov    $0x1,%edi
     f9a:	b8 00 00 00 00       	mov    $0x0,%eax
     f9f:	e8 ce 30 00 00       	call   4072 <printf>
          exit();
     fa4:	e8 07 2f 00 00       	call   3eb0 <exit>
      for(j = 0; j < n; j++){
     fa9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     fad:	8b 45 f8             	mov    -0x8(%rbp),%eax
     fb0:	3b 45 e0             	cmp    -0x20(%rbp),%eax
     fb3:	7c b4                	jl     f69 <twofiles+0x18a>
        }
      }
      total += n;
     fb5:	8b 45 e0             	mov    -0x20(%rbp),%eax
     fb8:	01 45 f4             	add    %eax,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fbb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     fbe:	ba 00 20 00 00       	mov    $0x2000,%edx
     fc3:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
     fca:	89 c7                	mov    %eax,%edi
     fcc:	e8 f7 2e 00 00       	call   3ec8 <read>
     fd1:	89 45 e0             	mov    %eax,-0x20(%rbp)
     fd4:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
     fd8:	7f 86                	jg     f60 <twofiles+0x181>
    }
    close(fd);
     fda:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     fdd:	89 c7                	mov    %eax,%edi
     fdf:	e8 f4 2e 00 00       	call   3ed8 <close>
    if(total != 12*500){
     fe4:	81 7d f4 70 17 00 00 	cmpl   $0x1770,-0xc(%rbp)
     feb:	74 20                	je     100d <twofiles+0x22e>
      printf(1, "wrong length %d\n", total);
     fed:	8b 45 f4             	mov    -0xc(%rbp),%eax
     ff0:	89 c2                	mov    %eax,%edx
     ff2:	48 c7 c6 c6 4b 00 00 	mov    $0x4bc6,%rsi
     ff9:	bf 01 00 00 00       	mov    $0x1,%edi
     ffe:	b8 00 00 00 00       	mov    $0x0,%eax
    1003:	e8 6a 30 00 00       	call   4072 <printf>
      exit();
    1008:	e8 a3 2e 00 00       	call   3eb0 <exit>
  for(i = 0; i < 2; i++){
    100d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1011:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
    1015:	0f 8e 16 ff ff ff    	jle    f31 <twofiles+0x152>
    }
  }

  unlink("f1");
    101b:	48 c7 c7 94 4b 00 00 	mov    $0x4b94,%rdi
    1022:	e8 d9 2e 00 00       	call   3f00 <unlink>
  unlink("f2");
    1027:	48 c7 c7 97 4b 00 00 	mov    $0x4b97,%rdi
    102e:	e8 cd 2e 00 00       	call   3f00 <unlink>

  printf(1, "twofiles ok\n");
    1033:	48 c7 c6 d7 4b 00 00 	mov    $0x4bd7,%rsi
    103a:	bf 01 00 00 00       	mov    $0x1,%edi
    103f:	b8 00 00 00 00       	mov    $0x0,%eax
    1044:	e8 29 30 00 00       	call   4072 <printf>
}
    1049:	90                   	nop
    104a:	c9                   	leave
    104b:	c3                   	ret

000000000000104c <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
    104c:	f3 0f 1e fa          	endbr64
    1050:	55                   	push   %rbp
    1051:	48 89 e5             	mov    %rsp,%rbp
    1054:	48 83 ec 30          	sub    $0x30,%rsp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
    1058:	48 c7 c6 e4 4b 00 00 	mov    $0x4be4,%rsi
    105f:	bf 01 00 00 00       	mov    $0x1,%edi
    1064:	b8 00 00 00 00       	mov    $0x0,%eax
    1069:	e8 04 30 00 00       	call   4072 <printf>
  pid = fork();
    106e:	e8 35 2e 00 00       	call   3ea8 <fork>
    1073:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid < 0){
    1076:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    107a:	79 1b                	jns    1097 <createdelete+0x4b>
    printf(1, "fork failed\n");
    107c:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
    1083:	bf 01 00 00 00       	mov    $0x1,%edi
    1088:	b8 00 00 00 00       	mov    $0x0,%eax
    108d:	e8 e0 2f 00 00       	call   4072 <printf>
    exit();
    1092:	e8 19 2e 00 00       	call   3eb0 <exit>
  }

  name[0] = pid ? 'p' : 'c';
    1097:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    109b:	74 07                	je     10a4 <createdelete+0x58>
    109d:	b8 70 00 00 00       	mov    $0x70,%eax
    10a2:	eb 05                	jmp    10a9 <createdelete+0x5d>
    10a4:	b8 63 00 00 00       	mov    $0x63,%eax
    10a9:	88 45 d0             	mov    %al,-0x30(%rbp)
  name[2] = '\0';
    10ac:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
  for(i = 0; i < N; i++){
    10b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10b7:	e9 99 00 00 00       	jmp    1155 <createdelete+0x109>
    name[1] = '0' + i;
    10bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10bf:	83 c0 30             	add    $0x30,%eax
    10c2:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, O_CREATE | O_RDWR);
    10c5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    10c9:	be 02 02 00 00       	mov    $0x202,%esi
    10ce:	48 89 c7             	mov    %rax,%rdi
    10d1:	e8 1a 2e 00 00       	call   3ef0 <open>
    10d6:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    10d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    10dd:	79 1b                	jns    10fa <createdelete+0xae>
      printf(1, "create failed\n");
    10df:	48 c7 c6 9a 4b 00 00 	mov    $0x4b9a,%rsi
    10e6:	bf 01 00 00 00       	mov    $0x1,%edi
    10eb:	b8 00 00 00 00       	mov    $0x0,%eax
    10f0:	e8 7d 2f 00 00       	call   4072 <printf>
      exit();
    10f5:	e8 b6 2d 00 00       	call   3eb0 <exit>
    }
    close(fd);
    10fa:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10fd:	89 c7                	mov    %eax,%edi
    10ff:	e8 d4 2d 00 00       	call   3ed8 <close>
    if(i > 0 && (i % 2 ) == 0){
    1104:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1108:	7e 47                	jle    1151 <createdelete+0x105>
    110a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    110d:	83 e0 01             	and    $0x1,%eax
    1110:	85 c0                	test   %eax,%eax
    1112:	75 3d                	jne    1151 <createdelete+0x105>
      name[1] = '0' + (i / 2);
    1114:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1117:	89 c2                	mov    %eax,%edx
    1119:	c1 ea 1f             	shr    $0x1f,%edx
    111c:	01 d0                	add    %edx,%eax
    111e:	d1 f8                	sar    $1,%eax
    1120:	83 c0 30             	add    $0x30,%eax
    1123:	88 45 d1             	mov    %al,-0x2f(%rbp)
      if(unlink(name) < 0){
    1126:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    112a:	48 89 c7             	mov    %rax,%rdi
    112d:	e8 ce 2d 00 00       	call   3f00 <unlink>
    1132:	85 c0                	test   %eax,%eax
    1134:	79 1b                	jns    1151 <createdelete+0x105>
        printf(1, "unlink failed\n");
    1136:	48 c7 c6 f7 4b 00 00 	mov    $0x4bf7,%rsi
    113d:	bf 01 00 00 00       	mov    $0x1,%edi
    1142:	b8 00 00 00 00       	mov    $0x0,%eax
    1147:	e8 26 2f 00 00       	call   4072 <printf>
        exit();
    114c:	e8 5f 2d 00 00       	call   3eb0 <exit>
  for(i = 0; i < N; i++){
    1151:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1155:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1159:	0f 8e 5d ff ff ff    	jle    10bc <createdelete+0x70>
      }
    }
  }

  if(pid==0)
    115f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1163:	75 05                	jne    116a <createdelete+0x11e>
    exit();
    1165:	e8 46 2d 00 00       	call   3eb0 <exit>
  else
    wait();
    116a:	e8 49 2d 00 00       	call   3eb8 <wait>

  for(i = 0; i < N; i++){
    116f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1176:	e9 36 01 00 00       	jmp    12b1 <createdelete+0x265>
    name[0] = 'p';
    117b:	c6 45 d0 70          	movb   $0x70,-0x30(%rbp)
    name[1] = '0' + i;
    117f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1182:	83 c0 30             	add    $0x30,%eax
    1185:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, 0);
    1188:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    118c:	be 00 00 00 00       	mov    $0x0,%esi
    1191:	48 89 c7             	mov    %rax,%rdi
    1194:	e8 57 2d 00 00       	call   3ef0 <open>
    1199:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((i == 0 || i >= N/2) && fd < 0){
    119c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11a0:	74 06                	je     11a8 <createdelete+0x15c>
    11a2:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    11a6:	7e 28                	jle    11d0 <createdelete+0x184>
    11a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    11ac:	79 22                	jns    11d0 <createdelete+0x184>
      printf(1, "oops createdelete %s didn't exist\n", name);
    11ae:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    11b2:	48 89 c2             	mov    %rax,%rdx
    11b5:	48 c7 c6 08 4c 00 00 	mov    $0x4c08,%rsi
    11bc:	bf 01 00 00 00       	mov    $0x1,%edi
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
    11c6:	e8 a7 2e 00 00       	call   4072 <printf>
      exit();
    11cb:	e8 e0 2c 00 00       	call   3eb0 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11d4:	7e 2e                	jle    1204 <createdelete+0x1b8>
    11d6:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    11da:	7f 28                	jg     1204 <createdelete+0x1b8>
    11dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    11e0:	78 22                	js     1204 <createdelete+0x1b8>
      printf(1, "oops createdelete %s did exist\n", name);
    11e2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    11e6:	48 89 c2             	mov    %rax,%rdx
    11e9:	48 c7 c6 30 4c 00 00 	mov    $0x4c30,%rsi
    11f0:	bf 01 00 00 00       	mov    $0x1,%edi
    11f5:	b8 00 00 00 00       	mov    $0x0,%eax
    11fa:	e8 73 2e 00 00       	call   4072 <printf>
      exit();
    11ff:	e8 ac 2c 00 00       	call   3eb0 <exit>
    }
    if(fd >= 0)
    1204:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1208:	78 0a                	js     1214 <createdelete+0x1c8>
      close(fd);
    120a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    120d:	89 c7                	mov    %eax,%edi
    120f:	e8 c4 2c 00 00       	call   3ed8 <close>

    name[0] = 'c';
    1214:	c6 45 d0 63          	movb   $0x63,-0x30(%rbp)
    name[1] = '0' + i;
    1218:	8b 45 fc             	mov    -0x4(%rbp),%eax
    121b:	83 c0 30             	add    $0x30,%eax
    121e:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, 0);
    1221:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    1225:	be 00 00 00 00       	mov    $0x0,%esi
    122a:	48 89 c7             	mov    %rax,%rdi
    122d:	e8 be 2c 00 00       	call   3ef0 <open>
    1232:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((i == 0 || i >= N/2) && fd < 0){
    1235:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1239:	74 06                	je     1241 <createdelete+0x1f5>
    123b:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    123f:	7e 28                	jle    1269 <createdelete+0x21d>
    1241:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1245:	79 22                	jns    1269 <createdelete+0x21d>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1247:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    124b:	48 89 c2             	mov    %rax,%rdx
    124e:	48 c7 c6 08 4c 00 00 	mov    $0x4c08,%rsi
    1255:	bf 01 00 00 00       	mov    $0x1,%edi
    125a:	b8 00 00 00 00       	mov    $0x0,%eax
    125f:	e8 0e 2e 00 00       	call   4072 <printf>
      exit();
    1264:	e8 47 2c 00 00       	call   3eb0 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1269:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    126d:	7e 2e                	jle    129d <createdelete+0x251>
    126f:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    1273:	7f 28                	jg     129d <createdelete+0x251>
    1275:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1279:	78 22                	js     129d <createdelete+0x251>
      printf(1, "oops createdelete %s did exist\n", name);
    127b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    127f:	48 89 c2             	mov    %rax,%rdx
    1282:	48 c7 c6 30 4c 00 00 	mov    $0x4c30,%rsi
    1289:	bf 01 00 00 00       	mov    $0x1,%edi
    128e:	b8 00 00 00 00       	mov    $0x0,%eax
    1293:	e8 da 2d 00 00       	call   4072 <printf>
      exit();
    1298:	e8 13 2c 00 00       	call   3eb0 <exit>
    }
    if(fd >= 0)
    129d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    12a1:	78 0a                	js     12ad <createdelete+0x261>
      close(fd);
    12a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    12a6:	89 c7                	mov    %eax,%edi
    12a8:	e8 2b 2c 00 00       	call   3ed8 <close>
  for(i = 0; i < N; i++){
    12ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12b1:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    12b5:	0f 8e c0 fe ff ff    	jle    117b <createdelete+0x12f>
  }

  for(i = 0; i < N; i++){
    12bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12c2:	eb 2d                	jmp    12f1 <createdelete+0x2a5>
    name[0] = 'p';
    12c4:	c6 45 d0 70          	movb   $0x70,-0x30(%rbp)
    name[1] = '0' + i;
    12c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12cb:	83 c0 30             	add    $0x30,%eax
    12ce:	88 45 d1             	mov    %al,-0x2f(%rbp)
    unlink(name);
    12d1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    12d5:	48 89 c7             	mov    %rax,%rdi
    12d8:	e8 23 2c 00 00       	call   3f00 <unlink>
    name[0] = 'c';
    12dd:	c6 45 d0 63          	movb   $0x63,-0x30(%rbp)
    unlink(name);
    12e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    12e5:	48 89 c7             	mov    %rax,%rdi
    12e8:	e8 13 2c 00 00       	call   3f00 <unlink>
  for(i = 0; i < N; i++){
    12ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12f1:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    12f5:	7e cd                	jle    12c4 <createdelete+0x278>
  }

  printf(1, "createdelete ok\n");
    12f7:	48 c7 c6 50 4c 00 00 	mov    $0x4c50,%rsi
    12fe:	bf 01 00 00 00       	mov    $0x1,%edi
    1303:	b8 00 00 00 00       	mov    $0x0,%eax
    1308:	e8 65 2d 00 00       	call   4072 <printf>
}
    130d:	90                   	nop
    130e:	c9                   	leave
    130f:	c3                   	ret

0000000000001310 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1310:	f3 0f 1e fa          	endbr64
    1314:	55                   	push   %rbp
    1315:	48 89 e5             	mov    %rsp,%rbp
    1318:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    131c:	48 c7 c6 61 4c 00 00 	mov    $0x4c61,%rsi
    1323:	bf 01 00 00 00       	mov    $0x1,%edi
    1328:	b8 00 00 00 00       	mov    $0x0,%eax
    132d:	e8 40 2d 00 00       	call   4072 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1332:	be 02 02 00 00       	mov    $0x202,%esi
    1337:	48 c7 c7 72 4c 00 00 	mov    $0x4c72,%rdi
    133e:	e8 ad 2b 00 00       	call   3ef0 <open>
    1343:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1346:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    134a:	79 1b                	jns    1367 <unlinkread+0x57>
    printf(1, "create unlinkread failed\n");
    134c:	48 c7 c6 7d 4c 00 00 	mov    $0x4c7d,%rsi
    1353:	bf 01 00 00 00       	mov    $0x1,%edi
    1358:	b8 00 00 00 00       	mov    $0x0,%eax
    135d:	e8 10 2d 00 00       	call   4072 <printf>
    exit();
    1362:	e8 49 2b 00 00       	call   3eb0 <exit>
  }
  write(fd, "hello", 5);
    1367:	8b 45 fc             	mov    -0x4(%rbp),%eax
    136a:	ba 05 00 00 00       	mov    $0x5,%edx
    136f:	48 c7 c6 97 4c 00 00 	mov    $0x4c97,%rsi
    1376:	89 c7                	mov    %eax,%edi
    1378:	e8 53 2b 00 00       	call   3ed0 <write>
  close(fd);
    137d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1380:	89 c7                	mov    %eax,%edi
    1382:	e8 51 2b 00 00       	call   3ed8 <close>

  fd = open("unlinkread", O_RDWR);
    1387:	be 02 00 00 00       	mov    $0x2,%esi
    138c:	48 c7 c7 72 4c 00 00 	mov    $0x4c72,%rdi
    1393:	e8 58 2b 00 00       	call   3ef0 <open>
    1398:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    139b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    139f:	79 1b                	jns    13bc <unlinkread+0xac>
    printf(1, "open unlinkread failed\n");
    13a1:	48 c7 c6 9d 4c 00 00 	mov    $0x4c9d,%rsi
    13a8:	bf 01 00 00 00       	mov    $0x1,%edi
    13ad:	b8 00 00 00 00       	mov    $0x0,%eax
    13b2:	e8 bb 2c 00 00       	call   4072 <printf>
    exit();
    13b7:	e8 f4 2a 00 00       	call   3eb0 <exit>
  }
  if(unlink("unlinkread") != 0){
    13bc:	48 c7 c7 72 4c 00 00 	mov    $0x4c72,%rdi
    13c3:	e8 38 2b 00 00       	call   3f00 <unlink>
    13c8:	85 c0                	test   %eax,%eax
    13ca:	74 1b                	je     13e7 <unlinkread+0xd7>
    printf(1, "unlink unlinkread failed\n");
    13cc:	48 c7 c6 b5 4c 00 00 	mov    $0x4cb5,%rsi
    13d3:	bf 01 00 00 00       	mov    $0x1,%edi
    13d8:	b8 00 00 00 00       	mov    $0x0,%eax
    13dd:	e8 90 2c 00 00       	call   4072 <printf>
    exit();
    13e2:	e8 c9 2a 00 00       	call   3eb0 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    13e7:	be 02 02 00 00       	mov    $0x202,%esi
    13ec:	48 c7 c7 72 4c 00 00 	mov    $0x4c72,%rdi
    13f3:	e8 f8 2a 00 00       	call   3ef0 <open>
    13f8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  write(fd1, "yyy", 3);
    13fb:	8b 45 f8             	mov    -0x8(%rbp),%eax
    13fe:	ba 03 00 00 00       	mov    $0x3,%edx
    1403:	48 c7 c6 cf 4c 00 00 	mov    $0x4ccf,%rsi
    140a:	89 c7                	mov    %eax,%edi
    140c:	e8 bf 2a 00 00       	call   3ed0 <write>
  close(fd1);
    1411:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1414:	89 c7                	mov    %eax,%edi
    1416:	e8 bd 2a 00 00       	call   3ed8 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    141b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    141e:	ba 00 20 00 00       	mov    $0x2000,%edx
    1423:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    142a:	89 c7                	mov    %eax,%edi
    142c:	e8 97 2a 00 00       	call   3ec8 <read>
    1431:	83 f8 05             	cmp    $0x5,%eax
    1434:	74 1b                	je     1451 <unlinkread+0x141>
    printf(1, "unlinkread read failed");
    1436:	48 c7 c6 d3 4c 00 00 	mov    $0x4cd3,%rsi
    143d:	bf 01 00 00 00       	mov    $0x1,%edi
    1442:	b8 00 00 00 00       	mov    $0x0,%eax
    1447:	e8 26 2c 00 00       	call   4072 <printf>
    exit();
    144c:	e8 5f 2a 00 00       	call   3eb0 <exit>
  }
  if(buf[0] != 'h'){
    1451:	0f b6 05 e8 4f 00 00 	movzbl 0x4fe8(%rip),%eax        # 6440 <buf>
    1458:	3c 68                	cmp    $0x68,%al
    145a:	74 1b                	je     1477 <unlinkread+0x167>
    printf(1, "unlinkread wrong data\n");
    145c:	48 c7 c6 ea 4c 00 00 	mov    $0x4cea,%rsi
    1463:	bf 01 00 00 00       	mov    $0x1,%edi
    1468:	b8 00 00 00 00       	mov    $0x0,%eax
    146d:	e8 00 2c 00 00       	call   4072 <printf>
    exit();
    1472:	e8 39 2a 00 00       	call   3eb0 <exit>
  }
  if(write(fd, buf, 10) != 10){
    1477:	8b 45 fc             	mov    -0x4(%rbp),%eax
    147a:	ba 0a 00 00 00       	mov    $0xa,%edx
    147f:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    1486:	89 c7                	mov    %eax,%edi
    1488:	e8 43 2a 00 00       	call   3ed0 <write>
    148d:	83 f8 0a             	cmp    $0xa,%eax
    1490:	74 1b                	je     14ad <unlinkread+0x19d>
    printf(1, "unlinkread write failed\n");
    1492:	48 c7 c6 01 4d 00 00 	mov    $0x4d01,%rsi
    1499:	bf 01 00 00 00       	mov    $0x1,%edi
    149e:	b8 00 00 00 00       	mov    $0x0,%eax
    14a3:	e8 ca 2b 00 00       	call   4072 <printf>
    exit();
    14a8:	e8 03 2a 00 00       	call   3eb0 <exit>
  }
  close(fd);
    14ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14b0:	89 c7                	mov    %eax,%edi
    14b2:	e8 21 2a 00 00       	call   3ed8 <close>
  unlink("unlinkread");
    14b7:	48 c7 c7 72 4c 00 00 	mov    $0x4c72,%rdi
    14be:	e8 3d 2a 00 00       	call   3f00 <unlink>
  printf(1, "unlinkread ok\n");
    14c3:	48 c7 c6 1a 4d 00 00 	mov    $0x4d1a,%rsi
    14ca:	bf 01 00 00 00       	mov    $0x1,%edi
    14cf:	b8 00 00 00 00       	mov    $0x0,%eax
    14d4:	e8 99 2b 00 00       	call   4072 <printf>
}
    14d9:	90                   	nop
    14da:	c9                   	leave
    14db:	c3                   	ret

00000000000014dc <linktest>:

void
linktest(void)
{
    14dc:	f3 0f 1e fa          	endbr64
    14e0:	55                   	push   %rbp
    14e1:	48 89 e5             	mov    %rsp,%rbp
    14e4:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "linktest\n");
    14e8:	48 c7 c6 29 4d 00 00 	mov    $0x4d29,%rsi
    14ef:	bf 01 00 00 00       	mov    $0x1,%edi
    14f4:	b8 00 00 00 00       	mov    $0x0,%eax
    14f9:	e8 74 2b 00 00       	call   4072 <printf>

  unlink("lf1");
    14fe:	48 c7 c7 33 4d 00 00 	mov    $0x4d33,%rdi
    1505:	e8 f6 29 00 00       	call   3f00 <unlink>
  unlink("lf2");
    150a:	48 c7 c7 37 4d 00 00 	mov    $0x4d37,%rdi
    1511:	e8 ea 29 00 00       	call   3f00 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1516:	be 02 02 00 00       	mov    $0x202,%esi
    151b:	48 c7 c7 33 4d 00 00 	mov    $0x4d33,%rdi
    1522:	e8 c9 29 00 00       	call   3ef0 <open>
    1527:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    152a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    152e:	79 1b                	jns    154b <linktest+0x6f>
    printf(1, "create lf1 failed\n");
    1530:	48 c7 c6 3b 4d 00 00 	mov    $0x4d3b,%rsi
    1537:	bf 01 00 00 00       	mov    $0x1,%edi
    153c:	b8 00 00 00 00       	mov    $0x0,%eax
    1541:	e8 2c 2b 00 00       	call   4072 <printf>
    exit();
    1546:	e8 65 29 00 00       	call   3eb0 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    154b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    154e:	ba 05 00 00 00       	mov    $0x5,%edx
    1553:	48 c7 c6 97 4c 00 00 	mov    $0x4c97,%rsi
    155a:	89 c7                	mov    %eax,%edi
    155c:	e8 6f 29 00 00       	call   3ed0 <write>
    1561:	83 f8 05             	cmp    $0x5,%eax
    1564:	74 1b                	je     1581 <linktest+0xa5>
    printf(1, "write lf1 failed\n");
    1566:	48 c7 c6 4e 4d 00 00 	mov    $0x4d4e,%rsi
    156d:	bf 01 00 00 00       	mov    $0x1,%edi
    1572:	b8 00 00 00 00       	mov    $0x0,%eax
    1577:	e8 f6 2a 00 00       	call   4072 <printf>
    exit();
    157c:	e8 2f 29 00 00       	call   3eb0 <exit>
  }
  close(fd);
    1581:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1584:	89 c7                	mov    %eax,%edi
    1586:	e8 4d 29 00 00       	call   3ed8 <close>

  if(link("lf1", "lf2") < 0){
    158b:	48 c7 c6 37 4d 00 00 	mov    $0x4d37,%rsi
    1592:	48 c7 c7 33 4d 00 00 	mov    $0x4d33,%rdi
    1599:	e8 72 29 00 00       	call   3f10 <link>
    159e:	85 c0                	test   %eax,%eax
    15a0:	79 1b                	jns    15bd <linktest+0xe1>
    printf(1, "link lf1 lf2 failed\n");
    15a2:	48 c7 c6 60 4d 00 00 	mov    $0x4d60,%rsi
    15a9:	bf 01 00 00 00       	mov    $0x1,%edi
    15ae:	b8 00 00 00 00       	mov    $0x0,%eax
    15b3:	e8 ba 2a 00 00       	call   4072 <printf>
    exit();
    15b8:	e8 f3 28 00 00       	call   3eb0 <exit>
  }
  unlink("lf1");
    15bd:	48 c7 c7 33 4d 00 00 	mov    $0x4d33,%rdi
    15c4:	e8 37 29 00 00       	call   3f00 <unlink>

  if(open("lf1", 0) >= 0){
    15c9:	be 00 00 00 00       	mov    $0x0,%esi
    15ce:	48 c7 c7 33 4d 00 00 	mov    $0x4d33,%rdi
    15d5:	e8 16 29 00 00       	call   3ef0 <open>
    15da:	85 c0                	test   %eax,%eax
    15dc:	78 1b                	js     15f9 <linktest+0x11d>
    printf(1, "unlinked lf1 but it is still there!\n");
    15de:	48 c7 c6 78 4d 00 00 	mov    $0x4d78,%rsi
    15e5:	bf 01 00 00 00       	mov    $0x1,%edi
    15ea:	b8 00 00 00 00       	mov    $0x0,%eax
    15ef:	e8 7e 2a 00 00       	call   4072 <printf>
    exit();
    15f4:	e8 b7 28 00 00       	call   3eb0 <exit>
  }

  fd = open("lf2", 0);
    15f9:	be 00 00 00 00       	mov    $0x0,%esi
    15fe:	48 c7 c7 37 4d 00 00 	mov    $0x4d37,%rdi
    1605:	e8 e6 28 00 00       	call   3ef0 <open>
    160a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    160d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1611:	79 1b                	jns    162e <linktest+0x152>
    printf(1, "open lf2 failed\n");
    1613:	48 c7 c6 9d 4d 00 00 	mov    $0x4d9d,%rsi
    161a:	bf 01 00 00 00       	mov    $0x1,%edi
    161f:	b8 00 00 00 00       	mov    $0x0,%eax
    1624:	e8 49 2a 00 00       	call   4072 <printf>
    exit();
    1629:	e8 82 28 00 00       	call   3eb0 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    162e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1631:	ba 00 20 00 00       	mov    $0x2000,%edx
    1636:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    163d:	89 c7                	mov    %eax,%edi
    163f:	e8 84 28 00 00       	call   3ec8 <read>
    1644:	83 f8 05             	cmp    $0x5,%eax
    1647:	74 1b                	je     1664 <linktest+0x188>
    printf(1, "read lf2 failed\n");
    1649:	48 c7 c6 ae 4d 00 00 	mov    $0x4dae,%rsi
    1650:	bf 01 00 00 00       	mov    $0x1,%edi
    1655:	b8 00 00 00 00       	mov    $0x0,%eax
    165a:	e8 13 2a 00 00       	call   4072 <printf>
    exit();
    165f:	e8 4c 28 00 00       	call   3eb0 <exit>
  }
  close(fd);
    1664:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1667:	89 c7                	mov    %eax,%edi
    1669:	e8 6a 28 00 00       	call   3ed8 <close>

  if(link("lf2", "lf2") >= 0){
    166e:	48 c7 c6 37 4d 00 00 	mov    $0x4d37,%rsi
    1675:	48 c7 c7 37 4d 00 00 	mov    $0x4d37,%rdi
    167c:	e8 8f 28 00 00       	call   3f10 <link>
    1681:	85 c0                	test   %eax,%eax
    1683:	78 1b                	js     16a0 <linktest+0x1c4>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1685:	48 c7 c6 bf 4d 00 00 	mov    $0x4dbf,%rsi
    168c:	bf 01 00 00 00       	mov    $0x1,%edi
    1691:	b8 00 00 00 00       	mov    $0x0,%eax
    1696:	e8 d7 29 00 00       	call   4072 <printf>
    exit();
    169b:	e8 10 28 00 00       	call   3eb0 <exit>
  }

  unlink("lf2");
    16a0:	48 c7 c7 37 4d 00 00 	mov    $0x4d37,%rdi
    16a7:	e8 54 28 00 00       	call   3f00 <unlink>
  if(link("lf2", "lf1") >= 0){
    16ac:	48 c7 c6 33 4d 00 00 	mov    $0x4d33,%rsi
    16b3:	48 c7 c7 37 4d 00 00 	mov    $0x4d37,%rdi
    16ba:	e8 51 28 00 00       	call   3f10 <link>
    16bf:	85 c0                	test   %eax,%eax
    16c1:	78 1b                	js     16de <linktest+0x202>
    printf(1, "link non-existant succeeded! oops\n");
    16c3:	48 c7 c6 e0 4d 00 00 	mov    $0x4de0,%rsi
    16ca:	bf 01 00 00 00       	mov    $0x1,%edi
    16cf:	b8 00 00 00 00       	mov    $0x0,%eax
    16d4:	e8 99 29 00 00       	call   4072 <printf>
    exit();
    16d9:	e8 d2 27 00 00       	call   3eb0 <exit>
  }

  if(link(".", "lf1") >= 0){
    16de:	48 c7 c6 33 4d 00 00 	mov    $0x4d33,%rsi
    16e5:	48 c7 c7 03 4e 00 00 	mov    $0x4e03,%rdi
    16ec:	e8 1f 28 00 00       	call   3f10 <link>
    16f1:	85 c0                	test   %eax,%eax
    16f3:	78 1b                	js     1710 <linktest+0x234>
    printf(1, "link . lf1 succeeded! oops\n");
    16f5:	48 c7 c6 05 4e 00 00 	mov    $0x4e05,%rsi
    16fc:	bf 01 00 00 00       	mov    $0x1,%edi
    1701:	b8 00 00 00 00       	mov    $0x0,%eax
    1706:	e8 67 29 00 00       	call   4072 <printf>
    exit();
    170b:	e8 a0 27 00 00       	call   3eb0 <exit>
  }

  printf(1, "linktest ok\n");
    1710:	48 c7 c6 21 4e 00 00 	mov    $0x4e21,%rsi
    1717:	bf 01 00 00 00       	mov    $0x1,%edi
    171c:	b8 00 00 00 00       	mov    $0x0,%eax
    1721:	e8 4c 29 00 00       	call   4072 <printf>
}
    1726:	90                   	nop
    1727:	c9                   	leave
    1728:	c3                   	ret

0000000000001729 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1729:	f3 0f 1e fa          	endbr64
    172d:	55                   	push   %rbp
    172e:	48 89 e5             	mov    %rsp,%rbp
    1731:	48 83 ec 50          	sub    $0x50,%rsp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1735:	48 c7 c6 2e 4e 00 00 	mov    $0x4e2e,%rsi
    173c:	bf 01 00 00 00       	mov    $0x1,%edi
    1741:	b8 00 00 00 00       	mov    $0x0,%eax
    1746:	e8 27 29 00 00       	call   4072 <printf>
  file[0] = 'C';
    174b:	c6 45 ed 43          	movb   $0x43,-0x13(%rbp)
  file[2] = '\0';
    174f:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  for(i = 0; i < 40; i++){
    1753:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    175a:	e9 06 01 00 00       	jmp    1865 <concreate+0x13c>
    file[1] = '0' + i;
    175f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1762:	83 c0 30             	add    $0x30,%eax
    1765:	88 45 ee             	mov    %al,-0x12(%rbp)
    unlink(file);
    1768:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    176c:	48 89 c7             	mov    %rax,%rdi
    176f:	e8 8c 27 00 00       	call   3f00 <unlink>
    pid = fork();
    1774:	e8 2f 27 00 00       	call   3ea8 <fork>
    1779:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid && (i % 3) == 1){
    177c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1780:	74 42                	je     17c4 <concreate+0x9b>
    1782:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    1785:	48 63 c1             	movslq %ecx,%rax
    1788:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    178f:	48 c1 e8 20          	shr    $0x20,%rax
    1793:	48 89 c2             	mov    %rax,%rdx
    1796:	89 c8                	mov    %ecx,%eax
    1798:	c1 f8 1f             	sar    $0x1f,%eax
    179b:	29 c2                	sub    %eax,%edx
    179d:	89 d0                	mov    %edx,%eax
    179f:	01 c0                	add    %eax,%eax
    17a1:	01 d0                	add    %edx,%eax
    17a3:	29 c1                	sub    %eax,%ecx
    17a5:	89 ca                	mov    %ecx,%edx
    17a7:	83 fa 01             	cmp    $0x1,%edx
    17aa:	75 18                	jne    17c4 <concreate+0x9b>
      link("C0", file);
    17ac:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    17b0:	48 89 c6             	mov    %rax,%rsi
    17b3:	48 c7 c7 3e 4e 00 00 	mov    $0x4e3e,%rdi
    17ba:	e8 51 27 00 00       	call   3f10 <link>
    17bf:	e9 8d 00 00 00       	jmp    1851 <concreate+0x128>
    } else if(pid == 0 && (i % 5) == 1){
    17c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    17c8:	75 41                	jne    180b <concreate+0xe2>
    17ca:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    17cd:	48 63 c1             	movslq %ecx,%rax
    17d0:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    17d7:	48 c1 e8 20          	shr    $0x20,%rax
    17db:	89 c2                	mov    %eax,%edx
    17dd:	d1 fa                	sar    $1,%edx
    17df:	89 c8                	mov    %ecx,%eax
    17e1:	c1 f8 1f             	sar    $0x1f,%eax
    17e4:	29 c2                	sub    %eax,%edx
    17e6:	89 d0                	mov    %edx,%eax
    17e8:	c1 e0 02             	shl    $0x2,%eax
    17eb:	01 d0                	add    %edx,%eax
    17ed:	29 c1                	sub    %eax,%ecx
    17ef:	89 ca                	mov    %ecx,%edx
    17f1:	83 fa 01             	cmp    $0x1,%edx
    17f4:	75 15                	jne    180b <concreate+0xe2>
      link("C0", file);
    17f6:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    17fa:	48 89 c6             	mov    %rax,%rsi
    17fd:	48 c7 c7 3e 4e 00 00 	mov    $0x4e3e,%rdi
    1804:	e8 07 27 00 00       	call   3f10 <link>
    1809:	eb 46                	jmp    1851 <concreate+0x128>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    180b:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    180f:	be 02 02 00 00       	mov    $0x202,%esi
    1814:	48 89 c7             	mov    %rax,%rdi
    1817:	e8 d4 26 00 00       	call   3ef0 <open>
    181c:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if(fd < 0){
    181f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1823:	79 22                	jns    1847 <concreate+0x11e>
        printf(1, "concreate create %s failed\n", file);
    1825:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1829:	48 89 c2             	mov    %rax,%rdx
    182c:	48 c7 c6 41 4e 00 00 	mov    $0x4e41,%rsi
    1833:	bf 01 00 00 00       	mov    $0x1,%edi
    1838:	b8 00 00 00 00       	mov    $0x0,%eax
    183d:	e8 30 28 00 00       	call   4072 <printf>
        exit();
    1842:	e8 69 26 00 00       	call   3eb0 <exit>
      }
      close(fd);
    1847:	8b 45 f4             	mov    -0xc(%rbp),%eax
    184a:	89 c7                	mov    %eax,%edi
    184c:	e8 87 26 00 00       	call   3ed8 <close>
    }
    if(pid == 0)
    1851:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1855:	75 05                	jne    185c <concreate+0x133>
      exit();
    1857:	e8 54 26 00 00       	call   3eb0 <exit>
    else
      wait();
    185c:	e8 57 26 00 00       	call   3eb8 <wait>
  for(i = 0; i < 40; i++){
    1861:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1865:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    1869:	0f 8e f0 fe ff ff    	jle    175f <concreate+0x36>
  }

  memset(fa, 0, sizeof(fa));
    186f:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    1873:	ba 28 00 00 00       	mov    $0x28,%edx
    1878:	be 00 00 00 00       	mov    $0x0,%esi
    187d:	48 89 c7             	mov    %rax,%rdi
    1880:	e8 1e 24 00 00       	call   3ca3 <memset>
  fd = open(".", 0);
    1885:	be 00 00 00 00       	mov    $0x0,%esi
    188a:	48 c7 c7 03 4e 00 00 	mov    $0x4e03,%rdi
    1891:	e8 5a 26 00 00       	call   3ef0 <open>
    1896:	89 45 f4             	mov    %eax,-0xc(%rbp)
  n = 0;
    1899:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  while(read(fd, &de, sizeof(de)) > 0){
    18a0:	e9 ab 00 00 00       	jmp    1950 <concreate+0x227>
    if(de.inum == 0)
    18a5:	0f b7 45 b0          	movzwl -0x50(%rbp),%eax
    18a9:	66 85 c0             	test   %ax,%ax
    18ac:	0f 84 9d 00 00 00    	je     194f <concreate+0x226>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    18b2:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    18b6:	3c 43                	cmp    $0x43,%al
    18b8:	0f 85 92 00 00 00    	jne    1950 <concreate+0x227>
    18be:	0f b6 45 b4          	movzbl -0x4c(%rbp),%eax
    18c2:	84 c0                	test   %al,%al
    18c4:	0f 85 86 00 00 00    	jne    1950 <concreate+0x227>
      i = de.name[1] - '0';
    18ca:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
    18ce:	0f be c0             	movsbl %al,%eax
    18d1:	83 e8 30             	sub    $0x30,%eax
    18d4:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(i < 0 || i >= sizeof(fa)){
    18d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    18db:	78 08                	js     18e5 <concreate+0x1bc>
    18dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18e0:	83 f8 27             	cmp    $0x27,%eax
    18e3:	76 26                	jbe    190b <concreate+0x1e2>
        printf(1, "concreate weird file %s\n", de.name);
    18e5:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    18e9:	48 83 c0 02          	add    $0x2,%rax
    18ed:	48 89 c2             	mov    %rax,%rdx
    18f0:	48 c7 c6 5d 4e 00 00 	mov    $0x4e5d,%rsi
    18f7:	bf 01 00 00 00       	mov    $0x1,%edi
    18fc:	b8 00 00 00 00       	mov    $0x0,%eax
    1901:	e8 6c 27 00 00       	call   4072 <printf>
        exit();
    1906:	e8 a5 25 00 00       	call   3eb0 <exit>
      }
      if(fa[i]){
    190b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    190e:	48 98                	cltq
    1910:	0f b6 44 05 c0       	movzbl -0x40(%rbp,%rax,1),%eax
    1915:	84 c0                	test   %al,%al
    1917:	74 26                	je     193f <concreate+0x216>
        printf(1, "concreate duplicate file %s\n", de.name);
    1919:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    191d:	48 83 c0 02          	add    $0x2,%rax
    1921:	48 89 c2             	mov    %rax,%rdx
    1924:	48 c7 c6 76 4e 00 00 	mov    $0x4e76,%rsi
    192b:	bf 01 00 00 00       	mov    $0x1,%edi
    1930:	b8 00 00 00 00       	mov    $0x0,%eax
    1935:	e8 38 27 00 00       	call   4072 <printf>
        exit();
    193a:	e8 71 25 00 00       	call   3eb0 <exit>
      }
      fa[i] = 1;
    193f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1942:	48 98                	cltq
    1944:	c6 44 05 c0 01       	movb   $0x1,-0x40(%rbp,%rax,1)
      n++;
    1949:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    194d:	eb 01                	jmp    1950 <concreate+0x227>
      continue;
    194f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1950:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    1954:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1957:	ba 10 00 00 00       	mov    $0x10,%edx
    195c:	48 89 ce             	mov    %rcx,%rsi
    195f:	89 c7                	mov    %eax,%edi
    1961:	e8 62 25 00 00       	call   3ec8 <read>
    1966:	85 c0                	test   %eax,%eax
    1968:	0f 8f 37 ff ff ff    	jg     18a5 <concreate+0x17c>
    }
  }
  close(fd);
    196e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1971:	89 c7                	mov    %eax,%edi
    1973:	e8 60 25 00 00       	call   3ed8 <close>

  if(n != 40){
    1978:	83 7d f8 28          	cmpl   $0x28,-0x8(%rbp)
    197c:	74 1b                	je     1999 <concreate+0x270>
    printf(1, "concreate not enough files in directory listing\n");
    197e:	48 c7 c6 98 4e 00 00 	mov    $0x4e98,%rsi
    1985:	bf 01 00 00 00       	mov    $0x1,%edi
    198a:	b8 00 00 00 00       	mov    $0x0,%eax
    198f:	e8 de 26 00 00       	call   4072 <printf>
    exit();
    1994:	e8 17 25 00 00       	call   3eb0 <exit>
  }

  for(i = 0; i < 40; i++){
    1999:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    19a0:	e9 37 01 00 00       	jmp    1adc <concreate+0x3b3>
    file[1] = '0' + i;
    19a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    19a8:	83 c0 30             	add    $0x30,%eax
    19ab:	88 45 ee             	mov    %al,-0x12(%rbp)
    pid = fork();
    19ae:	e8 f5 24 00 00       	call   3ea8 <fork>
    19b3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    19b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    19ba:	79 1b                	jns    19d7 <concreate+0x2ae>
      printf(1, "fork failed\n");
    19bc:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
    19c3:	bf 01 00 00 00       	mov    $0x1,%edi
    19c8:	b8 00 00 00 00       	mov    $0x0,%eax
    19cd:	e8 a0 26 00 00       	call   4072 <printf>
      exit();
    19d2:	e8 d9 24 00 00       	call   3eb0 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    19d7:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    19da:	48 63 c1             	movslq %ecx,%rax
    19dd:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    19e4:	48 c1 e8 20          	shr    $0x20,%rax
    19e8:	48 89 c2             	mov    %rax,%rdx
    19eb:	89 c8                	mov    %ecx,%eax
    19ed:	c1 f8 1f             	sar    $0x1f,%eax
    19f0:	29 c2                	sub    %eax,%edx
    19f2:	89 d0                	mov    %edx,%eax
    19f4:	01 c0                	add    %eax,%eax
    19f6:	01 d0                	add    %edx,%eax
    19f8:	29 c1                	sub    %eax,%ecx
    19fa:	89 ca                	mov    %ecx,%edx
    19fc:	85 d2                	test   %edx,%edx
    19fe:	75 06                	jne    1a06 <concreate+0x2dd>
    1a00:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1a04:	74 30                	je     1a36 <concreate+0x30d>
       ((i % 3) == 1 && pid != 0)){
    1a06:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    1a09:	48 63 c1             	movslq %ecx,%rax
    1a0c:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    1a13:	48 c1 e8 20          	shr    $0x20,%rax
    1a17:	48 89 c2             	mov    %rax,%rdx
    1a1a:	89 c8                	mov    %ecx,%eax
    1a1c:	c1 f8 1f             	sar    $0x1f,%eax
    1a1f:	29 c2                	sub    %eax,%edx
    1a21:	89 d0                	mov    %edx,%eax
    1a23:	01 c0                	add    %eax,%eax
    1a25:	01 d0                	add    %edx,%eax
    1a27:	29 c1                	sub    %eax,%ecx
    1a29:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    1a2b:	83 fa 01             	cmp    $0x1,%edx
    1a2e:	75 68                	jne    1a98 <concreate+0x36f>
       ((i % 3) == 1 && pid != 0)){
    1a30:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1a34:	74 62                	je     1a98 <concreate+0x36f>
      close(open(file, 0));
    1a36:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a3a:	be 00 00 00 00       	mov    $0x0,%esi
    1a3f:	48 89 c7             	mov    %rax,%rdi
    1a42:	e8 a9 24 00 00       	call   3ef0 <open>
    1a47:	89 c7                	mov    %eax,%edi
    1a49:	e8 8a 24 00 00       	call   3ed8 <close>
      close(open(file, 0));
    1a4e:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a52:	be 00 00 00 00       	mov    $0x0,%esi
    1a57:	48 89 c7             	mov    %rax,%rdi
    1a5a:	e8 91 24 00 00       	call   3ef0 <open>
    1a5f:	89 c7                	mov    %eax,%edi
    1a61:	e8 72 24 00 00       	call   3ed8 <close>
      close(open(file, 0));
    1a66:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a6a:	be 00 00 00 00       	mov    $0x0,%esi
    1a6f:	48 89 c7             	mov    %rax,%rdi
    1a72:	e8 79 24 00 00       	call   3ef0 <open>
    1a77:	89 c7                	mov    %eax,%edi
    1a79:	e8 5a 24 00 00       	call   3ed8 <close>
      close(open(file, 0));
    1a7e:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a82:	be 00 00 00 00       	mov    $0x0,%esi
    1a87:	48 89 c7             	mov    %rax,%rdi
    1a8a:	e8 61 24 00 00       	call   3ef0 <open>
    1a8f:	89 c7                	mov    %eax,%edi
    1a91:	e8 42 24 00 00       	call   3ed8 <close>
    1a96:	eb 30                	jmp    1ac8 <concreate+0x39f>
    } else {
      unlink(file);
    1a98:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a9c:	48 89 c7             	mov    %rax,%rdi
    1a9f:	e8 5c 24 00 00       	call   3f00 <unlink>
      unlink(file);
    1aa4:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1aa8:	48 89 c7             	mov    %rax,%rdi
    1aab:	e8 50 24 00 00       	call   3f00 <unlink>
      unlink(file);
    1ab0:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1ab4:	48 89 c7             	mov    %rax,%rdi
    1ab7:	e8 44 24 00 00       	call   3f00 <unlink>
      unlink(file);
    1abc:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1ac0:	48 89 c7             	mov    %rax,%rdi
    1ac3:	e8 38 24 00 00       	call   3f00 <unlink>
    }
    if(pid == 0)
    1ac8:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1acc:	75 05                	jne    1ad3 <concreate+0x3aa>
      exit();
    1ace:	e8 dd 23 00 00       	call   3eb0 <exit>
    else
      wait();
    1ad3:	e8 e0 23 00 00       	call   3eb8 <wait>
  for(i = 0; i < 40; i++){
    1ad8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1adc:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    1ae0:	0f 8e bf fe ff ff    	jle    19a5 <concreate+0x27c>
  }

  printf(1, "concreate ok\n");
    1ae6:	48 c7 c6 c9 4e 00 00 	mov    $0x4ec9,%rsi
    1aed:	bf 01 00 00 00       	mov    $0x1,%edi
    1af2:	b8 00 00 00 00       	mov    $0x0,%eax
    1af7:	e8 76 25 00 00       	call   4072 <printf>
}
    1afc:	90                   	nop
    1afd:	c9                   	leave
    1afe:	c3                   	ret

0000000000001aff <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1aff:	f3 0f 1e fa          	endbr64
    1b03:	55                   	push   %rbp
    1b04:	48 89 e5             	mov    %rsp,%rbp
    1b07:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, i;

  printf(1, "linkunlink test\n");
    1b0b:	48 c7 c6 d7 4e 00 00 	mov    $0x4ed7,%rsi
    1b12:	bf 01 00 00 00       	mov    $0x1,%edi
    1b17:	b8 00 00 00 00       	mov    $0x0,%eax
    1b1c:	e8 51 25 00 00       	call   4072 <printf>

  unlink("x");
    1b21:	48 c7 c7 32 4a 00 00 	mov    $0x4a32,%rdi
    1b28:	e8 d3 23 00 00       	call   3f00 <unlink>
  pid = fork();
    1b2d:	e8 76 23 00 00       	call   3ea8 <fork>
    1b32:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid < 0){
    1b35:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1b39:	79 1b                	jns    1b56 <linkunlink+0x57>
    printf(1, "fork failed\n");
    1b3b:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
    1b42:	bf 01 00 00 00       	mov    $0x1,%edi
    1b47:	b8 00 00 00 00       	mov    $0x0,%eax
    1b4c:	e8 21 25 00 00       	call   4072 <printf>
    exit();
    1b51:	e8 5a 23 00 00       	call   3eb0 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1b56:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1b5a:	74 07                	je     1b63 <linkunlink+0x64>
    1b5c:	b8 01 00 00 00       	mov    $0x1,%eax
    1b61:	eb 05                	jmp    1b68 <linkunlink+0x69>
    1b63:	b8 61 00 00 00       	mov    $0x61,%eax
    1b68:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 100; i++){
    1b6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1b72:	e9 99 00 00 00       	jmp    1c10 <linkunlink+0x111>
    x = x * 1103515245 + 12345;
    1b77:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1b7a:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1b80:	05 39 30 00 00       	add    $0x3039,%eax
    1b85:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if((x % 3) == 0){
    1b88:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    1b8b:	89 ca                	mov    %ecx,%edx
    1b8d:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1b92:	48 0f af c2          	imul   %rdx,%rax
    1b96:	48 c1 e8 20          	shr    $0x20,%rax
    1b9a:	89 c2                	mov    %eax,%edx
    1b9c:	d1 ea                	shr    $1,%edx
    1b9e:	89 d0                	mov    %edx,%eax
    1ba0:	01 c0                	add    %eax,%eax
    1ba2:	01 d0                	add    %edx,%eax
    1ba4:	29 c1                	sub    %eax,%ecx
    1ba6:	89 ca                	mov    %ecx,%edx
    1ba8:	85 d2                	test   %edx,%edx
    1baa:	75 1a                	jne    1bc6 <linkunlink+0xc7>
      close(open("x", O_RDWR | O_CREATE));
    1bac:	be 02 02 00 00       	mov    $0x202,%esi
    1bb1:	48 c7 c7 32 4a 00 00 	mov    $0x4a32,%rdi
    1bb8:	e8 33 23 00 00       	call   3ef0 <open>
    1bbd:	89 c7                	mov    %eax,%edi
    1bbf:	e8 14 23 00 00       	call   3ed8 <close>
    1bc4:	eb 46                	jmp    1c0c <linkunlink+0x10d>
    } else if((x % 3) == 1){
    1bc6:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    1bc9:	89 ca                	mov    %ecx,%edx
    1bcb:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1bd0:	48 0f af c2          	imul   %rdx,%rax
    1bd4:	48 c1 e8 20          	shr    $0x20,%rax
    1bd8:	89 c2                	mov    %eax,%edx
    1bda:	d1 ea                	shr    $1,%edx
    1bdc:	89 d0                	mov    %edx,%eax
    1bde:	01 c0                	add    %eax,%eax
    1be0:	01 d0                	add    %edx,%eax
    1be2:	29 c1                	sub    %eax,%ecx
    1be4:	89 ca                	mov    %ecx,%edx
    1be6:	83 fa 01             	cmp    $0x1,%edx
    1be9:	75 15                	jne    1c00 <linkunlink+0x101>
      link("cat", "x");
    1beb:	48 c7 c6 32 4a 00 00 	mov    $0x4a32,%rsi
    1bf2:	48 c7 c7 e8 4e 00 00 	mov    $0x4ee8,%rdi
    1bf9:	e8 12 23 00 00       	call   3f10 <link>
    1bfe:	eb 0c                	jmp    1c0c <linkunlink+0x10d>
    } else {
      unlink("x");
    1c00:	48 c7 c7 32 4a 00 00 	mov    $0x4a32,%rdi
    1c07:	e8 f4 22 00 00       	call   3f00 <unlink>
  for(i = 0; i < 100; i++){
    1c0c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1c10:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    1c14:	0f 8e 5d ff ff ff    	jle    1b77 <linkunlink+0x78>
    }
  }

  if(pid)
    1c1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1c1e:	74 07                	je     1c27 <linkunlink+0x128>
    wait();
    1c20:	e8 93 22 00 00       	call   3eb8 <wait>
    1c25:	eb 05                	jmp    1c2c <linkunlink+0x12d>
  else 
    exit();
    1c27:	e8 84 22 00 00       	call   3eb0 <exit>

  printf(1, "linkunlink ok\n");
    1c2c:	48 c7 c6 ec 4e 00 00 	mov    $0x4eec,%rsi
    1c33:	bf 01 00 00 00       	mov    $0x1,%edi
    1c38:	b8 00 00 00 00       	mov    $0x0,%eax
    1c3d:	e8 30 24 00 00       	call   4072 <printf>
}
    1c42:	90                   	nop
    1c43:	c9                   	leave
    1c44:	c3                   	ret

0000000000001c45 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1c45:	f3 0f 1e fa          	endbr64
    1c49:	55                   	push   %rbp
    1c4a:	48 89 e5             	mov    %rsp,%rbp
    1c4d:	48 83 ec 20          	sub    $0x20,%rsp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1c51:	48 c7 c6 fb 4e 00 00 	mov    $0x4efb,%rsi
    1c58:	bf 01 00 00 00       	mov    $0x1,%edi
    1c5d:	b8 00 00 00 00       	mov    $0x0,%eax
    1c62:	e8 0b 24 00 00       	call   4072 <printf>
  unlink("bd");
    1c67:	48 c7 c7 08 4f 00 00 	mov    $0x4f08,%rdi
    1c6e:	e8 8d 22 00 00       	call   3f00 <unlink>

  fd = open("bd", O_CREATE);
    1c73:	be 00 02 00 00       	mov    $0x200,%esi
    1c78:	48 c7 c7 08 4f 00 00 	mov    $0x4f08,%rdi
    1c7f:	e8 6c 22 00 00       	call   3ef0 <open>
    1c84:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    1c87:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1c8b:	79 1b                	jns    1ca8 <bigdir+0x63>
    printf(1, "bigdir create failed\n");
    1c8d:	48 c7 c6 0b 4f 00 00 	mov    $0x4f0b,%rsi
    1c94:	bf 01 00 00 00       	mov    $0x1,%edi
    1c99:	b8 00 00 00 00       	mov    $0x0,%eax
    1c9e:	e8 cf 23 00 00       	call   4072 <printf>
    exit();
    1ca3:	e8 08 22 00 00       	call   3eb0 <exit>
  }
  close(fd);
    1ca8:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1cab:	89 c7                	mov    %eax,%edi
    1cad:	e8 26 22 00 00       	call   3ed8 <close>

  for(i = 0; i < 500; i++){
    1cb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1cb9:	eb 6c                	jmp    1d27 <bigdir+0xe2>
    name[0] = 'x';
    1cbb:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    1cbf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1cc2:	8d 50 3f             	lea    0x3f(%rax),%edx
    1cc5:	85 c0                	test   %eax,%eax
    1cc7:	0f 48 c2             	cmovs  %edx,%eax
    1cca:	c1 f8 06             	sar    $0x6,%eax
    1ccd:	83 c0 30             	add    $0x30,%eax
    1cd0:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    1cd3:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1cd6:	89 d0                	mov    %edx,%eax
    1cd8:	c1 f8 1f             	sar    $0x1f,%eax
    1cdb:	c1 e8 1a             	shr    $0x1a,%eax
    1cde:	01 c2                	add    %eax,%edx
    1ce0:	83 e2 3f             	and    $0x3f,%edx
    1ce3:	29 c2                	sub    %eax,%edx
    1ce5:	89 d0                	mov    %edx,%eax
    1ce7:	83 c0 30             	add    $0x30,%eax
    1cea:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    1ced:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(link("bd", name) != 0){
    1cf1:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1cf5:	48 89 c6             	mov    %rax,%rsi
    1cf8:	48 c7 c7 08 4f 00 00 	mov    $0x4f08,%rdi
    1cff:	e8 0c 22 00 00       	call   3f10 <link>
    1d04:	85 c0                	test   %eax,%eax
    1d06:	74 1b                	je     1d23 <bigdir+0xde>
      printf(1, "bigdir link failed\n");
    1d08:	48 c7 c6 21 4f 00 00 	mov    $0x4f21,%rsi
    1d0f:	bf 01 00 00 00       	mov    $0x1,%edi
    1d14:	b8 00 00 00 00       	mov    $0x0,%eax
    1d19:	e8 54 23 00 00       	call   4072 <printf>
      exit();
    1d1e:	e8 8d 21 00 00       	call   3eb0 <exit>
  for(i = 0; i < 500; i++){
    1d23:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1d27:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    1d2e:	7e 8b                	jle    1cbb <bigdir+0x76>
    }
  }

  unlink("bd");
    1d30:	48 c7 c7 08 4f 00 00 	mov    $0x4f08,%rdi
    1d37:	e8 c4 21 00 00       	call   3f00 <unlink>
  for(i = 0; i < 500; i++){
    1d3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1d43:	eb 65                	jmp    1daa <bigdir+0x165>
    name[0] = 'x';
    1d45:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    1d49:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1d4c:	8d 50 3f             	lea    0x3f(%rax),%edx
    1d4f:	85 c0                	test   %eax,%eax
    1d51:	0f 48 c2             	cmovs  %edx,%eax
    1d54:	c1 f8 06             	sar    $0x6,%eax
    1d57:	83 c0 30             	add    $0x30,%eax
    1d5a:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    1d5d:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1d60:	89 d0                	mov    %edx,%eax
    1d62:	c1 f8 1f             	sar    $0x1f,%eax
    1d65:	c1 e8 1a             	shr    $0x1a,%eax
    1d68:	01 c2                	add    %eax,%edx
    1d6a:	83 e2 3f             	and    $0x3f,%edx
    1d6d:	29 c2                	sub    %eax,%edx
    1d6f:	89 d0                	mov    %edx,%eax
    1d71:	83 c0 30             	add    $0x30,%eax
    1d74:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    1d77:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(unlink(name) != 0){
    1d7b:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1d7f:	48 89 c7             	mov    %rax,%rdi
    1d82:	e8 79 21 00 00       	call   3f00 <unlink>
    1d87:	85 c0                	test   %eax,%eax
    1d89:	74 1b                	je     1da6 <bigdir+0x161>
      printf(1, "bigdir unlink failed");
    1d8b:	48 c7 c6 35 4f 00 00 	mov    $0x4f35,%rsi
    1d92:	bf 01 00 00 00       	mov    $0x1,%edi
    1d97:	b8 00 00 00 00       	mov    $0x0,%eax
    1d9c:	e8 d1 22 00 00       	call   4072 <printf>
      exit();
    1da1:	e8 0a 21 00 00       	call   3eb0 <exit>
  for(i = 0; i < 500; i++){
    1da6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1daa:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    1db1:	7e 92                	jle    1d45 <bigdir+0x100>
    }
  }

  printf(1, "bigdir ok\n");
    1db3:	48 c7 c6 4a 4f 00 00 	mov    $0x4f4a,%rsi
    1dba:	bf 01 00 00 00       	mov    $0x1,%edi
    1dbf:	b8 00 00 00 00       	mov    $0x0,%eax
    1dc4:	e8 a9 22 00 00       	call   4072 <printf>
}
    1dc9:	90                   	nop
    1dca:	c9                   	leave
    1dcb:	c3                   	ret

0000000000001dcc <subdir>:

void
subdir(void)
{
    1dcc:	f3 0f 1e fa          	endbr64
    1dd0:	55                   	push   %rbp
    1dd1:	48 89 e5             	mov    %rsp,%rbp
    1dd4:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, cc;

  printf(1, "subdir test\n");
    1dd8:	48 c7 c6 55 4f 00 00 	mov    $0x4f55,%rsi
    1ddf:	bf 01 00 00 00       	mov    $0x1,%edi
    1de4:	b8 00 00 00 00       	mov    $0x0,%eax
    1de9:	e8 84 22 00 00       	call   4072 <printf>

  unlink("ff");
    1dee:	48 c7 c7 62 4f 00 00 	mov    $0x4f62,%rdi
    1df5:	e8 06 21 00 00       	call   3f00 <unlink>
  if(mkdir("dd") != 0){
    1dfa:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    1e01:	e8 12 21 00 00       	call   3f18 <mkdir>
    1e06:	85 c0                	test   %eax,%eax
    1e08:	74 1b                	je     1e25 <subdir+0x59>
    printf(1, "subdir mkdir dd failed\n");
    1e0a:	48 c7 c6 68 4f 00 00 	mov    $0x4f68,%rsi
    1e11:	bf 01 00 00 00       	mov    $0x1,%edi
    1e16:	b8 00 00 00 00       	mov    $0x0,%eax
    1e1b:	e8 52 22 00 00       	call   4072 <printf>
    exit();
    1e20:	e8 8b 20 00 00       	call   3eb0 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1e25:	be 02 02 00 00       	mov    $0x202,%esi
    1e2a:	48 c7 c7 80 4f 00 00 	mov    $0x4f80,%rdi
    1e31:	e8 ba 20 00 00       	call   3ef0 <open>
    1e36:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1e39:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1e3d:	79 1b                	jns    1e5a <subdir+0x8e>
    printf(1, "create dd/ff failed\n");
    1e3f:	48 c7 c6 86 4f 00 00 	mov    $0x4f86,%rsi
    1e46:	bf 01 00 00 00       	mov    $0x1,%edi
    1e4b:	b8 00 00 00 00       	mov    $0x0,%eax
    1e50:	e8 1d 22 00 00       	call   4072 <printf>
    exit();
    1e55:	e8 56 20 00 00       	call   3eb0 <exit>
  }
  write(fd, "ff", 2);
    1e5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e5d:	ba 02 00 00 00       	mov    $0x2,%edx
    1e62:	48 c7 c6 62 4f 00 00 	mov    $0x4f62,%rsi
    1e69:	89 c7                	mov    %eax,%edi
    1e6b:	e8 60 20 00 00       	call   3ed0 <write>
  close(fd);
    1e70:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e73:	89 c7                	mov    %eax,%edi
    1e75:	e8 5e 20 00 00       	call   3ed8 <close>
  
  if(unlink("dd") >= 0){
    1e7a:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    1e81:	e8 7a 20 00 00       	call   3f00 <unlink>
    1e86:	85 c0                	test   %eax,%eax
    1e88:	78 1b                	js     1ea5 <subdir+0xd9>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1e8a:	48 c7 c6 a0 4f 00 00 	mov    $0x4fa0,%rsi
    1e91:	bf 01 00 00 00       	mov    $0x1,%edi
    1e96:	b8 00 00 00 00       	mov    $0x0,%eax
    1e9b:	e8 d2 21 00 00       	call   4072 <printf>
    exit();
    1ea0:	e8 0b 20 00 00       	call   3eb0 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1ea5:	48 c7 c7 c6 4f 00 00 	mov    $0x4fc6,%rdi
    1eac:	e8 67 20 00 00       	call   3f18 <mkdir>
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	74 1b                	je     1ed0 <subdir+0x104>
    printf(1, "subdir mkdir dd/dd failed\n");
    1eb5:	48 c7 c6 cd 4f 00 00 	mov    $0x4fcd,%rsi
    1ebc:	bf 01 00 00 00       	mov    $0x1,%edi
    1ec1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ec6:	e8 a7 21 00 00       	call   4072 <printf>
    exit();
    1ecb:	e8 e0 1f 00 00       	call   3eb0 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1ed0:	be 02 02 00 00       	mov    $0x202,%esi
    1ed5:	48 c7 c7 e8 4f 00 00 	mov    $0x4fe8,%rdi
    1edc:	e8 0f 20 00 00       	call   3ef0 <open>
    1ee1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1ee4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1ee8:	79 1b                	jns    1f05 <subdir+0x139>
    printf(1, "create dd/dd/ff failed\n");
    1eea:	48 c7 c6 f1 4f 00 00 	mov    $0x4ff1,%rsi
    1ef1:	bf 01 00 00 00       	mov    $0x1,%edi
    1ef6:	b8 00 00 00 00       	mov    $0x0,%eax
    1efb:	e8 72 21 00 00       	call   4072 <printf>
    exit();
    1f00:	e8 ab 1f 00 00       	call   3eb0 <exit>
  }
  write(fd, "FF", 2);
    1f05:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f08:	ba 02 00 00 00       	mov    $0x2,%edx
    1f0d:	48 c7 c6 09 50 00 00 	mov    $0x5009,%rsi
    1f14:	89 c7                	mov    %eax,%edi
    1f16:	e8 b5 1f 00 00       	call   3ed0 <write>
  close(fd);
    1f1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f1e:	89 c7                	mov    %eax,%edi
    1f20:	e8 b3 1f 00 00       	call   3ed8 <close>

  fd = open("dd/dd/../ff", 0);
    1f25:	be 00 00 00 00       	mov    $0x0,%esi
    1f2a:	48 c7 c7 0c 50 00 00 	mov    $0x500c,%rdi
    1f31:	e8 ba 1f 00 00       	call   3ef0 <open>
    1f36:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1f39:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1f3d:	79 1b                	jns    1f5a <subdir+0x18e>
    printf(1, "open dd/dd/../ff failed\n");
    1f3f:	48 c7 c6 18 50 00 00 	mov    $0x5018,%rsi
    1f46:	bf 01 00 00 00       	mov    $0x1,%edi
    1f4b:	b8 00 00 00 00       	mov    $0x0,%eax
    1f50:	e8 1d 21 00 00       	call   4072 <printf>
    exit();
    1f55:	e8 56 1f 00 00       	call   3eb0 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1f5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f5d:	ba 00 20 00 00       	mov    $0x2000,%edx
    1f62:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    1f69:	89 c7                	mov    %eax,%edi
    1f6b:	e8 58 1f 00 00       	call   3ec8 <read>
    1f70:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(cc != 2 || buf[0] != 'f'){
    1f73:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
    1f77:	75 0b                	jne    1f84 <subdir+0x1b8>
    1f79:	0f b6 05 c0 44 00 00 	movzbl 0x44c0(%rip),%eax        # 6440 <buf>
    1f80:	3c 66                	cmp    $0x66,%al
    1f82:	74 1b                	je     1f9f <subdir+0x1d3>
    printf(1, "dd/dd/../ff wrong content\n");
    1f84:	48 c7 c6 31 50 00 00 	mov    $0x5031,%rsi
    1f8b:	bf 01 00 00 00       	mov    $0x1,%edi
    1f90:	b8 00 00 00 00       	mov    $0x0,%eax
    1f95:	e8 d8 20 00 00       	call   4072 <printf>
    exit();
    1f9a:	e8 11 1f 00 00       	call   3eb0 <exit>
  }
  close(fd);
    1f9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1fa2:	89 c7                	mov    %eax,%edi
    1fa4:	e8 2f 1f 00 00       	call   3ed8 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1fa9:	48 c7 c6 4c 50 00 00 	mov    $0x504c,%rsi
    1fb0:	48 c7 c7 e8 4f 00 00 	mov    $0x4fe8,%rdi
    1fb7:	e8 54 1f 00 00       	call   3f10 <link>
    1fbc:	85 c0                	test   %eax,%eax
    1fbe:	74 1b                	je     1fdb <subdir+0x20f>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1fc0:	48 c7 c6 58 50 00 00 	mov    $0x5058,%rsi
    1fc7:	bf 01 00 00 00       	mov    $0x1,%edi
    1fcc:	b8 00 00 00 00       	mov    $0x0,%eax
    1fd1:	e8 9c 20 00 00       	call   4072 <printf>
    exit();
    1fd6:	e8 d5 1e 00 00       	call   3eb0 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1fdb:	48 c7 c7 e8 4f 00 00 	mov    $0x4fe8,%rdi
    1fe2:	e8 19 1f 00 00       	call   3f00 <unlink>
    1fe7:	85 c0                	test   %eax,%eax
    1fe9:	74 1b                	je     2006 <subdir+0x23a>
    printf(1, "unlink dd/dd/ff failed\n");
    1feb:	48 c7 c6 79 50 00 00 	mov    $0x5079,%rsi
    1ff2:	bf 01 00 00 00       	mov    $0x1,%edi
    1ff7:	b8 00 00 00 00       	mov    $0x0,%eax
    1ffc:	e8 71 20 00 00       	call   4072 <printf>
    exit();
    2001:	e8 aa 1e 00 00       	call   3eb0 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2006:	be 00 00 00 00       	mov    $0x0,%esi
    200b:	48 c7 c7 e8 4f 00 00 	mov    $0x4fe8,%rdi
    2012:	e8 d9 1e 00 00       	call   3ef0 <open>
    2017:	85 c0                	test   %eax,%eax
    2019:	78 1b                	js     2036 <subdir+0x26a>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    201b:	48 c7 c6 98 50 00 00 	mov    $0x5098,%rsi
    2022:	bf 01 00 00 00       	mov    $0x1,%edi
    2027:	b8 00 00 00 00       	mov    $0x0,%eax
    202c:	e8 41 20 00 00       	call   4072 <printf>
    exit();
    2031:	e8 7a 1e 00 00       	call   3eb0 <exit>
  }

  if(chdir("dd") != 0){
    2036:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    203d:	e8 de 1e 00 00       	call   3f20 <chdir>
    2042:	85 c0                	test   %eax,%eax
    2044:	74 1b                	je     2061 <subdir+0x295>
    printf(1, "chdir dd failed\n");
    2046:	48 c7 c6 bc 50 00 00 	mov    $0x50bc,%rsi
    204d:	bf 01 00 00 00       	mov    $0x1,%edi
    2052:	b8 00 00 00 00       	mov    $0x0,%eax
    2057:	e8 16 20 00 00       	call   4072 <printf>
    exit();
    205c:	e8 4f 1e 00 00       	call   3eb0 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    2061:	48 c7 c7 cd 50 00 00 	mov    $0x50cd,%rdi
    2068:	e8 b3 1e 00 00       	call   3f20 <chdir>
    206d:	85 c0                	test   %eax,%eax
    206f:	74 1b                	je     208c <subdir+0x2c0>
    printf(1, "chdir dd/../../dd failed\n");
    2071:	48 c7 c6 d9 50 00 00 	mov    $0x50d9,%rsi
    2078:	bf 01 00 00 00       	mov    $0x1,%edi
    207d:	b8 00 00 00 00       	mov    $0x0,%eax
    2082:	e8 eb 1f 00 00       	call   4072 <printf>
    exit();
    2087:	e8 24 1e 00 00       	call   3eb0 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    208c:	48 c7 c7 f3 50 00 00 	mov    $0x50f3,%rdi
    2093:	e8 88 1e 00 00       	call   3f20 <chdir>
    2098:	85 c0                	test   %eax,%eax
    209a:	74 1b                	je     20b7 <subdir+0x2eb>
    printf(1, "chdir dd/../../dd failed\n");
    209c:	48 c7 c6 d9 50 00 00 	mov    $0x50d9,%rsi
    20a3:	bf 01 00 00 00       	mov    $0x1,%edi
    20a8:	b8 00 00 00 00       	mov    $0x0,%eax
    20ad:	e8 c0 1f 00 00       	call   4072 <printf>
    exit();
    20b2:	e8 f9 1d 00 00       	call   3eb0 <exit>
  }
  if(chdir("./..") != 0){
    20b7:	48 c7 c7 02 51 00 00 	mov    $0x5102,%rdi
    20be:	e8 5d 1e 00 00       	call   3f20 <chdir>
    20c3:	85 c0                	test   %eax,%eax
    20c5:	74 1b                	je     20e2 <subdir+0x316>
    printf(1, "chdir ./.. failed\n");
    20c7:	48 c7 c6 07 51 00 00 	mov    $0x5107,%rsi
    20ce:	bf 01 00 00 00       	mov    $0x1,%edi
    20d3:	b8 00 00 00 00       	mov    $0x0,%eax
    20d8:	e8 95 1f 00 00       	call   4072 <printf>
    exit();
    20dd:	e8 ce 1d 00 00       	call   3eb0 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    20e2:	be 00 00 00 00       	mov    $0x0,%esi
    20e7:	48 c7 c7 4c 50 00 00 	mov    $0x504c,%rdi
    20ee:	e8 fd 1d 00 00       	call   3ef0 <open>
    20f3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    20f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    20fa:	79 1b                	jns    2117 <subdir+0x34b>
    printf(1, "open dd/dd/ffff failed\n");
    20fc:	48 c7 c6 1a 51 00 00 	mov    $0x511a,%rsi
    2103:	bf 01 00 00 00       	mov    $0x1,%edi
    2108:	b8 00 00 00 00       	mov    $0x0,%eax
    210d:	e8 60 1f 00 00       	call   4072 <printf>
    exit();
    2112:	e8 99 1d 00 00       	call   3eb0 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2117:	8b 45 fc             	mov    -0x4(%rbp),%eax
    211a:	ba 00 20 00 00       	mov    $0x2000,%edx
    211f:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    2126:	89 c7                	mov    %eax,%edi
    2128:	e8 9b 1d 00 00       	call   3ec8 <read>
    212d:	83 f8 02             	cmp    $0x2,%eax
    2130:	74 1b                	je     214d <subdir+0x381>
    printf(1, "read dd/dd/ffff wrong len\n");
    2132:	48 c7 c6 32 51 00 00 	mov    $0x5132,%rsi
    2139:	bf 01 00 00 00       	mov    $0x1,%edi
    213e:	b8 00 00 00 00       	mov    $0x0,%eax
    2143:	e8 2a 1f 00 00       	call   4072 <printf>
    exit();
    2148:	e8 63 1d 00 00       	call   3eb0 <exit>
  }
  close(fd);
    214d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2150:	89 c7                	mov    %eax,%edi
    2152:	e8 81 1d 00 00       	call   3ed8 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2157:	be 00 00 00 00       	mov    $0x0,%esi
    215c:	48 c7 c7 e8 4f 00 00 	mov    $0x4fe8,%rdi
    2163:	e8 88 1d 00 00       	call   3ef0 <open>
    2168:	85 c0                	test   %eax,%eax
    216a:	78 1b                	js     2187 <subdir+0x3bb>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    216c:	48 c7 c6 50 51 00 00 	mov    $0x5150,%rsi
    2173:	bf 01 00 00 00       	mov    $0x1,%edi
    2178:	b8 00 00 00 00       	mov    $0x0,%eax
    217d:	e8 f0 1e 00 00       	call   4072 <printf>
    exit();
    2182:	e8 29 1d 00 00       	call   3eb0 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2187:	be 02 02 00 00       	mov    $0x202,%esi
    218c:	48 c7 c7 75 51 00 00 	mov    $0x5175,%rdi
    2193:	e8 58 1d 00 00       	call   3ef0 <open>
    2198:	85 c0                	test   %eax,%eax
    219a:	78 1b                	js     21b7 <subdir+0x3eb>
    printf(1, "create dd/ff/ff succeeded!\n");
    219c:	48 c7 c6 7e 51 00 00 	mov    $0x517e,%rsi
    21a3:	bf 01 00 00 00       	mov    $0x1,%edi
    21a8:	b8 00 00 00 00       	mov    $0x0,%eax
    21ad:	e8 c0 1e 00 00       	call   4072 <printf>
    exit();
    21b2:	e8 f9 1c 00 00       	call   3eb0 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    21b7:	be 02 02 00 00       	mov    $0x202,%esi
    21bc:	48 c7 c7 9a 51 00 00 	mov    $0x519a,%rdi
    21c3:	e8 28 1d 00 00       	call   3ef0 <open>
    21c8:	85 c0                	test   %eax,%eax
    21ca:	78 1b                	js     21e7 <subdir+0x41b>
    printf(1, "create dd/xx/ff succeeded!\n");
    21cc:	48 c7 c6 a3 51 00 00 	mov    $0x51a3,%rsi
    21d3:	bf 01 00 00 00       	mov    $0x1,%edi
    21d8:	b8 00 00 00 00       	mov    $0x0,%eax
    21dd:	e8 90 1e 00 00       	call   4072 <printf>
    exit();
    21e2:	e8 c9 1c 00 00       	call   3eb0 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    21e7:	be 00 02 00 00       	mov    $0x200,%esi
    21ec:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    21f3:	e8 f8 1c 00 00       	call   3ef0 <open>
    21f8:	85 c0                	test   %eax,%eax
    21fa:	78 1b                	js     2217 <subdir+0x44b>
    printf(1, "create dd succeeded!\n");
    21fc:	48 c7 c6 bf 51 00 00 	mov    $0x51bf,%rsi
    2203:	bf 01 00 00 00       	mov    $0x1,%edi
    2208:	b8 00 00 00 00       	mov    $0x0,%eax
    220d:	e8 60 1e 00 00       	call   4072 <printf>
    exit();
    2212:	e8 99 1c 00 00       	call   3eb0 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    2217:	be 02 00 00 00       	mov    $0x2,%esi
    221c:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    2223:	e8 c8 1c 00 00       	call   3ef0 <open>
    2228:	85 c0                	test   %eax,%eax
    222a:	78 1b                	js     2247 <subdir+0x47b>
    printf(1, "open dd rdwr succeeded!\n");
    222c:	48 c7 c6 d5 51 00 00 	mov    $0x51d5,%rsi
    2233:	bf 01 00 00 00       	mov    $0x1,%edi
    2238:	b8 00 00 00 00       	mov    $0x0,%eax
    223d:	e8 30 1e 00 00       	call   4072 <printf>
    exit();
    2242:	e8 69 1c 00 00       	call   3eb0 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    2247:	be 01 00 00 00       	mov    $0x1,%esi
    224c:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    2253:	e8 98 1c 00 00       	call   3ef0 <open>
    2258:	85 c0                	test   %eax,%eax
    225a:	78 1b                	js     2277 <subdir+0x4ab>
    printf(1, "open dd wronly succeeded!\n");
    225c:	48 c7 c6 ee 51 00 00 	mov    $0x51ee,%rsi
    2263:	bf 01 00 00 00       	mov    $0x1,%edi
    2268:	b8 00 00 00 00       	mov    $0x0,%eax
    226d:	e8 00 1e 00 00       	call   4072 <printf>
    exit();
    2272:	e8 39 1c 00 00       	call   3eb0 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2277:	48 c7 c6 09 52 00 00 	mov    $0x5209,%rsi
    227e:	48 c7 c7 75 51 00 00 	mov    $0x5175,%rdi
    2285:	e8 86 1c 00 00       	call   3f10 <link>
    228a:	85 c0                	test   %eax,%eax
    228c:	75 1b                	jne    22a9 <subdir+0x4dd>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    228e:	48 c7 c6 18 52 00 00 	mov    $0x5218,%rsi
    2295:	bf 01 00 00 00       	mov    $0x1,%edi
    229a:	b8 00 00 00 00       	mov    $0x0,%eax
    229f:	e8 ce 1d 00 00       	call   4072 <printf>
    exit();
    22a4:	e8 07 1c 00 00       	call   3eb0 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    22a9:	48 c7 c6 09 52 00 00 	mov    $0x5209,%rsi
    22b0:	48 c7 c7 9a 51 00 00 	mov    $0x519a,%rdi
    22b7:	e8 54 1c 00 00       	call   3f10 <link>
    22bc:	85 c0                	test   %eax,%eax
    22be:	75 1b                	jne    22db <subdir+0x50f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    22c0:	48 c7 c6 40 52 00 00 	mov    $0x5240,%rsi
    22c7:	bf 01 00 00 00       	mov    $0x1,%edi
    22cc:	b8 00 00 00 00       	mov    $0x0,%eax
    22d1:	e8 9c 1d 00 00       	call   4072 <printf>
    exit();
    22d6:	e8 d5 1b 00 00       	call   3eb0 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    22db:	48 c7 c6 4c 50 00 00 	mov    $0x504c,%rsi
    22e2:	48 c7 c7 80 4f 00 00 	mov    $0x4f80,%rdi
    22e9:	e8 22 1c 00 00       	call   3f10 <link>
    22ee:	85 c0                	test   %eax,%eax
    22f0:	75 1b                	jne    230d <subdir+0x541>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    22f2:	48 c7 c6 68 52 00 00 	mov    $0x5268,%rsi
    22f9:	bf 01 00 00 00       	mov    $0x1,%edi
    22fe:	b8 00 00 00 00       	mov    $0x0,%eax
    2303:	e8 6a 1d 00 00       	call   4072 <printf>
    exit();
    2308:	e8 a3 1b 00 00       	call   3eb0 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    230d:	48 c7 c7 75 51 00 00 	mov    $0x5175,%rdi
    2314:	e8 ff 1b 00 00       	call   3f18 <mkdir>
    2319:	85 c0                	test   %eax,%eax
    231b:	75 1b                	jne    2338 <subdir+0x56c>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    231d:	48 c7 c6 8a 52 00 00 	mov    $0x528a,%rsi
    2324:	bf 01 00 00 00       	mov    $0x1,%edi
    2329:	b8 00 00 00 00       	mov    $0x0,%eax
    232e:	e8 3f 1d 00 00       	call   4072 <printf>
    exit();
    2333:	e8 78 1b 00 00       	call   3eb0 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2338:	48 c7 c7 9a 51 00 00 	mov    $0x519a,%rdi
    233f:	e8 d4 1b 00 00       	call   3f18 <mkdir>
    2344:	85 c0                	test   %eax,%eax
    2346:	75 1b                	jne    2363 <subdir+0x597>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2348:	48 c7 c6 a5 52 00 00 	mov    $0x52a5,%rsi
    234f:	bf 01 00 00 00       	mov    $0x1,%edi
    2354:	b8 00 00 00 00       	mov    $0x0,%eax
    2359:	e8 14 1d 00 00       	call   4072 <printf>
    exit();
    235e:	e8 4d 1b 00 00       	call   3eb0 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2363:	48 c7 c7 4c 50 00 00 	mov    $0x504c,%rdi
    236a:	e8 a9 1b 00 00       	call   3f18 <mkdir>
    236f:	85 c0                	test   %eax,%eax
    2371:	75 1b                	jne    238e <subdir+0x5c2>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2373:	48 c7 c6 c0 52 00 00 	mov    $0x52c0,%rsi
    237a:	bf 01 00 00 00       	mov    $0x1,%edi
    237f:	b8 00 00 00 00       	mov    $0x0,%eax
    2384:	e8 e9 1c 00 00       	call   4072 <printf>
    exit();
    2389:	e8 22 1b 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    238e:	48 c7 c7 9a 51 00 00 	mov    $0x519a,%rdi
    2395:	e8 66 1b 00 00       	call   3f00 <unlink>
    239a:	85 c0                	test   %eax,%eax
    239c:	75 1b                	jne    23b9 <subdir+0x5ed>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    239e:	48 c7 c6 dd 52 00 00 	mov    $0x52dd,%rsi
    23a5:	bf 01 00 00 00       	mov    $0x1,%edi
    23aa:	b8 00 00 00 00       	mov    $0x0,%eax
    23af:	e8 be 1c 00 00       	call   4072 <printf>
    exit();
    23b4:	e8 f7 1a 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    23b9:	48 c7 c7 75 51 00 00 	mov    $0x5175,%rdi
    23c0:	e8 3b 1b 00 00       	call   3f00 <unlink>
    23c5:	85 c0                	test   %eax,%eax
    23c7:	75 1b                	jne    23e4 <subdir+0x618>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    23c9:	48 c7 c6 f9 52 00 00 	mov    $0x52f9,%rsi
    23d0:	bf 01 00 00 00       	mov    $0x1,%edi
    23d5:	b8 00 00 00 00       	mov    $0x0,%eax
    23da:	e8 93 1c 00 00       	call   4072 <printf>
    exit();
    23df:	e8 cc 1a 00 00       	call   3eb0 <exit>
  }
  if(chdir("dd/ff") == 0){
    23e4:	48 c7 c7 80 4f 00 00 	mov    $0x4f80,%rdi
    23eb:	e8 30 1b 00 00       	call   3f20 <chdir>
    23f0:	85 c0                	test   %eax,%eax
    23f2:	75 1b                	jne    240f <subdir+0x643>
    printf(1, "chdir dd/ff succeeded!\n");
    23f4:	48 c7 c6 15 53 00 00 	mov    $0x5315,%rsi
    23fb:	bf 01 00 00 00       	mov    $0x1,%edi
    2400:	b8 00 00 00 00       	mov    $0x0,%eax
    2405:	e8 68 1c 00 00       	call   4072 <printf>
    exit();
    240a:	e8 a1 1a 00 00       	call   3eb0 <exit>
  }
  if(chdir("dd/xx") == 0){
    240f:	48 c7 c7 2d 53 00 00 	mov    $0x532d,%rdi
    2416:	e8 05 1b 00 00       	call   3f20 <chdir>
    241b:	85 c0                	test   %eax,%eax
    241d:	75 1b                	jne    243a <subdir+0x66e>
    printf(1, "chdir dd/xx succeeded!\n");
    241f:	48 c7 c6 33 53 00 00 	mov    $0x5333,%rsi
    2426:	bf 01 00 00 00       	mov    $0x1,%edi
    242b:	b8 00 00 00 00       	mov    $0x0,%eax
    2430:	e8 3d 1c 00 00       	call   4072 <printf>
    exit();
    2435:	e8 76 1a 00 00       	call   3eb0 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    243a:	48 c7 c7 4c 50 00 00 	mov    $0x504c,%rdi
    2441:	e8 ba 1a 00 00       	call   3f00 <unlink>
    2446:	85 c0                	test   %eax,%eax
    2448:	74 1b                	je     2465 <subdir+0x699>
    printf(1, "unlink dd/dd/ff failed\n");
    244a:	48 c7 c6 79 50 00 00 	mov    $0x5079,%rsi
    2451:	bf 01 00 00 00       	mov    $0x1,%edi
    2456:	b8 00 00 00 00       	mov    $0x0,%eax
    245b:	e8 12 1c 00 00       	call   4072 <printf>
    exit();
    2460:	e8 4b 1a 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd/ff") != 0){
    2465:	48 c7 c7 80 4f 00 00 	mov    $0x4f80,%rdi
    246c:	e8 8f 1a 00 00       	call   3f00 <unlink>
    2471:	85 c0                	test   %eax,%eax
    2473:	74 1b                	je     2490 <subdir+0x6c4>
    printf(1, "unlink dd/ff failed\n");
    2475:	48 c7 c6 4b 53 00 00 	mov    $0x534b,%rsi
    247c:	bf 01 00 00 00       	mov    $0x1,%edi
    2481:	b8 00 00 00 00       	mov    $0x0,%eax
    2486:	e8 e7 1b 00 00       	call   4072 <printf>
    exit();
    248b:	e8 20 1a 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd") == 0){
    2490:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    2497:	e8 64 1a 00 00       	call   3f00 <unlink>
    249c:	85 c0                	test   %eax,%eax
    249e:	75 1b                	jne    24bb <subdir+0x6ef>
    printf(1, "unlink non-empty dd succeeded!\n");
    24a0:	48 c7 c6 60 53 00 00 	mov    $0x5360,%rsi
    24a7:	bf 01 00 00 00       	mov    $0x1,%edi
    24ac:	b8 00 00 00 00       	mov    $0x0,%eax
    24b1:	e8 bc 1b 00 00       	call   4072 <printf>
    exit();
    24b6:	e8 f5 19 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd/dd") < 0){
    24bb:	48 c7 c7 80 53 00 00 	mov    $0x5380,%rdi
    24c2:	e8 39 1a 00 00       	call   3f00 <unlink>
    24c7:	85 c0                	test   %eax,%eax
    24c9:	79 1b                	jns    24e6 <subdir+0x71a>
    printf(1, "unlink dd/dd failed\n");
    24cb:	48 c7 c6 86 53 00 00 	mov    $0x5386,%rsi
    24d2:	bf 01 00 00 00       	mov    $0x1,%edi
    24d7:	b8 00 00 00 00       	mov    $0x0,%eax
    24dc:	e8 91 1b 00 00       	call   4072 <printf>
    exit();
    24e1:	e8 ca 19 00 00       	call   3eb0 <exit>
  }
  if(unlink("dd") < 0){
    24e6:	48 c7 c7 65 4f 00 00 	mov    $0x4f65,%rdi
    24ed:	e8 0e 1a 00 00       	call   3f00 <unlink>
    24f2:	85 c0                	test   %eax,%eax
    24f4:	79 1b                	jns    2511 <subdir+0x745>
    printf(1, "unlink dd failed\n");
    24f6:	48 c7 c6 9b 53 00 00 	mov    $0x539b,%rsi
    24fd:	bf 01 00 00 00       	mov    $0x1,%edi
    2502:	b8 00 00 00 00       	mov    $0x0,%eax
    2507:	e8 66 1b 00 00       	call   4072 <printf>
    exit();
    250c:	e8 9f 19 00 00       	call   3eb0 <exit>
  }

  printf(1, "subdir ok\n");
    2511:	48 c7 c6 ad 53 00 00 	mov    $0x53ad,%rsi
    2518:	bf 01 00 00 00       	mov    $0x1,%edi
    251d:	b8 00 00 00 00       	mov    $0x0,%eax
    2522:	e8 4b 1b 00 00       	call   4072 <printf>
}
    2527:	90                   	nop
    2528:	c9                   	leave
    2529:	c3                   	ret

000000000000252a <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    252a:	f3 0f 1e fa          	endbr64
    252e:	55                   	push   %rbp
    252f:	48 89 e5             	mov    %rsp,%rbp
    2532:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2536:	48 c7 c6 b8 53 00 00 	mov    $0x53b8,%rsi
    253d:	bf 01 00 00 00       	mov    $0x1,%edi
    2542:	b8 00 00 00 00       	mov    $0x0,%eax
    2547:	e8 26 1b 00 00       	call   4072 <printf>

  unlink("bigwrite");
    254c:	48 c7 c7 c7 53 00 00 	mov    $0x53c7,%rdi
    2553:	e8 a8 19 00 00       	call   3f00 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2558:	c7 45 fc f3 01 00 00 	movl   $0x1f3,-0x4(%rbp)
    255f:	e9 a9 00 00 00       	jmp    260d <bigwrite+0xe3>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2564:	be 02 02 00 00       	mov    $0x202,%esi
    2569:	48 c7 c7 c7 53 00 00 	mov    $0x53c7,%rdi
    2570:	e8 7b 19 00 00       	call   3ef0 <open>
    2575:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    2578:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    257c:	79 1b                	jns    2599 <bigwrite+0x6f>
      printf(1, "cannot create bigwrite\n");
    257e:	48 c7 c6 d0 53 00 00 	mov    $0x53d0,%rsi
    2585:	bf 01 00 00 00       	mov    $0x1,%edi
    258a:	b8 00 00 00 00       	mov    $0x0,%eax
    258f:	e8 de 1a 00 00       	call   4072 <printf>
      exit();
    2594:	e8 17 19 00 00       	call   3eb0 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    2599:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    25a0:	eb 48                	jmp    25ea <bigwrite+0xc0>
      int cc = write(fd, buf, sz);
    25a2:	8b 55 fc             	mov    -0x4(%rbp),%edx
    25a5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    25a8:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    25af:	89 c7                	mov    %eax,%edi
    25b1:	e8 1a 19 00 00       	call   3ed0 <write>
    25b6:	89 45 f0             	mov    %eax,-0x10(%rbp)
      if(cc != sz){
    25b9:	8b 45 f0             	mov    -0x10(%rbp),%eax
    25bc:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    25bf:	74 25                	je     25e6 <bigwrite+0xbc>
        printf(1, "write(%d) ret %d\n", sz, cc);
    25c1:	8b 55 f0             	mov    -0x10(%rbp),%edx
    25c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    25c7:	89 d1                	mov    %edx,%ecx
    25c9:	89 c2                	mov    %eax,%edx
    25cb:	48 c7 c6 e8 53 00 00 	mov    $0x53e8,%rsi
    25d2:	bf 01 00 00 00       	mov    $0x1,%edi
    25d7:	b8 00 00 00 00       	mov    $0x0,%eax
    25dc:	e8 91 1a 00 00       	call   4072 <printf>
        exit();
    25e1:	e8 ca 18 00 00       	call   3eb0 <exit>
    for(i = 0; i < 2; i++){
    25e6:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    25ea:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
    25ee:	7e b2                	jle    25a2 <bigwrite+0x78>
      }
    }
    close(fd);
    25f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    25f3:	89 c7                	mov    %eax,%edi
    25f5:	e8 de 18 00 00       	call   3ed8 <close>
    unlink("bigwrite");
    25fa:	48 c7 c7 c7 53 00 00 	mov    $0x53c7,%rdi
    2601:	e8 fa 18 00 00       	call   3f00 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2606:	81 45 fc d7 01 00 00 	addl   $0x1d7,-0x4(%rbp)
    260d:	81 7d fc ff 17 00 00 	cmpl   $0x17ff,-0x4(%rbp)
    2614:	0f 8e 4a ff ff ff    	jle    2564 <bigwrite+0x3a>
  }

  printf(1, "bigwrite ok\n");
    261a:	48 c7 c6 fa 53 00 00 	mov    $0x53fa,%rsi
    2621:	bf 01 00 00 00       	mov    $0x1,%edi
    2626:	b8 00 00 00 00       	mov    $0x0,%eax
    262b:	e8 42 1a 00 00       	call   4072 <printf>
}
    2630:	90                   	nop
    2631:	c9                   	leave
    2632:	c3                   	ret

0000000000002633 <bigfile>:

void
bigfile(void)
{
    2633:	f3 0f 1e fa          	endbr64
    2637:	55                   	push   %rbp
    2638:	48 89 e5             	mov    %rsp,%rbp
    263b:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    263f:	48 c7 c6 07 54 00 00 	mov    $0x5407,%rsi
    2646:	bf 01 00 00 00       	mov    $0x1,%edi
    264b:	b8 00 00 00 00       	mov    $0x0,%eax
    2650:	e8 1d 1a 00 00       	call   4072 <printf>

  unlink("bigfile");
    2655:	48 c7 c7 15 54 00 00 	mov    $0x5415,%rdi
    265c:	e8 9f 18 00 00       	call   3f00 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2661:	be 02 02 00 00       	mov    $0x202,%esi
    2666:	48 c7 c7 15 54 00 00 	mov    $0x5415,%rdi
    266d:	e8 7e 18 00 00       	call   3ef0 <open>
    2672:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    2675:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2679:	79 1b                	jns    2696 <bigfile+0x63>
    printf(1, "cannot create bigfile");
    267b:	48 c7 c6 1d 54 00 00 	mov    $0x541d,%rsi
    2682:	bf 01 00 00 00       	mov    $0x1,%edi
    2687:	b8 00 00 00 00       	mov    $0x0,%eax
    268c:	e8 e1 19 00 00       	call   4072 <printf>
    exit();
    2691:	e8 1a 18 00 00       	call   3eb0 <exit>
  }
  for(i = 0; i < 20; i++){
    2696:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    269d:	eb 52                	jmp    26f1 <bigfile+0xbe>
    memset(buf, i, 600);
    269f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26a2:	ba 58 02 00 00       	mov    $0x258,%edx
    26a7:	89 c6                	mov    %eax,%esi
    26a9:	48 c7 c7 40 64 00 00 	mov    $0x6440,%rdi
    26b0:	e8 ee 15 00 00       	call   3ca3 <memset>
    if(write(fd, buf, 600) != 600){
    26b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    26b8:	ba 58 02 00 00       	mov    $0x258,%edx
    26bd:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    26c4:	89 c7                	mov    %eax,%edi
    26c6:	e8 05 18 00 00       	call   3ed0 <write>
    26cb:	3d 58 02 00 00       	cmp    $0x258,%eax
    26d0:	74 1b                	je     26ed <bigfile+0xba>
      printf(1, "write bigfile failed\n");
    26d2:	48 c7 c6 33 54 00 00 	mov    $0x5433,%rsi
    26d9:	bf 01 00 00 00       	mov    $0x1,%edi
    26de:	b8 00 00 00 00       	mov    $0x0,%eax
    26e3:	e8 8a 19 00 00       	call   4072 <printf>
      exit();
    26e8:	e8 c3 17 00 00       	call   3eb0 <exit>
  for(i = 0; i < 20; i++){
    26ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    26f1:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    26f5:	7e a8                	jle    269f <bigfile+0x6c>
    }
  }
  close(fd);
    26f7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    26fa:	89 c7                	mov    %eax,%edi
    26fc:	e8 d7 17 00 00       	call   3ed8 <close>

  fd = open("bigfile", 0);
    2701:	be 00 00 00 00       	mov    $0x0,%esi
    2706:	48 c7 c7 15 54 00 00 	mov    $0x5415,%rdi
    270d:	e8 de 17 00 00       	call   3ef0 <open>
    2712:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    2715:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2719:	79 1b                	jns    2736 <bigfile+0x103>
    printf(1, "cannot open bigfile\n");
    271b:	48 c7 c6 49 54 00 00 	mov    $0x5449,%rsi
    2722:	bf 01 00 00 00       	mov    $0x1,%edi
    2727:	b8 00 00 00 00       	mov    $0x0,%eax
    272c:	e8 41 19 00 00       	call   4072 <printf>
    exit();
    2731:	e8 7a 17 00 00       	call   3eb0 <exit>
  }
  total = 0;
    2736:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i = 0; ; i++){
    273d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    cc = read(fd, buf, 300);
    2744:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2747:	ba 2c 01 00 00       	mov    $0x12c,%edx
    274c:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    2753:	89 c7                	mov    %eax,%edi
    2755:	e8 6e 17 00 00       	call   3ec8 <read>
    275a:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(cc < 0){
    275d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2761:	79 1b                	jns    277e <bigfile+0x14b>
      printf(1, "read bigfile failed\n");
    2763:	48 c7 c6 5e 54 00 00 	mov    $0x545e,%rsi
    276a:	bf 01 00 00 00       	mov    $0x1,%edi
    276f:	b8 00 00 00 00       	mov    $0x0,%eax
    2774:	e8 f9 18 00 00       	call   4072 <printf>
      exit();
    2779:	e8 32 17 00 00       	call   3eb0 <exit>
    }
    if(cc == 0)
    277e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2782:	0f 84 82 00 00 00    	je     280a <bigfile+0x1d7>
      break;
    if(cc != 300){
    2788:	81 7d f0 2c 01 00 00 	cmpl   $0x12c,-0x10(%rbp)
    278f:	74 1b                	je     27ac <bigfile+0x179>
      printf(1, "short read bigfile\n");
    2791:	48 c7 c6 73 54 00 00 	mov    $0x5473,%rsi
    2798:	bf 01 00 00 00       	mov    $0x1,%edi
    279d:	b8 00 00 00 00       	mov    $0x0,%eax
    27a2:	e8 cb 18 00 00       	call   4072 <printf>
      exit();
    27a7:	e8 04 17 00 00       	call   3eb0 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    27ac:	0f b6 05 8d 3c 00 00 	movzbl 0x3c8d(%rip),%eax        # 6440 <buf>
    27b3:	0f be d0             	movsbl %al,%edx
    27b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    27b9:	89 c1                	mov    %eax,%ecx
    27bb:	c1 e9 1f             	shr    $0x1f,%ecx
    27be:	01 c8                	add    %ecx,%eax
    27c0:	d1 f8                	sar    $1,%eax
    27c2:	39 c2                	cmp    %eax,%edx
    27c4:	75 1a                	jne    27e0 <bigfile+0x1ad>
    27c6:	0f b6 05 9e 3d 00 00 	movzbl 0x3d9e(%rip),%eax        # 656b <buf+0x12b>
    27cd:	0f be d0             	movsbl %al,%edx
    27d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    27d3:	89 c1                	mov    %eax,%ecx
    27d5:	c1 e9 1f             	shr    $0x1f,%ecx
    27d8:	01 c8                	add    %ecx,%eax
    27da:	d1 f8                	sar    $1,%eax
    27dc:	39 c2                	cmp    %eax,%edx
    27de:	74 1b                	je     27fb <bigfile+0x1c8>
      printf(1, "read bigfile wrong data\n");
    27e0:	48 c7 c6 87 54 00 00 	mov    $0x5487,%rsi
    27e7:	bf 01 00 00 00       	mov    $0x1,%edi
    27ec:	b8 00 00 00 00       	mov    $0x0,%eax
    27f1:	e8 7c 18 00 00       	call   4072 <printf>
      exit();
    27f6:	e8 b5 16 00 00       	call   3eb0 <exit>
    }
    total += cc;
    27fb:	8b 45 f0             	mov    -0x10(%rbp),%eax
    27fe:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i = 0; ; i++){
    2801:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    cc = read(fd, buf, 300);
    2805:	e9 3a ff ff ff       	jmp    2744 <bigfile+0x111>
      break;
    280a:	90                   	nop
  }
  close(fd);
    280b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    280e:	89 c7                	mov    %eax,%edi
    2810:	e8 c3 16 00 00       	call   3ed8 <close>
  if(total != 20*600){
    2815:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,-0x8(%rbp)
    281c:	74 1b                	je     2839 <bigfile+0x206>
    printf(1, "read bigfile wrong total\n");
    281e:	48 c7 c6 a0 54 00 00 	mov    $0x54a0,%rsi
    2825:	bf 01 00 00 00       	mov    $0x1,%edi
    282a:	b8 00 00 00 00       	mov    $0x0,%eax
    282f:	e8 3e 18 00 00       	call   4072 <printf>
    exit();
    2834:	e8 77 16 00 00       	call   3eb0 <exit>
  }
  unlink("bigfile");
    2839:	48 c7 c7 15 54 00 00 	mov    $0x5415,%rdi
    2840:	e8 bb 16 00 00       	call   3f00 <unlink>

  printf(1, "bigfile test ok\n");
    2845:	48 c7 c6 ba 54 00 00 	mov    $0x54ba,%rsi
    284c:	bf 01 00 00 00       	mov    $0x1,%edi
    2851:	b8 00 00 00 00       	mov    $0x0,%eax
    2856:	e8 17 18 00 00       	call   4072 <printf>
}
    285b:	90                   	nop
    285c:	c9                   	leave
    285d:	c3                   	ret

000000000000285e <fourteen>:

void
fourteen(void)
{
    285e:	f3 0f 1e fa          	endbr64
    2862:	55                   	push   %rbp
    2863:	48 89 e5             	mov    %rsp,%rbp
    2866:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    286a:	48 c7 c6 cb 54 00 00 	mov    $0x54cb,%rsi
    2871:	bf 01 00 00 00       	mov    $0x1,%edi
    2876:	b8 00 00 00 00       	mov    $0x0,%eax
    287b:	e8 f2 17 00 00       	call   4072 <printf>

  if(mkdir("12345678901234") != 0){
    2880:	48 c7 c7 da 54 00 00 	mov    $0x54da,%rdi
    2887:	e8 8c 16 00 00       	call   3f18 <mkdir>
    288c:	85 c0                	test   %eax,%eax
    288e:	74 1b                	je     28ab <fourteen+0x4d>
    printf(1, "mkdir 12345678901234 failed\n");
    2890:	48 c7 c6 e9 54 00 00 	mov    $0x54e9,%rsi
    2897:	bf 01 00 00 00       	mov    $0x1,%edi
    289c:	b8 00 00 00 00       	mov    $0x0,%eax
    28a1:	e8 cc 17 00 00       	call   4072 <printf>
    exit();
    28a6:	e8 05 16 00 00       	call   3eb0 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    28ab:	48 c7 c7 08 55 00 00 	mov    $0x5508,%rdi
    28b2:	e8 61 16 00 00       	call   3f18 <mkdir>
    28b7:	85 c0                	test   %eax,%eax
    28b9:	74 1b                	je     28d6 <fourteen+0x78>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    28bb:	48 c7 c6 28 55 00 00 	mov    $0x5528,%rsi
    28c2:	bf 01 00 00 00       	mov    $0x1,%edi
    28c7:	b8 00 00 00 00       	mov    $0x0,%eax
    28cc:	e8 a1 17 00 00       	call   4072 <printf>
    exit();
    28d1:	e8 da 15 00 00       	call   3eb0 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    28d6:	be 00 02 00 00       	mov    $0x200,%esi
    28db:	48 c7 c7 58 55 00 00 	mov    $0x5558,%rdi
    28e2:	e8 09 16 00 00       	call   3ef0 <open>
    28e7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    28ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    28ee:	79 1b                	jns    290b <fourteen+0xad>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    28f0:	48 c7 c6 88 55 00 00 	mov    $0x5588,%rsi
    28f7:	bf 01 00 00 00       	mov    $0x1,%edi
    28fc:	b8 00 00 00 00       	mov    $0x0,%eax
    2901:	e8 6c 17 00 00       	call   4072 <printf>
    exit();
    2906:	e8 a5 15 00 00       	call   3eb0 <exit>
  }
  close(fd);
    290b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    290e:	89 c7                	mov    %eax,%edi
    2910:	e8 c3 15 00 00       	call   3ed8 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2915:	be 00 00 00 00       	mov    $0x0,%esi
    291a:	48 c7 c7 c8 55 00 00 	mov    $0x55c8,%rdi
    2921:	e8 ca 15 00 00       	call   3ef0 <open>
    2926:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2929:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    292d:	79 1b                	jns    294a <fourteen+0xec>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    292f:	48 c7 c6 f8 55 00 00 	mov    $0x55f8,%rsi
    2936:	bf 01 00 00 00       	mov    $0x1,%edi
    293b:	b8 00 00 00 00       	mov    $0x0,%eax
    2940:	e8 2d 17 00 00       	call   4072 <printf>
    exit();
    2945:	e8 66 15 00 00       	call   3eb0 <exit>
  }
  close(fd);
    294a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    294d:	89 c7                	mov    %eax,%edi
    294f:	e8 84 15 00 00       	call   3ed8 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2954:	48 c7 c7 32 56 00 00 	mov    $0x5632,%rdi
    295b:	e8 b8 15 00 00       	call   3f18 <mkdir>
    2960:	85 c0                	test   %eax,%eax
    2962:	75 1b                	jne    297f <fourteen+0x121>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2964:	48 c7 c6 50 56 00 00 	mov    $0x5650,%rsi
    296b:	bf 01 00 00 00       	mov    $0x1,%edi
    2970:	b8 00 00 00 00       	mov    $0x0,%eax
    2975:	e8 f8 16 00 00       	call   4072 <printf>
    exit();
    297a:	e8 31 15 00 00       	call   3eb0 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    297f:	48 c7 c7 80 56 00 00 	mov    $0x5680,%rdi
    2986:	e8 8d 15 00 00       	call   3f18 <mkdir>
    298b:	85 c0                	test   %eax,%eax
    298d:	75 1b                	jne    29aa <fourteen+0x14c>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    298f:	48 c7 c6 a0 56 00 00 	mov    $0x56a0,%rsi
    2996:	bf 01 00 00 00       	mov    $0x1,%edi
    299b:	b8 00 00 00 00       	mov    $0x0,%eax
    29a0:	e8 cd 16 00 00       	call   4072 <printf>
    exit();
    29a5:	e8 06 15 00 00       	call   3eb0 <exit>
  }

  printf(1, "fourteen ok\n");
    29aa:	48 c7 c6 d1 56 00 00 	mov    $0x56d1,%rsi
    29b1:	bf 01 00 00 00       	mov    $0x1,%edi
    29b6:	b8 00 00 00 00       	mov    $0x0,%eax
    29bb:	e8 b2 16 00 00       	call   4072 <printf>
}
    29c0:	90                   	nop
    29c1:	c9                   	leave
    29c2:	c3                   	ret

00000000000029c3 <rmdot>:

void
rmdot(void)
{
    29c3:	f3 0f 1e fa          	endbr64
    29c7:	55                   	push   %rbp
    29c8:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "rmdot test\n");
    29cb:	48 c7 c6 de 56 00 00 	mov    $0x56de,%rsi
    29d2:	bf 01 00 00 00       	mov    $0x1,%edi
    29d7:	b8 00 00 00 00       	mov    $0x0,%eax
    29dc:	e8 91 16 00 00       	call   4072 <printf>
  if(mkdir("dots") != 0){
    29e1:	48 c7 c7 ea 56 00 00 	mov    $0x56ea,%rdi
    29e8:	e8 2b 15 00 00       	call   3f18 <mkdir>
    29ed:	85 c0                	test   %eax,%eax
    29ef:	74 1b                	je     2a0c <rmdot+0x49>
    printf(1, "mkdir dots failed\n");
    29f1:	48 c7 c6 ef 56 00 00 	mov    $0x56ef,%rsi
    29f8:	bf 01 00 00 00       	mov    $0x1,%edi
    29fd:	b8 00 00 00 00       	mov    $0x0,%eax
    2a02:	e8 6b 16 00 00       	call   4072 <printf>
    exit();
    2a07:	e8 a4 14 00 00       	call   3eb0 <exit>
  }
  if(chdir("dots") != 0){
    2a0c:	48 c7 c7 ea 56 00 00 	mov    $0x56ea,%rdi
    2a13:	e8 08 15 00 00       	call   3f20 <chdir>
    2a18:	85 c0                	test   %eax,%eax
    2a1a:	74 1b                	je     2a37 <rmdot+0x74>
    printf(1, "chdir dots failed\n");
    2a1c:	48 c7 c6 02 57 00 00 	mov    $0x5702,%rsi
    2a23:	bf 01 00 00 00       	mov    $0x1,%edi
    2a28:	b8 00 00 00 00       	mov    $0x0,%eax
    2a2d:	e8 40 16 00 00       	call   4072 <printf>
    exit();
    2a32:	e8 79 14 00 00       	call   3eb0 <exit>
  }
  if(unlink(".") == 0){
    2a37:	48 c7 c7 03 4e 00 00 	mov    $0x4e03,%rdi
    2a3e:	e8 bd 14 00 00       	call   3f00 <unlink>
    2a43:	85 c0                	test   %eax,%eax
    2a45:	75 1b                	jne    2a62 <rmdot+0x9f>
    printf(1, "rm . worked!\n");
    2a47:	48 c7 c6 15 57 00 00 	mov    $0x5715,%rsi
    2a4e:	bf 01 00 00 00       	mov    $0x1,%edi
    2a53:	b8 00 00 00 00       	mov    $0x0,%eax
    2a58:	e8 15 16 00 00       	call   4072 <printf>
    exit();
    2a5d:	e8 4e 14 00 00       	call   3eb0 <exit>
  }
  if(unlink("..") == 0){
    2a62:	48 c7 c7 88 49 00 00 	mov    $0x4988,%rdi
    2a69:	e8 92 14 00 00       	call   3f00 <unlink>
    2a6e:	85 c0                	test   %eax,%eax
    2a70:	75 1b                	jne    2a8d <rmdot+0xca>
    printf(1, "rm .. worked!\n");
    2a72:	48 c7 c6 23 57 00 00 	mov    $0x5723,%rsi
    2a79:	bf 01 00 00 00       	mov    $0x1,%edi
    2a7e:	b8 00 00 00 00       	mov    $0x0,%eax
    2a83:	e8 ea 15 00 00       	call   4072 <printf>
    exit();
    2a88:	e8 23 14 00 00       	call   3eb0 <exit>
  }
  if(chdir("/") != 0){
    2a8d:	48 c7 c7 32 57 00 00 	mov    $0x5732,%rdi
    2a94:	e8 87 14 00 00       	call   3f20 <chdir>
    2a99:	85 c0                	test   %eax,%eax
    2a9b:	74 1b                	je     2ab8 <rmdot+0xf5>
    printf(1, "chdir / failed\n");
    2a9d:	48 c7 c6 34 57 00 00 	mov    $0x5734,%rsi
    2aa4:	bf 01 00 00 00       	mov    $0x1,%edi
    2aa9:	b8 00 00 00 00       	mov    $0x0,%eax
    2aae:	e8 bf 15 00 00       	call   4072 <printf>
    exit();
    2ab3:	e8 f8 13 00 00       	call   3eb0 <exit>
  }
  if(unlink("dots/.") == 0){
    2ab8:	48 c7 c7 44 57 00 00 	mov    $0x5744,%rdi
    2abf:	e8 3c 14 00 00       	call   3f00 <unlink>
    2ac4:	85 c0                	test   %eax,%eax
    2ac6:	75 1b                	jne    2ae3 <rmdot+0x120>
    printf(1, "unlink dots/. worked!\n");
    2ac8:	48 c7 c6 4b 57 00 00 	mov    $0x574b,%rsi
    2acf:	bf 01 00 00 00       	mov    $0x1,%edi
    2ad4:	b8 00 00 00 00       	mov    $0x0,%eax
    2ad9:	e8 94 15 00 00       	call   4072 <printf>
    exit();
    2ade:	e8 cd 13 00 00       	call   3eb0 <exit>
  }
  if(unlink("dots/..") == 0){
    2ae3:	48 c7 c7 62 57 00 00 	mov    $0x5762,%rdi
    2aea:	e8 11 14 00 00       	call   3f00 <unlink>
    2aef:	85 c0                	test   %eax,%eax
    2af1:	75 1b                	jne    2b0e <rmdot+0x14b>
    printf(1, "unlink dots/.. worked!\n");
    2af3:	48 c7 c6 6a 57 00 00 	mov    $0x576a,%rsi
    2afa:	bf 01 00 00 00       	mov    $0x1,%edi
    2aff:	b8 00 00 00 00       	mov    $0x0,%eax
    2b04:	e8 69 15 00 00       	call   4072 <printf>
    exit();
    2b09:	e8 a2 13 00 00       	call   3eb0 <exit>
  }
  if(unlink("dots") != 0){
    2b0e:	48 c7 c7 ea 56 00 00 	mov    $0x56ea,%rdi
    2b15:	e8 e6 13 00 00       	call   3f00 <unlink>
    2b1a:	85 c0                	test   %eax,%eax
    2b1c:	74 1b                	je     2b39 <rmdot+0x176>
    printf(1, "unlink dots failed!\n");
    2b1e:	48 c7 c6 82 57 00 00 	mov    $0x5782,%rsi
    2b25:	bf 01 00 00 00       	mov    $0x1,%edi
    2b2a:	b8 00 00 00 00       	mov    $0x0,%eax
    2b2f:	e8 3e 15 00 00       	call   4072 <printf>
    exit();
    2b34:	e8 77 13 00 00       	call   3eb0 <exit>
  }
  printf(1, "rmdot ok\n");
    2b39:	48 c7 c6 97 57 00 00 	mov    $0x5797,%rsi
    2b40:	bf 01 00 00 00       	mov    $0x1,%edi
    2b45:	b8 00 00 00 00       	mov    $0x0,%eax
    2b4a:	e8 23 15 00 00       	call   4072 <printf>
}
    2b4f:	90                   	nop
    2b50:	5d                   	pop    %rbp
    2b51:	c3                   	ret

0000000000002b52 <dirfile>:

void
dirfile(void)
{
    2b52:	f3 0f 1e fa          	endbr64
    2b56:	55                   	push   %rbp
    2b57:	48 89 e5             	mov    %rsp,%rbp
    2b5a:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "dir vs file\n");
    2b5e:	48 c7 c6 a1 57 00 00 	mov    $0x57a1,%rsi
    2b65:	bf 01 00 00 00       	mov    $0x1,%edi
    2b6a:	b8 00 00 00 00       	mov    $0x0,%eax
    2b6f:	e8 fe 14 00 00       	call   4072 <printf>

  fd = open("dirfile", O_CREATE);
    2b74:	be 00 02 00 00       	mov    $0x200,%esi
    2b79:	48 c7 c7 ae 57 00 00 	mov    $0x57ae,%rdi
    2b80:	e8 6b 13 00 00       	call   3ef0 <open>
    2b85:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2b88:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2b8c:	79 1b                	jns    2ba9 <dirfile+0x57>
    printf(1, "create dirfile failed\n");
    2b8e:	48 c7 c6 b6 57 00 00 	mov    $0x57b6,%rsi
    2b95:	bf 01 00 00 00       	mov    $0x1,%edi
    2b9a:	b8 00 00 00 00       	mov    $0x0,%eax
    2b9f:	e8 ce 14 00 00       	call   4072 <printf>
    exit();
    2ba4:	e8 07 13 00 00       	call   3eb0 <exit>
  }
  close(fd);
    2ba9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2bac:	89 c7                	mov    %eax,%edi
    2bae:	e8 25 13 00 00       	call   3ed8 <close>
  if(chdir("dirfile") == 0){
    2bb3:	48 c7 c7 ae 57 00 00 	mov    $0x57ae,%rdi
    2bba:	e8 61 13 00 00       	call   3f20 <chdir>
    2bbf:	85 c0                	test   %eax,%eax
    2bc1:	75 1b                	jne    2bde <dirfile+0x8c>
    printf(1, "chdir dirfile succeeded!\n");
    2bc3:	48 c7 c6 cd 57 00 00 	mov    $0x57cd,%rsi
    2bca:	bf 01 00 00 00       	mov    $0x1,%edi
    2bcf:	b8 00 00 00 00       	mov    $0x0,%eax
    2bd4:	e8 99 14 00 00       	call   4072 <printf>
    exit();
    2bd9:	e8 d2 12 00 00       	call   3eb0 <exit>
  }
  fd = open("dirfile/xx", 0);
    2bde:	be 00 00 00 00       	mov    $0x0,%esi
    2be3:	48 c7 c7 e7 57 00 00 	mov    $0x57e7,%rdi
    2bea:	e8 01 13 00 00       	call   3ef0 <open>
    2bef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2bf2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2bf6:	78 1b                	js     2c13 <dirfile+0xc1>
    printf(1, "create dirfile/xx succeeded!\n");
    2bf8:	48 c7 c6 f2 57 00 00 	mov    $0x57f2,%rsi
    2bff:	bf 01 00 00 00       	mov    $0x1,%edi
    2c04:	b8 00 00 00 00       	mov    $0x0,%eax
    2c09:	e8 64 14 00 00       	call   4072 <printf>
    exit();
    2c0e:	e8 9d 12 00 00       	call   3eb0 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2c13:	be 00 02 00 00       	mov    $0x200,%esi
    2c18:	48 c7 c7 e7 57 00 00 	mov    $0x57e7,%rdi
    2c1f:	e8 cc 12 00 00       	call   3ef0 <open>
    2c24:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2c27:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2c2b:	78 1b                	js     2c48 <dirfile+0xf6>
    printf(1, "create dirfile/xx succeeded!\n");
    2c2d:	48 c7 c6 f2 57 00 00 	mov    $0x57f2,%rsi
    2c34:	bf 01 00 00 00       	mov    $0x1,%edi
    2c39:	b8 00 00 00 00       	mov    $0x0,%eax
    2c3e:	e8 2f 14 00 00       	call   4072 <printf>
    exit();
    2c43:	e8 68 12 00 00       	call   3eb0 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2c48:	48 c7 c7 e7 57 00 00 	mov    $0x57e7,%rdi
    2c4f:	e8 c4 12 00 00       	call   3f18 <mkdir>
    2c54:	85 c0                	test   %eax,%eax
    2c56:	75 1b                	jne    2c73 <dirfile+0x121>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2c58:	48 c7 c6 10 58 00 00 	mov    $0x5810,%rsi
    2c5f:	bf 01 00 00 00       	mov    $0x1,%edi
    2c64:	b8 00 00 00 00       	mov    $0x0,%eax
    2c69:	e8 04 14 00 00       	call   4072 <printf>
    exit();
    2c6e:	e8 3d 12 00 00       	call   3eb0 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2c73:	48 c7 c7 e7 57 00 00 	mov    $0x57e7,%rdi
    2c7a:	e8 81 12 00 00       	call   3f00 <unlink>
    2c7f:	85 c0                	test   %eax,%eax
    2c81:	75 1b                	jne    2c9e <dirfile+0x14c>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2c83:	48 c7 c6 2d 58 00 00 	mov    $0x582d,%rsi
    2c8a:	bf 01 00 00 00       	mov    $0x1,%edi
    2c8f:	b8 00 00 00 00       	mov    $0x0,%eax
    2c94:	e8 d9 13 00 00       	call   4072 <printf>
    exit();
    2c99:	e8 12 12 00 00       	call   3eb0 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2c9e:	48 c7 c6 e7 57 00 00 	mov    $0x57e7,%rsi
    2ca5:	48 c7 c7 4b 58 00 00 	mov    $0x584b,%rdi
    2cac:	e8 5f 12 00 00       	call   3f10 <link>
    2cb1:	85 c0                	test   %eax,%eax
    2cb3:	75 1b                	jne    2cd0 <dirfile+0x17e>
    printf(1, "link to dirfile/xx succeeded!\n");
    2cb5:	48 c7 c6 58 58 00 00 	mov    $0x5858,%rsi
    2cbc:	bf 01 00 00 00       	mov    $0x1,%edi
    2cc1:	b8 00 00 00 00       	mov    $0x0,%eax
    2cc6:	e8 a7 13 00 00       	call   4072 <printf>
    exit();
    2ccb:	e8 e0 11 00 00       	call   3eb0 <exit>
  }
  if(unlink("dirfile") != 0){
    2cd0:	48 c7 c7 ae 57 00 00 	mov    $0x57ae,%rdi
    2cd7:	e8 24 12 00 00       	call   3f00 <unlink>
    2cdc:	85 c0                	test   %eax,%eax
    2cde:	74 1b                	je     2cfb <dirfile+0x1a9>
    printf(1, "unlink dirfile failed!\n");
    2ce0:	48 c7 c6 77 58 00 00 	mov    $0x5877,%rsi
    2ce7:	bf 01 00 00 00       	mov    $0x1,%edi
    2cec:	b8 00 00 00 00       	mov    $0x0,%eax
    2cf1:	e8 7c 13 00 00       	call   4072 <printf>
    exit();
    2cf6:	e8 b5 11 00 00       	call   3eb0 <exit>
  }

  fd = open(".", O_RDWR);
    2cfb:	be 02 00 00 00       	mov    $0x2,%esi
    2d00:	48 c7 c7 03 4e 00 00 	mov    $0x4e03,%rdi
    2d07:	e8 e4 11 00 00       	call   3ef0 <open>
    2d0c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2d0f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2d13:	78 1b                	js     2d30 <dirfile+0x1de>
    printf(1, "open . for writing succeeded!\n");
    2d15:	48 c7 c6 90 58 00 00 	mov    $0x5890,%rsi
    2d1c:	bf 01 00 00 00       	mov    $0x1,%edi
    2d21:	b8 00 00 00 00       	mov    $0x0,%eax
    2d26:	e8 47 13 00 00       	call   4072 <printf>
    exit();
    2d2b:	e8 80 11 00 00       	call   3eb0 <exit>
  }
  fd = open(".", 0);
    2d30:	be 00 00 00 00       	mov    $0x0,%esi
    2d35:	48 c7 c7 03 4e 00 00 	mov    $0x4e03,%rdi
    2d3c:	e8 af 11 00 00       	call   3ef0 <open>
    2d41:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(write(fd, "x", 1) > 0){
    2d44:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d47:	ba 01 00 00 00       	mov    $0x1,%edx
    2d4c:	48 c7 c6 32 4a 00 00 	mov    $0x4a32,%rsi
    2d53:	89 c7                	mov    %eax,%edi
    2d55:	e8 76 11 00 00       	call   3ed0 <write>
    2d5a:	85 c0                	test   %eax,%eax
    2d5c:	7e 1b                	jle    2d79 <dirfile+0x227>
    printf(1, "write . succeeded!\n");
    2d5e:	48 c7 c6 af 58 00 00 	mov    $0x58af,%rsi
    2d65:	bf 01 00 00 00       	mov    $0x1,%edi
    2d6a:	b8 00 00 00 00       	mov    $0x0,%eax
    2d6f:	e8 fe 12 00 00       	call   4072 <printf>
    exit();
    2d74:	e8 37 11 00 00       	call   3eb0 <exit>
  }
  close(fd);
    2d79:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d7c:	89 c7                	mov    %eax,%edi
    2d7e:	e8 55 11 00 00       	call   3ed8 <close>

  printf(1, "dir vs file OK\n");
    2d83:	48 c7 c6 c3 58 00 00 	mov    $0x58c3,%rsi
    2d8a:	bf 01 00 00 00       	mov    $0x1,%edi
    2d8f:	b8 00 00 00 00       	mov    $0x0,%eax
    2d94:	e8 d9 12 00 00       	call   4072 <printf>
}
    2d99:	90                   	nop
    2d9a:	c9                   	leave
    2d9b:	c3                   	ret

0000000000002d9c <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2d9c:	f3 0f 1e fa          	endbr64
    2da0:	55                   	push   %rbp
    2da1:	48 89 e5             	mov    %rsp,%rbp
    2da4:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "empty file name\n");
    2da8:	48 c7 c6 d3 58 00 00 	mov    $0x58d3,%rsi
    2daf:	bf 01 00 00 00       	mov    $0x1,%edi
    2db4:	b8 00 00 00 00       	mov    $0x0,%eax
    2db9:	e8 b4 12 00 00       	call   4072 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2dbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2dc5:	e9 cd 00 00 00       	jmp    2e97 <iref+0xfb>
    if(mkdir("irefd") != 0){
    2dca:	48 c7 c7 e4 58 00 00 	mov    $0x58e4,%rdi
    2dd1:	e8 42 11 00 00       	call   3f18 <mkdir>
    2dd6:	85 c0                	test   %eax,%eax
    2dd8:	74 1b                	je     2df5 <iref+0x59>
      printf(1, "mkdir irefd failed\n");
    2dda:	48 c7 c6 ea 58 00 00 	mov    $0x58ea,%rsi
    2de1:	bf 01 00 00 00       	mov    $0x1,%edi
    2de6:	b8 00 00 00 00       	mov    $0x0,%eax
    2deb:	e8 82 12 00 00       	call   4072 <printf>
      exit();
    2df0:	e8 bb 10 00 00       	call   3eb0 <exit>
    }
    if(chdir("irefd") != 0){
    2df5:	48 c7 c7 e4 58 00 00 	mov    $0x58e4,%rdi
    2dfc:	e8 1f 11 00 00       	call   3f20 <chdir>
    2e01:	85 c0                	test   %eax,%eax
    2e03:	74 1b                	je     2e20 <iref+0x84>
      printf(1, "chdir irefd failed\n");
    2e05:	48 c7 c6 fe 58 00 00 	mov    $0x58fe,%rsi
    2e0c:	bf 01 00 00 00       	mov    $0x1,%edi
    2e11:	b8 00 00 00 00       	mov    $0x0,%eax
    2e16:	e8 57 12 00 00       	call   4072 <printf>
      exit();
    2e1b:	e8 90 10 00 00       	call   3eb0 <exit>
    }

    mkdir("");
    2e20:	48 c7 c7 12 59 00 00 	mov    $0x5912,%rdi
    2e27:	e8 ec 10 00 00       	call   3f18 <mkdir>
    link("README", "");
    2e2c:	48 c7 c6 12 59 00 00 	mov    $0x5912,%rsi
    2e33:	48 c7 c7 4b 58 00 00 	mov    $0x584b,%rdi
    2e3a:	e8 d1 10 00 00       	call   3f10 <link>
    fd = open("", O_CREATE);
    2e3f:	be 00 02 00 00       	mov    $0x200,%esi
    2e44:	48 c7 c7 12 59 00 00 	mov    $0x5912,%rdi
    2e4b:	e8 a0 10 00 00       	call   3ef0 <open>
    2e50:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    2e53:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2e57:	78 0a                	js     2e63 <iref+0xc7>
      close(fd);
    2e59:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2e5c:	89 c7                	mov    %eax,%edi
    2e5e:	e8 75 10 00 00       	call   3ed8 <close>
    fd = open("xx", O_CREATE);
    2e63:	be 00 02 00 00       	mov    $0x200,%esi
    2e68:	48 c7 c7 13 59 00 00 	mov    $0x5913,%rdi
    2e6f:	e8 7c 10 00 00       	call   3ef0 <open>
    2e74:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    2e77:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2e7b:	78 0a                	js     2e87 <iref+0xeb>
      close(fd);
    2e7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2e80:	89 c7                	mov    %eax,%edi
    2e82:	e8 51 10 00 00       	call   3ed8 <close>
    unlink("xx");
    2e87:	48 c7 c7 13 59 00 00 	mov    $0x5913,%rdi
    2e8e:	e8 6d 10 00 00       	call   3f00 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2e93:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2e97:	83 7d fc 32          	cmpl   $0x32,-0x4(%rbp)
    2e9b:	0f 8e 29 ff ff ff    	jle    2dca <iref+0x2e>
  }

  chdir("/");
    2ea1:	48 c7 c7 32 57 00 00 	mov    $0x5732,%rdi
    2ea8:	e8 73 10 00 00       	call   3f20 <chdir>
  printf(1, "empty file name OK\n");
    2ead:	48 c7 c6 16 59 00 00 	mov    $0x5916,%rsi
    2eb4:	bf 01 00 00 00       	mov    $0x1,%edi
    2eb9:	b8 00 00 00 00       	mov    $0x0,%eax
    2ebe:	e8 af 11 00 00       	call   4072 <printf>
}
    2ec3:	90                   	nop
    2ec4:	c9                   	leave
    2ec5:	c3                   	ret

0000000000002ec6 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2ec6:	f3 0f 1e fa          	endbr64
    2eca:	55                   	push   %rbp
    2ecb:	48 89 e5             	mov    %rsp,%rbp
    2ece:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
    2ed2:	48 c7 c6 2a 59 00 00 	mov    $0x592a,%rsi
    2ed9:	bf 01 00 00 00       	mov    $0x1,%edi
    2ede:	b8 00 00 00 00       	mov    $0x0,%eax
    2ee3:	e8 8a 11 00 00       	call   4072 <printf>

  for(n=0; n<1000; n++){
    2ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2eef:	eb 1d                	jmp    2f0e <forktest+0x48>
    pid = fork();
    2ef1:	e8 b2 0f 00 00       	call   3ea8 <fork>
    2ef6:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
    2ef9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2efd:	78 1a                	js     2f19 <forktest+0x53>
      break;
    if(pid == 0)
    2eff:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2f03:	75 05                	jne    2f0a <forktest+0x44>
      exit();
    2f05:	e8 a6 0f 00 00       	call   3eb0 <exit>
  for(n=0; n<1000; n++){
    2f0a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2f0e:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    2f15:	7e da                	jle    2ef1 <forktest+0x2b>
    2f17:	eb 01                	jmp    2f1a <forktest+0x54>
      break;
    2f19:	90                   	nop
  }
  
  if(n == 1000){
    2f1a:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    2f21:	75 43                	jne    2f66 <forktest+0xa0>
    printf(1, "fork claimed to work 1000 times!\n");
    2f23:	48 c7 c6 38 59 00 00 	mov    $0x5938,%rsi
    2f2a:	bf 01 00 00 00       	mov    $0x1,%edi
    2f2f:	b8 00 00 00 00       	mov    $0x0,%eax
    2f34:	e8 39 11 00 00       	call   4072 <printf>
    exit();
    2f39:	e8 72 0f 00 00       	call   3eb0 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2f3e:	e8 75 0f 00 00       	call   3eb8 <wait>
    2f43:	85 c0                	test   %eax,%eax
    2f45:	79 1b                	jns    2f62 <forktest+0x9c>
      printf(1, "wait stopped early\n");
    2f47:	48 c7 c6 5a 59 00 00 	mov    $0x595a,%rsi
    2f4e:	bf 01 00 00 00       	mov    $0x1,%edi
    2f53:	b8 00 00 00 00       	mov    $0x0,%eax
    2f58:	e8 15 11 00 00       	call   4072 <printf>
      exit();
    2f5d:	e8 4e 0f 00 00       	call   3eb0 <exit>
  for(; n > 0; n--){
    2f62:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    2f66:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2f6a:	7f d2                	jg     2f3e <forktest+0x78>
    }
  }
  
  if(wait() != -1){
    2f6c:	e8 47 0f 00 00       	call   3eb8 <wait>
    2f71:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f74:	74 1b                	je     2f91 <forktest+0xcb>
    printf(1, "wait got too many\n");
    2f76:	48 c7 c6 6e 59 00 00 	mov    $0x596e,%rsi
    2f7d:	bf 01 00 00 00       	mov    $0x1,%edi
    2f82:	b8 00 00 00 00       	mov    $0x0,%eax
    2f87:	e8 e6 10 00 00       	call   4072 <printf>
    exit();
    2f8c:	e8 1f 0f 00 00       	call   3eb0 <exit>
  }
  
  printf(1, "fork test OK\n");
    2f91:	48 c7 c6 81 59 00 00 	mov    $0x5981,%rsi
    2f98:	bf 01 00 00 00       	mov    $0x1,%edi
    2f9d:	b8 00 00 00 00       	mov    $0x0,%eax
    2fa2:	e8 cb 10 00 00       	call   4072 <printf>
}
    2fa7:	90                   	nop
    2fa8:	c9                   	leave
    2fa9:	c3                   	ret

0000000000002faa <sbrktest>:

void
sbrktest(void)
{
    2faa:	f3 0f 1e fa          	endbr64
    2fae:	55                   	push   %rbp
    2faf:	48 89 e5             	mov    %rsp,%rbp
    2fb2:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2fb9:	8b 05 49 34 00 00    	mov    0x3449(%rip),%eax        # 6408 <stdout>
    2fbf:	48 c7 c6 8f 59 00 00 	mov    $0x598f,%rsi
    2fc6:	89 c7                	mov    %eax,%edi
    2fc8:	b8 00 00 00 00       	mov    $0x0,%eax
    2fcd:	e8 a0 10 00 00       	call   4072 <printf>
  oldbrk = sbrk(0);
    2fd2:	bf 00 00 00 00       	mov    $0x0,%edi
    2fd7:	e8 5c 0f 00 00       	call   3f38 <sbrk>
    2fdc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2fe0:	bf 00 00 00 00       	mov    $0x0,%edi
    2fe5:	e8 4e 0f 00 00       	call   3f38 <sbrk>
    2fea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2fee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    2ff5:	eb 5b                	jmp    3052 <sbrktest+0xa8>
    b = sbrk(1);
    2ff7:	bf 01 00 00 00       	mov    $0x1,%edi
    2ffc:	e8 37 0f 00 00       	call   3f38 <sbrk>
    3001:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if(b != a){
    3005:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    3009:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    300d:	74 2c                	je     303b <sbrktest+0x91>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    300f:	8b 05 f3 33 00 00    	mov    0x33f3(%rip),%eax        # 6408 <stdout>
    3015:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
    3019:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    301d:	8b 55 f4             	mov    -0xc(%rbp),%edx
    3020:	49 89 f0             	mov    %rsi,%r8
    3023:	48 c7 c6 9a 59 00 00 	mov    $0x599a,%rsi
    302a:	89 c7                	mov    %eax,%edi
    302c:	b8 00 00 00 00       	mov    $0x0,%eax
    3031:	e8 3c 10 00 00       	call   4072 <printf>
      exit();
    3036:	e8 75 0e 00 00       	call   3eb0 <exit>
    }
    *b = 1;
    303b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    303f:	c6 00 01             	movb   $0x1,(%rax)
    a = b + 1;
    3042:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    3046:	48 83 c0 01          	add    $0x1,%rax
    304a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(i = 0; i < 5000; i++){ 
    304e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    3052:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%rbp)
    3059:	7e 9c                	jle    2ff7 <sbrktest+0x4d>
  }
  pid = fork();
    305b:	e8 48 0e 00 00       	call   3ea8 <fork>
    3060:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(pid < 0){
    3063:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    3067:	79 1e                	jns    3087 <sbrktest+0xdd>
    printf(stdout, "sbrk test fork failed\n");
    3069:	8b 05 99 33 00 00    	mov    0x3399(%rip),%eax        # 6408 <stdout>
    306f:	48 c7 c6 b5 59 00 00 	mov    $0x59b5,%rsi
    3076:	89 c7                	mov    %eax,%edi
    3078:	b8 00 00 00 00       	mov    $0x0,%eax
    307d:	e8 f0 0f 00 00       	call   4072 <printf>
    exit();
    3082:	e8 29 0e 00 00       	call   3eb0 <exit>
  }
  c = sbrk(1);
    3087:	bf 01 00 00 00       	mov    $0x1,%edi
    308c:	e8 a7 0e 00 00       	call   3f38 <sbrk>
    3091:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  c = sbrk(1);
    3095:	bf 01 00 00 00       	mov    $0x1,%edi
    309a:	e8 99 0e 00 00       	call   3f38 <sbrk>
    309f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a + 1){
    30a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    30a7:	48 83 c0 01          	add    $0x1,%rax
    30ab:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    30af:	74 1e                	je     30cf <sbrktest+0x125>
    printf(stdout, "sbrk test failed post-fork\n");
    30b1:	8b 05 51 33 00 00    	mov    0x3351(%rip),%eax        # 6408 <stdout>
    30b7:	48 c7 c6 cc 59 00 00 	mov    $0x59cc,%rsi
    30be:	89 c7                	mov    %eax,%edi
    30c0:	b8 00 00 00 00       	mov    $0x0,%eax
    30c5:	e8 a8 0f 00 00       	call   4072 <printf>
    exit();
    30ca:	e8 e1 0d 00 00       	call   3eb0 <exit>
  }
  if(pid == 0)
    30cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    30d3:	75 05                	jne    30da <sbrktest+0x130>
    exit();
    30d5:	e8 d6 0d 00 00       	call   3eb0 <exit>
  wait();
    30da:	e8 d9 0d 00 00       	call   3eb8 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    30df:	bf 00 00 00 00       	mov    $0x0,%edi
    30e4:	e8 4f 0e 00 00       	call   3f38 <sbrk>
    30e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  amt = (BIG) - (uint)a;
    30ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    30f1:	89 c2                	mov    %eax,%edx
    30f3:	b8 00 00 40 06       	mov    $0x6400000,%eax
    30f8:	29 d0                	sub    %edx,%eax
    30fa:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  p = sbrk(amt);
    30fd:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    3100:	89 c7                	mov    %eax,%edi
    3102:	e8 31 0e 00 00       	call   3f38 <sbrk>
    3107:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  if (p != a) { 
    310b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    310f:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    3113:	74 1e                	je     3133 <sbrktest+0x189>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3115:	8b 05 ed 32 00 00    	mov    0x32ed(%rip),%eax        # 6408 <stdout>
    311b:	48 c7 c6 e8 59 00 00 	mov    $0x59e8,%rsi
    3122:	89 c7                	mov    %eax,%edi
    3124:	b8 00 00 00 00       	mov    $0x0,%eax
    3129:	e8 44 0f 00 00       	call   4072 <printf>
    exit();
    312e:	e8 7d 0d 00 00       	call   3eb0 <exit>
  }
  lastaddr = (char*) (BIG-1);
    3133:	48 c7 45 c0 ff ff 3f 	movq   $0x63fffff,-0x40(%rbp)
    313a:	06 
  *lastaddr = 99;
    313b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    313f:	c6 00 63             	movb   $0x63,(%rax)

  // can one de-allocate?
  a = sbrk(0);
    3142:	bf 00 00 00 00       	mov    $0x0,%edi
    3147:	e8 ec 0d 00 00       	call   3f38 <sbrk>
    314c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-4096);
    3150:	bf 00 f0 ff ff       	mov    $0xfffff000,%edi
    3155:	e8 de 0d 00 00       	call   3f38 <sbrk>
    315a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c == (char*)0xffffffff){
    315e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3163:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    3167:	75 1e                	jne    3187 <sbrktest+0x1dd>
    printf(stdout, "sbrk could not deallocate\n");
    3169:	8b 05 99 32 00 00    	mov    0x3299(%rip),%eax        # 6408 <stdout>
    316f:	48 c7 c6 26 5a 00 00 	mov    $0x5a26,%rsi
    3176:	89 c7                	mov    %eax,%edi
    3178:	b8 00 00 00 00       	mov    $0x0,%eax
    317d:	e8 f0 0e 00 00       	call   4072 <printf>
    exit();
    3182:	e8 29 0d 00 00       	call   3eb0 <exit>
  }
  c = sbrk(0);
    3187:	bf 00 00 00 00       	mov    $0x0,%edi
    318c:	e8 a7 0d 00 00       	call   3f38 <sbrk>
    3191:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a - 4096){
    3195:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3199:	48 2d 00 10 00 00    	sub    $0x1000,%rax
    319f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    31a3:	74 26                	je     31cb <sbrktest+0x221>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    31a5:	8b 05 5d 32 00 00    	mov    0x325d(%rip),%eax        # 6408 <stdout>
    31ab:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    31af:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    31b3:	48 c7 c6 48 5a 00 00 	mov    $0x5a48,%rsi
    31ba:	89 c7                	mov    %eax,%edi
    31bc:	b8 00 00 00 00       	mov    $0x0,%eax
    31c1:	e8 ac 0e 00 00       	call   4072 <printf>
    exit();
    31c6:	e8 e5 0c 00 00       	call   3eb0 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    31cb:	bf 00 00 00 00       	mov    $0x0,%edi
    31d0:	e8 63 0d 00 00       	call   3f38 <sbrk>
    31d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(4096);
    31d9:	bf 00 10 00 00       	mov    $0x1000,%edi
    31de:	e8 55 0d 00 00       	call   3f38 <sbrk>
    31e3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a || sbrk(0) != a + 4096){
    31e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    31eb:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    31ef:	75 1a                	jne    320b <sbrktest+0x261>
    31f1:	bf 00 00 00 00       	mov    $0x0,%edi
    31f6:	e8 3d 0d 00 00       	call   3f38 <sbrk>
    31fb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    31ff:	48 81 c2 00 10 00 00 	add    $0x1000,%rdx
    3206:	48 39 d0             	cmp    %rdx,%rax
    3209:	74 26                	je     3231 <sbrktest+0x287>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    320b:	8b 05 f7 31 00 00    	mov    0x31f7(%rip),%eax        # 6408 <stdout>
    3211:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    3215:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    3219:	48 c7 c6 80 5a 00 00 	mov    $0x5a80,%rsi
    3220:	89 c7                	mov    %eax,%edi
    3222:	b8 00 00 00 00       	mov    $0x0,%eax
    3227:	e8 46 0e 00 00       	call   4072 <printf>
    exit();
    322c:	e8 7f 0c 00 00       	call   3eb0 <exit>
  }
  if(*lastaddr == 99){
    3231:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    3235:	0f b6 00             	movzbl (%rax),%eax
    3238:	3c 63                	cmp    $0x63,%al
    323a:	75 1e                	jne    325a <sbrktest+0x2b0>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    323c:	8b 05 c6 31 00 00    	mov    0x31c6(%rip),%eax        # 6408 <stdout>
    3242:	48 c7 c6 a8 5a 00 00 	mov    $0x5aa8,%rsi
    3249:	89 c7                	mov    %eax,%edi
    324b:	b8 00 00 00 00       	mov    $0x0,%eax
    3250:	e8 1d 0e 00 00       	call   4072 <printf>
    exit();
    3255:	e8 56 0c 00 00       	call   3eb0 <exit>
  }

  a = sbrk(0);
    325a:	bf 00 00 00 00       	mov    $0x0,%edi
    325f:	e8 d4 0c 00 00       	call   3f38 <sbrk>
    3264:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-(sbrk(0) - oldbrk));
    3268:	bf 00 00 00 00       	mov    $0x0,%edi
    326d:	e8 c6 0c 00 00       	call   3f38 <sbrk>
    3272:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    3276:	48 29 c2             	sub    %rax,%rdx
    3279:	89 d0                	mov    %edx,%eax
    327b:	89 c7                	mov    %eax,%edi
    327d:	e8 b6 0c 00 00       	call   3f38 <sbrk>
    3282:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a){
    3286:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    328a:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    328e:	74 26                	je     32b6 <sbrktest+0x30c>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3290:	8b 05 72 31 00 00    	mov    0x3172(%rip),%eax        # 6408 <stdout>
    3296:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    329a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    329e:	48 c7 c6 d8 5a 00 00 	mov    $0x5ad8,%rsi
    32a5:	89 c7                	mov    %eax,%edi
    32a7:	b8 00 00 00 00       	mov    $0x0,%eax
    32ac:	e8 c1 0d 00 00       	call   4072 <printf>
    exit();
    32b1:	e8 fa 0b 00 00       	call   3eb0 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    32b6:	48 c7 45 f8 00 00 00 	movq   $0xffffffff80000000,-0x8(%rbp)
    32bd:	80 
    32be:	eb 7d                	jmp    333d <sbrktest+0x393>
    ppid = getpid();
    32c0:	e8 6b 0c 00 00       	call   3f30 <getpid>
    32c5:	89 45 bc             	mov    %eax,-0x44(%rbp)
    pid = fork();
    32c8:	e8 db 0b 00 00       	call   3ea8 <fork>
    32cd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if(pid < 0){
    32d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    32d4:	79 1e                	jns    32f4 <sbrktest+0x34a>
      printf(stdout, "fork failed\n");
    32d6:	8b 05 2c 31 00 00    	mov    0x312c(%rip),%eax        # 6408 <stdout>
    32dc:	48 c7 c6 79 4a 00 00 	mov    $0x4a79,%rsi
    32e3:	89 c7                	mov    %eax,%edi
    32e5:	b8 00 00 00 00       	mov    $0x0,%eax
    32ea:	e8 83 0d 00 00       	call   4072 <printf>
      exit();
    32ef:	e8 bc 0b 00 00       	call   3eb0 <exit>
    }
    if(pid == 0){
    32f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    32f8:	75 36                	jne    3330 <sbrktest+0x386>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    32fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    32fe:	0f b6 00             	movzbl (%rax),%eax
    3301:	0f be c8             	movsbl %al,%ecx
    3304:	8b 05 fe 30 00 00    	mov    0x30fe(%rip),%eax        # 6408 <stdout>
    330a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    330e:	48 c7 c6 f9 5a 00 00 	mov    $0x5af9,%rsi
    3315:	89 c7                	mov    %eax,%edi
    3317:	b8 00 00 00 00       	mov    $0x0,%eax
    331c:	e8 51 0d 00 00       	call   4072 <printf>
      kill(ppid);
    3321:	8b 45 bc             	mov    -0x44(%rbp),%eax
    3324:	89 c7                	mov    %eax,%edi
    3326:	e8 b5 0b 00 00       	call   3ee0 <kill>
      exit();
    332b:	e8 80 0b 00 00       	call   3eb0 <exit>
    }
    wait();
    3330:	e8 83 0b 00 00       	call   3eb8 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3335:	48 81 45 f8 50 c3 00 	addq   $0xc350,-0x8(%rbp)
    333c:	00 
    333d:	48 81 7d f8 7f 84 1e 	cmpq   $0xffffffff801e847f,-0x8(%rbp)
    3344:	80 
    3345:	0f 86 75 ff ff ff    	jbe    32c0 <sbrktest+0x316>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    334b:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    334f:	48 89 c7             	mov    %rax,%rdi
    3352:	e8 69 0b 00 00       	call   3ec0 <pipe>
    3357:	85 c0                	test   %eax,%eax
    3359:	74 1b                	je     3376 <sbrktest+0x3cc>
    printf(1, "pipe() failed\n");
    335b:	48 c7 c6 cd 49 00 00 	mov    $0x49cd,%rsi
    3362:	bf 01 00 00 00       	mov    $0x1,%edi
    3367:	b8 00 00 00 00       	mov    $0x0,%eax
    336c:	e8 01 0d 00 00       	call   4072 <printf>
    exit();
    3371:	e8 3a 0b 00 00       	call   3eb0 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3376:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    337d:	e9 83 00 00 00       	jmp    3405 <sbrktest+0x45b>
    if((pids[i] = fork()) == 0){
    3382:	e8 21 0b 00 00       	call   3ea8 <fork>
    3387:	8b 55 f4             	mov    -0xc(%rbp),%edx
    338a:	48 63 d2             	movslq %edx,%rdx
    338d:	89 44 95 80          	mov    %eax,-0x80(%rbp,%rdx,4)
    3391:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3394:	48 98                	cltq
    3396:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    339a:	85 c0                	test   %eax,%eax
    339c:	75 3c                	jne    33da <sbrktest+0x430>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    339e:	bf 00 00 00 00       	mov    $0x0,%edi
    33a3:	e8 90 0b 00 00       	call   3f38 <sbrk>
    33a8:	89 c2                	mov    %eax,%edx
    33aa:	b8 00 00 40 06       	mov    $0x6400000,%eax
    33af:	29 d0                	sub    %edx,%eax
    33b1:	89 c7                	mov    %eax,%edi
    33b3:	e8 80 0b 00 00       	call   3f38 <sbrk>
      write(fds[1], "x", 1);
    33b8:	8b 45 ac             	mov    -0x54(%rbp),%eax
    33bb:	ba 01 00 00 00       	mov    $0x1,%edx
    33c0:	48 c7 c6 32 4a 00 00 	mov    $0x4a32,%rsi
    33c7:	89 c7                	mov    %eax,%edi
    33c9:	e8 02 0b 00 00       	call   3ed0 <write>
      // sit around until killed
      for(;;) sleep(1000);
    33ce:	bf e8 03 00 00       	mov    $0x3e8,%edi
    33d3:	e8 68 0b 00 00       	call   3f40 <sleep>
    33d8:	eb f4                	jmp    33ce <sbrktest+0x424>
    }
    if(pids[i] != -1)
    33da:	8b 45 f4             	mov    -0xc(%rbp),%eax
    33dd:	48 98                	cltq
    33df:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    33e3:	83 f8 ff             	cmp    $0xffffffff,%eax
    33e6:	74 19                	je     3401 <sbrktest+0x457>
      read(fds[0], &scratch, 1);
    33e8:	8b 45 a8             	mov    -0x58(%rbp),%eax
    33eb:	48 8d 8d 7f ff ff ff 	lea    -0x81(%rbp),%rcx
    33f2:	ba 01 00 00 00       	mov    $0x1,%edx
    33f7:	48 89 ce             	mov    %rcx,%rsi
    33fa:	89 c7                	mov    %eax,%edi
    33fc:	e8 c7 0a 00 00       	call   3ec8 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3401:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    3405:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3408:	83 f8 09             	cmp    $0x9,%eax
    340b:	0f 86 71 ff ff ff    	jbe    3382 <sbrktest+0x3d8>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3411:	bf 00 10 00 00       	mov    $0x1000,%edi
    3416:	e8 1d 0b 00 00       	call   3f38 <sbrk>
    341b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    341f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    3426:	eb 2a                	jmp    3452 <sbrktest+0x4a8>
    if(pids[i] == -1)
    3428:	8b 45 f4             	mov    -0xc(%rbp),%eax
    342b:	48 98                	cltq
    342d:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    3431:	83 f8 ff             	cmp    $0xffffffff,%eax
    3434:	74 17                	je     344d <sbrktest+0x4a3>
      continue;
    kill(pids[i]);
    3436:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3439:	48 98                	cltq
    343b:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    343f:	89 c7                	mov    %eax,%edi
    3441:	e8 9a 0a 00 00       	call   3ee0 <kill>
    wait();
    3446:	e8 6d 0a 00 00       	call   3eb8 <wait>
    344b:	eb 01                	jmp    344e <sbrktest+0x4a4>
      continue;
    344d:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    344e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    3452:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3455:	83 f8 09             	cmp    $0x9,%eax
    3458:	76 ce                	jbe    3428 <sbrktest+0x47e>
  }
  if(c == (char*)0xffffffff){
    345a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    345f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    3463:	75 1e                	jne    3483 <sbrktest+0x4d9>
    printf(stdout, "failed sbrk leaked memory\n");
    3465:	8b 05 9d 2f 00 00    	mov    0x2f9d(%rip),%eax        # 6408 <stdout>
    346b:	48 c7 c6 12 5b 00 00 	mov    $0x5b12,%rsi
    3472:	89 c7                	mov    %eax,%edi
    3474:	b8 00 00 00 00       	mov    $0x0,%eax
    3479:	e8 f4 0b 00 00       	call   4072 <printf>
    exit();
    347e:	e8 2d 0a 00 00       	call   3eb0 <exit>
  }

  if(sbrk(0) > oldbrk)
    3483:	bf 00 00 00 00       	mov    $0x0,%edi
    3488:	e8 ab 0a 00 00       	call   3f38 <sbrk>
    348d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    3491:	73 1a                	jae    34ad <sbrktest+0x503>
    sbrk(-(sbrk(0) - oldbrk));
    3493:	bf 00 00 00 00       	mov    $0x0,%edi
    3498:	e8 9b 0a 00 00       	call   3f38 <sbrk>
    349d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    34a1:	48 29 c2             	sub    %rax,%rdx
    34a4:	89 d0                	mov    %edx,%eax
    34a6:	89 c7                	mov    %eax,%edi
    34a8:	e8 8b 0a 00 00       	call   3f38 <sbrk>

  printf(stdout, "sbrk test OK\n");
    34ad:	8b 05 55 2f 00 00    	mov    0x2f55(%rip),%eax        # 6408 <stdout>
    34b3:	48 c7 c6 2d 5b 00 00 	mov    $0x5b2d,%rsi
    34ba:	89 c7                	mov    %eax,%edi
    34bc:	b8 00 00 00 00       	mov    $0x0,%eax
    34c1:	e8 ac 0b 00 00       	call   4072 <printf>
}
    34c6:	90                   	nop
    34c7:	c9                   	leave
    34c8:	c3                   	ret

00000000000034c9 <validateint>:

void
validateint(int *p)
{
    34c9:	f3 0f 1e fa          	endbr64
    34cd:	55                   	push   %rbp
    34ce:	48 89 e5             	mov    %rsp,%rbp
    34d1:	48 83 ec 08          	sub    $0x8,%rsp
    34d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
#endif
}
    34d9:	90                   	nop
    34da:	c9                   	leave
    34db:	c3                   	ret

00000000000034dc <validatetest>:

void
validatetest(void)
{
    34dc:	f3 0f 1e fa          	endbr64
    34e0:	55                   	push   %rbp
    34e1:	48 89 e5             	mov    %rsp,%rbp
    34e4:	48 83 ec 10          	sub    $0x10,%rsp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    34e8:	8b 05 1a 2f 00 00    	mov    0x2f1a(%rip),%eax        # 6408 <stdout>
    34ee:	48 c7 c6 3b 5b 00 00 	mov    $0x5b3b,%rsi
    34f5:	89 c7                	mov    %eax,%edi
    34f7:	b8 00 00 00 00       	mov    $0x0,%eax
    34fc:	e8 71 0b 00 00       	call   4072 <printf>
  hi = 1100*1024;
    3501:	c7 45 f8 00 30 11 00 	movl   $0x113000,-0x8(%rbp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3508:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    350f:	eb 7d                	jmp    358e <validatetest+0xb2>
    if((pid = fork()) == 0){
    3511:	e8 92 09 00 00       	call   3ea8 <fork>
    3516:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3519:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    351d:	75 10                	jne    352f <validatetest+0x53>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    351f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3522:	48 89 c7             	mov    %rax,%rdi
    3525:	e8 9f ff ff ff       	call   34c9 <validateint>
      exit();
    352a:	e8 81 09 00 00       	call   3eb0 <exit>
    }
    sleep(0);
    352f:	bf 00 00 00 00       	mov    $0x0,%edi
    3534:	e8 07 0a 00 00       	call   3f40 <sleep>
    sleep(0);
    3539:	bf 00 00 00 00       	mov    $0x0,%edi
    353e:	e8 fd 09 00 00       	call   3f40 <sleep>
    kill(pid);
    3543:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3546:	89 c7                	mov    %eax,%edi
    3548:	e8 93 09 00 00       	call   3ee0 <kill>
    wait();
    354d:	e8 66 09 00 00       	call   3eb8 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3552:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3555:	48 89 c6             	mov    %rax,%rsi
    3558:	48 c7 c7 4a 5b 00 00 	mov    $0x5b4a,%rdi
    355f:	e8 ac 09 00 00       	call   3f10 <link>
    3564:	83 f8 ff             	cmp    $0xffffffff,%eax
    3567:	74 1e                	je     3587 <validatetest+0xab>
      printf(stdout, "link should not succeed\n");
    3569:	8b 05 99 2e 00 00    	mov    0x2e99(%rip),%eax        # 6408 <stdout>
    356f:	48 c7 c6 55 5b 00 00 	mov    $0x5b55,%rsi
    3576:	89 c7                	mov    %eax,%edi
    3578:	b8 00 00 00 00       	mov    $0x0,%eax
    357d:	e8 f0 0a 00 00       	call   4072 <printf>
      exit();
    3582:	e8 29 09 00 00       	call   3eb0 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3587:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
    358e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    3591:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    3594:	0f 83 77 ff ff ff    	jae    3511 <validatetest+0x35>
    }
  }

  printf(stdout, "validate ok\n");
    359a:	8b 05 68 2e 00 00    	mov    0x2e68(%rip),%eax        # 6408 <stdout>
    35a0:	48 c7 c6 6e 5b 00 00 	mov    $0x5b6e,%rsi
    35a7:	89 c7                	mov    %eax,%edi
    35a9:	b8 00 00 00 00       	mov    $0x0,%eax
    35ae:	e8 bf 0a 00 00       	call   4072 <printf>
}
    35b3:	90                   	nop
    35b4:	c9                   	leave
    35b5:	c3                   	ret

00000000000035b6 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    35b6:	f3 0f 1e fa          	endbr64
    35ba:	55                   	push   %rbp
    35bb:	48 89 e5             	mov    %rsp,%rbp
    35be:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  printf(stdout, "bss test\n");
    35c2:	8b 05 40 2e 00 00    	mov    0x2e40(%rip),%eax        # 6408 <stdout>
    35c8:	48 c7 c6 7b 5b 00 00 	mov    $0x5b7b,%rsi
    35cf:	89 c7                	mov    %eax,%edi
    35d1:	b8 00 00 00 00       	mov    $0x0,%eax
    35d6:	e8 97 0a 00 00       	call   4072 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    35db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    35e2:	eb 32                	jmp    3616 <bsstest+0x60>
    if(uninit[i] != '\0'){
    35e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35e7:	48 98                	cltq
    35e9:	0f b6 80 60 84 00 00 	movzbl 0x8460(%rax),%eax
    35f0:	84 c0                	test   %al,%al
    35f2:	74 1e                	je     3612 <bsstest+0x5c>
      printf(stdout, "bss test failed\n");
    35f4:	8b 05 0e 2e 00 00    	mov    0x2e0e(%rip),%eax        # 6408 <stdout>
    35fa:	48 c7 c6 85 5b 00 00 	mov    $0x5b85,%rsi
    3601:	89 c7                	mov    %eax,%edi
    3603:	b8 00 00 00 00       	mov    $0x0,%eax
    3608:	e8 65 0a 00 00       	call   4072 <printf>
      exit();
    360d:	e8 9e 08 00 00       	call   3eb0 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    3612:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3616:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3619:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    361e:	76 c4                	jbe    35e4 <bsstest+0x2e>
    }
  }
  printf(stdout, "bss test ok\n");
    3620:	8b 05 e2 2d 00 00    	mov    0x2de2(%rip),%eax        # 6408 <stdout>
    3626:	48 c7 c6 96 5b 00 00 	mov    $0x5b96,%rsi
    362d:	89 c7                	mov    %eax,%edi
    362f:	b8 00 00 00 00       	mov    $0x0,%eax
    3634:	e8 39 0a 00 00       	call   4072 <printf>
}
    3639:	90                   	nop
    363a:	c9                   	leave
    363b:	c3                   	ret

000000000000363c <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    363c:	f3 0f 1e fa          	endbr64
    3640:	55                   	push   %rbp
    3641:	48 89 e5             	mov    %rsp,%rbp
    3644:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, fd;

  unlink("bigarg-ok");
    3648:	48 c7 c7 a3 5b 00 00 	mov    $0x5ba3,%rdi
    364f:	e8 ac 08 00 00       	call   3f00 <unlink>
  pid = fork();
    3654:	e8 4f 08 00 00       	call   3ea8 <fork>
    3659:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    365c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3660:	0f 85 97 00 00 00    	jne    36fd <bigargtest+0xc1>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3666:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    366d:	eb 15                	jmp    3684 <bigargtest+0x48>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    366f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3672:	48 98                	cltq
    3674:	48 c7 04 c5 80 ab 00 	movq   $0x5bb0,0xab80(,%rax,8)
    367b:	00 b0 5b 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3680:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3684:	83 7d fc 1e          	cmpl   $0x1e,-0x4(%rbp)
    3688:	7e e5                	jle    366f <bigargtest+0x33>
    args[MAXARG-1] = 0;
    368a:	48 c7 05 e3 75 00 00 	movq   $0x0,0x75e3(%rip)        # ac78 <args.0+0xf8>
    3691:	00 00 00 00 
    printf(stdout, "bigarg test\n");
    3695:	8b 05 6d 2d 00 00    	mov    0x2d6d(%rip),%eax        # 6408 <stdout>
    369b:	48 c7 c6 8d 5c 00 00 	mov    $0x5c8d,%rsi
    36a2:	89 c7                	mov    %eax,%edi
    36a4:	b8 00 00 00 00       	mov    $0x0,%eax
    36a9:	e8 c4 09 00 00       	call   4072 <printf>
    exec("echo", args);
    36ae:	48 c7 c6 80 ab 00 00 	mov    $0xab80,%rsi
    36b5:	48 c7 c7 88 46 00 00 	mov    $0x4688,%rdi
    36bc:	e8 27 08 00 00       	call   3ee8 <exec>
    printf(stdout, "bigarg test ok\n");
    36c1:	8b 05 41 2d 00 00    	mov    0x2d41(%rip),%eax        # 6408 <stdout>
    36c7:	48 c7 c6 9a 5c 00 00 	mov    $0x5c9a,%rsi
    36ce:	89 c7                	mov    %eax,%edi
    36d0:	b8 00 00 00 00       	mov    $0x0,%eax
    36d5:	e8 98 09 00 00       	call   4072 <printf>
    fd = open("bigarg-ok", O_CREATE);
    36da:	be 00 02 00 00       	mov    $0x200,%esi
    36df:	48 c7 c7 a3 5b 00 00 	mov    $0x5ba3,%rdi
    36e6:	e8 05 08 00 00       	call   3ef0 <open>
    36eb:	89 45 f4             	mov    %eax,-0xc(%rbp)
    close(fd);
    36ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
    36f1:	89 c7                	mov    %eax,%edi
    36f3:	e8 e0 07 00 00       	call   3ed8 <close>
    exit();
    36f8:	e8 b3 07 00 00       	call   3eb0 <exit>
  } else if(pid < 0){
    36fd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3701:	79 1e                	jns    3721 <bigargtest+0xe5>
    printf(stdout, "bigargtest: fork failed\n");
    3703:	8b 05 ff 2c 00 00    	mov    0x2cff(%rip),%eax        # 6408 <stdout>
    3709:	48 c7 c6 aa 5c 00 00 	mov    $0x5caa,%rsi
    3710:	89 c7                	mov    %eax,%edi
    3712:	b8 00 00 00 00       	mov    $0x0,%eax
    3717:	e8 56 09 00 00       	call   4072 <printf>
    exit();
    371c:	e8 8f 07 00 00       	call   3eb0 <exit>
  }
  wait();
    3721:	e8 92 07 00 00       	call   3eb8 <wait>
  fd = open("bigarg-ok", 0);
    3726:	be 00 00 00 00       	mov    $0x0,%esi
    372b:	48 c7 c7 a3 5b 00 00 	mov    $0x5ba3,%rdi
    3732:	e8 b9 07 00 00       	call   3ef0 <open>
    3737:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    373a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    373e:	79 1e                	jns    375e <bigargtest+0x122>
    printf(stdout, "bigarg test failed!\n");
    3740:	8b 05 c2 2c 00 00    	mov    0x2cc2(%rip),%eax        # 6408 <stdout>
    3746:	48 c7 c6 c3 5c 00 00 	mov    $0x5cc3,%rsi
    374d:	89 c7                	mov    %eax,%edi
    374f:	b8 00 00 00 00       	mov    $0x0,%eax
    3754:	e8 19 09 00 00       	call   4072 <printf>
    exit();
    3759:	e8 52 07 00 00       	call   3eb0 <exit>
  }
  close(fd);
    375e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3761:	89 c7                	mov    %eax,%edi
    3763:	e8 70 07 00 00       	call   3ed8 <close>
  unlink("bigarg-ok");
    3768:	48 c7 c7 a3 5b 00 00 	mov    $0x5ba3,%rdi
    376f:	e8 8c 07 00 00       	call   3f00 <unlink>
}
    3774:	90                   	nop
    3775:	c9                   	leave
    3776:	c3                   	ret

0000000000003777 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3777:	f3 0f 1e fa          	endbr64
    377b:	55                   	push   %rbp
    377c:	48 89 e5             	mov    %rsp,%rbp
    377f:	48 83 ec 60          	sub    $0x60,%rsp
  int nfiles;
  int fsblocks = 0;
    3783:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

  printf(1, "fsfull test\n");
    378a:	48 c7 c6 d8 5c 00 00 	mov    $0x5cd8,%rsi
    3791:	bf 01 00 00 00       	mov    $0x1,%edi
    3796:	b8 00 00 00 00       	mov    $0x0,%eax
    379b:	e8 d2 08 00 00       	call   4072 <printf>

  for(nfiles = 0; ; nfiles++){
    37a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    char name[64];
    name[0] = 'f';
    37a7:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    37ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    37ae:	48 63 d0             	movslq %eax,%rdx
    37b1:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    37b8:	48 c1 ea 20          	shr    $0x20,%rdx
    37bc:	c1 fa 06             	sar    $0x6,%edx
    37bf:	c1 f8 1f             	sar    $0x1f,%eax
    37c2:	29 c2                	sub    %eax,%edx
    37c4:	89 d0                	mov    %edx,%eax
    37c6:	83 c0 30             	add    $0x30,%eax
    37c9:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    37cc:	8b 55 fc             	mov    -0x4(%rbp),%edx
    37cf:	48 63 c2             	movslq %edx,%rax
    37d2:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    37d9:	48 c1 e8 20          	shr    $0x20,%rax
    37dd:	c1 f8 06             	sar    $0x6,%eax
    37e0:	89 d1                	mov    %edx,%ecx
    37e2:	c1 f9 1f             	sar    $0x1f,%ecx
    37e5:	29 c8                	sub    %ecx,%eax
    37e7:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    37ed:	89 d0                	mov    %edx,%eax
    37ef:	29 c8                	sub    %ecx,%eax
    37f1:	48 63 d0             	movslq %eax,%rdx
    37f4:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    37fb:	48 c1 ea 20          	shr    $0x20,%rdx
    37ff:	c1 fa 05             	sar    $0x5,%edx
    3802:	c1 f8 1f             	sar    $0x1f,%eax
    3805:	29 c2                	sub    %eax,%edx
    3807:	89 d0                	mov    %edx,%eax
    3809:	83 c0 30             	add    $0x30,%eax
    380c:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    380f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3812:	48 63 c2             	movslq %edx,%rax
    3815:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    381c:	48 c1 e8 20          	shr    $0x20,%rax
    3820:	c1 f8 05             	sar    $0x5,%eax
    3823:	89 d1                	mov    %edx,%ecx
    3825:	c1 f9 1f             	sar    $0x1f,%ecx
    3828:	29 c8                	sub    %ecx,%eax
    382a:	6b c8 64             	imul   $0x64,%eax,%ecx
    382d:	89 d0                	mov    %edx,%eax
    382f:	29 c8                	sub    %ecx,%eax
    3831:	48 63 d0             	movslq %eax,%rdx
    3834:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    383b:	48 c1 ea 20          	shr    $0x20,%rdx
    383f:	c1 fa 02             	sar    $0x2,%edx
    3842:	c1 f8 1f             	sar    $0x1f,%eax
    3845:	29 c2                	sub    %eax,%edx
    3847:	89 d0                	mov    %edx,%eax
    3849:	83 c0 30             	add    $0x30,%eax
    384c:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    384f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3852:	48 63 c2             	movslq %edx,%rax
    3855:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    385c:	48 c1 e8 20          	shr    $0x20,%rax
    3860:	89 c1                	mov    %eax,%ecx
    3862:	c1 f9 02             	sar    $0x2,%ecx
    3865:	89 d0                	mov    %edx,%eax
    3867:	c1 f8 1f             	sar    $0x1f,%eax
    386a:	29 c1                	sub    %eax,%ecx
    386c:	89 c8                	mov    %ecx,%eax
    386e:	c1 e0 02             	shl    $0x2,%eax
    3871:	01 c8                	add    %ecx,%eax
    3873:	01 c0                	add    %eax,%eax
    3875:	89 d1                	mov    %edx,%ecx
    3877:	29 c1                	sub    %eax,%ecx
    3879:	89 c8                	mov    %ecx,%eax
    387b:	83 c0 30             	add    $0x30,%eax
    387e:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    3881:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    printf(1, "writing %s\n", name);
    3885:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    3889:	48 89 c2             	mov    %rax,%rdx
    388c:	48 c7 c6 e5 5c 00 00 	mov    $0x5ce5,%rsi
    3893:	bf 01 00 00 00       	mov    $0x1,%edi
    3898:	b8 00 00 00 00       	mov    $0x0,%eax
    389d:	e8 d0 07 00 00       	call   4072 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    38a2:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    38a6:	be 02 02 00 00       	mov    $0x202,%esi
    38ab:	48 89 c7             	mov    %rax,%rdi
    38ae:	e8 3d 06 00 00       	call   3ef0 <open>
    38b3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(fd < 0){
    38b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    38ba:	79 1f                	jns    38db <fsfull+0x164>
      printf(1, "open %s failed\n", name);
    38bc:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    38c0:	48 89 c2             	mov    %rax,%rdx
    38c3:	48 c7 c6 f1 5c 00 00 	mov    $0x5cf1,%rsi
    38ca:	bf 01 00 00 00       	mov    $0x1,%edi
    38cf:	b8 00 00 00 00       	mov    $0x0,%eax
    38d4:	e8 99 07 00 00       	call   4072 <printf>
      break;
    38d9:	eb 6b                	jmp    3946 <fsfull+0x1cf>
    }
    int total = 0;
    38db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while(1){
      int cc = write(fd, buf, 512);
    38e2:	8b 45 f0             	mov    -0x10(%rbp),%eax
    38e5:	ba 00 02 00 00       	mov    $0x200,%edx
    38ea:	48 c7 c6 40 64 00 00 	mov    $0x6440,%rsi
    38f1:	89 c7                	mov    %eax,%edi
    38f3:	e8 d8 05 00 00       	call   3ed0 <write>
    38f8:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(cc < 512)
    38fb:	81 7d ec ff 01 00 00 	cmpl   $0x1ff,-0x14(%rbp)
    3902:	7e 0c                	jle    3910 <fsfull+0x199>
        break;
      total += cc;
    3904:	8b 45 ec             	mov    -0x14(%rbp),%eax
    3907:	01 45 f4             	add    %eax,-0xc(%rbp)
      fsblocks++;
    390a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    while(1){
    390e:	eb d2                	jmp    38e2 <fsfull+0x16b>
        break;
    3910:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    3911:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3914:	89 c2                	mov    %eax,%edx
    3916:	48 c7 c6 01 5d 00 00 	mov    $0x5d01,%rsi
    391d:	bf 01 00 00 00       	mov    $0x1,%edi
    3922:	b8 00 00 00 00       	mov    $0x0,%eax
    3927:	e8 46 07 00 00       	call   4072 <printf>
    close(fd);
    392c:	8b 45 f0             	mov    -0x10(%rbp),%eax
    392f:	89 c7                	mov    %eax,%edi
    3931:	e8 a2 05 00 00       	call   3ed8 <close>
    if(total == 0)
    3936:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    393a:	74 09                	je     3945 <fsfull+0x1ce>
  for(nfiles = 0; ; nfiles++){
    393c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3940:	e9 62 fe ff ff       	jmp    37a7 <fsfull+0x30>
      break;
    3945:	90                   	nop
  }

  while(nfiles >= 0){
    3946:	e9 ee 00 00 00       	jmp    3a39 <fsfull+0x2c2>
    char name[64];
    name[0] = 'f';
    394b:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    394f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3952:	48 63 d0             	movslq %eax,%rdx
    3955:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    395c:	48 c1 ea 20          	shr    $0x20,%rdx
    3960:	c1 fa 06             	sar    $0x6,%edx
    3963:	c1 f8 1f             	sar    $0x1f,%eax
    3966:	29 c2                	sub    %eax,%edx
    3968:	89 d0                	mov    %edx,%eax
    396a:	83 c0 30             	add    $0x30,%eax
    396d:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3970:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3973:	48 63 c2             	movslq %edx,%rax
    3976:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    397d:	48 c1 e8 20          	shr    $0x20,%rax
    3981:	c1 f8 06             	sar    $0x6,%eax
    3984:	89 d1                	mov    %edx,%ecx
    3986:	c1 f9 1f             	sar    $0x1f,%ecx
    3989:	29 c8                	sub    %ecx,%eax
    398b:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    3991:	89 d0                	mov    %edx,%eax
    3993:	29 c8                	sub    %ecx,%eax
    3995:	48 63 d0             	movslq %eax,%rdx
    3998:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    399f:	48 c1 ea 20          	shr    $0x20,%rdx
    39a3:	c1 fa 05             	sar    $0x5,%edx
    39a6:	c1 f8 1f             	sar    $0x1f,%eax
    39a9:	29 c2                	sub    %eax,%edx
    39ab:	89 d0                	mov    %edx,%eax
    39ad:	83 c0 30             	add    $0x30,%eax
    39b0:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    39b3:	8b 55 fc             	mov    -0x4(%rbp),%edx
    39b6:	48 63 c2             	movslq %edx,%rax
    39b9:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    39c0:	48 c1 e8 20          	shr    $0x20,%rax
    39c4:	c1 f8 05             	sar    $0x5,%eax
    39c7:	89 d1                	mov    %edx,%ecx
    39c9:	c1 f9 1f             	sar    $0x1f,%ecx
    39cc:	29 c8                	sub    %ecx,%eax
    39ce:	6b c8 64             	imul   $0x64,%eax,%ecx
    39d1:	89 d0                	mov    %edx,%eax
    39d3:	29 c8                	sub    %ecx,%eax
    39d5:	48 63 d0             	movslq %eax,%rdx
    39d8:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    39df:	48 c1 ea 20          	shr    $0x20,%rdx
    39e3:	c1 fa 02             	sar    $0x2,%edx
    39e6:	c1 f8 1f             	sar    $0x1f,%eax
    39e9:	29 c2                	sub    %eax,%edx
    39eb:	89 d0                	mov    %edx,%eax
    39ed:	83 c0 30             	add    $0x30,%eax
    39f0:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    39f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
    39f6:	48 63 c2             	movslq %edx,%rax
    39f9:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    3a00:	48 c1 e8 20          	shr    $0x20,%rax
    3a04:	89 c1                	mov    %eax,%ecx
    3a06:	c1 f9 02             	sar    $0x2,%ecx
    3a09:	89 d0                	mov    %edx,%eax
    3a0b:	c1 f8 1f             	sar    $0x1f,%eax
    3a0e:	29 c1                	sub    %eax,%ecx
    3a10:	89 c8                	mov    %ecx,%eax
    3a12:	c1 e0 02             	shl    $0x2,%eax
    3a15:	01 c8                	add    %ecx,%eax
    3a17:	01 c0                	add    %eax,%eax
    3a19:	89 d1                	mov    %edx,%ecx
    3a1b:	29 c1                	sub    %eax,%ecx
    3a1d:	89 c8                	mov    %ecx,%eax
    3a1f:	83 c0 30             	add    $0x30,%eax
    3a22:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    3a25:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    unlink(name);
    3a29:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    3a2d:	48 89 c7             	mov    %rax,%rdi
    3a30:	e8 cb 04 00 00       	call   3f00 <unlink>
    nfiles--;
    3a35:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  while(nfiles >= 0){
    3a39:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3a3d:	0f 89 08 ff ff ff    	jns    394b <fsfull+0x1d4>
  }

  printf(1, "fsfull test finished\n");
    3a43:	48 c7 c6 11 5d 00 00 	mov    $0x5d11,%rsi
    3a4a:	bf 01 00 00 00       	mov    $0x1,%edi
    3a4f:	b8 00 00 00 00       	mov    $0x0,%eax
    3a54:	e8 19 06 00 00       	call   4072 <printf>
}
    3a59:	90                   	nop
    3a5a:	c9                   	leave
    3a5b:	c3                   	ret

0000000000003a5c <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3a5c:	f3 0f 1e fa          	endbr64
    3a60:	55                   	push   %rbp
    3a61:	48 89 e5             	mov    %rsp,%rbp
  randstate = randstate * 1664525 + 1013904223;
    3a64:	48 8b 05 a5 29 00 00 	mov    0x29a5(%rip),%rax        # 6410 <randstate>
    3a6b:	48 69 c0 0d 66 19 00 	imul   $0x19660d,%rax,%rax
    3a72:	48 05 5f f3 6e 3c    	add    $0x3c6ef35f,%rax
    3a78:	48 89 05 91 29 00 00 	mov    %rax,0x2991(%rip)        # 6410 <randstate>
  return randstate;
    3a7f:	48 8b 05 8a 29 00 00 	mov    0x298a(%rip),%rax        # 6410 <randstate>
}
    3a86:	5d                   	pop    %rbp
    3a87:	c3                   	ret

0000000000003a88 <main>:

int
main(int argc, char *argv[])
{
    3a88:	f3 0f 1e fa          	endbr64
    3a8c:	55                   	push   %rbp
    3a8d:	48 89 e5             	mov    %rsp,%rbp
    3a90:	48 83 ec 10          	sub    $0x10,%rsp
    3a94:	89 7d fc             	mov    %edi,-0x4(%rbp)
    3a97:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  printf(1, "usertests starting\n");
    3a9b:	48 c7 c6 27 5d 00 00 	mov    $0x5d27,%rsi
    3aa2:	bf 01 00 00 00       	mov    $0x1,%edi
    3aa7:	b8 00 00 00 00       	mov    $0x0,%eax
    3aac:	e8 c1 05 00 00       	call   4072 <printf>

  if(open("usertests.ran", 0) >= 0){
    3ab1:	be 00 00 00 00       	mov    $0x0,%esi
    3ab6:	48 c7 c7 3b 5d 00 00 	mov    $0x5d3b,%rdi
    3abd:	e8 2e 04 00 00       	call   3ef0 <open>
    3ac2:	85 c0                	test   %eax,%eax
    3ac4:	78 1b                	js     3ae1 <main+0x59>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3ac6:	48 c7 c6 50 5d 00 00 	mov    $0x5d50,%rsi
    3acd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ad2:	b8 00 00 00 00       	mov    $0x0,%eax
    3ad7:	e8 96 05 00 00       	call   4072 <printf>
    exit();
    3adc:	e8 cf 03 00 00       	call   3eb0 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3ae1:	be 00 02 00 00       	mov    $0x200,%esi
    3ae6:	48 c7 c7 3b 5d 00 00 	mov    $0x5d3b,%rdi
    3aed:	e8 fe 03 00 00       	call   3ef0 <open>
    3af2:	89 c7                	mov    %eax,%edi
    3af4:	e8 df 03 00 00       	call   3ed8 <close>

  bigargtest();
    3af9:	e8 3e fb ff ff       	call   363c <bigargtest>
  bigwrite();
    3afe:	e8 27 ea ff ff       	call   252a <bigwrite>
  bigargtest();
    3b03:	e8 34 fb ff ff       	call   363c <bigargtest>
  bsstest();
    3b08:	e8 a9 fa ff ff       	call   35b6 <bsstest>
  sbrktest();
    3b0d:	e8 98 f4 ff ff       	call   2faa <sbrktest>
  validatetest();
    3b12:	e8 c5 f9 ff ff       	call   34dc <validatetest>

  opentest();
    3b17:	e8 e4 c4 ff ff       	call   0 <opentest>
  writetest();
    3b1c:	e8 9a c5 ff ff       	call   bb <writetest>
  writetest1();
    3b21:	e8 c2 c7 ff ff       	call   2e8 <writetest1>
  createtest();
    3b26:	e8 d1 c9 ff ff       	call   4fc <createtest>

  mem();
    3b2b:	e8 ba cf ff ff       	call   aea <mem>
  pipe1();
    3b30:	e8 da cb ff ff       	call   70f <pipe1>
  preempt();
    3b35:	e8 c8 cd ff ff       	call   902 <preempt>
  exitwait();
    3b3a:	e8 21 cf ff ff       	call   a60 <exitwait>

  rmdot();
    3b3f:	e8 7f ee ff ff       	call   29c3 <rmdot>
  fourteen();
    3b44:	e8 15 ed ff ff       	call   285e <fourteen>
  bigfile();
    3b49:	e8 e5 ea ff ff       	call   2633 <bigfile>
  subdir();
    3b4e:	e8 79 e2 ff ff       	call   1dcc <subdir>
  concreate();
    3b53:	e8 d1 db ff ff       	call   1729 <concreate>
  linkunlink();
    3b58:	b8 00 00 00 00       	mov    $0x0,%eax
    3b5d:	e8 9d df ff ff       	call   1aff <linkunlink>
  linktest();
    3b62:	e8 75 d9 ff ff       	call   14dc <linktest>
  unlinkread();
    3b67:	e8 a4 d7 ff ff       	call   1310 <unlinkread>
  createdelete();
    3b6c:	e8 db d4 ff ff       	call   104c <createdelete>
  twofiles();
    3b71:	e8 69 d2 ff ff       	call   ddf <twofiles>
  sharedfd();
    3b76:	e8 6e d0 ff ff       	call   be9 <sharedfd>
  dirfile();
    3b7b:	e8 d2 ef ff ff       	call   2b52 <dirfile>
  iref();
    3b80:	e8 17 f2 ff ff       	call   2d9c <iref>
  forktest();
    3b85:	e8 3c f3 ff ff       	call   2ec6 <forktest>
  bigdir(); // slow
    3b8a:	e8 b6 e0 ff ff       	call   1c45 <bigdir>

  exectest();
    3b8f:	e8 22 cb ff ff       	call   6b6 <exectest>

  exit();
    3b94:	e8 17 03 00 00       	call   3eb0 <exit>

0000000000003b99 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3b99:	55                   	push   %rbp
    3b9a:	48 89 e5             	mov    %rsp,%rbp
    3b9d:	48 83 ec 10          	sub    $0x10,%rsp
    3ba1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3ba5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    3ba8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    3bab:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    3baf:	8b 55 f0             	mov    -0x10(%rbp),%edx
    3bb2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3bb5:	48 89 ce             	mov    %rcx,%rsi
    3bb8:	48 89 f7             	mov    %rsi,%rdi
    3bbb:	89 d1                	mov    %edx,%ecx
    3bbd:	fc                   	cld
    3bbe:	f3 aa                	rep stos %al,%es:(%rdi)
    3bc0:	89 ca                	mov    %ecx,%edx
    3bc2:	48 89 fe             	mov    %rdi,%rsi
    3bc5:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    3bc9:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3bcc:	90                   	nop
    3bcd:	c9                   	leave
    3bce:	c3                   	ret

0000000000003bcf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3bcf:	f3 0f 1e fa          	endbr64
    3bd3:	55                   	push   %rbp
    3bd4:	48 89 e5             	mov    %rsp,%rbp
    3bd7:	48 83 ec 20          	sub    $0x20,%rsp
    3bdb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3bdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    3be3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3be7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    3beb:	90                   	nop
    3bec:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    3bf0:	48 8d 42 01          	lea    0x1(%rdx),%rax
    3bf4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    3bf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3bfc:	48 8d 48 01          	lea    0x1(%rax),%rcx
    3c00:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    3c04:	0f b6 12             	movzbl (%rdx),%edx
    3c07:	88 10                	mov    %dl,(%rax)
    3c09:	0f b6 00             	movzbl (%rax),%eax
    3c0c:	84 c0                	test   %al,%al
    3c0e:	75 dc                	jne    3bec <strcpy+0x1d>
    ;
  return os;
    3c10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    3c14:	c9                   	leave
    3c15:	c3                   	ret

0000000000003c16 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3c16:	f3 0f 1e fa          	endbr64
    3c1a:	55                   	push   %rbp
    3c1b:	48 89 e5             	mov    %rsp,%rbp
    3c1e:	48 83 ec 10          	sub    $0x10,%rsp
    3c22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3c26:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    3c2a:	eb 0a                	jmp    3c36 <strcmp+0x20>
    p++, q++;
    3c2c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    3c31:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    3c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c3a:	0f b6 00             	movzbl (%rax),%eax
    3c3d:	84 c0                	test   %al,%al
    3c3f:	74 12                	je     3c53 <strcmp+0x3d>
    3c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c45:	0f b6 10             	movzbl (%rax),%edx
    3c48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    3c4c:	0f b6 00             	movzbl (%rax),%eax
    3c4f:	38 c2                	cmp    %al,%dl
    3c51:	74 d9                	je     3c2c <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    3c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c57:	0f b6 00             	movzbl (%rax),%eax
    3c5a:	0f b6 d0             	movzbl %al,%edx
    3c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    3c61:	0f b6 00             	movzbl (%rax),%eax
    3c64:	0f b6 c0             	movzbl %al,%eax
    3c67:	29 c2                	sub    %eax,%edx
    3c69:	89 d0                	mov    %edx,%eax
}
    3c6b:	c9                   	leave
    3c6c:	c3                   	ret

0000000000003c6d <strlen>:

uint
strlen(char *s)
{
    3c6d:	f3 0f 1e fa          	endbr64
    3c71:	55                   	push   %rbp
    3c72:	48 89 e5             	mov    %rsp,%rbp
    3c75:	48 83 ec 18          	sub    $0x18,%rsp
    3c79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    3c7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3c84:	eb 04                	jmp    3c8a <strlen+0x1d>
    3c86:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3c8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3c8d:	48 63 d0             	movslq %eax,%rdx
    3c90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3c94:	48 01 d0             	add    %rdx,%rax
    3c97:	0f b6 00             	movzbl (%rax),%eax
    3c9a:	84 c0                	test   %al,%al
    3c9c:	75 e8                	jne    3c86 <strlen+0x19>
    ;
  return n;
    3c9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    3ca1:	c9                   	leave
    3ca2:	c3                   	ret

0000000000003ca3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3ca3:	f3 0f 1e fa          	endbr64
    3ca7:	55                   	push   %rbp
    3ca8:	48 89 e5             	mov    %rsp,%rbp
    3cab:	48 83 ec 10          	sub    $0x10,%rsp
    3caf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3cb3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    3cb6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    3cb9:	8b 55 f0             	mov    -0x10(%rbp),%edx
    3cbc:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    3cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3cc3:	89 ce                	mov    %ecx,%esi
    3cc5:	48 89 c7             	mov    %rax,%rdi
    3cc8:	e8 cc fe ff ff       	call   3b99 <stosb>
  return dst;
    3ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    3cd1:	c9                   	leave
    3cd2:	c3                   	ret

0000000000003cd3 <strchr>:

char*
strchr(const char *s, char c)
{
    3cd3:	f3 0f 1e fa          	endbr64
    3cd7:	55                   	push   %rbp
    3cd8:	48 89 e5             	mov    %rsp,%rbp
    3cdb:	48 83 ec 10          	sub    $0x10,%rsp
    3cdf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3ce3:	89 f0                	mov    %esi,%eax
    3ce5:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    3ce8:	eb 17                	jmp    3d01 <strchr+0x2e>
    if(*s == c)
    3cea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3cee:	0f b6 00             	movzbl (%rax),%eax
    3cf1:	38 45 f4             	cmp    %al,-0xc(%rbp)
    3cf4:	75 06                	jne    3cfc <strchr+0x29>
      return (char*)s;
    3cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3cfa:	eb 15                	jmp    3d11 <strchr+0x3e>
  for(; *s; s++)
    3cfc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    3d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3d05:	0f b6 00             	movzbl (%rax),%eax
    3d08:	84 c0                	test   %al,%al
    3d0a:	75 de                	jne    3cea <strchr+0x17>
  return 0;
    3d0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3d11:	c9                   	leave
    3d12:	c3                   	ret

0000000000003d13 <gets>:

char*
gets(char *buf, int max)
{
    3d13:	f3 0f 1e fa          	endbr64
    3d17:	55                   	push   %rbp
    3d18:	48 89 e5             	mov    %rsp,%rbp
    3d1b:	48 83 ec 20          	sub    $0x20,%rsp
    3d1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3d23:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3d2d:	eb 48                	jmp    3d77 <gets+0x64>
    cc = read(0, &c, 1);
    3d2f:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    3d33:	ba 01 00 00 00       	mov    $0x1,%edx
    3d38:	48 89 c6             	mov    %rax,%rsi
    3d3b:	bf 00 00 00 00       	mov    $0x0,%edi
    3d40:	e8 83 01 00 00       	call   3ec8 <read>
    3d45:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    3d48:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3d4c:	7e 36                	jle    3d84 <gets+0x71>
      break;
    buf[i++] = c;
    3d4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d51:	8d 50 01             	lea    0x1(%rax),%edx
    3d54:	89 55 fc             	mov    %edx,-0x4(%rbp)
    3d57:	48 63 d0             	movslq %eax,%rdx
    3d5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d5e:	48 01 c2             	add    %rax,%rdx
    3d61:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3d65:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    3d67:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3d6b:	3c 0a                	cmp    $0xa,%al
    3d6d:	74 16                	je     3d85 <gets+0x72>
    3d6f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3d73:	3c 0d                	cmp    $0xd,%al
    3d75:	74 0e                	je     3d85 <gets+0x72>
  for(i=0; i+1 < max; ){
    3d77:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d7a:	83 c0 01             	add    $0x1,%eax
    3d7d:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    3d80:	7f ad                	jg     3d2f <gets+0x1c>
    3d82:	eb 01                	jmp    3d85 <gets+0x72>
      break;
    3d84:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3d85:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d88:	48 63 d0             	movslq %eax,%rdx
    3d8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d8f:	48 01 d0             	add    %rdx,%rax
    3d92:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    3d95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    3d99:	c9                   	leave
    3d9a:	c3                   	ret

0000000000003d9b <stat>:

int
stat(char *n, struct stat *st)
{
    3d9b:	f3 0f 1e fa          	endbr64
    3d9f:	55                   	push   %rbp
    3da0:	48 89 e5             	mov    %rsp,%rbp
    3da3:	48 83 ec 20          	sub    $0x20,%rsp
    3da7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3dab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3daf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3db3:	be 00 00 00 00       	mov    $0x0,%esi
    3db8:	48 89 c7             	mov    %rax,%rdi
    3dbb:	e8 30 01 00 00       	call   3ef0 <open>
    3dc0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    3dc3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3dc7:	79 07                	jns    3dd0 <stat+0x35>
    return -1;
    3dc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3dce:	eb 21                	jmp    3df1 <stat+0x56>
  r = fstat(fd, st);
    3dd0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    3dd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3dd7:	48 89 d6             	mov    %rdx,%rsi
    3dda:	89 c7                	mov    %eax,%edi
    3ddc:	e8 27 01 00 00       	call   3f08 <fstat>
    3de1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    3de4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3de7:	89 c7                	mov    %eax,%edi
    3de9:	e8 ea 00 00 00       	call   3ed8 <close>
  return r;
    3dee:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    3df1:	c9                   	leave
    3df2:	c3                   	ret

0000000000003df3 <atoi>:

int
atoi(const char *s)
{
    3df3:	f3 0f 1e fa          	endbr64
    3df7:	55                   	push   %rbp
    3df8:	48 89 e5             	mov    %rsp,%rbp
    3dfb:	48 83 ec 18          	sub    $0x18,%rsp
    3dff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    3e03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    3e0a:	eb 28                	jmp    3e34 <atoi+0x41>
    n = n*10 + *s++ - '0';
    3e0c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3e0f:	89 d0                	mov    %edx,%eax
    3e11:	c1 e0 02             	shl    $0x2,%eax
    3e14:	01 d0                	add    %edx,%eax
    3e16:	01 c0                	add    %eax,%eax
    3e18:	89 c1                	mov    %eax,%ecx
    3e1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3e1e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    3e22:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    3e26:	0f b6 00             	movzbl (%rax),%eax
    3e29:	0f be c0             	movsbl %al,%eax
    3e2c:	01 c8                	add    %ecx,%eax
    3e2e:	83 e8 30             	sub    $0x30,%eax
    3e31:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    3e34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3e38:	0f b6 00             	movzbl (%rax),%eax
    3e3b:	3c 2f                	cmp    $0x2f,%al
    3e3d:	7e 0b                	jle    3e4a <atoi+0x57>
    3e3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3e43:	0f b6 00             	movzbl (%rax),%eax
    3e46:	3c 39                	cmp    $0x39,%al
    3e48:	7e c2                	jle    3e0c <atoi+0x19>
  return n;
    3e4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    3e4d:	c9                   	leave
    3e4e:	c3                   	ret

0000000000003e4f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3e4f:	f3 0f 1e fa          	endbr64
    3e53:	55                   	push   %rbp
    3e54:	48 89 e5             	mov    %rsp,%rbp
    3e57:	48 83 ec 28          	sub    $0x28,%rsp
    3e5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3e5f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    3e63:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
    3e66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3e6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    3e6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    3e72:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    3e76:	eb 1d                	jmp    3e95 <memmove+0x46>
    *dst++ = *src++;
    3e78:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    3e7c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    3e80:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    3e84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3e88:	48 8d 48 01          	lea    0x1(%rax),%rcx
    3e8c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    3e90:	0f b6 12             	movzbl (%rdx),%edx
    3e93:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    3e95:	8b 45 dc             	mov    -0x24(%rbp),%eax
    3e98:	8d 50 ff             	lea    -0x1(%rax),%edx
    3e9b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    3e9e:	85 c0                	test   %eax,%eax
    3ea0:	7f d6                	jg     3e78 <memmove+0x29>
  return vdst;
    3ea2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    3ea6:	c9                   	leave
    3ea7:	c3                   	ret

0000000000003ea8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3ea8:	b8 01 00 00 00       	mov    $0x1,%eax
    3ead:	cd 40                	int    $0x40
    3eaf:	c3                   	ret

0000000000003eb0 <exit>:
SYSCALL(exit)
    3eb0:	b8 02 00 00 00       	mov    $0x2,%eax
    3eb5:	cd 40                	int    $0x40
    3eb7:	c3                   	ret

0000000000003eb8 <wait>:
SYSCALL(wait)
    3eb8:	b8 03 00 00 00       	mov    $0x3,%eax
    3ebd:	cd 40                	int    $0x40
    3ebf:	c3                   	ret

0000000000003ec0 <pipe>:
SYSCALL(pipe)
    3ec0:	b8 04 00 00 00       	mov    $0x4,%eax
    3ec5:	cd 40                	int    $0x40
    3ec7:	c3                   	ret

0000000000003ec8 <read>:
SYSCALL(read)
    3ec8:	b8 05 00 00 00       	mov    $0x5,%eax
    3ecd:	cd 40                	int    $0x40
    3ecf:	c3                   	ret

0000000000003ed0 <write>:
SYSCALL(write)
    3ed0:	b8 10 00 00 00       	mov    $0x10,%eax
    3ed5:	cd 40                	int    $0x40
    3ed7:	c3                   	ret

0000000000003ed8 <close>:
SYSCALL(close)
    3ed8:	b8 15 00 00 00       	mov    $0x15,%eax
    3edd:	cd 40                	int    $0x40
    3edf:	c3                   	ret

0000000000003ee0 <kill>:
SYSCALL(kill)
    3ee0:	b8 06 00 00 00       	mov    $0x6,%eax
    3ee5:	cd 40                	int    $0x40
    3ee7:	c3                   	ret

0000000000003ee8 <exec>:
SYSCALL(exec)
    3ee8:	b8 07 00 00 00       	mov    $0x7,%eax
    3eed:	cd 40                	int    $0x40
    3eef:	c3                   	ret

0000000000003ef0 <open>:
SYSCALL(open)
    3ef0:	b8 0f 00 00 00       	mov    $0xf,%eax
    3ef5:	cd 40                	int    $0x40
    3ef7:	c3                   	ret

0000000000003ef8 <mknod>:
SYSCALL(mknod)
    3ef8:	b8 11 00 00 00       	mov    $0x11,%eax
    3efd:	cd 40                	int    $0x40
    3eff:	c3                   	ret

0000000000003f00 <unlink>:
SYSCALL(unlink)
    3f00:	b8 12 00 00 00       	mov    $0x12,%eax
    3f05:	cd 40                	int    $0x40
    3f07:	c3                   	ret

0000000000003f08 <fstat>:
SYSCALL(fstat)
    3f08:	b8 08 00 00 00       	mov    $0x8,%eax
    3f0d:	cd 40                	int    $0x40
    3f0f:	c3                   	ret

0000000000003f10 <link>:
SYSCALL(link)
    3f10:	b8 13 00 00 00       	mov    $0x13,%eax
    3f15:	cd 40                	int    $0x40
    3f17:	c3                   	ret

0000000000003f18 <mkdir>:
SYSCALL(mkdir)
    3f18:	b8 14 00 00 00       	mov    $0x14,%eax
    3f1d:	cd 40                	int    $0x40
    3f1f:	c3                   	ret

0000000000003f20 <chdir>:
SYSCALL(chdir)
    3f20:	b8 09 00 00 00       	mov    $0x9,%eax
    3f25:	cd 40                	int    $0x40
    3f27:	c3                   	ret

0000000000003f28 <dup>:
SYSCALL(dup)
    3f28:	b8 0a 00 00 00       	mov    $0xa,%eax
    3f2d:	cd 40                	int    $0x40
    3f2f:	c3                   	ret

0000000000003f30 <getpid>:
SYSCALL(getpid)
    3f30:	b8 0b 00 00 00       	mov    $0xb,%eax
    3f35:	cd 40                	int    $0x40
    3f37:	c3                   	ret

0000000000003f38 <sbrk>:
SYSCALL(sbrk)
    3f38:	b8 0c 00 00 00       	mov    $0xc,%eax
    3f3d:	cd 40                	int    $0x40
    3f3f:	c3                   	ret

0000000000003f40 <sleep>:
SYSCALL(sleep)
    3f40:	b8 0d 00 00 00       	mov    $0xd,%eax
    3f45:	cd 40                	int    $0x40
    3f47:	c3                   	ret

0000000000003f48 <uptime>:
SYSCALL(uptime)
    3f48:	b8 0e 00 00 00       	mov    $0xe,%eax
    3f4d:	cd 40                	int    $0x40
    3f4f:	c3                   	ret

0000000000003f50 <getpinfo>:
SYSCALL(getpinfo)
    3f50:	b8 18 00 00 00       	mov    $0x18,%eax
    3f55:	cd 40                	int    $0x40
    3f57:	c3                   	ret

0000000000003f58 <settickets>:
SYSCALL(settickets)
    3f58:	b8 1b 00 00 00       	mov    $0x1b,%eax
    3f5d:	cd 40                	int    $0x40
    3f5f:	c3                   	ret

0000000000003f60 <getfavnum>:
SYSCALL(getfavnum)
    3f60:	b8 1c 00 00 00       	mov    $0x1c,%eax
    3f65:	cd 40                	int    $0x40
    3f67:	c3                   	ret

0000000000003f68 <halt>:
SYSCALL(halt)
    3f68:	b8 1d 00 00 00       	mov    $0x1d,%eax
    3f6d:	cd 40                	int    $0x40
    3f6f:	c3                   	ret

0000000000003f70 <getcount>:
SYSCALL(getcount)
    3f70:	b8 1e 00 00 00       	mov    $0x1e,%eax
    3f75:	cd 40                	int    $0x40
    3f77:	c3                   	ret

0000000000003f78 <killrandom>:
SYSCALL(killrandom)
    3f78:	b8 1f 00 00 00       	mov    $0x1f,%eax
    3f7d:	cd 40                	int    $0x40
    3f7f:	c3                   	ret

0000000000003f80 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3f80:	f3 0f 1e fa          	endbr64
    3f84:	55                   	push   %rbp
    3f85:	48 89 e5             	mov    %rsp,%rbp
    3f88:	48 83 ec 10          	sub    $0x10,%rsp
    3f8c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    3f8f:	89 f0                	mov    %esi,%eax
    3f91:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    3f94:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    3f98:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3f9b:	ba 01 00 00 00       	mov    $0x1,%edx
    3fa0:	48 89 ce             	mov    %rcx,%rsi
    3fa3:	89 c7                	mov    %eax,%edi
    3fa5:	e8 26 ff ff ff       	call   3ed0 <write>
}
    3faa:	90                   	nop
    3fab:	c9                   	leave
    3fac:	c3                   	ret

0000000000003fad <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3fad:	f3 0f 1e fa          	endbr64
    3fb1:	55                   	push   %rbp
    3fb2:	48 89 e5             	mov    %rsp,%rbp
    3fb5:	48 83 ec 30          	sub    $0x30,%rsp
    3fb9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    3fbc:	89 75 d8             	mov    %esi,-0x28(%rbp)
    3fbf:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    3fc2:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3fc5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
    3fcc:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    3fd0:	74 17                	je     3fe9 <printint+0x3c>
    3fd2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    3fd6:	79 11                	jns    3fe9 <printint+0x3c>
    neg = 1;
    3fd8:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
    3fdf:	8b 45 d8             	mov    -0x28(%rbp),%eax
    3fe2:	f7 d8                	neg    %eax
    3fe4:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3fe7:	eb 06                	jmp    3fef <printint+0x42>
  } else {
    x = xx;
    3fe9:	8b 45 d8             	mov    -0x28(%rbp),%eax
    3fec:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
    3fef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
    3ff6:	8b 75 d4             	mov    -0x2c(%rbp),%esi
    3ff9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3ffc:	ba 00 00 00 00       	mov    $0x0,%edx
    4001:	f7 f6                	div    %esi
    4003:	89 d1                	mov    %edx,%ecx
    4005:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4008:	8d 50 01             	lea    0x1(%rax),%edx
    400b:	89 55 fc             	mov    %edx,-0x4(%rbp)
    400e:	89 ca                	mov    %ecx,%edx
    4010:	0f b6 92 20 64 00 00 	movzbl 0x6420(%rdx),%edx
    4017:	48 98                	cltq
    4019:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
    401d:	8b 7d d4             	mov    -0x2c(%rbp),%edi
    4020:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4023:	ba 00 00 00 00       	mov    $0x0,%edx
    4028:	f7 f7                	div    %edi
    402a:	89 45 f4             	mov    %eax,-0xc(%rbp)
    402d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    4031:	75 c3                	jne    3ff6 <printint+0x49>
  if(neg)
    4033:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    4037:	74 2b                	je     4064 <printint+0xb7>
    buf[i++] = '-';
    4039:	8b 45 fc             	mov    -0x4(%rbp),%eax
    403c:	8d 50 01             	lea    0x1(%rax),%edx
    403f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    4042:	48 98                	cltq
    4044:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
    4049:	eb 19                	jmp    4064 <printint+0xb7>
    putc(fd, buf[i]);
    404b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    404e:	48 98                	cltq
    4050:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    4055:	0f be d0             	movsbl %al,%edx
    4058:	8b 45 dc             	mov    -0x24(%rbp),%eax
    405b:	89 d6                	mov    %edx,%esi
    405d:	89 c7                	mov    %eax,%edi
    405f:	e8 1c ff ff ff       	call   3f80 <putc>
  while(--i >= 0)
    4064:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    4068:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    406c:	79 dd                	jns    404b <printint+0x9e>
}
    406e:	90                   	nop
    406f:	90                   	nop
    4070:	c9                   	leave
    4071:	c3                   	ret

0000000000004072 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4072:	f3 0f 1e fa          	endbr64
    4076:	55                   	push   %rbp
    4077:	48 89 e5             	mov    %rsp,%rbp
    407a:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    4081:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    4087:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    408e:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    4095:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    409c:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    40a3:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    40aa:	84 c0                	test   %al,%al
    40ac:	74 20                	je     40ce <printf+0x5c>
    40ae:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    40b2:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    40b6:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    40ba:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    40be:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    40c2:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    40c6:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    40ca:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
    40ce:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    40d5:	00 00 00 
    40d8:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    40df:	00 00 00 
    40e2:	48 8d 45 10          	lea    0x10(%rbp),%rax
    40e6:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    40ed:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    40f4:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
    40fb:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    4102:	00 00 00 
  for(i = 0; fmt[i]; i++){
    4105:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    410c:	00 00 00 
    410f:	e9 a8 02 00 00       	jmp    43bc <printf+0x34a>
    c = fmt[i] & 0xff;
    4114:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    411a:	48 63 d0             	movslq %eax,%rdx
    411d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    4124:	48 01 d0             	add    %rdx,%rax
    4127:	0f b6 00             	movzbl (%rax),%eax
    412a:	0f be c0             	movsbl %al,%eax
    412d:	25 ff 00 00 00       	and    $0xff,%eax
    4132:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
    4138:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
    413f:	75 35                	jne    4176 <printf+0x104>
      if(c == '%'){
    4141:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    4148:	75 0f                	jne    4159 <printf+0xe7>
        state = '%';
    414a:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
    4151:	00 00 00 
    4154:	e9 5c 02 00 00       	jmp    43b5 <printf+0x343>
      } else {
        putc(fd, c);
    4159:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    415f:	0f be d0             	movsbl %al,%edx
    4162:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4168:	89 d6                	mov    %edx,%esi
    416a:	89 c7                	mov    %eax,%edi
    416c:	e8 0f fe ff ff       	call   3f80 <putc>
    4171:	e9 3f 02 00 00       	jmp    43b5 <printf+0x343>
      }
    } else if(state == '%'){
    4176:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
    417d:	0f 85 32 02 00 00    	jne    43b5 <printf+0x343>
      if(c == 'd'){
    4183:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    418a:	75 5e                	jne    41ea <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
    418c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    4192:	83 f8 2f             	cmp    $0x2f,%eax
    4195:	77 23                	ja     41ba <printf+0x148>
    4197:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    419e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    41a4:	89 d2                	mov    %edx,%edx
    41a6:	48 01 d0             	add    %rdx,%rax
    41a9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    41af:	83 c2 08             	add    $0x8,%edx
    41b2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    41b8:	eb 12                	jmp    41cc <printf+0x15a>
    41ba:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    41c1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    41c5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    41cc:	8b 30                	mov    (%rax),%esi
    41ce:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    41d4:	b9 01 00 00 00       	mov    $0x1,%ecx
    41d9:	ba 0a 00 00 00       	mov    $0xa,%edx
    41de:	89 c7                	mov    %eax,%edi
    41e0:	e8 c8 fd ff ff       	call   3fad <printint>
    41e5:	e9 c1 01 00 00       	jmp    43ab <printf+0x339>
      } else if(c == 'x' || c == 'p'){
    41ea:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    41f1:	74 09                	je     41fc <printf+0x18a>
    41f3:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    41fa:	75 5e                	jne    425a <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
    41fc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    4202:	83 f8 2f             	cmp    $0x2f,%eax
    4205:	77 23                	ja     422a <printf+0x1b8>
    4207:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    420e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    4214:	89 d2                	mov    %edx,%edx
    4216:	48 01 d0             	add    %rdx,%rax
    4219:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    421f:	83 c2 08             	add    $0x8,%edx
    4222:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    4228:	eb 12                	jmp    423c <printf+0x1ca>
    422a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    4231:	48 8d 50 08          	lea    0x8(%rax),%rdx
    4235:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    423c:	8b 30                	mov    (%rax),%esi
    423e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4244:	b9 00 00 00 00       	mov    $0x0,%ecx
    4249:	ba 10 00 00 00       	mov    $0x10,%edx
    424e:	89 c7                	mov    %eax,%edi
    4250:	e8 58 fd ff ff       	call   3fad <printint>
    4255:	e9 51 01 00 00       	jmp    43ab <printf+0x339>
      } else if(c == 's'){
    425a:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    4261:	0f 85 98 00 00 00    	jne    42ff <printf+0x28d>
        s = va_arg(ap, char*);
    4267:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    426d:	83 f8 2f             	cmp    $0x2f,%eax
    4270:	77 23                	ja     4295 <printf+0x223>
    4272:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    4279:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    427f:	89 d2                	mov    %edx,%edx
    4281:	48 01 d0             	add    %rdx,%rax
    4284:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    428a:	83 c2 08             	add    $0x8,%edx
    428d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    4293:	eb 12                	jmp    42a7 <printf+0x235>
    4295:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    429c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    42a0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    42a7:	48 8b 00             	mov    (%rax),%rax
    42aa:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
    42b1:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
    42b8:	00 
    42b9:	75 31                	jne    42ec <printf+0x27a>
          s = "(null)";
    42bb:	48 c7 85 48 ff ff ff 	movq   $0x5d7a,-0xb8(%rbp)
    42c2:	7a 5d 00 00 
        while(*s != 0){
    42c6:	eb 24                	jmp    42ec <printf+0x27a>
          putc(fd, *s);
    42c8:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    42cf:	0f b6 00             	movzbl (%rax),%eax
    42d2:	0f be d0             	movsbl %al,%edx
    42d5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    42db:	89 d6                	mov    %edx,%esi
    42dd:	89 c7                	mov    %eax,%edi
    42df:	e8 9c fc ff ff       	call   3f80 <putc>
          s++;
    42e4:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
    42eb:	01 
        while(*s != 0){
    42ec:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    42f3:	0f b6 00             	movzbl (%rax),%eax
    42f6:	84 c0                	test   %al,%al
    42f8:	75 ce                	jne    42c8 <printf+0x256>
    42fa:	e9 ac 00 00 00       	jmp    43ab <printf+0x339>
        }
      } else if(c == 'c'){
    42ff:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    4306:	75 56                	jne    435e <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
    4308:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    430e:	83 f8 2f             	cmp    $0x2f,%eax
    4311:	77 23                	ja     4336 <printf+0x2c4>
    4313:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    431a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    4320:	89 d2                	mov    %edx,%edx
    4322:	48 01 d0             	add    %rdx,%rax
    4325:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    432b:	83 c2 08             	add    $0x8,%edx
    432e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    4334:	eb 12                	jmp    4348 <printf+0x2d6>
    4336:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    433d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    4341:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    4348:	8b 00                	mov    (%rax),%eax
    434a:	0f be d0             	movsbl %al,%edx
    434d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4353:	89 d6                	mov    %edx,%esi
    4355:	89 c7                	mov    %eax,%edi
    4357:	e8 24 fc ff ff       	call   3f80 <putc>
    435c:	eb 4d                	jmp    43ab <printf+0x339>
      } else if(c == '%'){
    435e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    4365:	75 1a                	jne    4381 <printf+0x30f>
        putc(fd, c);
    4367:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    436d:	0f be d0             	movsbl %al,%edx
    4370:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4376:	89 d6                	mov    %edx,%esi
    4378:	89 c7                	mov    %eax,%edi
    437a:	e8 01 fc ff ff       	call   3f80 <putc>
    437f:	eb 2a                	jmp    43ab <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4381:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4387:	be 25 00 00 00       	mov    $0x25,%esi
    438c:	89 c7                	mov    %eax,%edi
    438e:	e8 ed fb ff ff       	call   3f80 <putc>
        putc(fd, c);
    4393:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    4399:	0f be d0             	movsbl %al,%edx
    439c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    43a2:	89 d6                	mov    %edx,%esi
    43a4:	89 c7                	mov    %eax,%edi
    43a6:	e8 d5 fb ff ff       	call   3f80 <putc>
      }
      state = 0;
    43ab:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    43b2:	00 00 00 
  for(i = 0; fmt[i]; i++){
    43b5:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
    43bc:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    43c2:	48 63 d0             	movslq %eax,%rdx
    43c5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    43cc:	48 01 d0             	add    %rdx,%rax
    43cf:	0f b6 00             	movzbl (%rax),%eax
    43d2:	84 c0                	test   %al,%al
    43d4:	0f 85 3a fd ff ff    	jne    4114 <printf+0xa2>
    }
  }
}
    43da:	90                   	nop
    43db:	90                   	nop
    43dc:	c9                   	leave
    43dd:	c3                   	ret

00000000000043de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    43de:	f3 0f 1e fa          	endbr64
    43e2:	55                   	push   %rbp
    43e3:	48 89 e5             	mov    %rsp,%rbp
    43e6:	48 83 ec 18          	sub    $0x18,%rsp
    43ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    43ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    43f2:	48 83 e8 10          	sub    $0x10,%rax
    43f6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    43fa:	48 8b 05 8f 68 00 00 	mov    0x688f(%rip),%rax        # ac90 <freep>
    4401:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    4405:	eb 2f                	jmp    4436 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    440b:	48 8b 00             	mov    (%rax),%rax
    440e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    4412:	72 17                	jb     442b <free+0x4d>
    4414:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4418:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    441c:	72 2f                	jb     444d <free+0x6f>
    441e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4422:	48 8b 00             	mov    (%rax),%rax
    4425:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    4429:	72 22                	jb     444d <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    442b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    442f:	48 8b 00             	mov    (%rax),%rax
    4432:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    4436:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    443a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    443e:	73 c7                	jae    4407 <free+0x29>
    4440:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4444:	48 8b 00             	mov    (%rax),%rax
    4447:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    444b:	73 ba                	jae    4407 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
    444d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4451:	8b 40 08             	mov    0x8(%rax),%eax
    4454:	89 c0                	mov    %eax,%eax
    4456:	48 c1 e0 04          	shl    $0x4,%rax
    445a:	48 89 c2             	mov    %rax,%rdx
    445d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4461:	48 01 c2             	add    %rax,%rdx
    4464:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4468:	48 8b 00             	mov    (%rax),%rax
    446b:	48 39 c2             	cmp    %rax,%rdx
    446e:	75 2d                	jne    449d <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
    4470:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4474:	8b 50 08             	mov    0x8(%rax),%edx
    4477:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    447b:	48 8b 00             	mov    (%rax),%rax
    447e:	8b 40 08             	mov    0x8(%rax),%eax
    4481:	01 c2                	add    %eax,%edx
    4483:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4487:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    448a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    448e:	48 8b 00             	mov    (%rax),%rax
    4491:	48 8b 10             	mov    (%rax),%rdx
    4494:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4498:	48 89 10             	mov    %rdx,(%rax)
    449b:	eb 0e                	jmp    44ab <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
    449d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44a1:	48 8b 10             	mov    (%rax),%rdx
    44a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    44a8:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    44ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44af:	8b 40 08             	mov    0x8(%rax),%eax
    44b2:	89 c0                	mov    %eax,%eax
    44b4:	48 c1 e0 04          	shl    $0x4,%rax
    44b8:	48 89 c2             	mov    %rax,%rdx
    44bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44bf:	48 01 d0             	add    %rdx,%rax
    44c2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    44c6:	75 27                	jne    44ef <free+0x111>
    p->s.size += bp->s.size;
    44c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44cc:	8b 50 08             	mov    0x8(%rax),%edx
    44cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    44d3:	8b 40 08             	mov    0x8(%rax),%eax
    44d6:	01 c2                	add    %eax,%edx
    44d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44dc:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    44df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    44e3:	48 8b 10             	mov    (%rax),%rdx
    44e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44ea:	48 89 10             	mov    %rdx,(%rax)
    44ed:	eb 0b                	jmp    44fa <free+0x11c>
  } else
    p->s.ptr = bp;
    44ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44f3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    44f7:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    44fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44fe:	48 89 05 8b 67 00 00 	mov    %rax,0x678b(%rip)        # ac90 <freep>
}
    4505:	90                   	nop
    4506:	c9                   	leave
    4507:	c3                   	ret

0000000000004508 <morecore>:

static Header*
morecore(uint nu)
{
    4508:	f3 0f 1e fa          	endbr64
    450c:	55                   	push   %rbp
    450d:	48 89 e5             	mov    %rsp,%rbp
    4510:	48 83 ec 20          	sub    $0x20,%rsp
    4514:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    4517:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    451e:	77 07                	ja     4527 <morecore+0x1f>
    nu = 4096;
    4520:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    4527:	8b 45 ec             	mov    -0x14(%rbp),%eax
    452a:	c1 e0 04             	shl    $0x4,%eax
    452d:	89 c7                	mov    %eax,%edi
    452f:	e8 04 fa ff ff       	call   3f38 <sbrk>
    4534:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    4538:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    453d:	75 07                	jne    4546 <morecore+0x3e>
    return 0;
    453f:	b8 00 00 00 00       	mov    $0x0,%eax
    4544:	eb 29                	jmp    456f <morecore+0x67>
  hp = (Header*)p;
    4546:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    454a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    454e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4552:	8b 55 ec             	mov    -0x14(%rbp),%edx
    4555:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    4558:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    455c:	48 83 c0 10          	add    $0x10,%rax
    4560:	48 89 c7             	mov    %rax,%rdi
    4563:	e8 76 fe ff ff       	call   43de <free>
  return freep;
    4568:	48 8b 05 21 67 00 00 	mov    0x6721(%rip),%rax        # ac90 <freep>
}
    456f:	c9                   	leave
    4570:	c3                   	ret

0000000000004571 <malloc>:

void*
malloc(uint nbytes)
{
    4571:	f3 0f 1e fa          	endbr64
    4575:	55                   	push   %rbp
    4576:	48 89 e5             	mov    %rsp,%rbp
    4579:	48 83 ec 30          	sub    $0x30,%rsp
    457d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4580:	8b 45 dc             	mov    -0x24(%rbp),%eax
    4583:	48 83 c0 0f          	add    $0xf,%rax
    4587:	48 c1 e8 04          	shr    $0x4,%rax
    458b:	83 c0 01             	add    $0x1,%eax
    458e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    4591:	48 8b 05 f8 66 00 00 	mov    0x66f8(%rip),%rax        # ac90 <freep>
    4598:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    459c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    45a1:	75 2b                	jne    45ce <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
    45a3:	48 c7 45 f0 80 ac 00 	movq   $0xac80,-0x10(%rbp)
    45aa:	00 
    45ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    45af:	48 89 05 da 66 00 00 	mov    %rax,0x66da(%rip)        # ac90 <freep>
    45b6:	48 8b 05 d3 66 00 00 	mov    0x66d3(%rip),%rax        # ac90 <freep>
    45bd:	48 89 05 bc 66 00 00 	mov    %rax,0x66bc(%rip)        # ac80 <base>
    base.s.size = 0;
    45c4:	c7 05 ba 66 00 00 00 	movl   $0x0,0x66ba(%rip)        # ac88 <base+0x8>
    45cb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    45ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    45d2:	48 8b 00             	mov    (%rax),%rax
    45d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    45d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    45dd:	8b 40 08             	mov    0x8(%rax),%eax
    45e0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    45e3:	72 5f                	jb     4644 <malloc+0xd3>
      if(p->s.size == nunits)
    45e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    45e9:	8b 40 08             	mov    0x8(%rax),%eax
    45ec:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    45ef:	75 10                	jne    4601 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
    45f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    45f5:	48 8b 10             	mov    (%rax),%rdx
    45f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    45fc:	48 89 10             	mov    %rdx,(%rax)
    45ff:	eb 2e                	jmp    462f <malloc+0xbe>
      else {
        p->s.size -= nunits;
    4601:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4605:	8b 40 08             	mov    0x8(%rax),%eax
    4608:	2b 45 ec             	sub    -0x14(%rbp),%eax
    460b:	89 c2                	mov    %eax,%edx
    460d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4611:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    4614:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4618:	8b 40 08             	mov    0x8(%rax),%eax
    461b:	89 c0                	mov    %eax,%eax
    461d:	48 c1 e0 04          	shl    $0x4,%rax
    4621:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    4625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4629:	8b 55 ec             	mov    -0x14(%rbp),%edx
    462c:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    462f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4633:	48 89 05 56 66 00 00 	mov    %rax,0x6656(%rip)        # ac90 <freep>
      return (void*)(p + 1);
    463a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    463e:	48 83 c0 10          	add    $0x10,%rax
    4642:	eb 41                	jmp    4685 <malloc+0x114>
    }
    if(p == freep)
    4644:	48 8b 05 45 66 00 00 	mov    0x6645(%rip),%rax        # ac90 <freep>
    464b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    464f:	75 1c                	jne    466d <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
    4651:	8b 45 ec             	mov    -0x14(%rbp),%eax
    4654:	89 c7                	mov    %eax,%edi
    4656:	e8 ad fe ff ff       	call   4508 <morecore>
    465b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    465f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    4664:	75 07                	jne    466d <malloc+0xfc>
        return 0;
    4666:	b8 00 00 00 00       	mov    $0x0,%eax
    466b:	eb 18                	jmp    4685 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    466d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4671:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    4675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4679:	48 8b 00             	mov    (%rax),%rax
    467c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    4680:	e9 54 ff ff ff       	jmp    45d9 <malloc+0x68>
  }
}
    4685:	c9                   	leave
    4686:	c3                   	ret
