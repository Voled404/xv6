
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
  a0:	48 c7 c6 c8 0e 00 00 	mov    $0xec8,%rsi
  a7:	bf 01 00 00 00       	mov    $0x1,%edi
  ac:	b8 00 00 00 00       	mov    $0x0,%eax
  b1:	e8 f6 07 00 00       	call   8ac <printf>
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
  fb:	48 c7 c6 ec 0e 00 00 	mov    $0xeec,%rsi
 102:	bf 01 00 00 00       	mov    $0x1,%edi
 107:	b8 00 00 00 00       	mov    $0x0,%eax
 10c:	e8 9b 07 00 00       	call   8ac <printf>
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
 1c5:	48 c7 c6 01 0f 00 00 	mov    $0xf01,%rsi
 1cc:	bf 01 00 00 00       	mov    $0x1,%edi
 1d1:	b8 00 00 00 00       	mov    $0x0,%eax
 1d6:	e8 d1 06 00 00       	call   8ac <printf>
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
 220:	48 c7 c6 1d 0f 00 00 	mov    $0xf1d,%rsi
 227:	bf 01 00 00 00       	mov    $0x1,%edi
 22c:	b8 00 00 00 00       	mov    $0x0,%eax
 231:	e8 76 06 00 00       	call   8ac <printf>

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
 2f7:	48 c7 c6 30 0f 00 00 	mov    $0xf30,%rsi
 2fe:	bf 01 00 00 00       	mov    $0x1,%edi
 303:	b8 00 00 00 00       	mov    $0x0,%eax
 308:	e8 9f 05 00 00       	call   8ac <printf>
 30d:	48 83 c4 10          	add    $0x10,%rsp
    for (int i = 0; i < N; i++) {
 311:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 315:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
 319:	0f 8e 23 ff ff ff    	jle    242 <print_info+0xf3>
               children[i], tickets[i], ticks[i], cpu1, cpu2);
    }
    printf(1, "\n");
 31f:	48 c7 c6 5c 0f 00 00 	mov    $0xf5c,%rsi
 326:	bf 01 00 00 00       	mov    $0x1,%edi
 32b:	b8 00 00 00 00       	mov    $0x0,%eax
 330:	e8 77 05 00 00       	call   8ac <printf>
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
 364:	48 c7 c6 5e 0f 00 00 	mov    $0xf5e,%rsi
 36b:	bf 01 00 00 00       	mov    $0x1,%edi
 370:	b8 00 00 00 00       	mov    $0x0,%eax
 375:	e8 32 05 00 00       	call   8ac <printf>

    sleep(3000);
 37a:	bf b8 0b 00 00       	mov    $0xbb8,%edi
 37f:	e8 f6 03 00 00       	call   77a <sleep>

    if (getpinfo(&pstat) == -1) {
 384:	48 c7 c7 c0 12 00 00 	mov    $0x12c0,%rdi
 38b:	e8 fa 03 00 00       	call   78a <getpinfo>
 390:	83 f8 ff             	cmp    $0xffffffff,%eax
 393:	75 25                	jne    3ba <main+0x82>
        printf(1, "\nFailed to get pinfo\n");
 395:	48 c7 c6 74 0f 00 00 	mov    $0xf74,%rsi
 39c:	bf 01 00 00 00       	mov    $0x1,%edi
 3a1:	b8 00 00 00 00       	mov    $0x0,%eax
 3a6:	e8 01 05 00 00       	call   8ac <printf>
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

00000000000007b2 <killrandom>:
SYSCALL(killrandom)
 7b2:	b8 1f 00 00 00       	mov    $0x1f,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret

00000000000007ba <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7ba:	f3 0f 1e fa          	endbr64
 7be:	55                   	push   %rbp
 7bf:	48 89 e5             	mov    %rsp,%rbp
 7c2:	48 83 ec 10          	sub    $0x10,%rsp
 7c6:	89 7d fc             	mov    %edi,-0x4(%rbp)
 7c9:	89 f0                	mov    %esi,%eax
 7cb:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7ce:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7d5:	ba 01 00 00 00       	mov    $0x1,%edx
 7da:	48 89 ce             	mov    %rcx,%rsi
 7dd:	89 c7                	mov    %eax,%edi
 7df:	e8 26 ff ff ff       	call   70a <write>
}
 7e4:	90                   	nop
 7e5:	c9                   	leave
 7e6:	c3                   	ret

