
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
  73:	8b 04 85 40 12 00 00 	mov    0x1240(,%rax,4),%eax
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
  a0:	48 c7 c6 b0 0e 00 00 	mov    $0xeb0,%rsi
  a7:	bf 01 00 00 00       	mov    $0x1,%edi
  ac:	b8 00 00 00 00       	mov    $0x0,%eax
  b1:	e8 de 07 00 00       	call   894 <printf>
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
  fb:	48 c7 c6 d4 0e 00 00 	mov    $0xed4,%rsi
 102:	bf 01 00 00 00       	mov    $0x1,%edi
 107:	b8 00 00 00 00       	mov    $0x0,%eax
 10c:	e8 83 07 00 00       	call   894 <printf>
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
 1c5:	48 c7 c6 e9 0e 00 00 	mov    $0xee9,%rsi
 1cc:	bf 01 00 00 00       	mov    $0x1,%edi
 1d1:	b8 00 00 00 00       	mov    $0x0,%eax
 1d6:	e8 b9 06 00 00       	call   894 <printf>
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
 220:	48 c7 c6 05 0f 00 00 	mov    $0xf05,%rsi
 227:	bf 01 00 00 00       	mov    $0x1,%edi
 22c:	b8 00 00 00 00       	mov    $0x0,%eax
 231:	e8 5e 06 00 00       	call   894 <printf>

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
 2cf:	8b 14 85 40 12 00 00 	mov    0x1240(,%rax,4),%edx
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
 2f7:	48 c7 c6 18 0f 00 00 	mov    $0xf18,%rsi
 2fe:	bf 01 00 00 00       	mov    $0x1,%edi
 303:	b8 00 00 00 00       	mov    $0x0,%eax
 308:	e8 87 05 00 00       	call   894 <printf>
 30d:	48 83 c4 10          	add    $0x10,%rsp
    for (int i = 0; i < N; i++) {
 311:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 315:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
 319:	0f 8e 23 ff ff ff    	jle    242 <print_info+0xf3>
               children[i], tickets[i], ticks[i], cpu1, cpu2);
    }
    printf(1, "\n");
 31f:	48 c7 c6 44 0f 00 00 	mov    $0xf44,%rsi
 326:	bf 01 00 00 00       	mov    $0x1,%edi
 32b:	b8 00 00 00 00       	mov    $0x0,%eax
 330:	e8 5f 05 00 00       	call   894 <printf>
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
 364:	48 c7 c6 46 0f 00 00 	mov    $0xf46,%rsi
 36b:	bf 01 00 00 00       	mov    $0x1,%edi
 370:	b8 00 00 00 00       	mov    $0x0,%eax
 375:	e8 1a 05 00 00       	call   894 <printf>

    sleep(3000);
 37a:	bf b8 0b 00 00       	mov    $0xbb8,%edi
 37f:	e8 f6 03 00 00       	call   77a <sleep>

    if (getpinfo(&pstat) == -1) {
 384:	48 c7 c7 a0 12 00 00 	mov    $0x12a0,%rdi
 38b:	e8 fa 03 00 00       	call   78a <getpinfo>
 390:	83 f8 ff             	cmp    $0xffffffff,%eax
 393:	75 25                	jne    3ba <main+0x82>
        printf(1, "\nFailed to get pinfo\n");
 395:	48 c7 c6 5c 0f 00 00 	mov    $0xf5c,%rsi
 39c:	bf 01 00 00 00       	mov    $0x1,%edi
 3a1:	b8 00 00 00 00       	mov    $0x0,%eax
 3a6:	e8 e9 04 00 00       	call   894 <printf>
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

00000000000007a2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7a2:	f3 0f 1e fa          	endbr64
 7a6:	55                   	push   %rbp
 7a7:	48 89 e5             	mov    %rsp,%rbp
 7aa:	48 83 ec 10          	sub    $0x10,%rsp
 7ae:	89 7d fc             	mov    %edi,-0x4(%rbp)
 7b1:	89 f0                	mov    %esi,%eax
 7b3:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 7b6:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 7ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7bd:	ba 01 00 00 00       	mov    $0x1,%edx
 7c2:	48 89 ce             	mov    %rcx,%rsi
 7c5:	89 c7                	mov    %eax,%edi
 7c7:	e8 3e ff ff ff       	call   70a <write>
}
 7cc:	90                   	nop
 7cd:	c9                   	leave
 7ce:	c3                   	ret

