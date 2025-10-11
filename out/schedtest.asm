
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
  b7:	48 c7 c6 94 0e 00 00 	mov    $0xe94,%rsi
  be:	bf 01 00 00 00       	mov    $0x1,%edi
  c3:	b8 00 00 00 00       	mov    $0x0,%eax
  c8:	e8 b2 07 00 00       	call   87f <printf>

    if (pstat->inuse[j] == 1) 
  cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  d4:	48 63 d2             	movslq %edx,%rdx
  d7:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  da:	83 f8 01             	cmp    $0x1,%eax
  dd:	75 18                	jne    f7 <print_info+0x7c>
    {
        printf(1, "YES");
  df:	48 c7 c6 9b 0e 00 00 	mov    $0xe9b,%rsi
  e6:	bf 01 00 00 00       	mov    $0x1,%edi
  eb:	b8 00 00 00 00       	mov    $0x0,%eax
  f0:	e8 8a 07 00 00       	call   87f <printf>
  f5:	eb 16                	jmp    10d <print_info+0x92>
    }
    else 
    {
        printf(1, "NO");
  f7:	48 c7 c6 9f 0e 00 00 	mov    $0xe9f,%rsi
  fe:	bf 01 00 00 00       	mov    $0x1,%edi
 103:	b8 00 00 00 00       	mov    $0x0,%eax
 108:	e8 72 07 00 00       	call   87f <printf>
    }

    printf(1, "\n");
 10d:	48 c7 c6 a2 0e 00 00 	mov    $0xea2,%rsi
 114:	bf 01 00 00 00       	mov    $0x1,%edi
 119:	b8 00 00 00 00       	mov    $0x0,%eax
 11e:	e8 5c 07 00 00       	call   87f <printf>
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
 1f3:	48 c7 c6 a4 0e 00 00 	mov    $0xea4,%rsi
 1fa:	bf 01 00 00 00       	mov    $0x1,%edi
 1ff:	b8 00 00 00 00       	mov    $0x0,%eax
 204:	e8 76 06 00 00       	call   87f <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 210:	eb 25                	jmp    237 <main+0xc9>
    {
        printf(1, "- pid %d\n", pid_chds[i]);
 212:	8b 45 fc             	mov    -0x4(%rbp),%eax
 215:	48 98                	cltq
 217:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 21b:	89 c2                	mov    %eax,%edx
 21d:	48 c7 c6 be 0e 00 00 	mov    $0xebe,%rsi
 224:	bf 01 00 00 00       	mov    $0x1,%edi
 229:	b8 00 00 00 00       	mov    $0x0,%eax
 22e:	e8 4c 06 00 00       	call   87f <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 233:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 237:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 23b:	7e d5                	jle    212 <main+0xa4>
    }
    printf(1, "\n");
 23d:	48 c7 c6 a2 0e 00 00 	mov    $0xea2,%rsi
 244:	bf 01 00 00 00       	mov    $0x1,%edi
 249:	b8 00 00 00 00       	mov    $0x0,%eax
 24e:	e8 2c 06 00 00       	call   87f <printf>

    printf(1, "PID\tTICKS\tIN USE\n");
 253:	48 c7 c6 c8 0e 00 00 	mov    $0xec8,%rsi
 25a:	bf 01 00 00 00       	mov    $0x1,%edi
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
 264:	e8 16 06 00 00       	call   87f <printf>
    
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
 292:	48 c7 c6 da 0e 00 00 	mov    $0xeda,%rsi
 299:	bf 01 00 00 00       	mov    $0x1,%edi
 29e:	b8 00 00 00 00       	mov    $0x0,%eax
 2a3:	e8 d7 05 00 00       	call   87f <printf>
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
 359:	48 c7 c6 a2 0e 00 00 	mov    $0xea2,%rsi
 360:	bf 01 00 00 00       	mov    $0x1,%edi
 365:	b8 00 00 00 00       	mov    $0x0,%eax
 36a:	e8 10 05 00 00       	call   87f <printf>
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

