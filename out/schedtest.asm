
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
  b7:	48 c7 c6 9c 0e 00 00 	mov    $0xe9c,%rsi
  be:	bf 01 00 00 00       	mov    $0x1,%edi
  c3:	b8 00 00 00 00       	mov    $0x0,%eax
  c8:	e8 ba 07 00 00       	call   887 <printf>

    if (pstat->inuse[j] == 1) 
  cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  d4:	48 63 d2             	movslq %edx,%rdx
  d7:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  da:	83 f8 01             	cmp    $0x1,%eax
  dd:	75 18                	jne    f7 <print_info+0x7c>
    {
        printf(1, "YES");
  df:	48 c7 c6 a3 0e 00 00 	mov    $0xea3,%rsi
  e6:	bf 01 00 00 00       	mov    $0x1,%edi
  eb:	b8 00 00 00 00       	mov    $0x0,%eax
  f0:	e8 92 07 00 00       	call   887 <printf>
  f5:	eb 16                	jmp    10d <print_info+0x92>
    }
    else 
    {
        printf(1, "NO");
  f7:	48 c7 c6 a7 0e 00 00 	mov    $0xea7,%rsi
  fe:	bf 01 00 00 00       	mov    $0x1,%edi
 103:	b8 00 00 00 00       	mov    $0x0,%eax
 108:	e8 7a 07 00 00       	call   887 <printf>
    }

    printf(1, "\n");
 10d:	48 c7 c6 aa 0e 00 00 	mov    $0xeaa,%rsi
 114:	bf 01 00 00 00       	mov    $0x1,%edi
 119:	b8 00 00 00 00       	mov    $0x0,%eax
 11e:	e8 64 07 00 00       	call   887 <printf>
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
 1f3:	48 c7 c6 ac 0e 00 00 	mov    $0xeac,%rsi
 1fa:	bf 01 00 00 00       	mov    $0x1,%edi
 1ff:	b8 00 00 00 00       	mov    $0x0,%eax
 204:	e8 7e 06 00 00       	call   887 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 210:	eb 25                	jmp    237 <main+0xc9>
    {
        printf(1, "- pid %d\n", pid_chds[i]);
 212:	8b 45 fc             	mov    -0x4(%rbp),%eax
 215:	48 98                	cltq
 217:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 21b:	89 c2                	mov    %eax,%edx
 21d:	48 c7 c6 c6 0e 00 00 	mov    $0xec6,%rsi
 224:	bf 01 00 00 00       	mov    $0x1,%edi
 229:	b8 00 00 00 00       	mov    $0x0,%eax
 22e:	e8 54 06 00 00       	call   887 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 233:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 237:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 23b:	7e d5                	jle    212 <main+0xa4>
    }
    printf(1, "\n");
 23d:	48 c7 c6 aa 0e 00 00 	mov    $0xeaa,%rsi
 244:	bf 01 00 00 00       	mov    $0x1,%edi
 249:	b8 00 00 00 00       	mov    $0x0,%eax
 24e:	e8 34 06 00 00       	call   887 <printf>

    printf(1, "PID\tTICKS\tIN USE\n");
 253:	48 c7 c6 d0 0e 00 00 	mov    $0xed0,%rsi
 25a:	bf 01 00 00 00       	mov    $0x1,%edi
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
 264:	e8 1e 06 00 00       	call   887 <printf>
    
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
 292:	48 c7 c6 e2 0e 00 00 	mov    $0xee2,%rsi
 299:	bf 01 00 00 00       	mov    $0x1,%edi
 29e:	b8 00 00 00 00       	mov    $0x0,%eax
 2a3:	e8 df 05 00 00       	call   887 <printf>
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
 359:	48 c7 c6 aa 0e 00 00 	mov    $0xeaa,%rsi
 360:	bf 01 00 00 00       	mov    $0x1,%edi
 365:	b8 00 00 00 00       	mov    $0x0,%eax
 36a:	e8 18 05 00 00       	call   887 <printf>
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

0000000000000785 <getfavnum>:
SYSCALL(getfavnum)
 785:	b8 1c 00 00 00       	mov    $0x1c,%eax
 78a:	cd 40                	int    $0x40
 78c:	c3                   	ret