00000000000007cf <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7cf:	f3 0f 1e fa          	endbr64
 7d3:	55                   	push   %rbp
 7d4:	48 89 e5             	mov    %rsp,%rbp
 7d7:	48 83 ec 30          	sub    $0x30,%rsp
 7db:	89 7d dc             	mov    %edi,-0x24(%rbp)
 7de:	89 75 d8             	mov    %esi,-0x28(%rbp)
 7e1:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 7e4:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 7ee:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 7f2:	74 17                	je     80b <printint+0x3c>
 7f4:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 7f8:	79 11                	jns    80b <printint+0x3c>
    neg = 1;
 7fa:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 801:	8b 45 d8             	mov    -0x28(%rbp),%eax
 804:	f7 d8                	neg    %eax
 806:	89 45 f4             	mov    %eax,-0xc(%rbp)
 809:	eb 06                	jmp    811 <printint+0x42>
  } else {
    x = xx;
 80b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 80e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 811:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 818:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 81b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 81e:	ba 00 00 00 00       	mov    $0x0,%edx
 823:	f7 f6                	div    %esi
 825:	89 d1                	mov    %edx,%ecx
 827:	8b 45 fc             	mov    -0x4(%rbp),%eax
 82a:	8d 50 01             	lea    0x1(%rax),%edx
 82d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 830:	89 ca                	mov    %ecx,%edx
 832:	0f b6 92 60 12 00 00 	movzbl 0x1260(%rdx),%edx
 839:	48 98                	cltq
 83b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 83f:	8b 7d d4             	mov    -0x2c(%rbp),%edi
 842:	8b 45 f4             	mov    -0xc(%rbp),%eax
 845:	ba 00 00 00 00       	mov    $0x0,%edx
 84a:	f7 f7                	div    %edi
 84c:	89 45 f4             	mov    %eax,-0xc(%rbp)
 84f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 853:	75 c3                	jne    818 <printint+0x49>
  if(neg)
 855:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 859:	74 2b                	je     886 <printint+0xb7>
    buf[i++] = '-';
 85b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 85e:	8d 50 01             	lea    0x1(%rax),%edx
 861:	89 55 fc             	mov    %edx,-0x4(%rbp)
 864:	48 98                	cltq
 866:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 86b:	eb 19                	jmp    886 <printint+0xb7>
    putc(fd, buf[i]);
 86d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 870:	48 98                	cltq
 872:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 877:	0f be d0             	movsbl %al,%edx
 87a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 87d:	89 d6                	mov    %edx,%esi
 87f:	89 c7                	mov    %eax,%edi
 881:	e8 1c ff ff ff       	call   7a2 <putc>
  while(--i >= 0)
 886:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 88a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 88e:	79 dd                	jns    86d <printint+0x9e>
}
 890:	90                   	nop
 891:	90                   	nop
 892:	c9                   	leave
 893:	c3                   	ret

