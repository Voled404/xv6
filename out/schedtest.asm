
fs/schedtest:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <spin>:
#define LTICKS(x) (x * 1000000)

/* A function to spend some CPU cycles on */
void 
spin(int J)
{
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 18          	sub    $0x18,%rsp
   c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    int i = 0;
   f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    int j = 0;
  16:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    int k = 0;
  1d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for (i = 0; i < 50; i++) 
  24:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2b:	eb 44                	jmp    71 <spin+0x71>
    {
        for (j = 0; j < J; j++) 
  2d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  34:	eb 2f                	jmp    65 <spin+0x65>
        {
            k = j % 10;
  36:	8b 55 f8             	mov    -0x8(%rbp),%edx
  39:	48 63 c2             	movslq %edx,%rax
  3c:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
  43:	48 c1 e8 20          	shr    $0x20,%rax
  47:	89 c1                	mov    %eax,%ecx
  49:	c1 f9 02             	sar    $0x2,%ecx
  4c:	89 d0                	mov    %edx,%eax
  4e:	c1 f8 1f             	sar    $0x1f,%eax
  51:	29 c1                	sub    %eax,%ecx
  53:	89 c8                	mov    %ecx,%eax
  55:	c1 e0 02             	shl    $0x2,%eax
  58:	01 c8                	add    %ecx,%eax
  5a:	01 c0                	add    %eax,%eax
  5c:	29 c2                	sub    %eax,%edx
  5e:	89 55 f4             	mov    %edx,-0xc(%rbp)
        for (j = 0; j < J; j++) 
  61:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  65:	8b 45 f8             	mov    -0x8(%rbp),%eax
  68:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  6b:	7c c9                	jl     36 <spin+0x36>
    for (i = 0; i < 50; i++) 
  6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  71:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
  75:	7e b6                	jle    2d <spin+0x2d>
        }
    }

    (void)k; /* unused variable is unused :) */
}
  77:	90                   	nop
  78:	90                   	nop
  79:	c9                   	leave
  7a:	c3                   	ret

000000000000007b <print_info>:

/* Print information about each of the running processes */

void
print_info(struct pstat *pstat, int j)
{
  7b:	f3 0f 1e fa          	endbr64
  7f:	55                   	push   %rbp
  80:	48 89 e5             	mov    %rsp,%rbp
  83:	48 83 ec 10          	sub    $0x10,%rsp
  87:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    printf(1, "%d\t%d\t", pstat->pid[j], pstat->ticks[j]);
  8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  92:	8b 55 f4             	mov    -0xc(%rbp),%edx
  95:	48 63 d2             	movslq %edx,%rdx
  98:	48 81 c2 c0 00 00 00 	add    $0xc0,%rdx
  9f:	8b 14 90             	mov    (%rax,%rdx,4),%edx
  a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  a6:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  a9:	48 63 c9             	movslq %ecx,%rcx
  ac:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
  b0:	8b 04 88             	mov    (%rax,%rcx,4),%eax
  b3:	89 d1                	mov    %edx,%ecx
  b5:	89 c2                	mov    %eax,%edx
  b7:	48 c7 c6 8c 0e 00 00 	mov    $0xe8c,%rsi
  be:	bf 01 00 00 00       	mov    $0x1,%edi
  c3:	b8 00 00 00 00       	mov    $0x0,%eax
  c8:	e8 aa 07 00 00       	call   877 <printf>

    if (pstat->inuse[j] == 1) 
  cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  d4:	48 63 d2             	movslq %edx,%rdx
  d7:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  da:	83 f8 01             	cmp    $0x1,%eax
  dd:	75 18                	jne    f7 <print_info+0x7c>
    {
        printf(1, "YES");
  df:	48 c7 c6 93 0e 00 00 	mov    $0xe93,%rsi
  e6:	bf 01 00 00 00       	mov    $0x1,%edi
  eb:	b8 00 00 00 00       	mov    $0x0,%eax
  f0:	e8 82 07 00 00       	call   877 <printf>
  f5:	eb 16                	jmp    10d <print_info+0x92>
    }
    else 
    {
        printf(1, "NO");
  f7:	48 c7 c6 97 0e 00 00 	mov    $0xe97,%rsi
  fe:	bf 01 00 00 00       	mov    $0x1,%edi
 103:	b8 00 00 00 00       	mov    $0x0,%eax
 108:	e8 6a 07 00 00       	call   877 <printf>
    }

    printf(1, "\n");
 10d:	48 c7 c6 9a 0e 00 00 	mov    $0xe9a,%rsi
 114:	bf 01 00 00 00       	mov    $0x1,%edi
 119:	b8 00 00 00 00       	mov    $0x0,%eax
 11e:	e8 54 07 00 00       	call   877 <printf>
}
 123:	90                   	nop
 124:	c9                   	leave
 125:	c3                   	ret