000000000000078d <halt>:
SYSCALL(halt)
 78d:	b8 1d 00 00 00       	mov    $0x1d,%eax
 792:	cd 40                	int    $0x40
 794:	c3                   	ret

0000000000000795 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 795:	f3 0f 1e fa          	endbr64
 799:	55                   	push   %rbp
 79a:	48 89 e5             	mov    %rsp,%rbp
 79d:	48 83 ec 10          	sub    $0x10,%rsp
 7a1:	89 7d fc             	mov    %edi,-0x4(%rbp)
 7a4:	89 f0                	mov    %esi,%eax
 7a6:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7a9:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7b0:	ba 01 00 00 00       	mov    $0x1,%edx
 7b5:	48 89 ce             	mov    %rcx,%rsi
 7b8:	89 c7                	mov    %eax,%edi
 7ba:	e8 36 ff ff ff       	call   6f5 <write>
}
 7bf:	90                   	nop
 7c0:	c9                   	leave
 7c1:	c3                   	ret

00000000000007c2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7c2:	f3 0f 1e fa          	endbr64
 7c6:	55                   	push   %rbp
 7c7:	48 89 e5             	mov    %rsp,%rbp
 7ca:	48 83 ec 30          	sub    $0x30,%rsp
 7ce:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7d1:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7d4:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7d7:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7da:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7e1:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7e5:	74 17                	je     7fe <printint+0x3c>
 7e7:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7eb:	79 11                	jns    7fe <printint+0x3c>
    neg = 1;
 7ed:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7f4:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7f7:	f7 d8                	neg    %eax
 7f9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7fc:	eb 06                	jmp    804 <printint+0x42>
  } else {
    x = xx;
 7fe:	8b 45 d8             	mov    -0x28(%rbp),%eax
 801:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 804:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 80b:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 80e:	8b 45 f4             	mov    -0xc(%rbp),%eax
 811:	ba 00 00 00 00       	mov    $0x0,%edx
 816:	f7 f6                	div    %esi
 818:	89 d1                	mov    %edx,%ecx
 81a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 81d:	8d 50 01             	lea    0x1(%rax),%edx
 820:	89 55 fc             	mov    %edx,-0x4(%rbp)
 823:	89 ca                	mov    %ecx,%edx
 825:	0f b6 92 a0 11 00 00 	movzbl 0x11a0(%rdx),%edx
 82c:	48 98                	cltq
 82e:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 832:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 835:	8b 45 f4             	mov    -0xc(%rbp),%eax
 838:	ba 00 00 00 00       	mov    $0x0,%edx
 83d:	f7 f7                	div    %edi
 83f:	89 45 f4             	mov    %eax,-0xc(%rbp)
 842:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 846:	75 c3                	jne    80b <printint+0x49>
  if(neg)
 848:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 84c:	74 2b                	je     879 <printint+0xb7>
    buf[i++] = '-';
 84e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 851:	8d 50 01             	lea    0x1(%rax),%edx
 854:	89 55 fc             	mov    %edx,-0x4(%rbp)
 857:	48 98                	cltq
 859:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 85e:	eb 19                	jmp    879 <printint+0xb7>
    putc(fd, buf[i]);
 860:	8b 45 fc             	mov    -0x4(%rbp),%eax
 863:	48 98                	cltq
 865:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 86a:	0f be d0             	movsbl %al,%edx
 86d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 870:	89 d6                	mov    %edx,%esi
 872:	89 c7                	mov    %eax,%edi
 874:	e8 1c ff ff ff       	call   795 <putc>
  while(--i >= 0)
 879:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 87d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 881:	79 dd                	jns    860 <printint+0x9e>
}
 883:	90                   	nop
 884:	90                   	nop
 885:	c9                   	leave
 886:	c3                   	ret