0000000000000894 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 894:	f3 0f 1e fa          	endbr64
 898:	55                   	push   %rbp
 899:	48 89 e5             	mov    %rsp,%rbp
 89c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 8a3:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 8a9:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 8b0:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 8b7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 8be:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 8c5:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 8cc:	84 c0                	test   %al,%al
 8ce:	74 20                	je     8f0 <printf+0x5c>
 8d0:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 8d4:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 8d8:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 8dc:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 8e0:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 8e4:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 8e8:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 8ec:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 8f0:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 8f7:	00 00 00 
 8fa:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 901:	00 00 00 
 904:	48 8d 45 10          	lea    0x10(%rbp),%rax
 908:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 90f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 916:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 91d:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 924:	00 00 00 
  for(i = 0; fmt[i]; i++){
 927:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 92e:	00 00 00 
 931:	e9 a8 02 00 00       	jmp    bde <printf+0x34a>
    c = fmt[i] & 0xff;
 936:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 93c:	48 63 d0             	movslq %eax,%rdx
 93f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 946:	48 01 d0             	add    %rdx,%rax
 949:	0f b6 00             	movzbl (%rax),%eax
 94c:	0f be c0             	movsbl %al,%eax
 94f:	25 ff 00 00 00       	and    $0xff,%eax
 954:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 95a:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 961:	75 35                	jne    998 <printf+0x104>
      if(c == '%'){
 963:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 96a:	75 0f                	jne    97b <printf+0xe7>
        state = '%';
 96c:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 973:	00 00 00 
 976:	e9 5c 02 00 00       	jmp    bd7 <printf+0x343>
      } else {
        putc(fd, c);
 97b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 981:	0f be d0             	movsbl %al,%edx
 984:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 98a:	89 d6                	mov    %edx,%esi
 98c:	89 c7                	mov    %eax,%edi
 98e:	e8 0f fe ff ff       	call   7a2 <putc>
 993:	e9 3f 02 00 00       	jmp    bd7 <printf+0x343>
      }
    } else if(state == '%'){
 998:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 99f:	0f 85 32 02 00 00    	jne    bd7 <printf+0x343>
      if(c == 'd'){
 9a5:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 9ac:	75 5e                	jne    a0c <printf+0x178>
        printint(fd, va_arg(ap, int), 10, 1);
 9ae:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9b4:	83 f8 2f             	cmp    $0x2f,%eax
 9b7:	77 23                	ja     9dc <printf+0x148>
 9b9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9c6:	89 d2                	mov    %edx,%edx
 9c8:	48 01 d0             	add    %rdx,%rax
 9cb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9d1:	83 c2 08             	add    $0x8,%edx
 9d4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9da:	eb 12                	jmp    9ee <printf+0x15a>
 9dc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9e3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9e7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9ee:	8b 30                	mov    (%rax),%esi
 9f0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9f6:	b9 01 00 00 00       	mov    $0x1,%ecx
 9fb:	ba 0a 00 00 00       	mov    $0xa,%edx
 a00:	89 c7                	mov    %eax,%edi
 a02:	e8 c8 fd ff ff       	call   7cf <printint>
 a07:	e9 c1 01 00 00       	jmp    bcd <printf+0x339>
      } else if(c == 'x' || c == 'p'){
 a0c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 a13:	74 09                	je     a1e <printf+0x18a>
 a15:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 a1c:	75 5e                	jne    a7c <printf+0x1e8>
        printint(fd, va_arg(ap, int), 16, 0);
 a1e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a24:	83 f8 2f             	cmp    $0x2f,%eax
 a27:	77 23                	ja     a4c <printf+0x1b8>
 a29:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a30:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a36:	89 d2                	mov    %edx,%edx
 a38:	48 01 d0             	add    %rdx,%rax
 a3b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a41:	83 c2 08             	add    $0x8,%edx
 a44:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a4a:	eb 12                	jmp    a5e <printf+0x1ca>
 a4c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a53:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a57:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a5e:	8b 30                	mov    (%rax),%esi
 a60:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a66:	b9 00 00 00 00       	mov    $0x0,%ecx
 a6b:	ba 10 00 00 00       	mov    $0x10,%edx
 a70:	89 c7                	mov    %eax,%edi
 a72:	e8 58 fd ff ff       	call   7cf <printint>
 a77:	e9 51 01 00 00       	jmp    bcd <printf+0x339>
      } else if(c == 's'){
 a7c:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a83:	0f 85 98 00 00 00    	jne    b21 <printf+0x28d>
        s = va_arg(ap, char*);
 a89:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a8f:	83 f8 2f             	cmp    $0x2f,%eax
 a92:	77 23                	ja     ab7 <printf+0x223>
 a94:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a9b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 aa1:	89 d2                	mov    %edx,%edx
 aa3:	48 01 d0             	add    %rdx,%rax
 aa6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 aac:	83 c2 08             	add    $0x8,%edx
 aaf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 ab5:	eb 12                	jmp    ac9 <printf+0x235>
 ab7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 abe:	48 8d 50 08          	lea    0x8(%rax),%rdx
 ac2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 ac9:	48 8b 00             	mov    (%rax),%rax
 acc:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 ad3:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 ada:	00 
 adb:	75 31                	jne    b0e <printf+0x27a>
          s = "(null)";
 add:	48 c7 85 48 ff ff ff 	movq   $0xf72,-0xb8(%rbp)
 ae4:	72 0f 00 00 
        while(*s != 0){
 ae8:	eb 24                	jmp    b0e <printf+0x27a>
          putc(fd, *s);
 aea:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 af1:	0f b6 00             	movzbl (%rax),%eax
 af4:	0f be d0             	movsbl %al,%edx
 af7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 afd:	89 d6                	mov    %edx,%esi
 aff:	89 c7                	mov    %eax,%edi
 b01:	e8 9c fc ff ff       	call   7a2 <putc>
          s++;
 b06:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 b0d:	01 
        while(*s != 0){
 b0e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b15:	0f b6 00             	movzbl (%rax),%eax
 b18:	84 c0                	test   %al,%al
 b1a:	75 ce                	jne    aea <printf+0x256>
 b1c:	e9 ac 00 00 00       	jmp    bcd <printf+0x339>
        }
      } else if(c == 'c'){
 b21:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 b28:	75 56                	jne    b80 <printf+0x2ec>
        putc(fd, va_arg(ap, uint));
 b2a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 b30:	83 f8 2f             	cmp    $0x2f,%eax
 b33:	77 23                	ja     b58 <printf+0x2c4>
 b35:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 b3c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b42:	89 d2                	mov    %edx,%edx
 b44:	48 01 d0             	add    %rdx,%rax
 b47:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 b4d:	83 c2 08             	add    $0x8,%edx
 b50:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 b56:	eb 12                	jmp    b6a <printf+0x2d6>
 b58:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 b5f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 b63:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b6a:	8b 00                	mov    (%rax),%eax
 b6c:	0f be d0             	movsbl %al,%edx
 b6f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b75:	89 d6                	mov    %edx,%esi
 b77:	89 c7                	mov    %eax,%edi
 b79:	e8 24 fc ff ff       	call   7a2 <putc>
 b7e:	eb 4d                	jmp    bcd <printf+0x339>
      } else if(c == '%'){
 b80:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b87:	75 1a                	jne    ba3 <printf+0x30f>
        putc(fd, c);
 b89:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b8f:	0f be d0             	movsbl %al,%edx
 b92:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b98:	89 d6                	mov    %edx,%esi
 b9a:	89 c7                	mov    %eax,%edi
 b9c:	e8 01 fc ff ff       	call   7a2 <putc>
 ba1:	eb 2a                	jmp    bcd <printf+0x339>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ba3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 ba9:	be 25 00 00 00       	mov    $0x25,%esi
 bae:	89 c7                	mov    %eax,%edi
 bb0:	e8 ed fb ff ff       	call   7a2 <putc>
        putc(fd, c);
 bb5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 bbb:	0f be d0             	movsbl %al,%edx
 bbe:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 bc4:	89 d6                	mov    %edx,%esi
 bc6:	89 c7                	mov    %eax,%edi
 bc8:	e8 d5 fb ff ff       	call   7a2 <putc>
      }
      state = 0;
 bcd:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 bd4:	00 00 00 
  for(i = 0; fmt[i]; i++){
 bd7:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 bde:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 be4:	48 63 d0             	movslq %eax,%rdx
 be7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 bee:	48 01 d0             	add    %rdx,%rax
 bf1:	0f b6 00             	movzbl (%rax),%eax
 bf4:	84 c0                	test   %al,%al
 bf6:	0f 85 3a fd ff ff    	jne    936 <printf+0xa2>
    }
  }
}
 bfc:	90                   	nop
 bfd:	90                   	nop
 bfe:	c9                   	leave
 bff:	c3                   	ret

