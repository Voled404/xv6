
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
  73:	8b 04 85 30 12 00 00 	mov    0x1230(,%rax,4),%eax
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
  97:	89 14 85 80 12 00 00 	mov    %edx,0x1280(,%rax,4)
  9e:	eb 48                	jmp    e8 <fork_children+0xa0>
        } else {
            printf(1, "\nFailed to fork children processes\n");
  a0:	48 c7 c6 a8 0e 00 00 	mov    $0xea8,%rsi
  a7:	bf 01 00 00 00       	mov    $0x1,%edi
  ac:	b8 00 00 00 00       	mov    $0x0,%eax
  b1:	e8 d6 07 00 00       	call   88c <printf>
            for (int j = 0; j < i; j++) {
  b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  bd:	eb 1c                	jmp    db <fork_children+0x93>
                kill(children[j]);
  bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  c2:	48 98                	cltq
  c4:	8b 04 85 80 12 00 00 	mov    0x1280(,%rax,4),%eax
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
  fb:	48 c7 c6 cc 0e 00 00 	mov    $0xecc,%rsi
 102:	bf 01 00 00 00       	mov    $0x1,%edi
 107:	b8 00 00 00 00       	mov    $0x0,%eax
 10c:	e8 7b 07 00 00       	call   88c <printf>
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
 12e:	8b 04 85 80 12 00 00 	mov    0x1280(,%rax,4),%eax
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
 198:	8b 04 85 80 12 00 00 	mov    0x1280(,%rax,4),%eax
 19f:	89 c6                	mov    %eax,%esi
 1a1:	48 c7 c7 a0 12 00 00 	mov    $0x12a0,%rdi
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
 1c5:	48 c7 c6 e1 0e 00 00 	mov    $0xee1,%rsi
 1cc:	bf 01 00 00 00       	mov    $0x1,%edi
 1d1:	b8 00 00 00 00       	mov    $0x0,%eax
 1d6:	e8 b1 06 00 00       	call   88c <printf>
            exit();
 1db:	e8 0a 05 00 00       	call   6ea <exit>
        }

        ticks[i] = pstat.ticks[index[i]];
 1e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1e3:	48 98                	cltq
 1e5:	8b 44 85 d0          	mov    -0x30(%rbp,%rax,4),%eax
 1e9:	48 98                	cltq
 1eb:	48 05 c0 00 00 00    	add    $0xc0,%rax
 1f1:	8b 14 85 a0 12 00 00 	mov    0x12a0(,%rax,4),%edx
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
 220:	48 c7 c6 fd 0e 00 00 	mov    $0xefd,%rsi
 227:	bf 01 00 00 00       	mov    $0x1,%edi
 22c:	b8 00 00 00 00       	mov    $0x0,%eax
 231:	e8 56 06 00 00       	call   88c <printf>

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
 2cf:	8b 14 85 30 12 00 00 	mov    0x1230(,%rax,4),%edx
 2d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
 2d9:	48 98                	cltq
 2db:	8b 04 85 80 12 00 00 	mov    0x1280(,%rax,4),%eax
 2e2:	8b 7d f0             	mov    -0x10(%rbp),%edi
 2e5:	48 83 ec 08          	sub    $0x8,%rsp
 2e9:	8b 4d ec             	mov    -0x14(%rbp),%ecx
 2ec:	51                   	push   %rcx
 2ed:	41 89 f9             	mov    %edi,%r9d
 2f0:	41 89 f0             	mov    %esi,%r8d
 2f3:	89 d1                	mov    %edx,%ecx
 2f5:	89 c2                	mov    %eax,%edx
 2f7:	48 c7 c6 10 0f 00 00 	mov    $0xf10,%rsi
 2fe:	bf 01 00 00 00       	mov    $0x1,%edi
 303:	b8 00 00 00 00       	mov    $0x0,%eax
 308:	e8 7f 05 00 00       	call   88c <printf>
 30d:	48 83 c4 10          	add    $0x10,%rsp
    for (int i = 0; i < N; i++) {
 311:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 315:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
 319:	0f 8e 23 ff ff ff    	jle    242 <print_info+0xf3>
               children[i], tickets[i], ticks[i], cpu1, cpu2);
    }
    printf(1, "\n");
 31f:	48 c7 c6 3c 0f 00 00 	mov    $0xf3c,%rsi
 326:	bf 01 00 00 00       	mov    $0x1,%edi
 32b:	b8 00 00 00 00       	mov    $0x0,%eax
 330:	e8 57 05 00 00       	call   88c <printf>
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
 364:	48 c7 c6 3e 0f 00 00 	mov    $0xf3e,%rsi
 36b:	bf 01 00 00 00       	mov    $0x1,%edi
 370:	b8 00 00 00 00       	mov    $0x0,%eax
 375:	e8 12 05 00 00       	call   88c <printf>

    sleep(3000);
 37a:	bf b8 0b 00 00       	mov    $0xbb8,%edi
 37f:	e8 f6 03 00 00       	call   77a <sleep>

    if (getpinfo(&pstat) == -1) {
 384:	48 c7 c7 a0 12 00 00 	mov    $0x12a0,%rdi
 38b:	e8 fa 03 00 00       	call   78a <getpinfo>
 390:	83 f8 ff             	cmp    $0xffffffff,%eax
 393:	75 25                	jne    3ba <main+0x82>
        printf(1, "\nFailed to get pinfo\n");
 395:	48 c7 c6 54 0f 00 00 	mov    $0xf54,%rsi
 39c:	bf 01 00 00 00       	mov    $0x1,%edi
 3a1:	b8 00 00 00 00       	mov    $0x0,%eax
 3a6:	e8 e1 04 00 00       	call   88c <printf>
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

000000000000079a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 79a:	f3 0f 1e fa          	endbr64
 79e:	55                   	push   %rbp
 79f:	48 89 e5             	mov    %rsp,%rbp
 7a2:	48 83 ec 10          	sub    $0x10,%rsp
 7a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
 7a9:	89 f0                	mov    %esi,%eax
 7ab:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7ae:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7b5:	ba 01 00 00 00       	mov    $0x1,%edx
 7ba:	48 89 ce             	mov    %rcx,%rsi
 7bd:	89 c7                	mov    %eax,%edi
 7bf:	e8 46 ff ff ff       	call   70a <write>
}
 7c4:	90                   	nop
 7c5:	c9                   	leave
 7c6:	c3                   	ret