000000000000078d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 78d:	f3 0f 1e fa          	endbr64
 791:	55                   	push   %rbp
 792:	48 89 e5             	mov    %rsp,%rbp
 795:	48 83 ec 10          	sub    $0x10,%rsp
 799:	89 7d fc             	mov    %edi,-0x4(%rbp)
 79c:	89 f0                	mov    %esi,%eax
 79e:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7a1:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7a8:	ba 01 00 00 00       	mov    $0x1,%edx
 7ad:	48 89 ce             	mov    %rcx,%rsi
 7b0:	89 c7                	mov    %eax,%edi
 7b2:	e8 3e ff ff ff       	call   6f5 <write>
}
 7b7:	90                   	nop
 7b8:	c9                   	leave
 7b9:	c3                   	ret

00000000000007ba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7ba:	f3 0f 1e fa          	endbr64
 7be:	55                   	push   %rbp
 7bf:	48 89 e5             	mov    %rsp,%rbp
 7c2:	48 83 ec 30          	sub    $0x30,%rsp
 7c6:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7c9:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7cc:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7cf:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7d9:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7dd:	74 17                	je     7f6 <printint+0x3c>
 7df:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7e3:	79 11                	jns    7f6 <printint+0x3c>
    neg = 1;
 7e5:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7ec:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7ef:	f7 d8                	neg    %eax
 7f1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7f4:	eb 06                	jmp    7fc <printint+0x42>
  } else {
    x = xx;
 7f6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7f9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 803:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 806:	8b 45 f4             	mov    -0xc(%rbp),%eax
 809:	ba 00 00 00 00       	mov    $0x0,%edx
 80e:	f7 f6                	div    %esi
 810:	89 d1                	mov    %edx,%ecx
 812:	8b 45 fc             	mov    -0x4(%rbp),%eax
 815:	8d 50 01             	lea    0x1(%rax),%edx
 818:	89 55 fc             	mov    %edx,-0x4(%rbp)
 81b:	89 ca                	mov    %ecx,%edx
 81d:	0f b6 92 90 11 00 00 	movzbl 0x1190(%rdx),%edx
 824:	48 98                	cltq
 826:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 82a:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 82d:	8b 45 f4             	mov    -0xc(%rbp),%eax
 830:	ba 00 00 00 00       	mov    $0x0,%edx
 835:	f7 f7                	div    %edi
 837:	89 45 f4             	mov    %eax,-0xc(%rbp)
 83a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 83e:	75 c3                	jne    803 <printint+0x49>
  if(neg)
 840:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 844:	74 2b                	je     871 <printint+0xb7>
    buf[i++] = '-';
 846:	8b 45 fc             	mov    -0x4(%rbp),%eax
 849:	8d 50 01             	lea    0x1(%rax),%edx
 84c:	89 55 fc             	mov    %edx,-0x4(%rbp)
 84f:	48 98                	cltq
 851:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 856:	eb 19                	jmp    871 <printint+0xb7>
    putc(fd, buf[i]);
 858:	8b 45 fc             	mov    -0x4(%rbp),%eax
 85b:	48 98                	cltq
 85d:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 862:	0f be d0             	movsbl %al,%edx
 865:	8b 45 dc             	mov    -0x24(%rbp),%eax
 868:	89 d6                	mov    %edx,%esi
 86a:	89 c7                	mov    %eax,%edi
 86c:	e8 1c ff ff ff       	call   78d <putc>
  while(--i >= 0)
 871:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 875:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 879:	79 dd                	jns    858 <printint+0x9e>
}
 87b:	90                   	nop
 87c:	90                   	nop
 87d:	c9                   	leave
 87e:	c3                   	ret