0000000000000c00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c00:	f3 0f 1e fa          	endbr64
 c04:	55                   	push   %rbp
 c05:	48 89 e5             	mov    %rsp,%rbp
 c08:	48 83 ec 18          	sub    $0x18,%rsp
 c0c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c14:	48 83 e8 10          	sub    $0x10,%rax
 c18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c1c:	48 8b 05 9d 0a 00 00 	mov    0xa9d(%rip),%rax        # 16c0 <freep>
 c23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c27:	eb 2f                	jmp    c58 <free+0x58>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2d:	48 8b 00             	mov    (%rax),%rax
 c30:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c34:	72 17                	jb     c4d <free+0x4d>
 c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c3a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c3e:	72 2f                	jb     c6f <free+0x6f>
 c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c44:	48 8b 00             	mov    (%rax),%rax
 c47:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c4b:	72 22                	jb     c6f <free+0x6f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c51:	48 8b 00             	mov    (%rax),%rax
 c54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c5c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c60:	73 c7                	jae    c29 <free+0x29>
 c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c66:	48 8b 00             	mov    (%rax),%rax
 c69:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c6d:	73 ba                	jae    c29 <free+0x29>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c73:	8b 40 08             	mov    0x8(%rax),%eax
 c76:	89 c0                	mov    %eax,%eax
 c78:	48 c1 e0 04          	shl    $0x4,%rax
 c7c:	48 89 c2             	mov    %rax,%rdx
 c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c83:	48 01 c2             	add    %rax,%rdx
 c86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c8a:	48 8b 00             	mov    (%rax),%rax
 c8d:	48 39 c2             	cmp    %rax,%rdx
 c90:	75 2d                	jne    cbf <free+0xbf>
    bp->s.size += p->s.ptr->s.size;
 c92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c96:	8b 50 08             	mov    0x8(%rax),%edx
 c99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9d:	48 8b 00             	mov    (%rax),%rax
 ca0:	8b 40 08             	mov    0x8(%rax),%eax
 ca3:	01 c2                	add    %eax,%edx
 ca5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ca9:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 cac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb0:	48 8b 00             	mov    (%rax),%rax
 cb3:	48 8b 10             	mov    (%rax),%rdx
 cb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cba:	48 89 10             	mov    %rdx,(%rax)
 cbd:	eb 0e                	jmp    ccd <free+0xcd>
  } else
    bp->s.ptr = p->s.ptr;
 cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc3:	48 8b 10             	mov    (%rax),%rdx
 cc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cca:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd1:	8b 40 08             	mov    0x8(%rax),%eax
 cd4:	89 c0                	mov    %eax,%eax
 cd6:	48 c1 e0 04          	shl    $0x4,%rax
 cda:	48 89 c2             	mov    %rax,%rdx
 cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce1:	48 01 d0             	add    %rdx,%rax
 ce4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 ce8:	75 27                	jne    d11 <free+0x111>
    p->s.size += bp->s.size;
 cea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cee:	8b 50 08             	mov    0x8(%rax),%edx
 cf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cf5:	8b 40 08             	mov    0x8(%rax),%eax
 cf8:	01 c2                	add    %eax,%edx
 cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfe:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d05:	48 8b 10             	mov    (%rax),%rdx
 d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0c:	48 89 10             	mov    %rdx,(%rax)
 d0f:	eb 0b                	jmp    d1c <free+0x11c>
  } else
    p->s.ptr = bp;
 d11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d15:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d19:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 d1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d20:	48 89 05 99 09 00 00 	mov    %rax,0x999(%rip)        # 16c0 <freep>
}
 d27:	90                   	nop
 d28:	c9                   	leave
 d29:	c3                   	ret