00000000000007e7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7e7:	f3 0f 1e fa          	endbr64
 7eb:	55                   	push   %rbp
 7ec:	48 89 e5             	mov    %rsp,%rbp
 7ef:	48 83 ec 30          	sub    $0x30,%rsp
 7f3:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7f6:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7f9:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7fc:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 806:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 80a:	74 17                	je     823 <printint+0x3c>
 80c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 810:	79 11                	jns    823 <printint+0x3c>
    neg = 1;
 812:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 819:	8b 45 d8             	mov    -0x28(%rbp),%eax
 81c:	f7 d8                	neg    %eax
 81e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 821:	eb 06                	jmp    829 <printint+0x42>
  } else {
    x = xx;
 823:	8b 45 d8             	mov    -0x28(%rbp),%eax
 826:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 829:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 830:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 833:	8b 45 f4             	mov    -0xc(%rbp),%eax
 836:	ba 00 00 00 00       	mov    $0x0,%edx
 83b:	f7 f6                	div    %esi
 83d:	89 d1                	mov    %edx,%ecx
 83f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 842:	8d 50 01             	lea    0x1(%rax),%edx
 845:	89 55 fc             	mov    %edx,-0x4(%rbp)
 848:	89 ca                	mov    %ecx,%edx
 84a:	0f b6 92 70 12 00 00 	movzbl 0x1270(%rdx),%edx
 851:	48 98                	cltq
 853:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 857:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 85a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 85d:	ba 00 00 00 00       	mov    $0x0,%edx
 862:	f7 f7                	div    %edi
 864:	89 45 f4             	mov    %eax,-0xc(%rbp)
 867:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 86b:	75 c3                	jne    830 <printint+0x49>
  if(neg)
 86d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 871:	74 2b                	je     89e <printint+0xb7>
    buf[i++] = '-';
 873:	8b 45 fc             	mov    -0x4(%rbp),%eax
 876:	8d 50 01             	lea    0x1(%rax),%edx
 879:	89 55 fc             	mov    %edx,-0x4(%rbp)
 87c:	48 98                	cltq
 87e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 883:	eb 19                	jmp    89e <printint+0xb7>
    putc(fd, buf[i]);
 885:	8b 45 fc             	mov    -0x4(%rbp),%eax
 888:	48 98                	cltq
 88a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 88f:	0f be d0             	movsbl %al,%edx
 892:	8b 45 dc             	mov    -0x24(%rbp),%eax
 895:	89 d6                	mov    %edx,%esi
 897:	89 c7                	mov    %eax,%edi
 899:	e8 1c ff ff ff       	call   7ba <putc>
  while(--i >= 0)
 89e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 8a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 8a6:	79 dd                	jns    885 <printint+0x9e>
}
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	c9                   	leave
 8ab:	c3                   	ret