0000000000000887 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 887:	f3 0f 1e fa          	endbr64
 88b:	55                   	push   %rbp
 88c:	48 89 e5             	mov    %rsp,%rbp
 88f:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 896:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 89c:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 8a3:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8aa:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8b1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8b8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8bf:	84 c0                	test   %al,%al
 8c1:	74 20                	je     8e3 <printf+0x5c>
 8c3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8c7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8cb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8cf:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8d3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8d7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8db:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8df:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8e3:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8ea:	00 00 00 
 8ed:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8f4:	00 00 00 
 8f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8fb:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 902:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 909:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 910:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 917:	00 00 00 
  for(i = 0; fmt[i]; i++){
 91a:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 921:	00 00 00 
 924:	e9 a8 02 00 00       	jmp    bd1 <printf+0x34a>
    c = fmt[i] & 0xff;
 929:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 92f:	48 63 d0             	movslq %eax,%rdx
 932:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 939:	48 01 d0             	add    %rdx,%rax
 93c:	0f b6 00             	movzbl (%rax),%eax
 93f:	0f be c0             	movsbl %al,%eax
 942:	25 ff 00 00 00       	and    $0xff,%eax
 947:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 94d:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 954:	75 35                	jne    98b <printf+0x104>
      if(c == '%'){
 956:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 95d:	75 0f                	jne    96e <printf+0xe7>
        state = '%';
 95f:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 966:	00 00 00 
 969:	e9 5c 02 00 00       	jmp    bca <printf+0x343>
      } else {
        putc(fd, c);
 96e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 974:	0f be d0             	movsbl %al,%edx
 977:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 97d:	89 d6                	mov    %edx,%esi
 97f:	89 c7                	mov    %eax,%edi
 981:	e8 0f fe ff ff       	call   795 <putc>
 986:	e9 3f 02 00 00       	jmp    bca <printf+0x343>
      }
    } else if(state == '%'){
 98b:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 992:	0f 85 32 02 00 00    	jne    bca <printf+0x343>
      if(c == 'd'){
 998:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 99f:	75 5e                	jne    9ff <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 9a1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9a7:	83 f8 2f             	cmp    $0x2f,%eax
 9aa:	77 23                	ja     9cf <printf+0x148>
 9ac:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9b3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9b9:	89 d2                	mov    %edx,%edx
 9bb:	48 01 d0             	add    %rdx,%rax
 9be:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9c4:	83 c2 08             	add    $0x8,%edx
 9c7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9cd:	eb 12                	jmp    9e1 <printf+0x15a>
 9cf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9d6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9da:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9e1:	8b 30                	mov    (%rax),%esi
 9e3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9e9:	b9 01 00 00 00       	mov    $0x1,%ecx
 9ee:	ba 0a 00 00 00       	mov    $0xa,%edx
 9f3:	89 c7                	mov    %eax,%edi
 9f5:	e8 c8 fd ff ff       	call   7c2 <printint>
 9fa:	e9 c1 01 00 00       	jmp    bc0 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 9ff:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a06:	74 09                	je     a11 <printf+0x18a>
 a08:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a0f:	75 5e                	jne    a6f <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a11:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a17:	83 f8 2f             	cmp    $0x2f,%eax
 a1a:	77 23                	ja     a3f <printf+0x1b8>
 a1c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a23:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a29:	89 d2                	mov    %edx,%edx
 a2b:	48 01 d0             	add    %rdx,%rax
 a2e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a34:	83 c2 08             	add    $0x8,%edx
 a37:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a3d:	eb 12                	jmp    a51 <printf+0x1ca>
 a3f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a46:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a4a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a51:	8b 30                	mov    (%rax),%esi
 a53:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a59:	b9 00 00 00 00       	mov    $0x0,%ecx
 a5e:	ba 10 00 00 00       	mov    $0x10,%edx
 a63:	89 c7                	mov    %eax,%edi
 a65:	e8 58 fd ff ff       	call   7c2 <printint>
 a6a:	e9 51 01 00 00       	jmp    bc0 <printf+0x339>
      } else if(c == 's'){
 a6f:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a76:	0f 85 98 00 00 00    	jne    b14 <printf+0x28d>
        s = va_arg(ap, char*);
 a7c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a82:	83 f8 2f             	cmp    $0x2f,%eax
 a85:	77 23                	ja     aaa <printf+0x223>
 a87:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a8e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a94:	89 d2                	mov    %edx,%edx
 a96:	48 01 d0             	add    %rdx,%rax
 a99:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a9f:	83 c2 08             	add    $0x8,%edx
 aa2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 aa8:	eb 12                	jmp    abc <printf+0x235>
 aaa:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 ab1:	48 8d 50 08          	lea    0x8(%rax),%rdx
 ab5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 abc:	48 8b 00             	mov    (%rax),%rax
 abf:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 ac6:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 acd:	00 
 ace:	75 31                	jne    b01 <printf+0x27a>
          s = "(null)";
 ad0:	48 c7 85 48 ff ff ff 	movq   $0xef3,-0xb8(%rbp)
 ad7:	f3 0e 00 00 
        while(*s != 0){
 adb:	eb 24                	jmp    b01 <printf+0x27a>
          putc(fd, *s);
 add:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ae4:	0f b6 00             	movzbl (%rax),%eax
 ae7:	0f be d0             	movsbl %al,%edx
 aea:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 af0:	89 d6                	mov    %edx,%esi
 af2:	89 c7                	mov    %eax,%edi
 af4:	e8 9c fc ff ff       	call   795 <putc>
          s++;
 af9:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 b00:	01 
        while(*s != 0){
 b01:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b08:	0f b6 00             	movzbl (%rax),%eax
 b0b:	84 c0                	test   %al,%al
 b0d:	75 ce                	jne    add <printf+0x256>
 b0f:	e9 ac 00 00 00       	jmp    bc0 <printf+0x339>
        }
      } else if(c == 'c'){
 b14:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b1b:	75 56                	jne    b73 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b1d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b23:	83 f8 2f             	cmp    $0x2f,%eax
 b26:	77 23                	ja     b4b <printf+0x2c4>
 b28:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b2f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b35:	89 d2                	mov    %edx,%edx
 b37:	48 01 d0             	add    %rdx,%rax
 b3a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b40:	83 c2 08             	add    $0x8,%edx
 b43:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b49:	eb 12                	jmp    b5d <printf+0x2d6>
 b4b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b52:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b56:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b5d:	8b 00                	mov    (%rax),%eax
 b5f:	0f be d0             	movsbl %al,%edx
 b62:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b68:	89 d6                	mov    %edx,%esi
 b6a:	89 c7                	mov    %eax,%edi
 b6c:	e8 24 fc ff ff       	call   795 <putc>
 b71:	eb 4d                	jmp    bc0 <printf+0x339>
      } else if(c == '%'){
 b73:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b7a:	75 1a                	jne    b96 <printf+0x30f>
        putc(fd, c);
 b7c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b82:	0f be d0             	movsbl %al,%edx
 b85:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b8b:	89 d6                	mov    %edx,%esi
 b8d:	89 c7                	mov    %eax,%edi
 b8f:	e8 01 fc ff ff       	call   795 <putc>
 b94:	eb 2a                	jmp    bc0 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b96:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b9c:	be 25 00 00 00       	mov    $0x25,%esi
 ba1:	89 c7                	mov    %eax,%edi
 ba3:	e8 ed fb ff ff       	call   795 <putc>
        putc(fd, c);
 ba8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 bae:	0f be d0             	movsbl %al,%edx
 bb1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bb7:	89 d6                	mov    %edx,%esi
 bb9:	89 c7                	mov    %eax,%edi
 bbb:	e8 d5 fb ff ff       	call   795 <putc>
      }
      state = 0;
 bc0:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bc7:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bca:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bd1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bd7:	48 63 d0             	movslq %eax,%rdx
 bda:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 be1:	48 01 d0             	add    %rdx,%rax
 be4:	0f b6 00             	movzbl (%rax),%eax
 be7:	84 c0                	test   %al,%al
 be9:	0f 85 3a fd ff ff    	jne    929 <printf+0xa2>
    }
  }
}
 bef:	90                   	nop
 bf0:	90                   	nop
 bf1:	c9                   	leave
 bf2:	c3                   	ret