00000000000007c7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7c7:	f3 0f 1e fa          	endbr64
 7cb:	55                   	push   %rbp
 7cc:	48 89 e5             	mov    %rsp,%rbp
 7cf:	48 83 ec 30          	sub    $0x30,%rsp
 7d3:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7d6:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7d9:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7dc:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7e6:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7ea:	74 17                	je     803 <printint+0x3c>
 7ec:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7f0:	79 11                	jns    803 <printint+0x3c>
    neg = 1;
 7f2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7f9:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7fc:	f7 d8                	neg    %eax
 7fe:	89 45 f4             	mov    %eax,-0xc(%rbp)
 801:	eb 06                	jmp    809 <printint+0x42>
  } else {
    x = xx;
 803:	8b 45 d8             	mov    -0x28(%rbp),%eax
 806:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 809:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 810:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 813:	8b 45 f4             	mov    -0xc(%rbp),%eax
 816:	ba 00 00 00 00       	mov    $0x0,%edx
 81b:	f7 f6                	div    %esi
 81d:	89 d1                	mov    %edx,%ecx
 81f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 822:	8d 50 01             	lea    0x1(%rax),%edx
 825:	89 55 fc             	mov    %edx,-0x4(%rbp)
 828:	89 ca                	mov    %ecx,%edx
 82a:	0f b6 92 50 12 00 00 	movzbl 0x1250(%rdx),%edx
 831:	48 98                	cltq
 833:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 837:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 83a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 83d:	ba 00 00 00 00       	mov    $0x0,%edx
 842:	f7 f7                	div    %edi
 844:	89 45 f4             	mov    %eax,-0xc(%rbp)
 847:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 84b:	75 c3                	jne    810 <printint+0x49>
  if(neg)
 84d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 851:	74 2b                	je     87e <printint+0xb7>
    buf[i++] = '-';
 853:	8b 45 fc             	mov    -0x4(%rbp),%eax
 856:	8d 50 01             	lea    0x1(%rax),%edx
 859:	89 55 fc             	mov    %edx,-0x4(%rbp)
 85c:	48 98                	cltq
 85e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 863:	eb 19                	jmp    87e <printint+0xb7>
    putc(fd, buf[i]);
 865:	8b 45 fc             	mov    -0x4(%rbp),%eax
 868:	48 98                	cltq
 86a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 86f:	0f be d0             	movsbl %al,%edx
 872:	8b 45 dc             	mov    -0x24(%rbp),%eax
 875:	89 d6                	mov    %edx,%esi
 877:	89 c7                	mov    %eax,%edi
 879:	e8 1c ff ff ff       	call   79a <putc>
  while(--i >= 0)
 87e:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 882:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 886:	79 dd                	jns    865 <printint+0x9e>
}
 888:	90                   	nop
 889:	90                   	nop
 88a:	c9                   	leave
 88b:	c3                   	ret