00000000000008ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8ac:	f3 0f 1e fa          	endbr64
 8b0:	55                   	push   %rbp
 8b1:	48 89 e5             	mov    %rsp,%rbp
 8b4:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 8bb:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 8c1:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 8c8:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8cf:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8d6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8dd:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8e4:	84 c0                	test   %al,%al
 8e6:	74 20                	je     908 <printf+0x5c>
 8e8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8ec:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8f0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8f4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8f8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8fc:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 900:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 904:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 908:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 90f:	00 00 00 
 912:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 919:	00 00 00 
 91c:	48 8d 45 10          	lea    0x10(%rbp),%rax
 920:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 927:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 92e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 935:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 93c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 93f:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 946:	00 00 00 
 949:	e9 a8 02 00 00       	jmp    bf6 <printf+0x34a>
    c = fmt[i] & 0xff;
 94e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 954:	48 63 d0             	movslq %eax,%rdx
 957:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 95e:	48 01 d0             	add    %rdx,%rax
 961:	0f b6 00             	movzbl (%rax),%eax
 964:	0f be c0             	movsbl %al,%eax
 967:	25 ff 00 00 00       	and    $0xff,%eax
 96c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 972:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 979:	75 35                	jne    9b0 <printf+0x104>
      if(c == '%'){
 97b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 982:	75 0f                	jne    993 <printf+0xe7>
        state = '%';
 984:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 98b:	00 00 00 
 98e:	e9 5c 02 00 00       	jmp    bef <printf+0x343>
      } else {
        putc(fd, c);
 993:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 999:	0f be d0             	movsbl %al,%edx
 99c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9a2:	89 d6                	mov    %edx,%esi
 9a4:	89 c7                	mov    %eax,%edi
 9a6:	e8 0f fe ff ff       	call   7ba <putc>
 9ab:	e9 3f 02 00 00       	jmp    bef <printf+0x343>
      }
    } else if(state == '%'){
 9b0:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 9b7:	0f 85 32 02 00 00    	jne    bef <printf+0x343>
      if(c == 'd'){
 9bd:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 9c4:	75 5e                	jne    a24 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 9c6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9cc:	83 f8 2f             	cmp    $0x2f,%eax
 9cf:	77 23                	ja     9f4 <printf+0x148>
 9d1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9d8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9de:	89 d2                	mov    %edx,%edx
 9e0:	48 01 d0             	add    %rdx,%rax
 9e3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9e9:	83 c2 08             	add    $0x8,%edx
 9ec:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9f2:	eb 12                	jmp    a06 <printf+0x15a>
 9f4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9fb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9ff:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a06:	8b 30                	mov    (%rax),%esi
 a08:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a0e:	b9 01 00 00 00       	mov    $0x1,%ecx
 a13:	ba 0a 00 00 00       	mov    $0xa,%edx
 a18:	89 c7                	mov    %eax,%edi
 a1a:	e8 c8 fd ff ff       	call   7e7 <printint>
 a1f:	e9 c1 01 00 00       	jmp    be5 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 a24:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a2b:	74 09                	je     a36 <printf+0x18a>
 a2d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a34:	75 5e                	jne    a94 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a36:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a3c:	83 f8 2f             	cmp    $0x2f,%eax
 a3f:	77 23                	ja     a64 <printf+0x1b8>
 a41:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a48:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a4e:	89 d2                	mov    %edx,%edx
 a50:	48 01 d0             	add    %rdx,%rax
 a53:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a59:	83 c2 08             	add    $0x8,%edx
 a5c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a62:	eb 12                	jmp    a76 <printf+0x1ca>
 a64:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a6b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a6f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a76:	8b 30                	mov    (%rax),%esi
 a78:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a7e:	b9 00 00 00 00       	mov    $0x0,%ecx
 a83:	ba 10 00 00 00       	mov    $0x10,%edx
 a88:	89 c7                	mov    %eax,%edi
 a8a:	e8 58 fd ff ff       	call   7e7 <printint>
 a8f:	e9 51 01 00 00       	jmp    be5 <printf+0x339>
      } else if(c == 's'){
 a94:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a9b:	0f 85 98 00 00 00    	jne    b39 <printf+0x28d>
        s = va_arg(ap, char*);
 aa1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 aa7:	83 f8 2f             	cmp    $0x2f,%eax
 aaa:	77 23                	ja     acf <printf+0x223>
 aac:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 ab3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ab9:	89 d2                	mov    %edx,%edx
 abb:	48 01 d0             	add    %rdx,%rax
 abe:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ac4:	83 c2 08             	add    $0x8,%edx
 ac7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 acd:	eb 12                	jmp    ae1 <printf+0x235>
 acf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 ad6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 ada:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ae1:	48 8b 00             	mov    (%rax),%rax
 ae4:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 aeb:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 af2:	00 
 af3:	75 31                	jne    b26 <printf+0x27a>
          s = "(null)";
 af5:	48 c7 85 48 ff ff ff 	movq   $0xf8a,-0xb8(%rbp)
 afc:	8a 0f 00 00 
        while(*s != 0){
 b00:	eb 24                	jmp    b26 <printf+0x27a>
          putc(fd, *s);
 b02:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b09:	0f b6 00             	movzbl (%rax),%eax
 b0c:	0f be d0             	movsbl %al,%edx
 b0f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b15:	89 d6                	mov    %edx,%esi
 b17:	89 c7                	mov    %eax,%edi
 b19:	e8 9c fc ff ff       	call   7ba <putc>
          s++;
 b1e:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 b25:	01 
        while(*s != 0){
 b26:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b2d:	0f b6 00             	movzbl (%rax),%eax
 b30:	84 c0                	test   %al,%al
 b32:	75 ce                	jne    b02 <printf+0x256>
 b34:	e9 ac 00 00 00       	jmp    be5 <printf+0x339>
        }
      } else if(c == 'c'){
 b39:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b40:	75 56                	jne    b98 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b42:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b48:	83 f8 2f             	cmp    $0x2f,%eax
 b4b:	77 23                	ja     b70 <printf+0x2c4>
 b4d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b54:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b5a:	89 d2                	mov    %edx,%edx
 b5c:	48 01 d0             	add    %rdx,%rax
 b5f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b65:	83 c2 08             	add    $0x8,%edx
 b68:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b6e:	eb 12                	jmp    b82 <printf+0x2d6>
 b70:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b77:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b7b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b82:	8b 00                	mov    (%rax),%eax
 b84:	0f be d0             	movsbl %al,%edx
 b87:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b8d:	89 d6                	mov    %edx,%esi
 b8f:	89 c7                	mov    %eax,%edi
 b91:	e8 24 fc ff ff       	call   7ba <putc>
 b96:	eb 4d                	jmp    be5 <printf+0x339>
      } else if(c == '%'){
 b98:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b9f:	75 1a                	jne    bbb <printf+0x30f>
        putc(fd, c);
 ba1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 ba7:	0f be d0             	movsbl %al,%edx
 baa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bb0:	89 d6                	mov    %edx,%esi
 bb2:	89 c7                	mov    %eax,%edi
 bb4:	e8 01 fc ff ff       	call   7ba <putc>
 bb9:	eb 2a                	jmp    be5 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bbb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bc1:	be 25 00 00 00       	mov    $0x25,%esi
 bc6:	89 c7                	mov    %eax,%edi
 bc8:	e8 ed fb ff ff       	call   7ba <putc>
        putc(fd, c);
 bcd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 bd3:	0f be d0             	movsbl %al,%edx
 bd6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bdc:	89 d6                	mov    %edx,%esi
 bde:	89 c7                	mov    %eax,%edi
 be0:	e8 d5 fb ff ff       	call   7ba <putc>
      }
      state = 0;
 be5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bec:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bef:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bf6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bfc:	48 63 d0             	movslq %eax,%rdx
 bff:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 c06:	48 01 d0             	add    %rdx,%rax
 c09:	0f b6 00             	movzbl (%rax),%eax
 c0c:	84 c0                	test   %al,%al
 c0e:	0f 85 3a fd ff ff    	jne    94e <printf+0xa2>
    }
  }
}
 c14:	90                   	nop
 c15:	90                   	nop
 c16:	c9                   	leave
 c17:	c3                   	ret