000000000000087f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 87f:	f3 0f 1e fa          	endbr64
 883:	55                   	push   %rbp
 884:	48 89 e5             	mov    %rsp,%rbp
 887:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 88e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 894:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 89b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8a2:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8a9:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8b0:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8b7:	84 c0                	test   %al,%al
 8b9:	74 20                	je     8db <printf+0x5c>
 8bb:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8bf:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8c3:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8c7:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8cb:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8cf:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8d3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8d7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8db:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8e2:	00 00 00 
 8e5:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8ec:	00 00 00 
 8ef:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8f3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8fa:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 901:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 908:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 90f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 912:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 919:	00 00 00 
 91c:	e9 a8 02 00 00       	jmp    bc9 <printf+0x34a>
    c = fmt[i] & 0xff;
 921:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 927:	48 63 d0             	movslq %eax,%rdx
 92a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 931:	48 01 d0             	add    %rdx,%rax
 934:	0f b6 00             	movzbl (%rax),%eax
 937:	0f be c0             	movsbl %al,%eax
 93a:	25 ff 00 00 00       	and    $0xff,%eax
 93f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 945:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 94c:	75 35                	jne    983 <printf+0x104>
      if(c == '%'){
 94e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 955:	75 0f                	jne    966 <printf+0xe7>
        state = '%';
 957:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 95e:	00 00 00 
 961:	e9 5c 02 00 00       	jmp    bc2 <printf+0x343>
      } else {
        putc(fd, c);
 966:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 96c:	0f be d0             	movsbl %al,%edx
 96f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 975:	89 d6                	mov    %edx,%esi
 977:	89 c7                	mov    %eax,%edi
 979:	e8 0f fe ff ff       	call   78d <putc>
 97e:	e9 3f 02 00 00       	jmp    bc2 <printf+0x343>
      }
    } else if(state == '%'){
 983:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 98a:	0f 85 32 02 00 00    	jne    bc2 <printf+0x343>
      if(c == 'd'){
 990:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 997:	75 5e                	jne    9f7 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 999:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 99f:	83 f8 2f             	cmp    $0x2f,%eax
 9a2:	77 23                	ja     9c7 <printf+0x148>
 9a4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9ab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9b1:	89 d2                	mov    %edx,%edx
 9b3:	48 01 d0             	add    %rdx,%rax
 9b6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9bc:	83 c2 08             	add    $0x8,%edx
 9bf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9c5:	eb 12                	jmp    9d9 <printf+0x15a>
 9c7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9ce:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9d2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9d9:	8b 30                	mov    (%rax),%esi
 9db:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9e1:	b9 01 00 00 00       	mov    $0x1,%ecx
 9e6:	ba 0a 00 00 00       	mov    $0xa,%edx
 9eb:	89 c7                	mov    %eax,%edi
 9ed:	e8 c8 fd ff ff       	call   7ba <printint>
 9f2:	e9 c1 01 00 00       	jmp    bb8 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 9f7:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 9fe:	74 09                	je     a09 <printf+0x18a>
 a00:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a07:	75 5e                	jne    a67 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a09:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a0f:	83 f8 2f             	cmp    $0x2f,%eax
 a12:	77 23                	ja     a37 <printf+0x1b8>
 a14:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a1b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a21:	89 d2                	mov    %edx,%edx
 a23:	48 01 d0             	add    %rdx,%rax
 a26:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a2c:	83 c2 08             	add    $0x8,%edx
 a2f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a35:	eb 12                	jmp    a49 <printf+0x1ca>
 a37:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a3e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a42:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a49:	8b 30                	mov    (%rax),%esi
 a4b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a51:	b9 00 00 00 00       	mov    $0x0,%ecx
 a56:	ba 10 00 00 00       	mov    $0x10,%edx
 a5b:	89 c7                	mov    %eax,%edi
 a5d:	e8 58 fd ff ff       	call   7ba <printint>
 a62:	e9 51 01 00 00       	jmp    bb8 <printf+0x339>
      } else if(c == 's'){
 a67:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a6e:	0f 85 98 00 00 00    	jne    b0c <printf+0x28d>
        s = va_arg(ap, char*);
 a74:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a7a:	83 f8 2f             	cmp    $0x2f,%eax
 a7d:	77 23                	ja     aa2 <printf+0x223>
 a7f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a86:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a8c:	89 d2                	mov    %edx,%edx
 a8e:	48 01 d0             	add    %rdx,%rax
 a91:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a97:	83 c2 08             	add    $0x8,%edx
 a9a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 aa0:	eb 12                	jmp    ab4 <printf+0x235>
 aa2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 aa9:	48 8d 50 08          	lea    0x8(%rax),%rdx
 aad:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ab4:	48 8b 00             	mov    (%rax),%rax
 ab7:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 abe:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 ac5:	00 
 ac6:	75 31                	jne    af9 <printf+0x27a>
          s = "(null)";
 ac8:	48 c7 85 48 ff ff ff 	movq   $0xeeb,-0xb8(%rbp)
 acf:	eb 0e 00 00 
        while(*s != 0){
 ad3:	eb 24                	jmp    af9 <printf+0x27a>
          putc(fd, *s);
 ad5:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 adc:	0f b6 00             	movzbl (%rax),%eax
 adf:	0f be d0             	movsbl %al,%edx
 ae2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ae8:	89 d6                	mov    %edx,%esi
 aea:	89 c7                	mov    %eax,%edi
 aec:	e8 9c fc ff ff       	call   78d <putc>
          s++;
 af1:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 af8:	01 
        while(*s != 0){
 af9:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b00:	0f b6 00             	movzbl (%rax),%eax
 b03:	84 c0                	test   %al,%al
 b05:	75 ce                	jne    ad5 <printf+0x256>
 b07:	e9 ac 00 00 00       	jmp    bb8 <printf+0x339>
        }
      } else if(c == 'c'){
 b0c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b13:	75 56                	jne    b6b <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b15:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b1b:	83 f8 2f             	cmp    $0x2f,%eax
 b1e:	77 23                	ja     b43 <printf+0x2c4>
 b20:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b27:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b2d:	89 d2                	mov    %edx,%edx
 b2f:	48 01 d0             	add    %rdx,%rax
 b32:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b38:	83 c2 08             	add    $0x8,%edx
 b3b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b41:	eb 12                	jmp    b55 <printf+0x2d6>
 b43:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b4a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b4e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b55:	8b 00                	mov    (%rax),%eax
 b57:	0f be d0             	movsbl %al,%edx
 b5a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b60:	89 d6                	mov    %edx,%esi
 b62:	89 c7                	mov    %eax,%edi
 b64:	e8 24 fc ff ff       	call   78d <putc>
 b69:	eb 4d                	jmp    bb8 <printf+0x339>
      } else if(c == '%'){
 b6b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b72:	75 1a                	jne    b8e <printf+0x30f>
        putc(fd, c);
 b74:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b7a:	0f be d0             	movsbl %al,%edx
 b7d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b83:	89 d6                	mov    %edx,%esi
 b85:	89 c7                	mov    %eax,%edi
 b87:	e8 01 fc ff ff       	call   78d <putc>
 b8c:	eb 2a                	jmp    bb8 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b8e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b94:	be 25 00 00 00       	mov    $0x25,%esi
 b99:	89 c7                	mov    %eax,%edi
 b9b:	e8 ed fb ff ff       	call   78d <putc>
        putc(fd, c);
 ba0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 ba6:	0f be d0             	movsbl %al,%edx
 ba9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 baf:	89 d6                	mov    %edx,%esi
 bb1:	89 c7                	mov    %eax,%edi
 bb3:	e8 d5 fb ff ff       	call   78d <putc>
      }
      state = 0;
 bb8:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bbf:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bc2:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bc9:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bcf:	48 63 d0             	movslq %eax,%rdx
 bd2:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bd9:	48 01 d0             	add    %rdx,%rax
 bdc:	0f b6 00             	movzbl (%rax),%eax
 bdf:	84 c0                	test   %al,%al
 be1:	0f 85 3a fd ff ff    	jne    921 <printf+0xa2>
    }
  }
}
 be7:	90                   	nop
 be8:	90                   	nop
 be9:	c9                   	leave
 bea:	c3                   	ret