000000000000088c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 88c:	f3 0f 1e fa          	endbr64
 890:	55                   	push   %rbp
 891:	48 89 e5             	mov    %rsp,%rbp
 894:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 89b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 8a1:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 8a8:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8af:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8b6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8bd:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8c4:	84 c0                	test   %al,%al
 8c6:	74 20                	je     8e8 <printf+0x5c>
 8c8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8cc:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8d0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8d4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8d8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8dc:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8e0:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8e4:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8e8:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8ef:	00 00 00 
 8f2:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 8f9:	00 00 00 
 8fc:	48 8d 45 10          	lea    0x10(%rbp),%rax
 900:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 907:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 90e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 915:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 91c:	00 00 00 
  for(i = 0; fmt[i]; i++){
 91f:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 926:	00 00 00 
 929:	e9 a8 02 00 00       	jmp    bd6 <printf+0x34a>
    c = fmt[i] & 0xff;
 92e:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 934:	48 63 d0             	movslq %eax,%rdx
 937:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 93e:	48 01 d0             	add    %rdx,%rax
 941:	0f b6 00             	movzbl (%rax),%eax
 944:	0f be c0             	movsbl %al,%eax
 947:	25 ff 00 00 00       	and    $0xff,%eax
 94c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 952:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 959:	75 35                	jne    990 <printf+0x104>
      if(c == '%'){
 95b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 962:	75 0f                	jne    973 <printf+0xe7>
        state = '%';
 964:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 96b:	00 00 00 
 96e:	e9 5c 02 00 00       	jmp    bcf <printf+0x343>
      } else {
        putc(fd, c);
 973:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 979:	0f be d0             	movsbl %al,%edx
 97c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 982:	89 d6                	mov    %edx,%esi
 984:	89 c7                	mov    %eax,%edi
 986:	e8 0f fe ff ff       	call   79a <putc>
 98b:	e9 3f 02 00 00       	jmp    bcf <printf+0x343>
      }
    } else if(state == '%'){
 990:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 997:	0f 85 32 02 00 00    	jne    bcf <printf+0x343>
      if(c == 'd'){
 99d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 9a4:	75 5e                	jne    a04 <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 9a6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9ac:	83 f8 2f             	cmp    $0x2f,%eax
 9af:	77 23                	ja     9d4 <printf+0x148>
 9b1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9be:	89 d2                	mov    %edx,%edx
 9c0:	48 01 d0             	add    %rdx,%rax
 9c3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9c9:	83 c2 08             	add    $0x8,%edx
 9cc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9d2:	eb 12                	jmp    9e6 <printf+0x15a>
 9d4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9db:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9df:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9e6:	8b 30                	mov    (%rax),%esi
 9e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9ee:	b9 01 00 00 00       	mov    $0x1,%ecx
 9f3:	ba 0a 00 00 00       	mov    $0xa,%edx
 9f8:	89 c7                	mov    %eax,%edi
 9fa:	e8 c8 fd ff ff       	call   7c7 <printint>
 9ff:	e9 c1 01 00 00       	jmp    bc5 <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 a04:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a0b:	74 09                	je     a16 <printf+0x18a>
 a0d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a14:	75 5e                	jne    a74 <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a16:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a1c:	83 f8 2f             	cmp    $0x2f,%eax
 a1f:	77 23                	ja     a44 <printf+0x1b8>
 a21:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a28:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a2e:	89 d2                	mov    %edx,%edx
 a30:	48 01 d0             	add    %rdx,%rax
 a33:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a39:	83 c2 08             	add    $0x8,%edx
 a3c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a42:	eb 12                	jmp    a56 <printf+0x1ca>
 a44:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a4b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a4f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a56:	8b 30                	mov    (%rax),%esi
 a58:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a5e:	b9 00 00 00 00       	mov    $0x0,%ecx
 a63:	ba 10 00 00 00       	mov    $0x10,%edx
 a68:	89 c7                	mov    %eax,%edi
 a6a:	e8 58 fd ff ff       	call   7c7 <printint>
 a6f:	e9 51 01 00 00       	jmp    bc5 <printf+0x339>
      } else if(c == 's'){
 a74:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a7b:	0f 85 98 00 00 00    	jne    b19 <printf+0x28d>
        s = va_arg(ap, char*);
 a81:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a87:	83 f8 2f             	cmp    $0x2f,%eax
 a8a:	77 23                	ja     aaf <printf+0x223>
 a8c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a93:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a99:	89 d2                	mov    %edx,%edx
 a9b:	48 01 d0             	add    %rdx,%rax
 a9e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 aa4:	83 c2 08             	add    $0x8,%edx
 aa7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 aad:	eb 12                	jmp    ac1 <printf+0x235>
 aaf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 ab6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 aba:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ac1:	48 8b 00             	mov    (%rax),%rax
 ac4:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 acb:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 ad2:	00 
 ad3:	75 31                	jne    b06 <printf+0x27a>
          s = "(null)";
 ad5:	48 c7 85 48 ff ff ff 	movq   $0xf6a,-0xb8(%rbp)
 adc:	6a 0f 00 00 
        while(*s != 0){
 ae0:	eb 24                	jmp    b06 <printf+0x27a>
          putc(fd, *s);
 ae2:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ae9:	0f b6 00             	movzbl (%rax),%eax
 aec:	0f be d0             	movsbl %al,%edx
 aef:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 af5:	89 d6                	mov    %edx,%esi
 af7:	89 c7                	mov    %eax,%edi
 af9:	e8 9c fc ff ff       	call   79a <putc>
          s++;
 afe:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 b05:	01 
        while(*s != 0){
 b06:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b0d:	0f b6 00             	movzbl (%rax),%eax
 b10:	84 c0                	test   %al,%al
 b12:	75 ce                	jne    ae2 <printf+0x256>
 b14:	e9 ac 00 00 00       	jmp    bc5 <printf+0x339>
        }
      } else if(c == 'c'){
 b19:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b20:	75 56                	jne    b78 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b22:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b28:	83 f8 2f             	cmp    $0x2f,%eax
 b2b:	77 23                	ja     b50 <printf+0x2c4>
 b2d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b34:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b3a:	89 d2                	mov    %edx,%edx
 b3c:	48 01 d0             	add    %rdx,%rax
 b3f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b45:	83 c2 08             	add    $0x8,%edx
 b48:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b4e:	eb 12                	jmp    b62 <printf+0x2d6>
 b50:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b57:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b5b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b62:	8b 00                	mov    (%rax),%eax
 b64:	0f be d0             	movsbl %al,%edx
 b67:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b6d:	89 d6                	mov    %edx,%esi
 b6f:	89 c7                	mov    %eax,%edi
 b71:	e8 24 fc ff ff       	call   79a <putc>
 b76:	eb 4d                	jmp    bc5 <printf+0x339>
      } else if(c == '%'){
 b78:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b7f:	75 1a                	jne    b9b <printf+0x30f>
        putc(fd, c);
 b81:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b87:	0f be d0             	movsbl %al,%edx
 b8a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b90:	89 d6                	mov    %edx,%esi
 b92:	89 c7                	mov    %eax,%edi
 b94:	e8 01 fc ff ff       	call   79a <putc>
 b99:	eb 2a                	jmp    bc5 <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b9b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ba1:	be 25 00 00 00       	mov    $0x25,%esi
 ba6:	89 c7                	mov    %eax,%edi
 ba8:	e8 ed fb ff ff       	call   79a <putc>
        putc(fd, c);
 bad:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 bb3:	0f be d0             	movsbl %al,%edx
 bb6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bbc:	89 d6                	mov    %edx,%esi
 bbe:	89 c7                	mov    %eax,%edi
 bc0:	e8 d5 fb ff ff       	call   79a <putc>
      }
      state = 0;
 bc5:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bcc:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bcf:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bd6:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 bdc:	48 63 d0             	movslq %eax,%rdx
 bdf:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 be6:	48 01 d0             	add    %rdx,%rax
 be9:	0f b6 00             	movzbl (%rax),%eax
 bec:	84 c0                	test   %al,%al
 bee:	0f 85 3a fd ff ff    	jne    92e <printf+0xa2>
    }
  }
}
 bf4:	90                   	nop
 bf5:	90                   	nop
 bf6:	c9                   	leave
 bf7:	c3                   	ret