0000000000000c18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c18:	f3 0f 1e fa          	endbr64
 c1c:	55                   	push   %rbp
 c1d:	48 89 e5             	mov    %rsp,%rbp
 c20:	48 83 ec 18          	sub    $0x18,%rsp
 c24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c2c:	48 83 e8 10          	sub    $0x10,%rax
 c30:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c34:	48 8b 05 a5 0a 00 00 	mov    0xaa5(%rip),%rax        # 16e0 <freep>
 c3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c3f:	eb 2f                	jmp    c70 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c45:	48 8b 00             	mov    (%rax),%rax
 c48:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c4c:	72 17                	jb     c65 <free+0x4d>
 c4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c52:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c56:	72 2f                	jb     c87 <free+0x6f>
 c58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5c:	48 8b 00             	mov    (%rax),%rax
 c5f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c63:	72 22                	jb     c87 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c69:	48 8b 00             	mov    (%rax),%rax
 c6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c74:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c78:	73 c7                	jae    c41 <free+0x29>
 c7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c7e:	48 8b 00             	mov    (%rax),%rax
 c81:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c85:	73 ba                	jae    c41 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c8b:	8b 40 08             	mov    0x8(%rax),%eax
 c8e:	89 c0                	mov    %eax,%eax
 c90:	48 c1 e0 04          	shl    $0x4,%rax
 c94:	48 89 c2             	mov    %rax,%rdx
 c97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9b:	48 01 c2             	add    %rax,%rdx
 c9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca2:	48 8b 00             	mov    (%rax),%rax
 ca5:	48 39 c2             	cmp    %rax,%rdx
 ca8:	75 2d                	jne    cd7 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cae:	8b 50 08             	mov    0x8(%rax),%edx
 cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb5:	48 8b 00             	mov    (%rax),%rax
 cb8:	8b 40 08             	mov    0x8(%rax),%eax
 cbb:	01 c2                	add    %eax,%edx
 cbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cc1:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 cc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc8:	48 8b 00             	mov    (%rax),%rax
 ccb:	48 8b 10             	mov    (%rax),%rdx
 cce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cd2:	48 89 10             	mov    %rdx,(%rax)
 cd5:	eb 0e                	jmp    ce5 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 cd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cdb:	48 8b 10             	mov    (%rax),%rdx
 cde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce2:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 ce5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce9:	8b 40 08             	mov    0x8(%rax),%eax
 cec:	89 c0                	mov    %eax,%eax
 cee:	48 c1 e0 04          	shl    $0x4,%rax
 cf2:	48 89 c2             	mov    %rax,%rdx
 cf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf9:	48 01 d0             	add    %rdx,%rax
 cfc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 d00:	75 27                	jne    d29 <free+0x111>
    p->s.size += bp->s.size;
 d02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d06:	8b 50 08             	mov    0x8(%rax),%edx
 d09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d0d:	8b 40 08             	mov    0x8(%rax),%eax
 d10:	01 c2                	add    %eax,%edx
 d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d16:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 d19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d1d:	48 8b 10             	mov    (%rax),%rdx
 d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d24:	48 89 10             	mov    %rdx,(%rax)
 d27:	eb 0b                	jmp    d34 <free+0x11c>
  } else
    p->s.ptr = bp;
 d29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d2d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d31:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d38:	48 89 05 a1 09 00 00 	mov    %rax,0x9a1(%rip)        # 16e0 <freep>
}
 d3f:	90                   	nop
 d40:	c9                   	leave
 d41:	c3                   	ret