0000000000000beb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 beb:	f3 0f 1e fa          	endbr64
 bef:	55                   	push   %rbp
 bf0:	48 89 e5             	mov    %rsp,%rbp
 bf3:	48 83 ec 18          	sub    $0x18,%rsp
 bf7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 bff:	48 83 e8 10          	sub    $0x10,%rax
 c03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c07:	48 8b 05 b2 05 00 00 	mov    0x5b2(%rip),%rax        # 11c0 <freep>
 c0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c12:	eb 2f                	jmp    c43 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c18:	48 8b 00             	mov    (%rax),%rax
 c1b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c1f:	72 17                	jb     c38 <free+0x4d>
 c21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c25:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c29:	72 2f                	jb     c5a <free+0x6f>
 c2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2f:	48 8b 00             	mov    (%rax),%rax
 c32:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c36:	72 22                	jb     c5a <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3c:	48 8b 00             	mov    (%rax),%rax
 c3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c47:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c4b:	73 c7                	jae    c14 <free+0x29>
 c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c51:	48 8b 00             	mov    (%rax),%rax
 c54:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c58:	73 ba                	jae    c14 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c5e:	8b 40 08             	mov    0x8(%rax),%eax
 c61:	89 c0                	mov    %eax,%eax
 c63:	48 c1 e0 04          	shl    $0x4,%rax
 c67:	48 89 c2             	mov    %rax,%rdx
 c6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c6e:	48 01 c2             	add    %rax,%rdx
 c71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c75:	48 8b 00             	mov    (%rax),%rax
 c78:	48 39 c2             	cmp    %rax,%rdx
 c7b:	75 2d                	jne    caa <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c81:	8b 50 08             	mov    0x8(%rax),%edx
 c84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c88:	48 8b 00             	mov    (%rax),%rax
 c8b:	8b 40 08             	mov    0x8(%rax),%eax
 c8e:	01 c2                	add    %eax,%edx
 c90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c94:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9b:	48 8b 00             	mov    (%rax),%rax
 c9e:	48 8b 10             	mov    (%rax),%rdx
 ca1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ca5:	48 89 10             	mov    %rdx,(%rax)
 ca8:	eb 0e                	jmp    cb8 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cae:	48 8b 10             	mov    (%rax),%rdx
 cb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cb5:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbc:	8b 40 08             	mov    0x8(%rax),%eax
 cbf:	89 c0                	mov    %eax,%eax
 cc1:	48 c1 e0 04          	shl    $0x4,%rax
 cc5:	48 89 c2             	mov    %rax,%rdx
 cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ccc:	48 01 d0             	add    %rdx,%rax
 ccf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 cd3:	75 27                	jne    cfc <free+0x111>
    p->s.size += bp->s.size;
 cd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd9:	8b 50 08             	mov    0x8(%rax),%edx
 cdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce0:	8b 40 08             	mov    0x8(%rax),%eax
 ce3:	01 c2                	add    %eax,%edx
 ce5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce9:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 cec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cf0:	48 8b 10             	mov    (%rax),%rdx
 cf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf7:	48 89 10             	mov    %rdx,(%rax)
 cfa:	eb 0b                	jmp    d07 <free+0x11c>
  } else
    p->s.ptr = bp;
 cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d00:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d04:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0b:	48 89 05 ae 04 00 00 	mov    %rax,0x4ae(%rip)        # 11c0 <freep>
}
 d12:	90                   	nop
 d13:	c9                   	leave
 d14:	c3                   	ret