0000000000000bf8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bf8:	f3 0f 1e fa          	endbr64
 bfc:	55                   	push   %rbp
 bfd:	48 89 e5             	mov    %rsp,%rbp
 c00:	48 83 ec 18          	sub    $0x18,%rsp
 c04:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c0c:	48 83 e8 10          	sub    $0x10,%rax
 c10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c14:	48 8b 05 a5 0a 00 00 	mov    0xaa5(%rip),%rax        # 16c0 <freep>
 c1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c1f:	eb 2f                	jmp    c50 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c25:	48 8b 00             	mov    (%rax),%rax
 c28:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c2c:	72 17                	jb     c45 <free+0x4d>
 c2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c32:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c36:	72 2f                	jb     c67 <free+0x6f>
 c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3c:	48 8b 00             	mov    (%rax),%rax
 c3f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c43:	72 22                	jb     c67 <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c49:	48 8b 00             	mov    (%rax),%rax
 c4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c54:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c58:	73 c7                	jae    c21 <free+0x29>
 c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5e:	48 8b 00             	mov    (%rax),%rax
 c61:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c65:	73 ba                	jae    c21 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c6b:	8b 40 08             	mov    0x8(%rax),%eax
 c6e:	89 c0                	mov    %eax,%eax
 c70:	48 c1 e0 04          	shl    $0x4,%rax
 c74:	48 89 c2             	mov    %rax,%rdx
 c77:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c7b:	48 01 c2             	add    %rax,%rdx
 c7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c82:	48 8b 00             	mov    (%rax),%rax
 c85:	48 39 c2             	cmp    %rax,%rdx
 c88:	75 2d                	jne    cb7 <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c8e:	8b 50 08             	mov    0x8(%rax),%edx
 c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c95:	48 8b 00             	mov    (%rax),%rax
 c98:	8b 40 08             	mov    0x8(%rax),%eax
 c9b:	01 c2                	add    %eax,%edx
 c9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ca1:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca8:	48 8b 00             	mov    (%rax),%rax
 cab:	48 8b 10             	mov    (%rax),%rdx
 cae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cb2:	48 89 10             	mov    %rdx,(%rax)
 cb5:	eb 0e                	jmp    cc5 <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 cb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbb:	48 8b 10             	mov    (%rax),%rdx
 cbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cc2:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc9:	8b 40 08             	mov    0x8(%rax),%eax
 ccc:	89 c0                	mov    %eax,%eax
 cce:	48 c1 e0 04          	shl    $0x4,%rax
 cd2:	48 89 c2             	mov    %rax,%rdx
 cd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd9:	48 01 d0             	add    %rdx,%rax
 cdc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 ce0:	75 27                	jne    d09 <free+0x111>
    p->s.size += bp->s.size;
 ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce6:	8b 50 08             	mov    0x8(%rax),%edx
 ce9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ced:	8b 40 08             	mov    0x8(%rax),%eax
 cf0:	01 c2                	add    %eax,%edx
 cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf6:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 cf9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cfd:	48 8b 10             	mov    (%rax),%rdx
 d00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d04:	48 89 10             	mov    %rdx,(%rax)
 d07:	eb 0b                	jmp    d14 <free+0x11c>
  } else
    p->s.ptr = bp;
 d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d11:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d18:	48 89 05 a1 09 00 00 	mov    %rax,0x9a1(%rip)        # 16c0 <freep>
}
 d1f:	90                   	nop
 d20:	c9                   	leave
 d21:	c3                   	ret

