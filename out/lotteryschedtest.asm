
fs/lotteryschedtest:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <pindex>:
int tickets[N] = {200, 100, 500, 50, 150};
int children[N];
struct pstat pstat;
int lottery;

int pindex(struct pstat *pstat, int pid) {
   0:	f3 0f 1e fa          	endbr64
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    for (int i = 0; i < NPROC; i++) {
  13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1a:	eb 1f                	jmp    3b <pindex+0x3b>
        if (pstat->pid[i] == pid) {
  1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  20:	8b 55 fc             	mov    -0x4(%rbp),%edx
  23:	48 63 d2             	movslq %edx,%rdx
  26:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
  2a:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  2d:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
  30:	75 05                	jne    37 <pindex+0x37>
            return i;
  32:	8b 45 fc             	mov    -0x4(%rbp),%eax
  35:	eb 0f                	jmp    46 <pindex+0x46>
    for (int i = 0; i < NPROC; i++) {
  37:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  3b:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
  3f:	7e db                	jle    1c <pindex+0x1c>
        }
    }
    return -1;
  41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  46:	c9                   	leave
  47:	c3                   	ret

0000000000000048 <fork_children>:

void fork_children() {
  48:	f3 0f 1e fa          	endbr64
  4c:	55                   	push   %rbp
  4d:	48 89 e5             	mov    %rsp,%rbp
  50:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < N; i++) {
  54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  5b:	e9 8c 00 00 00       	jmp    ec <fork_children+0xa4>
        int fpid = fork();
  60:	e8 7d 06 00 00       	call   6e2 <fork>
  65:	89 45 f4             	mov    %eax,-0xc(%rbp)

        if (fpid == 0) {
  68:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  6c:	75 1b                	jne    89 <fork_children+0x41>
            settickets(tickets[i]);
  6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  71:	48 98                	cltq
  73:	8b 04 85 50 12 00 00 	mov    0x1250(,%rax,4),%eax
  7a:	89 c7                	mov    %eax,%edi
  7c:	b8 00 00 00 00       	mov    $0x0,%eax
  81:	e8 0c 07 00 00       	call   792 <settickets>

            for (;;) {
  86:	90                   	nop
  87:	eb fd                	jmp    86 <fork_children+0x3e>
            }

        } else if (fpid != -1) {
  89:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
  8d:	74 11                	je     a0 <fork_children+0x58>
            children[i] = fpid;
  8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  92:	48 98                	cltq
  94:	8b 55 f4             	mov    -0xc(%rbp),%edx
  97:	89 14 85 a0 12 00 00 	mov    %edx,0x12a0(,%rax,4)
  9e:	eb 48                	jmp    e8 <fork_children+0xa0>
        } else {
            printf(1, "\nFailed to fork children processes\n");
  a0:	48 c7 c6 c0 0e 00 00 	mov    $0xec0,%rsi
  a7:	bf 01 00 00 00       	mov    $0x1,%edi
  ac:	b8 00 00 00 00       	mov    $0x0,%eax
  b1:	e8 ee 07 00 00       	call   8a4 <printf>
            for (int j = 0; j < i; j++) {
  b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  bd:	eb 1c                	jmp    db <fork_children+0x93>
                kill(children[j]);
  bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  c2:	48 98                	cltq
  c4:	8b 04 85 a0 12 00 00 	mov    0x12a0(,%rax,4),%eax
  cb:	89 c7                	mov    %eax,%edi
  cd:	e8 48 06 00 00       	call   71a <kill>
                wait();
  d2:	e8 1b 06 00 00       	call   6f2 <wait>
            for (int j = 0; j < i; j++) {
  d7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  db:	8b 45 f8             	mov    -0x8(%rbp),%eax
  de:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  e1:	7c dc                	jl     bf <fork_children+0x77>
            }
            exit();
  e3:	e8 02 06 00 00       	call   6ea <exit>
    for (int i = 0; i < N; i++) {
  e8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  ec:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  f0:	0f 8e 6a ff ff ff    	jle    60 <fork_children+0x18>
        }
    }
    printf(1, "\nForked %d children ", N);
  f6:	ba 05 00 00 00       	mov    $0x5,%edx
  fb:	48 c7 c6 e4 0e 00 00 	mov    $0xee4,%rsi
 102:	bf 01 00 00 00       	mov    $0x1,%edi
 107:	b8 00 00 00 00       	mov    $0x0,%eax
 10c:	e8 93 07 00 00       	call   8a4 <printf>
}
 111:	90                   	nop
 112:	c9                   	leave
 113:	c3                   	ret

0000000000000114 <kill_children>:

void kill_children() {
 114:	f3 0f 1e fa          	endbr64
 118:	55                   	push   %rbp
 119:	48 89 e5             	mov    %rsp,%rbp
 11c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < N; i++) {
 120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 127:	eb 1c                	jmp    145 <kill_children+0x31>
        kill(children[i]);
 129:	8b 45 fc             	mov    -0x4(%rbp),%eax
 12c:	48 98                	cltq
 12e:	8b 04 85 a0 12 00 00 	mov    0x12a0(,%rax,4),%eax
 135:	89 c7                	mov    %eax,%edi
 137:	e8 de 05 00 00       	call   71a <kill>
        wait();
 13c:	e8 b1 05 00 00       	call   6f2 <wait>
    for (int i = 0; i < N; i++) {
 141:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 145:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
 149:	7e de                	jle    129 <kill_children+0x15>
    }
}
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	c9                   	leave
 14e:	c3                   	ret

000000000000014f <print_info>:

void print_info() {
 14f:	f3 0f 1e fa          	endbr64
 153:	55                   	push   %rbp
 154:	48 89 e5             	mov    %rsp,%rbp
 157:	48 83 ec 50          	sub    $0x50,%rsp
    int index[N] = {-1};
 15b:	66 0f ef c0          	pxor   %xmm0,%xmm0
 15f:	0f 29 45 d0          	movaps %xmm0,-0x30(%rbp)
 163:	66 0f 7e 45 e0       	movd   %xmm0,-0x20(%rbp)
 168:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
    int ticks[N] = {-1};
 16f:	66 0f ef c0          	pxor   %xmm0,%xmm0
 173:	0f 29 45 b0          	movaps %xmm0,-0x50(%rbp)
 177:	66 0f 7e 45 c0       	movd   %xmm0,-0x40(%rbp)
 17c:	c7 45 b0 ff ff ff ff 	movl   $0xffffffff,-0x50(%rbp)
    int tticks = 0;
 183:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

    for (int i = 0; i < N; i++) {
 18a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
 191:	eb 7e                	jmp    211 <print_info+0xc2>
        index[i] = pindex(&pstat, children[i]);
 193:	8b 45 f8             	mov    -0x8(%rbp),%eax
 196:	48 98                	cltq
 198:	8b 04 85 a0 12 00 00 	mov    0x12a0(,%rax,4),%eax
 19f:	89 c6                	mov    %eax,%esi
 1a1:	48 c7 c7 c0 12 00 00 	mov    $0x12c0,%rdi
 1a8:	e8 53 fe ff ff       	call   0 <pindex>
 1ad:	8b 55 f8             	mov    -0x8(%rbp),%edx
 1b0:	48 63 d2             	movslq %edx,%rdx
 1b3:	89 44 95 d0          	mov    %eax,-0x30(%rbp,%rdx,4)

        if (index[i] == -1) {
 1b7:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1ba:	48 98                	cltq
 1bc:	8b 44 85 d0          	mov    -0x30(%rbp,%rax,4),%eax
 1c0:	83 f8 ff             	cmp    $0xffffffff,%eax
 1c3:	75 1b                	jne    1e0 <print_info+0x91>
            printf(1, "Failed to get process info\n");
 1c5:	48 c7 c6 f9 0e 00 00 	mov    $0xef9,%rsi
 1cc:	bf 01 00 00 00       	mov    $0x1,%edi
 1d1:	b8 00 00 00 00       	mov    $0x0,%eax
 1d6:	e8 c9 06 00 00       	call   8a4 <printf>
            exit();
 1db:	e8 0a 05 00 00       	call   6ea <exit>
        }

        ticks[i] = pstat.ticks[index[i]];
 1e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1e3:	48 98                	cltq
 1e5:	8b 44 85 d0          	mov    -0x30(%rbp,%rax,4),%eax
 1e9:	48 98                	cltq
 1eb:	48 05 c0 00 00 00    	add    $0xc0,%rax
 1f1:	8b 14 85 c0 12 00 00 	mov    0x12c0(,%rax,4),%edx
 1f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1fb:	48 98                	cltq
 1fd:	89 54 85 b0          	mov    %edx,-0x50(%rbp,%rax,4)
        tticks += ticks[i];
 201:	8b 45 f8             	mov    -0x8(%rbp),%eax
 204:	48 98                	cltq
 206:	8b 44 85 b0          	mov    -0x50(%rbp,%rax,4),%eax
 20a:	01 45 fc             	add    %eax,-0x4(%rbp)
    for (int i = 0; i < N; i++) {
 20d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
 211:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
 215:	0f 8e 78 ff ff ff    	jle    193 <print_info+0x44>
    }

    printf(1, "(real %d)\n\n", tticks);
 21b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 21e:	89 c2                	mov    %eax,%edx
 220:	48 c7 c6 15 0f 00 00 	mov    $0xf15,%rsi
 227:	bf 01 00 00 00       	mov    $0x1,%edi
 22c:	b8 00 00 00 00       	mov    $0x0,%eax
 231:	e8 6e 06 00 00       	call   8a4 <printf>

    for (int i = 0; i < N; i++) {
 236:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 23d:	e9 d3 00 00 00       	jmp    315 <print_info+0x1c6>
        int cpu1 = ticks[i] / (tticks / 100);
 242:	8b 45 f4             	mov    -0xc(%rbp),%eax
 245:	48 98                	cltq
 247:	8b 54 85 b0          	mov    -0x50(%rbp,%rax,4),%edx
 24b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 24e:	48 63 c8             	movslq %eax,%rcx
 251:	48 69 c9 1f 85 eb 51 	imul   $0x51eb851f,%rcx,%rcx
 258:	48 c1 e9 20          	shr    $0x20,%rcx
 25c:	c1 f9 05             	sar    $0x5,%ecx
 25f:	c1 f8 1f             	sar    $0x1f,%eax
 262:	29 c1                	sub    %eax,%ecx
 264:	89 d0                	mov    %edx,%eax
 266:	99                   	cltd
 267:	f7 f9                	idiv   %ecx
 269:	89 45 f0             	mov    %eax,-0x10(%rbp)
        int cpu2 = ticks[i] / (tticks / 1000) % 10;
 26c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 26f:	48 98                	cltq
 271:	8b 54 85 b0          	mov    -0x50(%rbp,%rax,4),%edx
 275:	8b 45 fc             	mov    -0x4(%rbp),%eax
 278:	48 63 c8             	movslq %eax,%rcx
 27b:	48 69 c9 d3 4d 62 10 	imul   $0x10624dd3,%rcx,%rcx
 282:	48 c1 e9 20          	shr    $0x20,%rcx
 286:	c1 f9 06             	sar    $0x6,%ecx
 289:	c1 f8 1f             	sar    $0x1f,%eax
 28c:	29 c1                	sub    %eax,%ecx
 28e:	89 d0                	mov    %edx,%eax
 290:	99                   	cltd
 291:	f7 f9                	idiv   %ecx
 293:	89 c2                	mov    %eax,%edx
 295:	48 63 c2             	movslq %edx,%rax
 298:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
 29f:	48 c1 e8 20          	shr    $0x20,%rax
 2a3:	c1 f8 02             	sar    $0x2,%eax
 2a6:	89 d1                	mov    %edx,%ecx
 2a8:	c1 f9 1f             	sar    $0x1f,%ecx
 2ab:	29 c8                	sub    %ecx,%eax
 2ad:	89 45 ec             	mov    %eax,-0x14(%rbp)
 2b0:	8b 4d ec             	mov    -0x14(%rbp),%ecx
 2b3:	89 c8                	mov    %ecx,%eax
 2b5:	c1 e0 02             	shl    $0x2,%eax
 2b8:	01 c8                	add    %ecx,%eax
 2ba:	01 c0                	add    %eax,%eax
 2bc:	29 c2                	sub    %eax,%edx
 2be:	89 55 ec             	mov    %edx,-0x14(%rbp)

        printf(1, "PID: %d\tTICKETS: %d\tTICKS: %d\tCPU: %d.%d%%\n",
 2c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
 2c4:	48 98                	cltq
 2c6:	8b 74 85 b0          	mov    -0x50(%rbp,%rax,4),%esi
 2ca:	8b 45 f4             	mov    -0xc(%rbp),%eax
 2cd:	48 98                	cltq
 2cf:	8b 14 85 50 12 00 00 	mov    0x1250(,%rax,4),%edx
 2d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
 2d9:	48 98                	cltq
 2db:	8b 04 85 a0 12 00 00 	mov    0x12a0(,%rax,4),%eax
 2e2:	8b 7d f0             	mov    -0x10(%rbp),%edi
 2e5:	48 83 ec 08          	sub    $0x8,%rsp
 2e9:	8b 4d ec             	mov    -0x14(%rbp),%ecx
 2ec:	51                   	push   %rcx
 2ed:	41 89 f9             	mov    %edi,%r9d
 2f0:	41 89 f0             	mov    %esi,%r8d
 2f3:	89 d1                	mov    %edx,%ecx
 2f5:	89 c2                	mov    %eax,%edx
 2f7:	48 c7 c6 28 0f 00 00 	mov    $0xf28,%rsi
 2fe:	bf 01 00 00 00       	mov    $0x1,%edi
 303:	b8 00 00 00 00       	mov    $0x0,%eax
 308:	e8 97 05 00 00       	call   8a4 <printf>
 30d:	48 83 c4 10          	add    $0x10,%rsp
    for (int i = 0; i < N; i++) {
 311:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 315:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
 319:	0f 8e 23 ff ff ff    	jle    242 <print_info+0xf3>
               children[i], tickets[i], ticks[i], cpu1, cpu2);
    }
    printf(1, "\n");
 31f:	48 c7 c6 54 0f 00 00 	mov    $0xf54,%rsi
 326:	bf 01 00 00 00       	mov    $0x1,%edi
 32b:	b8 00 00 00 00       	mov    $0x0,%eax
 330:	e8 6f 05 00 00       	call   8a4 <printf>
}
 335:	90                   	nop
 336:	c9                   	leave
 337:	c3                   	ret

0000000000000338 <main>:

void main(int argc, char *argv[]) {
 338:	f3 0f 1e fa          	endbr64
 33c:	55                   	push   %rbp
 33d:	48 89 e5             	mov    %rsp,%rbp
 340:	48 83 ec 10          	sub    $0x10,%rsp
 344:	89 7d fc             	mov    %edi,-0x4(%rbp)
 347:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    settickets(1000000);
 34b:	bf 40 42 0f 00       	mov    $0xf4240,%edi
 350:	b8 00 00 00 00       	mov    $0x0,%eax
 355:	e8 38 04 00 00       	call   792 <settickets>

    fork_children();
 35a:	b8 00 00 00 00       	mov    $0x0,%eax
 35f:	e8 e4 fc ff ff       	call   48 <fork_children>

    printf(1, "to share ~3000 ticks ");
 364:	48 c7 c6 56 0f 00 00 	mov    $0xf56,%rsi
 36b:	bf 01 00 00 00       	mov    $0x1,%edi
 370:	b8 00 00 00 00       	mov    $0x0,%eax
 375:	e8 2a 05 00 00       	call   8a4 <printf>

    sleep(3000);
 37a:	bf b8 0b 00 00       	mov    $0xbb8,%edi
 37f:	e8 f6 03 00 00       	call   77a <sleep>

    if (getpinfo(&pstat) == -1) {
 384:	48 c7 c7 c0 12 00 00 	mov    $0x12c0,%rdi
 38b:	e8 fa 03 00 00       	call   78a <getpinfo>
 390:	83 f8 ff             	cmp    $0xffffffff,%eax
 393:	75 25                	jne    3ba <main+0x82>
        printf(1, "\nFailed to get pinfo\n");
 395:	48 c7 c6 6c 0f 00 00 	mov    $0xf6c,%rsi
 39c:	bf 01 00 00 00       	mov    $0x1,%edi
 3a1:	b8 00 00 00 00       	mov    $0x0,%eax
 3a6:	e8 f9 04 00 00       	call   8a4 <printf>
        kill_children();
 3ab:	b8 00 00 00 00       	mov    $0x0,%eax
 3b0:	e8 5f fd ff ff       	call   114 <kill_children>
        exit();
 3b5:	e8 30 03 00 00       	call   6ea <exit>
    }

    kill_children();
 3ba:	b8 00 00 00 00       	mov    $0x0,%eax
 3bf:	e8 50 fd ff ff       	call   114 <kill_children>
    print_info();
 3c4:	b8 00 00 00 00       	mov    $0x0,%eax
 3c9:	e8 81 fd ff ff       	call   14f <print_info>
    exit();
 3ce:	e8 17 03 00 00       	call   6ea <exit>

00000000000003d3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3d3:	55                   	push   %rbp
 3d4:	48 89 e5             	mov    %rsp,%rbp
 3d7:	48 83 ec 10          	sub    $0x10,%rsp
 3db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3df:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3e2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3e5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3e9:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3ec:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3ef:	48 89 ce             	mov    %rcx,%rsi
 3f2:	48 89 f7             	mov    %rsi,%rdi
 3f5:	89 d1                	mov    %edx,%ecx
 3f7:	fc                   	cld
 3f8:	f3 aa                	rep stos %al,%es:(%rdi)
 3fa:	89 ca                	mov    %ecx,%edx
 3fc:	48 89 fe             	mov    %rdi,%rsi
 3ff:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 403:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 406:	90                   	nop
 407:	c9                   	leave
 408:	c3                   	ret

0000000000000409 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 409:	f3 0f 1e fa          	endbr64
 40d:	55                   	push   %rbp
 40e:	48 89 e5             	mov    %rsp,%rbp
 411:	48 83 ec 20          	sub    $0x20,%rsp
 415:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 419:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 41d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 421:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 425:	90                   	nop
 426:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 42a:	48 8d 42 01          	lea    0x1(%rdx),%rax
 42e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 432:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 436:	48 8d 48 01          	lea    0x1(%rax),%rcx
 43a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 43e:	0f b6 12             	movzbl (%rdx),%edx
 441:	88 10                	mov    %dl,(%rax)
 443:	0f b6 00             	movzbl (%rax),%eax
 446:	84 c0                	test   %al,%al
 448:	75 dc                	jne    426 <strcpy+0x1d>
    ;
  return os;
 44a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 44e:	c9                   	leave
 44f:	c3                   	ret

0000000000000450 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 450:	f3 0f 1e fa          	endbr64
 454:	55                   	push   %rbp
 455:	48 89 e5             	mov    %rsp,%rbp
 458:	48 83 ec 10          	sub    $0x10,%rsp
 45c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 460:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 464:	eb 0a                	jmp    470 <strcmp+0x20>
    p++, q++;
 466:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 46b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 474:	0f b6 00             	movzbl (%rax),%eax
 477:	84 c0                	test   %al,%al
 479:	74 12                	je     48d <strcmp+0x3d>
 47b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 47f:	0f b6 10             	movzbl (%rax),%edx
 482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 486:	0f b6 00             	movzbl (%rax),%eax
 489:	38 c2                	cmp    %al,%dl
 48b:	74 d9                	je     466 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
 48d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 491:	0f b6 00             	movzbl (%rax),%eax
 494:	0f b6 d0             	movzbl %al,%edx
 497:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 49b:	0f b6 00             	movzbl (%rax),%eax
 49e:	0f b6 c0             	movzbl %al,%eax
 4a1:	29 c2                	sub    %eax,%edx
 4a3:	89 d0                	mov    %edx,%eax
}
 4a5:	c9                   	leave
 4a6:	c3                   	ret

00000000000004a7 <strlen>:

uint
strlen(char *s)
{
 4a7:	f3 0f 1e fa          	endbr64
 4ab:	55                   	push   %rbp
 4ac:	48 89 e5             	mov    %rsp,%rbp
 4af:	48 83 ec 18          	sub    $0x18,%rsp
 4b3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 4b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 4be:	eb 04                	jmp    4c4 <strlen+0x1d>
 4c0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 4c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c7:	48 63 d0             	movslq %eax,%rdx
 4ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4ce:	48 01 d0             	add    %rdx,%rax
 4d1:	0f b6 00             	movzbl (%rax),%eax
 4d4:	84 c0                	test   %al,%al
 4d6:	75 e8                	jne    4c0 <strlen+0x19>
    ;
  return n;
 4d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4db:	c9                   	leave
 4dc:	c3                   	ret

00000000000004dd <memset>:

void*
memset(void *dst, int c, uint n)
{
 4dd:	f3 0f 1e fa          	endbr64
 4e1:	55                   	push   %rbp
 4e2:	48 89 e5             	mov    %rsp,%rbp
 4e5:	48 83 ec 10          	sub    $0x10,%rsp
 4e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4ed:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4f0:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4f3:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4f6:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4fd:	89 ce                	mov    %ecx,%esi
 4ff:	48 89 c7             	mov    %rax,%rdi
 502:	e8 cc fe ff ff       	call   3d3 <stosb>
  return dst;
 507:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 50b:	c9                   	leave
 50c:	c3                   	ret

000000000000050d <strchr>:

char*
strchr(const char *s, char c)
{
 50d:	f3 0f 1e fa          	endbr64
 511:	55                   	push   %rbp
 512:	48 89 e5             	mov    %rsp,%rbp
 515:	48 83 ec 10          	sub    $0x10,%rsp
 519:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 51d:	89 f0                	mov    %esi,%eax
 51f:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 522:	eb 17                	jmp    53b <strchr+0x2e>
    if(*s == c)
 524:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 528:	0f b6 00             	movzbl (%rax),%eax
 52b:	38 45 f4             	cmp    %al,-0xc(%rbp)
 52e:	75 06                	jne    536 <strchr+0x29>
      return (char*)s;
 530:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 534:	eb 15                	jmp    54b <strchr+0x3e>
  for(; *s; s++)
 536:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 53b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 53f:	0f b6 00             	movzbl (%rax),%eax
 542:	84 c0                	test   %al,%al
 544:	75 de                	jne    524 <strchr+0x17>
  return 0;
 546:	b8 00 00 00 00       	mov    $0x0,%eax
}
 54b:	c9                   	leave
 54c:	c3                   	ret

000000000000054d <gets>:

char*
gets(char *buf, int max)
{
 54d:	f3 0f 1e fa          	endbr64
 551:	55                   	push   %rbp
 552:	48 89 e5             	mov    %rsp,%rbp
 555:	48 83 ec 20          	sub    $0x20,%rsp
 559:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 55d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 560:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 567:	eb 48                	jmp    5b1 <gets+0x64>
    cc = read(0, &c, 1);
 569:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 56d:	ba 01 00 00 00       	mov    $0x1,%edx
 572:	48 89 c6             	mov    %rax,%rsi
 575:	bf 00 00 00 00       	mov    $0x0,%edi
 57a:	e8 83 01 00 00       	call   702 <read>
 57f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 582:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 586:	7e 36                	jle    5be <gets+0x71>
      break;
    buf[i++] = c;
 588:	8b 45 fc             	mov    -0x4(%rbp),%eax
 58b:	8d 50 01             	lea    0x1(%rax),%edx
 58e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 591:	48 63 d0             	movslq %eax,%rdx
 594:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 598:	48 01 c2             	add    %rax,%rdx
 59b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 59f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 5a1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 5a5:	3c 0a                	cmp    $0xa,%al
 5a7:	74 16                	je     5bf <gets+0x72>
 5a9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 5ad:	3c 0d                	cmp    $0xd,%al
 5af:	74 0e                	je     5bf <gets+0x72>
  for(i=0; i+1 < max; ){
 5b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b4:	83 c0 01             	add    $0x1,%eax
 5b7:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 5ba:	7f ad                	jg     569 <gets+0x1c>
 5bc:	eb 01                	jmp    5bf <gets+0x72>
      break;
 5be:	90                   	nop
      break;
  }
  buf[i] = '\0';
 5bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5c2:	48 63 d0             	movslq %eax,%rdx
 5c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5c9:	48 01 d0             	add    %rdx,%rax
 5cc:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 5cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 5d3:	c9                   	leave
 5d4:	c3                   	ret

00000000000005d5 <stat>:

int
stat(char *n, struct stat *st)
{
 5d5:	f3 0f 1e fa          	endbr64
 5d9:	55                   	push   %rbp
 5da:	48 89 e5             	mov    %rsp,%rbp
 5dd:	48 83 ec 20          	sub    $0x20,%rsp
 5e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 5e5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5ed:	be 00 00 00 00       	mov    $0x0,%esi
 5f2:	48 89 c7             	mov    %rax,%rdi
 5f5:	e8 30 01 00 00       	call   72a <open>
 5fa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5fd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 601:	79 07                	jns    60a <stat+0x35>
    return -1;
 603:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 608:	eb 21                	jmp    62b <stat+0x56>
  r = fstat(fd, st);
 60a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 60e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 611:	48 89 d6             	mov    %rdx,%rsi
 614:	89 c7                	mov    %eax,%edi
 616:	e8 27 01 00 00       	call   742 <fstat>
 61b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 61e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 621:	89 c7                	mov    %eax,%edi
 623:	e8 ea 00 00 00       	call   712 <close>
  return r;
 628:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 62b:	c9                   	leave
 62c:	c3                   	ret

000000000000062d <atoi>:

int
atoi(const char *s)
{
 62d:	f3 0f 1e fa          	endbr64
 631:	55                   	push   %rbp
 632:	48 89 e5             	mov    %rsp,%rbp
 635:	48 83 ec 18          	sub    $0x18,%rsp
 639:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 63d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 644:	eb 28                	jmp    66e <atoi+0x41>
    n = n*10 + *s++ - '0';
 646:	8b 55 fc             	mov    -0x4(%rbp),%edx
 649:	89 d0                	mov    %edx,%eax
 64b:	c1 e0 02             	shl    $0x2,%eax
 64e:	01 d0                	add    %edx,%eax
 650:	01 c0                	add    %eax,%eax
 652:	89 c1                	mov    %eax,%ecx
 654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 658:	48 8d 50 01          	lea    0x1(%rax),%rdx
 65c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 660:	0f b6 00             	movzbl (%rax),%eax
 663:	0f be c0             	movsbl %al,%eax
 666:	01 c8                	add    %ecx,%eax
 668:	83 e8 30             	sub    $0x30,%eax
 66b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 66e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 672:	0f b6 00             	movzbl (%rax),%eax
 675:	3c 2f                	cmp    $0x2f,%al
 677:	7e 0b                	jle    684 <atoi+0x57>
 679:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 67d:	0f b6 00             	movzbl (%rax),%eax
 680:	3c 39                	cmp    $0x39,%al
 682:	7e c2                	jle    646 <atoi+0x19>
  return n;
 684:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 687:	c9                   	leave
 688:	c3                   	ret

0000000000000689 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 689:	f3 0f 1e fa          	endbr64
 68d:	55                   	push   %rbp
 68e:	48 89 e5             	mov    %rsp,%rbp
 691:	48 83 ec 28          	sub    $0x28,%rsp
 695:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 699:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 69d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 6a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 6a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 6a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 6ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 6b0:	eb 1d                	jmp    6cf <memmove+0x46>
    *dst++ = *src++;
 6b2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 6b6:	48 8d 42 01          	lea    0x1(%rdx),%rax
 6ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 6be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 6c2:	48 8d 48 01          	lea    0x1(%rax),%rcx
 6c6:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 6ca:	0f b6 12             	movzbl (%rdx),%edx
 6cd:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 6cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 6d2:	8d 50 ff             	lea    -0x1(%rax),%edx
 6d5:	89 55 dc             	mov    %edx,-0x24(%rbp)
 6d8:	85 c0                	test   %eax,%eax
 6da:	7f d6                	jg     6b2 <memmove+0x29>
  return vdst;
 6dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 6e0:	c9                   	leave
 6e1:	c3                   	ret

00000000000006e2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6e2:	b8 01 00 00 00       	mov    $0x1,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret

00000000000006ea <exit>:
SYSCALL(exit)
 6ea:	b8 02 00 00 00       	mov    $0x2,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret

00000000000006f2 <wait>:
SYSCALL(wait)
 6f2:	b8 03 00 00 00       	mov    $0x3,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret

00000000000006fa <pipe>:
SYSCALL(pipe)
 6fa:	b8 04 00 00 00       	mov    $0x4,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret

0000000000000702 <read>:
SYSCALL(read)
 702:	b8 05 00 00 00       	mov    $0x5,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret

000000000000070a <write>:
SYSCALL(write)
 70a:	b8 10 00 00 00       	mov    $0x10,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret

0000000000000712 <close>:
SYSCALL(close)
 712:	b8 15 00 00 00       	mov    $0x15,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret

000000000000071a <kill>:
SYSCALL(kill)
 71a:	b8 06 00 00 00       	mov    $0x6,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret

0000000000000722 <exec>:
SYSCALL(exec)
 722:	b8 07 00 00 00       	mov    $0x7,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret

000000000000072a <open>:
SYSCALL(open)
 72a:	b8 0f 00 00 00       	mov    $0xf,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret

0000000000000732 <mknod>:
SYSCALL(mknod)
 732:	b8 11 00 00 00       	mov    $0x11,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret

000000000000073a <unlink>:
SYSCALL(unlink)
 73a:	b8 12 00 00 00       	mov    $0x12,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret

0000000000000742 <fstat>:
SYSCALL(fstat)
 742:	b8 08 00 00 00       	mov    $0x8,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret

000000000000074a <link>:
SYSCALL(link)
 74a:	b8 13 00 00 00       	mov    $0x13,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret

0000000000000752 <mkdir>:
SYSCALL(mkdir)
 752:	b8 14 00 00 00       	mov    $0x14,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret

000000000000075a <chdir>:
SYSCALL(chdir)
 75a:	b8 09 00 00 00       	mov    $0x9,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret

0000000000000762 <dup>:
SYSCALL(dup)
 762:	b8 0a 00 00 00       	mov    $0xa,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret

000000000000076a <getpid>:
SYSCALL(getpid)
 76a:	b8 0b 00 00 00       	mov    $0xb,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret

0000000000000772 <sbrk>:
SYSCALL(sbrk)
 772:	b8 0c 00 00 00       	mov    $0xc,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret

000000000000077a <sleep>:
SYSCALL(sleep)
 77a:	b8 0d 00 00 00       	mov    $0xd,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret

0000000000000782 <uptime>:
SYSCALL(uptime)
 782:	b8 0e 00 00 00       	mov    $0xe,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret

000000000000078a <getpinfo>:
SYSCALL(getpinfo)
 78a:	b8 18 00 00 00       	mov    $0x18,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret

0000000000000792 <settickets>:
SYSCALL(settickets)
 792:	b8 1b 00 00 00       	mov    $0x1b,%eax
 797:	cd 40                	int    $0x40
 799:	c3                   	ret

000000000000079a <getfavnum>:
SYSCALL(getfavnum)
 79a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret

00000000000007a2 <halt>:
SYSCALL(halt)
 7a2:	b8 1d 00 00 00       	mov    $0x1d,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret

00000000000007aa <getcount>:
SYSCALL(getcount)
 7aa:	b8 1e 00 00 00       	mov    $0x1e,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret

00000000000007b2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7b2:	f3 0f 1e fa          	endbr64
 7b6:	55                   	push   %rbp
 7b7:	48 89 e5             	mov    %rsp,%rbp
 7ba:	48 83 ec 10          	sub    $0x10,%rsp
 7be:	89 7d fc             	mov    %edi,-0x4(%rbp)
 7c1:	89 f0                	mov    %esi,%eax
 7c3:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7c6:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7cd:	ba 01 00 00 00       	mov    $0x1,%edx
 7d2:	48 89 ce             	mov    %rcx,%rsi
 7d5:	89 c7                	mov    %eax,%edi
 7d7:	e8 2e ff ff ff       	call   70a <write>
}
 7dc:	90                   	nop
 7dd:	c9                   	leave
 7de:	c3                   	ret

00000000000007df <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7df:	f3 0f 1e fa          	endbr64
 7e3:	55                   	push   %rbp
 7e4:	48 89 e5             	mov    %rsp,%rbp
 7e7:	48 83 ec 30          	sub    $0x30,%rsp
 7eb:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7ee:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7f1:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7f4:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7fe:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 802:	74 17                	je     81b <printint+0x3c>
 804:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 808:	79 11                	jns    81b <printint+0x3c>
    neg = 1;
 80a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 811:	8b 45 d8             	mov    -0x28(%rbp),%eax
 814:	f7 d8                	neg    %eax
 816:	89 45 f4             	mov    %eax,-0xc(%rbp)
 819:	eb 06                	jmp    821 <printint+0x42>
  } else {
    x = xx;
 81b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 81e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 821:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 828:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 82b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 82e:	ba 00 00 00 00       	mov    $0x0,%edx
 833:	f7 f6                	div    %esi
 835:	89 d1                	mov    %edx,%ecx
 837:	8b 45 fc             	mov    -0x4(%rbp),%eax
 83a:	8d 50 01             	lea    0x1(%rax),%edx
 83d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 840:	89 ca                	mov    %ecx,%edx
 842:	0f b6 92 70 12 00 00 	movzbl 0x1270(%rdx),%edx
 849:	48 98                	cltq
 84b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 84f:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 852:	8b 45 f4             	mov    -0xc(%rbp),%eax
 855:	ba 00 00 00 00       	mov    $0x0,%edx
 85a:	f7 f7                	div    %edi
 85c:	89 45 f4             	mov    %eax,-0xc(%rbp)
 85f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 863:	75 c3                	jne    828 <printint+0x49>
  if(neg)
 865:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 869:	74 2b                	je     896 <printint+0xb7>
    buf[i++] = '-';
 86b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 86e:	8d 50 01             	lea    0x1(%rax),%edx
 871:	89 55 fc             	mov    %edx,-0x4(%rbp)
 874:	48 98                	cltq
 876:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 87b:	eb 19                	jmp    896 <printint+0xb7>
    putc(fd, buf[i]);
 87d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 880:	48 98                	cltq
 882:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 887:	0f be d0             	movsbl %al,%edx
 88a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 88d:	89 d6                	mov    %edx,%esi
 88f:	89 c7                	mov    %eax,%edi
 891:	e8 1c ff ff ff       	call   7b2 <putc>
  while(--i >= 0)
 896:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 89a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 89e:	79 dd                	jns    87d <printint+0x9e>
}
 8a0:	90                   	nop
 8a1:	90                   	nop
 8a2:	c9                   	leave
 8a3:	c3                   	ret

00000000000008a4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8a4:	f3 0f 1e fa          	endbr64
 8a8:	55                   	push   %rbp
 8a9:	48 89 e5             	mov    %rsp,%rbp
 8ac:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 8b3:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 8b9:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 8c0:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8c7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8ce:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8d5:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8dc:	84 c0                	test   %al,%al
 8de:	74 20                	je     900 <printf+0x5c>
 8e0:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8e4:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8e8:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8ec:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8f0:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8f4:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8f8:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8fc:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 900:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 907:	00 00 00 
 90a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 911:	00 00 00 
 914:	48 8d 45 10          	lea    0x10(%rbp),%rax
 918:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 91f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 926:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 92d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 934:	00 00 00 
  for(i = 0; fmt[i]; i++){
 937:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 93e:	00 00 00 
 941:	e9 a8 02 00 00       	jmp    bee <printf+0x34a>
    c = fmt[i] & 0xff;
 946:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 94c:	48 63 d0             	movslq %eax,%rdx
 94f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 956:	48 01 d0             	add    %rdx,%rax
 959:	0f b6 00             	movzbl (%rax),%eax
 95c:	0f be c0             	movsbl %al,%eax
 95f:	25 ff 00 00 00       	and    $0xff,%eax
 964:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 96a:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 971:	75 35                	jne    9a8 <printf+0x104>
      if(c == '%'){
 973:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 97a:	75 0f                	jne    98b <printf+0xe7>
        state = '%';
 97c:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 983:	00 00 00 
 986:	e9 5c 02 00 00       	jmp    be7 <printf+0x343>
      } else {
        putc(fd, c);
 98b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 991:	0f be d0             	movsbl %al,%edx
 994:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 99a:	89 d6                	mov    %edx,%esi
 99c:	89 c7                	mov    %eax,%edi
 99e:	e8 0f fe ff ff       	call   7b2 <putc>
 9a3:	e9 3f 02 00 00       	jmp    be7 <printf+0x343>
      }
    } else if(state == '%'){
 9a8:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 9af:	0f 85 32 02 00 00    	jne    be7 <printf+0x343>
      if(c == 'd'){
 9b5:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 9bc:	75 5e                	jne    a1c <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 9be:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9c4:	83 f8 2f             	cmp    $0x2f,%eax
 9c7:	77 23                	ja     9ec <printf+0x148>
 9c9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9d0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9d6:	89 d2                	mov    %edx,%edx
 9d8:	48 01 d0             	add    %rdx,%rax
 9db:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9e1:	83 c2 08             	add    $0x8,%edx
 9e4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9ea:	eb 12                	jmp    9fe <printf+0x15a>
 9ec:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9f3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9f7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9fe:	8b 30                	mov    (%rax),%esi
 a00:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a06:	b9 01 00 00 00       	mov    $0x1,%ecx
 a0b:	ba 0a 00 00 00       	mov    $0xa,%edx
 a10:	89 c7                	mov    %eax,%edi
 a12:	e8 c8 fd ff ff       	call   7df <printint>
 a17:	e9 c1 01 00 00       	jmp    bdd <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 a1c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a23:	74 09                	je     a2e <printf+0x18a>
 a25:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a2c:	75 5e                	jne    a8c <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a2e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a34:	83 f8 2f             	cmp    $0x2f,%eax
 a37:	77 23                	ja     a5c <printf+0x1b8>
 a39:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a40:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a46:	89 d2                	mov    %edx,%edx
 a48:	48 01 d0             	add    %rdx,%rax
 a4b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a51:	83 c2 08             	add    $0x8,%edx
 a54:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a5a:	eb 12                	jmp    a6e <printf+0x1ca>
 a5c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a63:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a67:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a6e:	8b 30                	mov    (%rax),%esi
 a70:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a76:	b9 00 00 00 00       	mov    $0x0,%ecx
 a7b:	ba 10 00 00 00       	mov    $0x10,%edx
 a80:	89 c7                	mov    %eax,%edi
 a82:	e8 58 fd ff ff       	call   7df <printint>
 a87:	e9 51 01 00 00       	jmp    bdd <printf+0x339>
      } else if(c == 's'){
 a8c:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a93:	0f 85 98 00 00 00    	jne    b31 <printf+0x28d>
        s = va_arg(ap, char*);
 a99:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a9f:	83 f8 2f             	cmp    $0x2f,%eax
 aa2:	77 23                	ja     ac7 <printf+0x223>
 aa4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 aab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ab1:	89 d2                	mov    %edx,%edx
 ab3:	48 01 d0             	add    %rdx,%rax
 ab6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 abc:	83 c2 08             	add    $0x8,%edx
 abf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 ac5:	eb 12                	jmp    ad9 <printf+0x235>
 ac7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 ace:	48 8d 50 08          	lea    0x8(%rax),%rdx
 ad2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ad9:	48 8b 00             	mov    (%rax),%rax
 adc:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 ae3:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 aea:	00 
 aeb:	75 31                	jne    b1e <printf+0x27a>
          s = "(null)";
 aed:	48 c7 85 48 ff ff ff 	movq   $0xf82,-0xb8(%rbp)
 af4:	82 0f 00 00 
        while(*s != 0){
 af8:	eb 24                	jmp    b1e <printf+0x27a>
          putc(fd, *s);
 afa:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b01:	0f b6 00             	movzbl (%rax),%eax
 b04:	0f be d0             	movsbl %al,%edx
 b07:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b0d:	89 d6                	mov    %edx,%esi
 b0f:	89 c7                	mov    %eax,%edi
 b11:	e8 9c fc ff ff       	call   7b2 <putc>
          s++;
 b16:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 b1d:	01 
        while(*s != 0){
 b1e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b25:	0f b6 00             	movzbl (%rax),%eax
 b28:	84 c0                	test   %al,%al
 b2a:	75 ce                	jne    afa <printf+0x256>
 b2c:	e9 ac 00 00 00       	jmp    bdd <printf+0x339>
        }
      } else if(c == 'c'){
 b31:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b38:	75 56                	jne    b90 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b3a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b40:	83 f8 2f             	cmp    $0x2f,%eax
 b43:	77 23                	ja     b68 <printf+0x2c4>
 b45:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b4c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b52:	89 d2                	mov    %edx,%edx
 b54:	48 01 d0             	add    %rdx,%rax
 b57:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b5d:	83 c2 08             	add    $0x8,%edx
 b60:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b66:	eb 12                	jmp    b7a <printf+0x2d6>
 b68:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b6f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b73:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b7a:	8b 00                	mov    (%rax),%eax
 b7c:	0f be d0             	movsbl %al,%edx
 b7f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b85:	89 d6                	mov    %edx,%esi
 b87:	89 c7                	mov    %eax,%edi
 b89:	e8 24 fc ff ff       	call   7b2 <putc>
 b8e:	eb 4d                	jmp    bdd <printf+0x339>
      } else if(c == '%'){
 b90:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b97:	75 1a                	jne    bb3 <printf+0x30f>
        putc(fd, c);
 b99:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b9f:	0f be d0             	movsbl %al,%edx
 ba2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ba8:	89 d6                	mov    %edx,%esi
 baa:	89 c7                	mov    %eax,%edi
 bac:	e8 01 fc ff ff       	call   7b2 <putc>
 bb1:	eb 2a                	jmp    bdd <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bb3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bb9:	be 25 00 00 00       	mov    $0x25,%esi
 bbe:	89 c7                	mov    %eax,%edi
 bc0:	e8 ed fb ff ff       	call   7b2 <putc>
        putc(fd, c);
 bc5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 bcb:	0f be d0             	movsbl %al,%edx
 bce:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bd4:	89 d6                	mov    %edx,%esi
 bd6:	89 c7                	mov    %eax,%edi
 bd8:	e8 d5 fb ff ff       	call   7b2 <putc>
      }
      state = 0;
 bdd:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 be4:	00 00 00 
  for(i = 0; fmt[i]; i++){
 be7:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bee:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bf4:	48 63 d0             	movslq %eax,%rdx
 bf7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bfe:	48 01 d0             	add    %rdx,%rax
 c01:	0f b6 00             	movzbl (%rax),%eax
 c04:	84 c0                	test   %al,%al
 c06:	0f 85 3a fd ff ff    	jne    946 <printf+0xa2>
    }
  }
}
 c0c:	90                   	nop
 c0d:	90                   	nop
 c0e:	c9                   	leave
 c0f:	c3                   	ret

0000000000000c10 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c10:	f3 0f 1e fa          	endbr64
 c14:	55                   	push   %rbp
 c15:	48 89 e5             	mov    %rsp,%rbp
 c18:	48 83 ec 18          	sub    $0x18,%rsp
 c1c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c24:	48 83 e8 10          	sub    $0x10,%rax
 c28:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c2c:	48 8b 05 ad 0a 00 00 	mov    0xaad(%rip),%rax        # 16e0 <freep>
 c33:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c37:	eb 2f                	jmp    c68 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3d:	48 8b 00             	mov    (%rax),%rax
 c40:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c44:	72 17                	jb     c5d <free+0x4d>
 c46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c4a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c4e:	72 2f                	jb     c7f <free+0x6f>
 c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c54:	48 8b 00             	mov    (%rax),%rax
 c57:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c5b:	72 22                	jb     c7f <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c61:	48 8b 00             	mov    (%rax),%rax
 c64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c6c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c70:	73 c7                	jae    c39 <free+0x29>
 c72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c76:	48 8b 00             	mov    (%rax),%rax
 c79:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c7d:	73 ba                	jae    c39 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c83:	8b 40 08             	mov    0x8(%rax),%eax
 c86:	89 c0                	mov    %eax,%eax
 c88:	48 c1 e0 04          	shl    $0x4,%rax
 c8c:	48 89 c2             	mov    %rax,%rdx
 c8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c93:	48 01 c2             	add    %rax,%rdx
 c96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9a:	48 8b 00             	mov    (%rax),%rax
 c9d:	48 39 c2             	cmp    %rax,%rdx
 ca0:	75 2d                	jne    ccf <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 ca2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ca6:	8b 50 08             	mov    0x8(%rax),%edx
 ca9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cad:	48 8b 00             	mov    (%rax),%rax
 cb0:	8b 40 08             	mov    0x8(%rax),%eax
 cb3:	01 c2                	add    %eax,%edx
 cb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cb9:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc0:	48 8b 00             	mov    (%rax),%rax
 cc3:	48 8b 10             	mov    (%rax),%rdx
 cc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cca:	48 89 10             	mov    %rdx,(%rax)
 ccd:	eb 0e                	jmp    cdd <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 ccf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd3:	48 8b 10             	mov    (%rax),%rdx
 cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cda:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce1:	8b 40 08             	mov    0x8(%rax),%eax
 ce4:	89 c0                	mov    %eax,%eax
 ce6:	48 c1 e0 04          	shl    $0x4,%rax
 cea:	48 89 c2             	mov    %rax,%rdx
 ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf1:	48 01 d0             	add    %rdx,%rax
 cf4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 cf8:	75 27                	jne    d21 <free+0x111>
    p->s.size += bp->s.size;
 cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfe:	8b 50 08             	mov    0x8(%rax),%edx
 d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d05:	8b 40 08             	mov    0x8(%rax),%eax
 d08:	01 c2                	add    %eax,%edx
 d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 d11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d15:	48 8b 10             	mov    (%rax),%rdx
 d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d1c:	48 89 10             	mov    %rdx,(%rax)
 d1f:	eb 0b                	jmp    d2c <free+0x11c>
  } else
    p->s.ptr = bp;
 d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d25:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d29:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d30:	48 89 05 a9 09 00 00 	mov    %rax,0x9a9(%rip)        # 16e0 <freep>
}
 d37:	90                   	nop
 d38:	c9                   	leave
 d39:	c3                   	ret

0000000000000d3a <morecore>:

static Header*
morecore(uint nu)
{
 d3a:	f3 0f 1e fa          	endbr64
 d3e:	55                   	push   %rbp
 d3f:	48 89 e5             	mov    %rsp,%rbp
 d42:	48 83 ec 20          	sub    $0x20,%rsp
 d46:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d49:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d50:	77 07                	ja     d59 <morecore+0x1f>
    nu = 4096;
 d52:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d59:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d5c:	c1 e0 04             	shl    $0x4,%eax
 d5f:	89 c7                	mov    %eax,%edi
 d61:	e8 0c fa ff ff       	call   772 <sbrk>
 d66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d6a:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d6f:	75 07                	jne    d78 <morecore+0x3e>
    return 0;
 d71:	b8 00 00 00 00       	mov    $0x0,%eax
 d76:	eb 29                	jmp    da1 <morecore+0x67>
  hp = (Header*)p;
 d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d7c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d84:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d87:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d8e:	48 83 c0 10          	add    $0x10,%rax
 d92:	48 89 c7             	mov    %rax,%rdi
 d95:	e8 76 fe ff ff       	call   c10 <free>
  return freep;
 d9a:	48 8b 05 3f 09 00 00 	mov    0x93f(%rip),%rax        # 16e0 <freep>
}
 da1:	c9                   	leave
 da2:	c3                   	ret

0000000000000da3 <malloc>:

void*
malloc(uint nbytes)
{
 da3:	f3 0f 1e fa          	endbr64
 da7:	55                   	push   %rbp
 da8:	48 89 e5             	mov    %rsp,%rbp
 dab:	48 83 ec 30          	sub    $0x30,%rsp
 daf:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 db2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 db5:	48 83 c0 0f          	add    $0xf,%rax
 db9:	48 c1 e8 04          	shr    $0x4,%rax
 dbd:	83 c0 01             	add    $0x1,%eax
 dc0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 dc3:	48 8b 05 16 09 00 00 	mov    0x916(%rip),%rax        # 16e0 <freep>
 dca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 dce:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 dd3:	75 2b                	jne    e00 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 dd5:	48 c7 45 f0 d0 16 00 	movq   $0x16d0,-0x10(%rbp)
 ddc:	00 
 ddd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 de1:	48 89 05 f8 08 00 00 	mov    %rax,0x8f8(%rip)        # 16e0 <freep>
 de8:	48 8b 05 f1 08 00 00 	mov    0x8f1(%rip),%rax        # 16e0 <freep>
 def:	48 89 05 da 08 00 00 	mov    %rax,0x8da(%rip)        # 16d0 <base>
    base.s.size = 0;
 df6:	c7 05 d8 08 00 00 00 	movl   $0x0,0x8d8(%rip)        # 16d8 <base+0x8>
 dfd:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e04:	48 8b 00             	mov    (%rax),%rax
 e07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0f:	8b 40 08             	mov    0x8(%rax),%eax
 e12:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 e15:	72 5f                	jb     e76 <malloc+0xd3>
      if(p->s.size == nunits)
 e17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1b:	8b 40 08             	mov    0x8(%rax),%eax
 e1e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 e21:	75 10                	jne    e33 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e27:	48 8b 10             	mov    (%rax),%rdx
 e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e2e:	48 89 10             	mov    %rdx,(%rax)
 e31:	eb 2e                	jmp    e61 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e37:	8b 40 08             	mov    0x8(%rax),%eax
 e3a:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e3d:	89 c2                	mov    %eax,%edx
 e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e43:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e4a:	8b 40 08             	mov    0x8(%rax),%eax
 e4d:	89 c0                	mov    %eax,%eax
 e4f:	48 c1 e0 04          	shl    $0x4,%rax
 e53:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e5b:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e5e:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e65:	48 89 05 74 08 00 00 	mov    %rax,0x874(%rip)        # 16e0 <freep>
      return (void*)(p + 1);
 e6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e70:	48 83 c0 10          	add    $0x10,%rax
 e74:	eb 41                	jmp    eb7 <malloc+0x114>
    }
    if(p == freep)
 e76:	48 8b 05 63 08 00 00 	mov    0x863(%rip),%rax        # 16e0 <freep>
 e7d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e81:	75 1c                	jne    e9f <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e83:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e86:	89 c7                	mov    %eax,%edi
 e88:	e8 ad fe ff ff       	call   d3a <morecore>
 e8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e91:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e96:	75 07                	jne    e9f <malloc+0xfc>
        return 0;
 e98:	b8 00 00 00 00       	mov    $0x0,%eax
 e9d:	eb 18                	jmp    eb7 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ea3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 eab:	48 8b 00             	mov    (%rax),%rax
 eae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 eb2:	e9 54 ff ff ff       	jmp    e0b <malloc+0x68>
  }
}
 eb7:	c9                   	leave
 eb8:	c3                   	ret