0000000000000bf3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bf3:	f3 0f 1e fa          	endbr64
 bf7:	55                   	push   %rbp
 bf8:	48 89 e5             	mov    %rsp,%rbp
 bfb:	48 83 ec 18          	sub    $0x18,%rsp
 bff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c07:	48 83 e8 10          	sub    $0x10,%rax
 c0b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c0f:	48 8b 05 ba 05 00 00 	mov    0x5ba(%rip),%rax        # 11d0 <freep>
 c16:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c1a:	eb 2f                	jmp    c4b <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c20:	48 8b 00             	mov    (%rax),%rax
 c23:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c27:	72 17                	jb     c40 <free+0x4d>
 c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c31:	72 2f                	jb     c62 <free+0x6f>
 c33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c37:	48 8b 00             	mov    (%rax),%rax
 c3a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c3e:	72 22                	jb     c62 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c44:	48 8b 00             	mov    (%rax),%rax
 c47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c4f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c53:	73 c7                	jae    c1c <free+0x29>
 c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c59:	48 8b 00             	mov    (%rax),%rax
 c5c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c60:	73 ba                	jae    c1c <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c66:	8b 40 08             	mov    0x8(%rax),%eax
 c69:	89 c0                	mov    %eax,%eax
 c6b:	48 c1 e0 04          	shl    $0x4,%rax
 c6f:	48 89 c2             	mov    %rax,%rdx
 c72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c76:	48 01 c2             	add    %rax,%rdx
 c79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c7d:	48 8b 00             	mov    (%rax),%rax
 c80:	48 39 c2             	cmp    %rax,%rdx
 c83:	75 2d                	jne    cb2 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c89:	8b 50 08             	mov    0x8(%rax),%edx
 c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c90:	48 8b 00             	mov    (%rax),%rax
 c93:	8b 40 08             	mov    0x8(%rax),%eax
 c96:	01 c2                	add    %eax,%edx
 c98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca3:	48 8b 00             	mov    (%rax),%rax
 ca6:	48 8b 10             	mov    (%rax),%rdx
 ca9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cad:	48 89 10             	mov    %rdx,(%rax)
 cb0:	eb 0e                	jmp    cc0 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 cb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb6:	48 8b 10             	mov    (%rax),%rdx
 cb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cbd:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc4:	8b 40 08             	mov    0x8(%rax),%eax
 cc7:	89 c0                	mov    %eax,%eax
 cc9:	48 c1 e0 04          	shl    $0x4,%rax
 ccd:	48 89 c2             	mov    %rax,%rdx
 cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd4:	48 01 d0             	add    %rdx,%rax
 cd7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 cdb:	75 27                	jne    d04 <free+0x111>
    p->s.size += bp->s.size;
 cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce1:	8b 50 08             	mov    0x8(%rax),%edx
 ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce8:	8b 40 08             	mov    0x8(%rax),%eax
 ceb:	01 c2                	add    %eax,%edx
 ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf1:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 cf4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cf8:	48 8b 10             	mov    (%rax),%rdx
 cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cff:	48 89 10             	mov    %rdx,(%rax)
 d02:	eb 0b                	jmp    d0f <free+0x11c>
  } else
    p->s.ptr = bp;
 d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d08:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d0c:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d13:	48 89 05 b6 04 00 00 	mov    %rax,0x4b6(%rip)        # 11d0 <freep>
}
 d1a:	90                   	nop
 d1b:	c9                   	leave
 d1c:	c3                   	ret