0000000000000d2a <morecore>:

static Header*
morecore(uint nu)
{
 d2a:	f3 0f 1e fa          	endbr64
 d2e:	55                   	push   %rbp
 d2f:	48 89 e5             	mov    %rsp,%rbp
 d32:	48 83 ec 20          	sub    $0x20,%rsp
 d36:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 d39:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 d40:	77 07                	ja     d49 <morecore+0x1f>
    nu = 4096;
 d42:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 d49:	8b 45 ec             	mov    -0x14(%rbp),%eax
 d4c:	c1 e0 04             	shl    $0x4,%eax
 d4f:	89 c7                	mov    %eax,%edi
 d51:	e8 1c fa ff ff       	call   772 <sbrk>
 d56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 d5a:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 d5f:	75 07                	jne    d68 <morecore+0x3e>
    return 0;
 d61:	b8 00 00 00 00       	mov    $0x0,%eax
 d66:	eb 29                	jmp    d91 <morecore+0x67>
  hp = (Header*)p;
 d68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d6c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d74:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d77:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d7e:	48 83 c0 10          	add    $0x10,%rax
 d82:	48 89 c7             	mov    %rax,%rdi
 d85:	e8 76 fe ff ff       	call   c00 <free>
  return freep;
 d8a:	48 8b 05 2f 09 00 00 	mov    0x92f(%rip),%rax        # 16c0 <freep>
}
 d91:	c9                   	leave
 d92:	c3                   	ret