0000000000000d22 <morecore>:

static Header*
morecore(uint nu)
{
 d22:	f3 0f 1e fa          	endbr64
 d26:	55                   	push   %rbp
 d27:	48 89 e5             	mov    %rsp,%rbp
 d2a:	48 83 ec 20          	sub    $0x20,%rsp
 d2e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d31:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d38:	77 07                	ja     d41 <morecore+0x1f>
    nu = 4096;
 d3a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d41:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d44:	c1 e0 04             	shl    $0x4,%eax
 d47:	89 c7                	mov    %eax,%edi
 d49:	e8 24 fa ff ff       	call   772 <sbrk>
 d4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d52:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d57:	75 07                	jne    d60 <morecore+0x3e>
    return 0;
 d59:	b8 00 00 00 00       	mov    $0x0,%eax
 d5e:	eb 29                	jmp    d89 <morecore+0x67>
  hp = (Header*)p;
 d60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d64:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d6c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d6f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d76:	48 83 c0 10          	add    $0x10,%rax
 d7a:	48 89 c7             	mov    %rax,%rdi
 d7d:	e8 76 fe ff ff       	call   bf8 <free>
  return freep;
 d82:	48 8b 05 37 09 00 00 	mov    0x937(%rip),%rax        # 16c0 <freep>
}
 d89:	c9                   	leave
 d8a:	c3                   	ret