0000000000000126 <find_pid>:

/* Return the index of a process inside the pstat array */
int
find_pid(struct pstat *pstat, int pid)
{
 126:	f3 0f 1e fa          	endbr64
 12a:	55                   	push   %rbp
 12b:	48 89 e5             	mov    %rsp,%rbp
 12e:	48 83 ec 20          	sub    $0x20,%rsp
 132:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 136:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    int i;
    for (i = 0; i < NPROC; i++)
 139:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 140:	eb 1f                	jmp    161 <find_pid+0x3b>
    {
        if (pstat->pid[i] == pid) 
 142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 146:	8b 55 fc             	mov    -0x4(%rbp),%edx
 149:	48 63 d2             	movslq %edx,%rdx
 14c:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
 150:	8b 04 90             	mov    (%rax,%rdx,4),%eax
 153:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 156:	75 05                	jne    15d <find_pid+0x37>
        {
            return i;
 158:	8b 45 fc             	mov    -0x4(%rbp),%eax
 15b:	eb 0f                	jmp    16c <find_pid+0x46>
    for (i = 0; i < NPROC; i++)
 15d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 161:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
 165:	7e db                	jle    142 <find_pid+0x1c>
        }
    }
    return -1;
 167:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 16c:	c9                   	leave
 16d:	c3                   	ret

000000000000016e <main>:
// Uncomment the below line after you've implemented the "settickets" system call
// #define TICKETS 

int
main(int argc, char *argv[])
{
 16e:	f3 0f 1e fa          	endbr64
 172:	55                   	push   %rbp
 173:	48 89 e5             	mov    %rsp,%rbp
 176:	48 81 ec 50 04 00 00 	sub    $0x450,%rsp
 17d:	89 bd bc fb ff ff    	mov    %edi,-0x444(%rbp)
 183:	48 89 b5 b0 fb ff ff 	mov    %rsi,-0x450(%rbp)

    int pid_chds[N_C_PROCS];

    int n_tickets[N_C_PROCS]={2,1,300};
 18a:	c7 45 cc 02 00 00 00 	movl   $0x2,-0x34(%rbp)
 191:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%rbp)
 198:	c7 45 d4 2c 01 00 00 	movl   $0x12c,-0x2c(%rbp)
    pid_chds[0] = getpid();
 19f:	e8 b1 05 00 00       	call   755 <getpid>
 1a4:	89 45 d8             	mov    %eax,-0x28(%rbp)
#ifdef TICKETS
    settickets(n_tickets[0]);
#endif

    int i; 
    for (i = 1; i < N_C_PROCS; i++) 
 1a7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 1ae:	eb 36                	jmp    1e6 <main+0x78>
    {
        if ((pid_chds[i] = fork()) == 0) 
 1b0:	e8 18 05 00 00       	call   6cd <fork>
 1b5:	8b 55 fc             	mov    -0x4(%rbp),%edx
 1b8:	48 63 d2             	movslq %edx,%rdx
 1bb:	89 44 95 d8          	mov    %eax,-0x28(%rbp,%rdx,4)
 1bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1c2:	48 98                	cltq
 1c4:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 1c8:	85 c0                	test   %eax,%eax
 1ca:	75 16                	jne    1e2 <main+0x74>
        {
#ifdef TICKETS
            settickets(n_tickets[i]);
#endif
            int n_spin = LTICKS(5);
 1cc:	c7 45 e4 40 4b 4c 00 	movl   $0x4c4b40,-0x1c(%rbp)
            spin(n_spin);
 1d3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
 1d6:	89 c7                	mov    %eax,%edi
 1d8:	e8 23 fe ff ff       	call   0 <spin>
            exit();
 1dd:	e8 f3 04 00 00       	call   6d5 <exit>
    for (i = 1; i < N_C_PROCS; i++) 
 1e2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1e6:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 1ea:	7e c4                	jle    1b0 <main+0x42>
        }
    }

    struct pstat pstat;
    int t = 0;
 1ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

    printf(1, "PIDs of child processes:\n");
 1f3:	48 c7 c6 9c 0e 00 00 	mov    $0xe9c,%rsi
 1fa:	bf 01 00 00 00       	mov    $0x1,%edi
 1ff:	b8 00 00 00 00       	mov    $0x0,%eax
 204:	e8 6e 06 00 00       	call   877 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 210:	eb 25                	jmp    237 <main+0xc9>
    {
        printf(1, "- pid %d\n", pid_chds[i]);
 212:	8b 45 fc             	mov    -0x4(%rbp),%eax
 215:	48 98                	cltq
 217:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 21b:	89 c2                	mov    %eax,%edx
 21d:	48 c7 c6 b6 0e 00 00 	mov    $0xeb6,%rsi
 224:	bf 01 00 00 00       	mov    $0x1,%edi
 229:	b8 00 00 00 00       	mov    $0x0,%eax
 22e:	e8 44 06 00 00       	call   877 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 233:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 237:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 23b:	7e d5                	jle    212 <main+0xa4>
    }
    printf(1, "\n");
 23d:	48 c7 c6 9a 0e 00 00 	mov    $0xe9a,%rsi
 244:	bf 01 00 00 00       	mov    $0x1,%edi
 249:	b8 00 00 00 00       	mov    $0x0,%eax
 24e:	e8 24 06 00 00       	call   877 <printf>

    printf(1, "PID\tTICKS\tIN USE\n");
 253:	48 c7 c6 c0 0e 00 00 	mov    $0xec0,%rsi
 25a:	bf 01 00 00 00       	mov    $0x1,%edi
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
 264:	e8 0e 06 00 00       	call   877 <printf>
    
    // int n_time = atoi(argv[1]); /* You can pass the number of time-steps as a command line argument if you uncomment this. Hard-coded for now. */
    int n_time = TIMESTEPS;
 269:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)

    spin(LTICKS(1));
 270:	bf 40 42 0f 00       	mov    $0xf4240,%edi
 275:	e8 86 fd ff ff       	call   0 <spin>

    /* Every few seconds, print the process information. */
    while (t < n_time) 
 27a:	e9 f0 00 00 00       	jmp    36f <main+0x201>
    {
        
        if (getpinfo(&pstat) != 0) 
 27f:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 286:	48 89 c7             	mov    %rax,%rdi
 289:	e8 e7 04 00 00       	call   775 <getpinfo>
 28e:	85 c0                	test   %eax,%eax
 290:	74 1b                	je     2ad <main+0x13f>
        {
            printf(1, "getpinfo failed\n");
 292:	48 c7 c6 d2 0e 00 00 	mov    $0xed2,%rsi
 299:	bf 01 00 00 00       	mov    $0x1,%edi
 29e:	b8 00 00 00 00       	mov    $0x0,%eax
 2a3:	e8 cf 05 00 00       	call   877 <printf>
            goto exit;
 2a8:	e9 d1 00 00 00       	jmp    37e <main+0x210>
        }

        int j; int pid;
        for (i = 0; i < N_C_PROCS; i++)
 2ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2b4:	eb 3b                	jmp    2f1 <main+0x183>
        {
            pid = pid_chds[i];
 2b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2b9:	48 98                	cltq
 2bb:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 2bf:	89 45 e8             	mov    %eax,-0x18(%rbp)
            j = find_pid(&pstat, pid);
 2c2:	8b 55 e8             	mov    -0x18(%rbp),%edx
 2c5:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 2cc:	89 d6                	mov    %edx,%esi
 2ce:	48 89 c7             	mov    %rax,%rdi
 2d1:	e8 50 fe ff ff       	call   126 <find_pid>
 2d6:	89 45 ec             	mov    %eax,-0x14(%rbp)
            print_info(&pstat, j);
 2d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 2dc:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 2e3:	89 d6                	mov    %edx,%esi
 2e5:	48 89 c7             	mov    %rax,%rdi
 2e8:	e8 8e fd ff ff       	call   7b <print_info>
        for (i = 0; i < N_C_PROCS; i++)
 2ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 2f1:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 2f5:	7e bf                	jle    2b6 <main+0x148>
        }

        int all_done = 1;
 2f7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
        for (i = 1; i < N_C_PROCS; i++)
 2fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 305:	eb 38                	jmp    33f <main+0x1d1>
        {
            j = find_pid(&pstat, pid_chds[i]);
 307:	8b 45 fc             	mov    -0x4(%rbp),%eax
 30a:	48 98                	cltq
 30c:	8b 54 85 d8          	mov    -0x28(%rbp,%rax,4),%edx
 310:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 317:	89 d6                	mov    %edx,%esi
 319:	48 89 c7             	mov    %rax,%rdi
 31c:	e8 05 fe ff ff       	call   126 <find_pid>
 321:	89 45 ec             	mov    %eax,-0x14(%rbp)
            all_done &= !pstat.inuse[j];
 324:	8b 45 ec             	mov    -0x14(%rbp),%eax
 327:	48 98                	cltq
 329:	8b 84 85 c0 fb ff ff 	mov    -0x440(%rbp,%rax,4),%eax
 330:	85 c0                	test   %eax,%eax
 332:	0f 94 c0             	sete   %al
 335:	0f b6 c0             	movzbl %al,%eax
 338:	21 45 f4             	and    %eax,-0xc(%rbp)
        for (i = 1; i < N_C_PROCS; i++)
 33b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 33f:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 343:	7e c2                	jle    307 <main+0x199>
        }
        if (all_done) break;
 345:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 349:	75 32                	jne    37d <main+0x20f>

        spin(LTICKS(1));
 34b:	bf 40 42 0f 00       	mov    $0xf4240,%edi
 350:	e8 ab fc ff ff       	call   0 <spin>
        t++;
 355:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        printf(1, "\n");
 359:	48 c7 c6 9a 0e 00 00 	mov    $0xe9a,%rsi
 360:	bf 01 00 00 00       	mov    $0x1,%edi
 365:	b8 00 00 00 00       	mov    $0x0,%eax
 36a:	e8 08 05 00 00       	call   877 <printf>
    while (t < n_time) 
 36f:	8b 45 f8             	mov    -0x8(%rbp),%eax
 372:	3b 45 f0             	cmp    -0x10(%rbp),%eax
 375:	0f 8c 04 ff ff ff    	jl     27f <main+0x111>
    }

    /* Finally, kill all child processes. */