0000000000000d15 <morecore>:

static Header*
morecore(uint nu)
{
 d15:	f3 0f 1e fa          	endbr64
 d19:	55                   	push   %rbp
 d1a:	48 89 e5             	mov    %rsp,%rbp
 d1d:	48 83 ec 20          	sub    $0x20,%rsp
 d21:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d24:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d2b:	77 07                	ja     d34 <morecore+0x1f>
    nu = 4096;
 d2d:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d34:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d37:	c1 e0 04             	shl    $0x4,%eax
 d3a:	89 c7                	mov    %eax,%edi
 d3c:	e8 1c fa ff ff       	call   75d <sbrk>
 d41:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d45:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d4a:	75 07                	jne    d53 <morecore+0x3e>
    return 0;
 d4c:	b8 00 00 00 00       	mov    $0x0,%eax
 d51:	eb 29                	jmp    d7c <morecore+0x67>
  hp = (Header*)p;
 d53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d57:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d5f:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d62:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d69:	48 83 c0 10          	add    $0x10,%rax
 d6d:	48 89 c7             	mov    %rax,%rdi
 d70:	e8 76 fe ff ff       	call   beb <free>
  return freep;
 d75:	48 8b 05 44 04 00 00 	mov    0x444(%rip),%rax        # 11c0 <freep>
}
 d7c:	c9                   	leave
 d7d:	c3                   	ret