0000000000000d42 <morecore>:

static Header*
morecore(uint nu)
{
 d42:	f3 0f 1e fa          	endbr64
 d46:	55                   	push   %rbp
 d47:	48 89 e5             	mov    %rsp,%rbp
 d4a:	48 83 ec 20          	sub    $0x20,%rsp
 d4e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d51:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d58:	77 07                	ja     d61 <morecore+0x1f>
    nu = 4096;
 d5a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d61:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d64:	c1 e0 04             	shl    $0x4,%eax
 d67:	89 c7                	mov    %eax,%edi
 d69:	e8 04 fa ff ff       	call   772 <sbrk>
 d6e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d72:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d77:	75 07                	jne    d80 <morecore+0x3e>
    return 0;
 d79:	b8 00 00 00 00       	mov    $0x0,%eax
 d7e:	eb 29                	jmp    da9 <morecore+0x67>
  hp = (Header*)p;
 d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d84:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d8c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d8f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d96:	48 83 c0 10          	add    $0x10,%rax
 d9a:	48 89 c7             	mov    %rax,%rdi
 d9d:	e8 76 fe ff ff       	call   c18 <free>
  return freep;
 da2:	48 8b 05 37 09 00 00 	mov    0x937(%rip),%rax        # 16e0 <freep>
}
 da9:	c9                   	leave
 daa:	c3                   	ret