exit:
 37b:	eb 01                	jmp    37e <main+0x210>
        if (all_done) break;
 37d:	90                   	nop
    for (i = 1; pid_chds[i] > 0 && i < N_C_PROCS; i++) 
 37e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 385:	eb 14                	jmp    39b <main+0x22d>
    {
        kill(pid_chds[i]);
 387:	8b 45 fc             	mov    -0x4(%rbp),%eax
 38a:	48 98                	cltq
 38c:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 390:	89 c7                	mov    %eax,%edi
 392:	e8 6e 03 00 00       	call   705 <kill>
    for (i = 1; pid_chds[i] > 0 && i < N_C_PROCS; i++) 
 397:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 39b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 39e:	48 98                	cltq
 3a0:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 3a4:	85 c0                	test   %eax,%eax
 3a6:	7e 06                	jle    3ae <main+0x240>
 3a8:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 3ac:	7e d9                	jle    387 <main+0x219>
    }
    while(wait() != -1);
 3ae:	90                   	nop
 3af:	e8 29 03 00 00       	call   6dd <wait>
 3b4:	83 f8 ff             	cmp    $0xffffffff,%eax
 3b7:	75 f6                	jne    3af <main+0x241>

    exit();
 3b9:	e8 17 03 00 00       	call   6d5 <exit>