0000000000000d7e <malloc>:

void*
malloc(uint nbytes)
{
 d7e:	f3 0f 1e fa          	endbr64
 d82:	55                   	push   %rbp
 d83:	48 89 e5             	mov    %rsp,%rbp
 d86:	48 83 ec 30          	sub    $0x30,%rsp
 d8a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d8d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d90:	48 83 c0 0f          	add    $0xf,%rax
 d94:	48 c1 e8 04          	shr    $0x4,%rax
 d98:	83 c0 01             	add    $0x1,%eax
 d9b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d9e:	48 8b 05 1b 04 00 00 	mov    0x41b(%rip),%rax        # 11c0 <freep>
 da5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 da9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 dae:	75 2b                	jne    ddb <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 db0:	48 c7 45 f0 b0 11 00 	movq   $0x11b0,-0x10(%rbp)
 db7:	00 
 db8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dbc:	48 89 05 fd 03 00 00 	mov    %rax,0x3fd(%rip)        # 11c0 <freep>
 dc3:	48 8b 05 f6 03 00 00 	mov    0x3f6(%rip),%rax        # 11c0 <freep>
 dca:	48 89 05 df 03 00 00 	mov    %rax,0x3df(%rip)        # 11b0 <base>
    base.s.size = 0;
 dd1:	c7 05 dd 03 00 00 00 	movl   $0x0,0x3dd(%rip)        # 11b8 <base+0x8>
 dd8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ddb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ddf:	48 8b 00             	mov    (%rax),%rax
 de2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 de6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dea:	8b 40 08             	mov    0x8(%rax),%eax
 ded:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 df0:	72 5f                	jb     e51 <malloc+0xd3>
      if(p->s.size == nunits)
 df2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 df6:	8b 40 08             	mov    0x8(%rax),%eax
 df9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 dfc:	75 10                	jne    e0e <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 dfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e02:	48 8b 10             	mov    (%rax),%rdx
 e05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e09:	48 89 10             	mov    %rdx,(%rax)
 e0c:	eb 2e                	jmp    e3c <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e12:	8b 40 08             	mov    0x8(%rax),%eax
 e15:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e18:	89 c2                	mov    %eax,%edx
 e1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1e:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e25:	8b 40 08             	mov    0x8(%rax),%eax
 e28:	89 c0                	mov    %eax,%eax
 e2a:	48 c1 e0 04          	shl    $0x4,%rax
 e2e:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e36:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e39:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e40:	48 89 05 79 03 00 00 	mov    %rax,0x379(%rip)        # 11c0 <freep>
      return (void*)(p + 1);
 e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e4b:	48 83 c0 10          	add    $0x10,%rax
 e4f:	eb 41                	jmp    e92 <malloc+0x114>
    }
    if(p == freep)
 e51:	48 8b 05 68 03 00 00 	mov    0x368(%rip),%rax        # 11c0 <freep>
 e58:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e5c:	75 1c                	jne    e7a <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e5e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e61:	89 c7                	mov    %eax,%edi
 e63:	e8 ad fe ff ff       	call   d15 <morecore>
 e68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e6c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e71:	75 07                	jne    e7a <malloc+0xfc>
        return 0;
 e73:	b8 00 00 00 00       	mov    $0x0,%eax
 e78:	eb 18                	jmp    e92 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e86:	48 8b 00             	mov    (%rax),%rax
 e89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e8d:	e9 54 ff ff ff       	jmp    de6 <malloc+0x68>
  }
}
 e92:	c9                   	leave
 e93:	c3                   	ret