0000000000000dab <malloc>:

void*
malloc(uint nbytes)
{
 dab:	f3 0f 1e fa          	endbr64
 daf:	55                   	push   %rbp
 db0:	48 89 e5             	mov    %rsp,%rbp
 db3:	48 83 ec 30          	sub    $0x30,%rsp
 db7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dba:	8b 45 dc             	mov    -0x24(%rbp),%eax
 dbd:	48 83 c0 0f          	add    $0xf,%rax
 dc1:	48 c1 e8 04          	shr    $0x4,%rax
 dc5:	83 c0 01             	add    $0x1,%eax
 dc8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 dcb:	48 8b 05 0e 09 00 00 	mov    0x90e(%rip),%rax        # 16e0 <freep>
 dd2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 dd6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 ddb:	75 2b                	jne    e08 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 ddd:	48 c7 45 f0 d0 16 00 	movq   $0x16d0,-0x10(%rbp)
 de4:	00 
 de5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 de9:	48 89 05 f0 08 00 00 	mov    %rax,0x8f0(%rip)        # 16e0 <freep>
 df0:	48 8b 05 e9 08 00 00 	mov    0x8e9(%rip),%rax        # 16e0 <freep>
 df7:	48 89 05 d2 08 00 00 	mov    %rax,0x8d2(%rip)        # 16d0 <base>
    base.s.size = 0;
 dfe:	c7 05 d0 08 00 00 00 	movl   $0x0,0x8d0(%rip)        # 16d8 <base+0x8>
 e05:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e0c:	48 8b 00             	mov    (%rax),%rax
 e0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e17:	8b 40 08             	mov    0x8(%rax),%eax
 e1a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 e1d:	72 5f                	jb     e7e <malloc+0xd3>
      if(p->s.size == nunits)
 e1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e23:	8b 40 08             	mov    0x8(%rax),%eax
 e26:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 e29:	75 10                	jne    e3b <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2f:	48 8b 10             	mov    (%rax),%rdx
 e32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e36:	48 89 10             	mov    %rdx,(%rax)
 e39:	eb 2e                	jmp    e69 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e3f:	8b 40 08             	mov    0x8(%rax),%eax
 e42:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e45:	89 c2                	mov    %eax,%edx
 e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e4b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e52:	8b 40 08             	mov    0x8(%rax),%eax
 e55:	89 c0                	mov    %eax,%eax
 e57:	48 c1 e0 04          	shl    $0x4,%rax
 e5b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e63:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e66:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e6d:	48 89 05 6c 08 00 00 	mov    %rax,0x86c(%rip)        # 16e0 <freep>
      return (void*)(p + 1);
 e74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e78:	48 83 c0 10          	add    $0x10,%rax
 e7c:	eb 41                	jmp    ebf <malloc+0x114>
    }
    if(p == freep)
 e7e:	48 8b 05 5b 08 00 00 	mov    0x85b(%rip),%rax        # 16e0 <freep>
 e85:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e89:	75 1c                	jne    ea7 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e8b:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e8e:	89 c7                	mov    %eax,%edi
 e90:	e8 ad fe ff ff       	call   d42 <morecore>
 e95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e99:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e9e:	75 07                	jne    ea7 <malloc+0xfc>
        return 0;
 ea0:	b8 00 00 00 00       	mov    $0x0,%eax
 ea5:	eb 18                	jmp    ebf <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 eab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 eaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 eb3:	48 8b 00             	mov    (%rax),%rax
 eb6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 eba:	e9 54 ff ff ff       	jmp    e13 <malloc+0x68>
  }
}
 ebf:	c9                   	leave
 ec0:	c3                   	ret