00000000000003be <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3be:	55                   	push   %rbp
 3bf:	48 89 e5             	mov    %rsp,%rbp
 3c2:	48 83 ec 10          	sub    $0x10,%rsp
 3c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3ca:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3cd:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3d0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3d4:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3d7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3da:	48 89 ce             	mov    %rcx,%rsi
 3dd:	48 89 f7             	mov    %rsi,%rdi
 3e0:	89 d1                	mov    %edx,%ecx
 3e2:	fc                   	cld
 3e3:	f3 aa                	rep stos %al,%es:(%rdi)
 3e5:	89 ca                	mov    %ecx,%edx
 3e7:	48 89 fe             	mov    %rdi,%rsi
 3ea:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 3ee:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3f1:	90                   	nop
 3f2:	c9                   	leave
 3f3:	c3                   	ret

00000000000003f4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3f4:	f3 0f 1e fa          	endbr64
 3f8:	55                   	push   %rbp
 3f9:	48 89 e5             	mov    %rsp,%rbp
 3fc:	48 83 ec 20          	sub    $0x20,%rsp
 400:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 404:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 408:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 40c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 410:	90                   	nop
 411:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 415:	48 8d 42 01          	lea    0x1(%rdx),%rax
 419:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 41d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 421:	48 8d 48 01          	lea    0x1(%rax),%rcx
 425:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 429:	0f b6 12             	movzbl (%rdx),%edx
 42c:	88 10                	mov    %dl,(%rax)
 42e:	0f b6 00             	movzbl (%rax),%eax
 431:	84 c0                	test   %al,%al
 433:	75 dc                	jne    411 <strcpy+0x1d>
    ;
  return os;
 435:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 439:	c9                   	leave
 43a:	c3                   	ret