0000000000000d1d <morecore>:

static Header*
morecore(uint nu)
{
 d1d:	f3 0f 1e fa          	endbr64
 d21:	55                   	push   %rbp
 d22:	48 89 e5             	mov    %rsp,%rbp
 d25:	48 83 ec 20          	sub    $0x20,%rsp
 d29:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d2c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d33:	77 07                	ja     d3c <morecore+0x1f>
    nu = 4096;
 d35:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d3f:	c1 e0 04             	shl    $0x4,%eax
 d42:	89 c7                	mov    %eax,%edi
 d44:	e8 14 fa ff ff       	call   75d <sbrk>
 d49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d4d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d52:	75 07                	jne    d5b <morecore+0x3e>
    return 0;
 d54:	b8 00 00 00 00       	mov    $0x0,%eax
 d59:	eb 29                	jmp    d84 <morecore+0x67>
  hp = (Header*)p;
 d5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d5f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d67:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d6a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d71:	48 83 c0 10          	add    $0x10,%rax
 d75:	48 89 c7             	mov    %rax,%rdi
 d78:	e8 76 fe ff ff       	call   bf3 <free>
  return freep;
 d7d:	48 8b 05 4c 04 00 00 	mov    0x44c(%rip),%rax        # 11d0 <freep>
}
 d84:	c9                   	leave
 d85:	c3                   	ret