0000000000000d93 <malloc>:

void*
malloc(uint nbytes)
{
 d93:	f3 0f 1e fa          	endbr64
 d97:	55                   	push   %rbp
 d98:	48 89 e5             	mov    %rsp,%rbp
 d9b:	48 83 ec 30          	sub    $0x30,%rsp
 d9f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 da2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 da5:	48 83 c0 0f          	add    $0xf,%rax
 da9:	48 c1 e8 04          	shr    $0x4,%rax
 dad:	83 c0 01             	add    $0x1,%eax
 db0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 db3:	48 8b 05 06 09 00 00 	mov    0x906(%rip),%rax        # 16c0 <freep>
 dba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 dbe:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 dc3:	75 2b                	jne    df0 <malloc+0x5d>
    base.s.ptr = freep = prevp = &base;
 dc5:	48 c7 45 f0 b0 16 00 	movq   $0x16b0,-0x10(%rbp)
 dcc:	00 
 dcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dd1:	48 89 05 e8 08 00 00 	mov    %rax,0x8e8(%rip)        # 16c0 <freep>
 dd8:	48 8b 05 e1 08 00 00 	mov    0x8e1(%rip),%rax        # 16c0 <freep>
 ddf:	48 89 05 ca 08 00 00 	mov    %rax,0x8ca(%rip)        # 16b0 <base>
    base.s.size = 0;
 de6:	c7 05 c8 08 00 00 00 	movl   $0x0,0x8c8(%rip)        # 16b8 <base+0x8>
 ded:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 df4:	48 8b 00             	mov    (%rax),%rax
 df7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dff:	8b 40 08             	mov    0x8(%rax),%eax
 e02:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 e05:	72 5f                	jb     e66 <malloc+0xd3>
      if(p->s.size == nunits)
 e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0b:	8b 40 08             	mov    0x8(%rax),%eax
 e0e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 e11:	75 10                	jne    e23 <malloc+0x90>
        prevp->s.ptr = p->s.ptr;
 e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e17:	48 8b 10             	mov    (%rax),%rdx
 e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e1e:	48 89 10             	mov    %rdx,(%rax)
 e21:	eb 2e                	jmp    e51 <malloc+0xbe>
      else {
        p->s.size -= nunits;
 e23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e27:	8b 40 08             	mov    0x8(%rax),%eax
 e2a:	2b 45 ec             	sub    -0x14(%rbp),%eax
 e2d:	89 c2                	mov    %eax,%edx
 e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e33:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 e36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e3a:	8b 40 08             	mov    0x8(%rax),%eax
 e3d:	89 c0                	mov    %eax,%eax
 e3f:	48 c1 e0 04          	shl    $0x4,%rax
 e43:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e4b:	8b 55 ec             	mov    -0x14(%rbp),%edx
 e4e:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 e51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 e55:	48 89 05 64 08 00 00 	mov    %rax,0x864(%rip)        # 16c0 <freep>
      return (void*)(p + 1);
 e5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e60:	48 83 c0 10          	add    $0x10,%rax
 e64:	eb 41                	jmp    ea7 <malloc+0x114>
    }
    if(p == freep)
 e66:	48 8b 05 53 08 00 00 	mov    0x853(%rip),%rax        # 16c0 <freep>
 e6d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e71:	75 1c                	jne    e8f <malloc+0xfc>
      if((p = morecore(nunits)) == 0)
 e73:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e76:	89 c7                	mov    %eax,%edi
 e78:	e8 ad fe ff ff       	call   d2a <morecore>
 e7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e81:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e86:	75 07                	jne    e8f <malloc+0xfc>
        return 0;
 e88:	b8 00 00 00 00       	mov    $0x0,%eax
 e8d:	eb 18                	jmp    ea7 <malloc+0x114>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e93:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e9b:	48 8b 00             	mov    (%rax),%rax
 e9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ea2:	e9 54 ff ff ff       	jmp    dfb <malloc+0x68>
  }
}
 ea7:	c9                   	leave
 ea8:	c3                   	ret