000000000000043b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 43b:	f3 0f 1e fa          	endbr64
 43f:	55                   	push   %rbp
 440:	48 89 e5             	mov    %rsp,%rbp
 443:	48 83 ec 10          	sub    $0x10,%rsp
 447:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 44b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 44f:	eb 0a                	jmp    45b <strcmp+0x20>
    p++, q++;
 451:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 456:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 45b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 45f:	0f b6 00             	movzbl (%rax),%eax
 462:	84 c0                	test   %al,%al
 464:	74 12                	je     478 <strcmp+0x3d>
 466:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 46a:	0f b6 10             	movzbl (%rax),%edx
 46d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 471:	0f b6 00             	movzbl (%rax),%eax
 474:	38 c2                	cmp    %al,%dl
 476:	74 d9                	je     451 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 478:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 47c:	0f b6 00             	movzbl (%rax),%eax
 47f:	0f b6 d0             	movzbl %al,%edx
 482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 486:	0f b6 00             	movzbl (%rax),%eax
 489:	0f b6 c0             	movzbl %al,%eax
 48c:	29 c2                	sub    %eax,%edx
 48e:	89 d0                	mov    %edx,%eax
}
 490:	c9                   	leave
 491:	c3                   	ret

0000000000000492 <strlen>:

uint
strlen(char *s)
{
 492:	f3 0f 1e fa          	endbr64
 496:	55                   	push   %rbp
 497:	48 89 e5             	mov    %rsp,%rbp
 49a:	48 83 ec 18          	sub    $0x18,%rsp
 49e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 4a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 4a9:	eb 04                	jmp    4af <strlen+0x1d>
 4ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 4af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4b2:	48 63 d0             	movslq %eax,%rdx
 4b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4b9:	48 01 d0             	add    %rdx,%rax
 4bc:	0f b6 00             	movzbl (%rax),%eax
 4bf:	84 c0                	test   %al,%al
 4c1:	75 e8                	jne    4ab <strlen+0x19>
    ;
  return n;
 4c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4c6:	c9                   	leave
 4c7:	c3                   	ret

00000000000004c8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4c8:	f3 0f 1e fa          	endbr64
 4cc:	55                   	push   %rbp
 4cd:	48 89 e5             	mov    %rsp,%rbp
 4d0:	48 83 ec 10          	sub    $0x10,%rsp
 4d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4d8:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4db:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4de:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4e1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4e8:	89 ce                	mov    %ecx,%esi
 4ea:	48 89 c7             	mov    %rax,%rdi
 4ed:	e8 cc fe ff ff       	call   3be <stosb>
  return dst;
 4f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 4f6:	c9                   	leave
 4f7:	c3                   	ret

00000000000004f8 <strchr>:

char*
strchr(const char *s, char c)
{
 4f8:	f3 0f 1e fa          	endbr64
 4fc:	55                   	push   %rbp
 4fd:	48 89 e5             	mov    %rsp,%rbp
 500:	48 83 ec 10          	sub    $0x10,%rsp
 504:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 508:	89 f0                	mov    %esi,%eax
 50a:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 50d:	eb 17                	jmp    526 <strchr+0x2e>
    if(*s == c)
 50f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 513:	0f b6 00             	movzbl (%rax),%eax
 516:	38 45 f4             	cmp    %al,-0xc(%rbp)
 519:	75 06                	jne    521 <strchr+0x29>
      return (char*)s;
 51b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 51f:	eb 15                	jmp    536 <strchr+0x3e>
  for(; *s; s++)
 521:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 526:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 52a:	0f b6 00             	movzbl (%rax),%eax
 52d:	84 c0                	test   %al,%al
 52f:	75 de                	jne    50f <strchr+0x17>
  return 0;
 531:	b8 00 00 00 00       	mov    $0x0,%eax
}
 536:	c9                   	leave
 537:	c3                   	ret

0000000000000538 <gets>:

char*
gets(char *buf, int max)
{
 538:	f3 0f 1e fa          	endbr64
 53c:	55                   	push   %rbp
 53d:	48 89 e5             	mov    %rsp,%rbp
 540:	48 83 ec 20          	sub    $0x20,%rsp
 544:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 548:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 54b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 552:	eb 48                	jmp    59c <gets+0x64>
    cc = read(0, &c, 1);
 554:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 558:	ba 01 00 00 00       	mov    $0x1,%edx
 55d:	48 89 c6             	mov    %rax,%rsi
 560:	bf 00 00 00 00       	mov    $0x0,%edi
 565:	e8 83 01 00 00       	call   6ed <read>
 56a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 56d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 571:	7e 36                	jle    5a9 <gets+0x71>
      break;
    buf[i++] = c;
 573:	8b 45 fc             	mov    -0x4(%rbp),%eax
 576:	8d 50 01             	lea    0x1(%rax),%edx
 579:	89 55 fc             	mov    %edx,-0x4(%rbp)
 57c:	48 63 d0             	movslq %eax,%rdx
 57f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 583:	48 01 c2             	add    %rax,%rdx
 586:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 58a:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 58c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 590:	3c 0a                	cmp    $0xa,%al
 592:	74 16                	je     5aa <gets+0x72>
 594:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 598:	3c 0d                	cmp    $0xd,%al
 59a:	74 0e                	je     5aa <gets+0x72>
  for(i=0; i+1 < max; ){
 59c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 59f:	83 c0 01             	add    $0x1,%eax
 5a2:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 5a5:	7f ad                	jg     554 <gets+0x1c>
 5a7:	eb 01                	jmp    5aa <gets+0x72>
      break;
 5a9:	90                   	nop
      break;
  }
  buf[i] = '\0';
 5aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5ad:	48 63 d0             	movslq %eax,%rdx
 5b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5b4:	48 01 d0             	add    %rdx,%rax
 5b7:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 5ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 5be:	c9                   	leave
 5bf:	c3                   	ret

00000000000005c0 <stat>:

int
stat(char *n, struct stat *st)
{
 5c0:	f3 0f 1e fa          	endbr64
 5c4:	55                   	push   %rbp
 5c5:	48 89 e5             	mov    %rsp,%rbp
 5c8:	48 83 ec 20          	sub    $0x20,%rsp
 5cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 5d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5d8:	be 00 00 00 00       	mov    $0x0,%esi
 5dd:	48 89 c7             	mov    %rax,%rdi
 5e0:	e8 30 01 00 00       	call   715 <open>
 5e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5ec:	79 07                	jns    5f5 <stat+0x35>
    return -1;
 5ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5f3:	eb 21                	jmp    616 <stat+0x56>
  r = fstat(fd, st);
 5f5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 5f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5fc:	48 89 d6             	mov    %rdx,%rsi
 5ff:	89 c7                	mov    %eax,%edi
 601:	e8 27 01 00 00       	call   72d <fstat>
 606:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 609:	8b 45 fc             	mov    -0x4(%rbp),%eax
 60c:	89 c7                	mov    %eax,%edi
 60e:	e8 ea 00 00 00       	call   6fd <close>
  return r;
 613:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 616:	c9                   	leave
 617:	c3                   	ret

0000000000000618 <atoi>:

int
atoi(const char *s)
{
 618:	f3 0f 1e fa          	endbr64
 61c:	55                   	push   %rbp
 61d:	48 89 e5             	mov    %rsp,%rbp
 620:	48 83 ec 18          	sub    $0x18,%rsp
 624:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 628:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 62f:	eb 28                	jmp    659 <atoi+0x41>
    n = n*10 + *s++ - '0';
 631:	8b 55 fc             	mov    -0x4(%rbp),%edx
 634:	89 d0                	mov    %edx,%eax
 636:	c1 e0 02             	shl    $0x2,%eax
 639:	01 d0                	add    %edx,%eax
 63b:	01 c0                	add    %eax,%eax
 63d:	89 c1                	mov    %eax,%ecx
 63f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 643:	48 8d 50 01          	lea    0x1(%rax),%rdx
 647:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 64b:	0f b6 00             	movzbl (%rax),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	01 c8                	add    %ecx,%eax
 653:	83 e8 30             	sub    $0x30,%eax
 656:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 659:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 65d:	0f b6 00             	movzbl (%rax),%eax
 660:	3c 2f                	cmp    $0x2f,%al
 662:	7e 0b                	jle    66f <atoi+0x57>
 664:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 668:	0f b6 00             	movzbl (%rax),%eax
 66b:	3c 39                	cmp    $0x39,%al
 66d:	7e c2                	jle    631 <atoi+0x19>
  return n;
 66f:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 672:	c9                   	leave
 673:	c3                   	ret

0000000000000674 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 674:	f3 0f 1e fa          	endbr64
 678:	55                   	push   %rbp
 679:	48 89 e5             	mov    %rsp,%rbp
 67c:	48 83 ec 28          	sub    $0x28,%rsp
 680:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 684:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 688:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 68b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 68f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 693:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 697:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 69b:	eb 1d                	jmp    6ba <memmove+0x46>
    *dst++ = *src++;
 69d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 6a1:	48 8d 42 01          	lea    0x1(%rdx),%rax
 6a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 6a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 6ad:	48 8d 48 01          	lea    0x1(%rax),%rcx
 6b1:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 6b5:	0f b6 12             	movzbl (%rdx),%edx
 6b8:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 6ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
 6bd:	8d 50 ff             	lea    -0x1(%rax),%edx
 6c0:	89 55 dc             	mov    %edx,-0x24(%rbp)
 6c3:	85 c0                	test   %eax,%eax
 6c5:	7f d6                	jg     69d <memmove+0x29>
  return vdst;
 6c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 6cb:	c9                   	leave
 6cc:	c3                   	ret

00000000000006cd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6cd:	b8 01 00 00 00       	mov    $0x1,%eax
 6d2:	cd 40                	int    $0x40
 6d4:	c3                   	ret

00000000000006d5 <exit>:
SYSCALL(exit)
 6d5:	b8 02 00 00 00       	mov    $0x2,%eax
 6da:	cd 40                	int    $0x40
 6dc:	c3                   	ret

00000000000006dd <wait>:
SYSCALL(wait)
 6dd:	b8 03 00 00 00       	mov    $0x3,%eax
 6e2:	cd 40                	int    $0x40
 6e4:	c3                   	ret

00000000000006e5 <pipe>:
SYSCALL(pipe)
 6e5:	b8 04 00 00 00       	mov    $0x4,%eax
 6ea:	cd 40                	int    $0x40
 6ec:	c3                   	ret

00000000000006ed <read>:
SYSCALL(read)
 6ed:	b8 05 00 00 00       	mov    $0x5,%eax
 6f2:	cd 40                	int    $0x40
 6f4:	c3                   	ret

00000000000006f5 <write>:
SYSCALL(write)
 6f5:	b8 10 00 00 00       	mov    $0x10,%eax
 6fa:	cd 40                	int    $0x40
 6fc:	c3                   	ret

00000000000006fd <close>:
SYSCALL(close)
 6fd:	b8 15 00 00 00       	mov    $0x15,%eax
 702:	cd 40                	int    $0x40
 704:	c3                   	ret

0000000000000705 <kill>:
SYSCALL(kill)
 705:	b8 06 00 00 00       	mov    $0x6,%eax
 70a:	cd 40                	int    $0x40
 70c:	c3                   	ret

000000000000070d <exec>:
SYSCALL(exec)
 70d:	b8 07 00 00 00       	mov    $0x7,%eax
 712:	cd 40                	int    $0x40
 714:	c3                   	ret

0000000000000715 <open>:
SYSCALL(open)
 715:	b8 0f 00 00 00       	mov    $0xf,%eax
 71a:	cd 40                	int    $0x40
 71c:	c3                   	ret

000000000000071d <mknod>:
SYSCALL(mknod)
 71d:	b8 11 00 00 00       	mov    $0x11,%eax
 722:	cd 40                	int    $0x40
 724:	c3                   	ret

0000000000000725 <unlink>:
SYSCALL(unlink)
 725:	b8 12 00 00 00       	mov    $0x12,%eax
 72a:	cd 40                	int    $0x40
 72c:	c3                   	ret

000000000000072d <fstat>:
SYSCALL(fstat)
 72d:	b8 08 00 00 00       	mov    $0x8,%eax
 732:	cd 40                	int    $0x40
 734:	c3                   	ret

0000000000000735 <link>:
SYSCALL(link)
 735:	b8 13 00 00 00       	mov    $0x13,%eax
 73a:	cd 40                	int    $0x40
 73c:	c3                   	ret

000000000000073d <mkdir>:
SYSCALL(mkdir)
 73d:	b8 14 00 00 00       	mov    $0x14,%eax
 742:	cd 40                	int    $0x40
 744:	c3                   	ret

0000000000000745 <chdir>:
SYSCALL(chdir)
 745:	b8 09 00 00 00       	mov    $0x9,%eax
 74a:	cd 40                	int    $0x40
 74c:	c3                   	ret

000000000000074d <dup>:
SYSCALL(dup)
 74d:	b8 0a 00 00 00       	mov    $0xa,%eax
 752:	cd 40                	int    $0x40
 754:	c3                   	ret

0000000000000755 <getpid>:
SYSCALL(getpid)
 755:	b8 0b 00 00 00       	mov    $0xb,%eax
 75a:	cd 40                	int    $0x40
 75c:	c3                   	ret

000000000000075d <sbrk>:
SYSCALL(sbrk)
 75d:	b8 0c 00 00 00       	mov    $0xc,%eax
 762:	cd 40                	int    $0x40
 764:	c3                   	ret

0000000000000765 <sleep>:
SYSCALL(sleep)
 765:	b8 0d 00 00 00       	mov    $0xd,%eax
 76a:	cd 40                	int    $0x40
 76c:	c3                   	ret

000000000000076d <uptime>:
SYSCALL(uptime)
 76d:	b8 0e 00 00 00       	mov    $0xe,%eax
 772:	cd 40                	int    $0x40
 774:	c3                   	ret

0000000000000775 <getpinfo>:
SYSCALL(getpinfo)
 775:	b8 18 00 00 00       	mov    $0x18,%eax
 77a:	cd 40                	int    $0x40
 77c:	c3                   	ret

000000000000077d <settickets>:
SYSCALL(settickets)
 77d:	b8 1b 00 00 00       	mov    $0x1b,%eax
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
 7aa:	e8 46 ff ff ff       	call   6f5 <write>
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
 ac0:	48 c7 85 48 ff ff ff 	movq   $0xee3,-0xb8(%rbp)
 ac7:	e3 0e 00 00 
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
 bff:	48 8b 05 ba 05 00 00 	mov    0x5ba(%rip),%rax        # 11c0 <freep>
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
 d03:	48 89 05 b6 04 00 00 	mov    %rax,0x4b6(%rip)        # 11c0 <freep>
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
 d34:	e8 24 fa ff ff       	call   75d <sbrk>
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
 d6d:	48 8b 05 4c 04 00 00 	mov    0x44c(%rip),%rax        # 11c0 <freep>
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
 d96:	48 8b 05 23 04 00 00 	mov    0x423(%rip),%rax        # 11c0 <freep>
 d9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 da1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 da6:	75 2b                	jne    dd3 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 da8:	48 c7 45 f0 b0 11 00 	movq   $0x11b0,-0x10(%rbp)
 daf:	00 
 db0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 db4:	48 89 05 05 04 00 00 	mov    %rax,0x405(%rip)        # 11c0 <freep>
 dbb:	48 8b 05 fe 03 00 00 	mov    0x3fe(%rip),%rax        # 11c0 <freep>
 dc2:	48 89 05 e7 03 00 00 	mov    %rax,0x3e7(%rip)        # 11b0 <base>
    base.s.size = 0;
 dc9:	c7 05 e5 03 00 00 00 	movl   $0x0,0x3e5(%rip)        # 11b8 <base+0x8>
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
 e38:	48 89 05 81 03 00 00 	mov    %rax,0x381(%rip)        # 11c0 <freep>
      return (void*)(p + 1);
 e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e43:	48 83 c0 10          	add    $0x10,%rax
 e47:	eb 41                	jmp    e8a <malloc+0x114>
    }
    if(p == freep)
 e49:	48 8b 05 70 03 00 00 	mov    0x370(%rip),%rax        # 11c0 <freep>
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