0000000000000d8b <malloc>:

void*
malloc(uint nbytes)
{
 d8b:	f3 0f 1e fa          	endbr64
 d8f:	55                   	push   %rbp
 d90:	48 89 e5             	mov    %rsp,%rbp
 d93:	48 83 ec 30          	sub    $0x30,%rsp
 d97:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d9a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d9d:	48 83 c0 0f          	add    $0xf,%rax
 da1:	48 c1 e8 04          	shr    $0x4,%rax
 da5:	83 c0 01             	add    $0x1,%eax
 da8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 dab:	48 8b 05 0e 09 00 00 	mov    0x90e(%rip),%rax        # 16c0 <freep>
 db2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 db6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 dbb:	75 2b                	jne    de8 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 dbd:	48 c7 45 f0 b0 16 00 	movq   $0x16b0,-0x10(%rbp)
 dc4:	00 
 dc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dc9:	48 89 05 f0 08 00 00 	mov    %rax,0x8f0(%rip)        # 16c0 <freep>
 dd0:	48 8b 05 e9 08 00 00 	mov    0x8e9(%rip),%rax        # 16c0 <freep>
 dd7:	48 89 05 d2 08 00 00 	mov    %rax,0x8d2(%rip)        # 16b0 <base>
    base.s.size = 0;
 dde:	c7 05 d0 08 00 00 00 	movl   $0x0,0x8d0(%rip)        # 16b8 <base+0x8>
 de5:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 de8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dec:	48 8b 00             	mov    (%rax),%rax
 def:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 df3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 df7:	8b 40 08             	mov    0x8(%rax),%eax
 dfa:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 dfd:	72 5f                	jb     e5e <malloc+0xd3>
      if(p->s.size == nunits)
 dff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e03:	8b 40 08             	mov    0x8(%rax),%eax
 e06:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 e09:	75 10                	jne    e1b <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0f:	48 8b 10             	mov    (%rax),%rdx
 e12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e16:	48 89 10             	mov    %rdx,(%rax)
 e19:	eb 2e                	jmp    e49 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1f:	8b 40 08             	mov    0x8(%rax),%eax
 e22:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e25:	89 c2                	mov    %eax,%edx
 e27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e32:	8b 40 08             	mov    0x8(%rax),%eax
 e35:	89 c0                	mov    %eax,%eax
 e37:	48 c1 e0 04          	shl    $0x4,%rax
 e3b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e43:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e46:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e4d:	48 89 05 6c 08 00 00 	mov    %rax,0x86c(%rip)        # 16c0 <freep>
      return (void*)(p + 1);
 e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e58:	48 83 c0 10          	add    $0x10,%rax
 e5c:	eb 41                	jmp    e9f <malloc+0x114>
    }
    if(p == freep)
 e5e:	48 8b 05 5b 08 00 00 	mov    0x85b(%rip),%rax        # 16c0 <freep>
 e65:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e69:	75 1c                	jne    e87 <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e6b:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e6e:	89 c7                	mov    %eax,%edi
 e70:	e8 ad fe ff ff       	call   d22 <morecore>
 e75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e79:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e7e:	75 07                	jne    e87 <malloc+0xfc>
        return 0;
 e80:	b8 00 00 00 00       	mov    $0x0,%eax
 e85:	eb 18                	jmp    e9f <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e93:	48 8b 00             	mov    (%rax),%rax
 e96:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e9a:	e9 54 ff ff ff       	jmp    df3 <malloc+0x68>
  }
}
 e9f:	c9                   	leave
 ea0:	c3                   	ret