0000000000000d86 <malloc>:

void*
malloc(uint nbytes)
{
 d86:	f3 0f 1e fa          	endbr64
 d8a:	55                   	push   %rbp
 d8b:	48 89 e5             	mov    %rsp,%rbp
 d8e:	48 83 ec 30          	sub    $0x30,%rsp
 d92:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d95:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d98:	48 83 c0 0f          	add    $0xf,%rax
 d9c:	48 c1 e8 04          	shr    $0x4,%rax
 da0:	83 c0 01             	add    $0x1,%eax
 da3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 da6:	48 8b 05 23 04 00 00 	mov    0x423(%rip),%rax        # 11d0 <freep>
 dad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 db1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 db6:	75 2b                	jne    de3 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 db8:	48 c7 45 f0 c0 11 00 	movq   $0x11c0,-0x10(%rbp)
 dbf:	00 
 dc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dc4:	48 89 05 05 04 00 00 	mov    %rax,0x405(%rip)        # 11d0 <freep>
 dcb:	48 8b 05 fe 03 00 00 	mov    0x3fe(%rip),%rax        # 11d0 <freep>
 dd2:	48 89 05 e7 03 00 00 	mov    %rax,0x3e7(%rip)        # 11c0 <base>
    base.s.size = 0;
 dd9:	c7 05 e5 03 00 00 00 	movl   $0x0,0x3e5(%rip)        # 11c8 <base+0x8>
 de0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 de3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 de7:	48 8b 00             	mov    (%rax),%rax
 dea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 dee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 df2:	8b 40 08             	mov    0x8(%rax),%eax
 df5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 df8:	72 5f                	jb     e59 <malloc+0xd3>
      if(p->s.size == nunits)
 dfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dfe:	8b 40 08             	mov    0x8(%rax),%eax
 e01:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 e04:	75 10                	jne    e16 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0a:	48 8b 10             	mov    (%rax),%rdx
 e0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e11:	48 89 10             	mov    %rdx,(%rax)
 e14:	eb 2e                	jmp    e44 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1a:	8b 40 08             	mov    0x8(%rax),%eax
 e1d:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e20:	89 c2                	mov    %eax,%edx
 e22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e26:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2d:	8b 40 08             	mov    0x8(%rax),%eax
 e30:	89 c0                	mov    %eax,%eax
 e32:	48 c1 e0 04          	shl    $0x4,%rax
 e36:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e3e:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e41:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e48:	48 89 05 81 03 00 00 	mov    %rax,0x381(%rip)        # 11d0 <freep>
      return (void*)(p + 1);
 e4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e53:	48 83 c0 10          	add    $0x10,%rax
 e57:	eb 41                	jmp    e9a <malloc+0x114>
    }
    if(p == freep)
 e59:	48 8b 05 70 03 00 00 	mov    0x370(%rip),%rax        # 11d0 <freep>
 e60:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e64:	75 1c                	jne    e82 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e66:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e69:	89 c7                	mov    %eax,%edi
 e6b:	e8 ad fe ff ff       	call   d1d <morecore>
 e70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e74:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e79:	75 07                	jne    e82 <malloc+0xfc>
        return 0;
 e7b:	b8 00 00 00 00       	mov    $0x0,%eax
 e80:	eb 18                	jmp    e9a <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e8e:	48 8b 00             	mov    (%rax),%rax
 e91:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e95:	e9 54 ff ff ff       	jmp    dee <malloc+0x68>
  }
}
 e9a:	c9                   	leave
 e9b:	c3                   	ret
