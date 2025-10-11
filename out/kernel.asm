
out/kernel.elf:     file format elf64-x86-64


Disassembly of section .text:

ffffffff80100000 <begin>:
ffffffff80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%rax),%dh
ffffffff80100006:	01 00                	add    %eax,(%rax)
ffffffff80100008:	fe 4f 51             	decb   0x51(%rdi)
ffffffff8010000b:	e4 00                	in     $0x0,%al
ffffffff8010000d:	00 10                	add    %dl,(%rax)
ffffffff8010000f:	00 00                	add    %al,(%rax)
ffffffff80100011:	00 10                	add    %dl,(%rax)
ffffffff80100013:	00 00                	add    %al,(%rax)
ffffffff80100015:	c0 10 00             	rclb   $0x0,(%rax)
ffffffff80100018:	00 50 11             	add    %dl,0x11(%rax)
ffffffff8010001b:	00 20                	add    %ah,(%rax)
ffffffff8010001d:	00 10                	add    %dl,(%rax)
	...

ffffffff80100020 <mboot_entry>:
  .long mboot_entry_addr

mboot_entry:

# zero 4 pages for our bootstrap page tables
  xor %eax, %eax
ffffffff80100020:	31 c0                	xor    %eax,%eax
  mov $0x1000, %edi
ffffffff80100022:	bf 00 10 00 00       	mov    $0x1000,%edi
  mov $0x5000, %ecx
ffffffff80100027:	b9 00 50 00 00       	mov    $0x5000,%ecx
  rep stosb
ffffffff8010002c:	f3 aa                	rep stos %al,%es:(%rdi)

# P4ML[0] -> 0x2000 (PDPT-A)
  mov $(0x2000 | 3), %eax
ffffffff8010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
  mov %eax, 0x1000
ffffffff80100033:	a3 00 10 00 00 b8 03 	movabs %eax,0x3003b800001000
ffffffff8010003a:	30 00 

# P4ML[511] -> 0x3000 (PDPT-B)
  mov $(0x3000 | 3), %eax
ffffffff8010003c:	00 a3 f8 1f 00 00    	add    %ah,0x1ff8(%rbx)
  mov %eax, 0x1FF8

# PDPT-A[0] -> 0x4000 (PD)
  mov $(0x4000 | 3), %eax
ffffffff80100042:	b8 03 40 00 00       	mov    $0x4003,%eax
  mov %eax, 0x2000
ffffffff80100047:	a3 00 20 00 00 b8 03 	movabs %eax,0x4003b800002000
ffffffff8010004e:	40 00 

# PDPT-B[510] -> 0x4000 (PD)
  mov $(0x4000 | 3), %eax
ffffffff80100050:	00 a3 f0 3f 00 00    	add    %ah,0x3ff0(%rbx)
  mov %eax, 0x3FF0

# PD[0..511] -> 0..1022MB
  mov $0x83, %eax
ffffffff80100056:	b8 83 00 00 00       	mov    $0x83,%eax
  mov $0x4000, %ebx
ffffffff8010005b:	bb 00 40 00 00       	mov    $0x4000,%ebx
  mov $512, %ecx
ffffffff80100060:	b9 00 02 00 00       	mov    $0x200,%ecx

ffffffff80100065 <ptbl_loop>:
ptbl_loop:
  mov %eax, (%ebx)
ffffffff80100065:	89 03                	mov    %eax,(%rbx)
  add $0x200000, %eax
ffffffff80100067:	05 00 00 20 00       	add    $0x200000,%eax
  add $0x8, %ebx
ffffffff8010006c:	83 c3 08             	add    $0x8,%ebx
  dec %ecx
ffffffff8010006f:	49 75 f3             	rex.WB jne ffffffff80100065 <ptbl_loop>

# Clear ebx for initial processor boot.
# When secondary processors boot, they'll call through
# entry32mp (from entryother), but with a nonzero ebx.
# We'll reuse these bootstrap pagetables and GDT.
  xor %ebx, %ebx
ffffffff80100072:	31 db                	xor    %ebx,%ebx

ffffffff80100074 <entry32mp>:

.global entry32mp
entry32mp:
# CR3 -> 0x1000 (P4ML)
  mov $0x1000, %eax
ffffffff80100074:	b8 00 10 00 00       	mov    $0x1000,%eax
  mov %eax, %cr3
ffffffff80100079:	0f 22 d8             	mov    %rax,%cr3

  lgdt (gdtr64 - mboot_header + mboot_load_addr)
ffffffff8010007c:	0f 01 15 b0 00 10 00 	lgdt   0x1000b0(%rip)        # ffffffff80200133 <end+0xeb133>

# Enable PAE - CR4.PAE=1
  mov %cr4, %eax
ffffffff80100083:	0f 20 e0             	mov    %cr4,%rax
  bts $5, %eax
ffffffff80100086:	0f ba e8 05          	bts    $0x5,%eax
  mov %eax, %cr4
ffffffff8010008a:	0f 22 e0             	mov    %rax,%cr4

# enable long mode - EFER.LME=1
  mov $0xc0000080, %ecx
ffffffff8010008d:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  rdmsr
ffffffff80100092:	0f 32                	rdmsr
  bts $8, %eax
ffffffff80100094:	0f ba e8 08          	bts    $0x8,%eax
  wrmsr
ffffffff80100098:	0f 30                	wrmsr

# enable paging
  mov %cr0, %eax
ffffffff8010009a:	0f 20 c0             	mov    %cr0,%rax
  bts $31, %eax
ffffffff8010009d:	0f ba e8 1f          	bts    $0x1f,%eax
  mov %eax, %cr0
ffffffff801000a1:	0f 22 c0             	mov    %rax,%cr0

# shift to 64bit segment
  ljmp $8,$(entry64low - mboot_header + mboot_load_addr)
ffffffff801000a4:	ea                   	(bad)
ffffffff801000a5:	e0 00                	loopne ffffffff801000a7 <entry32mp+0x33>
ffffffff801000a7:	10 00                	adc    %al,(%rax)
ffffffff801000a9:	08 00                	or     %al,(%rax)
ffffffff801000ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

ffffffff801000b0 <gdtr64>:
ffffffff801000b0:	17                   	(bad)
ffffffff801000b1:	00 c0                	add    %al,%al
ffffffff801000b3:	00 10                	add    %dl,(%rax)
ffffffff801000b5:	00 00                	add    %al,(%rax)
ffffffff801000b7:	00 00                	add    %al,(%rax)
ffffffff801000b9:	00 90 0f 1f 44 00    	add    %dl,0x441f0f(%rax)
	...

ffffffff801000c0 <gdt64_begin>:
	...
ffffffff801000cc:	00 98 20 00 00 00    	add    %bl,0x20(%rax)
ffffffff801000d2:	00 00                	add    %al,(%rax)
ffffffff801000d4:	00                   	.byte 0
ffffffff801000d5:	90                   	nop
	...

ffffffff801000d8 <gdt64_end>:
ffffffff801000d8:	90                   	nop
ffffffff801000d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

ffffffff801000e0 <entry64low>:
gdt64_end:

.align 16
.code64
entry64low:
  movq $entry64high, %rax
ffffffff801000e0:	48 c7 c0 e9 00 10 80 	mov    $0xffffffff801000e9,%rax
  jmp *%rax
ffffffff801000e7:	ff e0                	jmp    *%rax

ffffffff801000e9 <_start>:
.global _start
_start:
entry64high:

# ensure data segment registers are sane
  xor %rax, %rax
ffffffff801000e9:	48 31 c0             	xor    %rax,%rax
  mov %ax, %ss
ffffffff801000ec:	8e d0                	mov    %eax,%ss
  mov %ax, %ds
ffffffff801000ee:	8e d8                	mov    %eax,%ds
  mov %ax, %es
ffffffff801000f0:	8e c0                	mov    %eax,%es
  mov %ax, %fs
ffffffff801000f2:	8e e0                	mov    %eax,%fs
  mov %ax, %gs
ffffffff801000f4:	8e e8                	mov    %eax,%gs

# check to see if we're booting a secondary core
  test %ebx, %ebx
ffffffff801000f6:	85 db                	test   %ebx,%ebx
  jnz entry64mp
ffffffff801000f8:	75 11                	jne    ffffffff8010010b <entry64mp>

# setup initial stack
  mov $0xFFFFFFFF80010000, %rax
ffffffff801000fa:	48 c7 c0 00 00 01 80 	mov    $0xffffffff80010000,%rax
  mov %rax, %rsp
ffffffff80100101:	48 89 c4             	mov    %rax,%rsp

# enter main()
  jmp main
ffffffff80100104:	e9 93 3c 00 00       	jmp    ffffffff80103d9c <main>

ffffffff80100109 <__deadloop>:

.global __deadloop
__deadloop:
# we should never return here...
  jmp .
ffffffff80100109:	eb fe                	jmp    ffffffff80100109 <__deadloop>

ffffffff8010010b <entry64mp>:

entry64mp:
# obtain kstack from data block before entryother
  mov $0x7000, %rax
ffffffff8010010b:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
  mov -16(%rax), %rsp
ffffffff80100112:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
  jmp mpenter
ffffffff80100116:	e9 45 3d 00 00       	jmp    ffffffff80103e60 <mpenter>

ffffffff8010011b <wrmsr>:

.global wrmsr
wrmsr:
  mov %rdi, %rcx     # arg0 -> msrnum
ffffffff8010011b:	48 89 f9             	mov    %rdi,%rcx
  mov %rsi, %rax     # val.low -> eax
ffffffff8010011e:	48 89 f0             	mov    %rsi,%rax
  shr $32, %rsi
ffffffff80100121:	48 c1 ee 20          	shr    $0x20,%rsi
  mov %rsi, %rdx     # val.high -> edx
ffffffff80100125:	48 89 f2             	mov    %rsi,%rdx
  wrmsr
ffffffff80100128:	0f 30                	wrmsr
  retq
ffffffff8010012a:	c3                   	ret

ffffffff8010012b <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
ffffffff8010012b:	f3 0f 1e fa          	endbr64
ffffffff8010012f:	55                   	push   %rbp
ffffffff80100130:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100133:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
ffffffff80100137:	48 c7 c6 18 9b 10 80 	mov    $0xffffffff80109b18,%rsi
ffffffff8010013e:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff80100145:	e8 30 5c 00 00       	call   ffffffff80105d7a <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffffffff8010014a:	48 c7 05 b3 d4 00 00 	movq   $0xffffffff8010d5f8,0xd4b3(%rip)        # ffffffff8010d608 <bcache+0x1608>
ffffffff80100151:	f8 d5 10 80 
  bcache.head.next = &bcache.head;
ffffffff80100155:	48 c7 05 b0 d4 00 00 	movq   $0xffffffff8010d5f8,0xd4b0(%rip)        # ffffffff8010d610 <bcache+0x1610>
ffffffff8010015c:	f8 d5 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffffffff80100160:	48 c7 45 f8 68 c0 10 	movq   $0xffffffff8010c068,-0x8(%rbp)
ffffffff80100167:	80 
ffffffff80100168:	eb 48                	jmp    ffffffff801001b2 <binit+0x87>
    b->next = bcache.head.next;
ffffffff8010016a:	48 8b 15 9f d4 00 00 	mov    0xd49f(%rip),%rdx        # ffffffff8010d610 <bcache+0x1610>
ffffffff80100171:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100175:	48 89 50 18          	mov    %rdx,0x18(%rax)
    b->prev = &bcache.head;
ffffffff80100179:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010017d:	48 c7 40 10 f8 d5 10 	movq   $0xffffffff8010d5f8,0x10(%rax)
ffffffff80100184:	80 
    b->dev = -1;
ffffffff80100185:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100189:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%rax)
    bcache.head.next->prev = b;
ffffffff80100190:	48 8b 05 79 d4 00 00 	mov    0xd479(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff80100197:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010019b:	48 89 50 10          	mov    %rdx,0x10(%rax)
    bcache.head.next = b;
ffffffff8010019f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801001a3:	48 89 05 66 d4 00 00 	mov    %rax,0xd466(%rip)        # ffffffff8010d610 <bcache+0x1610>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffffffff801001aa:	48 81 45 f8 28 02 00 	addq   $0x228,-0x8(%rbp)
ffffffff801001b1:	00 
ffffffff801001b2:	48 c7 c0 f8 d5 10 80 	mov    $0xffffffff8010d5f8,%rax
ffffffff801001b9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff801001bd:	72 ab                	jb     ffffffff8010016a <binit+0x3f>
  }
}
ffffffff801001bf:	90                   	nop
ffffffff801001c0:	90                   	nop
ffffffff801001c1:	c9                   	leave
ffffffff801001c2:	c3                   	ret

ffffffff801001c3 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
ffffffff801001c3:	f3 0f 1e fa          	endbr64
ffffffff801001c7:	55                   	push   %rbp
ffffffff801001c8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801001cb:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801001cf:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801001d2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  acquire(&bcache.lock);
ffffffff801001d5:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff801001dc:	e8 d2 5b 00 00       	call   ffffffff80105db3 <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffffffff801001e1:	48 8b 05 28 d4 00 00 	mov    0xd428(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff801001e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801001ec:	eb 6c                	jmp    ffffffff8010025a <bget+0x97>
    if(b->dev == dev && b->sector == sector){
ffffffff801001ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801001f2:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801001f5:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff801001f8:	75 54                	jne    ffffffff8010024e <bget+0x8b>
ffffffff801001fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801001fe:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80100201:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff80100204:	75 48                	jne    ffffffff8010024e <bget+0x8b>
      if(!(b->flags & B_BUSY)){
ffffffff80100206:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010020a:	8b 00                	mov    (%rax),%eax
ffffffff8010020c:	83 e0 01             	and    $0x1,%eax
ffffffff8010020f:	85 c0                	test   %eax,%eax
ffffffff80100211:	75 26                	jne    ffffffff80100239 <bget+0x76>
        b->flags |= B_BUSY;
ffffffff80100213:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100217:	8b 00                	mov    (%rax),%eax
ffffffff80100219:	83 c8 01             	or     $0x1,%eax
ffffffff8010021c:	89 c2                	mov    %eax,%edx
ffffffff8010021e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100222:	89 10                	mov    %edx,(%rax)
        release(&bcache.lock);
ffffffff80100224:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff8010022b:	e8 5e 5c 00 00       	call   ffffffff80105e8e <release>
        return b;
ffffffff80100230:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100234:	e9 a4 00 00 00       	jmp    ffffffff801002dd <bget+0x11a>
      }
      sleep(b, &bcache.lock);
ffffffff80100239:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010023d:	48 c7 c6 00 c0 10 80 	mov    $0xffffffff8010c000,%rsi
ffffffff80100244:	48 89 c7             	mov    %rax,%rdi
ffffffff80100247:	e8 cb 57 00 00       	call   ffffffff80105a17 <sleep>
      goto loop;
ffffffff8010024c:	eb 93                	jmp    ffffffff801001e1 <bget+0x1e>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffffffff8010024e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100252:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80100256:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010025a:	48 81 7d f8 f8 d5 10 	cmpq   $0xffffffff8010d5f8,-0x8(%rbp)
ffffffff80100261:	80 
ffffffff80100262:	75 8a                	jne    ffffffff801001ee <bget+0x2b>
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffffffff80100264:	48 8b 05 9d d3 00 00 	mov    0xd39d(%rip),%rax        # ffffffff8010d608 <bcache+0x1608>
ffffffff8010026b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010026f:	eb 56                	jmp    ffffffff801002c7 <bget+0x104>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
ffffffff80100271:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100275:	8b 00                	mov    (%rax),%eax
ffffffff80100277:	83 e0 01             	and    $0x1,%eax
ffffffff8010027a:	85 c0                	test   %eax,%eax
ffffffff8010027c:	75 3d                	jne    ffffffff801002bb <bget+0xf8>
ffffffff8010027e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100282:	8b 00                	mov    (%rax),%eax
ffffffff80100284:	83 e0 04             	and    $0x4,%eax
ffffffff80100287:	85 c0                	test   %eax,%eax
ffffffff80100289:	75 30                	jne    ffffffff801002bb <bget+0xf8>
      b->dev = dev;
ffffffff8010028b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010028f:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80100292:	89 50 04             	mov    %edx,0x4(%rax)
      b->sector = sector;
ffffffff80100295:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100299:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff8010029c:	89 50 08             	mov    %edx,0x8(%rax)
      b->flags = B_BUSY;
ffffffff8010029f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002a3:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      release(&bcache.lock);
ffffffff801002a9:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff801002b0:	e8 d9 5b 00 00       	call   ffffffff80105e8e <release>
      return b;
ffffffff801002b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002b9:	eb 22                	jmp    ffffffff801002dd <bget+0x11a>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffffffff801002bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002bf:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801002c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801002c7:	48 81 7d f8 f8 d5 10 	cmpq   $0xffffffff8010d5f8,-0x8(%rbp)
ffffffff801002ce:	80 
ffffffff801002cf:	75 a0                	jne    ffffffff80100271 <bget+0xae>
    }
  }
  panic("bget: no buffers");
ffffffff801002d1:	48 c7 c7 1f 9b 10 80 	mov    $0xffffffff80109b1f,%rdi
ffffffff801002d8:	e8 72 06 00 00       	call   ffffffff8010094f <panic>
}
ffffffff801002dd:	c9                   	leave
ffffffff801002de:	c3                   	ret

ffffffff801002df <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
ffffffff801002df:	f3 0f 1e fa          	endbr64
ffffffff801002e3:	55                   	push   %rbp
ffffffff801002e4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801002e7:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801002eb:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801002ee:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  b = bget(dev, sector);
ffffffff801002f1:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff801002f4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801002f7:	89 d6                	mov    %edx,%esi
ffffffff801002f9:	89 c7                	mov    %eax,%edi
ffffffff801002fb:	e8 c3 fe ff ff       	call   ffffffff801001c3 <bget>
ffffffff80100300:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!(b->flags & B_VALID))
ffffffff80100304:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100308:	8b 00                	mov    (%rax),%eax
ffffffff8010030a:	83 e0 02             	and    $0x2,%eax
ffffffff8010030d:	85 c0                	test   %eax,%eax
ffffffff8010030f:	75 0c                	jne    ffffffff8010031d <bread+0x3e>
    iderw(b);
ffffffff80100311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100315:	48 89 c7             	mov    %rax,%rdi
ffffffff80100318:	e8 ba 2c 00 00       	call   ffffffff80102fd7 <iderw>
  return b;
ffffffff8010031d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80100321:	c9                   	leave
ffffffff80100322:	c3                   	ret

ffffffff80100323 <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
ffffffff80100323:	f3 0f 1e fa          	endbr64
ffffffff80100327:	55                   	push   %rbp
ffffffff80100328:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010032b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010032f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if((b->flags & B_BUSY) == 0)
ffffffff80100333:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100337:	8b 00                	mov    (%rax),%eax
ffffffff80100339:	83 e0 01             	and    $0x1,%eax
ffffffff8010033c:	85 c0                	test   %eax,%eax
ffffffff8010033e:	75 0c                	jne    ffffffff8010034c <bwrite+0x29>
    panic("bwrite");
ffffffff80100340:	48 c7 c7 30 9b 10 80 	mov    $0xffffffff80109b30,%rdi
ffffffff80100347:	e8 03 06 00 00       	call   ffffffff8010094f <panic>
  b->flags |= B_DIRTY;
ffffffff8010034c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100350:	8b 00                	mov    (%rax),%eax
ffffffff80100352:	83 c8 04             	or     $0x4,%eax
ffffffff80100355:	89 c2                	mov    %eax,%edx
ffffffff80100357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010035b:	89 10                	mov    %edx,(%rax)
  iderw(b);
ffffffff8010035d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100361:	48 89 c7             	mov    %rax,%rdi
ffffffff80100364:	e8 6e 2c 00 00       	call   ffffffff80102fd7 <iderw>
}
ffffffff80100369:	90                   	nop
ffffffff8010036a:	c9                   	leave
ffffffff8010036b:	c3                   	ret

ffffffff8010036c <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
ffffffff8010036c:	f3 0f 1e fa          	endbr64
ffffffff80100370:	55                   	push   %rbp
ffffffff80100371:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100374:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80100378:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if((b->flags & B_BUSY) == 0)
ffffffff8010037c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100380:	8b 00                	mov    (%rax),%eax
ffffffff80100382:	83 e0 01             	and    $0x1,%eax
ffffffff80100385:	85 c0                	test   %eax,%eax
ffffffff80100387:	75 0c                	jne    ffffffff80100395 <brelse+0x29>
    panic("brelse");
ffffffff80100389:	48 c7 c7 37 9b 10 80 	mov    $0xffffffff80109b37,%rdi
ffffffff80100390:	e8 ba 05 00 00       	call   ffffffff8010094f <panic>

  acquire(&bcache.lock);
ffffffff80100395:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff8010039c:	e8 12 5a 00 00       	call   ffffffff80105db3 <acquire>

  b->next->prev = b->prev;
ffffffff801003a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003a5:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801003a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801003ad:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffffffff801003b1:	48 89 50 10          	mov    %rdx,0x10(%rax)
  b->prev->next = b->next;
ffffffff801003b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003b9:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801003bd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801003c1:	48 8b 52 18          	mov    0x18(%rdx),%rdx
ffffffff801003c5:	48 89 50 18          	mov    %rdx,0x18(%rax)
  b->next = bcache.head.next;
ffffffff801003c9:	48 8b 15 40 d2 00 00 	mov    0xd240(%rip),%rdx        # ffffffff8010d610 <bcache+0x1610>
ffffffff801003d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003d4:	48 89 50 18          	mov    %rdx,0x18(%rax)
  b->prev = &bcache.head;
ffffffff801003d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003dc:	48 c7 40 10 f8 d5 10 	movq   $0xffffffff8010d5f8,0x10(%rax)
ffffffff801003e3:	80 
  bcache.head.next->prev = b;
ffffffff801003e4:	48 8b 05 25 d2 00 00 	mov    0xd225(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff801003eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801003ef:	48 89 50 10          	mov    %rdx,0x10(%rax)
  bcache.head.next = b;
ffffffff801003f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003f7:	48 89 05 12 d2 00 00 	mov    %rax,0xd212(%rip)        # ffffffff8010d610 <bcache+0x1610>

  b->flags &= ~B_BUSY;
ffffffff801003fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100402:	8b 00                	mov    (%rax),%eax
ffffffff80100404:	83 e0 fe             	and    $0xfffffffe,%eax
ffffffff80100407:	89 c2                	mov    %eax,%edx
ffffffff80100409:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010040d:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffffffff8010040f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100413:	48 89 c7             	mov    %rax,%rdi
ffffffff80100416:	e8 18 57 00 00       	call   ffffffff80105b33 <wakeup>

  release(&bcache.lock);
ffffffff8010041b:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff80100422:	e8 67 5a 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80100427:	90                   	nop
ffffffff80100428:	c9                   	leave
ffffffff80100429:	c3                   	ret

ffffffff8010042a <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
ffffffff8010042a:	55                   	push   %rbp
ffffffff8010042b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010042e:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80100432:	89 f8                	mov    %edi,%eax
ffffffff80100434:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80100438:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff8010043c:	89 c2                	mov    %eax,%edx
ffffffff8010043e:	ec                   	in     (%dx),%al
ffffffff8010043f:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80100442:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80100446:	c9                   	leave
ffffffff80100447:	c3                   	ret

ffffffff80100448 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
ffffffff80100448:	55                   	push   %rbp
ffffffff80100449:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010044c:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80100450:	89 fa                	mov    %edi,%edx
ffffffff80100452:	89 f0                	mov    %esi,%eax
ffffffff80100454:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80100458:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff8010045b:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff8010045f:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80100463:	ee                   	out    %al,(%dx)
}
ffffffff80100464:	90                   	nop
ffffffff80100465:	c9                   	leave
ffffffff80100466:	c3                   	ret

ffffffff80100467 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
ffffffff80100467:	55                   	push   %rbp
ffffffff80100468:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010046b:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010046f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80100473:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  volatile ushort pd[5];

  pd[0] = size-1;
ffffffff80100476:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80100479:	83 e8 01             	sub    $0x1,%eax
ffffffff8010047c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff80100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100484:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff80100488:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010048c:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff80100490:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
#if X64
  pd[3] = (uintp)p >> 32;
ffffffff80100494:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100498:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff8010049c:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff801004a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801004a4:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff801004a8:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
#endif
  asm volatile("lidt (%0)" : : "r" (pd));
ffffffff801004ac:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff801004b0:	0f 01 18             	lidt   (%rax)
}
ffffffff801004b3:	90                   	nop
ffffffff801004b4:	c9                   	leave
ffffffff801004b5:	c3                   	ret

ffffffff801004b6 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
ffffffff801004b6:	55                   	push   %rbp
ffffffff801004b7:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffffffff801004ba:	fa                   	cli
}
ffffffff801004bb:	90                   	nop
ffffffff801004bc:	5d                   	pop    %rbp
ffffffff801004bd:	c3                   	ret

ffffffff801004be <printptr>:
} cons;

static char digits[] = "0123456789abcdef";

static void
printptr(uintp x) {
ffffffff801004be:	f3 0f 1e fa          	endbr64
ffffffff801004c2:	55                   	push   %rbp
ffffffff801004c3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801004c6:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801004ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uintp) * 2); i++, x <<= 4)
ffffffff801004ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801004d5:	eb 22                	jmp    ffffffff801004f9 <printptr+0x3b>
    consputc(digits[x >> (sizeof(uintp) * 8 - 4)]);
ffffffff801004d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801004db:	48 c1 e8 3c          	shr    $0x3c,%rax
ffffffff801004df:	0f b6 80 00 b0 10 80 	movzbl -0x7fef5000(%rax),%eax
ffffffff801004e6:	0f be c0             	movsbl %al,%eax
ffffffff801004e9:	89 c7                	mov    %eax,%edi
ffffffff801004eb:	e8 9e 06 00 00       	call   ffffffff80100b8e <consputc>
  for (i = 0; i < (sizeof(uintp) * 2); i++, x <<= 4)
ffffffff801004f0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801004f4:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffffffff801004f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801004fc:	83 f8 0f             	cmp    $0xf,%eax
ffffffff801004ff:	76 d6                	jbe    ffffffff801004d7 <printptr+0x19>
}
ffffffff80100501:	90                   	nop
ffffffff80100502:	90                   	nop
ffffffff80100503:	c9                   	leave
ffffffff80100504:	c3                   	ret

ffffffff80100505 <printint>:

static void
printint(int xx, int base, int sign)
{
ffffffff80100505:	f3 0f 1e fa          	endbr64
ffffffff80100509:	55                   	push   %rbp
ffffffff8010050a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010050d:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80100511:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff80100514:	89 75 d8             	mov    %esi,-0x28(%rbp)
ffffffff80100517:	89 55 d4             	mov    %edx,-0x2c(%rbp)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
ffffffff8010051a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff8010051e:	74 1c                	je     ffffffff8010053c <printint+0x37>
ffffffff80100520:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100523:	c1 e8 1f             	shr    $0x1f,%eax
ffffffff80100526:	0f b6 c0             	movzbl %al,%eax
ffffffff80100529:	89 45 d4             	mov    %eax,-0x2c(%rbp)
ffffffff8010052c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff80100530:	74 0a                	je     ffffffff8010053c <printint+0x37>
    x = -xx;
ffffffff80100532:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100535:	f7 d8                	neg    %eax
ffffffff80100537:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff8010053a:	eb 06                	jmp    ffffffff80100542 <printint+0x3d>
  else
    x = xx;
ffffffff8010053c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010053f:	89 45 f8             	mov    %eax,-0x8(%rbp)

  i = 0;
ffffffff80100542:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
ffffffff80100549:	8b 75 d8             	mov    -0x28(%rbp),%esi
ffffffff8010054c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010054f:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80100554:	f7 f6                	div    %esi
ffffffff80100556:	89 d1                	mov    %edx,%ecx
ffffffff80100558:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010055b:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff8010055e:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100561:	89 ca                	mov    %ecx,%edx
ffffffff80100563:	0f b6 92 00 b0 10 80 	movzbl -0x7fef5000(%rdx),%edx
ffffffff8010056a:	48 98                	cltq
ffffffff8010056c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
ffffffff80100570:	8b 7d d8             	mov    -0x28(%rbp),%edi
ffffffff80100573:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80100576:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff8010057b:	f7 f7                	div    %edi
ffffffff8010057d:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff80100580:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffffffff80100584:	75 c3                	jne    ffffffff80100549 <printint+0x44>

  if(sign)
ffffffff80100586:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff8010058a:	74 26                	je     ffffffff801005b2 <printint+0xad>
    buf[i++] = '-';
ffffffff8010058c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010058f:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100592:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100595:	48 98                	cltq
ffffffff80100597:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
ffffffff8010059c:	eb 14                	jmp    ffffffff801005b2 <printint+0xad>
    consputc(buf[i]);
ffffffff8010059e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801005a1:	48 98                	cltq
ffffffff801005a3:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffffffff801005a8:	0f be c0             	movsbl %al,%eax
ffffffff801005ab:	89 c7                	mov    %eax,%edi
ffffffff801005ad:	e8 dc 05 00 00       	call   ffffffff80100b8e <consputc>
  while(--i >= 0)
ffffffff801005b2:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffffffff801005b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801005ba:	79 e2                	jns    ffffffff8010059e <printint+0x99>
}
ffffffff801005bc:	90                   	nop
ffffffff801005bd:	90                   	nop
ffffffff801005be:	c9                   	leave
ffffffff801005bf:	c3                   	ret

ffffffff801005c0 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
ffffffff801005c0:	f3 0f 1e fa          	endbr64
ffffffff801005c4:	55                   	push   %rbp
ffffffff801005c5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801005c8:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffffffff801005cf:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
ffffffff801005d6:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
ffffffff801005dd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
ffffffff801005e4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
ffffffff801005eb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
ffffffff801005f2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
ffffffff801005f9:	84 c0                	test   %al,%al
ffffffff801005fb:	74 20                	je     ffffffff8010061d <cprintf+0x5d>
ffffffff801005fd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
ffffffff80100601:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
ffffffff80100605:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
ffffffff80100609:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
ffffffff8010060d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
ffffffff80100611:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
ffffffff80100615:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
ffffffff80100619:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c, locking;
  char *s;

  va_start(ap, fmt);
ffffffff8010061d:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffffffff80100624:	00 00 00 
ffffffff80100627:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffffffff8010062e:	00 00 00 
ffffffff80100631:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffffffff80100635:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffffffff8010063c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffffffff80100643:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  locking = cons.locking;
ffffffff8010064a:	8b 05 38 d3 00 00    	mov    0xd338(%rip),%eax        # ffffffff8010d988 <cons+0x68>
ffffffff80100650:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if(locking)
ffffffff80100656:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffffffff8010065d:	74 0c                	je     ffffffff8010066b <cprintf+0xab>
    acquire(&cons.lock);
ffffffff8010065f:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100666:	e8 48 57 00 00       	call   ffffffff80105db3 <acquire>

  if (fmt == 0)
ffffffff8010066b:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffffffff80100672:	00 
ffffffff80100673:	75 0c                	jne    ffffffff80100681 <cprintf+0xc1>
    panic("null fmt");
ffffffff80100675:	48 c7 c7 3e 9b 10 80 	mov    $0xffffffff80109b3e,%rdi
ffffffff8010067c:	e8 ce 02 00 00       	call   ffffffff8010094f <panic>

  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
ffffffff80100681:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffffffff80100688:	00 00 00 
ffffffff8010068b:	e9 73 02 00 00       	jmp    ffffffff80100903 <cprintf+0x343>
    if(c != '%'){
ffffffff80100690:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffffffff80100697:	74 12                	je     ffffffff801006ab <cprintf+0xeb>
      consputc(c);
ffffffff80100699:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffffffff8010069f:	89 c7                	mov    %eax,%edi
ffffffff801006a1:	e8 e8 04 00 00       	call   ffffffff80100b8e <consputc>
      continue;
ffffffff801006a6:	e9 51 02 00 00       	jmp    ffffffff801008fc <cprintf+0x33c>
    }
    c = fmt[++i] & 0xff;
ffffffff801006ab:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffffffff801006b2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffffffff801006b8:	48 63 d0             	movslq %eax,%rdx
ffffffff801006bb:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffffffff801006c2:	48 01 d0             	add    %rdx,%rax
ffffffff801006c5:	0f b6 00             	movzbl (%rax),%eax
ffffffff801006c8:	0f be c0             	movsbl %al,%eax
ffffffff801006cb:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff801006d0:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
    if(c == 0)
ffffffff801006d6:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffffffff801006dd:	0f 84 53 02 00 00    	je     ffffffff80100936 <cprintf+0x376>
      break;
    switch(c){
ffffffff801006e3:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffffffff801006ea:	0f 84 b3 00 00 00    	je     ffffffff801007a3 <cprintf+0x1e3>
ffffffff801006f0:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffffffff801006f7:	0f 8f e7 01 00 00    	jg     ffffffff801008e4 <cprintf+0x324>
ffffffff801006fd:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffffffff80100704:	0f 84 41 01 00 00    	je     ffffffff8010084b <cprintf+0x28b>
ffffffff8010070a:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffffffff80100711:	0f 8f cd 01 00 00    	jg     ffffffff801008e4 <cprintf+0x324>
ffffffff80100717:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffffffff8010071e:	0f 84 d7 00 00 00    	je     ffffffff801007fb <cprintf+0x23b>
ffffffff80100724:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffffffff8010072b:	0f 8f b3 01 00 00    	jg     ffffffff801008e4 <cprintf+0x324>
ffffffff80100731:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffffffff80100738:	0f 84 9a 01 00 00    	je     ffffffff801008d8 <cprintf+0x318>
ffffffff8010073e:	83 bd 38 ff ff ff 64 	cmpl   $0x64,-0xc8(%rbp)
ffffffff80100745:	0f 85 99 01 00 00    	jne    ffffffff801008e4 <cprintf+0x324>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
ffffffff8010074b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100751:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff80100754:	77 23                	ja     ffffffff80100779 <cprintf+0x1b9>
ffffffff80100756:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff8010075d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff80100763:	89 d2                	mov    %edx,%edx
ffffffff80100765:	48 01 d0             	add    %rdx,%rax
ffffffff80100768:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010076e:	83 c2 08             	add    $0x8,%edx
ffffffff80100771:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100777:	eb 12                	jmp    ffffffff8010078b <cprintf+0x1cb>
ffffffff80100779:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100780:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100784:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010078b:	8b 00                	mov    (%rax),%eax
ffffffff8010078d:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80100792:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80100797:	89 c7                	mov    %eax,%edi
ffffffff80100799:	e8 67 fd ff ff       	call   ffffffff80100505 <printint>
      break;
ffffffff8010079e:	e9 59 01 00 00       	jmp    ffffffff801008fc <cprintf+0x33c>
    case 'x':
      printint(va_arg(ap, int), 16, 0);
ffffffff801007a3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff801007a9:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff801007ac:	77 23                	ja     ffffffff801007d1 <cprintf+0x211>
ffffffff801007ae:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff801007b5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff801007bb:	89 d2                	mov    %edx,%edx
ffffffff801007bd:	48 01 d0             	add    %rdx,%rax
ffffffff801007c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff801007c6:	83 c2 08             	add    $0x8,%edx
ffffffff801007c9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff801007cf:	eb 12                	jmp    ffffffff801007e3 <cprintf+0x223>
ffffffff801007d1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff801007d8:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff801007dc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff801007e3:	8b 00                	mov    (%rax),%eax
ffffffff801007e5:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff801007ea:	be 10 00 00 00       	mov    $0x10,%esi
ffffffff801007ef:	89 c7                	mov    %eax,%edi
ffffffff801007f1:	e8 0f fd ff ff       	call   ffffffff80100505 <printint>
      break;
ffffffff801007f6:	e9 01 01 00 00       	jmp    ffffffff801008fc <cprintf+0x33c>
    case 'p':
      printptr(va_arg(ap, uintp));
ffffffff801007fb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100801:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff80100804:	77 23                	ja     ffffffff80100829 <cprintf+0x269>
ffffffff80100806:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff8010080d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff80100813:	89 d2                	mov    %edx,%edx
ffffffff80100815:	48 01 d0             	add    %rdx,%rax
ffffffff80100818:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010081e:	83 c2 08             	add    $0x8,%edx
ffffffff80100821:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100827:	eb 12                	jmp    ffffffff8010083b <cprintf+0x27b>
ffffffff80100829:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100830:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100834:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010083b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010083e:	48 89 c7             	mov    %rax,%rdi
ffffffff80100841:	e8 78 fc ff ff       	call   ffffffff801004be <printptr>
      break;
ffffffff80100846:	e9 b1 00 00 00       	jmp    ffffffff801008fc <cprintf+0x33c>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
ffffffff8010084b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100851:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff80100854:	77 23                	ja     ffffffff80100879 <cprintf+0x2b9>
ffffffff80100856:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff8010085d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff80100863:	89 d2                	mov    %edx,%edx
ffffffff80100865:	48 01 d0             	add    %rdx,%rax
ffffffff80100868:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010086e:	83 c2 08             	add    $0x8,%edx
ffffffff80100871:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100877:	eb 12                	jmp    ffffffff8010088b <cprintf+0x2cb>
ffffffff80100879:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100880:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100884:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010088b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010088e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffffffff80100895:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
ffffffff8010089c:	00 
ffffffff8010089d:	75 29                	jne    ffffffff801008c8 <cprintf+0x308>
        s = "(null)";
ffffffff8010089f:	48 c7 85 40 ff ff ff 	movq   $0xffffffff80109b47,-0xc0(%rbp)
ffffffff801008a6:	47 9b 10 80 
      for(; *s; s++)
ffffffff801008aa:	eb 1c                	jmp    ffffffff801008c8 <cprintf+0x308>
        consputc(*s);
ffffffff801008ac:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffffffff801008b3:	0f b6 00             	movzbl (%rax),%eax
ffffffff801008b6:	0f be c0             	movsbl %al,%eax
ffffffff801008b9:	89 c7                	mov    %eax,%edi
ffffffff801008bb:	e8 ce 02 00 00       	call   ffffffff80100b8e <consputc>
      for(; *s; s++)
ffffffff801008c0:	48 83 85 40 ff ff ff 	addq   $0x1,-0xc0(%rbp)
ffffffff801008c7:	01 
ffffffff801008c8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffffffff801008cf:	0f b6 00             	movzbl (%rax),%eax
ffffffff801008d2:	84 c0                	test   %al,%al
ffffffff801008d4:	75 d6                	jne    ffffffff801008ac <cprintf+0x2ec>
      break;
ffffffff801008d6:	eb 24                	jmp    ffffffff801008fc <cprintf+0x33c>
    case '%':
      consputc('%');
ffffffff801008d8:	bf 25 00 00 00       	mov    $0x25,%edi
ffffffff801008dd:	e8 ac 02 00 00       	call   ffffffff80100b8e <consputc>
      break;
ffffffff801008e2:	eb 18                	jmp    ffffffff801008fc <cprintf+0x33c>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
ffffffff801008e4:	bf 25 00 00 00       	mov    $0x25,%edi
ffffffff801008e9:	e8 a0 02 00 00       	call   ffffffff80100b8e <consputc>
      consputc(c);
ffffffff801008ee:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffffffff801008f4:	89 c7                	mov    %eax,%edi
ffffffff801008f6:	e8 93 02 00 00       	call   ffffffff80100b8e <consputc>
      break;
ffffffff801008fb:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
ffffffff801008fc:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffffffff80100903:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffffffff80100909:	48 63 d0             	movslq %eax,%rdx
ffffffff8010090c:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffffffff80100913:	48 01 d0             	add    %rdx,%rax
ffffffff80100916:	0f b6 00             	movzbl (%rax),%eax
ffffffff80100919:	0f be c0             	movsbl %al,%eax
ffffffff8010091c:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff80100921:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffffffff80100927:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffffffff8010092e:	0f 85 5c fd ff ff    	jne    ffffffff80100690 <cprintf+0xd0>
ffffffff80100934:	eb 01                	jmp    ffffffff80100937 <cprintf+0x377>
      break;
ffffffff80100936:	90                   	nop
    }
  }

  if(locking)
ffffffff80100937:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffffffff8010093e:	74 0c                	je     ffffffff8010094c <cprintf+0x38c>
    release(&cons.lock);
ffffffff80100940:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100947:	e8 42 55 00 00       	call   ffffffff80105e8e <release>
}
ffffffff8010094c:	90                   	nop
ffffffff8010094d:	c9                   	leave
ffffffff8010094e:	c3                   	ret

ffffffff8010094f <panic>:

void
panic(char *s)
{
ffffffff8010094f:	f3 0f 1e fa          	endbr64
ffffffff80100953:	55                   	push   %rbp
ffffffff80100954:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100957:	48 83 ec 70          	sub    $0x70,%rsp
ffffffff8010095b:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
  int i;
  uintp pcs[10];
  
  cli();
ffffffff8010095f:	e8 52 fb ff ff       	call   ffffffff801004b6 <cli>
  cons.locking = 0;
ffffffff80100964:	c7 05 1a d0 00 00 00 	movl   $0x0,0xd01a(%rip)        # ffffffff8010d988 <cons+0x68>
ffffffff8010096b:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
ffffffff8010096e:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80100975:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80100979:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010097c:	0f b6 c0             	movzbl %al,%eax
ffffffff8010097f:	89 c6                	mov    %eax,%esi
ffffffff80100981:	48 c7 c7 4e 9b 10 80 	mov    $0xffffffff80109b4e,%rdi
ffffffff80100988:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010098d:	e8 2e fc ff ff       	call   ffffffff801005c0 <cprintf>
  cprintf(s);
ffffffff80100992:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffffffff80100996:	48 89 c7             	mov    %rax,%rdi
ffffffff80100999:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010099e:	e8 1d fc ff ff       	call   ffffffff801005c0 <cprintf>
  cprintf("\n");
ffffffff801009a3:	48 c7 c7 5d 9b 10 80 	mov    $0xffffffff80109b5d,%rdi
ffffffff801009aa:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801009af:	e8 0c fc ff ff       	call   ffffffff801005c0 <cprintf>
  getcallerpcs(&s, pcs);
ffffffff801009b4:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffffffff801009b8:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffffffff801009bc:	48 89 d6             	mov    %rdx,%rsi
ffffffff801009bf:	48 89 c7             	mov    %rax,%rdi
ffffffff801009c2:	e8 24 55 00 00       	call   ffffffff80105eeb <getcallerpcs>
  for(i=0; i<10; i++)
ffffffff801009c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801009ce:	eb 22                	jmp    ffffffff801009f2 <panic+0xa3>
    cprintf(" %p", pcs[i]);
ffffffff801009d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801009d3:	48 98                	cltq
ffffffff801009d5:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffffffff801009da:	48 89 c6             	mov    %rax,%rsi
ffffffff801009dd:	48 c7 c7 5f 9b 10 80 	mov    $0xffffffff80109b5f,%rdi
ffffffff801009e4:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801009e9:	e8 d2 fb ff ff       	call   ffffffff801005c0 <cprintf>
  for(i=0; i<10; i++)
ffffffff801009ee:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801009f2:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff801009f6:	7e d8                	jle    ffffffff801009d0 <panic+0x81>
  panicked = 1; // freeze other CPU
ffffffff801009f8:	c7 05 16 cf 00 00 01 	movl   $0x1,0xcf16(%rip)        # ffffffff8010d918 <panicked>
ffffffff801009ff:	00 00 00 
  for(;;)
ffffffff80100a02:	90                   	nop
ffffffff80100a03:	eb fd                	jmp    ffffffff80100a02 <panic+0xb3>

ffffffff80100a05 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
ffffffff80100a05:	f3 0f 1e fa          	endbr64
ffffffff80100a09:	55                   	push   %rbp
ffffffff80100a0a:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100a0d:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80100a11:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
ffffffff80100a14:	be 0e 00 00 00       	mov    $0xe,%esi
ffffffff80100a19:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100a1e:	e8 25 fa ff ff       	call   ffffffff80100448 <outb>
  pos = inb(CRTPORT+1) << 8;
ffffffff80100a23:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100a28:	e8 fd f9 ff ff       	call   ffffffff8010042a <inb>
ffffffff80100a2d:	0f b6 c0             	movzbl %al,%eax
ffffffff80100a30:	c1 e0 08             	shl    $0x8,%eax
ffffffff80100a33:	89 45 fc             	mov    %eax,-0x4(%rbp)
  outb(CRTPORT, 15);
ffffffff80100a36:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80100a3b:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100a40:	e8 03 fa ff ff       	call   ffffffff80100448 <outb>
  pos |= inb(CRTPORT+1);
ffffffff80100a45:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100a4a:	e8 db f9 ff ff       	call   ffffffff8010042a <inb>
ffffffff80100a4f:	0f b6 c0             	movzbl %al,%eax
ffffffff80100a52:	09 45 fc             	or     %eax,-0x4(%rbp)

  if(c == '\n')
ffffffff80100a55:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffffffff80100a59:	75 37                	jne    ffffffff80100a92 <cgaputc+0x8d>
    pos += 80 - pos%80;
ffffffff80100a5b:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80100a5e:	48 63 c1             	movslq %ecx,%rax
ffffffff80100a61:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
ffffffff80100a68:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80100a6c:	89 c2                	mov    %eax,%edx
ffffffff80100a6e:	c1 fa 05             	sar    $0x5,%edx
ffffffff80100a71:	89 c8                	mov    %ecx,%eax
ffffffff80100a73:	c1 f8 1f             	sar    $0x1f,%eax
ffffffff80100a76:	29 c2                	sub    %eax,%edx
ffffffff80100a78:	89 d0                	mov    %edx,%eax
ffffffff80100a7a:	c1 e0 02             	shl    $0x2,%eax
ffffffff80100a7d:	01 d0                	add    %edx,%eax
ffffffff80100a7f:	c1 e0 04             	shl    $0x4,%eax
ffffffff80100a82:	29 c1                	sub    %eax,%ecx
ffffffff80100a84:	89 ca                	mov    %ecx,%edx
ffffffff80100a86:	b8 50 00 00 00       	mov    $0x50,%eax
ffffffff80100a8b:	29 d0                	sub    %edx,%eax
ffffffff80100a8d:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff80100a90:	eb 3d                	jmp    ffffffff80100acf <cgaputc+0xca>
  else if(c == BACKSPACE){
ffffffff80100a92:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffffffff80100a99:	75 0c                	jne    ffffffff80100aa7 <cgaputc+0xa2>
    if(pos > 0) --pos;
ffffffff80100a9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100a9f:	7e 2e                	jle    ffffffff80100acf <cgaputc+0xca>
ffffffff80100aa1:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffffffff80100aa5:	eb 28                	jmp    ffffffff80100acf <cgaputc+0xca>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
ffffffff80100aa7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80100aaa:	0f b6 c0             	movzbl %al,%eax
ffffffff80100aad:	80 cc 07             	or     $0x7,%ah
ffffffff80100ab0:	89 c6                	mov    %eax,%esi
ffffffff80100ab2:	48 8b 0d 5f a5 00 00 	mov    0xa55f(%rip),%rcx        # ffffffff8010b018 <crt>
ffffffff80100ab9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100abc:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100abf:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100ac2:	48 98                	cltq
ffffffff80100ac4:	48 01 c0             	add    %rax,%rax
ffffffff80100ac7:	48 01 c8             	add    %rcx,%rax
ffffffff80100aca:	89 f2                	mov    %esi,%edx
ffffffff80100acc:	66 89 10             	mov    %dx,(%rax)
  
  if((pos/80) >= 24){  // Scroll up.
ffffffff80100acf:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffffffff80100ad6:	7e 56                	jle    ffffffff80100b2e <cgaputc+0x129>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
ffffffff80100ad8:	48 8b 05 39 a5 00 00 	mov    0xa539(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100adf:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffffffff80100ae6:	48 8b 05 2b a5 00 00 	mov    0xa52b(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100aed:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffffffff80100af2:	48 89 ce             	mov    %rcx,%rsi
ffffffff80100af5:	48 89 c7             	mov    %rax,%rdi
ffffffff80100af8:	e8 39 57 00 00       	call   ffffffff80106236 <memmove>
    pos -= 80;
ffffffff80100afd:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffffffff80100b01:	b8 80 07 00 00       	mov    $0x780,%eax
ffffffff80100b06:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80100b09:	48 98                	cltq
ffffffff80100b0b:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffffffff80100b0e:	48 8b 05 03 a5 00 00 	mov    0xa503(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100b15:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80100b18:	48 63 c9             	movslq %ecx,%rcx
ffffffff80100b1b:	48 01 c9             	add    %rcx,%rcx
ffffffff80100b1e:	48 01 c8             	add    %rcx,%rax
ffffffff80100b21:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100b26:	48 89 c7             	mov    %rax,%rdi
ffffffff80100b29:	e8 11 56 00 00       	call   ffffffff8010613f <memset>
  }
  
  outb(CRTPORT, 14);
ffffffff80100b2e:	be 0e 00 00 00       	mov    $0xe,%esi
ffffffff80100b33:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100b38:	e8 0b f9 ff ff       	call   ffffffff80100448 <outb>
  outb(CRTPORT+1, pos>>8);
ffffffff80100b3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100b40:	c1 f8 08             	sar    $0x8,%eax
ffffffff80100b43:	0f b6 c0             	movzbl %al,%eax
ffffffff80100b46:	89 c6                	mov    %eax,%esi
ffffffff80100b48:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100b4d:	e8 f6 f8 ff ff       	call   ffffffff80100448 <outb>
  outb(CRTPORT, 15);
ffffffff80100b52:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80100b57:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100b5c:	e8 e7 f8 ff ff       	call   ffffffff80100448 <outb>
  outb(CRTPORT+1, pos);
ffffffff80100b61:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100b64:	0f b6 c0             	movzbl %al,%eax
ffffffff80100b67:	89 c6                	mov    %eax,%esi
ffffffff80100b69:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100b6e:	e8 d5 f8 ff ff       	call   ffffffff80100448 <outb>
  crt[pos] = ' ' | 0x0700;
ffffffff80100b73:	48 8b 05 9e a4 00 00 	mov    0xa49e(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100b7a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80100b7d:	48 63 d2             	movslq %edx,%rdx
ffffffff80100b80:	48 01 d2             	add    %rdx,%rdx
ffffffff80100b83:	48 01 d0             	add    %rdx,%rax
ffffffff80100b86:	66 c7 00 20 07       	movw   $0x720,(%rax)
}
ffffffff80100b8b:	90                   	nop
ffffffff80100b8c:	c9                   	leave
ffffffff80100b8d:	c3                   	ret

ffffffff80100b8e <consputc>:

void
consputc(int c)
{
ffffffff80100b8e:	f3 0f 1e fa          	endbr64
ffffffff80100b92:	55                   	push   %rbp
ffffffff80100b93:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100b96:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80100b9a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if(panicked){
ffffffff80100b9d:	8b 05 75 cd 00 00    	mov    0xcd75(%rip),%eax        # ffffffff8010d918 <panicked>
ffffffff80100ba3:	85 c0                	test   %eax,%eax
ffffffff80100ba5:	74 08                	je     ffffffff80100baf <consputc+0x21>
    cli();
ffffffff80100ba7:	e8 0a f9 ff ff       	call   ffffffff801004b6 <cli>
    for(;;)
ffffffff80100bac:	90                   	nop
ffffffff80100bad:	eb fd                	jmp    ffffffff80100bac <consputc+0x1e>
      ;
  }

  if(c == BACKSPACE){
ffffffff80100baf:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffffffff80100bb6:	75 20                	jne    ffffffff80100bd8 <consputc+0x4a>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffffffff80100bb8:	bf 08 00 00 00       	mov    $0x8,%edi
ffffffff80100bbd:	e8 45 73 00 00       	call   ffffffff80107f07 <uartputc>
ffffffff80100bc2:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80100bc7:	e8 3b 73 00 00       	call   ffffffff80107f07 <uartputc>
ffffffff80100bcc:	bf 08 00 00 00       	mov    $0x8,%edi
ffffffff80100bd1:	e8 31 73 00 00       	call   ffffffff80107f07 <uartputc>
ffffffff80100bd6:	eb 0a                	jmp    ffffffff80100be2 <consputc+0x54>
  } else
    uartputc(c);
ffffffff80100bd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100bdb:	89 c7                	mov    %eax,%edi
ffffffff80100bdd:	e8 25 73 00 00       	call   ffffffff80107f07 <uartputc>
  cgaputc(c);
ffffffff80100be2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100be5:	89 c7                	mov    %eax,%edi
ffffffff80100be7:	e8 19 fe ff ff       	call   ffffffff80100a05 <cgaputc>
}
ffffffff80100bec:	90                   	nop
ffffffff80100bed:	c9                   	leave
ffffffff80100bee:	c3                   	ret

ffffffff80100bef <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
ffffffff80100bef:	f3 0f 1e fa          	endbr64
ffffffff80100bf3:	55                   	push   %rbp
ffffffff80100bf4:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100bf7:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80100bfb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffffffff80100bff:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100c06:	e8 a8 51 00 00       	call   ffffffff80105db3 <acquire>
  while((c = getc()) >= 0){
ffffffff80100c0b:	e9 7b 01 00 00       	jmp    ffffffff80100d8b <consoleintr+0x19c>
    switch(c){
ffffffff80100c10:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80100c14:	0f 84 a4 00 00 00    	je     ffffffff80100cbe <consoleintr+0xcf>
ffffffff80100c1a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80100c1e:	0f 8f cc 00 00 00    	jg     ffffffff80100cf0 <consoleintr+0x101>
ffffffff80100c24:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffffffff80100c28:	74 2b                	je     ffffffff80100c55 <consoleintr+0x66>
ffffffff80100c2a:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffffffff80100c2e:	0f 8f bc 00 00 00    	jg     ffffffff80100cf0 <consoleintr+0x101>
ffffffff80100c34:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffffffff80100c38:	74 52                	je     ffffffff80100c8c <consoleintr+0x9d>
ffffffff80100c3a:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffffffff80100c3e:	0f 8f ac 00 00 00    	jg     ffffffff80100cf0 <consoleintr+0x101>
ffffffff80100c44:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffffffff80100c48:	74 74                	je     ffffffff80100cbe <consoleintr+0xcf>
ffffffff80100c4a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffffffff80100c4e:	74 19                	je     ffffffff80100c69 <consoleintr+0x7a>
ffffffff80100c50:	e9 9b 00 00 00       	jmp    ffffffff80100cf0 <consoleintr+0x101>
    case C('Z'): // reboot
      lidt(0,0);
ffffffff80100c55:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100c5a:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80100c5f:	e8 03 f8 ff ff       	call   ffffffff80100467 <lidt>
      break;
ffffffff80100c64:	e9 22 01 00 00       	jmp    ffffffff80100d8b <consoleintr+0x19c>
    case C('P'):  // Process listing.
      procdump();
ffffffff80100c69:	e8 87 4f 00 00       	call   ffffffff80105bf5 <procdump>
      break;
ffffffff80100c6e:	e9 18 01 00 00       	jmp    ffffffff80100d8b <consoleintr+0x19c>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffffffff80100c73:	8b 05 97 cc 00 00    	mov    0xcc97(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100c79:	83 e8 01             	sub    $0x1,%eax
ffffffff80100c7c:	89 05 8e cc 00 00    	mov    %eax,0xcc8e(%rip)        # ffffffff8010d910 <input+0xf0>
        consputc(BACKSPACE);
ffffffff80100c82:	bf 00 01 00 00       	mov    $0x100,%edi
ffffffff80100c87:	e8 02 ff ff ff       	call   ffffffff80100b8e <consputc>
      while(input.e != input.w &&
ffffffff80100c8c:	8b 15 7e cc 00 00    	mov    0xcc7e(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100c92:	8b 05 74 cc 00 00    	mov    0xcc74(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100c98:	39 c2                	cmp    %eax,%edx
ffffffff80100c9a:	0f 84 e4 00 00 00    	je     ffffffff80100d84 <consoleintr+0x195>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffffffff80100ca0:	8b 05 6a cc 00 00    	mov    0xcc6a(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100ca6:	83 e8 01             	sub    $0x1,%eax
ffffffff80100ca9:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100cac:	89 c0                	mov    %eax,%eax
ffffffff80100cae:	0f b6 80 88 d8 10 80 	movzbl -0x7fef2778(%rax),%eax
      while(input.e != input.w &&
ffffffff80100cb5:	3c 0a                	cmp    $0xa,%al
ffffffff80100cb7:	75 ba                	jne    ffffffff80100c73 <consoleintr+0x84>
      }
      break;
ffffffff80100cb9:	e9 c6 00 00 00       	jmp    ffffffff80100d84 <consoleintr+0x195>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
ffffffff80100cbe:	8b 15 4c cc 00 00    	mov    0xcc4c(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100cc4:	8b 05 42 cc 00 00    	mov    0xcc42(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100cca:	39 c2                	cmp    %eax,%edx
ffffffff80100ccc:	0f 84 b5 00 00 00    	je     ffffffff80100d87 <consoleintr+0x198>
        input.e--;
ffffffff80100cd2:	8b 05 38 cc 00 00    	mov    0xcc38(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100cd8:	83 e8 01             	sub    $0x1,%eax
ffffffff80100cdb:	89 05 2f cc 00 00    	mov    %eax,0xcc2f(%rip)        # ffffffff8010d910 <input+0xf0>
        consputc(BACKSPACE);
ffffffff80100ce1:	bf 00 01 00 00       	mov    $0x100,%edi
ffffffff80100ce6:	e8 a3 fe ff ff       	call   ffffffff80100b8e <consputc>
      }
      break;
ffffffff80100ceb:	e9 97 00 00 00       	jmp    ffffffff80100d87 <consoleintr+0x198>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
ffffffff80100cf0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100cf4:	0f 84 90 00 00 00    	je     ffffffff80100d8a <consoleintr+0x19b>
ffffffff80100cfa:	8b 15 10 cc 00 00    	mov    0xcc10(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100d00:	8b 05 02 cc 00 00    	mov    0xcc02(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100d06:	29 c2                	sub    %eax,%edx
ffffffff80100d08:	83 fa 7f             	cmp    $0x7f,%edx
ffffffff80100d0b:	77 7d                	ja     ffffffff80100d8a <consoleintr+0x19b>
        c = (c == '\r') ? '\n' : c;
ffffffff80100d0d:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffffffff80100d11:	74 05                	je     ffffffff80100d18 <consoleintr+0x129>
ffffffff80100d13:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100d16:	eb 05                	jmp    ffffffff80100d1d <consoleintr+0x12e>
ffffffff80100d18:	b8 0a 00 00 00       	mov    $0xa,%eax
ffffffff80100d1d:	89 45 fc             	mov    %eax,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffffffff80100d20:	8b 05 ea cb 00 00    	mov    0xcbea(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100d26:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100d29:	89 15 e1 cb 00 00    	mov    %edx,0xcbe1(%rip)        # ffffffff8010d910 <input+0xf0>
ffffffff80100d2f:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100d32:	89 c1                	mov    %eax,%ecx
ffffffff80100d34:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100d37:	89 c2                	mov    %eax,%edx
ffffffff80100d39:	89 c8                	mov    %ecx,%eax
ffffffff80100d3b:	88 90 88 d8 10 80    	mov    %dl,-0x7fef2778(%rax)
        consputc(c);
ffffffff80100d41:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100d44:	89 c7                	mov    %eax,%edi
ffffffff80100d46:	e8 43 fe ff ff       	call   ffffffff80100b8e <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
ffffffff80100d4b:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffffffff80100d4f:	74 19                	je     ffffffff80100d6a <consoleintr+0x17b>
ffffffff80100d51:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffffffff80100d55:	74 13                	je     ffffffff80100d6a <consoleintr+0x17b>
ffffffff80100d57:	8b 15 b3 cb 00 00    	mov    0xcbb3(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100d5d:	8b 05 a5 cb 00 00    	mov    0xcba5(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100d63:	83 e8 80             	sub    $0xffffff80,%eax
ffffffff80100d66:	39 c2                	cmp    %eax,%edx
ffffffff80100d68:	75 20                	jne    ffffffff80100d8a <consoleintr+0x19b>
          input.w = input.e;
ffffffff80100d6a:	8b 05 a0 cb 00 00    	mov    0xcba0(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100d70:	89 05 96 cb 00 00    	mov    %eax,0xcb96(%rip)        # ffffffff8010d90c <input+0xec>
          wakeup(&input.r);
ffffffff80100d76:	48 c7 c7 08 d9 10 80 	mov    $0xffffffff8010d908,%rdi
ffffffff80100d7d:	e8 b1 4d 00 00       	call   ffffffff80105b33 <wakeup>
        }
      }
      break;
ffffffff80100d82:	eb 06                	jmp    ffffffff80100d8a <consoleintr+0x19b>
      break;
ffffffff80100d84:	90                   	nop
ffffffff80100d85:	eb 04                	jmp    ffffffff80100d8b <consoleintr+0x19c>
      break;
ffffffff80100d87:	90                   	nop
ffffffff80100d88:	eb 01                	jmp    ffffffff80100d8b <consoleintr+0x19c>
      break;
ffffffff80100d8a:	90                   	nop
  while((c = getc()) >= 0){
ffffffff80100d8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100d8f:	ff d0                	call   *%rax
ffffffff80100d91:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80100d94:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100d98:	0f 89 72 fe ff ff    	jns    ffffffff80100c10 <consoleintr+0x21>
    }
  }
  release(&input.lock);
ffffffff80100d9e:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100da5:	e8 e4 50 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80100daa:	90                   	nop
ffffffff80100dab:	c9                   	leave
ffffffff80100dac:	c3                   	ret

ffffffff80100dad <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
ffffffff80100dad:	f3 0f 1e fa          	endbr64
ffffffff80100db1:	55                   	push   %rbp
ffffffff80100db2:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100db5:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80100db9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80100dbd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80100dc1:	89 55 dc             	mov    %edx,-0x24(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffffffff80100dc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100dc8:	48 89 c7             	mov    %rax,%rdi
ffffffff80100dcb:	e8 bd 12 00 00       	call   ffffffff8010208d <iunlock>
  target = n;
ffffffff80100dd0:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100dd3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffffffff80100dd6:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100ddd:	e8 d1 4f 00 00       	call   ffffffff80105db3 <acquire>
  while(n > 0){
ffffffff80100de2:	e9 b2 00 00 00       	jmp    ffffffff80100e99 <consoleread+0xec>
    while(input.r == input.w){
      if(proc->killed){
ffffffff80100de7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80100dee:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80100df2:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80100df5:	85 c0                	test   %eax,%eax
ffffffff80100df7:	74 22                	je     ffffffff80100e1b <consoleread+0x6e>
        release(&input.lock);
ffffffff80100df9:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100e00:	e8 89 50 00 00       	call   ffffffff80105e8e <release>
        ilock(ip);
ffffffff80100e05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100e09:	48 89 c7             	mov    %rax,%rdi
ffffffff80100e0c:	e8 07 11 00 00       	call   ffffffff80101f18 <ilock>
        return -1;
ffffffff80100e11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80100e16:	e9 ac 00 00 00       	jmp    ffffffff80100ec7 <consoleread+0x11a>
      }
      sleep(&input.r, &input.lock);
ffffffff80100e1b:	48 c7 c6 20 d8 10 80 	mov    $0xffffffff8010d820,%rsi
ffffffff80100e22:	48 c7 c7 08 d9 10 80 	mov    $0xffffffff8010d908,%rdi
ffffffff80100e29:	e8 e9 4b 00 00       	call   ffffffff80105a17 <sleep>
    while(input.r == input.w){
ffffffff80100e2e:	8b 15 d4 ca 00 00    	mov    0xcad4(%rip),%edx        # ffffffff8010d908 <input+0xe8>
ffffffff80100e34:	8b 05 d2 ca 00 00    	mov    0xcad2(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100e3a:	39 c2                	cmp    %eax,%edx
ffffffff80100e3c:	74 a9                	je     ffffffff80100de7 <consoleread+0x3a>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffffffff80100e3e:	8b 05 c4 ca 00 00    	mov    0xcac4(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100e44:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100e47:	89 15 bb ca 00 00    	mov    %edx,0xcabb(%rip)        # ffffffff8010d908 <input+0xe8>
ffffffff80100e4d:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100e50:	89 c0                	mov    %eax,%eax
ffffffff80100e52:	0f b6 80 88 d8 10 80 	movzbl -0x7fef2778(%rax),%eax
ffffffff80100e59:	0f be c0             	movsbl %al,%eax
ffffffff80100e5c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(c == C('D')){  // EOF
ffffffff80100e5f:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffffffff80100e63:	75 19                	jne    ffffffff80100e7e <consoleread+0xd1>
      if(n < target){
ffffffff80100e65:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100e68:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffffffff80100e6b:	73 34                	jae    ffffffff80100ea1 <consoleread+0xf4>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffffffff80100e6d:	8b 05 95 ca 00 00    	mov    0xca95(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100e73:	83 e8 01             	sub    $0x1,%eax
ffffffff80100e76:	89 05 8c ca 00 00    	mov    %eax,0xca8c(%rip)        # ffffffff8010d908 <input+0xe8>
      }
      break;
ffffffff80100e7c:	eb 23                	jmp    ffffffff80100ea1 <consoleread+0xf4>
    }
    *dst++ = c;
ffffffff80100e7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80100e82:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffffffff80100e86:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffffffff80100e8a:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff80100e8d:	88 10                	mov    %dl,(%rax)
    --n;
ffffffff80100e8f:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
    if(c == '\n')
ffffffff80100e93:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffffffff80100e97:	74 0b                	je     ffffffff80100ea4 <consoleread+0xf7>
  while(n > 0){
ffffffff80100e99:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80100e9d:	7f 8f                	jg     ffffffff80100e2e <consoleread+0x81>
ffffffff80100e9f:	eb 04                	jmp    ffffffff80100ea5 <consoleread+0xf8>
      break;
ffffffff80100ea1:	90                   	nop
ffffffff80100ea2:	eb 01                	jmp    ffffffff80100ea5 <consoleread+0xf8>
      break;
ffffffff80100ea4:	90                   	nop
  }
  release(&input.lock);
ffffffff80100ea5:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100eac:	e8 dd 4f 00 00       	call   ffffffff80105e8e <release>
  ilock(ip);
ffffffff80100eb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100eb5:	48 89 c7             	mov    %rax,%rdi
ffffffff80100eb8:	e8 5b 10 00 00       	call   ffffffff80101f18 <ilock>

  return target - n;
ffffffff80100ebd:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100ec0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80100ec3:	29 c2                	sub    %eax,%edx
ffffffff80100ec5:	89 d0                	mov    %edx,%eax
}
ffffffff80100ec7:	c9                   	leave
ffffffff80100ec8:	c3                   	ret

ffffffff80100ec9 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
ffffffff80100ec9:	f3 0f 1e fa          	endbr64
ffffffff80100ecd:	55                   	push   %rbp
ffffffff80100ece:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100ed1:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80100ed5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80100ed9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80100edd:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  iunlock(ip);
ffffffff80100ee0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100ee4:	48 89 c7             	mov    %rax,%rdi
ffffffff80100ee7:	e8 a1 11 00 00       	call   ffffffff8010208d <iunlock>
  acquire(&cons.lock);
ffffffff80100eec:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100ef3:	e8 bb 4e 00 00       	call   ffffffff80105db3 <acquire>
  for(i = 0; i < n; i++)
ffffffff80100ef8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80100eff:	eb 21                	jmp    ffffffff80100f22 <consolewrite+0x59>
    consputc(buf[i] & 0xff);
ffffffff80100f01:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100f04:	48 63 d0             	movslq %eax,%rdx
ffffffff80100f07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80100f0b:	48 01 d0             	add    %rdx,%rax
ffffffff80100f0e:	0f b6 00             	movzbl (%rax),%eax
ffffffff80100f11:	0f be c0             	movsbl %al,%eax
ffffffff80100f14:	0f b6 c0             	movzbl %al,%eax
ffffffff80100f17:	89 c7                	mov    %eax,%edi
ffffffff80100f19:	e8 70 fc ff ff       	call   ffffffff80100b8e <consputc>
  for(i = 0; i < n; i++)
ffffffff80100f1e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80100f22:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100f25:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80100f28:	7c d7                	jl     ffffffff80100f01 <consolewrite+0x38>
  release(&cons.lock);
ffffffff80100f2a:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100f31:	e8 58 4f 00 00       	call   ffffffff80105e8e <release>
  ilock(ip);
ffffffff80100f36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100f3a:	48 89 c7             	mov    %rax,%rdi
ffffffff80100f3d:	e8 d6 0f 00 00       	call   ffffffff80101f18 <ilock>

  return n;
ffffffff80100f42:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff80100f45:	c9                   	leave
ffffffff80100f46:	c3                   	ret

ffffffff80100f47 <consoleinit>:

void
consoleinit(void)
{
ffffffff80100f47:	f3 0f 1e fa          	endbr64
ffffffff80100f4b:	55                   	push   %rbp
ffffffff80100f4c:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffffffff80100f4f:	48 c7 c6 63 9b 10 80 	mov    $0xffffffff80109b63,%rsi
ffffffff80100f56:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100f5d:	e8 18 4e 00 00       	call   ffffffff80105d7a <initlock>
  initlock(&input.lock, "input");
ffffffff80100f62:	48 c7 c6 6b 9b 10 80 	mov    $0xffffffff80109b6b,%rsi
ffffffff80100f69:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100f70:	e8 05 4e 00 00       	call   ffffffff80105d7a <initlock>

  devsw[CONSOLE].write = consolewrite;
ffffffff80100f75:	48 c7 05 38 ca 00 00 	movq   $0xffffffff80100ec9,0xca38(%rip)        # ffffffff8010d9b8 <devsw+0x18>
ffffffff80100f7c:	c9 0e 10 80 
  devsw[CONSOLE].read = consoleread;
ffffffff80100f80:	48 c7 05 25 ca 00 00 	movq   $0xffffffff80100dad,0xca25(%rip)        # ffffffff8010d9b0 <devsw+0x10>
ffffffff80100f87:	ad 0d 10 80 
  cons.locking = 1;
ffffffff80100f8b:	c7 05 f3 c9 00 00 01 	movl   $0x1,0xc9f3(%rip)        # ffffffff8010d988 <cons+0x68>
ffffffff80100f92:	00 00 00 

  picenable(IRQ_KBD);
ffffffff80100f95:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80100f9a:	e8 f4 39 00 00       	call   ffffffff80104993 <picenable>
  ioapicenable(IRQ_KBD, 0);
ffffffff80100f9f:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100fa4:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80100fa9:	e8 34 22 00 00       	call   ffffffff801031e2 <ioapicenable>
}
ffffffff80100fae:	90                   	nop
ffffffff80100faf:	5d                   	pop    %rbp
ffffffff80100fb0:	c3                   	ret

ffffffff80100fb1 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffffffff80100fb1:	f3 0f 1e fa          	endbr64
ffffffff80100fb5:	55                   	push   %rbp
ffffffff80100fb6:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100fb9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffffffff80100fc0:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffffffff80100fc7:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
ffffffff80100fce:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffffffff80100fd5:	48 89 c7             	mov    %rax,%rdi
ffffffff80100fd8:	e8 3e 1c 00 00       	call   ffffffff80102c1b <namei>
ffffffff80100fdd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffffffff80100fe1:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff80100fe6:	75 0a                	jne    ffffffff80100ff2 <exec+0x41>
    return -1;
ffffffff80100fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80100fed:	e9 c2 04 00 00       	jmp    ffffffff801014b4 <exec+0x503>
  ilock(ip);
ffffffff80100ff2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80100ff6:	48 89 c7             	mov    %rax,%rdi
ffffffff80100ff9:	e8 1a 0f 00 00       	call   ffffffff80101f18 <ilock>
  pgdir = 0;
ffffffff80100ffe:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffffffff80101005:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
ffffffff80101006:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffffffff8010100d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80101011:	b9 40 00 00 00       	mov    $0x40,%ecx
ffffffff80101016:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff8010101b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010101e:	e8 b9 14 00 00       	call   ffffffff801024dc <readi>
ffffffff80101023:	83 f8 3f             	cmp    $0x3f,%eax
ffffffff80101026:	0f 86 3e 04 00 00    	jbe    ffffffff8010146a <exec+0x4b9>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffffffff8010102c:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffffffff80101032:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffffffff80101037:	0f 85 30 04 00 00    	jne    ffffffff8010146d <exec+0x4bc>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffffffff8010103d:	e8 59 87 00 00       	call   ffffffff8010979b <setupkvm>
ffffffff80101042:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffffffff80101046:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff8010104b:	0f 84 1f 04 00 00    	je     ffffffff80101470 <exec+0x4bf>
    goto bad;

  // Load program into memory.
  sz = 0;
ffffffff80101051:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
ffffffff80101058:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffffffff80101059:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff80101060:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffffffff80101067:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff8010106a:	e9 c8 00 00 00       	jmp    ffffffff80101137 <exec+0x186>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffffffff8010106f:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80101072:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffffffff80101079:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010107d:	b9 38 00 00 00       	mov    $0x38,%ecx
ffffffff80101082:	48 89 c7             	mov    %rax,%rdi
ffffffff80101085:	e8 52 14 00 00       	call   ffffffff801024dc <readi>
ffffffff8010108a:	83 f8 38             	cmp    $0x38,%eax
ffffffff8010108d:	0f 85 e0 03 00 00    	jne    ffffffff80101473 <exec+0x4c2>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffffffff80101093:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffffffff80101099:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010109c:	0f 85 87 00 00 00    	jne    ffffffff80101129 <exec+0x178>
      continue;
    if(ph.memsz < ph.filesz)
ffffffff801010a2:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffffffff801010a9:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffffffff801010b0:	48 39 c2             	cmp    %rax,%rdx
ffffffff801010b3:	0f 82 bd 03 00 00    	jb     ffffffff80101476 <exec+0x4c5>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffffffff801010b9:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffffffff801010c0:	89 c2                	mov    %eax,%edx
ffffffff801010c2:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffffffff801010c9:	01 c2                	add    %eax,%edx
ffffffff801010cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801010cf:	89 c1                	mov    %eax,%ecx
ffffffff801010d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff801010d5:	89 ce                	mov    %ecx,%esi
ffffffff801010d7:	48 89 c7             	mov    %rax,%rdi
ffffffff801010da:	e8 aa 7c 00 00       	call   ffffffff80108d89 <allocuvm>
ffffffff801010df:	48 98                	cltq
ffffffff801010e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff801010e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff801010ea:	0f 84 89 03 00 00    	je     ffffffff80101479 <exec+0x4c8>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffffffff801010f0:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffffffff801010f7:	89 c7                	mov    %eax,%edi
ffffffff801010f9:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffffffff80101100:	89 c1                	mov    %eax,%ecx
ffffffff80101102:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffffffff80101109:	48 89 c6             	mov    %rax,%rsi
ffffffff8010110c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffffffff80101110:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101114:	41 89 f8             	mov    %edi,%r8d
ffffffff80101117:	48 89 c7             	mov    %rax,%rdi
ffffffff8010111a:	e8 6c 7b 00 00       	call   ffffffff80108c8b <loaduvm>
ffffffff8010111f:	85 c0                	test   %eax,%eax
ffffffff80101121:	0f 88 55 03 00 00    	js     ffffffff8010147c <exec+0x4cb>
ffffffff80101127:	eb 01                	jmp    ffffffff8010112a <exec+0x179>
      continue;
ffffffff80101129:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffffffff8010112a:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffffffff8010112e:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80101131:	83 c0 38             	add    $0x38,%eax
ffffffff80101134:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff80101137:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffffffff8010113e:	0f b7 c0             	movzwl %ax,%eax
ffffffff80101141:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80101144:	0f 8c 25 ff ff ff    	jl     ffffffff8010106f <exec+0xbe>
      goto bad;
  }
  iunlockput(ip);
ffffffff8010114a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010114e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101151:	e8 96 10 00 00       	call   ffffffff801021ec <iunlockput>
  ip = 0;
ffffffff80101156:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffffffff8010115d:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffffffff8010115e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101162:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80101168:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff8010116e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffffffff80101172:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101176:	8d 90 00 20 00 00    	lea    0x2000(%rax),%edx
ffffffff8010117c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101180:	89 c1                	mov    %eax,%ecx
ffffffff80101182:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101186:	89 ce                	mov    %ecx,%esi
ffffffff80101188:	48 89 c7             	mov    %rax,%rdi
ffffffff8010118b:	e8 f9 7b 00 00       	call   ffffffff80108d89 <allocuvm>
ffffffff80101190:	48 98                	cltq
ffffffff80101192:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff80101196:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff8010119b:	0f 84 de 02 00 00    	je     ffffffff8010147f <exec+0x4ce>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffffffff801011a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801011a5:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffffffff801011ab:	48 89 c2             	mov    %rax,%rdx
ffffffff801011ae:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff801011b2:	48 89 d6             	mov    %rdx,%rsi
ffffffff801011b5:	48 89 c7             	mov    %rax,%rdi
ffffffff801011b8:	e8 39 7e 00 00       	call   ffffffff80108ff6 <clearpteu>
  sp = sz;
ffffffff801011bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801011c1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffffffff801011c5:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffffffff801011cc:	00 
ffffffff801011cd:	e9 b5 00 00 00       	jmp    ffffffff80101287 <exec+0x2d6>
    if(argc >= MAXARG)
ffffffff801011d2:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffffffff801011d7:	0f 87 a5 02 00 00    	ja     ffffffff80101482 <exec+0x4d1>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(uintp)-1);
ffffffff801011dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801011e1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801011e8:	00 
ffffffff801011e9:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff801011f0:	48 01 d0             	add    %rdx,%rax
ffffffff801011f3:	48 8b 00             	mov    (%rax),%rax
ffffffff801011f6:	48 89 c7             	mov    %rax,%rdi
ffffffff801011f9:	e8 5b 52 00 00       	call   ffffffff80106459 <strlen>
ffffffff801011fe:	83 c0 01             	add    $0x1,%eax
ffffffff80101201:	48 98                	cltq
ffffffff80101203:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff80101207:	48 29 c2             	sub    %rax,%rdx
ffffffff8010120a:	48 89 d0             	mov    %rdx,%rax
ffffffff8010120d:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffffffff80101211:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffffffff80101215:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101219:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80101220:	00 
ffffffff80101221:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff80101228:	48 01 d0             	add    %rdx,%rax
ffffffff8010122b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010122e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101231:	e8 23 52 00 00       	call   ffffffff80106459 <strlen>
ffffffff80101236:	83 c0 01             	add    $0x1,%eax
ffffffff80101239:	89 c1                	mov    %eax,%ecx
ffffffff8010123b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010123f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80101246:	00 
ffffffff80101247:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff8010124e:	48 01 d0             	add    %rdx,%rax
ffffffff80101251:	48 8b 10             	mov    (%rax),%rdx
ffffffff80101254:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101258:	89 c6                	mov    %eax,%esi
ffffffff8010125a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff8010125e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101261:	e8 a2 7f 00 00       	call   ffffffff80109208 <copyout>
ffffffff80101266:	85 c0                	test   %eax,%eax
ffffffff80101268:	0f 88 17 02 00 00    	js     ffffffff80101485 <exec+0x4d4>
      goto bad;
    ustack[3+argc] = sp;
ffffffff8010126e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101272:	48 8d 50 03          	lea    0x3(%rax),%rdx
ffffffff80101276:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010127a:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffffffff80101281:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffffffff80101282:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffffffff80101287:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010128b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80101292:	00 
ffffffff80101293:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff8010129a:	48 01 d0             	add    %rdx,%rax
ffffffff8010129d:	48 8b 00             	mov    (%rax),%rax
ffffffff801012a0:	48 85 c0             	test   %rax,%rax
ffffffff801012a3:	0f 85 29 ff ff ff    	jne    ffffffff801011d2 <exec+0x221>
  }
  ustack[3+argc] = 0;
ffffffff801012a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801012ad:	48 83 c0 03          	add    $0x3,%rax
ffffffff801012b1:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffffffff801012b8:	ff 00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
ffffffff801012bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801012c2:	48 89 85 90 fe ff ff 	mov    %rax,-0x170(%rbp)
  ustack[1] = argc;
ffffffff801012c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801012cd:	48 89 85 98 fe ff ff 	mov    %rax,-0x168(%rbp)
  ustack[2] = sp - (argc+1)*sizeof(uintp);  // argv pointer
ffffffff801012d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801012d8:	48 83 c0 01          	add    $0x1,%rax
ffffffff801012dc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801012e3:	00 
ffffffff801012e4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801012e8:	48 29 d0             	sub    %rdx,%rax
ffffffff801012eb:	48 89 85 a0 fe ff ff 	mov    %rax,-0x160(%rbp)

#if X64
  proc->tf->rdi = argc;
ffffffff801012f2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801012f9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801012fd:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80101301:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80101305:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(uintp);
ffffffff80101309:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010130d:	48 83 c0 01          	add    $0x1,%rax
ffffffff80101311:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffffffff80101318:	00 
ffffffff80101319:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80101320:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80101324:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80101328:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff8010132c:	48 29 ca             	sub    %rcx,%rdx
ffffffff8010132f:	48 89 50 28          	mov    %rdx,0x28(%rax)
#endif

  sp -= (3+argc+1) * sizeof(uintp);
ffffffff80101333:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101337:	48 83 c0 04          	add    $0x4,%rax
ffffffff8010133b:	48 c1 e0 03          	shl    $0x3,%rax
ffffffff8010133f:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*sizeof(uintp)) < 0)
ffffffff80101343:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101347:	48 83 c0 04          	add    $0x4,%rax
ffffffff8010134b:	8d 0c c5 00 00 00 00 	lea    0x0(,%rax,8),%ecx
ffffffff80101352:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101356:	89 c6                	mov    %eax,%esi
ffffffff80101358:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffffffff8010135f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101363:	48 89 c7             	mov    %rax,%rdi
ffffffff80101366:	e8 9d 7e 00 00       	call   ffffffff80109208 <copyout>
ffffffff8010136b:	85 c0                	test   %eax,%eax
ffffffff8010136d:	0f 88 15 01 00 00    	js     ffffffff80101488 <exec+0x4d7>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffffffff80101373:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffffffff8010137a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010137e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101382:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80101386:	eb 1c                	jmp    ffffffff801013a4 <exec+0x3f3>
    if(*s == '/')
ffffffff80101388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010138c:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010138f:	3c 2f                	cmp    $0x2f,%al
ffffffff80101391:	75 0c                	jne    ffffffff8010139f <exec+0x3ee>
      last = s+1;
ffffffff80101393:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101397:	48 83 c0 01          	add    $0x1,%rax
ffffffff8010139b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffffffff8010139f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff801013a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801013a8:	0f b6 00             	movzbl (%rax),%eax
ffffffff801013ab:	84 c0                	test   %al,%al
ffffffff801013ad:	75 d9                	jne    ffffffff80101388 <exec+0x3d7>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffffffff801013af:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013b6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013ba:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff801013c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801013c5:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff801013ca:	48 89 c6             	mov    %rax,%rsi
ffffffff801013cd:	48 89 cf             	mov    %rcx,%rdi
ffffffff801013d0:	e8 1d 50 00 00       	call   ffffffff801063f2 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
ffffffff801013d5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013dc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013e0:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801013e4:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  proc->pgdir = pgdir;
ffffffff801013e8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013ef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013f3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffffffff801013f7:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffffffff801013fb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80101402:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80101406:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff8010140a:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->eip = elf.entry;  // main
ffffffff8010140d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80101414:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80101418:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010141c:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffffffff80101423:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->esp = sp;
ffffffff8010142a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80101431:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80101435:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80101439:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff8010143d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffffffff80101444:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010144b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010144f:	48 89 c7             	mov    %rax,%rdi
ffffffff80101452:	e8 1d 86 00 00       	call   ffffffff80109a74 <switchuvm>
  freevm(oldpgdir);
ffffffff80101457:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010145b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010145e:	e8 e5 7a 00 00       	call   ffffffff80108f48 <freevm>
  return 0;
ffffffff80101463:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101468:	eb 4a                	jmp    ffffffff801014b4 <exec+0x503>
    goto bad;
ffffffff8010146a:	90                   	nop
ffffffff8010146b:	eb 1c                	jmp    ffffffff80101489 <exec+0x4d8>
    goto bad;
ffffffff8010146d:	90                   	nop
ffffffff8010146e:	eb 19                	jmp    ffffffff80101489 <exec+0x4d8>
    goto bad;
ffffffff80101470:	90                   	nop
ffffffff80101471:	eb 16                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff80101473:	90                   	nop
ffffffff80101474:	eb 13                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff80101476:	90                   	nop
ffffffff80101477:	eb 10                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff80101479:	90                   	nop
ffffffff8010147a:	eb 0d                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff8010147c:	90                   	nop
ffffffff8010147d:	eb 0a                	jmp    ffffffff80101489 <exec+0x4d8>
    goto bad;
ffffffff8010147f:	90                   	nop
ffffffff80101480:	eb 07                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff80101482:	90                   	nop
ffffffff80101483:	eb 04                	jmp    ffffffff80101489 <exec+0x4d8>
      goto bad;
ffffffff80101485:	90                   	nop
ffffffff80101486:	eb 01                	jmp    ffffffff80101489 <exec+0x4d8>
    goto bad;
ffffffff80101488:	90                   	nop

 bad:
  if(pgdir)
ffffffff80101489:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff8010148e:	74 0c                	je     ffffffff8010149c <exec+0x4eb>
    freevm(pgdir);
ffffffff80101490:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101494:	48 89 c7             	mov    %rax,%rdi
ffffffff80101497:	e8 ac 7a 00 00       	call   ffffffff80108f48 <freevm>
  if(ip)
ffffffff8010149c:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff801014a1:	74 0c                	je     ffffffff801014af <exec+0x4fe>
    iunlockput(ip);
ffffffff801014a3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801014a7:	48 89 c7             	mov    %rax,%rdi
ffffffff801014aa:	e8 3d 0d 00 00       	call   ffffffff801021ec <iunlockput>
  return -1;
ffffffff801014af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801014b4:	c9                   	leave
ffffffff801014b5:	c3                   	ret

ffffffff801014b6 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffffffff801014b6:	f3 0f 1e fa          	endbr64
ffffffff801014ba:	55                   	push   %rbp
ffffffff801014bb:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffffffff801014be:	48 c7 c6 71 9b 10 80 	mov    $0xffffffff80109b71,%rsi
ffffffff801014c5:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801014cc:	e8 a9 48 00 00       	call   ffffffff80105d7a <initlock>
}
ffffffff801014d1:	90                   	nop
ffffffff801014d2:	5d                   	pop    %rbp
ffffffff801014d3:	c3                   	ret

ffffffff801014d4 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffffffff801014d4:	f3 0f 1e fa          	endbr64
ffffffff801014d8:	55                   	push   %rbp
ffffffff801014d9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801014dc:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffffffff801014e0:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801014e7:	e8 c7 48 00 00       	call   ffffffff80105db3 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffffffff801014ec:	48 c7 45 f8 a8 da 10 	movq   $0xffffffff8010daa8,-0x8(%rbp)
ffffffff801014f3:	80 
ffffffff801014f4:	eb 2d                	jmp    ffffffff80101523 <filealloc+0x4f>
    if(f->ref == 0){
ffffffff801014f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801014fa:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801014fd:	85 c0                	test   %eax,%eax
ffffffff801014ff:	75 1d                	jne    ffffffff8010151e <filealloc+0x4a>
      f->ref = 1;
ffffffff80101501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101505:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffffffff8010150c:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101513:	e8 76 49 00 00       	call   ffffffff80105e8e <release>
      return f;
ffffffff80101518:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010151c:	eb 23                	jmp    ffffffff80101541 <filealloc+0x6d>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffffffff8010151e:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffffffff80101523:	48 c7 c0 48 ea 10 80 	mov    $0xffffffff8010ea48,%rax
ffffffff8010152a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff8010152e:	72 c6                	jb     ffffffff801014f6 <filealloc+0x22>
    }
  }
  release(&ftable.lock);
ffffffff80101530:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101537:	e8 52 49 00 00       	call   ffffffff80105e8e <release>
  return 0;
ffffffff8010153c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80101541:	c9                   	leave
ffffffff80101542:	c3                   	ret

ffffffff80101543 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffffffff80101543:	f3 0f 1e fa          	endbr64
ffffffff80101547:	55                   	push   %rbp
ffffffff80101548:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010154b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010154f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffffffff80101553:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff8010155a:	e8 54 48 00 00       	call   ffffffff80105db3 <acquire>
  if(f->ref < 1)
ffffffff8010155f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101563:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101566:	85 c0                	test   %eax,%eax
ffffffff80101568:	7f 0c                	jg     ffffffff80101576 <filedup+0x33>
    panic("filedup");
ffffffff8010156a:	48 c7 c7 78 9b 10 80 	mov    $0xffffffff80109b78,%rdi
ffffffff80101571:	e8 d9 f3 ff ff       	call   ffffffff8010094f <panic>
  f->ref++;
ffffffff80101576:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010157a:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff8010157d:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101580:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101584:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffffffff80101587:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff8010158e:	e8 fb 48 00 00       	call   ffffffff80105e8e <release>
  return f;
ffffffff80101593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80101597:	c9                   	leave
ffffffff80101598:	c3                   	ret

ffffffff80101599 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffffffff80101599:	f3 0f 1e fa          	endbr64
ffffffff8010159d:	55                   	push   %rbp
ffffffff8010159e:	48 89 e5             	mov    %rsp,%rbp
ffffffff801015a1:	53                   	push   %rbx
ffffffff801015a2:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff801015a6:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffffffff801015aa:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801015b1:	e8 fd 47 00 00       	call   ffffffff80105db3 <acquire>
  if(f->ref < 1)
ffffffff801015b6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015ba:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801015bd:	85 c0                	test   %eax,%eax
ffffffff801015bf:	7f 0c                	jg     ffffffff801015cd <fileclose+0x34>
    panic("fileclose");
ffffffff801015c1:	48 c7 c7 80 9b 10 80 	mov    $0xffffffff80109b80,%rdi
ffffffff801015c8:	e8 82 f3 ff ff       	call   ffffffff8010094f <panic>
  if(--f->ref > 0){
ffffffff801015cd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015d1:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801015d4:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801015d7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015db:	89 50 04             	mov    %edx,0x4(%rax)
ffffffff801015de:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015e2:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801015e5:	85 c0                	test   %eax,%eax
ffffffff801015e7:	7e 11                	jle    ffffffff801015fa <fileclose+0x61>
    release(&ftable.lock);
ffffffff801015e9:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801015f0:	e8 99 48 00 00       	call   ffffffff80105e8e <release>
ffffffff801015f5:	e9 93 00 00 00       	jmp    ffffffff8010168d <fileclose+0xf4>
    return;
  }
  ff = *f;
ffffffff801015fa:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015fe:	48 8b 08             	mov    (%rax),%rcx
ffffffff80101601:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffffffff80101605:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffffffff80101609:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffffffff8010160d:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffffffff80101611:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffffffff80101615:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffffffff80101619:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffffffff8010161d:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff80101621:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffffffff80101625:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80101629:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffffffff80101630:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80101634:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffffffff8010163a:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101641:	e8 48 48 00 00       	call   ffffffff80105e8e <release>
  
  if(ff.type == FD_PIPE)
ffffffff80101646:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffffffff80101649:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010164c:	75 17                	jne    ffffffff80101665 <fileclose+0xcc>
    pipeclose(ff.pipe, ff.writable);
ffffffff8010164e:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffffffff80101652:	0f be d0             	movsbl %al,%edx
ffffffff80101655:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101659:	89 d6                	mov    %edx,%esi
ffffffff8010165b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010165e:	e8 ed 35 00 00       	call   ffffffff80104c50 <pipeclose>
ffffffff80101663:	eb 28                	jmp    ffffffff8010168d <fileclose+0xf4>
  else if(ff.type == FD_INODE){
ffffffff80101665:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffffffff80101668:	83 f8 02             	cmp    $0x2,%eax
ffffffff8010166b:	75 20                	jne    ffffffff8010168d <fileclose+0xf4>
    begin_trans();
ffffffff8010166d:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101672:	e8 f9 24 00 00       	call   ffffffff80103b70 <begin_trans>
    iput(ff.ip);
ffffffff80101677:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010167b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010167e:	e8 80 0a 00 00       	call   ffffffff80102103 <iput>
    commit_trans();
ffffffff80101683:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101688:	e8 2f 25 00 00       	call   ffffffff80103bbc <commit_trans>
  }
}
ffffffff8010168d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80101691:	c9                   	leave
ffffffff80101692:	c3                   	ret

ffffffff80101693 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffffffff80101693:	f3 0f 1e fa          	endbr64
ffffffff80101697:	55                   	push   %rbp
ffffffff80101698:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010169b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010169f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801016a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffffffff801016a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801016ab:	8b 00                	mov    (%rax),%eax
ffffffff801016ad:	83 f8 02             	cmp    $0x2,%eax
ffffffff801016b0:	75 3e                	jne    ffffffff801016f0 <filestat+0x5d>
    ilock(f->ip);
ffffffff801016b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801016b6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801016ba:	48 89 c7             	mov    %rax,%rdi
ffffffff801016bd:	e8 56 08 00 00       	call   ffffffff80101f18 <ilock>
    stati(f->ip, st);
ffffffff801016c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801016c6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801016ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801016ce:	48 89 d6             	mov    %rdx,%rsi
ffffffff801016d1:	48 89 c7             	mov    %rax,%rdi
ffffffff801016d4:	e8 a2 0d 00 00       	call   ffffffff8010247b <stati>
    iunlock(f->ip);
ffffffff801016d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801016dd:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801016e1:	48 89 c7             	mov    %rax,%rdi
ffffffff801016e4:	e8 a4 09 00 00       	call   ffffffff8010208d <iunlock>
    return 0;
ffffffff801016e9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801016ee:	eb 05                	jmp    ffffffff801016f5 <filestat+0x62>
  }
  return -1;
ffffffff801016f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801016f5:	c9                   	leave
ffffffff801016f6:	c3                   	ret

ffffffff801016f7 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffffffff801016f7:	f3 0f 1e fa          	endbr64
ffffffff801016fb:	55                   	push   %rbp
ffffffff801016fc:	48 89 e5             	mov    %rsp,%rbp
ffffffff801016ff:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80101703:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80101707:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010170b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffffffff8010170e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101712:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffffffff80101716:	84 c0                	test   %al,%al
ffffffff80101718:	75 0a                	jne    ffffffff80101724 <fileread+0x2d>
    return -1;
ffffffff8010171a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010171f:	e9 9d 00 00 00       	jmp    ffffffff801017c1 <fileread+0xca>
  if(f->type == FD_PIPE)
ffffffff80101724:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101728:	8b 00                	mov    (%rax),%eax
ffffffff8010172a:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010172d:	75 1c                	jne    ffffffff8010174b <fileread+0x54>
    return piperead(f->pipe, addr, n);
ffffffff8010172f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101733:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80101737:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff8010173a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff8010173e:	48 89 ce             	mov    %rcx,%rsi
ffffffff80101741:	48 89 c7             	mov    %rax,%rdi
ffffffff80101744:	e8 ca 36 00 00       	call   ffffffff80104e13 <piperead>
ffffffff80101749:	eb 76                	jmp    ffffffff801017c1 <fileread+0xca>
  if(f->type == FD_INODE){
ffffffff8010174b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010174f:	8b 00                	mov    (%rax),%eax
ffffffff80101751:	83 f8 02             	cmp    $0x2,%eax
ffffffff80101754:	75 5f                	jne    ffffffff801017b5 <fileread+0xbe>
    ilock(f->ip);
ffffffff80101756:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010175a:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010175e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101761:	e8 b2 07 00 00       	call   ffffffff80101f18 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffffffff80101766:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffffffff80101769:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010176d:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff80101770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101774:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101778:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffffffff8010177c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010177f:	e8 58 0d 00 00       	call   ffffffff801024dc <readi>
ffffffff80101784:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80101787:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010178b:	7e 13                	jle    ffffffff801017a0 <fileread+0xa9>
      f->off += r;
ffffffff8010178d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101791:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff80101794:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101797:	01 c2                	add    %eax,%edx
ffffffff80101799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010179d:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffffffff801017a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017a4:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801017a8:	48 89 c7             	mov    %rax,%rdi
ffffffff801017ab:	e8 dd 08 00 00       	call   ffffffff8010208d <iunlock>
    return r;
ffffffff801017b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801017b3:	eb 0c                	jmp    ffffffff801017c1 <fileread+0xca>
  }
  panic("fileread");
ffffffff801017b5:	48 c7 c7 8a 9b 10 80 	mov    $0xffffffff80109b8a,%rdi
ffffffff801017bc:	e8 8e f1 ff ff       	call   ffffffff8010094f <panic>
}
ffffffff801017c1:	c9                   	leave
ffffffff801017c2:	c3                   	ret

ffffffff801017c3 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffffffff801017c3:	f3 0f 1e fa          	endbr64
ffffffff801017c7:	55                   	push   %rbp
ffffffff801017c8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801017cb:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801017cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801017d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff801017d7:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffffffff801017da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017de:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffffffff801017e2:	84 c0                	test   %al,%al
ffffffff801017e4:	75 0a                	jne    ffffffff801017f0 <filewrite+0x2d>
    return -1;
ffffffff801017e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801017eb:	e9 29 01 00 00       	jmp    ffffffff80101919 <filewrite+0x156>
  if(f->type == FD_PIPE)
ffffffff801017f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017f4:	8b 00                	mov    (%rax),%eax
ffffffff801017f6:	83 f8 01             	cmp    $0x1,%eax
ffffffff801017f9:	75 1f                	jne    ffffffff8010181a <filewrite+0x57>
    return pipewrite(f->pipe, addr, n);
ffffffff801017fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017ff:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80101803:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff80101806:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff8010180a:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010180d:	48 89 c7             	mov    %rax,%rdi
ffffffff80101810:	e8 e8 34 00 00       	call   ffffffff80104cfd <pipewrite>
ffffffff80101815:	e9 ff 00 00 00       	jmp    ffffffff80101919 <filewrite+0x156>
  if(f->type == FD_INODE){
ffffffff8010181a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010181e:	8b 00                	mov    (%rax),%eax
ffffffff80101820:	83 f8 02             	cmp    $0x2,%eax
ffffffff80101823:	0f 85 e4 00 00 00    	jne    ffffffff8010190d <filewrite+0x14a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffffffff80101829:	c7 45 f4 00 06 00 00 	movl   $0x600,-0xc(%rbp)
    int i = 0;
ffffffff80101830:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffffffff80101837:	e9 ae 00 00 00       	jmp    ffffffff801018ea <filewrite+0x127>
      int n1 = n - i;
ffffffff8010183c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010183f:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80101842:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffffffff80101845:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101848:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffffffff8010184b:	7e 06                	jle    ffffffff80101853 <filewrite+0x90>
        n1 = max;
ffffffff8010184d:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101850:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_trans();
ffffffff80101853:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101858:	e8 13 23 00 00       	call   ffffffff80103b70 <begin_trans>
      ilock(f->ip);
ffffffff8010185d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101861:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101865:	48 89 c7             	mov    %rax,%rdi
ffffffff80101868:	e8 ab 06 00 00       	call   ffffffff80101f18 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffffffff8010186d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffffffff80101870:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101874:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff80101877:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010187a:	48 63 f0             	movslq %eax,%rsi
ffffffff8010187d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101881:	48 01 c6             	add    %rax,%rsi
ffffffff80101884:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101888:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010188c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010188f:	e8 d0 0d 00 00       	call   ffffffff80102664 <writei>
ffffffff80101894:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffffffff80101897:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffffffff8010189b:	7e 13                	jle    ffffffff801018b0 <filewrite+0xed>
        f->off += r;
ffffffff8010189d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801018a1:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff801018a4:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff801018a7:	01 c2                	add    %eax,%edx
ffffffff801018a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801018ad:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffffffff801018b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801018b4:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff801018b8:	48 89 c7             	mov    %rax,%rdi
ffffffff801018bb:	e8 cd 07 00 00       	call   ffffffff8010208d <iunlock>
      commit_trans();
ffffffff801018c0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801018c5:	e8 f2 22 00 00       	call   ffffffff80103bbc <commit_trans>

      if(r < 0)
ffffffff801018ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffffffff801018ce:	78 28                	js     ffffffff801018f8 <filewrite+0x135>
        break;
      if(r != n1)
ffffffff801018d0:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff801018d3:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffffffff801018d6:	74 0c                	je     ffffffff801018e4 <filewrite+0x121>
        panic("short filewrite");
ffffffff801018d8:	48 c7 c7 93 9b 10 80 	mov    $0xffffffff80109b93,%rdi
ffffffff801018df:	e8 6b f0 ff ff       	call   ffffffff8010094f <panic>
      i += r;
ffffffff801018e4:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff801018e7:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffffffff801018ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801018ed:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff801018f0:	0f 8c 46 ff ff ff    	jl     ffffffff8010183c <filewrite+0x79>
ffffffff801018f6:	eb 01                	jmp    ffffffff801018f9 <filewrite+0x136>
        break;
ffffffff801018f8:	90                   	nop
    }
    return i == n ? n : -1;
ffffffff801018f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801018fc:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff801018ff:	75 05                	jne    ffffffff80101906 <filewrite+0x143>
ffffffff80101901:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80101904:	eb 13                	jmp    ffffffff80101919 <filewrite+0x156>
ffffffff80101906:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010190b:	eb 0c                	jmp    ffffffff80101919 <filewrite+0x156>
  }
  panic("filewrite");
ffffffff8010190d:	48 c7 c7 a3 9b 10 80 	mov    $0xffffffff80109ba3,%rdi
ffffffff80101914:	e8 36 f0 ff ff       	call   ffffffff8010094f <panic>
}
ffffffff80101919:	c9                   	leave
ffffffff8010191a:	c3                   	ret

ffffffff8010191b <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffffffff8010191b:	f3 0f 1e fa          	endbr64
ffffffff8010191f:	55                   	push   %rbp
ffffffff80101920:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101923:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101927:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff8010192a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp;
  
  bp = bread(dev, 1);
ffffffff8010192e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80101931:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80101936:	89 c7                	mov    %eax,%edi
ffffffff80101938:	e8 a2 e9 ff ff       	call   ffffffff801002df <bread>
ffffffff8010193d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffffffff80101941:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101945:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff80101949:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010194d:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff80101952:	48 89 ce             	mov    %rcx,%rsi
ffffffff80101955:	48 89 c7             	mov    %rax,%rdi
ffffffff80101958:	e8 d9 48 00 00       	call   ffffffff80106236 <memmove>
  brelse(bp);
ffffffff8010195d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101961:	48 89 c7             	mov    %rax,%rdi
ffffffff80101964:	e8 03 ea ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff80101969:	90                   	nop
ffffffff8010196a:	c9                   	leave
ffffffff8010196b:	c3                   	ret

ffffffff8010196c <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffffffff8010196c:	f3 0f 1e fa          	endbr64
ffffffff80101970:	55                   	push   %rbp
ffffffff80101971:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101974:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101978:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff8010197b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp;
  
  bp = bread(dev, bno);
ffffffff8010197e:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80101981:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80101984:	89 d6                	mov    %edx,%esi
ffffffff80101986:	89 c7                	mov    %eax,%edi
ffffffff80101988:	e8 52 e9 ff ff       	call   ffffffff801002df <bread>
ffffffff8010198d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffffffff80101991:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101995:	48 83 c0 28          	add    $0x28,%rax
ffffffff80101999:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff8010199e:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801019a3:	48 89 c7             	mov    %rax,%rdi
ffffffff801019a6:	e8 94 47 00 00       	call   ffffffff8010613f <memset>
  log_write(bp);
ffffffff801019ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801019af:	48 89 c7             	mov    %rax,%rdi
ffffffff801019b2:	e8 61 22 00 00       	call   ffffffff80103c18 <log_write>
  brelse(bp);
ffffffff801019b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801019bb:	48 89 c7             	mov    %rax,%rdi
ffffffff801019be:	e8 a9 e9 ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff801019c3:	90                   	nop
ffffffff801019c4:	c9                   	leave
ffffffff801019c5:	c3                   	ret

ffffffff801019c6 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffffffff801019c6:	f3 0f 1e fa          	endbr64
ffffffff801019ca:	55                   	push   %rbp
ffffffff801019cb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801019ce:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff801019d2:	89 7d cc             	mov    %edi,-0x34(%rbp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
ffffffff801019d5:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff801019dc:	00 
  readsb(dev, &sb);
ffffffff801019dd:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801019e0:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffffffff801019e4:	48 89 d6             	mov    %rdx,%rsi
ffffffff801019e7:	89 c7                	mov    %eax,%edi
ffffffff801019e9:	e8 2d ff ff ff       	call   ffffffff8010191b <readsb>
  for(b = 0; b < sb.size; b += BPB){
ffffffff801019ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801019f5:	e9 0d 01 00 00       	jmp    ffffffff80101b07 <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff801019fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801019fd:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffffffff80101a03:	85 c0                	test   %eax,%eax
ffffffff80101a05:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101a08:	c1 f8 0c             	sar    $0xc,%eax
ffffffff80101a0b:	89 c2                	mov    %eax,%edx
ffffffff80101a0d:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101a10:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101a13:	01 d0                	add    %edx,%eax
ffffffff80101a15:	8d 50 03             	lea    0x3(%rax),%edx
ffffffff80101a18:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101a1b:	89 d6                	mov    %edx,%esi
ffffffff80101a1d:	89 c7                	mov    %eax,%edi
ffffffff80101a1f:	e8 bb e8 ff ff       	call   ffffffff801002df <bread>
ffffffff80101a24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffffffff80101a28:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffffffff80101a2f:	e9 a2 00 00 00       	jmp    ffffffff80101ad6 <balloc+0x110>
      m = 1 << (bi % 8);
ffffffff80101a34:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a37:	83 e0 07             	and    $0x7,%eax
ffffffff80101a3a:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80101a3f:	89 c1                	mov    %eax,%ecx
ffffffff80101a41:	d3 e2                	shl    %cl,%edx
ffffffff80101a43:	89 d0                	mov    %edx,%eax
ffffffff80101a45:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffffffff80101a48:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a4b:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101a4e:	85 c0                	test   %eax,%eax
ffffffff80101a50:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101a53:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101a56:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80101a5a:	48 98                	cltq
ffffffff80101a5c:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101a61:	0f b6 c0             	movzbl %al,%eax
ffffffff80101a64:	23 45 ec             	and    -0x14(%rbp),%eax
ffffffff80101a67:	85 c0                	test   %eax,%eax
ffffffff80101a69:	75 67                	jne    ffffffff80101ad2 <balloc+0x10c>
        bp->data[bi/8] |= m;  // Mark block in use.
ffffffff80101a6b:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a6e:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101a71:	85 c0                	test   %eax,%eax
ffffffff80101a73:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101a76:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101a79:	89 c1                	mov    %eax,%ecx
ffffffff80101a7b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80101a7f:	48 63 c1             	movslq %ecx,%rax
ffffffff80101a82:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101a87:	89 c2                	mov    %eax,%edx
ffffffff80101a89:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80101a8c:	09 d0                	or     %edx,%eax
ffffffff80101a8e:	89 c6                	mov    %eax,%esi
ffffffff80101a90:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80101a94:	48 63 c1             	movslq %ecx,%rax
ffffffff80101a97:	40 88 74 02 28       	mov    %sil,0x28(%rdx,%rax,1)
        log_write(bp);
ffffffff80101a9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101aa0:	48 89 c7             	mov    %rax,%rdi
ffffffff80101aa3:	e8 70 21 00 00       	call   ffffffff80103c18 <log_write>
        brelse(bp);
ffffffff80101aa8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101aac:	48 89 c7             	mov    %rax,%rdi
ffffffff80101aaf:	e8 b8 e8 ff ff       	call   ffffffff8010036c <brelse>
        bzero(dev, b + bi);
ffffffff80101ab4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101ab7:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101aba:	01 c2                	add    %eax,%edx
ffffffff80101abc:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101abf:	89 d6                	mov    %edx,%esi
ffffffff80101ac1:	89 c7                	mov    %eax,%edi
ffffffff80101ac3:	e8 a4 fe ff ff       	call   ffffffff8010196c <bzero>
        return b + bi;
ffffffff80101ac8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101acb:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101ace:	01 d0                	add    %edx,%eax
ffffffff80101ad0:	eb 4f                	jmp    ffffffff80101b21 <balloc+0x15b>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffffffff80101ad2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffffffff80101ad6:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffffffff80101add:	7f 15                	jg     ffffffff80101af4 <balloc+0x12e>
ffffffff80101adf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101ae2:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101ae5:	01 d0                	add    %edx,%eax
ffffffff80101ae7:	89 c2                	mov    %eax,%edx
ffffffff80101ae9:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80101aec:	39 c2                	cmp    %eax,%edx
ffffffff80101aee:	0f 82 40 ff ff ff    	jb     ffffffff80101a34 <balloc+0x6e>
      }
    }
    brelse(bp);
ffffffff80101af4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101af8:	48 89 c7             	mov    %rax,%rdi
ffffffff80101afb:	e8 6c e8 ff ff       	call   ffffffff8010036c <brelse>
  for(b = 0; b < sb.size; b += BPB){
ffffffff80101b00:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffffffff80101b07:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80101b0a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101b0d:	39 c2                	cmp    %eax,%edx
ffffffff80101b0f:	0f 82 e5 fe ff ff    	jb     ffffffff801019fa <balloc+0x34>
  }
  panic("balloc: out of blocks");
ffffffff80101b15:	48 c7 c7 ad 9b 10 80 	mov    $0xffffffff80109bad,%rdi
ffffffff80101b1c:	e8 2e ee ff ff       	call   ffffffff8010094f <panic>
}
ffffffff80101b21:	c9                   	leave
ffffffff80101b22:	c3                   	ret

ffffffff80101b23 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffffffff80101b23:	f3 0f 1e fa          	endbr64
ffffffff80101b27:	55                   	push   %rbp
ffffffff80101b28:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101b2b:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80101b2f:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff80101b32:	89 75 d8             	mov    %esi,-0x28(%rbp)
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
ffffffff80101b35:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff80101b39:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80101b3c:	48 89 d6             	mov    %rdx,%rsi
ffffffff80101b3f:	89 c7                	mov    %eax,%edi
ffffffff80101b41:	e8 d5 fd ff ff       	call   ffffffff8010191b <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff80101b46:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101b49:	c1 e8 0c             	shr    $0xc,%eax
ffffffff80101b4c:	89 c2                	mov    %eax,%edx
ffffffff80101b4e:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80101b51:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101b54:	01 d0                	add    %edx,%eax
ffffffff80101b56:	8d 50 03             	lea    0x3(%rax),%edx
ffffffff80101b59:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80101b5c:	89 d6                	mov    %edx,%esi
ffffffff80101b5e:	89 c7                	mov    %eax,%edi
ffffffff80101b60:	e8 7a e7 ff ff       	call   ffffffff801002df <bread>
ffffffff80101b65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffffffff80101b69:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101b6c:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80101b71:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffffffff80101b74:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101b77:	83 e0 07             	and    $0x7,%eax
ffffffff80101b7a:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80101b7f:	89 c1                	mov    %eax,%ecx
ffffffff80101b81:	d3 e2                	shl    %cl,%edx
ffffffff80101b83:	89 d0                	mov    %edx,%eax
ffffffff80101b85:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffffffff80101b88:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101b8b:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101b8e:	85 c0                	test   %eax,%eax
ffffffff80101b90:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101b93:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101b96:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101b9a:	48 98                	cltq
ffffffff80101b9c:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101ba1:	0f b6 c0             	movzbl %al,%eax
ffffffff80101ba4:	23 45 f0             	and    -0x10(%rbp),%eax
ffffffff80101ba7:	85 c0                	test   %eax,%eax
ffffffff80101ba9:	75 0c                	jne    ffffffff80101bb7 <bfree+0x94>
    panic("freeing free block");
ffffffff80101bab:	48 c7 c7 c3 9b 10 80 	mov    $0xffffffff80109bc3,%rdi
ffffffff80101bb2:	e8 98 ed ff ff       	call   ffffffff8010094f <panic>
  bp->data[bi/8] &= ~m;
ffffffff80101bb7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101bba:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101bbd:	85 c0                	test   %eax,%eax
ffffffff80101bbf:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101bc2:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101bc5:	89 c1                	mov    %eax,%ecx
ffffffff80101bc7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101bcb:	48 63 c1             	movslq %ecx,%rax
ffffffff80101bce:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101bd3:	89 c2                	mov    %eax,%edx
ffffffff80101bd5:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80101bd8:	f7 d0                	not    %eax
ffffffff80101bda:	21 d0                	and    %edx,%eax
ffffffff80101bdc:	89 c6                	mov    %eax,%esi
ffffffff80101bde:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101be2:	48 63 c1             	movslq %ecx,%rax
ffffffff80101be5:	40 88 74 02 28       	mov    %sil,0x28(%rdx,%rax,1)
  log_write(bp);
ffffffff80101bea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101bee:	48 89 c7             	mov    %rax,%rdi
ffffffff80101bf1:	e8 22 20 00 00       	call   ffffffff80103c18 <log_write>
  brelse(bp);
ffffffff80101bf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101bfa:	48 89 c7             	mov    %rax,%rdi
ffffffff80101bfd:	e8 6a e7 ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff80101c02:	90                   	nop
ffffffff80101c03:	c9                   	leave
ffffffff80101c04:	c3                   	ret

ffffffff80101c05 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
ffffffff80101c05:	f3 0f 1e fa          	endbr64
ffffffff80101c09:	55                   	push   %rbp
ffffffff80101c0a:	48 89 e5             	mov    %rsp,%rbp
  initlock(&icache.lock, "icache");
ffffffff80101c0d:	48 c7 c6 d6 9b 10 80 	mov    $0xffffffff80109bd6,%rsi
ffffffff80101c14:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101c1b:	e8 5a 41 00 00       	call   ffffffff80105d7a <initlock>
}
ffffffff80101c20:	90                   	nop
ffffffff80101c21:	5d                   	pop    %rbp
ffffffff80101c22:	c3                   	ret

ffffffff80101c23 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffffffff80101c23:	f3 0f 1e fa          	endbr64
ffffffff80101c27:	55                   	push   %rbp
ffffffff80101c28:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101c2b:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80101c2f:	89 7d cc             	mov    %edi,-0x34(%rbp)
ffffffff80101c32:	89 f0                	mov    %esi,%eax
ffffffff80101c34:	66 89 45 c8          	mov    %ax,-0x38(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
ffffffff80101c38:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101c3b:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffffffff80101c3f:	48 89 d6             	mov    %rdx,%rsi
ffffffff80101c42:	89 c7                	mov    %eax,%edi
ffffffff80101c44:	e8 d2 fc ff ff       	call   ffffffff8010191b <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
ffffffff80101c49:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffffffff80101c50:	e9 9d 00 00 00       	jmp    ffffffff80101cf2 <ialloc+0xcf>
    bp = bread(dev, IBLOCK(inum));
ffffffff80101c55:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101c58:	48 98                	cltq
ffffffff80101c5a:	48 c1 e8 03          	shr    $0x3,%rax
ffffffff80101c5e:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101c61:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101c64:	89 d6                	mov    %edx,%esi
ffffffff80101c66:	89 c7                	mov    %eax,%edi
ffffffff80101c68:	e8 72 e6 ff ff       	call   ffffffff801002df <bread>
ffffffff80101c6d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffffffff80101c71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101c75:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101c79:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101c7c:	48 98                	cltq
ffffffff80101c7e:	83 e0 07             	and    $0x7,%eax
ffffffff80101c81:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101c85:	48 01 d0             	add    %rdx,%rax
ffffffff80101c88:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffffffff80101c8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101c90:	0f b7 00             	movzwl (%rax),%eax
ffffffff80101c93:	66 85 c0             	test   %ax,%ax
ffffffff80101c96:	75 4a                	jne    ffffffff80101ce2 <ialloc+0xbf>
      memset(dip, 0, sizeof(*dip));
ffffffff80101c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101c9c:	ba 40 00 00 00       	mov    $0x40,%edx
ffffffff80101ca1:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80101ca6:	48 89 c7             	mov    %rax,%rdi
ffffffff80101ca9:	e8 91 44 00 00       	call   ffffffff8010613f <memset>
      dip->type = type;
ffffffff80101cae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101cb2:	0f b7 55 c8          	movzwl -0x38(%rbp),%edx
ffffffff80101cb6:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffffffff80101cb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101cbd:	48 89 c7             	mov    %rax,%rdi
ffffffff80101cc0:	e8 53 1f 00 00       	call   ffffffff80103c18 <log_write>
      brelse(bp);
ffffffff80101cc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101cc9:	48 89 c7             	mov    %rax,%rdi
ffffffff80101ccc:	e8 9b e6 ff ff       	call   ffffffff8010036c <brelse>
      return iget(dev, inum);
ffffffff80101cd1:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101cd4:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101cd7:	89 d6                	mov    %edx,%esi
ffffffff80101cd9:	89 c7                	mov    %eax,%edi
ffffffff80101cdb:	e8 05 01 00 00       	call   ffffffff80101de5 <iget>
ffffffff80101ce0:	eb 2a                	jmp    ffffffff80101d0c <ialloc+0xe9>
    }
    brelse(bp);
ffffffff80101ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101ce6:	48 89 c7             	mov    %rax,%rdi
ffffffff80101ce9:	e8 7e e6 ff ff       	call   ffffffff8010036c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
ffffffff80101cee:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80101cf2:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101cf5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101cf8:	39 c2                	cmp    %eax,%edx
ffffffff80101cfa:	0f 82 55 ff ff ff    	jb     ffffffff80101c55 <ialloc+0x32>
  }
  panic("ialloc: no inodes");
ffffffff80101d00:	48 c7 c7 dd 9b 10 80 	mov    $0xffffffff80109bdd,%rdi
ffffffff80101d07:	e8 43 ec ff ff       	call   ffffffff8010094f <panic>
}
ffffffff80101d0c:	c9                   	leave
ffffffff80101d0d:	c3                   	ret

ffffffff80101d0e <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffffffff80101d0e:	f3 0f 1e fa          	endbr64
ffffffff80101d12:	55                   	push   %rbp
ffffffff80101d13:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101d16:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101d1a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff80101d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d22:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101d25:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101d28:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101d2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d2f:	8b 00                	mov    (%rax),%eax
ffffffff80101d31:	89 d6                	mov    %edx,%esi
ffffffff80101d33:	89 c7                	mov    %eax,%edi
ffffffff80101d35:	e8 a5 e5 ff ff       	call   ffffffff801002df <bread>
ffffffff80101d3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffffffff80101d3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101d42:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101d46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d4a:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101d4d:	89 c0                	mov    %eax,%eax
ffffffff80101d4f:	83 e0 07             	and    $0x7,%eax
ffffffff80101d52:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101d56:	48 01 d0             	add    %rdx,%rax
ffffffff80101d59:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffffffff80101d5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d61:	0f b7 50 10          	movzwl 0x10(%rax),%edx
ffffffff80101d65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d69:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffffffff80101d6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d70:	0f b7 50 12          	movzwl 0x12(%rax),%edx
ffffffff80101d74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d78:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffffffff80101d7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d80:	0f b7 50 14          	movzwl 0x14(%rax),%edx
ffffffff80101d84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d88:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffffffff80101d8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d90:	0f b7 50 16          	movzwl 0x16(%rax),%edx
ffffffff80101d94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d98:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffffffff80101d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101da0:	8b 50 18             	mov    0x18(%rax),%edx
ffffffff80101da3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101da7:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffffffff80101daa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101dae:	48 8d 48 1c          	lea    0x1c(%rax),%rcx
ffffffff80101db2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101db6:	48 83 c0 0c          	add    $0xc,%rax
ffffffff80101dba:	ba 34 00 00 00       	mov    $0x34,%edx
ffffffff80101dbf:	48 89 ce             	mov    %rcx,%rsi
ffffffff80101dc2:	48 89 c7             	mov    %rax,%rdi
ffffffff80101dc5:	e8 6c 44 00 00       	call   ffffffff80106236 <memmove>
  log_write(bp);
ffffffff80101dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101dce:	48 89 c7             	mov    %rax,%rdi
ffffffff80101dd1:	e8 42 1e 00 00       	call   ffffffff80103c18 <log_write>
  brelse(bp);
ffffffff80101dd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101dda:	48 89 c7             	mov    %rax,%rdi
ffffffff80101ddd:	e8 8a e5 ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff80101de2:	90                   	nop
ffffffff80101de3:	c9                   	leave
ffffffff80101de4:	c3                   	ret

ffffffff80101de5 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffffffff80101de5:	f3 0f 1e fa          	endbr64
ffffffff80101de9:	55                   	push   %rbp
ffffffff80101dea:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101ded:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101df1:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80101df4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffffffff80101df7:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101dfe:	e8 b0 3f 00 00       	call   ffffffff80105db3 <acquire>

  // Is the inode already cached?
  empty = 0;
ffffffff80101e03:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff80101e0a:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffffffff80101e0b:	48 c7 45 f8 c8 ea 10 	movq   $0xffffffff8010eac8,-0x8(%rbp)
ffffffff80101e12:	80 
ffffffff80101e13:	eb 64                	jmp    ffffffff80101e79 <iget+0x94>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffffffff80101e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e19:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101e1c:	85 c0                	test   %eax,%eax
ffffffff80101e1e:	7e 3a                	jle    ffffffff80101e5a <iget+0x75>
ffffffff80101e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e24:	8b 00                	mov    (%rax),%eax
ffffffff80101e26:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80101e29:	75 2f                	jne    ffffffff80101e5a <iget+0x75>
ffffffff80101e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e2f:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101e32:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff80101e35:	75 23                	jne    ffffffff80101e5a <iget+0x75>
      ip->ref++;
ffffffff80101e37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e3b:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101e3e:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e45:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffffffff80101e48:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101e4f:	e8 3a 40 00 00       	call   ffffffff80105e8e <release>
      return ip;
ffffffff80101e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e58:	eb 7d                	jmp    ffffffff80101ed7 <iget+0xf2>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
ffffffff80101e5a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80101e5f:	75 13                	jne    ffffffff80101e74 <iget+0x8f>
ffffffff80101e61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e65:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101e68:	85 c0                	test   %eax,%eax
ffffffff80101e6a:	75 08                	jne    ffffffff80101e74 <iget+0x8f>
      empty = ip;
ffffffff80101e6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e70:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffffffff80101e74:	48 83 45 f8 50       	addq   $0x50,-0x8(%rbp)
ffffffff80101e79:	48 81 7d f8 68 fa 10 	cmpq   $0xffffffff8010fa68,-0x8(%rbp)
ffffffff80101e80:	80 
ffffffff80101e81:	72 92                	jb     ffffffff80101e15 <iget+0x30>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffffffff80101e83:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80101e88:	75 0c                	jne    ffffffff80101e96 <iget+0xb1>
    panic("iget: no inodes");
ffffffff80101e8a:	48 c7 c7 ef 9b 10 80 	mov    $0xffffffff80109bef,%rdi
ffffffff80101e91:	e8 b9 ea ff ff       	call   ffffffff8010094f <panic>

  ip = empty;
ffffffff80101e96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101e9a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffffffff80101e9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101ea2:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80101ea5:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffffffff80101ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101eab:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80101eae:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffffffff80101eb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101eb5:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffffffff80101ebc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101ec0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
  release(&icache.lock);
ffffffff80101ec7:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101ece:	e8 bb 3f 00 00       	call   ffffffff80105e8e <release>

  return ip;
ffffffff80101ed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80101ed7:	c9                   	leave
ffffffff80101ed8:	c3                   	ret

ffffffff80101ed9 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffffffff80101ed9:	f3 0f 1e fa          	endbr64
ffffffff80101edd:	55                   	push   %rbp
ffffffff80101ede:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101ee1:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80101ee5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffffffff80101ee9:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101ef0:	e8 be 3e 00 00       	call   ffffffff80105db3 <acquire>
  ip->ref++;
ffffffff80101ef5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101ef9:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101efc:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101eff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101f03:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffffffff80101f06:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101f0d:	e8 7c 3f 00 00       	call   ffffffff80105e8e <release>
  return ip;
ffffffff80101f12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80101f16:	c9                   	leave
ffffffff80101f17:	c3                   	ret

ffffffff80101f18 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffffffff80101f18:	f3 0f 1e fa          	endbr64
ffffffff80101f1c:	55                   	push   %rbp
ffffffff80101f1d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101f20:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101f24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffffffff80101f28:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80101f2d:	74 0b                	je     ffffffff80101f3a <ilock+0x22>
ffffffff80101f2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f33:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101f36:	85 c0                	test   %eax,%eax
ffffffff80101f38:	7f 0c                	jg     ffffffff80101f46 <ilock+0x2e>
    panic("ilock");
ffffffff80101f3a:	48 c7 c7 ff 9b 10 80 	mov    $0xffffffff80109bff,%rdi
ffffffff80101f41:	e8 09 ea ff ff       	call   ffffffff8010094f <panic>

  acquire(&icache.lock);
ffffffff80101f46:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101f4d:	e8 61 3e 00 00       	call   ffffffff80105db3 <acquire>
  while(ip->flags & I_BUSY)
ffffffff80101f52:	eb 13                	jmp    ffffffff80101f67 <ilock+0x4f>
    sleep(ip, &icache.lock);
ffffffff80101f54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f58:	48 c7 c6 60 ea 10 80 	mov    $0xffffffff8010ea60,%rsi
ffffffff80101f5f:	48 89 c7             	mov    %rax,%rdi
ffffffff80101f62:	e8 b0 3a 00 00       	call   ffffffff80105a17 <sleep>
  while(ip->flags & I_BUSY)
ffffffff80101f67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f6b:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101f6e:	83 e0 01             	and    $0x1,%eax
ffffffff80101f71:	85 c0                	test   %eax,%eax
ffffffff80101f73:	75 df                	jne    ffffffff80101f54 <ilock+0x3c>
  ip->flags |= I_BUSY;
ffffffff80101f75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f79:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101f7c:	83 c8 01             	or     $0x1,%eax
ffffffff80101f7f:	89 c2                	mov    %eax,%edx
ffffffff80101f81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f85:	89 50 0c             	mov    %edx,0xc(%rax)
  release(&icache.lock);
ffffffff80101f88:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101f8f:	e8 fa 3e 00 00       	call   ffffffff80105e8e <release>

  if(!(ip->flags & I_VALID)){
ffffffff80101f94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f98:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101f9b:	83 e0 02             	and    $0x2,%eax
ffffffff80101f9e:	85 c0                	test   %eax,%eax
ffffffff80101fa0:	0f 85 e4 00 00 00    	jne    ffffffff8010208a <ilock+0x172>
    bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff80101fa6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101faa:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101fad:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101fb0:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101fb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fb7:	8b 00                	mov    (%rax),%eax
ffffffff80101fb9:	89 d6                	mov    %edx,%esi
ffffffff80101fbb:	89 c7                	mov    %eax,%edi
ffffffff80101fbd:	e8 1d e3 ff ff       	call   ffffffff801002df <bread>
ffffffff80101fc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffffffff80101fc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101fca:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101fce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fd2:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101fd5:	89 c0                	mov    %eax,%eax
ffffffff80101fd7:	83 e0 07             	and    $0x7,%eax
ffffffff80101fda:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101fde:	48 01 d0             	add    %rdx,%rax
ffffffff80101fe1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffffffff80101fe5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101fe9:	0f b7 10             	movzwl (%rax),%edx
ffffffff80101fec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ff0:	66 89 50 10          	mov    %dx,0x10(%rax)
    ip->major = dip->major;
ffffffff80101ff4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101ff8:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffffffff80101ffc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102000:	66 89 50 12          	mov    %dx,0x12(%rax)
    ip->minor = dip->minor;
ffffffff80102004:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102008:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffffffff8010200c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102010:	66 89 50 14          	mov    %dx,0x14(%rax)
    ip->nlink = dip->nlink;
ffffffff80102014:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102018:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffffffff8010201c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102020:	66 89 50 16          	mov    %dx,0x16(%rax)
    ip->size = dip->size;
ffffffff80102024:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102028:	8b 50 08             	mov    0x8(%rax),%edx
ffffffff8010202b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010202f:	89 50 18             	mov    %edx,0x18(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffffffff80102032:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102036:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffffffff8010203a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010203e:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80102042:	ba 34 00 00 00       	mov    $0x34,%edx
ffffffff80102047:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010204a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010204d:	e8 e4 41 00 00       	call   ffffffff80106236 <memmove>
    brelse(bp);
ffffffff80102052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102056:	48 89 c7             	mov    %rax,%rdi
ffffffff80102059:	e8 0e e3 ff ff       	call   ffffffff8010036c <brelse>
    ip->flags |= I_VALID;
ffffffff8010205e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102062:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80102065:	83 c8 02             	or     $0x2,%eax
ffffffff80102068:	89 c2                	mov    %eax,%edx
ffffffff8010206a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010206e:	89 50 0c             	mov    %edx,0xc(%rax)
    if(ip->type == 0)
ffffffff80102071:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102075:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80102079:	66 85 c0             	test   %ax,%ax
ffffffff8010207c:	75 0c                	jne    ffffffff8010208a <ilock+0x172>
      panic("ilock: no type");
ffffffff8010207e:	48 c7 c7 05 9c 10 80 	mov    $0xffffffff80109c05,%rdi
ffffffff80102085:	e8 c5 e8 ff ff       	call   ffffffff8010094f <panic>
  }
}
ffffffff8010208a:	90                   	nop
ffffffff8010208b:	c9                   	leave
ffffffff8010208c:	c3                   	ret

ffffffff8010208d <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffffffff8010208d:	f3 0f 1e fa          	endbr64
ffffffff80102091:	55                   	push   %rbp
ffffffff80102092:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102095:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102099:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
ffffffff8010209d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801020a2:	74 19                	je     ffffffff801020bd <iunlock+0x30>
ffffffff801020a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020a8:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801020ab:	83 e0 01             	and    $0x1,%eax
ffffffff801020ae:	85 c0                	test   %eax,%eax
ffffffff801020b0:	74 0b                	je     ffffffff801020bd <iunlock+0x30>
ffffffff801020b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020b6:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff801020b9:	85 c0                	test   %eax,%eax
ffffffff801020bb:	7f 0c                	jg     ffffffff801020c9 <iunlock+0x3c>
    panic("iunlock");
ffffffff801020bd:	48 c7 c7 14 9c 10 80 	mov    $0xffffffff80109c14,%rdi
ffffffff801020c4:	e8 86 e8 ff ff       	call   ffffffff8010094f <panic>

  acquire(&icache.lock);
ffffffff801020c9:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff801020d0:	e8 de 3c 00 00       	call   ffffffff80105db3 <acquire>
  ip->flags &= ~I_BUSY;
ffffffff801020d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020d9:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801020dc:	83 e0 fe             	and    $0xfffffffe,%eax
ffffffff801020df:	89 c2                	mov    %eax,%edx
ffffffff801020e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020e5:	89 50 0c             	mov    %edx,0xc(%rax)
  wakeup(ip);
ffffffff801020e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020ec:	48 89 c7             	mov    %rax,%rdi
ffffffff801020ef:	e8 3f 3a 00 00       	call   ffffffff80105b33 <wakeup>
  release(&icache.lock);
ffffffff801020f4:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff801020fb:	e8 8e 3d 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80102100:	90                   	nop
ffffffff80102101:	c9                   	leave
ffffffff80102102:	c3                   	ret

ffffffff80102103 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
ffffffff80102103:	f3 0f 1e fa          	endbr64
ffffffff80102107:	55                   	push   %rbp
ffffffff80102108:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010210b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010210f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffffffff80102113:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff8010211a:	e8 94 3c 00 00       	call   ffffffff80105db3 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffffffff8010211f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102123:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102126:	83 f8 01             	cmp    $0x1,%eax
ffffffff80102129:	0f 85 9d 00 00 00    	jne    ffffffff801021cc <iput+0xc9>
ffffffff8010212f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102133:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80102136:	83 e0 02             	and    $0x2,%eax
ffffffff80102139:	85 c0                	test   %eax,%eax
ffffffff8010213b:	0f 84 8b 00 00 00    	je     ffffffff801021cc <iput+0xc9>
ffffffff80102141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102145:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80102149:	66 85 c0             	test   %ax,%ax
ffffffff8010214c:	75 7e                	jne    ffffffff801021cc <iput+0xc9>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
ffffffff8010214e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102152:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80102155:	83 e0 01             	and    $0x1,%eax
ffffffff80102158:	85 c0                	test   %eax,%eax
ffffffff8010215a:	74 0c                	je     ffffffff80102168 <iput+0x65>
      panic("iput busy");
ffffffff8010215c:	48 c7 c7 1c 9c 10 80 	mov    $0xffffffff80109c1c,%rdi
ffffffff80102163:	e8 e7 e7 ff ff       	call   ffffffff8010094f <panic>
    ip->flags |= I_BUSY;
ffffffff80102168:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010216c:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff8010216f:	83 c8 01             	or     $0x1,%eax
ffffffff80102172:	89 c2                	mov    %eax,%edx
ffffffff80102174:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102178:	89 50 0c             	mov    %edx,0xc(%rax)
    release(&icache.lock);
ffffffff8010217b:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80102182:	e8 07 3d 00 00       	call   ffffffff80105e8e <release>
    itrunc(ip);
ffffffff80102187:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010218b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010218e:	e8 a8 01 00 00       	call   ffffffff8010233b <itrunc>
    ip->type = 0;
ffffffff80102193:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102197:	66 c7 40 10 00 00    	movw   $0x0,0x10(%rax)
    iupdate(ip);
ffffffff8010219d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801021a1:	48 89 c7             	mov    %rax,%rdi
ffffffff801021a4:	e8 65 fb ff ff       	call   ffffffff80101d0e <iupdate>
    acquire(&icache.lock);
ffffffff801021a9:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff801021b0:	e8 fe 3b 00 00       	call   ffffffff80105db3 <acquire>
    ip->flags = 0;
ffffffff801021b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801021b9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
    wakeup(ip);
ffffffff801021c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801021c4:	48 89 c7             	mov    %rax,%rdi
ffffffff801021c7:	e8 67 39 00 00       	call   ffffffff80105b33 <wakeup>
  }
  ip->ref--;
ffffffff801021cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801021d0:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff801021d3:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801021d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801021da:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffffffff801021dd:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff801021e4:	e8 a5 3c 00 00       	call   ffffffff80105e8e <release>
}
ffffffff801021e9:	90                   	nop
ffffffff801021ea:	c9                   	leave
ffffffff801021eb:	c3                   	ret

ffffffff801021ec <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffffffff801021ec:	f3 0f 1e fa          	endbr64
ffffffff801021f0:	55                   	push   %rbp
ffffffff801021f1:	48 89 e5             	mov    %rsp,%rbp
ffffffff801021f4:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801021f8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffffffff801021fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102200:	48 89 c7             	mov    %rax,%rdi
ffffffff80102203:	e8 85 fe ff ff       	call   ffffffff8010208d <iunlock>
  iput(ip);
ffffffff80102208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010220c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010220f:	e8 ef fe ff ff       	call   ffffffff80102103 <iput>
}
ffffffff80102214:	90                   	nop
ffffffff80102215:	c9                   	leave
ffffffff80102216:	c3                   	ret

ffffffff80102217 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffffffff80102217:	f3 0f 1e fa          	endbr64
ffffffff8010221b:	55                   	push   %rbp
ffffffff8010221c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010221f:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80102223:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80102227:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffffffff8010222a:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffffffff8010222e:	77 42                	ja     ffffffff80102272 <bmap+0x5b>
    if((addr = ip->addrs[bn]) == 0)
ffffffff80102230:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102234:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffffffff80102237:	48 83 c2 04          	add    $0x4,%rdx
ffffffff8010223b:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff8010223f:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102242:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80102246:	75 22                	jne    ffffffff8010226a <bmap+0x53>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffffffff80102248:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010224c:	8b 00                	mov    (%rax),%eax
ffffffff8010224e:	89 c7                	mov    %eax,%edi
ffffffff80102250:	e8 71 f7 ff ff       	call   ffffffff801019c6 <balloc>
ffffffff80102255:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102258:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010225c:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffffffff8010225f:	48 8d 4a 04          	lea    0x4(%rdx),%rcx
ffffffff80102263:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102266:	89 54 88 0c          	mov    %edx,0xc(%rax,%rcx,4)
    return addr;
ffffffff8010226a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010226d:	e9 c7 00 00 00       	jmp    ffffffff80102339 <bmap+0x122>
  }
  bn -= NDIRECT;
ffffffff80102272:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffffffff80102276:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffffffff8010227a:	0f 87 ad 00 00 00    	ja     ffffffff8010232d <bmap+0x116>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffffffff80102280:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102284:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff80102287:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010228a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010228e:	75 1a                	jne    ffffffff801022aa <bmap+0x93>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffffffff80102290:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102294:	8b 00                	mov    (%rax),%eax
ffffffff80102296:	89 c7                	mov    %eax,%edi
ffffffff80102298:	e8 29 f7 ff ff       	call   ffffffff801019c6 <balloc>
ffffffff8010229d:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801022a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801022a7:	89 50 4c             	mov    %edx,0x4c(%rax)
    bp = bread(ip->dev, addr);
ffffffff801022aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022ae:	8b 00                	mov    (%rax),%eax
ffffffff801022b0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801022b3:	89 d6                	mov    %edx,%esi
ffffffff801022b5:	89 c7                	mov    %eax,%edi
ffffffff801022b7:	e8 23 e0 ff ff       	call   ffffffff801002df <bread>
ffffffff801022bc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffffffff801022c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801022c4:	48 83 c0 28          	add    $0x28,%rax
ffffffff801022c8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffffffff801022cc:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff801022cf:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff801022d6:	00 
ffffffff801022d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801022db:	48 01 d0             	add    %rdx,%rax
ffffffff801022de:	8b 00                	mov    (%rax),%eax
ffffffff801022e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801022e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801022e7:	75 33                	jne    ffffffff8010231c <bmap+0x105>
      a[bn] = addr = balloc(ip->dev);
ffffffff801022e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022ed:	8b 00                	mov    (%rax),%eax
ffffffff801022ef:	89 c7                	mov    %eax,%edi
ffffffff801022f1:	e8 d0 f6 ff ff       	call   ffffffff801019c6 <balloc>
ffffffff801022f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801022f9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff801022fc:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80102303:	00 
ffffffff80102304:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102308:	48 01 c2             	add    %rax,%rdx
ffffffff8010230b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010230e:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffffffff80102310:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102314:	48 89 c7             	mov    %rax,%rdi
ffffffff80102317:	e8 fc 18 00 00       	call   ffffffff80103c18 <log_write>
    }
    brelse(bp);
ffffffff8010231c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102320:	48 89 c7             	mov    %rax,%rdi
ffffffff80102323:	e8 44 e0 ff ff       	call   ffffffff8010036c <brelse>
    return addr;
ffffffff80102328:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010232b:	eb 0c                	jmp    ffffffff80102339 <bmap+0x122>
  }

  panic("bmap: out of range");
ffffffff8010232d:	48 c7 c7 26 9c 10 80 	mov    $0xffffffff80109c26,%rdi
ffffffff80102334:	e8 16 e6 ff ff       	call   ffffffff8010094f <panic>
}
ffffffff80102339:	c9                   	leave
ffffffff8010233a:	c3                   	ret

ffffffff8010233b <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffffffff8010233b:	f3 0f 1e fa          	endbr64
ffffffff8010233f:	55                   	push   %rbp
ffffffff80102340:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102343:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80102347:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffffffff8010234b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102352:	eb 51                	jmp    ffffffff801023a5 <itrunc+0x6a>
    if(ip->addrs[i]){
ffffffff80102354:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102358:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010235b:	48 63 d2             	movslq %edx,%rdx
ffffffff8010235e:	48 83 c2 04          	add    $0x4,%rdx
ffffffff80102362:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff80102366:	85 c0                	test   %eax,%eax
ffffffff80102368:	74 37                	je     ffffffff801023a1 <itrunc+0x66>
      bfree(ip->dev, ip->addrs[i]);
ffffffff8010236a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010236e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102371:	48 63 d2             	movslq %edx,%rdx
ffffffff80102374:	48 83 c2 04          	add    $0x4,%rdx
ffffffff80102378:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff8010237c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff80102380:	8b 12                	mov    (%rdx),%edx
ffffffff80102382:	89 c6                	mov    %eax,%esi
ffffffff80102384:	89 d7                	mov    %edx,%edi
ffffffff80102386:	e8 98 f7 ff ff       	call   ffffffff80101b23 <bfree>
      ip->addrs[i] = 0;
ffffffff8010238b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010238f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102392:	48 63 d2             	movslq %edx,%rdx
ffffffff80102395:	48 83 c2 04          	add    $0x4,%rdx
ffffffff80102399:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%rax,%rdx,4)
ffffffff801023a0:	00 
  for(i = 0; i < NDIRECT; i++){
ffffffff801023a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801023a5:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffffffff801023a9:	7e a9                	jle    ffffffff80102354 <itrunc+0x19>
    }
  }
  
  if(ip->addrs[NDIRECT]){
ffffffff801023ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023af:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff801023b2:	85 c0                	test   %eax,%eax
ffffffff801023b4:	0f 84 a7 00 00 00    	je     ffffffff80102461 <itrunc+0x126>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffffffff801023ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023be:	8b 50 4c             	mov    0x4c(%rax),%edx
ffffffff801023c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023c5:	8b 00                	mov    (%rax),%eax
ffffffff801023c7:	89 d6                	mov    %edx,%esi
ffffffff801023c9:	89 c7                	mov    %eax,%edi
ffffffff801023cb:	e8 0f df ff ff       	call   ffffffff801002df <bread>
ffffffff801023d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffffffff801023d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801023d8:	48 83 c0 28          	add    $0x28,%rax
ffffffff801023dc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffffffff801023e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffffffff801023e7:	eb 43                	jmp    ffffffff8010242c <itrunc+0xf1>
      if(a[j])
ffffffff801023e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff801023ec:	48 98                	cltq
ffffffff801023ee:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff801023f5:	00 
ffffffff801023f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801023fa:	48 01 d0             	add    %rdx,%rax
ffffffff801023fd:	8b 00                	mov    (%rax),%eax
ffffffff801023ff:	85 c0                	test   %eax,%eax
ffffffff80102401:	74 25                	je     ffffffff80102428 <itrunc+0xed>
        bfree(ip->dev, a[j]);
ffffffff80102403:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102406:	48 98                	cltq
ffffffff80102408:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010240f:	00 
ffffffff80102410:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102414:	48 01 d0             	add    %rdx,%rax
ffffffff80102417:	8b 00                	mov    (%rax),%eax
ffffffff80102419:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff8010241d:	8b 12                	mov    (%rdx),%edx
ffffffff8010241f:	89 c6                	mov    %eax,%esi
ffffffff80102421:	89 d7                	mov    %edx,%edi
ffffffff80102423:	e8 fb f6 ff ff       	call   ffffffff80101b23 <bfree>
    for(j = 0; j < NINDIRECT; j++){
ffffffff80102428:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffffffff8010242c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010242f:	83 f8 7f             	cmp    $0x7f,%eax
ffffffff80102432:	76 b5                	jbe    ffffffff801023e9 <itrunc+0xae>
    }
    brelse(bp);
ffffffff80102434:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102438:	48 89 c7             	mov    %rax,%rdi
ffffffff8010243b:	e8 2c df ff ff       	call   ffffffff8010036c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffffffff80102440:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102444:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff80102447:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff8010244b:	8b 12                	mov    (%rdx),%edx
ffffffff8010244d:	89 c6                	mov    %eax,%esi
ffffffff8010244f:	89 d7                	mov    %edx,%edi
ffffffff80102451:	e8 cd f6 ff ff       	call   ffffffff80101b23 <bfree>
    ip->addrs[NDIRECT] = 0;
ffffffff80102456:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010245a:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%rax)
  }

  ip->size = 0;
ffffffff80102461:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102465:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
  iupdate(ip);
ffffffff8010246c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102470:	48 89 c7             	mov    %rax,%rdi
ffffffff80102473:	e8 96 f8 ff ff       	call   ffffffff80101d0e <iupdate>
}
ffffffff80102478:	90                   	nop
ffffffff80102479:	c9                   	leave
ffffffff8010247a:	c3                   	ret

ffffffff8010247b <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffffffff8010247b:	f3 0f 1e fa          	endbr64
ffffffff8010247f:	55                   	push   %rbp
ffffffff80102480:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102483:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102487:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010248b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffffffff8010248f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102493:	8b 00                	mov    (%rax),%eax
ffffffff80102495:	89 c2                	mov    %eax,%edx
ffffffff80102497:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010249b:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffffffff8010249e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801024a2:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff801024a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801024a9:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffffffff801024ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801024b0:	0f b7 50 10          	movzwl 0x10(%rax),%edx
ffffffff801024b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801024b8:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffffffff801024bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801024bf:	0f b7 50 16          	movzwl 0x16(%rax),%edx
ffffffff801024c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801024c7:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffffffff801024cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801024cf:	8b 50 18             	mov    0x18(%rax),%edx
ffffffff801024d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801024d6:	89 50 10             	mov    %edx,0x10(%rax)
}
ffffffff801024d9:	90                   	nop
ffffffff801024da:	c9                   	leave
ffffffff801024db:	c3                   	ret

ffffffff801024dc <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffffffff801024dc:	f3 0f 1e fa          	endbr64
ffffffff801024e0:	55                   	push   %rbp
ffffffff801024e1:	48 89 e5             	mov    %rsp,%rbp
ffffffff801024e4:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff801024e8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff801024ec:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff801024f0:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffffffff801024f3:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffffffff801024f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801024fa:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff801024fe:	66 83 f8 03          	cmp    $0x3,%ax
ffffffff80102502:	75 73                	jne    ffffffff80102577 <readi+0x9b>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffffffff80102504:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102508:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff8010250c:	66 85 c0             	test   %ax,%ax
ffffffff8010250f:	78 2b                	js     ffffffff8010253c <readi+0x60>
ffffffff80102511:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102515:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102519:	66 83 f8 09          	cmp    $0x9,%ax
ffffffff8010251d:	7f 1d                	jg     ffffffff8010253c <readi+0x60>
ffffffff8010251f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102523:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102527:	98                   	cwtl
ffffffff80102528:	48 98                	cltq
ffffffff8010252a:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010252e:	48 05 a0 d9 10 80    	add    $0xffffffff8010d9a0,%rax
ffffffff80102534:	48 8b 00             	mov    (%rax),%rax
ffffffff80102537:	48 85 c0             	test   %rax,%rax
ffffffff8010253a:	75 0a                	jne    ffffffff80102546 <readi+0x6a>
      return -1;
ffffffff8010253c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102541:	e9 1c 01 00 00       	jmp    ffffffff80102662 <readi+0x186>
    return devsw[ip->major].read(ip, dst, n);
ffffffff80102546:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010254a:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff8010254e:	98                   	cwtl
ffffffff8010254f:	48 98                	cltq
ffffffff80102551:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80102555:	48 05 a0 d9 10 80    	add    $0xffffffff8010d9a0,%rax
ffffffff8010255b:	4c 8b 00             	mov    (%rax),%r8
ffffffff8010255e:	8b 55 c8             	mov    -0x38(%rbp),%edx
ffffffff80102561:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff80102565:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102569:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010256c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010256f:	41 ff d0             	call   *%r8
ffffffff80102572:	e9 eb 00 00 00       	jmp    ffffffff80102662 <readi+0x186>
  }

  if(off > ip->size || off + n < off)
ffffffff80102577:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010257b:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010257e:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102581:	72 0d                	jb     ffffffff80102590 <readi+0xb4>
ffffffff80102583:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff80102586:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102589:	01 d0                	add    %edx,%eax
ffffffff8010258b:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff8010258e:	73 0a                	jae    ffffffff8010259a <readi+0xbe>
    return -1;
ffffffff80102590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102595:	e9 c8 00 00 00       	jmp    ffffffff80102662 <readi+0x186>
  if(off + n > ip->size)
ffffffff8010259a:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff8010259d:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff801025a0:	01 c2                	add    %eax,%edx
ffffffff801025a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025a6:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801025a9:	39 d0                	cmp    %edx,%eax
ffffffff801025ab:	73 0d                	jae    ffffffff801025ba <readi+0xde>
    n = ip->size - off;
ffffffff801025ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025b1:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801025b4:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffffffff801025b7:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffffffff801025ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801025c1:	e9 8d 00 00 00       	jmp    ffffffff80102653 <readi+0x177>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffffffff801025c6:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801025c9:	c1 e8 09             	shr    $0x9,%eax
ffffffff801025cc:	89 c2                	mov    %eax,%edx
ffffffff801025ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025d2:	89 d6                	mov    %edx,%esi
ffffffff801025d4:	48 89 c7             	mov    %rax,%rdi
ffffffff801025d7:	e8 3b fc ff ff       	call   ffffffff80102217 <bmap>
ffffffff801025dc:	89 c2                	mov    %eax,%edx
ffffffff801025de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025e2:	8b 00                	mov    (%rax),%eax
ffffffff801025e4:	89 d6                	mov    %edx,%esi
ffffffff801025e6:	89 c7                	mov    %eax,%edi
ffffffff801025e8:	e8 f2 dc ff ff       	call   ffffffff801002df <bread>
ffffffff801025ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffffffff801025f1:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801025f4:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff801025f9:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff801025fe:	29 c2                	sub    %eax,%edx
ffffffff80102600:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102603:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80102606:	39 c2                	cmp    %eax,%edx
ffffffff80102608:	0f 46 c2             	cmovbe %edx,%eax
ffffffff8010260b:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffffffff8010260e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102612:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80102616:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102619:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff8010261e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff80102622:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80102625:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80102629:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010262c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010262f:	e8 02 3c 00 00       	call   ffffffff80106236 <memmove>
    brelse(bp);
ffffffff80102634:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102638:	48 89 c7             	mov    %rax,%rdi
ffffffff8010263b:	e8 2c dd ff ff       	call   ffffffff8010036c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffffffff80102640:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80102643:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff80102646:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80102649:	01 45 cc             	add    %eax,-0x34(%rbp)
ffffffff8010264c:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff8010264f:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffffffff80102653:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102656:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffffffff80102659:	0f 82 67 ff ff ff    	jb     ffffffff801025c6 <readi+0xea>
  }
  return n;
ffffffff8010265f:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffffffff80102662:	c9                   	leave
ffffffff80102663:	c3                   	ret

ffffffff80102664 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffffffff80102664:	f3 0f 1e fa          	endbr64
ffffffff80102668:	55                   	push   %rbp
ffffffff80102669:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010266c:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80102670:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80102674:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80102678:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffffffff8010267b:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffffffff8010267e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102682:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80102686:	66 83 f8 03          	cmp    $0x3,%ax
ffffffff8010268a:	75 73                	jne    ffffffff801026ff <writei+0x9b>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffffffff8010268c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102690:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102694:	66 85 c0             	test   %ax,%ax
ffffffff80102697:	78 2b                	js     ffffffff801026c4 <writei+0x60>
ffffffff80102699:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010269d:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801026a1:	66 83 f8 09          	cmp    $0x9,%ax
ffffffff801026a5:	7f 1d                	jg     ffffffff801026c4 <writei+0x60>
ffffffff801026a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801026ab:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801026af:	98                   	cwtl
ffffffff801026b0:	48 98                	cltq
ffffffff801026b2:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801026b6:	48 05 a8 d9 10 80    	add    $0xffffffff8010d9a8,%rax
ffffffff801026bc:	48 8b 00             	mov    (%rax),%rax
ffffffff801026bf:	48 85 c0             	test   %rax,%rax
ffffffff801026c2:	75 0a                	jne    ffffffff801026ce <writei+0x6a>
      return -1;
ffffffff801026c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801026c9:	e9 49 01 00 00       	jmp    ffffffff80102817 <writei+0x1b3>
    return devsw[ip->major].write(ip, src, n);
ffffffff801026ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801026d2:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801026d6:	98                   	cwtl
ffffffff801026d7:	48 98                	cltq
ffffffff801026d9:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801026dd:	48 05 a8 d9 10 80    	add    $0xffffffff8010d9a8,%rax
ffffffff801026e3:	4c 8b 00             	mov    (%rax),%r8
ffffffff801026e6:	8b 55 c8             	mov    -0x38(%rbp),%edx
ffffffff801026e9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff801026ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801026f1:	48 89 ce             	mov    %rcx,%rsi
ffffffff801026f4:	48 89 c7             	mov    %rax,%rdi
ffffffff801026f7:	41 ff d0             	call   *%r8
ffffffff801026fa:	e9 18 01 00 00       	jmp    ffffffff80102817 <writei+0x1b3>
  }

  if(off > ip->size || off + n < off)
ffffffff801026ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102703:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102706:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102709:	72 0d                	jb     ffffffff80102718 <writei+0xb4>
ffffffff8010270b:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff8010270e:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102711:	01 d0                	add    %edx,%eax
ffffffff80102713:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102716:	73 0a                	jae    ffffffff80102722 <writei+0xbe>
    return -1;
ffffffff80102718:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010271d:	e9 f5 00 00 00       	jmp    ffffffff80102817 <writei+0x1b3>
  if(off + n > MAXFILE*BSIZE)
ffffffff80102722:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff80102725:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102728:	01 d0                	add    %edx,%eax
ffffffff8010272a:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffffffff8010272f:	76 0a                	jbe    ffffffff8010273b <writei+0xd7>
    return -1;
ffffffff80102731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102736:	e9 dc 00 00 00       	jmp    ffffffff80102817 <writei+0x1b3>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffffffff8010273b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102742:	e9 99 00 00 00       	jmp    ffffffff801027e0 <writei+0x17c>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffffffff80102747:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff8010274a:	c1 e8 09             	shr    $0x9,%eax
ffffffff8010274d:	89 c2                	mov    %eax,%edx
ffffffff8010274f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102753:	89 d6                	mov    %edx,%esi
ffffffff80102755:	48 89 c7             	mov    %rax,%rdi
ffffffff80102758:	e8 ba fa ff ff       	call   ffffffff80102217 <bmap>
ffffffff8010275d:	89 c2                	mov    %eax,%edx
ffffffff8010275f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102763:	8b 00                	mov    (%rax),%eax
ffffffff80102765:	89 d6                	mov    %edx,%esi
ffffffff80102767:	89 c7                	mov    %eax,%edi
ffffffff80102769:	e8 71 db ff ff       	call   ffffffff801002df <bread>
ffffffff8010276e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffffffff80102772:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102775:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff8010277a:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff8010277f:	29 c2                	sub    %eax,%edx
ffffffff80102781:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102784:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80102787:	39 c2                	cmp    %eax,%edx
ffffffff80102789:	0f 46 c2             	cmovbe %edx,%eax
ffffffff8010278c:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffffffff8010278f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102793:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80102797:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff8010279a:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff8010279f:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff801027a3:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801027a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801027aa:	48 89 c6             	mov    %rax,%rsi
ffffffff801027ad:	48 89 cf             	mov    %rcx,%rdi
ffffffff801027b0:	e8 81 3a 00 00       	call   ffffffff80106236 <memmove>
    log_write(bp);
ffffffff801027b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801027b9:	48 89 c7             	mov    %rax,%rdi
ffffffff801027bc:	e8 57 14 00 00       	call   ffffffff80103c18 <log_write>
    brelse(bp);
ffffffff801027c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801027c5:	48 89 c7             	mov    %rax,%rdi
ffffffff801027c8:	e8 9f db ff ff       	call   ffffffff8010036c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffffffff801027cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801027d0:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff801027d3:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801027d6:	01 45 cc             	add    %eax,-0x34(%rbp)
ffffffff801027d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801027dc:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffffffff801027e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801027e3:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffffffff801027e6:	0f 82 5b ff ff ff    	jb     ffffffff80102747 <writei+0xe3>
  }

  if(n > 0 && off > ip->size){
ffffffff801027ec:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffffffff801027f0:	74 22                	je     ffffffff80102814 <writei+0x1b0>
ffffffff801027f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801027f6:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801027f9:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff801027fc:	73 16                	jae    ffffffff80102814 <writei+0x1b0>
    ip->size = off;
ffffffff801027fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102802:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff80102805:	89 50 18             	mov    %edx,0x18(%rax)
    iupdate(ip);
ffffffff80102808:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010280c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010280f:	e8 fa f4 ff ff       	call   ffffffff80101d0e <iupdate>
  }
  return n;
ffffffff80102814:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffffffff80102817:	c9                   	leave
ffffffff80102818:	c3                   	ret

ffffffff80102819 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffffffff80102819:	f3 0f 1e fa          	endbr64
ffffffff8010281d:	55                   	push   %rbp
ffffffff8010281e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102821:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102825:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80102829:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffffffff8010282d:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102835:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff8010283a:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010283d:	48 89 c7             	mov    %rax,%rdi
ffffffff80102840:	e8 c7 3a 00 00       	call   ffffffff8010630c <strncmp>
}
ffffffff80102845:	c9                   	leave
ffffffff80102846:	c3                   	ret

ffffffff80102847 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffffffff80102847:	f3 0f 1e fa          	endbr64
ffffffff8010284b:	55                   	push   %rbp
ffffffff8010284c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010284f:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80102853:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80102857:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff8010285b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffffffff8010285f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102863:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80102867:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff8010286b:	74 0c                	je     ffffffff80102879 <dirlookup+0x32>
    panic("dirlookup not DIR");
ffffffff8010286d:	48 c7 c7 39 9c 10 80 	mov    $0xffffffff80109c39,%rdi
ffffffff80102874:	e8 d6 e0 ff ff       	call   ffffffff8010094f <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff80102879:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102880:	e9 80 00 00 00       	jmp    ffffffff80102905 <dirlookup+0xbe>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80102885:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102888:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff8010288c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102890:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80102895:	48 89 c7             	mov    %rax,%rdi
ffffffff80102898:	e8 3f fc ff ff       	call   ffffffff801024dc <readi>
ffffffff8010289d:	83 f8 10             	cmp    $0x10,%eax
ffffffff801028a0:	74 0c                	je     ffffffff801028ae <dirlookup+0x67>
      panic("dirlink read");
ffffffff801028a2:	48 c7 c7 4b 9c 10 80 	mov    $0xffffffff80109c4b,%rdi
ffffffff801028a9:	e8 a1 e0 ff ff       	call   ffffffff8010094f <panic>
    if(de.inum == 0)
ffffffff801028ae:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff801028b2:	66 85 c0             	test   %ax,%ax
ffffffff801028b5:	74 49                	je     ffffffff80102900 <dirlookup+0xb9>
      continue;
    if(namecmp(name, de.name) == 0){
ffffffff801028b7:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff801028bb:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffffffff801028bf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801028c3:	48 89 d6             	mov    %rdx,%rsi
ffffffff801028c6:	48 89 c7             	mov    %rax,%rdi
ffffffff801028c9:	e8 4b ff ff ff       	call   ffffffff80102819 <namecmp>
ffffffff801028ce:	85 c0                	test   %eax,%eax
ffffffff801028d0:	75 2f                	jne    ffffffff80102901 <dirlookup+0xba>
      // entry matches path element
      if(poff)
ffffffff801028d2:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff801028d7:	74 09                	je     ffffffff801028e2 <dirlookup+0x9b>
        *poff = off;
ffffffff801028d9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801028dd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801028e0:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffffffff801028e2:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff801028e6:	0f b7 c0             	movzwl %ax,%eax
ffffffff801028e9:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffffffff801028ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801028f0:	8b 00                	mov    (%rax),%eax
ffffffff801028f2:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff801028f5:	89 d6                	mov    %edx,%esi
ffffffff801028f7:	89 c7                	mov    %eax,%edi
ffffffff801028f9:	e8 e7 f4 ff ff       	call   ffffffff80101de5 <iget>
ffffffff801028fe:	eb 1a                	jmp    ffffffff8010291a <dirlookup+0xd3>
      continue;
ffffffff80102900:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff80102901:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffffffff80102905:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102909:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010290c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff8010290f:	0f 82 70 ff ff ff    	jb     ffffffff80102885 <dirlookup+0x3e>
    }
  }

  return 0;
ffffffff80102915:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010291a:	c9                   	leave
ffffffff8010291b:	c3                   	ret

ffffffff8010291c <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffffffff8010291c:	f3 0f 1e fa          	endbr64
ffffffff80102920:	55                   	push   %rbp
ffffffff80102921:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102924:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80102928:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff8010292c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80102930:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffffffff80102933:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff80102937:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010293b:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80102940:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102943:	48 89 c7             	mov    %rax,%rdi
ffffffff80102946:	e8 fc fe ff ff       	call   ffffffff80102847 <dirlookup>
ffffffff8010294b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff8010294f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80102954:	74 16                	je     ffffffff8010296c <dirlink+0x50>
    iput(ip);
ffffffff80102956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010295a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010295d:	e8 a1 f7 ff ff       	call   ffffffff80102103 <iput>
    return -1;
ffffffff80102962:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102967:	e9 a6 00 00 00       	jmp    ffffffff80102a12 <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff8010296c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102973:	eb 3b                	jmp    ffffffff801029b0 <dirlink+0x94>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80102975:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102978:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff8010297c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102980:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80102985:	48 89 c7             	mov    %rax,%rdi
ffffffff80102988:	e8 4f fb ff ff       	call   ffffffff801024dc <readi>
ffffffff8010298d:	83 f8 10             	cmp    $0x10,%eax
ffffffff80102990:	74 0c                	je     ffffffff8010299e <dirlink+0x82>
      panic("dirlink read");
ffffffff80102992:	48 c7 c7 4b 9c 10 80 	mov    $0xffffffff80109c4b,%rdi
ffffffff80102999:	e8 b1 df ff ff       	call   ffffffff8010094f <panic>
    if(de.inum == 0)
ffffffff8010299e:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff801029a2:	66 85 c0             	test   %ax,%ax
ffffffff801029a5:	74 19                	je     ffffffff801029c0 <dirlink+0xa4>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff801029a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801029aa:	83 c0 10             	add    $0x10,%eax
ffffffff801029ad:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801029b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801029b4:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801029b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801029ba:	39 c2                	cmp    %eax,%edx
ffffffff801029bc:	72 b7                	jb     ffffffff80102975 <dirlink+0x59>
ffffffff801029be:	eb 01                	jmp    ffffffff801029c1 <dirlink+0xa5>
      break;
ffffffff801029c0:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffffffff801029c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801029c5:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff801029c9:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffffffff801029cd:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff801029d2:	48 89 c6             	mov    %rax,%rsi
ffffffff801029d5:	48 89 cf             	mov    %rcx,%rdi
ffffffff801029d8:	e8 a0 39 00 00       	call   ffffffff8010637d <strncpy>
  de.inum = inum;
ffffffff801029dd:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801029e0:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff801029e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801029e7:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff801029eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801029ef:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff801029f4:	48 89 c7             	mov    %rax,%rdi
ffffffff801029f7:	e8 68 fc ff ff       	call   ffffffff80102664 <writei>
ffffffff801029fc:	83 f8 10             	cmp    $0x10,%eax
ffffffff801029ff:	74 0c                	je     ffffffff80102a0d <dirlink+0xf1>
    panic("dirlink");
ffffffff80102a01:	48 c7 c7 58 9c 10 80 	mov    $0xffffffff80109c58,%rdi
ffffffff80102a08:	e8 42 df ff ff       	call   ffffffff8010094f <panic>
  
  return 0;
ffffffff80102a0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80102a12:	c9                   	leave
ffffffff80102a13:	c3                   	ret

ffffffff80102a14 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffffffff80102a14:	f3 0f 1e fa          	endbr64
ffffffff80102a18:	55                   	push   %rbp
ffffffff80102a19:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102a1c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80102a20:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80102a24:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffffffff80102a28:	eb 05                	jmp    ffffffff80102a2f <skipelem+0x1b>
    path++;
ffffffff80102a2a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffffffff80102a2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a33:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a36:	3c 2f                	cmp    $0x2f,%al
ffffffff80102a38:	74 f0                	je     ffffffff80102a2a <skipelem+0x16>
  if(*path == 0)
ffffffff80102a3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a3e:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a41:	84 c0                	test   %al,%al
ffffffff80102a43:	75 0a                	jne    ffffffff80102a4f <skipelem+0x3b>
    return 0;
ffffffff80102a45:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102a4a:	e9 8c 00 00 00       	jmp    ffffffff80102adb <skipelem+0xc7>
  s = path;
ffffffff80102a4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffffffff80102a57:	eb 05                	jmp    ffffffff80102a5e <skipelem+0x4a>
    path++;
ffffffff80102a59:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffffffff80102a5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a62:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a65:	3c 2f                	cmp    $0x2f,%al
ffffffff80102a67:	74 0b                	je     ffffffff80102a74 <skipelem+0x60>
ffffffff80102a69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a6d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a70:	84 c0                	test   %al,%al
ffffffff80102a72:	75 e5                	jne    ffffffff80102a59 <skipelem+0x45>
  len = path - s;
ffffffff80102a74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a78:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffffffff80102a7c:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffffffff80102a7f:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffffffff80102a83:	7e 1a                	jle    ffffffff80102a9f <skipelem+0x8b>
    memmove(name, s, DIRSIZ);
ffffffff80102a85:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80102a89:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80102a8d:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff80102a92:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102a95:	48 89 c7             	mov    %rax,%rdi
ffffffff80102a98:	e8 99 37 00 00       	call   ffffffff80106236 <memmove>
ffffffff80102a9d:	eb 2d                	jmp    ffffffff80102acc <skipelem+0xb8>
  else {
    memmove(name, s, len);
ffffffff80102a9f:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80102aa2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80102aa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80102aaa:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102aad:	48 89 c7             	mov    %rax,%rdi
ffffffff80102ab0:	e8 81 37 00 00       	call   ffffffff80106236 <memmove>
    name[len] = 0;
ffffffff80102ab5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80102ab8:	48 63 d0             	movslq %eax,%rdx
ffffffff80102abb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80102abf:	48 01 d0             	add    %rdx,%rax
ffffffff80102ac2:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffffffff80102ac5:	eb 05                	jmp    ffffffff80102acc <skipelem+0xb8>
    path++;
ffffffff80102ac7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffffffff80102acc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102ad0:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102ad3:	3c 2f                	cmp    $0x2f,%al
ffffffff80102ad5:	74 f0                	je     ffffffff80102ac7 <skipelem+0xb3>
  return path;
ffffffff80102ad7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffffffff80102adb:	c9                   	leave
ffffffff80102adc:	c3                   	ret

ffffffff80102add <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffffffff80102add:	f3 0f 1e fa          	endbr64
ffffffff80102ae1:	55                   	push   %rbp
ffffffff80102ae2:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102ae5:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80102ae9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80102aed:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff80102af0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffffffff80102af4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102af8:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102afb:	3c 2f                	cmp    $0x2f,%al
ffffffff80102afd:	75 18                	jne    ffffffff80102b17 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
ffffffff80102aff:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102b04:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80102b09:	e8 d7 f2 ff ff       	call   ffffffff80101de5 <iget>
ffffffff80102b0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80102b12:	e9 c3 00 00 00       	jmp    ffffffff80102bda <namex+0xfd>
  else
    ip = idup(proc->cwd);
ffffffff80102b17:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80102b1e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80102b22:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff80102b29:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b2c:	e8 a8 f3 ff ff       	call   ffffffff80101ed9 <idup>
ffffffff80102b31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffffffff80102b35:	e9 a0 00 00 00       	jmp    ffffffff80102bda <namex+0xfd>
    ilock(ip);
ffffffff80102b3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b3e:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b41:	e8 d2 f3 ff ff       	call   ffffffff80101f18 <ilock>
    if(ip->type != T_DIR){
ffffffff80102b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b4a:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80102b4e:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80102b52:	74 16                	je     ffffffff80102b6a <namex+0x8d>
      iunlockput(ip);
ffffffff80102b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b58:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b5b:	e8 8c f6 ff ff       	call   ffffffff801021ec <iunlockput>
      return 0;
ffffffff80102b60:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102b65:	e9 af 00 00 00       	jmp    ffffffff80102c19 <namex+0x13c>
    }
    if(nameiparent && *path == '\0'){
ffffffff80102b6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffffffff80102b6e:	74 20                	je     ffffffff80102b90 <namex+0xb3>
ffffffff80102b70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102b74:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102b77:	84 c0                	test   %al,%al
ffffffff80102b79:	75 15                	jne    ffffffff80102b90 <namex+0xb3>
      // Stop one level early.
      iunlock(ip);
ffffffff80102b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b7f:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b82:	e8 06 f5 ff ff       	call   ffffffff8010208d <iunlock>
      return ip;
ffffffff80102b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b8b:	e9 89 00 00 00       	jmp    ffffffff80102c19 <namex+0x13c>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffffffff80102b90:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffffffff80102b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b98:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80102b9d:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102ba0:	48 89 c7             	mov    %rax,%rdi
ffffffff80102ba3:	e8 9f fc ff ff       	call   ffffffff80102847 <dirlookup>
ffffffff80102ba8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80102bac:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80102bb1:	75 13                	jne    ffffffff80102bc6 <namex+0xe9>
      iunlockput(ip);
ffffffff80102bb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102bb7:	48 89 c7             	mov    %rax,%rdi
ffffffff80102bba:	e8 2d f6 ff ff       	call   ffffffff801021ec <iunlockput>
      return 0;
ffffffff80102bbf:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102bc4:	eb 53                	jmp    ffffffff80102c19 <namex+0x13c>
    }
    iunlockput(ip);
ffffffff80102bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102bca:	48 89 c7             	mov    %rax,%rdi
ffffffff80102bcd:	e8 1a f6 ff ff       	call   ffffffff801021ec <iunlockput>
    ip = next;
ffffffff80102bd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102bd6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffffffff80102bda:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff80102bde:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102be2:	48 89 d6             	mov    %rdx,%rsi
ffffffff80102be5:	48 89 c7             	mov    %rax,%rdi
ffffffff80102be8:	e8 27 fe ff ff       	call   ffffffff80102a14 <skipelem>
ffffffff80102bed:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80102bf1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80102bf6:	0f 85 3e ff ff ff    	jne    ffffffff80102b3a <namex+0x5d>
  }
  if(nameiparent){
ffffffff80102bfc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffffffff80102c00:	74 13                	je     ffffffff80102c15 <namex+0x138>
    iput(ip);
ffffffff80102c02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102c06:	48 89 c7             	mov    %rax,%rdi
ffffffff80102c09:	e8 f5 f4 ff ff       	call   ffffffff80102103 <iput>
    return 0;
ffffffff80102c0e:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102c13:	eb 04                	jmp    ffffffff80102c19 <namex+0x13c>
  }
  return ip;
ffffffff80102c15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80102c19:	c9                   	leave
ffffffff80102c1a:	c3                   	ret

ffffffff80102c1b <namei>:

struct inode*
namei(char *path)
{
ffffffff80102c1b:	f3 0f 1e fa          	endbr64
ffffffff80102c1f:	55                   	push   %rbp
ffffffff80102c20:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c23:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80102c27:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffffffff80102c2b:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffffffff80102c2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102c33:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80102c38:	48 89 c7             	mov    %rax,%rdi
ffffffff80102c3b:	e8 9d fe ff ff       	call   ffffffff80102add <namex>
}
ffffffff80102c40:	c9                   	leave
ffffffff80102c41:	c3                   	ret

ffffffff80102c42 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffffffff80102c42:	f3 0f 1e fa          	endbr64
ffffffff80102c46:	55                   	push   %rbp
ffffffff80102c47:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c4a:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102c4e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80102c52:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffffffff80102c56:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80102c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102c5e:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102c63:	48 89 c7             	mov    %rax,%rdi
ffffffff80102c66:	e8 72 fe ff ff       	call   ffffffff80102add <namex>
}
ffffffff80102c6b:	c9                   	leave
ffffffff80102c6c:	c3                   	ret

ffffffff80102c6d <inb>:
{
ffffffff80102c6d:	55                   	push   %rbp
ffffffff80102c6e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c71:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80102c75:	89 f8                	mov    %edi,%eax
ffffffff80102c77:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80102c7b:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80102c7f:	89 c2                	mov    %eax,%edx
ffffffff80102c81:	ec                   	in     (%dx),%al
ffffffff80102c82:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80102c85:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80102c89:	c9                   	leave
ffffffff80102c8a:	c3                   	ret

ffffffff80102c8b <insl>:
{
ffffffff80102c8b:	55                   	push   %rbp
ffffffff80102c8c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c8f:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102c93:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80102c96:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102c9a:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep insl" :
ffffffff80102c9d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102ca0:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102ca4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102ca7:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102caa:	48 89 f7             	mov    %rsi,%rdi
ffffffff80102cad:	89 c1                	mov    %eax,%ecx
ffffffff80102caf:	fc                   	cld
ffffffff80102cb0:	f3 6d                	rep insl (%dx),%es:(%rdi)
ffffffff80102cb2:	89 c8                	mov    %ecx,%eax
ffffffff80102cb4:	48 89 fe             	mov    %rdi,%rsi
ffffffff80102cb7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102cbb:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffffffff80102cbe:	90                   	nop
ffffffff80102cbf:	c9                   	leave
ffffffff80102cc0:	c3                   	ret

ffffffff80102cc1 <outb>:
{
ffffffff80102cc1:	55                   	push   %rbp
ffffffff80102cc2:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102cc5:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80102cc9:	89 fa                	mov    %edi,%edx
ffffffff80102ccb:	89 f0                	mov    %esi,%eax
ffffffff80102ccd:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80102cd1:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80102cd4:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80102cd8:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80102cdc:	ee                   	out    %al,(%dx)
}
ffffffff80102cdd:	90                   	nop
ffffffff80102cde:	c9                   	leave
ffffffff80102cdf:	c3                   	ret

ffffffff80102ce0 <outsl>:
{
ffffffff80102ce0:	55                   	push   %rbp
ffffffff80102ce1:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102ce4:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102ce8:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80102ceb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102cef:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep outsl" :
ffffffff80102cf2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102cf5:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102cf9:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102cfc:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102cff:	89 c1                	mov    %eax,%ecx
ffffffff80102d01:	fc                   	cld
ffffffff80102d02:	f3 6f                	rep outsl %ds:(%rsi),(%dx)
ffffffff80102d04:	89 c8                	mov    %ecx,%eax
ffffffff80102d06:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102d0a:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffffffff80102d0d:	90                   	nop
ffffffff80102d0e:	c9                   	leave
ffffffff80102d0f:	c3                   	ret

ffffffff80102d10 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffffffff80102d10:	f3 0f 1e fa          	endbr64
ffffffff80102d14:	55                   	push   %rbp
ffffffff80102d15:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102d18:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80102d1c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
ffffffff80102d1f:	90                   	nop
ffffffff80102d20:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102d25:	e8 43 ff ff ff       	call   ffffffff80102c6d <inb>
ffffffff80102d2a:	0f b6 c0             	movzbl %al,%eax
ffffffff80102d2d:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102d30:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102d33:	25 c0 00 00 00       	and    $0xc0,%eax
ffffffff80102d38:	83 f8 40             	cmp    $0x40,%eax
ffffffff80102d3b:	75 e3                	jne    ffffffff80102d20 <idewait+0x10>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffffffff80102d3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80102d41:	74 11                	je     ffffffff80102d54 <idewait+0x44>
ffffffff80102d43:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102d46:	83 e0 21             	and    $0x21,%eax
ffffffff80102d49:	85 c0                	test   %eax,%eax
ffffffff80102d4b:	74 07                	je     ffffffff80102d54 <idewait+0x44>
    return -1;
ffffffff80102d4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102d52:	eb 05                	jmp    ffffffff80102d59 <idewait+0x49>
  return 0;
ffffffff80102d54:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80102d59:	c9                   	leave
ffffffff80102d5a:	c3                   	ret

ffffffff80102d5b <ideinit>:

void
ideinit(void)
{
ffffffff80102d5b:	f3 0f 1e fa          	endbr64
ffffffff80102d5f:	55                   	push   %rbp
ffffffff80102d60:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102d63:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  initlock(&idelock, "ide");
ffffffff80102d67:	48 c7 c6 60 9c 10 80 	mov    $0xffffffff80109c60,%rsi
ffffffff80102d6e:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102d75:	e8 00 30 00 00       	call   ffffffff80105d7a <initlock>
  picenable(IRQ_IDE);
ffffffff80102d7a:	bf 0e 00 00 00       	mov    $0xe,%edi
ffffffff80102d7f:	e8 0f 1c 00 00       	call   ffffffff80104993 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
ffffffff80102d84:	8b 05 5a d6 00 00    	mov    0xd65a(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80102d8a:	83 e8 01             	sub    $0x1,%eax
ffffffff80102d8d:	89 c6                	mov    %eax,%esi
ffffffff80102d8f:	bf 0e 00 00 00       	mov    $0xe,%edi
ffffffff80102d94:	e8 49 04 00 00       	call   ffffffff801031e2 <ioapicenable>
  idewait(0);
ffffffff80102d99:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80102d9e:	e8 6d ff ff ff       	call   ffffffff80102d10 <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffffffff80102da3:	be f0 00 00 00       	mov    $0xf0,%esi
ffffffff80102da8:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102dad:	e8 0f ff ff ff       	call   ffffffff80102cc1 <outb>
  for(i=0; i<1000; i++){
ffffffff80102db2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102db9:	eb 1e                	jmp    ffffffff80102dd9 <ideinit+0x7e>
    if(inb(0x1f7) != 0){
ffffffff80102dbb:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102dc0:	e8 a8 fe ff ff       	call   ffffffff80102c6d <inb>
ffffffff80102dc5:	84 c0                	test   %al,%al
ffffffff80102dc7:	74 0c                	je     ffffffff80102dd5 <ideinit+0x7a>
      havedisk1 = 1;
ffffffff80102dc9:	c7 05 1d cd 00 00 01 	movl   $0x1,0xcd1d(%rip)        # ffffffff8010faf0 <havedisk1>
ffffffff80102dd0:	00 00 00 
      break;
ffffffff80102dd3:	eb 0d                	jmp    ffffffff80102de2 <ideinit+0x87>
  for(i=0; i<1000; i++){
ffffffff80102dd5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80102dd9:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffffffff80102de0:	7e d9                	jle    ffffffff80102dbb <ideinit+0x60>
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffffffff80102de2:	be e0 00 00 00       	mov    $0xe0,%esi
ffffffff80102de7:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102dec:	e8 d0 fe ff ff       	call   ffffffff80102cc1 <outb>
}
ffffffff80102df1:	90                   	nop
ffffffff80102df2:	c9                   	leave
ffffffff80102df3:	c3                   	ret

ffffffff80102df4 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffffffff80102df4:	f3 0f 1e fa          	endbr64
ffffffff80102df8:	55                   	push   %rbp
ffffffff80102df9:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102dfc:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102e00:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(b == 0)
ffffffff80102e04:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80102e09:	75 0c                	jne    ffffffff80102e17 <idestart+0x23>
    panic("idestart");
ffffffff80102e0b:	48 c7 c7 64 9c 10 80 	mov    $0xffffffff80109c64,%rdi
ffffffff80102e12:	e8 38 db ff ff       	call   ffffffff8010094f <panic>

  idewait(0);
ffffffff80102e17:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80102e1c:	e8 ef fe ff ff       	call   ffffffff80102d10 <idewait>
  outb(0x3f6, 0);  // generate interrupt
ffffffff80102e21:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80102e26:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffffffff80102e2b:	e8 91 fe ff ff       	call   ffffffff80102cc1 <outb>
  outb(0x1f2, 1);  // number of sectors
ffffffff80102e30:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102e35:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffffffff80102e3a:	e8 82 fe ff ff       	call   ffffffff80102cc1 <outb>
  outb(0x1f3, b->sector & 0xff);
ffffffff80102e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e43:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102e46:	0f b6 c0             	movzbl %al,%eax
ffffffff80102e49:	89 c6                	mov    %eax,%esi
ffffffff80102e4b:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffffffff80102e50:	e8 6c fe ff ff       	call   ffffffff80102cc1 <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
ffffffff80102e55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e59:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102e5c:	c1 e8 08             	shr    $0x8,%eax
ffffffff80102e5f:	0f b6 c0             	movzbl %al,%eax
ffffffff80102e62:	89 c6                	mov    %eax,%esi
ffffffff80102e64:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffffffff80102e69:	e8 53 fe ff ff       	call   ffffffff80102cc1 <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
ffffffff80102e6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e72:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102e75:	c1 e8 10             	shr    $0x10,%eax
ffffffff80102e78:	0f b6 c0             	movzbl %al,%eax
ffffffff80102e7b:	89 c6                	mov    %eax,%esi
ffffffff80102e7d:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffffffff80102e82:	e8 3a fe ff ff       	call   ffffffff80102cc1 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
ffffffff80102e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e8b:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80102e8e:	c1 e0 04             	shl    $0x4,%eax
ffffffff80102e91:	83 e0 10             	and    $0x10,%eax
ffffffff80102e94:	89 c2                	mov    %eax,%edx
ffffffff80102e96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e9a:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102e9d:	c1 e8 18             	shr    $0x18,%eax
ffffffff80102ea0:	83 e0 0f             	and    $0xf,%eax
ffffffff80102ea3:	09 d0                	or     %edx,%eax
ffffffff80102ea5:	83 c8 e0             	or     $0xffffffe0,%eax
ffffffff80102ea8:	0f b6 c0             	movzbl %al,%eax
ffffffff80102eab:	89 c6                	mov    %eax,%esi
ffffffff80102ead:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102eb2:	e8 0a fe ff ff       	call   ffffffff80102cc1 <outb>
  if(b->flags & B_DIRTY){
ffffffff80102eb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ebb:	8b 00                	mov    (%rax),%eax
ffffffff80102ebd:	83 e0 04             	and    $0x4,%eax
ffffffff80102ec0:	85 c0                	test   %eax,%eax
ffffffff80102ec2:	74 2b                	je     ffffffff80102eef <idestart+0xfb>
    outb(0x1f7, IDE_CMD_WRITE);
ffffffff80102ec4:	be 30 00 00 00       	mov    $0x30,%esi
ffffffff80102ec9:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102ece:	e8 ee fd ff ff       	call   ffffffff80102cc1 <outb>
    outsl(0x1f0, b->data, 512/4);
ffffffff80102ed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ed7:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102edb:	ba 80 00 00 00       	mov    $0x80,%edx
ffffffff80102ee0:	48 89 c6             	mov    %rax,%rsi
ffffffff80102ee3:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffffffff80102ee8:	e8 f3 fd ff ff       	call   ffffffff80102ce0 <outsl>
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
ffffffff80102eed:	eb 0f                	jmp    ffffffff80102efe <idestart+0x10a>
    outb(0x1f7, IDE_CMD_READ);
ffffffff80102eef:	be 20 00 00 00       	mov    $0x20,%esi
ffffffff80102ef4:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102ef9:	e8 c3 fd ff ff       	call   ffffffff80102cc1 <outb>
}
ffffffff80102efe:	90                   	nop
ffffffff80102eff:	c9                   	leave
ffffffff80102f00:	c3                   	ret

ffffffff80102f01 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffffffff80102f01:	f3 0f 1e fa          	endbr64
ffffffff80102f05:	55                   	push   %rbp
ffffffff80102f06:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102f09:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffffffff80102f0d:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102f14:	e8 9a 2e 00 00       	call   ffffffff80105db3 <acquire>
  if((b = idequeue) == 0){
ffffffff80102f19:	48 8b 05 c8 cb 00 00 	mov    0xcbc8(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102f20:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80102f24:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80102f29:	75 11                	jne    ffffffff80102f3c <ideintr+0x3b>
    release(&idelock);
ffffffff80102f2b:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102f32:	e8 57 2f 00 00       	call   ffffffff80105e8e <release>
    // cprintf("spurious IDE interrupt\n");
    return;
ffffffff80102f37:	e9 99 00 00 00       	jmp    ffffffff80102fd5 <ideintr+0xd4>
  }
  idequeue = b->qnext;
ffffffff80102f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f40:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff80102f44:	48 89 05 9d cb 00 00 	mov    %rax,0xcb9d(%rip)        # ffffffff8010fae8 <idequeue>

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffffffff80102f4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f4f:	8b 00                	mov    (%rax),%eax
ffffffff80102f51:	83 e0 04             	and    $0x4,%eax
ffffffff80102f54:	85 c0                	test   %eax,%eax
ffffffff80102f56:	75 28                	jne    ffffffff80102f80 <ideintr+0x7f>
ffffffff80102f58:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80102f5d:	e8 ae fd ff ff       	call   ffffffff80102d10 <idewait>
ffffffff80102f62:	85 c0                	test   %eax,%eax
ffffffff80102f64:	78 1a                	js     ffffffff80102f80 <ideintr+0x7f>
    insl(0x1f0, b->data, 512/4);
ffffffff80102f66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f6a:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102f6e:	ba 80 00 00 00       	mov    $0x80,%edx
ffffffff80102f73:	48 89 c6             	mov    %rax,%rsi
ffffffff80102f76:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffffffff80102f7b:	e8 0b fd ff ff       	call   ffffffff80102c8b <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffffffff80102f80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f84:	8b 00                	mov    (%rax),%eax
ffffffff80102f86:	83 c8 02             	or     $0x2,%eax
ffffffff80102f89:	89 c2                	mov    %eax,%edx
ffffffff80102f8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f8f:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffffffff80102f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f95:	8b 00                	mov    (%rax),%eax
ffffffff80102f97:	83 e0 fb             	and    $0xfffffffb,%eax
ffffffff80102f9a:	89 c2                	mov    %eax,%edx
ffffffff80102f9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102fa0:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffffffff80102fa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102fa6:	48 89 c7             	mov    %rax,%rdi
ffffffff80102fa9:	e8 85 2b 00 00       	call   ffffffff80105b33 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
ffffffff80102fae:	48 8b 05 33 cb 00 00 	mov    0xcb33(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102fb5:	48 85 c0             	test   %rax,%rax
ffffffff80102fb8:	74 0f                	je     ffffffff80102fc9 <ideintr+0xc8>
    idestart(idequeue);
ffffffff80102fba:	48 8b 05 27 cb 00 00 	mov    0xcb27(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102fc1:	48 89 c7             	mov    %rax,%rdi
ffffffff80102fc4:	e8 2b fe ff ff       	call   ffffffff80102df4 <idestart>

  release(&idelock);
ffffffff80102fc9:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102fd0:	e8 b9 2e 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80102fd5:	c9                   	leave
ffffffff80102fd6:	c3                   	ret

ffffffff80102fd7 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffffffff80102fd7:	f3 0f 1e fa          	endbr64
ffffffff80102fdb:	55                   	push   %rbp
ffffffff80102fdc:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102fdf:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80102fe3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!(b->flags & B_BUSY))
ffffffff80102fe7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102feb:	8b 00                	mov    (%rax),%eax
ffffffff80102fed:	83 e0 01             	and    $0x1,%eax
ffffffff80102ff0:	85 c0                	test   %eax,%eax
ffffffff80102ff2:	75 0c                	jne    ffffffff80103000 <iderw+0x29>
    panic("iderw: buf not busy");
ffffffff80102ff4:	48 c7 c7 6d 9c 10 80 	mov    $0xffffffff80109c6d,%rdi
ffffffff80102ffb:	e8 4f d9 ff ff       	call   ffffffff8010094f <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffffffff80103000:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103004:	8b 00                	mov    (%rax),%eax
ffffffff80103006:	83 e0 06             	and    $0x6,%eax
ffffffff80103009:	83 f8 02             	cmp    $0x2,%eax
ffffffff8010300c:	75 0c                	jne    ffffffff8010301a <iderw+0x43>
    panic("iderw: nothing to do");
ffffffff8010300e:	48 c7 c7 81 9c 10 80 	mov    $0xffffffff80109c81,%rdi
ffffffff80103015:	e8 35 d9 ff ff       	call   ffffffff8010094f <panic>
  if(b->dev != 0 && !havedisk1)
ffffffff8010301a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010301e:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80103021:	85 c0                	test   %eax,%eax
ffffffff80103023:	74 16                	je     ffffffff8010303b <iderw+0x64>
ffffffff80103025:	8b 05 c5 ca 00 00    	mov    0xcac5(%rip),%eax        # ffffffff8010faf0 <havedisk1>
ffffffff8010302b:	85 c0                	test   %eax,%eax
ffffffff8010302d:	75 0c                	jne    ffffffff8010303b <iderw+0x64>
    panic("iderw: ide disk 1 not present");
ffffffff8010302f:	48 c7 c7 96 9c 10 80 	mov    $0xffffffff80109c96,%rdi
ffffffff80103036:	e8 14 d9 ff ff       	call   ffffffff8010094f <panic>

  acquire(&idelock);  //DOC:acquire-lock
ffffffff8010303b:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80103042:	e8 6c 2d 00 00       	call   ffffffff80105db3 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
ffffffff80103047:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010304b:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffffffff80103052:	00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffffffff80103053:	48 c7 45 f8 e8 fa 10 	movq   $0xffffffff8010fae8,-0x8(%rbp)
ffffffff8010305a:	80 
ffffffff8010305b:	eb 0f                	jmp    ffffffff8010306c <iderw+0x95>
ffffffff8010305d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103061:	48 8b 00             	mov    (%rax),%rax
ffffffff80103064:	48 83 c0 20          	add    $0x20,%rax
ffffffff80103068:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010306c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103070:	48 8b 00             	mov    (%rax),%rax
ffffffff80103073:	48 85 c0             	test   %rax,%rax
ffffffff80103076:	75 e5                	jne    ffffffff8010305d <iderw+0x86>
    ;
  *pp = b;
ffffffff80103078:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010307c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80103080:	48 89 10             	mov    %rdx,(%rax)
  
  // Start disk if necessary.
  if(idequeue == b)
ffffffff80103083:	48 8b 05 5e ca 00 00 	mov    0xca5e(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff8010308a:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff8010308e:	75 21                	jne    ffffffff801030b1 <iderw+0xda>
    idestart(b);
ffffffff80103090:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103094:	48 89 c7             	mov    %rax,%rdi
ffffffff80103097:	e8 58 fd ff ff       	call   ffffffff80102df4 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffffffff8010309c:	eb 13                	jmp    ffffffff801030b1 <iderw+0xda>
    sleep(b, &idelock);
ffffffff8010309e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801030a2:	48 c7 c6 80 fa 10 80 	mov    $0xffffffff8010fa80,%rsi
ffffffff801030a9:	48 89 c7             	mov    %rax,%rdi
ffffffff801030ac:	e8 66 29 00 00       	call   ffffffff80105a17 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffffffff801030b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801030b5:	8b 00                	mov    (%rax),%eax
ffffffff801030b7:	83 e0 06             	and    $0x6,%eax
ffffffff801030ba:	83 f8 02             	cmp    $0x2,%eax
ffffffff801030bd:	75 df                	jne    ffffffff8010309e <iderw+0xc7>
  }

  release(&idelock);
ffffffff801030bf:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff801030c6:	e8 c3 2d 00 00       	call   ffffffff80105e8e <release>
}
ffffffff801030cb:	90                   	nop
ffffffff801030cc:	c9                   	leave
ffffffff801030cd:	c3                   	ret

ffffffff801030ce <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffffffff801030ce:	f3 0f 1e fa          	endbr64
ffffffff801030d2:	55                   	push   %rbp
ffffffff801030d3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801030d6:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801030da:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffffffff801030dd:	48 8b 05 14 ca 00 00 	mov    0xca14(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff801030e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801030e7:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffffffff801030e9:	48 8b 05 08 ca 00 00 	mov    0xca08(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff801030f0:	8b 40 10             	mov    0x10(%rax),%eax
}
ffffffff801030f3:	c9                   	leave
ffffffff801030f4:	c3                   	ret

ffffffff801030f5 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffffffff801030f5:	f3 0f 1e fa          	endbr64
ffffffff801030f9:	55                   	push   %rbp
ffffffff801030fa:	48 89 e5             	mov    %rsp,%rbp
ffffffff801030fd:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103101:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80103104:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffffffff80103107:	48 8b 05 ea c9 00 00 	mov    0xc9ea(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff8010310e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103111:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffffffff80103113:	48 8b 05 de c9 00 00 	mov    0xc9de(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff8010311a:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff8010311d:	89 50 10             	mov    %edx,0x10(%rax)
}
ffffffff80103120:	90                   	nop
ffffffff80103121:	c9                   	leave
ffffffff80103122:	c3                   	ret

ffffffff80103123 <ioapicinit>:

void
ioapicinit(void)
{
ffffffff80103123:	f3 0f 1e fa          	endbr64
ffffffff80103127:	55                   	push   %rbp
ffffffff80103128:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010312b:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  if(!ismp)
ffffffff8010312f:	8b 05 ab d2 00 00    	mov    0xd2ab(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff80103135:	85 c0                	test   %eax,%eax
ffffffff80103137:	0f 84 a2 00 00 00    	je     ffffffff801031df <ioapicinit+0xbc>
    return;

  ioapic = (volatile struct ioapic*) IO2V(IOAPIC);
ffffffff8010313d:	48 b8 00 00 c0 40 ff 	movabs $0xffffffff40c00000,%rax
ffffffff80103144:	ff ff ff 
ffffffff80103147:	48 89 05 aa c9 00 00 	mov    %rax,0xc9aa(%rip)        # ffffffff8010faf8 <ioapic>
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffffffff8010314e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80103153:	e8 76 ff ff ff       	call   ffffffff801030ce <ioapicread>
ffffffff80103158:	c1 e8 10             	shr    $0x10,%eax
ffffffff8010315b:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff80103160:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffffffff80103163:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80103168:	e8 61 ff ff ff       	call   ffffffff801030ce <ioapicread>
ffffffff8010316d:	c1 e8 18             	shr    $0x18,%eax
ffffffff80103170:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffffffff80103173:	0f b6 05 6e d2 00 00 	movzbl 0xd26e(%rip),%eax        # ffffffff801103e8 <ioapicid>
ffffffff8010317a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010317d:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffffffff80103180:	74 11                	je     ffffffff80103193 <ioapicinit+0x70>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffffffff80103182:	48 c7 c7 b8 9c 10 80 	mov    $0xffffffff80109cb8,%rdi
ffffffff80103189:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010318e:	e8 2d d4 ff ff       	call   ffffffff801005c0 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffffffff80103193:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff8010319a:	eb 39                	jmp    ffffffff801031d5 <ioapicinit+0xb2>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffffffff8010319c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010319f:	83 c0 20             	add    $0x20,%eax
ffffffff801031a2:	0d 00 00 01 00       	or     $0x10000,%eax
ffffffff801031a7:	89 c2                	mov    %eax,%edx
ffffffff801031a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801031ac:	83 c0 08             	add    $0x8,%eax
ffffffff801031af:	01 c0                	add    %eax,%eax
ffffffff801031b1:	89 d6                	mov    %edx,%esi
ffffffff801031b3:	89 c7                	mov    %eax,%edi
ffffffff801031b5:	e8 3b ff ff ff       	call   ffffffff801030f5 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffffffff801031ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801031bd:	83 c0 08             	add    $0x8,%eax
ffffffff801031c0:	01 c0                	add    %eax,%eax
ffffffff801031c2:	83 c0 01             	add    $0x1,%eax
ffffffff801031c5:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801031ca:	89 c7                	mov    %eax,%edi
ffffffff801031cc:	e8 24 ff ff ff       	call   ffffffff801030f5 <ioapicwrite>
  for(i = 0; i <= maxintr; i++){
ffffffff801031d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801031d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801031d8:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffffffff801031db:	7e bf                	jle    ffffffff8010319c <ioapicinit+0x79>
ffffffff801031dd:	eb 01                	jmp    ffffffff801031e0 <ioapicinit+0xbd>
    return;
ffffffff801031df:	90                   	nop
  }
}
ffffffff801031e0:	c9                   	leave
ffffffff801031e1:	c3                   	ret

ffffffff801031e2 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffffffff801031e2:	f3 0f 1e fa          	endbr64
ffffffff801031e6:	55                   	push   %rbp
ffffffff801031e7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801031ea:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801031ee:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff801031f1:	89 75 f8             	mov    %esi,-0x8(%rbp)
  if(!ismp)
ffffffff801031f4:	8b 05 e6 d1 00 00    	mov    0xd1e6(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff801031fa:	85 c0                	test   %eax,%eax
ffffffff801031fc:	74 37                	je     ffffffff80103235 <ioapicenable+0x53>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffffffff801031fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103201:	83 c0 20             	add    $0x20,%eax
ffffffff80103204:	89 c2                	mov    %eax,%edx
ffffffff80103206:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103209:	83 c0 08             	add    $0x8,%eax
ffffffff8010320c:	01 c0                	add    %eax,%eax
ffffffff8010320e:	89 d6                	mov    %edx,%esi
ffffffff80103210:	89 c7                	mov    %eax,%edi
ffffffff80103212:	e8 de fe ff ff       	call   ffffffff801030f5 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffffffff80103217:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010321a:	c1 e0 18             	shl    $0x18,%eax
ffffffff8010321d:	89 c2                	mov    %eax,%edx
ffffffff8010321f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103222:	83 c0 08             	add    $0x8,%eax
ffffffff80103225:	01 c0                	add    %eax,%eax
ffffffff80103227:	83 c0 01             	add    $0x1,%eax
ffffffff8010322a:	89 d6                	mov    %edx,%esi
ffffffff8010322c:	89 c7                	mov    %eax,%edi
ffffffff8010322e:	e8 c2 fe ff ff       	call   ffffffff801030f5 <ioapicwrite>
ffffffff80103233:	eb 01                	jmp    ffffffff80103236 <ioapicenable+0x54>
    return;
ffffffff80103235:	90                   	nop
}
ffffffff80103236:	c9                   	leave
ffffffff80103237:	c3                   	ret

ffffffff80103238 <v2p>:
#endif
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff80103238:	55                   	push   %rbp
ffffffff80103239:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010323c:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103240:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103244:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103248:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff8010324d:	48 01 d0             	add    %rdx,%rax
ffffffff80103250:	c9                   	leave
ffffffff80103251:	c3                   	ret

ffffffff80103252 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
ffffffff80103252:	f3 0f 1e fa          	endbr64
ffffffff80103256:	55                   	push   %rbp
ffffffff80103257:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010325a:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010325e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103262:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffffffff80103266:	48 c7 c6 ea 9c 10 80 	mov    $0xffffffff80109cea,%rsi
ffffffff8010326d:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff80103274:	e8 01 2b 00 00       	call   ffffffff80105d7a <initlock>
  kmem.use_lock = 0;
ffffffff80103279:	c7 05 e5 c8 00 00 00 	movl   $0x0,0xc8e5(%rip)        # ffffffff8010fb68 <kmem+0x68>
ffffffff80103280:	00 00 00 
  freerange(vstart, vend);
ffffffff80103283:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80103287:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010328b:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010328e:	48 89 c7             	mov    %rax,%rdi
ffffffff80103291:	e8 37 00 00 00       	call   ffffffff801032cd <freerange>
}
ffffffff80103296:	90                   	nop
ffffffff80103297:	c9                   	leave
ffffffff80103298:	c3                   	ret

ffffffff80103299 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
ffffffff80103299:	f3 0f 1e fa          	endbr64
ffffffff8010329d:	55                   	push   %rbp
ffffffff8010329e:	48 89 e5             	mov    %rsp,%rbp
ffffffff801032a1:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801032a5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801032a9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  freerange(vstart, vend);
ffffffff801032ad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801032b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801032b5:	48 89 d6             	mov    %rdx,%rsi
ffffffff801032b8:	48 89 c7             	mov    %rax,%rdi
ffffffff801032bb:	e8 0d 00 00 00       	call   ffffffff801032cd <freerange>
  kmem.use_lock = 1;
ffffffff801032c0:	c7 05 9e c8 00 00 01 	movl   $0x1,0xc89e(%rip)        # ffffffff8010fb68 <kmem+0x68>
ffffffff801032c7:	00 00 00 
}
ffffffff801032ca:	90                   	nop
ffffffff801032cb:	c9                   	leave
ffffffff801032cc:	c3                   	ret

ffffffff801032cd <freerange>:

void
freerange(void *vstart, void *vend)
{
ffffffff801032cd:	f3 0f 1e fa          	endbr64
ffffffff801032d1:	55                   	push   %rbp
ffffffff801032d2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801032d5:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801032d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801032dd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((uintp)vstart);
ffffffff801032e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801032e5:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff801032eb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff801032f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffffffff801032f5:	eb 14                	jmp    ffffffff8010330b <freerange+0x3e>
    kfree(p);
ffffffff801032f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801032fb:	48 89 c7             	mov    %rax,%rdi
ffffffff801032fe:	e8 1c 00 00 00       	call   ffffffff8010331f <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffffffff80103303:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff8010330a:	00 
ffffffff8010330b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010330f:	48 05 00 10 00 00    	add    $0x1000,%rax
ffffffff80103315:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffffffff80103319:	73 dc                	jae    ffffffff801032f7 <freerange+0x2a>
}
ffffffff8010331b:	90                   	nop
ffffffff8010331c:	90                   	nop
ffffffff8010331d:	c9                   	leave
ffffffff8010331e:	c3                   	ret

ffffffff8010331f <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffffffff8010331f:	f3 0f 1e fa          	endbr64
ffffffff80103323:	55                   	push   %rbp
ffffffff80103324:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103327:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010332b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((uintp)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
ffffffff8010332f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103333:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80103338:	48 85 c0             	test   %rax,%rax
ffffffff8010333b:	75 1e                	jne    ffffffff8010335b <kfree+0x3c>
ffffffff8010333d:	48 81 7d e8 00 50 11 	cmpq   $0xffffffff80115000,-0x18(%rbp)
ffffffff80103344:	80 
ffffffff80103345:	72 14                	jb     ffffffff8010335b <kfree+0x3c>
ffffffff80103347:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010334b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010334e:	e8 e5 fe ff ff       	call   ffffffff80103238 <v2p>
ffffffff80103353:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffffffff80103359:	76 0c                	jbe    ffffffff80103367 <kfree+0x48>
    panic("kfree");
ffffffff8010335b:	48 c7 c7 ef 9c 10 80 	mov    $0xffffffff80109cef,%rdi
ffffffff80103362:	e8 e8 d5 ff ff       	call   ffffffff8010094f <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffffffff80103367:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010336b:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80103370:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80103375:	48 89 c7             	mov    %rax,%rdi
ffffffff80103378:	e8 c2 2d 00 00       	call   ffffffff8010613f <memset>

  if(kmem.use_lock)
ffffffff8010337d:	8b 05 e5 c7 00 00    	mov    0xc7e5(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff80103383:	85 c0                	test   %eax,%eax
ffffffff80103385:	74 0c                	je     ffffffff80103393 <kfree+0x74>
    acquire(&kmem.lock);
ffffffff80103387:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff8010338e:	e8 20 2a 00 00       	call   ffffffff80105db3 <acquire>
  r = (struct run*)v;
ffffffff80103393:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103397:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffffffff8010339b:	48 8b 15 ce c7 00 00 	mov    0xc7ce(%rip),%rdx        # ffffffff8010fb70 <kmem+0x70>
ffffffff801033a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801033a6:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffffffff801033a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801033ad:	48 89 05 bc c7 00 00 	mov    %rax,0xc7bc(%rip)        # ffffffff8010fb70 <kmem+0x70>
  if(kmem.use_lock)
ffffffff801033b4:	8b 05 ae c7 00 00    	mov    0xc7ae(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff801033ba:	85 c0                	test   %eax,%eax
ffffffff801033bc:	74 0c                	je     ffffffff801033ca <kfree+0xab>
    release(&kmem.lock);
ffffffff801033be:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff801033c5:	e8 c4 2a 00 00       	call   ffffffff80105e8e <release>
}
ffffffff801033ca:	90                   	nop
ffffffff801033cb:	c9                   	leave
ffffffff801033cc:	c3                   	ret

ffffffff801033cd <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffffffff801033cd:	f3 0f 1e fa          	endbr64
ffffffff801033d1:	55                   	push   %rbp
ffffffff801033d2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801033d5:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffffffff801033d9:	8b 05 89 c7 00 00    	mov    0xc789(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff801033df:	85 c0                	test   %eax,%eax
ffffffff801033e1:	74 0c                	je     ffffffff801033ef <kalloc+0x22>
    acquire(&kmem.lock);
ffffffff801033e3:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff801033ea:	e8 c4 29 00 00       	call   ffffffff80105db3 <acquire>
  r = kmem.freelist;
ffffffff801033ef:	48 8b 05 7a c7 00 00 	mov    0xc77a(%rip),%rax        # ffffffff8010fb70 <kmem+0x70>
ffffffff801033f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffffffff801033fa:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801033ff:	74 0e                	je     ffffffff8010340f <kalloc+0x42>
    kmem.freelist = r->next;
ffffffff80103401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103405:	48 8b 00             	mov    (%rax),%rax
ffffffff80103408:	48 89 05 61 c7 00 00 	mov    %rax,0xc761(%rip)        # ffffffff8010fb70 <kmem+0x70>
  if(kmem.use_lock)
ffffffff8010340f:	8b 05 53 c7 00 00    	mov    0xc753(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff80103415:	85 c0                	test   %eax,%eax
ffffffff80103417:	74 0c                	je     ffffffff80103425 <kalloc+0x58>
    release(&kmem.lock);
ffffffff80103419:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff80103420:	e8 69 2a 00 00       	call   ffffffff80105e8e <release>
  return (char*)r;
ffffffff80103425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80103429:	c9                   	leave
ffffffff8010342a:	c3                   	ret

ffffffff8010342b <inb>:
{
ffffffff8010342b:	55                   	push   %rbp
ffffffff8010342c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010342f:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80103433:	89 f8                	mov    %edi,%eax
ffffffff80103435:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80103439:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff8010343d:	89 c2                	mov    %eax,%edx
ffffffff8010343f:	ec                   	in     (%dx),%al
ffffffff80103440:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80103443:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80103447:	c9                   	leave
ffffffff80103448:	c3                   	ret

ffffffff80103449 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffffffff80103449:	f3 0f 1e fa          	endbr64
ffffffff8010344d:	55                   	push   %rbp
ffffffff8010344e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103451:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffffffff80103455:	bf 64 00 00 00       	mov    $0x64,%edi
ffffffff8010345a:	e8 cc ff ff ff       	call   ffffffff8010342b <inb>
ffffffff8010345f:	0f b6 c0             	movzbl %al,%eax
ffffffff80103462:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffffffff80103465:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80103468:	83 e0 01             	and    $0x1,%eax
ffffffff8010346b:	85 c0                	test   %eax,%eax
ffffffff8010346d:	75 0a                	jne    ffffffff80103479 <kbdgetc+0x30>
    return -1;
ffffffff8010346f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80103474:	e9 32 01 00 00       	jmp    ffffffff801035ab <kbdgetc+0x162>
  data = inb(KBDATAP);
ffffffff80103479:	bf 60 00 00 00       	mov    $0x60,%edi
ffffffff8010347e:	e8 a8 ff ff ff       	call   ffffffff8010342b <inb>
ffffffff80103483:	0f b6 c0             	movzbl %al,%eax
ffffffff80103486:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffffffff80103489:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffffffff80103490:	75 19                	jne    ffffffff801034ab <kbdgetc+0x62>
    shift |= E0ESC;
ffffffff80103492:	8b 05 e0 c6 00 00    	mov    0xc6e0(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103498:	83 c8 40             	or     $0x40,%eax
ffffffff8010349b:	89 05 d7 c6 00 00    	mov    %eax,0xc6d7(%rip)        # ffffffff8010fb78 <shift.1>
    return 0;
ffffffff801034a1:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801034a6:	e9 00 01 00 00       	jmp    ffffffff801035ab <kbdgetc+0x162>
  } else if(data & 0x80){
ffffffff801034ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801034ae:	25 80 00 00 00       	and    $0x80,%eax
ffffffff801034b3:	85 c0                	test   %eax,%eax
ffffffff801034b5:	74 47                	je     ffffffff801034fe <kbdgetc+0xb5>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffffffff801034b7:	8b 05 bb c6 00 00    	mov    0xc6bb(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff801034bd:	83 e0 40             	and    $0x40,%eax
ffffffff801034c0:	85 c0                	test   %eax,%eax
ffffffff801034c2:	75 08                	jne    ffffffff801034cc <kbdgetc+0x83>
ffffffff801034c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801034c7:	83 e0 7f             	and    $0x7f,%eax
ffffffff801034ca:	eb 03                	jmp    ffffffff801034cf <kbdgetc+0x86>
ffffffff801034cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801034cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffffffff801034d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801034d5:	0f b6 80 20 b0 10 80 	movzbl -0x7fef4fe0(%rax),%eax
ffffffff801034dc:	83 c8 40             	or     $0x40,%eax
ffffffff801034df:	0f b6 c0             	movzbl %al,%eax
ffffffff801034e2:	f7 d0                	not    %eax
ffffffff801034e4:	89 c2                	mov    %eax,%edx
ffffffff801034e6:	8b 05 8c c6 00 00    	mov    0xc68c(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff801034ec:	21 d0                	and    %edx,%eax
ffffffff801034ee:	89 05 84 c6 00 00    	mov    %eax,0xc684(%rip)        # ffffffff8010fb78 <shift.1>
    return 0;
ffffffff801034f4:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801034f9:	e9 ad 00 00 00       	jmp    ffffffff801035ab <kbdgetc+0x162>
  } else if(shift & E0ESC){
ffffffff801034fe:	8b 05 74 c6 00 00    	mov    0xc674(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103504:	83 e0 40             	and    $0x40,%eax
ffffffff80103507:	85 c0                	test   %eax,%eax
ffffffff80103509:	74 16                	je     ffffffff80103521 <kbdgetc+0xd8>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffffffff8010350b:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffffffff80103512:	8b 05 60 c6 00 00    	mov    0xc660(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103518:	83 e0 bf             	and    $0xffffffbf,%eax
ffffffff8010351b:	89 05 57 c6 00 00    	mov    %eax,0xc657(%rip)        # ffffffff8010fb78 <shift.1>
  }

  shift |= shiftcode[data];
ffffffff80103521:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103524:	0f b6 80 20 b0 10 80 	movzbl -0x7fef4fe0(%rax),%eax
ffffffff8010352b:	0f b6 d0             	movzbl %al,%edx
ffffffff8010352e:	8b 05 44 c6 00 00    	mov    0xc644(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103534:	09 d0                	or     %edx,%eax
ffffffff80103536:	89 05 3c c6 00 00    	mov    %eax,0xc63c(%rip)        # ffffffff8010fb78 <shift.1>
  shift ^= togglecode[data];
ffffffff8010353c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010353f:	0f b6 80 20 b1 10 80 	movzbl -0x7fef4ee0(%rax),%eax
ffffffff80103546:	0f b6 d0             	movzbl %al,%edx
ffffffff80103549:	8b 05 29 c6 00 00    	mov    0xc629(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff8010354f:	31 d0                	xor    %edx,%eax
ffffffff80103551:	89 05 21 c6 00 00    	mov    %eax,0xc621(%rip)        # ffffffff8010fb78 <shift.1>
  c = charcode[shift & (CTL | SHIFT)][data];
ffffffff80103557:	8b 05 1b c6 00 00    	mov    0xc61b(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff8010355d:	83 e0 03             	and    $0x3,%eax
ffffffff80103560:	89 c0                	mov    %eax,%eax
ffffffff80103562:	48 8b 14 c5 20 b5 10 	mov    -0x7fef4ae0(,%rax,8),%rdx
ffffffff80103569:	80 
ffffffff8010356a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010356d:	48 01 d0             	add    %rdx,%rax
ffffffff80103570:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103573:	0f b6 c0             	movzbl %al,%eax
ffffffff80103576:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffffffff80103579:	8b 05 f9 c5 00 00    	mov    0xc5f9(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff8010357f:	83 e0 08             	and    $0x8,%eax
ffffffff80103582:	85 c0                	test   %eax,%eax
ffffffff80103584:	74 22                	je     ffffffff801035a8 <kbdgetc+0x15f>
    if('a' <= c && c <= 'z')
ffffffff80103586:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffffffff8010358a:	76 0c                	jbe    ffffffff80103598 <kbdgetc+0x14f>
ffffffff8010358c:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffffffff80103590:	77 06                	ja     ffffffff80103598 <kbdgetc+0x14f>
      c += 'A' - 'a';
ffffffff80103592:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffffffff80103596:	eb 10                	jmp    ffffffff801035a8 <kbdgetc+0x15f>
    else if('A' <= c && c <= 'Z')
ffffffff80103598:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffffffff8010359c:	76 0a                	jbe    ffffffff801035a8 <kbdgetc+0x15f>
ffffffff8010359e:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffffffff801035a2:	77 04                	ja     ffffffff801035a8 <kbdgetc+0x15f>
      c += 'a' - 'A';
ffffffff801035a4:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffffffff801035a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffffffff801035ab:	c9                   	leave
ffffffff801035ac:	c3                   	ret

ffffffff801035ad <kbdintr>:

void
kbdintr(void)
{
ffffffff801035ad:	f3 0f 1e fa          	endbr64
ffffffff801035b1:	55                   	push   %rbp
ffffffff801035b2:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffffffff801035b5:	48 c7 c7 49 34 10 80 	mov    $0xffffffff80103449,%rdi
ffffffff801035bc:	e8 2e d6 ff ff       	call   ffffffff80100bef <consoleintr>
}
ffffffff801035c1:	90                   	nop
ffffffff801035c2:	5d                   	pop    %rbp
ffffffff801035c3:	c3                   	ret

ffffffff801035c4 <outb>:
{
ffffffff801035c4:	55                   	push   %rbp
ffffffff801035c5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801035c8:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801035cc:	89 fa                	mov    %edi,%edx
ffffffff801035ce:	89 f0                	mov    %esi,%eax
ffffffff801035d0:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801035d4:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801035d7:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff801035db:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff801035df:	ee                   	out    %al,(%dx)
}
ffffffff801035e0:	90                   	nop
ffffffff801035e1:	c9                   	leave
ffffffff801035e2:	c3                   	ret

ffffffff801035e3 <readeflags>:
{
ffffffff801035e3:	55                   	push   %rbp
ffffffff801035e4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801035e7:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff801035eb:	9c                   	pushf
ffffffff801035ec:	58                   	pop    %rax
ffffffff801035ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff801035f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801035f5:	c9                   	leave
ffffffff801035f6:	c3                   	ret

ffffffff801035f7 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffffffff801035f7:	f3 0f 1e fa          	endbr64
ffffffff801035fb:	55                   	push   %rbp
ffffffff801035fc:	48 89 e5             	mov    %rsp,%rbp
ffffffff801035ff:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103603:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80103606:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffffffff80103609:	48 8b 05 70 c5 00 00 	mov    0xc570(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103610:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103613:	48 63 d2             	movslq %edx,%rdx
ffffffff80103616:	48 c1 e2 02          	shl    $0x2,%rdx
ffffffff8010361a:	48 01 c2             	add    %rax,%rdx
ffffffff8010361d:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80103620:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffffffff80103622:	48 8b 05 57 c5 00 00 	mov    0xc557(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103629:	48 83 c0 20          	add    $0x20,%rax
ffffffff8010362d:	8b 00                	mov    (%rax),%eax
}
ffffffff8010362f:	90                   	nop
ffffffff80103630:	c9                   	leave
ffffffff80103631:	c3                   	ret

ffffffff80103632 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
ffffffff80103632:	f3 0f 1e fa          	endbr64
ffffffff80103636:	55                   	push   %rbp
ffffffff80103637:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic) 
ffffffff8010363a:	48 8b 05 3f c5 00 00 	mov    0xc53f(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103641:	48 85 c0             	test   %rax,%rax
ffffffff80103644:	0f 84 03 01 00 00    	je     ffffffff8010374d <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffffffff8010364a:	be 3f 01 00 00       	mov    $0x13f,%esi
ffffffff8010364f:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffffffff80103654:	e8 9e ff ff ff       	call   ffffffff801035f7 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffffffff80103659:	be 0b 00 00 00       	mov    $0xb,%esi
ffffffff8010365e:	bf f8 00 00 00       	mov    $0xf8,%edi
ffffffff80103663:	e8 8f ff ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffffffff80103668:	be 20 00 02 00       	mov    $0x20020,%esi
ffffffff8010366d:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff80103672:	e8 80 ff ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(TICR, 10000000); 
ffffffff80103677:	be 80 96 98 00       	mov    $0x989680,%esi
ffffffff8010367c:	bf e0 00 00 00       	mov    $0xe0,%edi
ffffffff80103681:	e8 71 ff ff ff       	call   ffffffff801035f7 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffffffff80103686:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff8010368b:	bf d4 00 00 00       	mov    $0xd4,%edi
ffffffff80103690:	e8 62 ff ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(LINT1, MASKED);
ffffffff80103695:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff8010369a:	bf d8 00 00 00       	mov    $0xd8,%edi
ffffffff8010369f:	e8 53 ff ff ff       	call   ffffffff801035f7 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffffffff801036a4:	48 8b 05 d5 c4 00 00 	mov    0xc4d5(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff801036ab:	48 83 c0 30          	add    $0x30,%rax
ffffffff801036af:	8b 00                	mov    (%rax),%eax
ffffffff801036b1:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffffffff801036b6:	85 c0                	test   %eax,%eax
ffffffff801036b8:	74 0f                	je     ffffffff801036c9 <lapicinit+0x97>
    lapicw(PCINT, MASKED);
ffffffff801036ba:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff801036bf:	bf d0 00 00 00       	mov    $0xd0,%edi
ffffffff801036c4:	e8 2e ff ff ff       	call   ffffffff801035f7 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffffffff801036c9:	be 33 00 00 00       	mov    $0x33,%esi
ffffffff801036ce:	bf dc 00 00 00       	mov    $0xdc,%edi
ffffffff801036d3:	e8 1f ff ff ff       	call   ffffffff801035f7 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffffffff801036d8:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801036dd:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff801036e2:	e8 10 ff ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(ESR, 0);
ffffffff801036e7:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801036ec:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff801036f1:	e8 01 ff ff ff       	call   ffffffff801035f7 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffffffff801036f6:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801036fb:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffffffff80103700:	e8 f2 fe ff ff       	call   ffffffff801035f7 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffffffff80103705:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010370a:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff8010370f:	e8 e3 fe ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffffffff80103714:	be 00 85 08 00       	mov    $0x88500,%esi
ffffffff80103719:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff8010371e:	e8 d4 fe ff ff       	call   ffffffff801035f7 <lapicw>
  while(lapic[ICRLO] & DELIVS)
ffffffff80103723:	90                   	nop
ffffffff80103724:	48 8b 05 55 c4 00 00 	mov    0xc455(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff8010372b:	48 05 00 03 00 00    	add    $0x300,%rax
ffffffff80103731:	8b 00                	mov    (%rax),%eax
ffffffff80103733:	25 00 10 00 00       	and    $0x1000,%eax
ffffffff80103738:	85 c0                	test   %eax,%eax
ffffffff8010373a:	75 e8                	jne    ffffffff80103724 <lapicinit+0xf2>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffffffff8010373c:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80103741:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80103746:	e8 ac fe ff ff       	call   ffffffff801035f7 <lapicw>
ffffffff8010374b:	eb 01                	jmp    ffffffff8010374e <lapicinit+0x11c>
    return;
ffffffff8010374d:	90                   	nop
}
ffffffff8010374e:	5d                   	pop    %rbp
ffffffff8010374f:	c3                   	ret

ffffffff80103750 <cpunum>:
// This is only used during secondary processor startup.
// cpu->id is the fast way to get the cpu number, once the
// processor is fully started.
int
cpunum(void)
{
ffffffff80103750:	f3 0f 1e fa          	endbr64
ffffffff80103754:	55                   	push   %rbp
ffffffff80103755:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103758:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffffffff8010375c:	e8 82 fe ff ff       	call   ffffffff801035e3 <readeflags>
ffffffff80103761:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80103766:	48 85 c0             	test   %rax,%rax
ffffffff80103769:	74 2b                	je     ffffffff80103796 <cpunum+0x46>
    static int n;
    if(n++ == 0)
ffffffff8010376b:	8b 05 17 c4 00 00    	mov    0xc417(%rip),%eax        # ffffffff8010fb88 <n.0>
ffffffff80103771:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80103774:	89 15 0e c4 00 00    	mov    %edx,0xc40e(%rip)        # ffffffff8010fb88 <n.0>
ffffffff8010377a:	85 c0                	test   %eax,%eax
ffffffff8010377c:	75 18                	jne    ffffffff80103796 <cpunum+0x46>
      cprintf("cpu called from %x with interrupts enabled\n",
ffffffff8010377e:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffffffff80103782:	48 89 c6             	mov    %rax,%rsi
ffffffff80103785:	48 c7 c7 f8 9c 10 80 	mov    $0xffffffff80109cf8,%rdi
ffffffff8010378c:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103791:	e8 2a ce ff ff       	call   ffffffff801005c0 <cprintf>
        __builtin_return_address(0));
  }

  if(!lapic)
ffffffff80103796:	48 8b 05 e3 c3 00 00 	mov    0xc3e3(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff8010379d:	48 85 c0             	test   %rax,%rax
ffffffff801037a0:	75 07                	jne    ffffffff801037a9 <cpunum+0x59>
    return 0;
ffffffff801037a2:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801037a7:	eb 5a                	jmp    ffffffff80103803 <cpunum+0xb3>

  id = lapic[ID]>>24;
ffffffff801037a9:	48 8b 05 d0 c3 00 00 	mov    0xc3d0(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff801037b0:	48 83 c0 20          	add    $0x20,%rax
ffffffff801037b4:	8b 00                	mov    (%rax),%eax
ffffffff801037b6:	c1 e8 18             	shr    $0x18,%eax
ffffffff801037b9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (n = 0; n < ncpu; n++)
ffffffff801037bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801037c3:	eb 2e                	jmp    ffffffff801037f3 <cpunum+0xa3>
    if (id == cpus[n].apicid)
ffffffff801037c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801037c8:	48 63 d0             	movslq %eax,%rdx
ffffffff801037cb:	48 89 d0             	mov    %rdx,%rax
ffffffff801037ce:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801037d2:	48 29 d0             	sub    %rdx,%rax
ffffffff801037d5:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801037d9:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff801037df:	0f b6 00             	movzbl (%rax),%eax
ffffffff801037e2:	0f b6 c0             	movzbl %al,%eax
ffffffff801037e5:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffffffff801037e8:	75 05                	jne    ffffffff801037ef <cpunum+0x9f>
      return n;
ffffffff801037ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801037ed:	eb 14                	jmp    ffffffff80103803 <cpunum+0xb3>
  for (n = 0; n < ncpu; n++)
ffffffff801037ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801037f3:	8b 05 eb cb 00 00    	mov    0xcbeb(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801037f9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff801037fc:	7c c7                	jl     ffffffff801037c5 <cpunum+0x75>

  return 0;
ffffffff801037fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80103803:	c9                   	leave
ffffffff80103804:	c3                   	ret

ffffffff80103805 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffffffff80103805:	f3 0f 1e fa          	endbr64
ffffffff80103809:	55                   	push   %rbp
ffffffff8010380a:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffffffff8010380d:	48 8b 05 6c c3 00 00 	mov    0xc36c(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103814:	48 85 c0             	test   %rax,%rax
ffffffff80103817:	74 0f                	je     ffffffff80103828 <lapiceoi+0x23>
    lapicw(EOI, 0);
ffffffff80103819:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010381e:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffffffff80103823:	e8 cf fd ff ff       	call   ffffffff801035f7 <lapicw>
}
ffffffff80103828:	90                   	nop
ffffffff80103829:	5d                   	pop    %rbp
ffffffff8010382a:	c3                   	ret

ffffffff8010382b <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffffffff8010382b:	f3 0f 1e fa          	endbr64
ffffffff8010382f:	55                   	push   %rbp
ffffffff80103830:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103833:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103837:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffffffff8010383a:	90                   	nop
ffffffff8010383b:	c9                   	leave
ffffffff8010383c:	c3                   	ret

ffffffff8010383d <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffffffff8010383d:	f3 0f 1e fa          	endbr64
ffffffff80103841:	55                   	push   %rbp
ffffffff80103842:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103845:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80103849:	89 f8                	mov    %edi,%eax
ffffffff8010384b:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffffffff8010384e:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
ffffffff80103851:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80103856:	bf 70 00 00 00       	mov    $0x70,%edi
ffffffff8010385b:	e8 64 fd ff ff       	call   ffffffff801035c4 <outb>
  outb(IO_RTC+1, 0x0A);
ffffffff80103860:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80103865:	bf 71 00 00 00       	mov    $0x71,%edi
ffffffff8010386a:	e8 55 fd ff ff       	call   ffffffff801035c4 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffffffff8010386f:	48 c7 45 f0 67 04 00 	movq   $0xffffffff80000467,-0x10(%rbp)
ffffffff80103876:	80 
  wrv[0] = 0;
ffffffff80103877:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010387b:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffffffff80103880:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80103883:	c1 e8 04             	shr    $0x4,%eax
ffffffff80103886:	89 c2                	mov    %eax,%edx
ffffffff80103888:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010388c:	48 83 c0 02          	add    $0x2,%rax
ffffffff80103890:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffffffff80103893:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffffffff80103897:	c1 e0 18             	shl    $0x18,%eax
ffffffff8010389a:	89 c6                	mov    %eax,%esi
ffffffff8010389c:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff801038a1:	e8 51 fd ff ff       	call   ffffffff801035f7 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffffffff801038a6:	be 00 c5 00 00       	mov    $0xc500,%esi
ffffffff801038ab:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff801038b0:	e8 42 fd ff ff       	call   ffffffff801035f7 <lapicw>
  microdelay(200);
ffffffff801038b5:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff801038ba:	e8 6c ff ff ff       	call   ffffffff8010382b <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
ffffffff801038bf:	be 00 85 00 00       	mov    $0x8500,%esi
ffffffff801038c4:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff801038c9:	e8 29 fd ff ff       	call   ffffffff801035f7 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffffffff801038ce:	bf 64 00 00 00       	mov    $0x64,%edi
ffffffff801038d3:	e8 53 ff ff ff       	call   ffffffff8010382b <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffffffff801038d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801038df:	eb 36                	jmp    ffffffff80103917 <lapicstartap+0xda>
    lapicw(ICRHI, apicid<<24);
ffffffff801038e1:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffffffff801038e5:	c1 e0 18             	shl    $0x18,%eax
ffffffff801038e8:	89 c6                	mov    %eax,%esi
ffffffff801038ea:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff801038ef:	e8 03 fd ff ff       	call   ffffffff801035f7 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
ffffffff801038f4:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff801038f7:	c1 e8 0c             	shr    $0xc,%eax
ffffffff801038fa:	80 cc 06             	or     $0x6,%ah
ffffffff801038fd:	89 c6                	mov    %eax,%esi
ffffffff801038ff:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff80103904:	e8 ee fc ff ff       	call   ffffffff801035f7 <lapicw>
    microdelay(200);
ffffffff80103909:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff8010390e:	e8 18 ff ff ff       	call   ffffffff8010382b <microdelay>
  for(i = 0; i < 2; i++){
ffffffff80103913:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103917:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffffffff8010391b:	7e c4                	jle    ffffffff801038e1 <lapicstartap+0xa4>
  }
}
ffffffff8010391d:	90                   	nop
ffffffff8010391e:	90                   	nop
ffffffff8010391f:	c9                   	leave
ffffffff80103920:	c3                   	ret

ffffffff80103921 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
ffffffff80103921:	f3 0f 1e fa          	endbr64
ffffffff80103925:	55                   	push   %rbp
ffffffff80103926:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103929:	48 83 ec 10          	sub    $0x10,%rsp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffffffff8010392d:	48 c7 c6 24 9d 10 80 	mov    $0xffffffff80109d24,%rsi
ffffffff80103934:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff8010393b:	e8 3a 24 00 00       	call   ffffffff80105d7a <initlock>
  readsb(ROOTDEV, &sb);
ffffffff80103940:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80103944:	48 89 c6             	mov    %rax,%rsi
ffffffff80103947:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff8010394c:	e8 ca df ff ff       	call   ffffffff8010191b <readsb>
  log.start = sb.size - sb.nlog;
ffffffff80103951:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80103954:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103957:	29 c2                	sub    %eax,%edx
ffffffff80103959:	89 d0                	mov    %edx,%eax
ffffffff8010395b:	89 05 a7 c2 00 00    	mov    %eax,0xc2a7(%rip)        # ffffffff8010fc08 <log+0x68>
  log.size = sb.nlog;
ffffffff80103961:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103964:	89 05 a2 c2 00 00    	mov    %eax,0xc2a2(%rip)        # ffffffff8010fc0c <log+0x6c>
  log.dev = ROOTDEV;
ffffffff8010396a:	c7 05 a0 c2 00 00 01 	movl   $0x1,0xc2a0(%rip)        # ffffffff8010fc14 <log+0x74>
ffffffff80103971:	00 00 00 
  recover_from_log();
ffffffff80103974:	e8 d3 01 00 00       	call   ffffffff80103b4c <recover_from_log>
}
ffffffff80103979:	90                   	nop
ffffffff8010397a:	c9                   	leave
ffffffff8010397b:	c3                   	ret

ffffffff8010397c <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
ffffffff8010397c:	f3 0f 1e fa          	endbr64
ffffffff80103980:	55                   	push   %rbp
ffffffff80103981:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103984:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffffffff80103988:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff8010398f:	e9 90 00 00 00       	jmp    ffffffff80103a24 <install_trans+0xa8>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffffffff80103994:	8b 15 6e c2 00 00    	mov    0xc26e(%rip),%edx        # ffffffff8010fc08 <log+0x68>
ffffffff8010399a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010399d:	01 d0                	add    %edx,%eax
ffffffff8010399f:	83 c0 01             	add    $0x1,%eax
ffffffff801039a2:	89 c2                	mov    %eax,%edx
ffffffff801039a4:	8b 05 6a c2 00 00    	mov    0xc26a(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff801039aa:	89 d6                	mov    %edx,%esi
ffffffff801039ac:	89 c7                	mov    %eax,%edi
ffffffff801039ae:	e8 2c c9 ff ff       	call   ffffffff801002df <bread>
ffffffff801039b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
ffffffff801039b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801039ba:	48 98                	cltq
ffffffff801039bc:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff801039c0:	8b 04 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%eax
ffffffff801039c7:	89 c2                	mov    %eax,%edx
ffffffff801039c9:	8b 05 45 c2 00 00    	mov    0xc245(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff801039cf:	89 d6                	mov    %edx,%esi
ffffffff801039d1:	89 c7                	mov    %eax,%edi
ffffffff801039d3:	e8 07 c9 ff ff       	call   ffffffff801002df <bread>
ffffffff801039d8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffffffff801039dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801039e0:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff801039e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801039e8:	48 83 c0 28          	add    $0x28,%rax
ffffffff801039ec:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff801039f1:	48 89 ce             	mov    %rcx,%rsi
ffffffff801039f4:	48 89 c7             	mov    %rax,%rdi
ffffffff801039f7:	e8 3a 28 00 00       	call   ffffffff80106236 <memmove>
    bwrite(dbuf);  // write dst to disk
ffffffff801039fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103a00:	48 89 c7             	mov    %rax,%rdi
ffffffff80103a03:	e8 1b c9 ff ff       	call   ffffffff80100323 <bwrite>
    brelse(lbuf); 
ffffffff80103a08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103a0c:	48 89 c7             	mov    %rax,%rdi
ffffffff80103a0f:	e8 58 c9 ff ff       	call   ffffffff8010036c <brelse>
    brelse(dbuf);
ffffffff80103a14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103a18:	48 89 c7             	mov    %rax,%rdi
ffffffff80103a1b:	e8 4c c9 ff ff       	call   ffffffff8010036c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
ffffffff80103a20:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103a24:	8b 05 ee c1 00 00    	mov    0xc1ee(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103a2a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103a2d:	0f 8c 61 ff ff ff    	jl     ffffffff80103994 <install_trans+0x18>
  }
}
ffffffff80103a33:	90                   	nop
ffffffff80103a34:	90                   	nop
ffffffff80103a35:	c9                   	leave
ffffffff80103a36:	c3                   	ret

ffffffff80103a37 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffffffff80103a37:	f3 0f 1e fa          	endbr64
ffffffff80103a3b:	55                   	push   %rbp
ffffffff80103a3c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103a3f:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffffffff80103a43:	8b 05 bf c1 00 00    	mov    0xc1bf(%rip),%eax        # ffffffff8010fc08 <log+0x68>
ffffffff80103a49:	89 c2                	mov    %eax,%edx
ffffffff80103a4b:	8b 05 c3 c1 00 00    	mov    0xc1c3(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff80103a51:	89 d6                	mov    %edx,%esi
ffffffff80103a53:	89 c7                	mov    %eax,%edi
ffffffff80103a55:	e8 85 c8 ff ff       	call   ffffffff801002df <bread>
ffffffff80103a5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffffffff80103a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103a62:	48 83 c0 28          	add    $0x28,%rax
ffffffff80103a66:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffffffff80103a6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103a6e:	8b 00                	mov    (%rax),%eax
ffffffff80103a70:	89 05 a2 c1 00 00    	mov    %eax,0xc1a2(%rip)        # ffffffff8010fc18 <log+0x78>
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103a76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103a7d:	eb 23                	jmp    ffffffff80103aa2 <read_head+0x6b>
    log.lh.sector[i] = lh->sector[i];
ffffffff80103a7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103a83:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103a86:	48 63 d2             	movslq %edx,%rdx
ffffffff80103a89:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff80103a8d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103a90:	48 63 d2             	movslq %edx,%rdx
ffffffff80103a93:	48 83 c2 1c          	add    $0x1c,%rdx
ffffffff80103a97:	89 04 95 ac fb 10 80 	mov    %eax,-0x7fef0454(,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103a9e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103aa2:	8b 05 70 c1 00 00    	mov    0xc170(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103aa8:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103aab:	7c d2                	jl     ffffffff80103a7f <read_head+0x48>
  }
  brelse(buf);
ffffffff80103aad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103ab1:	48 89 c7             	mov    %rax,%rdi
ffffffff80103ab4:	e8 b3 c8 ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff80103ab9:	90                   	nop
ffffffff80103aba:	c9                   	leave
ffffffff80103abb:	c3                   	ret

ffffffff80103abc <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffffffff80103abc:	f3 0f 1e fa          	endbr64
ffffffff80103ac0:	55                   	push   %rbp
ffffffff80103ac1:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103ac4:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffffffff80103ac8:	8b 05 3a c1 00 00    	mov    0xc13a(%rip),%eax        # ffffffff8010fc08 <log+0x68>
ffffffff80103ace:	89 c2                	mov    %eax,%edx
ffffffff80103ad0:	8b 05 3e c1 00 00    	mov    0xc13e(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff80103ad6:	89 d6                	mov    %edx,%esi
ffffffff80103ad8:	89 c7                	mov    %eax,%edi
ffffffff80103ada:	e8 00 c8 ff ff       	call   ffffffff801002df <bread>
ffffffff80103adf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffffffff80103ae3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103ae7:	48 83 c0 28          	add    $0x28,%rax
ffffffff80103aeb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffffffff80103aef:	8b 15 23 c1 00 00    	mov    0xc123(%rip),%edx        # ffffffff8010fc18 <log+0x78>
ffffffff80103af5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103af9:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103afb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103b02:	eb 22                	jmp    ffffffff80103b26 <write_head+0x6a>
    hb->sector[i] = log.lh.sector[i];
ffffffff80103b04:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103b07:	48 98                	cltq
ffffffff80103b09:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80103b0d:	8b 0c 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%ecx
ffffffff80103b14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103b18:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103b1b:	48 63 d2             	movslq %edx,%rdx
ffffffff80103b1e:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103b22:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103b26:	8b 05 ec c0 00 00    	mov    0xc0ec(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103b2c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103b2f:	7c d3                	jl     ffffffff80103b04 <write_head+0x48>
  }
  bwrite(buf);
ffffffff80103b31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103b35:	48 89 c7             	mov    %rax,%rdi
ffffffff80103b38:	e8 e6 c7 ff ff       	call   ffffffff80100323 <bwrite>
  brelse(buf);
ffffffff80103b3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103b41:	48 89 c7             	mov    %rax,%rdi
ffffffff80103b44:	e8 23 c8 ff ff       	call   ffffffff8010036c <brelse>
}
ffffffff80103b49:	90                   	nop
ffffffff80103b4a:	c9                   	leave
ffffffff80103b4b:	c3                   	ret

ffffffff80103b4c <recover_from_log>:

static void
recover_from_log(void)
{
ffffffff80103b4c:	f3 0f 1e fa          	endbr64
ffffffff80103b50:	55                   	push   %rbp
ffffffff80103b51:	48 89 e5             	mov    %rsp,%rbp
  read_head();      
ffffffff80103b54:	e8 de fe ff ff       	call   ffffffff80103a37 <read_head>
  install_trans(); // if committed, copy from log to disk
ffffffff80103b59:	e8 1e fe ff ff       	call   ffffffff8010397c <install_trans>
  log.lh.n = 0;
ffffffff80103b5e:	c7 05 b0 c0 00 00 00 	movl   $0x0,0xc0b0(%rip)        # ffffffff8010fc18 <log+0x78>
ffffffff80103b65:	00 00 00 
  write_head(); // clear the log
ffffffff80103b68:	e8 4f ff ff ff       	call   ffffffff80103abc <write_head>
}
ffffffff80103b6d:	90                   	nop
ffffffff80103b6e:	5d                   	pop    %rbp
ffffffff80103b6f:	c3                   	ret

ffffffff80103b70 <begin_trans>:

void
begin_trans(void)
{
ffffffff80103b70:	f3 0f 1e fa          	endbr64
ffffffff80103b74:	55                   	push   %rbp
ffffffff80103b75:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffffffff80103b78:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103b7f:	e8 2f 22 00 00       	call   ffffffff80105db3 <acquire>
  while (log.busy) {
ffffffff80103b84:	eb 13                	jmp    ffffffff80103b99 <begin_trans+0x29>
    sleep(&log, &log.lock);
ffffffff80103b86:	48 c7 c6 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rsi
ffffffff80103b8d:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103b94:	e8 7e 1e 00 00       	call   ffffffff80105a17 <sleep>
  while (log.busy) {
ffffffff80103b99:	8b 05 71 c0 00 00    	mov    0xc071(%rip),%eax        # ffffffff8010fc10 <log+0x70>
ffffffff80103b9f:	85 c0                	test   %eax,%eax
ffffffff80103ba1:	75 e3                	jne    ffffffff80103b86 <begin_trans+0x16>
  }
  log.busy = 1;
ffffffff80103ba3:	c7 05 63 c0 00 00 01 	movl   $0x1,0xc063(%rip)        # ffffffff8010fc10 <log+0x70>
ffffffff80103baa:	00 00 00 
  release(&log.lock);
ffffffff80103bad:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103bb4:	e8 d5 22 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80103bb9:	90                   	nop
ffffffff80103bba:	5d                   	pop    %rbp
ffffffff80103bbb:	c3                   	ret

ffffffff80103bbc <commit_trans>:

void
commit_trans(void)
{
ffffffff80103bbc:	f3 0f 1e fa          	endbr64
ffffffff80103bc0:	55                   	push   %rbp
ffffffff80103bc1:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffffffff80103bc4:	8b 05 4e c0 00 00    	mov    0xc04e(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103bca:	85 c0                	test   %eax,%eax
ffffffff80103bcc:	7e 19                	jle    ffffffff80103be7 <commit_trans+0x2b>
    write_head();    // Write header to disk -- the real commit
ffffffff80103bce:	e8 e9 fe ff ff       	call   ffffffff80103abc <write_head>
    install_trans(); // Now install writes to home locations
ffffffff80103bd3:	e8 a4 fd ff ff       	call   ffffffff8010397c <install_trans>
    log.lh.n = 0; 
ffffffff80103bd8:	c7 05 36 c0 00 00 00 	movl   $0x0,0xc036(%rip)        # ffffffff8010fc18 <log+0x78>
ffffffff80103bdf:	00 00 00 
    write_head();    // Erase the transaction from the log
ffffffff80103be2:	e8 d5 fe ff ff       	call   ffffffff80103abc <write_head>
  }
  
  acquire(&log.lock);
ffffffff80103be7:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103bee:	e8 c0 21 00 00       	call   ffffffff80105db3 <acquire>
  log.busy = 0;
ffffffff80103bf3:	c7 05 13 c0 00 00 00 	movl   $0x0,0xc013(%rip)        # ffffffff8010fc10 <log+0x70>
ffffffff80103bfa:	00 00 00 
  wakeup(&log);
ffffffff80103bfd:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103c04:	e8 2a 1f 00 00       	call   ffffffff80105b33 <wakeup>
  release(&log.lock);
ffffffff80103c09:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103c10:	e8 79 22 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80103c15:	90                   	nop
ffffffff80103c16:	5d                   	pop    %rbp
ffffffff80103c17:	c3                   	ret

ffffffff80103c18 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffffffff80103c18:	f3 0f 1e fa          	endbr64
ffffffff80103c1c:	55                   	push   %rbp
ffffffff80103c1d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103c20:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103c24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffffffff80103c28:	8b 05 ea bf 00 00    	mov    0xbfea(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103c2e:	83 f8 09             	cmp    $0x9,%eax
ffffffff80103c31:	7f 13                	jg     ffffffff80103c46 <log_write+0x2e>
ffffffff80103c33:	8b 15 df bf 00 00    	mov    0xbfdf(%rip),%edx        # ffffffff8010fc18 <log+0x78>
ffffffff80103c39:	8b 05 cd bf 00 00    	mov    0xbfcd(%rip),%eax        # ffffffff8010fc0c <log+0x6c>
ffffffff80103c3f:	83 e8 01             	sub    $0x1,%eax
ffffffff80103c42:	39 c2                	cmp    %eax,%edx
ffffffff80103c44:	7c 0c                	jl     ffffffff80103c52 <log_write+0x3a>
    panic("too big a transaction");
ffffffff80103c46:	48 c7 c7 28 9d 10 80 	mov    $0xffffffff80109d28,%rdi
ffffffff80103c4d:	e8 fd cc ff ff       	call   ffffffff8010094f <panic>
  if (!log.busy)
ffffffff80103c52:	8b 05 b8 bf 00 00    	mov    0xbfb8(%rip),%eax        # ffffffff8010fc10 <log+0x70>
ffffffff80103c58:	85 c0                	test   %eax,%eax
ffffffff80103c5a:	75 0c                	jne    ffffffff80103c68 <log_write+0x50>
    panic("write outside of trans");
ffffffff80103c5c:	48 c7 c7 3e 9d 10 80 	mov    $0xffffffff80109d3e,%rdi
ffffffff80103c63:	e8 e7 cc ff ff       	call   ffffffff8010094f <panic>

  for (i = 0; i < log.lh.n; i++) {
ffffffff80103c68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103c6f:	eb 21                	jmp    ffffffff80103c92 <log_write+0x7a>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
ffffffff80103c71:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103c74:	48 98                	cltq
ffffffff80103c76:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80103c7a:	8b 04 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%eax
ffffffff80103c81:	89 c2                	mov    %eax,%edx
ffffffff80103c83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103c87:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80103c8a:	39 c2                	cmp    %eax,%edx
ffffffff80103c8c:	74 11                	je     ffffffff80103c9f <log_write+0x87>
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103c8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103c92:	8b 05 80 bf 00 00    	mov    0xbf80(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103c98:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103c9b:	7c d4                	jl     ffffffff80103c71 <log_write+0x59>
ffffffff80103c9d:	eb 01                	jmp    ffffffff80103ca0 <log_write+0x88>
      break;
ffffffff80103c9f:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
ffffffff80103ca0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103ca4:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80103ca7:	89 c2                	mov    %eax,%edx
ffffffff80103ca9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103cac:	48 98                	cltq
ffffffff80103cae:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80103cb2:	89 14 85 ac fb 10 80 	mov    %edx,-0x7fef0454(,%rax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
ffffffff80103cb9:	8b 15 49 bf 00 00    	mov    0xbf49(%rip),%edx        # ffffffff8010fc08 <log+0x68>
ffffffff80103cbf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103cc2:	01 d0                	add    %edx,%eax
ffffffff80103cc4:	83 c0 01             	add    $0x1,%eax
ffffffff80103cc7:	89 c2                	mov    %eax,%edx
ffffffff80103cc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103ccd:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80103cd0:	89 d6                	mov    %edx,%esi
ffffffff80103cd2:	89 c7                	mov    %eax,%edi
ffffffff80103cd4:	e8 06 c6 ff ff       	call   ffffffff801002df <bread>
ffffffff80103cd9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(lbuf->data, b->data, BSIZE);
ffffffff80103cdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103ce1:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff80103ce5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103ce9:	48 83 c0 28          	add    $0x28,%rax
ffffffff80103ced:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff80103cf2:	48 89 ce             	mov    %rcx,%rsi
ffffffff80103cf5:	48 89 c7             	mov    %rax,%rdi
ffffffff80103cf8:	e8 39 25 00 00       	call   ffffffff80106236 <memmove>
  bwrite(lbuf);
ffffffff80103cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103d01:	48 89 c7             	mov    %rax,%rdi
ffffffff80103d04:	e8 1a c6 ff ff       	call   ffffffff80100323 <bwrite>
  brelse(lbuf);
ffffffff80103d09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103d0d:	48 89 c7             	mov    %rax,%rdi
ffffffff80103d10:	e8 57 c6 ff ff       	call   ffffffff8010036c <brelse>
  if (i == log.lh.n)
ffffffff80103d15:	8b 05 fd be 00 00    	mov    0xbefd(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103d1b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103d1e:	75 0f                	jne    ffffffff80103d2f <log_write+0x117>
    log.lh.n++;
ffffffff80103d20:	8b 05 f2 be 00 00    	mov    0xbef2(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103d26:	83 c0 01             	add    $0x1,%eax
ffffffff80103d29:	89 05 e9 be 00 00    	mov    %eax,0xbee9(%rip)        # ffffffff8010fc18 <log+0x78>
  b->flags |= B_DIRTY; // XXX prevent eviction
ffffffff80103d2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103d33:	8b 00                	mov    (%rax),%eax
ffffffff80103d35:	83 c8 04             	or     $0x4,%eax
ffffffff80103d38:	89 c2                	mov    %eax,%edx
ffffffff80103d3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103d3e:	89 10                	mov    %edx,(%rax)
}
ffffffff80103d40:	90                   	nop
ffffffff80103d41:	c9                   	leave
ffffffff80103d42:	c3                   	ret

ffffffff80103d43 <v2p>:
ffffffff80103d43:	55                   	push   %rbp
ffffffff80103d44:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103d47:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103d4b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103d4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103d53:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff80103d58:	48 01 d0             	add    %rdx,%rax
ffffffff80103d5b:	c9                   	leave
ffffffff80103d5c:	c3                   	ret

ffffffff80103d5d <p2v>:
static inline void *p2v(uintp a) { return (void *) ((a) + ((uintp)KERNBASE)); }
ffffffff80103d5d:	55                   	push   %rbp
ffffffff80103d5e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103d61:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103d65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103d69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103d6d:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80103d73:	c9                   	leave
ffffffff80103d74:	c3                   	ret

ffffffff80103d75 <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uintp newval)
{
ffffffff80103d75:	55                   	push   %rbp
ffffffff80103d76:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103d79:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103d7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80103d81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffffffff80103d85:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80103d89:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80103d8d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80103d91:	f0 87 02             	lock xchg %eax,(%rdx)
ffffffff80103d94:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffffffff80103d97:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80103d9a:	c9                   	leave
ffffffff80103d9b:	c3                   	ret

ffffffff80103d9c <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffffffff80103d9c:	f3 0f 1e fa          	endbr64
ffffffff80103da0:	55                   	push   %rbp
ffffffff80103da1:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffffffff80103da4:	e8 5d 40 00 00       	call   ffffffff80107e06 <uartearlyinit>
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
ffffffff80103da9:	48 c7 c6 00 00 40 80 	mov    $0xffffffff80400000,%rsi
ffffffff80103db0:	48 c7 c7 00 50 11 80 	mov    $0xffffffff80115000,%rdi
ffffffff80103db7:	e8 96 f4 ff ff       	call   ffffffff80103252 <kinit1>
  kvmalloc();      // kernel page table
ffffffff80103dbc:	e8 c8 5a 00 00       	call   ffffffff80109889 <kvmalloc>
  if (acpiinit()) // try to use acpi for machine info
ffffffff80103dc1:	e8 71 0a 00 00       	call   ffffffff80104837 <acpiinit>
ffffffff80103dc6:	85 c0                	test   %eax,%eax
ffffffff80103dc8:	74 05                	je     ffffffff80103dcf <main+0x33>
    mpinit();      // otherwise use bios MP tables
ffffffff80103dca:	e8 ea 04 00 00       	call   ffffffff801042b9 <mpinit>
  lapicinit();
ffffffff80103dcf:	e8 5e f8 ff ff       	call   ffffffff80103632 <lapicinit>
  seginit();       // set up segments
ffffffff80103dd4:	e8 9a 57 00 00       	call   ffffffff80109573 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
ffffffff80103dd9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103de0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103de4:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103de7:	0f b6 c0             	movzbl %al,%eax
ffffffff80103dea:	89 c6                	mov    %eax,%esi
ffffffff80103dec:	48 c7 c7 55 9d 10 80 	mov    $0xffffffff80109d55,%rdi
ffffffff80103df3:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103df8:	e8 c3 c7 ff ff       	call   ffffffff801005c0 <cprintf>
  picinit();       // interrupt controller
ffffffff80103dfd:	e8 c8 0b 00 00       	call   ffffffff801049ca <picinit>
  ioapicinit();    // another interrupt controller
ffffffff80103e02:	e8 1c f3 ff ff       	call   ffffffff80103123 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
ffffffff80103e07:	e8 3b d1 ff ff       	call   ffffffff80100f47 <consoleinit>
  uartinit();      // serial port
ffffffff80103e0c:	e8 b2 40 00 00       	call   ffffffff80107ec3 <uartinit>
  pinit();         // process table
ffffffff80103e11:	e8 39 11 00 00       	call   ffffffff80104f4f <pinit>
  tvinit();        // trap vectors
ffffffff80103e16:	e8 a5 55 00 00       	call   ffffffff801093c0 <tvinit>
  binit();         // buffer cache
ffffffff80103e1b:	e8 0b c3 ff ff       	call   ffffffff8010012b <binit>
  fileinit();      // file table
ffffffff80103e20:	e8 91 d6 ff ff       	call   ffffffff801014b6 <fileinit>
  iinit();         // inode cache
ffffffff80103e25:	e8 db dd ff ff       	call   ffffffff80101c05 <iinit>
  ideinit();       // disk
ffffffff80103e2a:	e8 2c ef ff ff       	call   ffffffff80102d5b <ideinit>
  if(!ismp)
ffffffff80103e2f:	8b 05 ab c5 00 00    	mov    0xc5ab(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff80103e35:	85 c0                	test   %eax,%eax
ffffffff80103e37:	75 05                	jne    ffffffff80103e3e <main+0xa2>
    timerinit();   // uniprocessor timer
ffffffff80103e39:	e8 bd 3b 00 00       	call   ffffffff801079fb <timerinit>
  startothers();   // start other processors
ffffffff80103e3e:	e8 8d 00 00 00       	call   ffffffff80103ed0 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
ffffffff80103e43:	48 c7 c6 00 00 00 8e 	mov    $0xffffffff8e000000,%rsi
ffffffff80103e4a:	48 c7 c7 00 00 40 80 	mov    $0xffffffff80400000,%rdi
ffffffff80103e51:	e8 43 f4 ff ff       	call   ffffffff80103299 <kinit2>
  userinit();      // first user process
ffffffff80103e56:	e8 4c 12 00 00       	call   ffffffff801050a7 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
ffffffff80103e5b:	e8 1c 00 00 00       	call   ffffffff80103e7c <mpmain>

ffffffff80103e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffffffff80103e60:	f3 0f 1e fa          	endbr64
ffffffff80103e64:	55                   	push   %rbp
ffffffff80103e65:	48 89 e5             	mov    %rsp,%rbp
  switchkvm(); 
ffffffff80103e68:	e8 e5 5b 00 00       	call   ffffffff80109a52 <switchkvm>
  seginit();
ffffffff80103e6d:	e8 01 57 00 00       	call   ffffffff80109573 <seginit>
  lapicinit();
ffffffff80103e72:	e8 bb f7 ff ff       	call   ffffffff80103632 <lapicinit>
  mpmain();
ffffffff80103e77:	e8 00 00 00 00       	call   ffffffff80103e7c <mpmain>

ffffffff80103e7c <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffffffff80103e7c:	f3 0f 1e fa          	endbr64
ffffffff80103e80:	55                   	push   %rbp
ffffffff80103e81:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpu->id);
ffffffff80103e84:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103e8b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103e8f:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103e92:	0f b6 c0             	movzbl %al,%eax
ffffffff80103e95:	89 c6                	mov    %eax,%esi
ffffffff80103e97:	48 c7 c7 6c 9d 10 80 	mov    $0xffffffff80109d6c,%rdi
ffffffff80103e9e:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103ea3:	e8 18 c7 ff ff       	call   ffffffff801005c0 <cprintf>
  idtinit();       // load idt register
ffffffff80103ea8:	e8 1e 55 00 00       	call   ffffffff801093cb <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
ffffffff80103ead:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103eb4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103eb8:	48 05 d8 00 00 00    	add    $0xd8,%rax
ffffffff80103ebe:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80103ec3:	48 89 c7             	mov    %rax,%rdi
ffffffff80103ec6:	e8 aa fe ff ff       	call   ffffffff80103d75 <xchg>
  scheduler();     // start running processes
ffffffff80103ecb:	e8 1d 19 00 00       	call   ffffffff801057ed <scheduler>

ffffffff80103ed0 <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffffffff80103ed0:	f3 0f 1e fa          	endbr64
ffffffff80103ed4:	55                   	push   %rbp
ffffffff80103ed5:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103ed8:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
ffffffff80103edc:	bf 00 70 00 00       	mov    $0x7000,%edi
ffffffff80103ee1:	e8 77 fe ff ff       	call   ffffffff80103d5d <p2v>
ffffffff80103ee6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_out_entryother_start, (uintp)_binary_out_entryother_size);
ffffffff80103eea:	48 c7 c0 72 00 00 00 	mov    $0x72,%rax
ffffffff80103ef1:	89 c2                	mov    %eax,%edx
ffffffff80103ef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103ef7:	48 c7 c6 ec be 10 80 	mov    $0xffffffff8010beec,%rsi
ffffffff80103efe:	48 89 c7             	mov    %rax,%rdi
ffffffff80103f01:	e8 30 23 00 00       	call   ffffffff80106236 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
ffffffff80103f06:	48 c7 45 f8 60 fc 10 	movq   $0xffffffff8010fc60,-0x8(%rbp)
ffffffff80103f0d:	80 
ffffffff80103f0e:	e9 a4 00 00 00       	jmp    ffffffff80103fb7 <startothers+0xe7>
    if(c == cpus+cpunum())  // We've started already.
ffffffff80103f13:	e8 38 f8 ff ff       	call   ffffffff80103750 <cpunum>
ffffffff80103f18:	48 63 d0             	movslq %eax,%rdx
ffffffff80103f1b:	48 89 d0             	mov    %rdx,%rax
ffffffff80103f1e:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103f22:	48 29 d0             	sub    %rdx,%rax
ffffffff80103f25:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103f29:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80103f2f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80103f33:	74 79                	je     ffffffff80103fae <startothers+0xde>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffffffff80103f35:	e8 93 f4 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80103f3a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
#if X64
    *(uint32*)(code-4) = 0x8000; // just enough stack to get us to entry64mp
ffffffff80103f3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f42:	48 83 e8 04          	sub    $0x4,%rax
ffffffff80103f46:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffffffff80103f4c:	48 c7 c7 74 00 10 80 	mov    $0xffffffff80100074,%rdi
ffffffff80103f53:	e8 eb fd ff ff       	call   ffffffff80103d43 <v2p>
ffffffff80103f58:	48 89 c2             	mov    %rax,%rdx
ffffffff80103f5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f5f:	48 83 e8 08          	sub    $0x8,%rax
ffffffff80103f63:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffffffff80103f65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103f69:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffffffff80103f70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f74:	48 83 e8 10          	sub    $0x10,%rax
ffffffff80103f78:	48 89 10             	mov    %rdx,(%rax)
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) v2p(entrypgdir);
#endif

    lapicstartap(c->apicid, v2p(code));
ffffffff80103f7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f7f:	48 89 c7             	mov    %rax,%rdi
ffffffff80103f82:	e8 bc fd ff ff       	call   ffffffff80103d43 <v2p>
ffffffff80103f87:	89 c2                	mov    %eax,%edx
ffffffff80103f89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103f8d:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff80103f91:	0f b6 c0             	movzbl %al,%eax
ffffffff80103f94:	89 d6                	mov    %edx,%esi
ffffffff80103f96:	89 c7                	mov    %eax,%edi
ffffffff80103f98:	e8 a0 f8 ff ff       	call   ffffffff8010383d <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffffffff80103f9d:	90                   	nop
ffffffff80103f9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103fa2:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
ffffffff80103fa8:	85 c0                	test   %eax,%eax
ffffffff80103faa:	74 f2                	je     ffffffff80103f9e <startothers+0xce>
ffffffff80103fac:	eb 01                	jmp    ffffffff80103faf <startothers+0xdf>
      continue;
ffffffff80103fae:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffffffff80103faf:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80103fb6:	00 
ffffffff80103fb7:	8b 05 27 c4 00 00    	mov    0xc427(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80103fbd:	48 63 d0             	movslq %eax,%rdx
ffffffff80103fc0:	48 89 d0             	mov    %rdx,%rax
ffffffff80103fc3:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103fc7:	48 29 d0             	sub    %rdx,%rax
ffffffff80103fca:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103fce:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80103fd4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80103fd8:	0f 82 35 ff ff ff    	jb     ffffffff80103f13 <startothers+0x43>
      ;
  }
}
ffffffff80103fde:	90                   	nop
ffffffff80103fdf:	90                   	nop
ffffffff80103fe0:	c9                   	leave
ffffffff80103fe1:	c3                   	ret

ffffffff80103fe2 <p2v>:
ffffffff80103fe2:	55                   	push   %rbp
ffffffff80103fe3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103fe6:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103fea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103fee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103ff2:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80103ff8:	c9                   	leave
ffffffff80103ff9:	c3                   	ret

ffffffff80103ffa <inb>:
{
ffffffff80103ffa:	55                   	push   %rbp
ffffffff80103ffb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103ffe:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80104002:	89 f8                	mov    %edi,%eax
ffffffff80104004:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80104008:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff8010400c:	89 c2                	mov    %eax,%edx
ffffffff8010400e:	ec                   	in     (%dx),%al
ffffffff8010400f:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80104012:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80104016:	c9                   	leave
ffffffff80104017:	c3                   	ret

ffffffff80104018 <outb>:
{
ffffffff80104018:	55                   	push   %rbp
ffffffff80104019:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010401c:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80104020:	89 fa                	mov    %edi,%edx
ffffffff80104022:	89 f0                	mov    %esi,%eax
ffffffff80104024:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80104028:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff8010402b:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff8010402f:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80104033:	ee                   	out    %al,(%dx)
}
ffffffff80104034:	90                   	nop
ffffffff80104035:	c9                   	leave
ffffffff80104036:	c3                   	ret

ffffffff80104037 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
ffffffff80104037:	f3 0f 1e fa          	endbr64
ffffffff8010403b:	55                   	push   %rbp
ffffffff8010403c:	48 89 e5             	mov    %rsp,%rbp
  return bcpu-cpus;
ffffffff8010403f:	48 8b 05 aa c3 00 00 	mov    0xc3aa(%rip),%rax        # ffffffff801103f0 <bcpu>
ffffffff80104046:	48 2d 60 fc 10 80    	sub    $0xffffffff8010fc60,%rax
ffffffff8010404c:	48 c1 f8 04          	sar    $0x4,%rax
ffffffff80104050:	48 89 c2             	mov    %rax,%rdx
ffffffff80104053:	48 b8 ef ee ee ee ee 	movabs $0xeeeeeeeeeeeeeeef,%rax
ffffffff8010405a:	ee ee ee 
ffffffff8010405d:	48 0f af c2          	imul   %rdx,%rax
}
ffffffff80104061:	5d                   	pop    %rbp
ffffffff80104062:	c3                   	ret

ffffffff80104063 <sum>:

static uchar
sum(uchar *addr, int len)
{
ffffffff80104063:	f3 0f 1e fa          	endbr64
ffffffff80104067:	55                   	push   %rbp
ffffffff80104068:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010406b:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010406f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104073:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;
  
  sum = 0;
ffffffff80104076:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffffffff8010407d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104084:	eb 1a                	jmp    ffffffff801040a0 <sum+0x3d>
    sum += addr[i];
ffffffff80104086:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104089:	48 63 d0             	movslq %eax,%rdx
ffffffff8010408c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104090:	48 01 d0             	add    %rdx,%rax
ffffffff80104093:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104096:	0f b6 c0             	movzbl %al,%eax
ffffffff80104099:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffffffff8010409c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801040a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801040a3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffffffff801040a6:	7c de                	jl     ffffffff80104086 <sum+0x23>
  return sum;
ffffffff801040a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffffffff801040ab:	c9                   	leave
ffffffff801040ac:	c3                   	ret

ffffffff801040ad <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
ffffffff801040ad:	f3 0f 1e fa          	endbr64
ffffffff801040b1:	55                   	push   %rbp
ffffffff801040b2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801040b5:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801040b9:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff801040bc:	89 75 d8             	mov    %esi,-0x28(%rbp)
  uchar *e, *p, *addr;

  addr = p2v(a);
ffffffff801040bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801040c2:	48 89 c7             	mov    %rax,%rdi
ffffffff801040c5:	e8 18 ff ff ff       	call   ffffffff80103fe2 <p2v>
ffffffff801040ca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffffffff801040ce:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff801040d1:	48 63 d0             	movslq %eax,%rdx
ffffffff801040d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801040d8:	48 01 d0             	add    %rdx,%rax
ffffffff801040db:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffffffff801040df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801040e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801040e7:	eb 3c                	jmp    ffffffff80104125 <mpsearch1+0x78>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffffffff801040e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801040ed:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff801040f2:	48 c7 c6 80 9d 10 80 	mov    $0xffffffff80109d80,%rsi
ffffffff801040f9:	48 89 c7             	mov    %rax,%rdi
ffffffff801040fc:	e8 c2 20 00 00       	call   ffffffff801061c3 <memcmp>
ffffffff80104101:	85 c0                	test   %eax,%eax
ffffffff80104103:	75 1b                	jne    ffffffff80104120 <mpsearch1+0x73>
ffffffff80104105:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104109:	be 10 00 00 00       	mov    $0x10,%esi
ffffffff8010410e:	48 89 c7             	mov    %rax,%rdi
ffffffff80104111:	e8 4d ff ff ff       	call   ffffffff80104063 <sum>
ffffffff80104116:	84 c0                	test   %al,%al
ffffffff80104118:	75 06                	jne    ffffffff80104120 <mpsearch1+0x73>
      return (struct mp*)p;
ffffffff8010411a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010411e:	eb 14                	jmp    ffffffff80104134 <mpsearch1+0x87>
  for(p = addr; p < e; p += sizeof(struct mp))
ffffffff80104120:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffffffff80104125:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104129:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff8010412d:	72 ba                	jb     ffffffff801040e9 <mpsearch1+0x3c>
  return 0;
ffffffff8010412f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80104134:	c9                   	leave
ffffffff80104135:	c3                   	ret

ffffffff80104136 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffffffff80104136:	f3 0f 1e fa          	endbr64
ffffffff8010413a:	55                   	push   %rbp
ffffffff8010413b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010413e:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffffffff80104142:	48 c7 45 f8 00 04 00 	movq   $0xffffffff80000400,-0x8(%rbp)
ffffffff80104149:	80 
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffffffff8010414a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010414e:	48 83 c0 0f          	add    $0xf,%rax
ffffffff80104152:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104155:	0f b6 c0             	movzbl %al,%eax
ffffffff80104158:	c1 e0 08             	shl    $0x8,%eax
ffffffff8010415b:	89 c2                	mov    %eax,%edx
ffffffff8010415d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104161:	48 83 c0 0e          	add    $0xe,%rax
ffffffff80104165:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104168:	0f b6 c0             	movzbl %al,%eax
ffffffff8010416b:	09 d0                	or     %edx,%eax
ffffffff8010416d:	c1 e0 04             	shl    $0x4,%eax
ffffffff80104170:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffffffff80104173:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff80104177:	74 20                	je     ffffffff80104199 <mpsearch+0x63>
    if((mp = mpsearch1(p, 1024)))
ffffffff80104179:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010417c:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff80104181:	89 c7                	mov    %eax,%edi
ffffffff80104183:	e8 25 ff ff ff       	call   ffffffff801040ad <mpsearch1>
ffffffff80104188:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff8010418c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80104191:	74 54                	je     ffffffff801041e7 <mpsearch+0xb1>
      return mp;
ffffffff80104193:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104197:	eb 5d                	jmp    ffffffff801041f6 <mpsearch+0xc0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffffffff80104199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010419d:	48 83 c0 14          	add    $0x14,%rax
ffffffff801041a1:	0f b6 00             	movzbl (%rax),%eax
ffffffff801041a4:	0f b6 c0             	movzbl %al,%eax
ffffffff801041a7:	c1 e0 08             	shl    $0x8,%eax
ffffffff801041aa:	89 c2                	mov    %eax,%edx
ffffffff801041ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801041b0:	48 83 c0 13          	add    $0x13,%rax
ffffffff801041b4:	0f b6 00             	movzbl (%rax),%eax
ffffffff801041b7:	0f b6 c0             	movzbl %al,%eax
ffffffff801041ba:	09 d0                	or     %edx,%eax
ffffffff801041bc:	c1 e0 0a             	shl    $0xa,%eax
ffffffff801041bf:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffffffff801041c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801041c5:	2d 00 04 00 00       	sub    $0x400,%eax
ffffffff801041ca:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff801041cf:	89 c7                	mov    %eax,%edi
ffffffff801041d1:	e8 d7 fe ff ff       	call   ffffffff801040ad <mpsearch1>
ffffffff801041d6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff801041da:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff801041df:	74 06                	je     ffffffff801041e7 <mpsearch+0xb1>
      return mp;
ffffffff801041e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801041e5:	eb 0f                	jmp    ffffffff801041f6 <mpsearch+0xc0>
  }
  return mpsearch1(0xF0000, 0x10000);
ffffffff801041e7:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff801041ec:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffffffff801041f1:	e8 b7 fe ff ff       	call   ffffffff801040ad <mpsearch1>
}
ffffffff801041f6:	c9                   	leave
ffffffff801041f7:	c3                   	ret

ffffffff801041f8 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffffffff801041f8:	f3 0f 1e fa          	endbr64
ffffffff801041fc:	55                   	push   %rbp
ffffffff801041fd:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104200:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80104204:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffffffff80104208:	e8 29 ff ff ff       	call   ffffffff80104136 <mpsearch>
ffffffff8010420d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80104211:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80104216:	74 0b                	je     ffffffff80104223 <mpconfig+0x2b>
ffffffff80104218:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010421c:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff8010421f:	85 c0                	test   %eax,%eax
ffffffff80104221:	75 0a                	jne    ffffffff8010422d <mpconfig+0x35>
    return 0;
ffffffff80104223:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104228:	e9 8a 00 00 00       	jmp    ffffffff801042b7 <mpconfig+0xbf>
  conf = (struct mpconf*) p2v((uintp) mp->physaddr);
ffffffff8010422d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104231:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80104234:	89 c0                	mov    %eax,%eax
ffffffff80104236:	48 89 c7             	mov    %rax,%rdi
ffffffff80104239:	e8 a4 fd ff ff       	call   ffffffff80103fe2 <p2v>
ffffffff8010423e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffffffff80104242:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104246:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff8010424b:	48 c7 c6 85 9d 10 80 	mov    $0xffffffff80109d85,%rsi
ffffffff80104252:	48 89 c7             	mov    %rax,%rdi
ffffffff80104255:	e8 69 1f 00 00       	call   ffffffff801061c3 <memcmp>
ffffffff8010425a:	85 c0                	test   %eax,%eax
ffffffff8010425c:	74 07                	je     ffffffff80104265 <mpconfig+0x6d>
    return 0;
ffffffff8010425e:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104263:	eb 52                	jmp    ffffffff801042b7 <mpconfig+0xbf>
  if(conf->version != 1 && conf->version != 4)
ffffffff80104265:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104269:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffffffff8010426d:	3c 01                	cmp    $0x1,%al
ffffffff8010426f:	74 13                	je     ffffffff80104284 <mpconfig+0x8c>
ffffffff80104271:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104275:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffffffff80104279:	3c 04                	cmp    $0x4,%al
ffffffff8010427b:	74 07                	je     ffffffff80104284 <mpconfig+0x8c>
    return 0;
ffffffff8010427d:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104282:	eb 33                	jmp    ffffffff801042b7 <mpconfig+0xbf>
  if(sum((uchar*)conf, conf->length) != 0)
ffffffff80104284:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104288:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffffffff8010428c:	0f b7 d0             	movzwl %ax,%edx
ffffffff8010428f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104293:	89 d6                	mov    %edx,%esi
ffffffff80104295:	48 89 c7             	mov    %rax,%rdi
ffffffff80104298:	e8 c6 fd ff ff       	call   ffffffff80104063 <sum>
ffffffff8010429d:	84 c0                	test   %al,%al
ffffffff8010429f:	74 07                	je     ffffffff801042a8 <mpconfig+0xb0>
    return 0;
ffffffff801042a1:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801042a6:	eb 0f                	jmp    ffffffff801042b7 <mpconfig+0xbf>
  *pmp = mp;
ffffffff801042a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801042ac:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801042b0:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffffffff801042b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffffffff801042b7:	c9                   	leave
ffffffff801042b8:	c3                   	ret

ffffffff801042b9 <mpinit>:

void
mpinit(void)
{
ffffffff801042b9:	f3 0f 1e fa          	endbr64
ffffffff801042bd:	55                   	push   %rbp
ffffffff801042be:	48 89 e5             	mov    %rsp,%rbp
ffffffff801042c1:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
ffffffff801042c5:	48 c7 05 20 c1 00 00 	movq   $0xffffffff8010fc60,0xc120(%rip)        # ffffffff801103f0 <bcpu>
ffffffff801042cc:	60 fc 10 80 
  if((conf = mpconfig(&mp)) == 0)
ffffffff801042d0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff801042d4:	48 89 c7             	mov    %rax,%rdi
ffffffff801042d7:	e8 1c ff ff ff       	call   ffffffff801041f8 <mpconfig>
ffffffff801042dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff801042e0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff801042e5:	0f 84 0e 02 00 00    	je     ffffffff801044f9 <mpinit+0x240>
    return;
  ismp = 1;
ffffffff801042eb:	c7 05 eb c0 00 00 01 	movl   $0x1,0xc0eb(%rip)        # ffffffff801103e0 <ismp>
ffffffff801042f2:	00 00 00 
  lapic = IO2V((uintp)conf->lapicaddr);
ffffffff801042f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801042f9:	8b 40 24             	mov    0x24(%rax),%eax
ffffffff801042fc:	89 c2                	mov    %eax,%edx
ffffffff801042fe:	48 b8 00 00 00 42 fe 	movabs $0xfffffffe42000000,%rax
ffffffff80104305:	ff ff ff 
ffffffff80104308:	48 01 d0             	add    %rdx,%rax
ffffffff8010430b:	48 89 05 6e b8 00 00 	mov    %rax,0xb86e(%rip)        # ffffffff8010fb80 <lapic>
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffffffff80104312:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104316:	48 83 c0 2c          	add    $0x2c,%rax
ffffffff8010431a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010431e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104322:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffffffff80104326:	0f b7 d0             	movzwl %ax,%edx
ffffffff80104329:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010432d:	48 01 d0             	add    %rdx,%rax
ffffffff80104330:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80104334:	e9 51 01 00 00       	jmp    ffffffff8010448a <mpinit+0x1d1>
    switch(*p){
ffffffff80104339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010433d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104340:	0f b6 c0             	movzbl %al,%eax
ffffffff80104343:	83 f8 04             	cmp    $0x4,%eax
ffffffff80104346:	0f 8f 17 01 00 00    	jg     ffffffff80104463 <mpinit+0x1aa>
ffffffff8010434c:	83 f8 03             	cmp    $0x3,%eax
ffffffff8010434f:	0f 8d 07 01 00 00    	jge    ffffffff8010445c <mpinit+0x1a3>
ffffffff80104355:	83 f8 02             	cmp    $0x2,%eax
ffffffff80104358:	0f 84 e1 00 00 00    	je     ffffffff8010443f <mpinit+0x186>
ffffffff8010435e:	83 f8 02             	cmp    $0x2,%eax
ffffffff80104361:	0f 8f fc 00 00 00    	jg     ffffffff80104463 <mpinit+0x1aa>
ffffffff80104367:	85 c0                	test   %eax,%eax
ffffffff80104369:	74 0e                	je     ffffffff80104379 <mpinit+0xc0>
ffffffff8010436b:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010436e:	0f 84 e8 00 00 00    	je     ffffffff8010445c <mpinit+0x1a3>
ffffffff80104374:	e9 ea 00 00 00       	jmp    ffffffff80104463 <mpinit+0x1aa>
    case MPPROC:
      proc = (struct mpproc*)p;
ffffffff80104379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010437d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      cprintf("mpinit ncpu=%d apicid=%d\n", ncpu, proc->apicid);
ffffffff80104381:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80104385:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff80104389:	0f b6 d0             	movzbl %al,%edx
ffffffff8010438c:	8b 05 52 c0 00 00    	mov    0xc052(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104392:	89 c6                	mov    %eax,%esi
ffffffff80104394:	48 c7 c7 8a 9d 10 80 	mov    $0xffffffff80109d8a,%rdi
ffffffff8010439b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801043a0:	e8 1b c2 ff ff       	call   ffffffff801005c0 <cprintf>
      if(proc->flags & MPBOOT)
ffffffff801043a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801043a9:	0f b6 40 03          	movzbl 0x3(%rax),%eax
ffffffff801043ad:	0f b6 c0             	movzbl %al,%eax
ffffffff801043b0:	83 e0 02             	and    $0x2,%eax
ffffffff801043b3:	85 c0                	test   %eax,%eax
ffffffff801043b5:	74 24                	je     ffffffff801043db <mpinit+0x122>
        bcpu = &cpus[ncpu];
ffffffff801043b7:	8b 05 27 c0 00 00    	mov    0xc027(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801043bd:	48 63 d0             	movslq %eax,%rdx
ffffffff801043c0:	48 89 d0             	mov    %rdx,%rax
ffffffff801043c3:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801043c7:	48 29 d0             	sub    %rdx,%rax
ffffffff801043ca:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801043ce:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff801043d4:	48 89 05 15 c0 00 00 	mov    %rax,0xc015(%rip)        # ffffffff801103f0 <bcpu>
      cpus[ncpu].id = ncpu;
ffffffff801043db:	8b 15 03 c0 00 00    	mov    0xc003(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff801043e1:	8b 05 fd bf 00 00    	mov    0xbffd(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801043e7:	89 d1                	mov    %edx,%ecx
ffffffff801043e9:	48 63 d0             	movslq %eax,%rdx
ffffffff801043ec:	48 89 d0             	mov    %rdx,%rax
ffffffff801043ef:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801043f3:	48 29 d0             	sub    %rdx,%rax
ffffffff801043f6:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801043fa:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80104400:	88 08                	mov    %cl,(%rax)
      cpus[ncpu].apicid = proc->apicid;
ffffffff80104402:	8b 15 dc bf 00 00    	mov    0xbfdc(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff80104408:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010440c:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffffffff80104410:	48 63 d2             	movslq %edx,%rdx
ffffffff80104413:	48 89 d0             	mov    %rdx,%rax
ffffffff80104416:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010441a:	48 29 d0             	sub    %rdx,%rax
ffffffff8010441d:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80104421:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff80104427:	88 08                	mov    %cl,(%rax)
      ncpu++;
ffffffff80104429:	8b 05 b5 bf 00 00    	mov    0xbfb5(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff8010442f:	83 c0 01             	add    $0x1,%eax
ffffffff80104432:	89 05 ac bf 00 00    	mov    %eax,0xbfac(%rip)        # ffffffff801103e4 <ncpu>
      p += sizeof(struct mpproc);
ffffffff80104438:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffffffff8010443d:	eb 4b                	jmp    ffffffff8010448a <mpinit+0x1d1>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffffffff8010443f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104443:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffffffff80104447:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010444b:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff8010444f:	88 05 93 bf 00 00    	mov    %al,0xbf93(%rip)        # ffffffff801103e8 <ioapicid>
      p += sizeof(struct mpioapic);
ffffffff80104455:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffffffff8010445a:	eb 2e                	jmp    ffffffff8010448a <mpinit+0x1d1>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffffffff8010445c:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffffffff80104461:	eb 27                	jmp    ffffffff8010448a <mpinit+0x1d1>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
ffffffff80104463:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104467:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010446a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010446d:	89 c6                	mov    %eax,%esi
ffffffff8010446f:	48 c7 c7 a8 9d 10 80 	mov    $0xffffffff80109da8,%rdi
ffffffff80104476:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010447b:	e8 40 c1 ff ff       	call   ffffffff801005c0 <cprintf>
      ismp = 0;
ffffffff80104480:	c7 05 56 bf 00 00 00 	movl   $0x0,0xbf56(%rip)        # ffffffff801103e0 <ismp>
ffffffff80104487:	00 00 00 
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffffffff8010448a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010448e:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff80104492:	0f 82 a1 fe ff ff    	jb     ffffffff80104339 <mpinit+0x80>
    }
  }
  if(!ismp){
ffffffff80104498:	8b 05 42 bf 00 00    	mov    0xbf42(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff8010449e:	85 c0                	test   %eax,%eax
ffffffff801044a0:	75 1e                	jne    ffffffff801044c0 <mpinit+0x207>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
ffffffff801044a2:	c7 05 38 bf 00 00 01 	movl   $0x1,0xbf38(%rip)        # ffffffff801103e4 <ncpu>
ffffffff801044a9:	00 00 00 
    lapic = 0;
ffffffff801044ac:	48 c7 05 c9 b6 00 00 	movq   $0x0,0xb6c9(%rip)        # ffffffff8010fb80 <lapic>
ffffffff801044b3:	00 00 00 00 
    ioapicid = 0;
ffffffff801044b7:	c6 05 2a bf 00 00 00 	movb   $0x0,0xbf2a(%rip)        # ffffffff801103e8 <ioapicid>
    return;
ffffffff801044be:	eb 3a                	jmp    ffffffff801044fa <mpinit+0x241>
  }

  if(mp->imcrp){
ffffffff801044c0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801044c4:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffffffff801044c8:	84 c0                	test   %al,%al
ffffffff801044ca:	74 2e                	je     ffffffff801044fa <mpinit+0x241>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffffffff801044cc:	be 70 00 00 00       	mov    $0x70,%esi
ffffffff801044d1:	bf 22 00 00 00       	mov    $0x22,%edi
ffffffff801044d6:	e8 3d fb ff ff       	call   ffffffff80104018 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffffffff801044db:	bf 23 00 00 00       	mov    $0x23,%edi
ffffffff801044e0:	e8 15 fb ff ff       	call   ffffffff80103ffa <inb>
ffffffff801044e5:	83 c8 01             	or     $0x1,%eax
ffffffff801044e8:	0f b6 c0             	movzbl %al,%eax
ffffffff801044eb:	89 c6                	mov    %eax,%esi
ffffffff801044ed:	bf 23 00 00 00       	mov    $0x23,%edi
ffffffff801044f2:	e8 21 fb ff ff       	call   ffffffff80104018 <outb>
ffffffff801044f7:	eb 01                	jmp    ffffffff801044fa <mpinit+0x241>
    return;
ffffffff801044f9:	90                   	nop
  }
}
ffffffff801044fa:	c9                   	leave
ffffffff801044fb:	c3                   	ret

ffffffff801044fc <p2v>:
ffffffff801044fc:	55                   	push   %rbp
ffffffff801044fd:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104500:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80104504:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80104508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010450c:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80104512:	c9                   	leave
ffffffff80104513:	c3                   	ret

ffffffff80104514 <scan_rdsp>:
extern struct cpu cpus[NCPU];
extern int ismp;
extern int ncpu;
extern uchar ioapicid;

static struct acpi_rdsp *scan_rdsp(uint base, uint len) {
ffffffff80104514:	f3 0f 1e fa          	endbr64
ffffffff80104518:	55                   	push   %rbp
ffffffff80104519:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010451c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80104520:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80104523:	89 75 e8             	mov    %esi,-0x18(%rbp)
  uchar *p;
  for (p = p2v(base); len >= sizeof(struct acpi_rdsp); len -= 4, p += 4) {
ffffffff80104526:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80104529:	48 89 c7             	mov    %rax,%rdi
ffffffff8010452c:	e8 cb ff ff ff       	call   ffffffff801044fc <p2v>
ffffffff80104531:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80104535:	eb 62                	jmp    ffffffff80104599 <scan_rdsp+0x85>
    if (memcmp(p, SIG_RDSP, 8) == 0) {
ffffffff80104537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010453b:	ba 08 00 00 00       	mov    $0x8,%edx
ffffffff80104540:	48 c7 c6 c8 9d 10 80 	mov    $0xffffffff80109dc8,%rsi
ffffffff80104547:	48 89 c7             	mov    %rax,%rdi
ffffffff8010454a:	e8 74 1c 00 00       	call   ffffffff801061c3 <memcmp>
ffffffff8010454f:	85 c0                	test   %eax,%eax
ffffffff80104551:	75 3d                	jne    ffffffff80104590 <scan_rdsp+0x7c>
      uint sum, n;
      for (sum = 0, n = 0; n < 20; n++)
ffffffff80104553:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffffffff8010455a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffffffff80104561:	eb 17                	jmp    ffffffff8010457a <scan_rdsp+0x66>
        sum += p[n];
ffffffff80104563:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80104566:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010456a:	48 01 d0             	add    %rdx,%rax
ffffffff8010456d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104570:	0f b6 c0             	movzbl %al,%eax
ffffffff80104573:	01 45 f4             	add    %eax,-0xc(%rbp)
      for (sum = 0, n = 0; n < 20; n++)
ffffffff80104576:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffffffff8010457a:	83 7d f0 13          	cmpl   $0x13,-0x10(%rbp)
ffffffff8010457e:	76 e3                	jbe    ffffffff80104563 <scan_rdsp+0x4f>
      if ((sum & 0xff) == 0)
ffffffff80104580:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80104583:	0f b6 c0             	movzbl %al,%eax
ffffffff80104586:	85 c0                	test   %eax,%eax
ffffffff80104588:	75 06                	jne    ffffffff80104590 <scan_rdsp+0x7c>
        return (struct acpi_rdsp *) p;
ffffffff8010458a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010458e:	eb 14                	jmp    ffffffff801045a4 <scan_rdsp+0x90>
  for (p = p2v(base); len >= sizeof(struct acpi_rdsp); len -= 4, p += 4) {
ffffffff80104590:	83 6d e8 04          	subl   $0x4,-0x18(%rbp)
ffffffff80104594:	48 83 45 f8 04       	addq   $0x4,-0x8(%rbp)
ffffffff80104599:	83 7d e8 23          	cmpl   $0x23,-0x18(%rbp)
ffffffff8010459d:	77 98                	ja     ffffffff80104537 <scan_rdsp+0x23>
    }
  }
  return (struct acpi_rdsp *) 0;  
ffffffff8010459f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801045a4:	c9                   	leave
ffffffff801045a5:	c3                   	ret

ffffffff801045a6 <find_rdsp>:

static struct acpi_rdsp *find_rdsp(void) {
ffffffff801045a6:	f3 0f 1e fa          	endbr64
ffffffff801045aa:	55                   	push   %rbp
ffffffff801045ab:	48 89 e5             	mov    %rsp,%rbp
ffffffff801045ae:	48 83 ec 10          	sub    $0x10,%rsp
  struct acpi_rdsp *rdsp;
  uintp pa;
  pa = *((ushort*) P2V(0x40E)) << 4; // EBDA
ffffffff801045b2:	48 c7 c0 0e 04 00 80 	mov    $0xffffffff8000040e,%rax
ffffffff801045b9:	0f b7 00             	movzwl (%rax),%eax
ffffffff801045bc:	0f b7 c0             	movzwl %ax,%eax
ffffffff801045bf:	c1 e0 04             	shl    $0x4,%eax
ffffffff801045c2:	48 98                	cltq
ffffffff801045c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (pa && (rdsp = scan_rdsp(pa, 1024)))
ffffffff801045c8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801045cd:	74 21                	je     ffffffff801045f0 <find_rdsp+0x4a>
ffffffff801045cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801045d3:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff801045d8:	89 c7                	mov    %eax,%edi
ffffffff801045da:	e8 35 ff ff ff       	call   ffffffff80104514 <scan_rdsp>
ffffffff801045df:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff801045e3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff801045e8:	74 06                	je     ffffffff801045f0 <find_rdsp+0x4a>
    return rdsp;
ffffffff801045ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801045ee:	eb 0f                	jmp    ffffffff801045ff <find_rdsp+0x59>
  return scan_rdsp(0xE0000, 0x20000);
ffffffff801045f0:	be 00 00 02 00       	mov    $0x20000,%esi
ffffffff801045f5:	bf 00 00 0e 00       	mov    $0xe0000,%edi
ffffffff801045fa:	e8 15 ff ff ff       	call   ffffffff80104514 <scan_rdsp>
} 
ffffffff801045ff:	c9                   	leave
ffffffff80104600:	c3                   	ret

ffffffff80104601 <acpi_config_smp>:

static int acpi_config_smp(struct acpi_madt *madt) {
ffffffff80104601:	f3 0f 1e fa          	endbr64
ffffffff80104605:	55                   	push   %rbp
ffffffff80104606:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104609:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff8010460d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  uint32 lapic_addr;
  uint nioapic = 0;
ffffffff80104611:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  uchar *p, *e;

  if (!madt)
ffffffff80104618:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
ffffffff8010461d:	75 0a                	jne    ffffffff80104629 <acpi_config_smp+0x28>
    return -1;
ffffffff8010461f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80104624:	e9 0c 02 00 00       	jmp    ffffffff80104835 <acpi_config_smp+0x234>
  if (madt->header.length < sizeof(struct acpi_madt))
ffffffff80104629:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010462d:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80104630:	83 f8 2b             	cmp    $0x2b,%eax
ffffffff80104633:	77 0a                	ja     ffffffff8010463f <acpi_config_smp+0x3e>
    return -1;
ffffffff80104635:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010463a:	e9 f6 01 00 00       	jmp    ffffffff80104835 <acpi_config_smp+0x234>

  lapic_addr = madt->lapic_addr_phys;
ffffffff8010463f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80104643:	8b 40 24             	mov    0x24(%rax),%eax
ffffffff80104646:	89 45 ec             	mov    %eax,-0x14(%rbp)

  p = madt->table;
ffffffff80104649:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010464d:	48 83 c0 2c          	add    $0x2c,%rax
ffffffff80104651:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = p + madt->header.length - sizeof(struct acpi_madt);
ffffffff80104655:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80104659:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff8010465c:	89 c0                	mov    %eax,%eax
ffffffff8010465e:	48 8d 50 d4          	lea    -0x2c(%rax),%rdx
ffffffff80104662:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104666:	48 01 d0             	add    %rdx,%rax
ffffffff80104669:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

  while (p < e) {
ffffffff8010466d:	e9 78 01 00 00       	jmp    ffffffff801047ea <acpi_config_smp+0x1e9>
    uint len;
    if ((e - p) < 2)
ffffffff80104672:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104676:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
ffffffff8010467a:	48 83 f8 01          	cmp    $0x1,%rax
ffffffff8010467e:	0f 8e 76 01 00 00    	jle    ffffffff801047fa <acpi_config_smp+0x1f9>
      break;
    len = p[1];
ffffffff80104684:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104688:	48 83 c0 01          	add    $0x1,%rax
ffffffff8010468c:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010468f:	0f b6 c0             	movzbl %al,%eax
ffffffff80104692:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if ((e - p) < len)
ffffffff80104695:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104699:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
ffffffff8010469d:	48 89 c2             	mov    %rax,%rdx
ffffffff801046a0:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801046a3:	48 39 c2             	cmp    %rax,%rdx
ffffffff801046a6:	0f 8c 51 01 00 00    	jl     ffffffff801047fd <acpi_config_smp+0x1fc>
      break;
    switch (p[0]) {
ffffffff801046ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801046b0:	0f b6 00             	movzbl (%rax),%eax
ffffffff801046b3:	0f b6 c0             	movzbl %al,%eax
ffffffff801046b6:	85 c0                	test   %eax,%eax
ffffffff801046b8:	74 0e                	je     ffffffff801046c8 <acpi_config_smp+0xc7>
ffffffff801046ba:	83 f8 01             	cmp    $0x1,%eax
ffffffff801046bd:	0f 84 ac 00 00 00    	je     ffffffff8010476f <acpi_config_smp+0x16e>
ffffffff801046c3:	e9 1b 01 00 00       	jmp    ffffffff801047e3 <acpi_config_smp+0x1e2>
    case TYPE_LAPIC: {
      struct madt_lapic *lapic = (void*) p;
ffffffff801046c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801046cc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
      if (len < sizeof(*lapic))
ffffffff801046d0:	83 7d dc 07          	cmpl   $0x7,-0x24(%rbp)
ffffffff801046d4:	0f 86 02 01 00 00    	jbe    ffffffff801047dc <acpi_config_smp+0x1db>
        break;
      if (!(lapic->flags & APIC_LAPIC_ENABLED))
ffffffff801046da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801046de:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801046e1:	83 e0 01             	and    $0x1,%eax
ffffffff801046e4:	85 c0                	test   %eax,%eax
ffffffff801046e6:	0f 84 f3 00 00 00    	je     ffffffff801047df <acpi_config_smp+0x1de>
        break;
      cprintf("acpi: cpu#%d apicid %d\n", ncpu, lapic->apic_id);
ffffffff801046ec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801046f0:	0f b6 40 03          	movzbl 0x3(%rax),%eax
ffffffff801046f4:	0f b6 d0             	movzbl %al,%edx
ffffffff801046f7:	8b 05 e7 bc 00 00    	mov    0xbce7(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801046fd:	89 c6                	mov    %eax,%esi
ffffffff801046ff:	48 c7 c7 d1 9d 10 80 	mov    $0xffffffff80109dd1,%rdi
ffffffff80104706:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010470b:	e8 b0 be ff ff       	call   ffffffff801005c0 <cprintf>
      cpus[ncpu].id = ncpu;
ffffffff80104710:	8b 15 ce bc 00 00    	mov    0xbcce(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff80104716:	8b 05 c8 bc 00 00    	mov    0xbcc8(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff8010471c:	89 d1                	mov    %edx,%ecx
ffffffff8010471e:	48 63 d0             	movslq %eax,%rdx
ffffffff80104721:	48 89 d0             	mov    %rdx,%rax
ffffffff80104724:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80104728:	48 29 d0             	sub    %rdx,%rax
ffffffff8010472b:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010472f:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80104735:	88 08                	mov    %cl,(%rax)
      cpus[ncpu].apicid = lapic->apic_id;
ffffffff80104737:	8b 15 a7 bc 00 00    	mov    0xbca7(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff8010473d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80104741:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
ffffffff80104745:	48 63 d2             	movslq %edx,%rdx
ffffffff80104748:	48 89 d0             	mov    %rdx,%rax
ffffffff8010474b:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010474f:	48 29 d0             	sub    %rdx,%rax
ffffffff80104752:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80104756:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff8010475c:	88 08                	mov    %cl,(%rax)
      ncpu++;
ffffffff8010475e:	8b 05 80 bc 00 00    	mov    0xbc80(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104764:	83 c0 01             	add    $0x1,%eax
ffffffff80104767:	89 05 77 bc 00 00    	mov    %eax,0xbc77(%rip)        # ffffffff801103e4 <ncpu>
      break;
ffffffff8010476d:	eb 74                	jmp    ffffffff801047e3 <acpi_config_smp+0x1e2>
    }
    case TYPE_IOAPIC: {
      struct madt_ioapic *ioapic = (void*) p;
ffffffff8010476f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104773:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
      if (len < sizeof(*ioapic))
ffffffff80104777:	83 7d dc 0b          	cmpl   $0xb,-0x24(%rbp)
ffffffff8010477b:	76 65                	jbe    ffffffff801047e2 <acpi_config_smp+0x1e1>
        break;
      cprintf("acpi: ioapic#%d @%x id=%d base=%d\n",
ffffffff8010477d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104781:	8b 70 08             	mov    0x8(%rax),%esi
        nioapic, ioapic->addr, ioapic->id, ioapic->interrupt_base);
ffffffff80104784:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104788:	0f b6 40 02          	movzbl 0x2(%rax),%eax
      cprintf("acpi: ioapic#%d @%x id=%d base=%d\n",
ffffffff8010478c:	0f b6 c8             	movzbl %al,%ecx
ffffffff8010478f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104793:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80104796:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104799:	41 89 f0             	mov    %esi,%r8d
ffffffff8010479c:	89 c6                	mov    %eax,%esi
ffffffff8010479e:	48 c7 c7 f0 9d 10 80 	mov    $0xffffffff80109df0,%rdi
ffffffff801047a5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801047aa:	e8 11 be ff ff       	call   ffffffff801005c0 <cprintf>
      if (nioapic) {
ffffffff801047af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801047b3:	74 13                	je     ffffffff801047c8 <acpi_config_smp+0x1c7>
        cprintf("warning: multiple ioapics are not supported");
ffffffff801047b5:	48 c7 c7 18 9e 10 80 	mov    $0xffffffff80109e18,%rdi
ffffffff801047bc:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801047c1:	e8 fa bd ff ff       	call   ffffffff801005c0 <cprintf>
ffffffff801047c6:	eb 0e                	jmp    ffffffff801047d6 <acpi_config_smp+0x1d5>
      } else {
        ioapicid = ioapic->id;
ffffffff801047c8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801047cc:	0f b6 40 02          	movzbl 0x2(%rax),%eax
ffffffff801047d0:	88 05 12 bc 00 00    	mov    %al,0xbc12(%rip)        # ffffffff801103e8 <ioapicid>
      }
      nioapic++;
ffffffff801047d6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
      break;
ffffffff801047da:	eb 07                	jmp    ffffffff801047e3 <acpi_config_smp+0x1e2>
        break;
ffffffff801047dc:	90                   	nop
ffffffff801047dd:	eb 04                	jmp    ffffffff801047e3 <acpi_config_smp+0x1e2>
        break;
ffffffff801047df:	90                   	nop
ffffffff801047e0:	eb 01                	jmp    ffffffff801047e3 <acpi_config_smp+0x1e2>
        break;
ffffffff801047e2:	90                   	nop
    }
    }
    p += len;
ffffffff801047e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801047e6:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  while (p < e) {
ffffffff801047ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801047ee:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffffffff801047f2:	0f 82 7a fe ff ff    	jb     ffffffff80104672 <acpi_config_smp+0x71>
ffffffff801047f8:	eb 04                	jmp    ffffffff801047fe <acpi_config_smp+0x1fd>
      break;
ffffffff801047fa:	90                   	nop
ffffffff801047fb:	eb 01                	jmp    ffffffff801047fe <acpi_config_smp+0x1fd>
      break;
ffffffff801047fd:	90                   	nop
  }

  if (ncpu) {
ffffffff801047fe:	8b 05 e0 bb 00 00    	mov    0xbbe0(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104804:	85 c0                	test   %eax,%eax
ffffffff80104806:	74 28                	je     ffffffff80104830 <acpi_config_smp+0x22f>
    ismp = 1;
ffffffff80104808:	c7 05 ce bb 00 00 01 	movl   $0x1,0xbbce(%rip)        # ffffffff801103e0 <ismp>
ffffffff8010480f:	00 00 00 
    lapic = IO2V(((uintp)lapic_addr));
ffffffff80104812:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80104815:	48 ba 00 00 00 42 fe 	movabs $0xfffffffe42000000,%rdx
ffffffff8010481c:	ff ff ff 
ffffffff8010481f:	48 01 d0             	add    %rdx,%rax
ffffffff80104822:	48 89 05 57 b3 00 00 	mov    %rax,0xb357(%rip)        # ffffffff8010fb80 <lapic>
    return 0;
ffffffff80104829:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010482e:	eb 05                	jmp    ffffffff80104835 <acpi_config_smp+0x234>
  }

  return -1;
ffffffff80104830:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80104835:	c9                   	leave
ffffffff80104836:	c3                   	ret

ffffffff80104837 <acpiinit>:
#define PHYSLIMIT 0x80000000
#else
#define PHYSLIMIT 0x0E000000
#endif

int acpiinit(void) {
ffffffff80104837:	f3 0f 1e fa          	endbr64
ffffffff8010483b:	55                   	push   %rbp
ffffffff8010483c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010483f:	48 83 ec 30          	sub    $0x30,%rsp
  unsigned n, count;
  struct acpi_rdsp *rdsp;
  struct acpi_rsdt *rsdt;
  struct acpi_madt *madt = 0;
ffffffff80104843:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff8010484a:	00 

  rdsp = find_rdsp();
ffffffff8010484b:	e8 56 fd ff ff       	call   ffffffff801045a6 <find_rdsp>
ffffffff80104850:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  if (rdsp->rsdt_addr_phys > PHYSLIMIT)
ffffffff80104854:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104858:	8b 40 10             	mov    0x10(%rax),%eax
ffffffff8010485b:	3d 00 00 00 80       	cmp    $0x80000000,%eax
ffffffff80104860:	0f 87 a3 00 00 00    	ja     ffffffff80104909 <acpiinit+0xd2>
    goto notmapped;
  rsdt = p2v(rdsp->rsdt_addr_phys);
ffffffff80104866:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010486a:	8b 40 10             	mov    0x10(%rax),%eax
ffffffff8010486d:	89 c0                	mov    %eax,%eax
ffffffff8010486f:	48 89 c7             	mov    %rax,%rdi
ffffffff80104872:	e8 85 fc ff ff       	call   ffffffff801044fc <p2v>
ffffffff80104877:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  count = (rsdt->header.length - sizeof(*rsdt)) / 4;
ffffffff8010487b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010487f:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80104882:	89 c0                	mov    %eax,%eax
ffffffff80104884:	48 83 e8 24          	sub    $0x24,%rax
ffffffff80104888:	48 c1 e8 02          	shr    $0x2,%rax
ffffffff8010488c:	89 45 dc             	mov    %eax,-0x24(%rbp)
  for (n = 0; n < count; n++) {
ffffffff8010488f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104896:	eb 5b                	jmp    ffffffff801048f3 <acpiinit+0xbc>
    struct acpi_desc_header *hdr = p2v(rsdt->entry[n]);
ffffffff80104898:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010489c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010489f:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801048a3:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff801048a7:	89 c0                	mov    %eax,%eax
ffffffff801048a9:	48 89 c7             	mov    %rax,%rdi
ffffffff801048ac:	e8 4b fc ff ff       	call   ffffffff801044fc <p2v>
ffffffff801048b1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (rsdt->entry[n] > PHYSLIMIT)
ffffffff801048b5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801048b9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801048bc:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801048c0:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff801048c4:	3d 00 00 00 80       	cmp    $0x80000000,%eax
ffffffff801048c9:	77 41                	ja     ffffffff8010490c <acpiinit+0xd5>
    memmove(creator, hdr->creator_id, 4); creator[4] = 0;
    cprintf("acpi: %s %s %s %x %s %x\n",
      sig, id, tableid, hdr->oem_revision,
      creator, hdr->creator_revision);
#endif
    if (!memcmp(hdr->signature, SIG_MADT, 4))
ffffffff801048cb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801048cf:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff801048d4:	48 c7 c6 44 9e 10 80 	mov    $0xffffffff80109e44,%rsi
ffffffff801048db:	48 89 c7             	mov    %rax,%rdi
ffffffff801048de:	e8 e0 18 00 00       	call   ffffffff801061c3 <memcmp>
ffffffff801048e3:	85 c0                	test   %eax,%eax
ffffffff801048e5:	75 08                	jne    ffffffff801048ef <acpiinit+0xb8>
      madt = (void*) hdr;
ffffffff801048e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801048eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for (n = 0; n < count; n++) {
ffffffff801048ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801048f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801048f6:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff801048f9:	72 9d                	jb     ffffffff80104898 <acpiinit+0x61>
  }

  return acpi_config_smp(madt);
ffffffff801048fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801048ff:	48 89 c7             	mov    %rax,%rdi
ffffffff80104902:	e8 fa fc ff ff       	call   ffffffff80104601 <acpi_config_smp>
ffffffff80104907:	eb 1f                	jmp    ffffffff80104928 <acpiinit+0xf1>
    goto notmapped;
ffffffff80104909:	90                   	nop
ffffffff8010490a:	eb 01                	jmp    ffffffff8010490d <acpiinit+0xd6>
      goto notmapped;
ffffffff8010490c:	90                   	nop

notmapped:
  cprintf("acpi: tables above 0x%x not mapped.\n", PHYSLIMIT);
ffffffff8010490d:	be 00 00 00 80       	mov    $0x80000000,%esi
ffffffff80104912:	48 c7 c7 50 9e 10 80 	mov    $0xffffffff80109e50,%rdi
ffffffff80104919:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010491e:	e8 9d bc ff ff       	call   ffffffff801005c0 <cprintf>
  return -1;
ffffffff80104923:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80104928:	c9                   	leave
ffffffff80104929:	c3                   	ret

ffffffff8010492a <outb>:
{
ffffffff8010492a:	55                   	push   %rbp
ffffffff8010492b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010492e:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80104932:	89 fa                	mov    %edi,%edx
ffffffff80104934:	89 f0                	mov    %esi,%eax
ffffffff80104936:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff8010493a:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff8010493d:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80104941:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80104945:	ee                   	out    %al,(%dx)
}
ffffffff80104946:	90                   	nop
ffffffff80104947:	c9                   	leave
ffffffff80104948:	c3                   	ret

ffffffff80104949 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
ffffffff80104949:	f3 0f 1e fa          	endbr64
ffffffff8010494d:	55                   	push   %rbp
ffffffff8010494e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104951:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80104955:	89 f8                	mov    %edi,%eax
ffffffff80104957:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  irqmask = mask;
ffffffff8010495b:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff8010495f:	66 89 05 da 6b 00 00 	mov    %ax,0x6bda(%rip)        # ffffffff8010b540 <irqmask>
  outb(IO_PIC1+1, mask);
ffffffff80104966:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff8010496a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010496d:	89 c6                	mov    %eax,%esi
ffffffff8010496f:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104974:	e8 b1 ff ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC2+1, mask >> 8);
ffffffff80104979:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff8010497d:	66 c1 e8 08          	shr    $0x8,%ax
ffffffff80104981:	0f b6 c0             	movzbl %al,%eax
ffffffff80104984:	89 c6                	mov    %eax,%esi
ffffffff80104986:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff8010498b:	e8 9a ff ff ff       	call   ffffffff8010492a <outb>
}
ffffffff80104990:	90                   	nop
ffffffff80104991:	c9                   	leave
ffffffff80104992:	c3                   	ret

ffffffff80104993 <picenable>:

void
picenable(int irq)
{
ffffffff80104993:	f3 0f 1e fa          	endbr64
ffffffff80104997:	55                   	push   %rbp
ffffffff80104998:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010499b:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010499f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  picsetmask(irqmask & ~(1<<irq));
ffffffff801049a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801049a5:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff801049aa:	89 c1                	mov    %eax,%ecx
ffffffff801049ac:	d3 e2                	shl    %cl,%edx
ffffffff801049ae:	89 d0                	mov    %edx,%eax
ffffffff801049b0:	f7 d0                	not    %eax
ffffffff801049b2:	89 c2                	mov    %eax,%edx
ffffffff801049b4:	0f b7 05 85 6b 00 00 	movzwl 0x6b85(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff801049bb:	21 d0                	and    %edx,%eax
ffffffff801049bd:	0f b7 c0             	movzwl %ax,%eax
ffffffff801049c0:	89 c7                	mov    %eax,%edi
ffffffff801049c2:	e8 82 ff ff ff       	call   ffffffff80104949 <picsetmask>
}
ffffffff801049c7:	90                   	nop
ffffffff801049c8:	c9                   	leave
ffffffff801049c9:	c3                   	ret

ffffffff801049ca <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
ffffffff801049ca:	f3 0f 1e fa          	endbr64
ffffffff801049ce:	55                   	push   %rbp
ffffffff801049cf:	48 89 e5             	mov    %rsp,%rbp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
ffffffff801049d2:	be ff 00 00 00       	mov    $0xff,%esi
ffffffff801049d7:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff801049dc:	e8 49 ff ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC2+1, 0xFF);
ffffffff801049e1:	be ff 00 00 00       	mov    $0xff,%esi
ffffffff801049e6:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff801049eb:	e8 3a ff ff ff       	call   ffffffff8010492a <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
ffffffff801049f0:	be 11 00 00 00       	mov    $0x11,%esi
ffffffff801049f5:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff801049fa:	e8 2b ff ff ff       	call   ffffffff8010492a <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
ffffffff801049ff:	be 20 00 00 00       	mov    $0x20,%esi
ffffffff80104a04:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104a09:	e8 1c ff ff ff       	call   ffffffff8010492a <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
ffffffff80104a0e:	be 04 00 00 00       	mov    $0x4,%esi
ffffffff80104a13:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104a18:	e8 0d ff ff ff       	call   ffffffff8010492a <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
ffffffff80104a1d:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff80104a22:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104a27:	e8 fe fe ff ff       	call   ffffffff8010492a <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
ffffffff80104a2c:	be 11 00 00 00       	mov    $0x11,%esi
ffffffff80104a31:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff80104a36:	e8 ef fe ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
ffffffff80104a3b:	be 28 00 00 00       	mov    $0x28,%esi
ffffffff80104a40:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff80104a45:	e8 e0 fe ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
ffffffff80104a4a:	be 02 00 00 00       	mov    $0x2,%esi
ffffffff80104a4f:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff80104a54:	e8 d1 fe ff ff       	call   ffffffff8010492a <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
ffffffff80104a59:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff80104a5e:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff80104a63:	e8 c2 fe ff ff       	call   ffffffff8010492a <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
ffffffff80104a68:	be 68 00 00 00       	mov    $0x68,%esi
ffffffff80104a6d:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80104a72:	e8 b3 fe ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
ffffffff80104a77:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80104a7c:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80104a81:	e8 a4 fe ff ff       	call   ffffffff8010492a <outb>

  outb(IO_PIC2, 0x68);             // OCW3
ffffffff80104a86:	be 68 00 00 00       	mov    $0x68,%esi
ffffffff80104a8b:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff80104a90:	e8 95 fe ff ff       	call   ffffffff8010492a <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
ffffffff80104a95:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80104a9a:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff80104a9f:	e8 86 fe ff ff       	call   ffffffff8010492a <outb>

  if(irqmask != 0xFFFF)
ffffffff80104aa4:	0f b7 05 95 6a 00 00 	movzwl 0x6a95(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff80104aab:	66 83 f8 ff          	cmp    $0xffff,%ax
ffffffff80104aaf:	74 11                	je     ffffffff80104ac2 <picinit+0xf8>
    picsetmask(irqmask);
ffffffff80104ab1:	0f b7 05 88 6a 00 00 	movzwl 0x6a88(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff80104ab8:	0f b7 c0             	movzwl %ax,%eax
ffffffff80104abb:	89 c7                	mov    %eax,%edi
ffffffff80104abd:	e8 87 fe ff ff       	call   ffffffff80104949 <picsetmask>
}
ffffffff80104ac2:	90                   	nop
ffffffff80104ac3:	5d                   	pop    %rbp
ffffffff80104ac4:	c3                   	ret

ffffffff80104ac5 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffffffff80104ac5:	f3 0f 1e fa          	endbr64
ffffffff80104ac9:	55                   	push   %rbp
ffffffff80104aca:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104acd:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80104ad1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104ad5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffffffff80104ad9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffffffff80104ae0:	00 
  *f0 = *f1 = 0;
ffffffff80104ae1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104ae5:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffffffff80104aec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104af0:	48 8b 10             	mov    (%rax),%rdx
ffffffff80104af3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104af7:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffffffff80104afa:	e8 d5 c9 ff ff       	call   ffffffff801014d4 <filealloc>
ffffffff80104aff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104b03:	48 89 02             	mov    %rax,(%rdx)
ffffffff80104b06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104b0a:	48 8b 00             	mov    (%rax),%rax
ffffffff80104b0d:	48 85 c0             	test   %rax,%rax
ffffffff80104b10:	0f 84 e6 00 00 00    	je     ffffffff80104bfc <pipealloc+0x137>
ffffffff80104b16:	e8 b9 c9 ff ff       	call   ffffffff801014d4 <filealloc>
ffffffff80104b1b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80104b1f:	48 89 02             	mov    %rax,(%rdx)
ffffffff80104b22:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104b26:	48 8b 00             	mov    (%rax),%rax
ffffffff80104b29:	48 85 c0             	test   %rax,%rax
ffffffff80104b2c:	0f 84 ca 00 00 00    	je     ffffffff80104bfc <pipealloc+0x137>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffffffff80104b32:	e8 96 e8 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80104b37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80104b3b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80104b40:	0f 84 b9 00 00 00    	je     ffffffff80104bff <pipealloc+0x13a>
    goto bad;
  p->readopen = 1;
ffffffff80104b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b4a:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffffffff80104b51:	00 00 00 
  p->writeopen = 1;
ffffffff80104b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b58:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffffffff80104b5f:	00 00 00 
  p->nwrite = 0;
ffffffff80104b62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b66:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffffffff80104b6d:	00 00 00 
  p->nread = 0;
ffffffff80104b70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b74:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffffffff80104b7b:	00 00 00 
  initlock(&p->lock, "pipe");
ffffffff80104b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b82:	48 c7 c6 75 9e 10 80 	mov    $0xffffffff80109e75,%rsi
ffffffff80104b89:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b8c:	e8 e9 11 00 00       	call   ffffffff80105d7a <initlock>
  (*f0)->type = FD_PIPE;
ffffffff80104b91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104b95:	48 8b 00             	mov    (%rax),%rax
ffffffff80104b98:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffffffff80104b9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ba2:	48 8b 00             	mov    (%rax),%rax
ffffffff80104ba5:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffffffff80104ba9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104bad:	48 8b 00             	mov    (%rax),%rax
ffffffff80104bb0:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffffffff80104bb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104bb8:	48 8b 00             	mov    (%rax),%rax
ffffffff80104bbb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104bbf:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffffffff80104bc3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104bc7:	48 8b 00             	mov    (%rax),%rax
ffffffff80104bca:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffffffff80104bd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104bd4:	48 8b 00             	mov    (%rax),%rax
ffffffff80104bd7:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffffffff80104bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104bdf:	48 8b 00             	mov    (%rax),%rax
ffffffff80104be2:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffffffff80104be6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104bea:	48 8b 00             	mov    (%rax),%rax
ffffffff80104bed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104bf1:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffffffff80104bf5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104bfa:	eb 52                	jmp    ffffffff80104c4e <pipealloc+0x189>
    goto bad;
ffffffff80104bfc:	90                   	nop
ffffffff80104bfd:	eb 01                	jmp    ffffffff80104c00 <pipealloc+0x13b>
    goto bad;
ffffffff80104bff:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffffffff80104c00:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80104c05:	74 0c                	je     ffffffff80104c13 <pipealloc+0x14e>
    kfree((char*)p);
ffffffff80104c07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104c0b:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c0e:	e8 0c e7 ff ff       	call   ffffffff8010331f <kfree>
  if(*f0)
ffffffff80104c13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c17:	48 8b 00             	mov    (%rax),%rax
ffffffff80104c1a:	48 85 c0             	test   %rax,%rax
ffffffff80104c1d:	74 0f                	je     ffffffff80104c2e <pipealloc+0x169>
    fileclose(*f0);
ffffffff80104c1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c23:	48 8b 00             	mov    (%rax),%rax
ffffffff80104c26:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c29:	e8 6b c9 ff ff       	call   ffffffff80101599 <fileclose>
  if(*f1)
ffffffff80104c2e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104c32:	48 8b 00             	mov    (%rax),%rax
ffffffff80104c35:	48 85 c0             	test   %rax,%rax
ffffffff80104c38:	74 0f                	je     ffffffff80104c49 <pipealloc+0x184>
    fileclose(*f1);
ffffffff80104c3a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104c3e:	48 8b 00             	mov    (%rax),%rax
ffffffff80104c41:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c44:	e8 50 c9 ff ff       	call   ffffffff80101599 <fileclose>
  return -1;
ffffffff80104c49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80104c4e:	c9                   	leave
ffffffff80104c4f:	c3                   	ret

ffffffff80104c50 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffffffff80104c50:	f3 0f 1e fa          	endbr64
ffffffff80104c54:	55                   	push   %rbp
ffffffff80104c55:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104c58:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80104c5c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80104c60:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffffffff80104c63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104c67:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c6a:	e8 44 11 00 00       	call   ffffffff80105db3 <acquire>
  if(writable){
ffffffff80104c6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff80104c73:	74 22                	je     ffffffff80104c97 <pipeclose+0x47>
    p->writeopen = 0;
ffffffff80104c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104c79:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffffffff80104c80:	00 00 00 
    wakeup(&p->nread);
ffffffff80104c83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104c87:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104c8d:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c90:	e8 9e 0e 00 00       	call   ffffffff80105b33 <wakeup>
ffffffff80104c95:	eb 20                	jmp    ffffffff80104cb7 <pipeclose+0x67>
  } else {
    p->readopen = 0;
ffffffff80104c97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104c9b:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffffffff80104ca2:	00 00 00 
    wakeup(&p->nwrite);
ffffffff80104ca5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ca9:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffffffff80104caf:	48 89 c7             	mov    %rax,%rdi
ffffffff80104cb2:	e8 7c 0e 00 00       	call   ffffffff80105b33 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffffffff80104cb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104cbb:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffffffff80104cc1:	85 c0                	test   %eax,%eax
ffffffff80104cc3:	75 28                	jne    ffffffff80104ced <pipeclose+0x9d>
ffffffff80104cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104cc9:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffffffff80104ccf:	85 c0                	test   %eax,%eax
ffffffff80104cd1:	75 1a                	jne    ffffffff80104ced <pipeclose+0x9d>
    release(&p->lock);
ffffffff80104cd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104cd7:	48 89 c7             	mov    %rax,%rdi
ffffffff80104cda:	e8 af 11 00 00       	call   ffffffff80105e8e <release>
    kfree((char*)p);
ffffffff80104cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ce3:	48 89 c7             	mov    %rax,%rdi
ffffffff80104ce6:	e8 34 e6 ff ff       	call   ffffffff8010331f <kfree>
ffffffff80104ceb:	eb 0d                	jmp    ffffffff80104cfa <pipeclose+0xaa>
  } else
    release(&p->lock);
ffffffff80104ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104cf1:	48 89 c7             	mov    %rax,%rdi
ffffffff80104cf4:	e8 95 11 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80104cf9:	90                   	nop
ffffffff80104cfa:	90                   	nop
ffffffff80104cfb:	c9                   	leave
ffffffff80104cfc:	c3                   	ret

ffffffff80104cfd <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffffffff80104cfd:	f3 0f 1e fa          	endbr64
ffffffff80104d01:	55                   	push   %rbp
ffffffff80104d02:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104d05:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80104d09:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104d0d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80104d11:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffffffff80104d14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d18:	48 89 c7             	mov    %rax,%rdi
ffffffff80104d1b:	e8 93 10 00 00       	call   ffffffff80105db3 <acquire>
  for(i = 0; i < n; i++){
ffffffff80104d20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104d27:	e9 bc 00 00 00       	jmp    ffffffff80104de8 <pipewrite+0xeb>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffffffff80104d2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d30:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffffffff80104d36:	85 c0                	test   %eax,%eax
ffffffff80104d38:	74 12                	je     ffffffff80104d4c <pipewrite+0x4f>
ffffffff80104d3a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80104d41:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80104d45:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80104d48:	85 c0                	test   %eax,%eax
ffffffff80104d4a:	74 16                	je     ffffffff80104d62 <pipewrite+0x65>
        release(&p->lock);
ffffffff80104d4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d50:	48 89 c7             	mov    %rax,%rdi
ffffffff80104d53:	e8 36 11 00 00       	call   ffffffff80105e8e <release>
        return -1;
ffffffff80104d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80104d5d:	e9 af 00 00 00       	jmp    ffffffff80104e11 <pipewrite+0x114>
      }
      wakeup(&p->nread);
ffffffff80104d62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d66:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104d6c:	48 89 c7             	mov    %rax,%rdi
ffffffff80104d6f:	e8 bf 0d 00 00       	call   ffffffff80105b33 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffffffff80104d74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d78:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104d7c:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffffffff80104d83:	48 89 c6             	mov    %rax,%rsi
ffffffff80104d86:	48 89 d7             	mov    %rdx,%rdi
ffffffff80104d89:	e8 89 0c 00 00       	call   ffffffff80105a17 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffffffff80104d8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d92:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffffffff80104d98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d9c:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffffffff80104da2:	05 00 02 00 00       	add    $0x200,%eax
ffffffff80104da7:	39 c2                	cmp    %eax,%edx
ffffffff80104da9:	74 81                	je     ffffffff80104d2c <pipewrite+0x2f>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffffffff80104dab:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104dae:	48 63 d0             	movslq %eax,%rdx
ffffffff80104db1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104db5:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffffffff80104db9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104dbd:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104dc3:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80104dc6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104dca:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffffffff80104dd0:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80104dd5:	89 c1                	mov    %eax,%ecx
ffffffff80104dd7:	0f b6 16             	movzbl (%rsi),%edx
ffffffff80104dda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104dde:	89 c9                	mov    %ecx,%ecx
ffffffff80104de0:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffffffff80104de4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80104de8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104deb:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80104dee:	7c 9e                	jl     ffffffff80104d8e <pipewrite+0x91>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffffffff80104df0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104df4:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104dfa:	48 89 c7             	mov    %rax,%rdi
ffffffff80104dfd:	e8 31 0d 00 00       	call   ffffffff80105b33 <wakeup>
  release(&p->lock);
ffffffff80104e02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e06:	48 89 c7             	mov    %rax,%rdi
ffffffff80104e09:	e8 80 10 00 00       	call   ffffffff80105e8e <release>
  return n;
ffffffff80104e0e:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff80104e11:	c9                   	leave
ffffffff80104e12:	c3                   	ret

ffffffff80104e13 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffffffff80104e13:	f3 0f 1e fa          	endbr64
ffffffff80104e17:	55                   	push   %rbp
ffffffff80104e18:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104e1b:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80104e1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104e23:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80104e27:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffffffff80104e2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e2e:	48 89 c7             	mov    %rax,%rdi
ffffffff80104e31:	e8 7d 0f 00 00       	call   ffffffff80105db3 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff80104e36:	eb 42                	jmp    ffffffff80104e7a <piperead+0x67>
    if(proc->killed){
ffffffff80104e38:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80104e3f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80104e43:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80104e46:	85 c0                	test   %eax,%eax
ffffffff80104e48:	74 16                	je     ffffffff80104e60 <piperead+0x4d>
      release(&p->lock);
ffffffff80104e4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e4e:	48 89 c7             	mov    %rax,%rdi
ffffffff80104e51:	e8 38 10 00 00       	call   ffffffff80105e8e <release>
      return -1;
ffffffff80104e56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80104e5b:	e9 c9 00 00 00       	jmp    ffffffff80104f29 <piperead+0x116>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffffffff80104e60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e64:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104e68:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffffffff80104e6f:	48 89 c6             	mov    %rax,%rsi
ffffffff80104e72:	48 89 d7             	mov    %rdx,%rdi
ffffffff80104e75:	e8 9d 0b 00 00       	call   ffffffff80105a17 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff80104e7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e7e:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffffffff80104e84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e88:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104e8e:	39 c2                	cmp    %eax,%edx
ffffffff80104e90:	75 0e                	jne    ffffffff80104ea0 <piperead+0x8d>
ffffffff80104e92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104e96:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffffffff80104e9c:	85 c0                	test   %eax,%eax
ffffffff80104e9e:	75 98                	jne    ffffffff80104e38 <piperead+0x25>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff80104ea0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104ea7:	eb 54                	jmp    ffffffff80104efd <piperead+0xea>
    if(p->nread == p->nwrite)
ffffffff80104ea9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ead:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffffffff80104eb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104eb7:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104ebd:	39 c2                	cmp    %eax,%edx
ffffffff80104ebf:	74 46                	je     ffffffff80104f07 <piperead+0xf4>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffffffff80104ec1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ec5:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffffffff80104ecb:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80104ece:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104ed2:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffffffff80104ed8:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80104edd:	89 c1                	mov    %eax,%ecx
ffffffff80104edf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104ee2:	48 63 d0             	movslq %eax,%rdx
ffffffff80104ee5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104ee9:	48 01 c2             	add    %rax,%rdx
ffffffff80104eec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ef0:	89 c9                	mov    %ecx,%ecx
ffffffff80104ef2:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffffffff80104ef7:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff80104ef9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80104efd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104f00:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80104f03:	7c a4                	jl     ffffffff80104ea9 <piperead+0x96>
ffffffff80104f05:	eb 01                	jmp    ffffffff80104f08 <piperead+0xf5>
      break;
ffffffff80104f07:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffffffff80104f08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104f0c:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffffffff80104f12:	48 89 c7             	mov    %rax,%rdi
ffffffff80104f15:	e8 19 0c 00 00       	call   ffffffff80105b33 <wakeup>
  release(&p->lock);
ffffffff80104f1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104f1e:	48 89 c7             	mov    %rax,%rdi
ffffffff80104f21:	e8 68 0f 00 00       	call   ffffffff80105e8e <release>
  return i;
ffffffff80104f26:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80104f29:	c9                   	leave
ffffffff80104f2a:	c3                   	ret

ffffffff80104f2b <readeflags>:
{
ffffffff80104f2b:	55                   	push   %rbp
ffffffff80104f2c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104f2f:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff80104f33:	9c                   	pushf
ffffffff80104f34:	58                   	pop    %rax
ffffffff80104f35:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff80104f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80104f3d:	c9                   	leave
ffffffff80104f3e:	c3                   	ret

ffffffff80104f3f <sti>:
{
ffffffff80104f3f:	55                   	push   %rbp
ffffffff80104f40:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffffffff80104f43:	fb                   	sti
}
ffffffff80104f44:	90                   	nop
ffffffff80104f45:	5d                   	pop    %rbp
ffffffff80104f46:	c3                   	ret

ffffffff80104f47 <hlt>:
{
ffffffff80104f47:	55                   	push   %rbp
ffffffff80104f48:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffffffff80104f4b:	f4                   	hlt
}
ffffffff80104f4c:	90                   	nop
ffffffff80104f4d:	5d                   	pop    %rbp
ffffffff80104f4e:	c3                   	ret

ffffffff80104f4f <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffffffff80104f4f:	f3 0f 1e fa          	endbr64
ffffffff80104f53:	55                   	push   %rbp
ffffffff80104f54:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffffffff80104f57:	48 c7 c6 7a 9e 10 80 	mov    $0xffffffff80109e7a,%rsi
ffffffff80104f5e:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104f65:	e8 10 0e 00 00       	call   ffffffff80105d7a <initlock>
}
ffffffff80104f6a:	90                   	nop
ffffffff80104f6b:	5d                   	pop    %rbp
ffffffff80104f6c:	c3                   	ret

ffffffff80104f6d <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffffffff80104f6d:	f3 0f 1e fa          	endbr64
ffffffff80104f71:	55                   	push   %rbp
ffffffff80104f72:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104f75:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffffffff80104f79:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104f80:	e8 2e 0e 00 00       	call   ffffffff80105db3 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80104f85:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80104f8c:	80 
ffffffff80104f8d:	eb 13                	jmp    ffffffff80104fa2 <allocproc+0x35>
    if(p->state == UNUSED)
ffffffff80104f8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f93:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80104f96:	85 c0                	test   %eax,%eax
ffffffff80104f98:	74 28                	je     ffffffff80104fc2 <allocproc+0x55>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80104f9a:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80104fa1:	00 
ffffffff80104fa2:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80104fa9:	80 
ffffffff80104faa:	72 e3                	jb     ffffffff80104f8f <allocproc+0x22>
      goto found;
  release(&ptable.lock);
ffffffff80104fac:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104fb3:	e8 d6 0e 00 00       	call   ffffffff80105e8e <release>
  return 0;
ffffffff80104fb8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104fbd:	e9 e3 00 00 00       	jmp    ffffffff801050a5 <allocproc+0x138>
      goto found;
ffffffff80104fc2:	90                   	nop

found:
  p->state = EMBRYO;
ffffffff80104fc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fc7:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffffffff80104fce:	8b 05 8c 65 00 00    	mov    0x658c(%rip),%eax        # ffffffff8010b560 <nextpid>
ffffffff80104fd4:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80104fd7:	89 15 83 65 00 00    	mov    %edx,0x6583(%rip)        # ffffffff8010b560 <nextpid>
ffffffff80104fdd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104fe1:	89 42 1c             	mov    %eax,0x1c(%rdx)
  p->ticks = 0;
ffffffff80104fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fe8:	c7 80 e4 00 00 00 00 	movl   $0x0,0xe4(%rax)
ffffffff80104fef:	00 00 00 
  release(&ptable.lock);
ffffffff80104ff2:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104ff9:	e8 90 0e 00 00       	call   ffffffff80105e8e <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffffffff80104ffe:	e8 ca e3 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80105003:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80105007:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffffffff8010500b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010500f:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80105013:	48 85 c0             	test   %rax,%rax
ffffffff80105016:	75 12                	jne    ffffffff8010502a <allocproc+0xbd>
    p->state = UNUSED;
ffffffff80105018:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010501c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffffffff80105023:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105028:	eb 7b                	jmp    ffffffff801050a5 <allocproc+0x138>
  }
  sp = p->kstack + KSTACKSIZE;
ffffffff8010502a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010502e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80105032:	48 05 00 10 00 00    	add    $0x1000,%rax
ffffffff80105038:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffffffff8010503c:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffffffff80105043:	00 
  p->tf = (struct trapframe*)sp;
ffffffff80105044:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105048:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff8010504c:	48 89 50 28          	mov    %rdx,0x28(%rax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(uintp);
ffffffff80105050:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(uintp*)sp = (uintp)trapret;
ffffffff80105055:	48 c7 c2 5c 7a 10 80 	mov    $0xffffffff80107a5c,%rdx
ffffffff8010505c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105060:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffffffff80105063:	48 83 6d f0 40       	subq   $0x40,-0x10(%rbp)
  p->context = (struct context*)sp;
ffffffff80105068:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010506c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80105070:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffffffff80105074:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105078:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff8010507c:	ba 40 00 00 00       	mov    $0x40,%edx
ffffffff80105081:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80105086:	48 89 c7             	mov    %rax,%rdi
ffffffff80105089:	e8 b1 10 00 00       	call   ffffffff8010613f <memset>
  p->context->eip = (uintp)forkret;
ffffffff8010508e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105092:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80105096:	48 c7 c2 e7 59 10 80 	mov    $0xffffffff801059e7,%rdx
ffffffff8010509d:	48 89 50 38          	mov    %rdx,0x38(%rax)

  return p;
ffffffff801050a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801050a5:	c9                   	leave
ffffffff801050a6:	c3                   	ret

ffffffff801050a7 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffffffff801050a7:	f3 0f 1e fa          	endbr64
ffffffff801050ab:	55                   	push   %rbp
ffffffff801050ac:	48 89 e5             	mov    %rsp,%rbp
ffffffff801050af:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_out_initcode_start[], _binary_out_initcode_size[];
  
  p = allocproc();
ffffffff801050b3:	e8 b5 fe ff ff       	call   ffffffff80104f6d <allocproc>
ffffffff801050b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  initproc = p;
ffffffff801050bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801050c0:	48 89 05 a1 ef 00 00 	mov    %rax,0xefa1(%rip)        # ffffffff80114068 <initproc>
  if((p->pgdir = setupkvm()) == 0)
ffffffff801050c7:	e8 cf 46 00 00       	call   ffffffff8010979b <setupkvm>
ffffffff801050cc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801050d0:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffffffff801050d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801050d8:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801050dc:	48 85 c0             	test   %rax,%rax
ffffffff801050df:	75 0c                	jne    ffffffff801050ed <userinit+0x46>
    panic("userinit: out of memory?");
ffffffff801050e1:	48 c7 c7 81 9e 10 80 	mov    $0xffffffff80109e81,%rdi
ffffffff801050e8:	e8 62 b8 ff ff       	call   ffffffff8010094f <panic>
  inituvm(p->pgdir, _binary_out_initcode_start, (uintp)_binary_out_initcode_size);
ffffffff801050ed:	48 c7 c0 3c 00 00 00 	mov    $0x3c,%rax
ffffffff801050f4:	89 c2                	mov    %eax,%edx
ffffffff801050f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801050fa:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801050fe:	48 c7 c6 b0 be 10 80 	mov    $0xffffffff8010beb0,%rsi
ffffffff80105105:	48 89 c7             	mov    %rax,%rdi
ffffffff80105108:	e8 ec 3a 00 00       	call   ffffffff80108bf9 <inituvm>
  p->sz = PGSIZE;
ffffffff8010510d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105111:	48 c7 00 00 10 00 00 	movq   $0x1000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffffffff80105118:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010511c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80105120:	ba b0 00 00 00       	mov    $0xb0,%edx
ffffffff80105125:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010512a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010512d:	e8 0d 10 00 00       	call   ffffffff8010613f <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
ffffffff80105132:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105136:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010513a:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
ffffffff80105141:	23 00 00 00 
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
ffffffff80105145:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105149:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010514d:	48 c7 80 a8 00 00 00 	movq   $0x2b,0xa8(%rax)
ffffffff80105154:	2b 00 00 00 
#ifndef X64
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
#endif
  p->tf->eflags = FL_IF;
ffffffff80105158:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010515c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80105160:	48 c7 80 98 00 00 00 	movq   $0x200,0x98(%rax)
ffffffff80105167:	00 02 00 00 
  p->tf->esp = PGSIZE;
ffffffff8010516b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010516f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80105173:	48 c7 80 a0 00 00 00 	movq   $0x1000,0xa0(%rax)
ffffffff8010517a:	00 10 00 00 
  p->tf->eip = 0;  // beginning of initcode.S
ffffffff8010517e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105182:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80105186:	48 c7 80 88 00 00 00 	movq   $0x0,0x88(%rax)
ffffffff8010518d:	00 00 00 00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffffffff80105191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105195:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffffffff8010519b:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff801051a0:	48 c7 c6 9a 9e 10 80 	mov    $0xffffffff80109e9a,%rsi
ffffffff801051a7:	48 89 c7             	mov    %rax,%rdi
ffffffff801051aa:	e8 43 12 00 00       	call   ffffffff801063f2 <safestrcpy>
  p->cwd = namei("/");
ffffffff801051af:	48 c7 c7 a3 9e 10 80 	mov    $0xffffffff80109ea3,%rdi
ffffffff801051b6:	e8 60 da ff ff       	call   ffffffff80102c1b <namei>
ffffffff801051bb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801051bf:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  p->state = RUNNABLE;
ffffffff801051c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801051ca:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffffffff801051d1:	90                   	nop
ffffffff801051d2:	c9                   	leave
ffffffff801051d3:	c3                   	ret

ffffffff801051d4 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
ffffffff801051d4:	f3 0f 1e fa          	endbr64
ffffffff801051d8:	55                   	push   %rbp
ffffffff801051d9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801051dc:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801051e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  uint sz;
  
  sz = proc->sz;
ffffffff801051e3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801051ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801051ee:	48 8b 00             	mov    (%rax),%rax
ffffffff801051f1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(n > 0){
ffffffff801051f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff801051f8:	7e 34                	jle    ffffffff8010522e <growproc+0x5a>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffffffff801051fa:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801051fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105200:	01 c2                	add    %eax,%edx
ffffffff80105202:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105209:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010520d:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105211:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80105214:	89 ce                	mov    %ecx,%esi
ffffffff80105216:	48 89 c7             	mov    %rax,%rdi
ffffffff80105219:	e8 6b 3b 00 00       	call   ffffffff80108d89 <allocuvm>
ffffffff8010521e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80105221:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80105225:	75 44                	jne    ffffffff8010526b <growproc+0x97>
      return -1;
ffffffff80105227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010522c:	eb 66                	jmp    ffffffff80105294 <growproc+0xc0>
  } else if(n < 0){
ffffffff8010522e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80105232:	79 37                	jns    ffffffff8010526b <growproc+0x97>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffffffff80105234:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80105237:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010523a:	01 d0                	add    %edx,%eax
ffffffff8010523c:	89 c2                	mov    %eax,%edx
ffffffff8010523e:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80105241:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105248:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010524c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105250:	48 89 ce             	mov    %rcx,%rsi
ffffffff80105253:	48 89 c7             	mov    %rax,%rdi
ffffffff80105256:	e8 06 3c 00 00       	call   ffffffff80108e61 <deallocuvm>
ffffffff8010525b:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010525e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80105262:	75 07                	jne    ffffffff8010526b <growproc+0x97>
      return -1;
ffffffff80105264:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105269:	eb 29                	jmp    ffffffff80105294 <growproc+0xc0>
  }
  proc->sz = sz;
ffffffff8010526b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105272:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105276:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80105279:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffffffff8010527c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105283:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105287:	48 89 c7             	mov    %rax,%rdi
ffffffff8010528a:	e8 e5 47 00 00       	call   ffffffff80109a74 <switchuvm>
  return 0;
ffffffff8010528f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80105294:	c9                   	leave
ffffffff80105295:	c3                   	ret

ffffffff80105296 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffffffff80105296:	f3 0f 1e fa          	endbr64
ffffffff8010529a:	55                   	push   %rbp
ffffffff8010529b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010529e:	53                   	push   %rbx
ffffffff8010529f:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffffffff801052a3:	e8 c5 fc ff ff       	call   ffffffff80104f6d <allocproc>
ffffffff801052a8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff801052ac:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff801052b1:	75 0a                	jne    ffffffff801052bd <fork+0x27>
    return -1;
ffffffff801052b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801052b8:	e9 5f 02 00 00       	jmp    ffffffff8010551c <fork+0x286>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffffffff801052bd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801052c4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801052c8:	48 8b 00             	mov    (%rax),%rax
ffffffff801052cb:	89 c2                	mov    %eax,%edx
ffffffff801052cd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801052d4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801052d8:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801052dc:	89 d6                	mov    %edx,%esi
ffffffff801052de:	48 89 c7             	mov    %rax,%rdi
ffffffff801052e1:	e8 6b 3d 00 00       	call   ffffffff80109051 <copyuvm>
ffffffff801052e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801052ea:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffffffff801052ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801052f2:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801052f6:	48 85 c0             	test   %rax,%rax
ffffffff801052f9:	75 31                	jne    ffffffff8010532c <fork+0x96>
    kfree(np->kstack);
ffffffff801052fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801052ff:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80105303:	48 89 c7             	mov    %rax,%rdi
ffffffff80105306:	e8 14 e0 ff ff       	call   ffffffff8010331f <kfree>
    np->kstack = 0;
ffffffff8010530b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010530f:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105316:	00 
    np->state = UNUSED;
ffffffff80105317:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010531b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffffffff80105322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105327:	e9 f0 01 00 00       	jmp    ffffffff8010551c <fork+0x286>
  }
  np->sz = proc->sz;
ffffffff8010532c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105333:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105337:	48 8b 10             	mov    (%rax),%rdx
ffffffff8010533a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010533e:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffffffff80105341:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105348:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff8010534c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105350:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffffffff80105354:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010535b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010535f:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffffffff80105363:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105367:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010536b:	48 8b 0a             	mov    (%rdx),%rcx
ffffffff8010536e:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffffffff80105372:	48 89 08             	mov    %rcx,(%rax)
ffffffff80105375:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffffffff80105379:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffffffff8010537d:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffffffff80105381:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffffffff80105385:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffffffff80105389:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffffffff8010538d:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffffffff80105391:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffffffff80105395:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffffffff80105399:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffffffff8010539d:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffffffff801053a1:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffffffff801053a5:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffffffff801053a9:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffffffff801053ad:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffffffff801053b1:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffffffff801053b5:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffffffff801053b9:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffffffff801053bd:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffffffff801053c1:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffffffff801053c5:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffffffff801053c9:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffffffff801053cd:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffffffff801053d1:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffffffff801053d5:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffffffff801053d9:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffffffff801053dd:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffffffff801053e1:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffffffff801053e5:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffffffff801053e9:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffffffff801053f0:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffffffff801053f7:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffffffff801053fe:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffffffff80105405:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffffffff8010540c:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffffffff80105413:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffffffff8010541a:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffffffff80105421:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffffffff80105428:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffffffff8010542f:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffffffff80105436:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
ffffffff8010543d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105441:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80105445:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffffffff8010544c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff80105453:	eb 58                	jmp    ffffffff801054ad <fork+0x217>
    if(proc->ofile[i])
ffffffff80105455:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010545c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105460:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80105463:	48 63 d2             	movslq %edx,%rdx
ffffffff80105466:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010546a:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff8010546f:	48 85 c0             	test   %rax,%rax
ffffffff80105472:	74 35                	je     ffffffff801054a9 <fork+0x213>
      np->ofile[i] = filedup(proc->ofile[i]);
ffffffff80105474:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010547b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010547f:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80105482:	48 63 d2             	movslq %edx,%rdx
ffffffff80105485:	48 83 c2 08          	add    $0x8,%rdx
ffffffff80105489:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff8010548e:	48 89 c7             	mov    %rax,%rdi
ffffffff80105491:	e8 ad c0 ff ff       	call   ffffffff80101543 <filedup>
ffffffff80105496:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff8010549a:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffffffff8010549d:	48 63 c9             	movslq %ecx,%rcx
ffffffff801054a0:	48 83 c1 08          	add    $0x8,%rcx
ffffffff801054a4:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffffffff801054a9:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffffffff801054ad:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffffffff801054b1:	7e a2                	jle    ffffffff80105455 <fork+0x1bf>
  np->cwd = idup(proc->cwd);
ffffffff801054b3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801054ba:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801054be:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff801054c5:	48 89 c7             	mov    %rax,%rdi
ffffffff801054c8:	e8 0c ca ff ff       	call   ffffffff80101ed9 <idup>
ffffffff801054cd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801054d1:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)
 
  pid = np->pid;
ffffffff801054d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801054dc:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff801054df:	89 45 dc             	mov    %eax,-0x24(%rbp)
  np->state = RUNNABLE;
ffffffff801054e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801054e6:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffffffff801054ed:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801054f4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801054f8:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff801054ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105503:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffffffff80105509:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff8010550e:	48 89 ce             	mov    %rcx,%rsi
ffffffff80105511:	48 89 c7             	mov    %rax,%rdi
ffffffff80105514:	e8 d9 0e 00 00       	call   ffffffff801063f2 <safestrcpy>
  return pid;
ffffffff80105519:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff8010551c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80105520:	c9                   	leave
ffffffff80105521:	c3                   	ret

ffffffff80105522 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffffffff80105522:	f3 0f 1e fa          	endbr64
ffffffff80105526:	55                   	push   %rbp
ffffffff80105527:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010552a:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffffffff8010552e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105535:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff80105539:	48 8b 05 28 eb 00 00 	mov    0xeb28(%rip),%rax        # ffffffff80114068 <initproc>
ffffffff80105540:	48 39 c2             	cmp    %rax,%rdx
ffffffff80105543:	75 0c                	jne    ffffffff80105551 <exit+0x2f>
    panic("init exiting");
ffffffff80105545:	48 c7 c7 a5 9e 10 80 	mov    $0xffffffff80109ea5,%rdi
ffffffff8010554c:	e8 fe b3 ff ff       	call   ffffffff8010094f <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffffffff80105551:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffffffff80105558:	eb 63                	jmp    ffffffff801055bd <exit+0x9b>
    if(proc->ofile[fd]){
ffffffff8010555a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105561:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105565:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80105568:	48 63 d2             	movslq %edx,%rdx
ffffffff8010556b:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010556f:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff80105574:	48 85 c0             	test   %rax,%rax
ffffffff80105577:	74 40                	je     ffffffff801055b9 <exit+0x97>
      fileclose(proc->ofile[fd]);
ffffffff80105579:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105580:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105584:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80105587:	48 63 d2             	movslq %edx,%rdx
ffffffff8010558a:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010558e:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff80105593:	48 89 c7             	mov    %rax,%rdi
ffffffff80105596:	e8 fe bf ff ff       	call   ffffffff80101599 <fileclose>
      proc->ofile[fd] = 0;
ffffffff8010559b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801055a2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801055a6:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801055a9:	48 63 d2             	movslq %edx,%rdx
ffffffff801055ac:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801055b0:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff801055b7:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffffffff801055b9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffffffff801055bd:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffffffff801055c1:	7e 97                	jle    ffffffff8010555a <exit+0x38>
    }
  }

  iput(proc->cwd);
ffffffff801055c3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801055ca:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801055ce:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff801055d5:	48 89 c7             	mov    %rax,%rdi
ffffffff801055d8:	e8 26 cb ff ff       	call   ffffffff80102103 <iput>
  proc->cwd = 0;
ffffffff801055dd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801055e4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801055e8:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffffffff801055ef:	00 00 00 00 
  proc->inuse = 0;
ffffffff801055f3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801055fa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801055fe:	c7 80 e0 00 00 00 00 	movl   $0x0,0xe0(%rax)
ffffffff80105605:	00 00 00 

  acquire(&ptable.lock);
ffffffff80105608:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010560f:	e8 9f 07 00 00       	call   ffffffff80105db3 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffffffff80105614:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010561b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010561f:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff80105623:	48 89 c7             	mov    %rax,%rdi
ffffffff80105626:	e8 b3 04 00 00       	call   ffffffff80105ade <wakeup1>


  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff8010562b:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80105632:	80 
ffffffff80105633:	eb 4a                	jmp    ffffffff8010567f <exit+0x15d>
    if(p->parent == proc){
ffffffff80105635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105639:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffffffff8010563d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105644:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105648:	48 39 c2             	cmp    %rax,%rdx
ffffffff8010564b:	75 2a                	jne    ffffffff80105677 <exit+0x155>
      p->parent = initproc;
ffffffff8010564d:	48 8b 15 14 ea 00 00 	mov    0xea14(%rip),%rdx        # ffffffff80114068 <initproc>
ffffffff80105654:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105658:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffffffff8010565c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105660:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105663:	83 f8 05             	cmp    $0x5,%eax
ffffffff80105666:	75 0f                	jne    ffffffff80105677 <exit+0x155>
        wakeup1(initproc);
ffffffff80105668:	48 8b 05 f9 e9 00 00 	mov    0xe9f9(%rip),%rax        # ffffffff80114068 <initproc>
ffffffff8010566f:	48 89 c7             	mov    %rax,%rdi
ffffffff80105672:	e8 67 04 00 00       	call   ffffffff80105ade <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105677:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff8010567e:	00 
ffffffff8010567f:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105686:	80 
ffffffff80105687:	72 ac                	jb     ffffffff80105635 <exit+0x113>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffffffff80105689:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105690:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105694:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
   sched();
ffffffff8010569b:	e8 35 02 00 00       	call   ffffffff801058d5 <sched>
  panic("zombie exit");
ffffffff801056a0:	48 c7 c7 b2 9e 10 80 	mov    $0xffffffff80109eb2,%rdi
ffffffff801056a7:	e8 a3 b2 ff ff       	call   ffffffff8010094f <panic>

ffffffff801056ac <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffffffff801056ac:	f3 0f 1e fa          	endbr64
ffffffff801056b0:	55                   	push   %rbp
ffffffff801056b1:	48 89 e5             	mov    %rsp,%rbp
ffffffff801056b4:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffffffff801056b8:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801056bf:	e8 ef 06 00 00       	call   ffffffff80105db3 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
ffffffff801056c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff801056cb:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff801056d2:	80 
ffffffff801056d3:	e9 bb 00 00 00       	jmp    ffffffff80105793 <wait+0xe7>
      if(p->parent != proc)
ffffffff801056d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801056dc:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffffffff801056e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801056e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801056eb:	48 39 c2             	cmp    %rax,%rdx
ffffffff801056ee:	0f 85 96 00 00 00    	jne    ffffffff8010578a <wait+0xde>
        continue;
      havekids = 1;
ffffffff801056f4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffffffff801056fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801056ff:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105702:	83 f8 05             	cmp    $0x5,%eax
ffffffff80105705:	0f 85 80 00 00 00    	jne    ffffffff8010578b <wait+0xdf>
        // Found one.
        pid = p->pid;
ffffffff8010570b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010570f:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff80105712:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffffffff80105715:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105719:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff8010571d:	48 89 c7             	mov    %rax,%rdi
ffffffff80105720:	e8 fa db ff ff       	call   ffffffff8010331f <kfree>
        p->kstack = 0;
ffffffff80105725:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105729:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105730:	00 
        freevm(p->pgdir);
ffffffff80105731:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105735:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105739:	48 89 c7             	mov    %rax,%rdi
ffffffff8010573c:	e8 07 38 00 00       	call   ffffffff80108f48 <freevm>
        p->state = UNUSED;
ffffffff80105741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105745:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        p->pid = 0;
ffffffff8010574c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105750:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffffffff80105757:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010575b:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffffffff80105762:	00 
        p->name[0] = 0;
ffffffff80105763:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105767:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffffffff8010576e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105772:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        release(&ptable.lock);
ffffffff80105779:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105780:	e8 09 07 00 00       	call   ffffffff80105e8e <release>
        return pid;
ffffffff80105785:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80105788:	eb 61                	jmp    ffffffff801057eb <wait+0x13f>
        continue;
ffffffff8010578a:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff8010578b:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105792:	00 
ffffffff80105793:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff8010579a:	80 
ffffffff8010579b:	0f 82 37 ff ff ff    	jb     ffffffff801056d8 <wait+0x2c>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffffffff801057a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff801057a5:	74 12                	je     ffffffff801057b9 <wait+0x10d>
ffffffff801057a7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801057ae:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801057b2:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff801057b5:	85 c0                	test   %eax,%eax
ffffffff801057b7:	74 13                	je     ffffffff801057cc <wait+0x120>
      release(&ptable.lock);
ffffffff801057b9:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801057c0:	e8 c9 06 00 00       	call   ffffffff80105e8e <release>
      return -1;
ffffffff801057c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801057ca:	eb 1f                	jmp    ffffffff801057eb <wait+0x13f>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffffffff801057cc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801057d3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801057d7:	48 c7 c6 00 04 11 80 	mov    $0xffffffff80110400,%rsi
ffffffff801057de:	48 89 c7             	mov    %rax,%rdi
ffffffff801057e1:	e8 31 02 00 00       	call   ffffffff80105a17 <sleep>
    havekids = 0;
ffffffff801057e6:	e9 d9 fe ff ff       	jmp    ffffffff801056c4 <wait+0x18>
  }
}
ffffffff801057eb:	c9                   	leave
ffffffff801057ec:	c3                   	ret

ffffffff801057ed <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffffffff801057ed:	f3 0f 1e fa          	endbr64
ffffffff801057f1:	55                   	push   %rbp
ffffffff801057f2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801057f5:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p = 0;
ffffffff801057f9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffffffff80105800:	00 

  for(;;){
    // Enable interrupts on this processor.
    sti();
ffffffff80105801:	e8 39 f7 ff ff       	call   ffffffff80104f3f <sti>

    // no runnable processes? (did we hit the end of the table last time?)
    // if so, wait for irq before trying again.
    if (p == &ptable.proc[NPROC])
ffffffff80105806:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff8010580d:	80 
ffffffff8010580e:	75 05                	jne    ffffffff80105815 <scheduler+0x28>
      hlt();
ffffffff80105810:	e8 32 f7 ff ff       	call   ffffffff80104f47 <hlt>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffffffff80105815:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010581c:	e8 92 05 00 00       	call   ffffffff80105db3 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105821:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80105828:	80 
ffffffff80105829:	e9 88 00 00 00       	jmp    ffffffff801058b6 <scheduler+0xc9>
      if(p->state != RUNNABLE)
ffffffff8010582e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105832:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105835:	83 f8 03             	cmp    $0x3,%eax
ffffffff80105838:	75 73                	jne    ffffffff801058ad <scheduler+0xc0>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffffffff8010583a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105841:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80105845:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffffffff80105849:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010584d:	48 89 c7             	mov    %rax,%rdi
ffffffff80105850:	e8 1f 42 00 00       	call   ffffffff80109a74 <switchuvm>
      p->state = RUNNING;
ffffffff80105855:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105859:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      p->inuse = 1;
ffffffff80105860:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105864:	c7 80 e0 00 00 00 01 	movl   $0x1,0xe0(%rax)
ffffffff8010586b:	00 00 00 

      swtch(&cpu->scheduler, proc->context);
ffffffff8010586e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105875:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105879:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff8010587d:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffffffff80105884:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff80105888:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010588c:	48 89 c6             	mov    %rax,%rsi
ffffffff8010588f:	48 89 d7             	mov    %rdx,%rdi
ffffffff80105892:	e8 f8 0b 00 00       	call   ffffffff8010648f <swtch>
    
      switchkvm();
ffffffff80105897:	e8 b6 41 00 00       	call   ffffffff80109a52 <switchkvm>
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffffffff8010589c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801058a3:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffffffff801058aa:	00 
ffffffff801058ab:	eb 01                	jmp    ffffffff801058ae <scheduler+0xc1>
        continue;
ffffffff801058ad:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff801058ae:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff801058b5:	00 
ffffffff801058b6:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff801058bd:	80 
ffffffff801058be:	0f 82 6a ff ff ff    	jb     ffffffff8010582e <scheduler+0x41>
    }
    release(&ptable.lock);
ffffffff801058c4:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801058cb:	e8 be 05 00 00       	call   ffffffff80105e8e <release>
    sti();
ffffffff801058d0:	e9 2c ff ff ff       	jmp    ffffffff80105801 <scheduler+0x14>

ffffffff801058d5 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
ffffffff801058d5:	f3 0f 1e fa          	endbr64
ffffffff801058d9:	55                   	push   %rbp
ffffffff801058da:	48 89 e5             	mov    %rsp,%rbp
ffffffff801058dd:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;

  if(!holding(&ptable.lock))
ffffffff801058e1:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801058e8:	e8 cd 06 00 00       	call   ffffffff80105fba <holding>
ffffffff801058ed:	85 c0                	test   %eax,%eax
ffffffff801058ef:	75 0c                	jne    ffffffff801058fd <sched+0x28>
    panic("sched ptable.lock");
ffffffff801058f1:	48 c7 c7 be 9e 10 80 	mov    $0xffffffff80109ebe,%rdi
ffffffff801058f8:	e8 52 b0 ff ff       	call   ffffffff8010094f <panic>
  if(cpu->ncli != 1)
ffffffff801058fd:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105904:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105908:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff8010590e:	83 f8 01             	cmp    $0x1,%eax
ffffffff80105911:	74 0c                	je     ffffffff8010591f <sched+0x4a>
    panic("sched locks");
ffffffff80105913:	48 c7 c7 d0 9e 10 80 	mov    $0xffffffff80109ed0,%rdi
ffffffff8010591a:	e8 30 b0 ff ff       	call   ffffffff8010094f <panic>
  if(proc->state == RUNNING)
ffffffff8010591f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105926:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010592a:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010592d:	83 f8 04             	cmp    $0x4,%eax
ffffffff80105930:	75 0c                	jne    ffffffff8010593e <sched+0x69>
    panic("sched running");
ffffffff80105932:	48 c7 c7 dc 9e 10 80 	mov    $0xffffffff80109edc,%rdi
ffffffff80105939:	e8 11 b0 ff ff       	call   ffffffff8010094f <panic>
  if(readeflags()&FL_IF)
ffffffff8010593e:	e8 e8 f5 ff ff       	call   ffffffff80104f2b <readeflags>
ffffffff80105943:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80105948:	48 85 c0             	test   %rax,%rax
ffffffff8010594b:	74 0c                	je     ffffffff80105959 <sched+0x84>
    panic("sched interruptible");
ffffffff8010594d:	48 c7 c7 ea 9e 10 80 	mov    $0xffffffff80109eea,%rdi
ffffffff80105954:	e8 f6 af ff ff       	call   ffffffff8010094f <panic>
  intena = cpu->intena;
ffffffff80105959:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105960:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105964:	8b 80 e0 00 00 00    	mov    0xe0(%rax),%eax
ffffffff8010596a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffffffff8010596d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105974:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105978:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff8010597c:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffffffff80105983:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff80105987:	48 83 c2 30          	add    $0x30,%rdx
ffffffff8010598b:	48 89 c6             	mov    %rax,%rsi
ffffffff8010598e:	48 89 d7             	mov    %rdx,%rdi
ffffffff80105991:	e8 f9 0a 00 00       	call   ffffffff8010648f <swtch>
  cpu->intena = intena;
ffffffff80105996:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff8010599d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801059a1:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801059a4:	89 90 e0 00 00 00    	mov    %edx,0xe0(%rax)
}
ffffffff801059aa:	90                   	nop
ffffffff801059ab:	c9                   	leave
ffffffff801059ac:	c3                   	ret

ffffffff801059ad <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffffffff801059ad:	f3 0f 1e fa          	endbr64
ffffffff801059b1:	55                   	push   %rbp
ffffffff801059b2:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffffffff801059b5:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801059bc:	e8 f2 03 00 00       	call   ffffffff80105db3 <acquire>
  proc->state = RUNNABLE;
ffffffff801059c1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801059c8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801059cc:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffffffff801059d3:	e8 fd fe ff ff       	call   ffffffff801058d5 <sched>
  release(&ptable.lock);
ffffffff801059d8:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801059df:	e8 aa 04 00 00       	call   ffffffff80105e8e <release>
}
ffffffff801059e4:	90                   	nop
ffffffff801059e5:	5d                   	pop    %rbp
ffffffff801059e6:	c3                   	ret

ffffffff801059e7 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffffffff801059e7:	f3 0f 1e fa          	endbr64
ffffffff801059eb:	55                   	push   %rbp
ffffffff801059ec:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffffffff801059ef:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801059f6:	e8 93 04 00 00       	call   ffffffff80105e8e <release>

  if (first) {
ffffffff801059fb:	8b 05 63 5b 00 00    	mov    0x5b63(%rip),%eax        # ffffffff8010b564 <first.1>
ffffffff80105a01:	85 c0                	test   %eax,%eax
ffffffff80105a03:	74 0f                	je     ffffffff80105a14 <forkret+0x2d>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
ffffffff80105a05:	c7 05 55 5b 00 00 00 	movl   $0x0,0x5b55(%rip)        # ffffffff8010b564 <first.1>
ffffffff80105a0c:	00 00 00 
    initlog();
ffffffff80105a0f:	e8 0d df ff ff       	call   ffffffff80103921 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
ffffffff80105a14:	90                   	nop
ffffffff80105a15:	5d                   	pop    %rbp
ffffffff80105a16:	c3                   	ret

ffffffff80105a17 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffffffff80105a17:	f3 0f 1e fa          	endbr64
ffffffff80105a1b:	55                   	push   %rbp
ffffffff80105a1c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105a1f:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105a23:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105a27:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffffffff80105a2b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105a32:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105a36:	48 85 c0             	test   %rax,%rax
ffffffff80105a39:	75 0c                	jne    ffffffff80105a47 <sleep+0x30>
    panic("sleep");
ffffffff80105a3b:	48 c7 c7 fe 9e 10 80 	mov    $0xffffffff80109efe,%rdi
ffffffff80105a42:	e8 08 af ff ff       	call   ffffffff8010094f <panic>

  if(lk == 0)
ffffffff80105a47:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80105a4c:	75 0c                	jne    ffffffff80105a5a <sleep+0x43>
    panic("sleep without lk");
ffffffff80105a4e:	48 c7 c7 04 9f 10 80 	mov    $0xffffffff80109f04,%rdi
ffffffff80105a55:	e8 f5 ae ff ff       	call   ffffffff8010094f <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffffffff80105a5a:	48 81 7d f0 00 04 11 	cmpq   $0xffffffff80110400,-0x10(%rbp)
ffffffff80105a61:	80 
ffffffff80105a62:	74 18                	je     ffffffff80105a7c <sleep+0x65>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffffffff80105a64:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105a6b:	e8 43 03 00 00       	call   ffffffff80105db3 <acquire>
    release(lk);
ffffffff80105a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a74:	48 89 c7             	mov    %rax,%rdi
ffffffff80105a77:	e8 12 04 00 00       	call   ffffffff80105e8e <release>
  }

  // Go to sleep.
  proc->chan = chan;
ffffffff80105a7c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105a83:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105a87:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80105a8b:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffffffff80105a8f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105a96:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105a9a:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffffffff80105aa1:	e8 2f fe ff ff       	call   ffffffff801058d5 <sched>

  // Tidy up.
  proc->chan = 0;
ffffffff80105aa6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105aad:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105ab1:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffffffff80105ab8:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffffffff80105ab9:	48 81 7d f0 00 04 11 	cmpq   $0xffffffff80110400,-0x10(%rbp)
ffffffff80105ac0:	80 
ffffffff80105ac1:	74 18                	je     ffffffff80105adb <sleep+0xc4>
    release(&ptable.lock);
ffffffff80105ac3:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105aca:	e8 bf 03 00 00       	call   ffffffff80105e8e <release>
    acquire(lk);
ffffffff80105acf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105ad3:	48 89 c7             	mov    %rax,%rdi
ffffffff80105ad6:	e8 d8 02 00 00       	call   ffffffff80105db3 <acquire>
  }
}
ffffffff80105adb:	90                   	nop
ffffffff80105adc:	c9                   	leave
ffffffff80105add:	c3                   	ret

ffffffff80105ade <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffffffff80105ade:	f3 0f 1e fa          	endbr64
ffffffff80105ae2:	55                   	push   %rbp
ffffffff80105ae3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105ae6:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80105aea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80105aee:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80105af5:	80 
ffffffff80105af6:	eb 2d                	jmp    ffffffff80105b25 <wakeup1+0x47>
    if(p->state == SLEEPING && p->chan == chan)
ffffffff80105af8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105afc:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105aff:	83 f8 02             	cmp    $0x2,%eax
ffffffff80105b02:	75 19                	jne    ffffffff80105b1d <wakeup1+0x3f>
ffffffff80105b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105b08:	48 8b 40 38          	mov    0x38(%rax),%rax
ffffffff80105b0c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80105b10:	75 0b                	jne    ffffffff80105b1d <wakeup1+0x3f>
      p->state = RUNNABLE;
ffffffff80105b12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105b16:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80105b1d:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105b24:	00 
ffffffff80105b25:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105b2c:	80 
ffffffff80105b2d:	72 c9                	jb     ffffffff80105af8 <wakeup1+0x1a>
}
ffffffff80105b2f:	90                   	nop
ffffffff80105b30:	90                   	nop
ffffffff80105b31:	c9                   	leave
ffffffff80105b32:	c3                   	ret

ffffffff80105b33 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffffffff80105b33:	f3 0f 1e fa          	endbr64
ffffffff80105b37:	55                   	push   %rbp
ffffffff80105b38:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105b3b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105b3f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffffffff80105b43:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105b4a:	e8 64 02 00 00       	call   ffffffff80105db3 <acquire>
  wakeup1(chan);
ffffffff80105b4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105b53:	48 89 c7             	mov    %rax,%rdi
ffffffff80105b56:	e8 83 ff ff ff       	call   ffffffff80105ade <wakeup1>
  release(&ptable.lock);
ffffffff80105b5b:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105b62:	e8 27 03 00 00       	call   ffffffff80105e8e <release>
}
ffffffff80105b67:	90                   	nop
ffffffff80105b68:	c9                   	leave
ffffffff80105b69:	c3                   	ret

ffffffff80105b6a <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffffffff80105b6a:	f3 0f 1e fa          	endbr64
ffffffff80105b6e:	55                   	push   %rbp
ffffffff80105b6f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105b72:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105b76:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffffffff80105b79:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105b80:	e8 2e 02 00 00       	call   ffffffff80105db3 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105b85:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80105b8c:	80 
ffffffff80105b8d:	eb 49                	jmp    ffffffff80105bd8 <kill+0x6e>
    if(p->pid == pid){
ffffffff80105b8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105b93:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff80105b96:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80105b99:	75 35                	jne    ffffffff80105bd0 <kill+0x66>
      p->killed = 1;
ffffffff80105b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105b9f:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffffffff80105ba6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105baa:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105bad:	83 f8 02             	cmp    $0x2,%eax
ffffffff80105bb0:	75 0b                	jne    ffffffff80105bbd <kill+0x53>
        p->state = RUNNABLE;
ffffffff80105bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105bb6:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffffffff80105bbd:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105bc4:	e8 c5 02 00 00       	call   ffffffff80105e8e <release>
      return 0;
ffffffff80105bc9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105bce:	eb 23                	jmp    ffffffff80105bf3 <kill+0x89>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105bd0:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105bd7:	00 
ffffffff80105bd8:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105bdf:	80 
ffffffff80105be0:	72 ad                	jb     ffffffff80105b8f <kill+0x25>
    }
  }
  release(&ptable.lock);
ffffffff80105be2:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105be9:	e8 a0 02 00 00       	call   ffffffff80105e8e <release>
  return -1;
ffffffff80105bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80105bf3:	c9                   	leave
ffffffff80105bf4:	c3                   	ret

ffffffff80105bf5 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffffffff80105bf5:	f3 0f 1e fa          	endbr64
ffffffff80105bf9:	55                   	push   %rbp
ffffffff80105bfa:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105bfd:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  uintp pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105c01:	48 c7 45 f0 68 04 11 	movq   $0xffffffff80110468,-0x10(%rbp)
ffffffff80105c08:	80 
ffffffff80105c09:	e9 ff 00 00 00       	jmp    ffffffff80105d0d <procdump+0x118>
    if(p->state == UNUSED)
ffffffff80105c0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c12:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105c15:	85 c0                	test   %eax,%eax
ffffffff80105c17:	0f 84 e7 00 00 00    	je     ffffffff80105d04 <procdump+0x10f>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffffffff80105c1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c21:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105c24:	83 f8 05             	cmp    $0x5,%eax
ffffffff80105c27:	77 2d                	ja     ffffffff80105c56 <procdump+0x61>
ffffffff80105c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c2d:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105c30:	89 c0                	mov    %eax,%eax
ffffffff80105c32:	48 8b 04 c5 80 b5 10 	mov    -0x7fef4a80(,%rax,8),%rax
ffffffff80105c39:	80 
ffffffff80105c3a:	48 85 c0             	test   %rax,%rax
ffffffff80105c3d:	74 17                	je     ffffffff80105c56 <procdump+0x61>
      state = states[p->state];
ffffffff80105c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c43:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105c46:	89 c0                	mov    %eax,%eax
ffffffff80105c48:	48 8b 04 c5 80 b5 10 	mov    -0x7fef4a80(,%rax,8),%rax
ffffffff80105c4f:	80 
ffffffff80105c50:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80105c54:	eb 08                	jmp    ffffffff80105c5e <procdump+0x69>
    else
      state = "???";
ffffffff80105c56:	48 c7 45 e8 15 9f 10 	movq   $0xffffffff80109f15,-0x18(%rbp)
ffffffff80105c5d:	80 
    cprintf("%d %s %s", p->pid, state, p->name);
ffffffff80105c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c62:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff80105c69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c6d:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff80105c70:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80105c74:	89 c6                	mov    %eax,%esi
ffffffff80105c76:	48 c7 c7 19 9f 10 80 	mov    $0xffffffff80109f19,%rdi
ffffffff80105c7d:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105c82:	e8 39 a9 ff ff       	call   ffffffff801005c0 <cprintf>
    if(p->state == SLEEPING){
ffffffff80105c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c8b:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105c8e:	83 f8 02             	cmp    $0x2,%eax
ffffffff80105c91:	75 5e                	jne    ffffffff80105cf1 <procdump+0xfc>
      getstackpcs((uintp*)p->context->ebp, pc);
ffffffff80105c93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105c97:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80105c9b:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80105c9f:	48 89 c2             	mov    %rax,%rdx
ffffffff80105ca2:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffffffff80105ca6:	48 89 c6             	mov    %rax,%rsi
ffffffff80105ca9:	48 89 d7             	mov    %rdx,%rdi
ffffffff80105cac:	e8 6b 02 00 00       	call   ffffffff80105f1c <getstackpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
ffffffff80105cb1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105cb8:	eb 22                	jmp    ffffffff80105cdc <procdump+0xe7>
        cprintf(" %p", pc[i]);
ffffffff80105cba:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105cbd:	48 98                	cltq
ffffffff80105cbf:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffffffff80105cc4:	48 89 c6             	mov    %rax,%rsi
ffffffff80105cc7:	48 c7 c7 22 9f 10 80 	mov    $0xffffffff80109f22,%rdi
ffffffff80105cce:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105cd3:	e8 e8 a8 ff ff       	call   ffffffff801005c0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
ffffffff80105cd8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105cdc:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105ce0:	7f 0f                	jg     ffffffff80105cf1 <procdump+0xfc>
ffffffff80105ce2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105ce5:	48 98                	cltq
ffffffff80105ce7:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffffffff80105cec:	48 85 c0             	test   %rax,%rax
ffffffff80105cef:	75 c9                	jne    ffffffff80105cba <procdump+0xc5>
    }
    cprintf("\n");
ffffffff80105cf1:	48 c7 c7 26 9f 10 80 	mov    $0xffffffff80109f26,%rdi
ffffffff80105cf8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105cfd:	e8 be a8 ff ff       	call   ffffffff801005c0 <cprintf>
ffffffff80105d02:	eb 01                	jmp    ffffffff80105d05 <procdump+0x110>
      continue;
ffffffff80105d04:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105d05:	48 81 45 f0 f0 00 00 	addq   $0xf0,-0x10(%rbp)
ffffffff80105d0c:	00 
ffffffff80105d0d:	48 81 7d f0 68 40 11 	cmpq   $0xffffffff80114068,-0x10(%rbp)
ffffffff80105d14:	80 
ffffffff80105d15:	0f 82 f3 fe ff ff    	jb     ffffffff80105c0e <procdump+0x19>
  }

    cprintf("\n\n");
ffffffff80105d1b:	48 c7 c7 28 9f 10 80 	mov    $0xffffffff80109f28,%rdi
ffffffff80105d22:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105d27:	e8 94 a8 ff ff       	call   ffffffff801005c0 <cprintf>
}
ffffffff80105d2c:	90                   	nop
ffffffff80105d2d:	c9                   	leave
ffffffff80105d2e:	c3                   	ret

ffffffff80105d2f <readeflags>:
{
ffffffff80105d2f:	55                   	push   %rbp
ffffffff80105d30:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105d33:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff80105d37:	9c                   	pushf
ffffffff80105d38:	58                   	pop    %rax
ffffffff80105d39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff80105d3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80105d41:	c9                   	leave
ffffffff80105d42:	c3                   	ret

ffffffff80105d43 <cli>:
{
ffffffff80105d43:	55                   	push   %rbp
ffffffff80105d44:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffffffff80105d47:	fa                   	cli
}
ffffffff80105d48:	90                   	nop
ffffffff80105d49:	5d                   	pop    %rbp
ffffffff80105d4a:	c3                   	ret

ffffffff80105d4b <sti>:
{
ffffffff80105d4b:	55                   	push   %rbp
ffffffff80105d4c:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffffffff80105d4f:	fb                   	sti
}
ffffffff80105d50:	90                   	nop
ffffffff80105d51:	5d                   	pop    %rbp
ffffffff80105d52:	c3                   	ret

ffffffff80105d53 <xchg>:
{
ffffffff80105d53:	55                   	push   %rbp
ffffffff80105d54:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105d57:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105d5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105d5f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffffffff80105d63:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80105d67:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105d6b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80105d6f:	f0 87 02             	lock xchg %eax,(%rdx)
ffffffff80105d72:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffffffff80105d75:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80105d78:	c9                   	leave
ffffffff80105d79:	c3                   	ret

ffffffff80105d7a <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffffffff80105d7a:	f3 0f 1e fa          	endbr64
ffffffff80105d7e:	55                   	push   %rbp
ffffffff80105d7f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105d82:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105d86:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105d8a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffffffff80105d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105d92:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80105d96:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffffffff80105d9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105d9e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffffffff80105da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105da8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105daf:	00 
}
ffffffff80105db0:	90                   	nop
ffffffff80105db1:	c9                   	leave
ffffffff80105db2:	c3                   	ret

ffffffff80105db3 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffffffff80105db3:	f3 0f 1e fa          	endbr64
ffffffff80105db7:	55                   	push   %rbp
ffffffff80105db8:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105dbb:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105dbf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffffffff80105dc3:	e8 32 02 00 00       	call   ffffffff80105ffa <pushcli>
  if(holding(lk)) {
ffffffff80105dc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105dcc:	48 89 c7             	mov    %rax,%rdi
ffffffff80105dcf:	e8 e6 01 00 00       	call   ffffffff80105fba <holding>
ffffffff80105dd4:	85 c0                	test   %eax,%eax
ffffffff80105dd6:	74 73                	je     ffffffff80105e4b <acquire+0x98>
    int i;
    cprintf("lock '%s':\n", lk->name);
ffffffff80105dd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105ddc:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105de0:	48 89 c6             	mov    %rax,%rsi
ffffffff80105de3:	48 c7 c7 55 9f 10 80 	mov    $0xffffffff80109f55,%rdi
ffffffff80105dea:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105def:	e8 cc a7 ff ff       	call   ffffffff801005c0 <cprintf>
    for (i = 0; i < 10; i++)
ffffffff80105df4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105dfb:	eb 2b                	jmp    ffffffff80105e28 <acquire+0x75>
      cprintf(" %p", lk->pcs[i]);
ffffffff80105dfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105e01:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80105e04:	48 63 d2             	movslq %edx,%rdx
ffffffff80105e07:	48 83 c2 02          	add    $0x2,%rdx
ffffffff80105e0b:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff80105e10:	48 89 c6             	mov    %rax,%rsi
ffffffff80105e13:	48 c7 c7 61 9f 10 80 	mov    $0xffffffff80109f61,%rdi
ffffffff80105e1a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105e1f:	e8 9c a7 ff ff       	call   ffffffff801005c0 <cprintf>
    for (i = 0; i < 10; i++)
ffffffff80105e24:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105e28:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105e2c:	7e cf                	jle    ffffffff80105dfd <acquire+0x4a>
    cprintf("\n");
ffffffff80105e2e:	48 c7 c7 65 9f 10 80 	mov    $0xffffffff80109f65,%rdi
ffffffff80105e35:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105e3a:	e8 81 a7 ff ff       	call   ffffffff801005c0 <cprintf>
    panic("acquire");
ffffffff80105e3f:	48 c7 c7 67 9f 10 80 	mov    $0xffffffff80109f67,%rdi
ffffffff80105e46:	e8 04 ab ff ff       	call   ffffffff8010094f <panic>
  }

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
ffffffff80105e4b:	90                   	nop
ffffffff80105e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105e50:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80105e55:	48 89 c7             	mov    %rax,%rdi
ffffffff80105e58:	e8 f6 fe ff ff       	call   ffffffff80105d53 <xchg>
ffffffff80105e5d:	85 c0                	test   %eax,%eax
ffffffff80105e5f:	75 eb                	jne    ffffffff80105e4c <acquire+0x99>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffffffff80105e61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105e65:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffffffff80105e6c:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff80105e70:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffffffff80105e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105e78:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffffffff80105e7c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80105e80:	48 89 d6             	mov    %rdx,%rsi
ffffffff80105e83:	48 89 c7             	mov    %rax,%rdi
ffffffff80105e86:	e8 60 00 00 00       	call   ffffffff80105eeb <getcallerpcs>
}
ffffffff80105e8b:	90                   	nop
ffffffff80105e8c:	c9                   	leave
ffffffff80105e8d:	c3                   	ret

ffffffff80105e8e <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffffffff80105e8e:	f3 0f 1e fa          	endbr64
ffffffff80105e92:	55                   	push   %rbp
ffffffff80105e93:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105e96:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105e9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffffffff80105e9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105ea2:	48 89 c7             	mov    %rax,%rdi
ffffffff80105ea5:	e8 10 01 00 00       	call   ffffffff80105fba <holding>
ffffffff80105eaa:	85 c0                	test   %eax,%eax
ffffffff80105eac:	75 0c                	jne    ffffffff80105eba <release+0x2c>
    panic("release");
ffffffff80105eae:	48 c7 c7 6f 9f 10 80 	mov    $0xffffffff80109f6f,%rdi
ffffffff80105eb5:	e8 95 aa ff ff       	call   ffffffff8010094f <panic>

  lk->pcs[0] = 0;
ffffffff80105eba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105ebe:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffffffff80105ec5:	00 
  lk->cpu = 0;
ffffffff80105ec6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105eca:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105ed1:	00 
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
ffffffff80105ed2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105ed6:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80105edb:	48 89 c7             	mov    %rax,%rdi
ffffffff80105ede:	e8 70 fe ff ff       	call   ffffffff80105d53 <xchg>

  popcli();
ffffffff80105ee3:	e8 66 01 00 00       	call   ffffffff8010604e <popcli>
}
ffffffff80105ee8:	90                   	nop
ffffffff80105ee9:	c9                   	leave
ffffffff80105eea:	c3                   	ret

ffffffff80105eeb <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uintp pcs[])
{
ffffffff80105eeb:	f3 0f 1e fa          	endbr64
ffffffff80105eef:	55                   	push   %rbp
ffffffff80105ef0:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105ef3:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105ef7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105efb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uintp *ebp;
#if X64
  asm volatile("mov %%rbp, %0" : "=r" (ebp));  
ffffffff80105eff:	48 89 e8             	mov    %rbp,%rax
ffffffff80105f02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
#else
  ebp = (uintp*)v - 2;
#endif
  getstackpcs(ebp, pcs);
ffffffff80105f06:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80105f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105f0e:	48 89 d6             	mov    %rdx,%rsi
ffffffff80105f11:	48 89 c7             	mov    %rax,%rdi
ffffffff80105f14:	e8 03 00 00 00       	call   ffffffff80105f1c <getstackpcs>
}
ffffffff80105f19:	90                   	nop
ffffffff80105f1a:	c9                   	leave
ffffffff80105f1b:	c3                   	ret

ffffffff80105f1c <getstackpcs>:

void
getstackpcs(uintp *ebp, uintp pcs[])
{
ffffffff80105f1c:	f3 0f 1e fa          	endbr64
ffffffff80105f20:	55                   	push   %rbp
ffffffff80105f21:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105f24:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105f28:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105f2c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  
  for(i = 0; i < 10; i++){
ffffffff80105f30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105f37:	eb 50                	jmp    ffffffff80105f89 <getstackpcs+0x6d>
    if(ebp == 0 || ebp < (uintp*)KERNBASE || ebp == (uintp*)0xffffffff)
ffffffff80105f39:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80105f3e:	74 70                	je     ffffffff80105fb0 <getstackpcs+0x94>
ffffffff80105f40:	48 b8 ff ff ff 7f ff 	movabs $0xffffffff7fffffff,%rax
ffffffff80105f47:	ff ff ff 
ffffffff80105f4a:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff80105f4e:	73 60                	jae    ffffffff80105fb0 <getstackpcs+0x94>
ffffffff80105f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105f55:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80105f59:	74 55                	je     ffffffff80105fb0 <getstackpcs+0x94>
      break;
    pcs[i] = ebp[1];     // saved %eip
ffffffff80105f5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105f5e:	48 98                	cltq
ffffffff80105f60:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80105f67:	00 
ffffffff80105f68:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105f6c:	48 01 c2             	add    %rax,%rdx
ffffffff80105f6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105f73:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105f77:	48 89 02             	mov    %rax,(%rdx)
    ebp = (uintp*)ebp[0]; // saved %ebp
ffffffff80105f7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105f7e:	48 8b 00             	mov    (%rax),%rax
ffffffff80105f81:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffffffff80105f85:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105f89:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105f8d:	7e aa                	jle    ffffffff80105f39 <getstackpcs+0x1d>
  }
  for(; i < 10; i++)
ffffffff80105f8f:	eb 1f                	jmp    ffffffff80105fb0 <getstackpcs+0x94>
    pcs[i] = 0;
ffffffff80105f91:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105f94:	48 98                	cltq
ffffffff80105f96:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80105f9d:	00 
ffffffff80105f9e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105fa2:	48 01 d0             	add    %rdx,%rax
ffffffff80105fa5:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffffffff80105fac:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105fb0:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105fb4:	7e db                	jle    ffffffff80105f91 <getstackpcs+0x75>
}
ffffffff80105fb6:	90                   	nop
ffffffff80105fb7:	90                   	nop
ffffffff80105fb8:	c9                   	leave
ffffffff80105fb9:	c3                   	ret

ffffffff80105fba <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffffffff80105fba:	f3 0f 1e fa          	endbr64
ffffffff80105fbe:	55                   	push   %rbp
ffffffff80105fbf:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105fc2:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80105fc6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffffffff80105fca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105fce:	8b 00                	mov    (%rax),%eax
ffffffff80105fd0:	85 c0                	test   %eax,%eax
ffffffff80105fd2:	74 1f                	je     ffffffff80105ff3 <holding+0x39>
ffffffff80105fd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105fd8:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffffffff80105fdc:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105fe3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105fe7:	48 39 c2             	cmp    %rax,%rdx
ffffffff80105fea:	75 07                	jne    ffffffff80105ff3 <holding+0x39>
ffffffff80105fec:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff80105ff1:	eb 05                	jmp    ffffffff80105ff8 <holding+0x3e>
ffffffff80105ff3:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80105ff8:	c9                   	leave
ffffffff80105ff9:	c3                   	ret

ffffffff80105ffa <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
ffffffff80105ffa:	f3 0f 1e fa          	endbr64
ffffffff80105ffe:	55                   	push   %rbp
ffffffff80105fff:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106002:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;
  
  eflags = readeflags();
ffffffff80106006:	e8 24 fd ff ff       	call   ffffffff80105d2f <readeflags>
ffffffff8010600b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffffffff8010600e:	e8 30 fd ff ff       	call   ffffffff80105d43 <cli>
  if(cpu->ncli++ == 0)
ffffffff80106013:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff8010601a:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff8010601e:	8b 82 dc 00 00 00    	mov    0xdc(%rdx),%eax
ffffffff80106024:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80106027:	89 8a dc 00 00 00    	mov    %ecx,0xdc(%rdx)
ffffffff8010602d:	85 c0                	test   %eax,%eax
ffffffff8010602f:	75 1a                	jne    ffffffff8010604b <pushcli+0x51>
    cpu->intena = eflags & FL_IF;
ffffffff80106031:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80106038:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010603c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010603f:	81 e2 00 02 00 00    	and    $0x200,%edx
ffffffff80106045:	89 90 e0 00 00 00    	mov    %edx,0xe0(%rax)
}
ffffffff8010604b:	90                   	nop
ffffffff8010604c:	c9                   	leave
ffffffff8010604d:	c3                   	ret

ffffffff8010604e <popcli>:

void
popcli(void)
{
ffffffff8010604e:	f3 0f 1e fa          	endbr64
ffffffff80106052:	55                   	push   %rbp
ffffffff80106053:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffffffff80106056:	e8 d4 fc ff ff       	call   ffffffff80105d2f <readeflags>
ffffffff8010605b:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80106060:	48 85 c0             	test   %rax,%rax
ffffffff80106063:	74 0c                	je     ffffffff80106071 <popcli+0x23>
    panic("popcli - interruptible");
ffffffff80106065:	48 c7 c7 77 9f 10 80 	mov    $0xffffffff80109f77,%rdi
ffffffff8010606c:	e8 de a8 ff ff       	call   ffffffff8010094f <panic>
  if(--cpu->ncli < 0)
ffffffff80106071:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80106078:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010607c:	8b 90 dc 00 00 00    	mov    0xdc(%rax),%edx
ffffffff80106082:	83 ea 01             	sub    $0x1,%edx
ffffffff80106085:	89 90 dc 00 00 00    	mov    %edx,0xdc(%rax)
ffffffff8010608b:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff80106091:	85 c0                	test   %eax,%eax
ffffffff80106093:	79 0c                	jns    ffffffff801060a1 <popcli+0x53>
    panic("popcli");
ffffffff80106095:	48 c7 c7 8e 9f 10 80 	mov    $0xffffffff80109f8e,%rdi
ffffffff8010609c:	e8 ae a8 ff ff       	call   ffffffff8010094f <panic>
  if(cpu->ncli == 0 && cpu->intena)
ffffffff801060a1:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff801060a8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801060ac:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff801060b2:	85 c0                	test   %eax,%eax
ffffffff801060b4:	75 1a                	jne    ffffffff801060d0 <popcli+0x82>
ffffffff801060b6:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff801060bd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801060c1:	8b 80 e0 00 00 00    	mov    0xe0(%rax),%eax
ffffffff801060c7:	85 c0                	test   %eax,%eax
ffffffff801060c9:	74 05                	je     ffffffff801060d0 <popcli+0x82>
    sti();
ffffffff801060cb:	e8 7b fc ff ff       	call   ffffffff80105d4b <sti>
}
ffffffff801060d0:	90                   	nop
ffffffff801060d1:	5d                   	pop    %rbp
ffffffff801060d2:	c3                   	ret

ffffffff801060d3 <stosb>:
{
ffffffff801060d3:	55                   	push   %rbp
ffffffff801060d4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801060d7:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801060db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801060df:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff801060e2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
ffffffff801060e5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff801060e9:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff801060ec:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801060ef:	48 89 ce             	mov    %rcx,%rsi
ffffffff801060f2:	48 89 f7             	mov    %rsi,%rdi
ffffffff801060f5:	89 d1                	mov    %edx,%ecx
ffffffff801060f7:	fc                   	cld
ffffffff801060f8:	f3 aa                	rep stos %al,%es:(%rdi)
ffffffff801060fa:	89 ca                	mov    %ecx,%edx
ffffffff801060fc:	48 89 fe             	mov    %rdi,%rsi
ffffffff801060ff:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffffffff80106103:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffffffff80106106:	90                   	nop
ffffffff80106107:	c9                   	leave
ffffffff80106108:	c3                   	ret

ffffffff80106109 <stosl>:
{
ffffffff80106109:	55                   	push   %rbp
ffffffff8010610a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010610d:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80106111:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80106115:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80106118:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosl" :
ffffffff8010611b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff8010611f:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80106122:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80106125:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106128:	48 89 f7             	mov    %rsi,%rdi
ffffffff8010612b:	89 d1                	mov    %edx,%ecx
ffffffff8010612d:	fc                   	cld
ffffffff8010612e:	f3 ab                	rep stos %eax,%es:(%rdi)
ffffffff80106130:	89 ca                	mov    %ecx,%edx
ffffffff80106132:	48 89 fe             	mov    %rdi,%rsi
ffffffff80106135:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffffffff80106139:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffffffff8010613c:	90                   	nop
ffffffff8010613d:	c9                   	leave
ffffffff8010613e:	c3                   	ret

ffffffff8010613f <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
ffffffff8010613f:	f3 0f 1e fa          	endbr64
ffffffff80106143:	55                   	push   %rbp
ffffffff80106144:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106147:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010614b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010614f:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80106152:	89 55 f0             	mov    %edx,-0x10(%rbp)
  if ((uintp)dst%4 == 0 && n%4 == 0){
ffffffff80106155:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106159:	83 e0 03             	and    $0x3,%eax
ffffffff8010615c:	48 85 c0             	test   %rax,%rax
ffffffff8010615f:	75 48                	jne    ffffffff801061a9 <memset+0x6a>
ffffffff80106161:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80106164:	83 e0 03             	and    $0x3,%eax
ffffffff80106167:	85 c0                	test   %eax,%eax
ffffffff80106169:	75 3e                	jne    ffffffff801061a9 <memset+0x6a>
    c &= 0xFF;
ffffffff8010616b:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffffffff80106172:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80106175:	c1 e8 02             	shr    $0x2,%eax
ffffffff80106178:	89 c6                	mov    %eax,%esi
ffffffff8010617a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010617d:	c1 e0 18             	shl    $0x18,%eax
ffffffff80106180:	89 c2                	mov    %eax,%edx
ffffffff80106182:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80106185:	c1 e0 10             	shl    $0x10,%eax
ffffffff80106188:	09 c2                	or     %eax,%edx
ffffffff8010618a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010618d:	c1 e0 08             	shl    $0x8,%eax
ffffffff80106190:	09 d0                	or     %edx,%eax
ffffffff80106192:	0b 45 f4             	or     -0xc(%rbp),%eax
ffffffff80106195:	89 c1                	mov    %eax,%ecx
ffffffff80106197:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010619b:	89 f2                	mov    %esi,%edx
ffffffff8010619d:	89 ce                	mov    %ecx,%esi
ffffffff8010619f:	48 89 c7             	mov    %rax,%rdi
ffffffff801061a2:	e8 62 ff ff ff       	call   ffffffff80106109 <stosl>
ffffffff801061a7:	eb 14                	jmp    ffffffff801061bd <memset+0x7e>
  } else
    stosb(dst, c, n);
ffffffff801061a9:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff801061ac:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff801061af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801061b3:	89 ce                	mov    %ecx,%esi
ffffffff801061b5:	48 89 c7             	mov    %rax,%rdi
ffffffff801061b8:	e8 16 ff ff ff       	call   ffffffff801060d3 <stosb>
  return dst;
ffffffff801061bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801061c1:	c9                   	leave
ffffffff801061c2:	c3                   	ret

ffffffff801061c3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
ffffffff801061c3:	f3 0f 1e fa          	endbr64
ffffffff801061c7:	55                   	push   %rbp
ffffffff801061c8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801061cb:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff801061cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801061d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff801061d7:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const uchar *s1, *s2;
  
  s1 = v1;
ffffffff801061da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801061de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffffffff801061e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801061e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffffffff801061ea:	eb 34                	jmp    ffffffff80106220 <memcmp+0x5d>
    if(*s1 != *s2)
ffffffff801061ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801061f0:	0f b6 10             	movzbl (%rax),%edx
ffffffff801061f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801061f7:	0f b6 00             	movzbl (%rax),%eax
ffffffff801061fa:	38 c2                	cmp    %al,%dl
ffffffff801061fc:	74 18                	je     ffffffff80106216 <memcmp+0x53>
      return *s1 - *s2;
ffffffff801061fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106202:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106205:	0f b6 d0             	movzbl %al,%edx
ffffffff80106208:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010620c:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010620f:	0f b6 c0             	movzbl %al,%eax
ffffffff80106212:	29 c2                	sub    %eax,%edx
ffffffff80106214:	eb 1c                	jmp    ffffffff80106232 <memcmp+0x6f>
    s1++, s2++;
ffffffff80106216:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff8010621b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffffffff80106220:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106223:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff80106226:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff80106229:	85 c0                	test   %eax,%eax
ffffffff8010622b:	75 bf                	jne    ffffffff801061ec <memcmp+0x29>
  }

  return 0;
ffffffff8010622d:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffffffff80106232:	89 d0                	mov    %edx,%eax
ffffffff80106234:	c9                   	leave
ffffffff80106235:	c3                   	ret

ffffffff80106236 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
ffffffff80106236:	f3 0f 1e fa          	endbr64
ffffffff8010623a:	55                   	push   %rbp
ffffffff8010623b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010623e:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff80106242:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80106246:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010624a:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const char *s;
  char *d;

  s = src;
ffffffff8010624d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106251:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffffffff80106255:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106259:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffffffff8010625d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106261:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff80106265:	73 63                	jae    ffffffff801062ca <memmove+0x94>
ffffffff80106267:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff8010626a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010626e:	48 01 d0             	add    %rdx,%rax
ffffffff80106271:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffffffff80106275:	73 53                	jae    ffffffff801062ca <memmove+0x94>
    s += n;
ffffffff80106277:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010627a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffffffff8010627e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106281:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffffffff80106285:	eb 17                	jmp    ffffffff8010629e <memmove+0x68>
      *--d = *--s;
ffffffff80106287:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffffffff8010628c:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffffffff80106291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106295:	0f b6 10             	movzbl (%rax),%edx
ffffffff80106298:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010629c:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffffffff8010629e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801062a1:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801062a4:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801062a7:	85 c0                	test   %eax,%eax
ffffffff801062a9:	75 dc                	jne    ffffffff80106287 <memmove+0x51>
  if(s < d && s + n > d){
ffffffff801062ab:	eb 2a                	jmp    ffffffff801062d7 <memmove+0xa1>
  } else
    while(n-- > 0)
      *d++ = *s++;
ffffffff801062ad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801062b1:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff801062b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801062b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801062bd:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff801062c1:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffffffff801062c5:	0f b6 12             	movzbl (%rdx),%edx
ffffffff801062c8:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffffffff801062ca:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801062cd:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801062d0:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801062d3:	85 c0                	test   %eax,%eax
ffffffff801062d5:	75 d6                	jne    ffffffff801062ad <memmove+0x77>

  return dst;
ffffffff801062d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffffffff801062db:	c9                   	leave
ffffffff801062dc:	c3                   	ret

ffffffff801062dd <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
ffffffff801062dd:	f3 0f 1e fa          	endbr64
ffffffff801062e1:	55                   	push   %rbp
ffffffff801062e2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801062e5:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff801062e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801062ed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff801062f1:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffffffff801062f4:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801062f7:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff801062fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801062ff:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106302:	48 89 c7             	mov    %rax,%rdi
ffffffff80106305:	e8 2c ff ff ff       	call   ffffffff80106236 <memmove>
}
ffffffff8010630a:	c9                   	leave
ffffffff8010630b:	c3                   	ret

ffffffff8010630c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
ffffffff8010630c:	f3 0f 1e fa          	endbr64
ffffffff80106310:	55                   	push   %rbp
ffffffff80106311:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106314:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80106318:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010631c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80106320:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffffffff80106323:	eb 0e                	jmp    ffffffff80106333 <strncmp+0x27>
    n--, p++, q++;
ffffffff80106325:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffffffff80106329:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff8010632e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffffffff80106333:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80106337:	74 1d                	je     ffffffff80106356 <strncmp+0x4a>
ffffffff80106339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010633d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106340:	84 c0                	test   %al,%al
ffffffff80106342:	74 12                	je     ffffffff80106356 <strncmp+0x4a>
ffffffff80106344:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106348:	0f b6 10             	movzbl (%rax),%edx
ffffffff8010634b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010634f:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106352:	38 c2                	cmp    %al,%dl
ffffffff80106354:	74 cf                	je     ffffffff80106325 <strncmp+0x19>
  if(n == 0)
ffffffff80106356:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff8010635a:	75 07                	jne    ffffffff80106363 <strncmp+0x57>
    return 0;
ffffffff8010635c:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80106361:	eb 16                	jmp    ffffffff80106379 <strncmp+0x6d>
  return (uchar)*p - (uchar)*q;
ffffffff80106363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106367:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010636a:	0f b6 d0             	movzbl %al,%edx
ffffffff8010636d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106371:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106374:	0f b6 c0             	movzbl %al,%eax
ffffffff80106377:	29 c2                	sub    %eax,%edx
}
ffffffff80106379:	89 d0                	mov    %edx,%eax
ffffffff8010637b:	c9                   	leave
ffffffff8010637c:	c3                   	ret

ffffffff8010637d <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffffffff8010637d:	f3 0f 1e fa          	endbr64
ffffffff80106381:	55                   	push   %rbp
ffffffff80106382:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106385:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff80106389:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff8010638d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80106391:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os;
  
  os = s;
ffffffff80106394:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106398:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffffffff8010639c:	90                   	nop
ffffffff8010639d:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801063a0:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801063a3:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801063a6:	85 c0                	test   %eax,%eax
ffffffff801063a8:	7e 35                	jle    ffffffff801063df <strncpy+0x62>
ffffffff801063aa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801063ae:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff801063b2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff801063b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801063ba:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff801063be:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffffffff801063c2:	0f b6 12             	movzbl (%rdx),%edx
ffffffff801063c5:	88 10                	mov    %dl,(%rax)
ffffffff801063c7:	0f b6 00             	movzbl (%rax),%eax
ffffffff801063ca:	84 c0                	test   %al,%al
ffffffff801063cc:	75 cf                	jne    ffffffff8010639d <strncpy+0x20>
    ;
  while(n-- > 0)
ffffffff801063ce:	eb 0f                	jmp    ffffffff801063df <strncpy+0x62>
    *s++ = 0;
ffffffff801063d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801063d4:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffffffff801063d8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffffffff801063dc:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffffffff801063df:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801063e2:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801063e5:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801063e8:	85 c0                	test   %eax,%eax
ffffffff801063ea:	7f e4                	jg     ffffffff801063d0 <strncpy+0x53>
  return os;
ffffffff801063ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801063f0:	c9                   	leave
ffffffff801063f1:	c3                   	ret

ffffffff801063f2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffffffff801063f2:	f3 0f 1e fa          	endbr64
ffffffff801063f6:	55                   	push   %rbp
ffffffff801063f7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801063fa:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff801063fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80106402:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80106406:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os;
  
  os = s;
ffffffff80106409:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010640d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffffffff80106411:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80106415:	7f 06                	jg     ffffffff8010641d <safestrcpy+0x2b>
    return os;
ffffffff80106417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010641b:	eb 3a                	jmp    ffffffff80106457 <safestrcpy+0x65>
  while(--n > 0 && (*s++ = *t++) != 0)
ffffffff8010641d:	90                   	nop
ffffffff8010641e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffffffff80106422:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80106426:	7e 24                	jle    ffffffff8010644c <safestrcpy+0x5a>
ffffffff80106428:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff8010642c:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff80106430:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff80106434:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106438:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff8010643c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffffffff80106440:	0f b6 12             	movzbl (%rdx),%edx
ffffffff80106443:	88 10                	mov    %dl,(%rax)
ffffffff80106445:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106448:	84 c0                	test   %al,%al
ffffffff8010644a:	75 d2                	jne    ffffffff8010641e <safestrcpy+0x2c>
    ;
  *s = 0;
ffffffff8010644c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106450:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffffffff80106453:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80106457:	c9                   	leave
ffffffff80106458:	c3                   	ret

ffffffff80106459 <strlen>:

int
strlen(const char *s)
{
ffffffff80106459:	f3 0f 1e fa          	endbr64
ffffffff8010645d:	55                   	push   %rbp
ffffffff8010645e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106461:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80106465:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffffffff80106469:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80106470:	eb 04                	jmp    ffffffff80106476 <strlen+0x1d>
ffffffff80106472:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80106476:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106479:	48 63 d0             	movslq %eax,%rdx
ffffffff8010647c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106480:	48 01 d0             	add    %rdx,%rax
ffffffff80106483:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106486:	84 c0                	test   %al,%al
ffffffff80106488:	75 e8                	jne    ffffffff80106472 <strlen+0x19>
    ;
  return n;
ffffffff8010648a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff8010648d:	c9                   	leave
ffffffff8010648e:	c3                   	ret

ffffffff8010648f <swtch>:
# and then load register context from new.

.globl swtch
swtch:
  # Save old callee-save registers
  push %rbp
ffffffff8010648f:	55                   	push   %rbp
  push %rbx
ffffffff80106490:	53                   	push   %rbx
  push %r11
ffffffff80106491:	41 53                	push   %r11
  push %r12
ffffffff80106493:	41 54                	push   %r12
  push %r13
ffffffff80106495:	41 55                	push   %r13
  push %r14
ffffffff80106497:	41 56                	push   %r14
  push %r15
ffffffff80106499:	41 57                	push   %r15

  # Switch stacks
  mov %rsp, (%rdi)
ffffffff8010649b:	48 89 27             	mov    %rsp,(%rdi)
  mov %rsi, %rsp
ffffffff8010649e:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  pop %r15
ffffffff801064a1:	41 5f                	pop    %r15
  pop %r14
ffffffff801064a3:	41 5e                	pop    %r14
  pop %r13
ffffffff801064a5:	41 5d                	pop    %r13
  pop %r12
ffffffff801064a7:	41 5c                	pop    %r12
  pop %r11
ffffffff801064a9:	41 5b                	pop    %r11
  pop %rbx
ffffffff801064ab:	5b                   	pop    %rbx
  pop %rbp
ffffffff801064ac:	5d                   	pop    %rbp

  ret #??
ffffffff801064ad:	c3                   	ret

ffffffff801064ae <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uintp addr, int *ip)
{
ffffffff801064ae:	f3 0f 1e fa          	endbr64
ffffffff801064b2:	55                   	push   %rbp
ffffffff801064b3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801064b6:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801064ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801064be:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffffffff801064c2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801064c9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801064cd:	48 8b 00             	mov    (%rax),%rax
ffffffff801064d0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff801064d4:	73 1b                	jae    ffffffff801064f1 <fetchint+0x43>
ffffffff801064d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801064da:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffffffff801064de:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801064e5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801064e9:	48 8b 00             	mov    (%rax),%rax
ffffffff801064ec:	48 39 d0             	cmp    %rdx,%rax
ffffffff801064ef:	73 07                	jae    ffffffff801064f8 <fetchint+0x4a>
    return -1;
ffffffff801064f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801064f6:	eb 11                	jmp    ffffffff80106509 <fetchint+0x5b>
  *ip = *(int*)(addr);
ffffffff801064f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801064fc:	8b 10                	mov    (%rax),%edx
ffffffff801064fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106502:	89 10                	mov    %edx,(%rax)
  return 0;
ffffffff80106504:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80106509:	c9                   	leave
ffffffff8010650a:	c3                   	ret

ffffffff8010650b <fetchuintp>:

int
fetchuintp(uintp addr, uintp *ip)
{
ffffffff8010650b:	f3 0f 1e fa          	endbr64
ffffffff8010650f:	55                   	push   %rbp
ffffffff80106510:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106513:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80106517:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010651b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr >= proc->sz || addr+sizeof(uintp) > proc->sz)
ffffffff8010651f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106526:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010652a:	48 8b 00             	mov    (%rax),%rax
ffffffff8010652d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80106531:	73 1b                	jae    ffffffff8010654e <fetchuintp+0x43>
ffffffff80106533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106537:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff8010653b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106542:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106546:	48 8b 00             	mov    (%rax),%rax
ffffffff80106549:	48 39 d0             	cmp    %rdx,%rax
ffffffff8010654c:	73 07                	jae    ffffffff80106555 <fetchuintp+0x4a>
    return -1;
ffffffff8010654e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106553:	eb 13                	jmp    ffffffff80106568 <fetchuintp+0x5d>
  *ip = *(uintp*)(addr);
ffffffff80106555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106559:	48 8b 10             	mov    (%rax),%rdx
ffffffff8010655c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106560:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff80106563:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80106568:	c9                   	leave
ffffffff80106569:	c3                   	ret

ffffffff8010656a <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uintp addr, char **pp)
{
ffffffff8010656a:	f3 0f 1e fa          	endbr64
ffffffff8010656e:	55                   	push   %rbp
ffffffff8010656f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106572:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80106576:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff8010657a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr >= proc->sz)
ffffffff8010657e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106585:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106589:	48 8b 00             	mov    (%rax),%rax
ffffffff8010658c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80106590:	72 07                	jb     ffffffff80106599 <fetchstr+0x2f>
    return -1;
ffffffff80106592:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106597:	eb 5b                	jmp    ffffffff801065f4 <fetchstr+0x8a>
  *pp = (char*)addr;
ffffffff80106599:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010659d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801065a1:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffffffff801065a4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801065ab:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801065af:	48 8b 00             	mov    (%rax),%rax
ffffffff801065b2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffffffff801065b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801065ba:	48 8b 00             	mov    (%rax),%rax
ffffffff801065bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801065c1:	eb 22                	jmp    ffffffff801065e5 <fetchstr+0x7b>
    if(*s == 0)
ffffffff801065c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801065c7:	0f b6 00             	movzbl (%rax),%eax
ffffffff801065ca:	84 c0                	test   %al,%al
ffffffff801065cc:	75 12                	jne    ffffffff801065e0 <fetchstr+0x76>
      return s - *pp;
ffffffff801065ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801065d2:	48 8b 00             	mov    (%rax),%rax
ffffffff801065d5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801065d9:	48 29 c2             	sub    %rax,%rdx
ffffffff801065dc:	89 d0                	mov    %edx,%eax
ffffffff801065de:	eb 14                	jmp    ffffffff801065f4 <fetchstr+0x8a>
  for(s = *pp; s < ep; s++)
ffffffff801065e0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff801065e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801065e9:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff801065ed:	72 d4                	jb     ffffffff801065c3 <fetchstr+0x59>
  return -1;
ffffffff801065ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801065f4:	c9                   	leave
ffffffff801065f5:	c3                   	ret

ffffffff801065f6 <fetcharg>:

#if X64
// arguments passed in registers on x64
static uintp
fetcharg(int n)
{
ffffffff801065f6:	f3 0f 1e fa          	endbr64
ffffffff801065fa:	55                   	push   %rbp
ffffffff801065fb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801065fe:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80106602:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffffffff80106605:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffffffff80106609:	0f 87 8c 00 00 00    	ja     ffffffff8010669b <fetcharg+0xa5>
ffffffff8010660f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106612:	48 8b 04 c5 98 9f 10 	mov    -0x7fef6068(,%rax,8),%rax
ffffffff80106619:	80 
ffffffff8010661a:	3e ff e0             	notrack jmp *%rax
  case 0: return proc->tf->rdi;
ffffffff8010661d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106624:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106628:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010662c:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80106630:	eb 69                	jmp    ffffffff8010669b <fetcharg+0xa5>
  case 1: return proc->tf->rsi;
ffffffff80106632:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106639:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010663d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106641:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106645:	eb 54                	jmp    ffffffff8010669b <fetcharg+0xa5>
  case 2: return proc->tf->rdx;
ffffffff80106647:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010664e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106652:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106656:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010665a:	eb 3f                	jmp    ffffffff8010669b <fetcharg+0xa5>
  case 3: return proc->tf->rcx;
ffffffff8010665c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106663:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106667:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010666b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff8010666f:	eb 2a                	jmp    ffffffff8010669b <fetcharg+0xa5>
  case 4: return proc->tf->r8;
ffffffff80106671:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106678:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010667c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106680:	48 8b 40 38          	mov    0x38(%rax),%rax
ffffffff80106684:	eb 15                	jmp    ffffffff8010669b <fetcharg+0xa5>
  case 5: return proc->tf->r9;
ffffffff80106686:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010668d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106691:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106695:	48 8b 40 40          	mov    0x40(%rax),%rax
ffffffff80106699:	eb 00                	jmp    ffffffff8010669b <fetcharg+0xa5>
  }
}
ffffffff8010669b:	c9                   	leave
ffffffff8010669c:	c3                   	ret

ffffffff8010669d <argint>:

int
argint(int n, int *ip)
{
ffffffff8010669d:	f3 0f 1e fa          	endbr64
ffffffff801066a1:	55                   	push   %rbp
ffffffff801066a2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801066a5:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801066a9:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff801066ac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffffffff801066b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801066b3:	89 c7                	mov    %eax,%edi
ffffffff801066b5:	e8 3c ff ff ff       	call   ffffffff801065f6 <fetcharg>
ffffffff801066ba:	89 c2                	mov    %eax,%edx
ffffffff801066bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801066c0:	89 10                	mov    %edx,(%rax)
  return 0;
ffffffff801066c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801066c7:	c9                   	leave
ffffffff801066c8:	c3                   	ret

ffffffff801066c9 <arguintp>:

int
arguintp(int n, uintp *ip)
{
ffffffff801066c9:	f3 0f 1e fa          	endbr64
ffffffff801066cd:	55                   	push   %rbp
ffffffff801066ce:	48 89 e5             	mov    %rsp,%rbp
ffffffff801066d1:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801066d5:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff801066d8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffffffff801066dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801066df:	89 c7                	mov    %eax,%edi
ffffffff801066e1:	e8 10 ff ff ff       	call   ffffffff801065f6 <fetcharg>
ffffffff801066e6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801066ea:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffffffff801066ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801066f2:	c9                   	leave
ffffffff801066f3:	c3                   	ret

ffffffff801066f4 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
ffffffff801066f4:	f3 0f 1e fa          	endbr64
ffffffff801066f8:	55                   	push   %rbp
ffffffff801066f9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801066fc:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80106700:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80106703:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80106707:	89 55 e8             	mov    %edx,-0x18(%rbp)
  uintp i;

  if(arguintp(n, &i) < 0)
ffffffff8010670a:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffffffff8010670e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80106711:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106714:	89 c7                	mov    %eax,%edi
ffffffff80106716:	e8 ae ff ff ff       	call   ffffffff801066c9 <arguintp>
ffffffff8010671b:	85 c0                	test   %eax,%eax
ffffffff8010671d:	79 07                	jns    ffffffff80106726 <argptr+0x32>
    return -1;
ffffffff8010671f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106724:	eb 51                	jmp    ffffffff80106777 <argptr+0x83>
  if(i >= proc->sz || i+size > proc->sz)
ffffffff80106726:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010672d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106731:	48 8b 00             	mov    (%rax),%rax
ffffffff80106734:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80106738:	48 39 c2             	cmp    %rax,%rdx
ffffffff8010673b:	73 20                	jae    ffffffff8010675d <argptr+0x69>
ffffffff8010673d:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80106740:	48 63 d0             	movslq %eax,%rdx
ffffffff80106743:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106747:	48 01 c2             	add    %rax,%rdx
ffffffff8010674a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106751:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106755:	48 8b 00             	mov    (%rax),%rax
ffffffff80106758:	48 39 d0             	cmp    %rdx,%rax
ffffffff8010675b:	73 07                	jae    ffffffff80106764 <argptr+0x70>
    return -1;
ffffffff8010675d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106762:	eb 13                	jmp    ffffffff80106777 <argptr+0x83>
  *pp = (char*)i;
ffffffff80106764:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106768:	48 89 c2             	mov    %rax,%rdx
ffffffff8010676b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010676f:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff80106772:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80106777:	c9                   	leave
ffffffff80106778:	c3                   	ret

ffffffff80106779 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffffffff80106779:	f3 0f 1e fa          	endbr64
ffffffff8010677d:	55                   	push   %rbp
ffffffff8010677e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106781:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80106785:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80106788:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uintp addr;
  if(arguintp(n, &addr) < 0)
ffffffff8010678c:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffffffff80106790:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80106793:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106796:	89 c7                	mov    %eax,%edi
ffffffff80106798:	e8 2c ff ff ff       	call   ffffffff801066c9 <arguintp>
ffffffff8010679d:	85 c0                	test   %eax,%eax
ffffffff8010679f:	79 07                	jns    ffffffff801067a8 <argstr+0x2f>
    return -1;
ffffffff801067a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801067a6:	eb 13                	jmp    ffffffff801067bb <argstr+0x42>
  return fetchstr(addr, pp);
ffffffff801067a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801067ac:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801067b0:	48 89 d6             	mov    %rdx,%rsi
ffffffff801067b3:	48 89 c7             	mov    %rax,%rdi
ffffffff801067b6:	e8 af fd ff ff       	call   ffffffff8010656a <fetchstr>
}
ffffffff801067bb:	c9                   	leave
ffffffff801067bc:	c3                   	ret

ffffffff801067bd <syscall>:
[SYS_halt]    sys_halt
};

void
syscall(void)
{
ffffffff801067bd:	f3 0f 1e fa          	endbr64
ffffffff801067c1:	55                   	push   %rbp
ffffffff801067c2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801067c5:	48 83 ec 10          	sub    $0x10,%rsp
  int num;

  num = proc->tf->eax;
ffffffff801067c9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801067d0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801067d4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801067d8:	48 8b 00             	mov    (%rax),%rax
ffffffff801067db:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffffffff801067de:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801067e2:	7e 42                	jle    ffffffff80106826 <syscall+0x69>
ffffffff801067e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801067e7:	83 f8 1d             	cmp    $0x1d,%eax
ffffffff801067ea:	77 3a                	ja     ffffffff80106826 <syscall+0x69>
ffffffff801067ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801067ef:	48 98                	cltq
ffffffff801067f1:	48 8b 04 c5 c0 b5 10 	mov    -0x7fef4a40(,%rax,8),%rax
ffffffff801067f8:	80 
ffffffff801067f9:	48 85 c0             	test   %rax,%rax
ffffffff801067fc:	74 28                	je     ffffffff80106826 <syscall+0x69>
    proc->tf->eax = syscalls[num]();
ffffffff801067fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106801:	48 98                	cltq
ffffffff80106803:	48 8b 04 c5 c0 b5 10 	mov    -0x7fef4a40(,%rax,8),%rax
ffffffff8010680a:	80 
ffffffff8010680b:	ff d0                	call   *%rax
ffffffff8010680d:	89 c2                	mov    %eax,%edx
ffffffff8010680f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106816:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010681a:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010681e:	48 63 d2             	movslq %edx,%rdx
ffffffff80106821:	48 89 10             	mov    %rdx,(%rax)
ffffffff80106824:	eb 52                	jmp    ffffffff80106878 <syscall+0xbb>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffffffff80106826:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010682d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106831:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffffffff80106838:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010683f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106843:	8b 40 1c             	mov    0x1c(%rax),%eax
    cprintf("%d %s: unknown sys call %d\n",
ffffffff80106846:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106849:	89 d1                	mov    %edx,%ecx
ffffffff8010684b:	48 89 f2             	mov    %rsi,%rdx
ffffffff8010684e:	89 c6                	mov    %eax,%esi
ffffffff80106850:	48 c7 c7 c8 9f 10 80 	mov    $0xffffffff80109fc8,%rdi
ffffffff80106857:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010685c:	e8 5f 9d ff ff       	call   ffffffff801005c0 <cprintf>
    proc->tf->eax = -1;
ffffffff80106861:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106868:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010686c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106870:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
}
ffffffff80106877:	90                   	nop
ffffffff80106878:	90                   	nop
ffffffff80106879:	c9                   	leave
ffffffff8010687a:	c3                   	ret

ffffffff8010687b <sys_settickets>:

int sys_settickets(void) {
ffffffff8010687b:	f3 0f 1e fa          	endbr64
ffffffff8010687f:	55                   	push   %rbp
ffffffff80106880:	48 89 e5             	mov    %rsp,%rbp
    return -1;
ffffffff80106883:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106888:	5d                   	pop    %rbp
ffffffff80106889:	c3                   	ret

ffffffff8010688a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffffffff8010688a:	f3 0f 1e fa          	endbr64
ffffffff8010688e:	55                   	push   %rbp
ffffffff8010688f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106892:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80106896:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80106899:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010689d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffffffff801068a1:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffffffff801068a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801068a8:	48 89 d6             	mov    %rdx,%rsi
ffffffff801068ab:	89 c7                	mov    %eax,%edi
ffffffff801068ad:	e8 eb fd ff ff       	call   ffffffff8010669d <argint>
ffffffff801068b2:	85 c0                	test   %eax,%eax
ffffffff801068b4:	79 07                	jns    ffffffff801068bd <argfd+0x33>
    return -1;
ffffffff801068b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801068bb:	eb 62                	jmp    ffffffff8010691f <argfd+0x95>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffffffff801068bd:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801068c0:	85 c0                	test   %eax,%eax
ffffffff801068c2:	78 2d                	js     ffffffff801068f1 <argfd+0x67>
ffffffff801068c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801068c7:	83 f8 0f             	cmp    $0xf,%eax
ffffffff801068ca:	7f 25                	jg     ffffffff801068f1 <argfd+0x67>
ffffffff801068cc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801068d3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801068d7:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801068da:	48 63 d2             	movslq %edx,%rdx
ffffffff801068dd:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801068e1:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801068e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801068ea:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801068ef:	75 07                	jne    ffffffff801068f8 <argfd+0x6e>
    return -1;
ffffffff801068f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801068f6:	eb 27                	jmp    ffffffff8010691f <argfd+0x95>
  if(pfd)
ffffffff801068f8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff801068fd:	74 09                	je     ffffffff80106908 <argfd+0x7e>
    *pfd = fd;
ffffffff801068ff:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106902:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106906:	89 10                	mov    %edx,(%rax)
  if(pf)
ffffffff80106908:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff8010690d:	74 0b                	je     ffffffff8010691a <argfd+0x90>
    *pf = f;
ffffffff8010690f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106913:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80106917:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff8010691a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010691f:	c9                   	leave
ffffffff80106920:	c3                   	ret

ffffffff80106921 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffffffff80106921:	f3 0f 1e fa          	endbr64
ffffffff80106925:	55                   	push   %rbp
ffffffff80106926:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106929:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010692d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffffffff80106931:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80106938:	eb 46                	jmp    ffffffff80106980 <fdalloc+0x5f>
    if(proc->ofile[fd] == 0){
ffffffff8010693a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106941:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106945:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106948:	48 63 d2             	movslq %edx,%rdx
ffffffff8010694b:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010694f:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff80106954:	48 85 c0             	test   %rax,%rax
ffffffff80106957:	75 23                	jne    ffffffff8010697c <fdalloc+0x5b>
      proc->ofile[fd] = f;
ffffffff80106959:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106960:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106964:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106967:	48 63 d2             	movslq %edx,%rdx
ffffffff8010696a:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffffffff8010696e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80106972:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffffffff80106977:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010697a:	eb 0f                	jmp    ffffffff8010698b <fdalloc+0x6a>
  for(fd = 0; fd < NOFILE; fd++){
ffffffff8010697c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80106980:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffffffff80106984:	7e b4                	jle    ffffffff8010693a <fdalloc+0x19>
    }
  }
  return -1;
ffffffff80106986:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff8010698b:	c9                   	leave
ffffffff8010698c:	c3                   	ret

ffffffff8010698d <sys_dup>:

int
sys_dup(void)
{
ffffffff8010698d:	f3 0f 1e fa          	endbr64
ffffffff80106991:	55                   	push   %rbp
ffffffff80106992:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106995:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
ffffffff80106999:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff8010699d:	48 89 c2             	mov    %rax,%rdx
ffffffff801069a0:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801069a5:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801069aa:	e8 db fe ff ff       	call   ffffffff8010688a <argfd>
ffffffff801069af:	85 c0                	test   %eax,%eax
ffffffff801069b1:	79 07                	jns    ffffffff801069ba <sys_dup+0x2d>
    return -1;
ffffffff801069b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801069b8:	eb 2b                	jmp    ffffffff801069e5 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
ffffffff801069ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801069be:	48 89 c7             	mov    %rax,%rdi
ffffffff801069c1:	e8 5b ff ff ff       	call   ffffffff80106921 <fdalloc>
ffffffff801069c6:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801069c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801069cd:	79 07                	jns    ffffffff801069d6 <sys_dup+0x49>
    return -1;
ffffffff801069cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801069d4:	eb 0f                	jmp    ffffffff801069e5 <sys_dup+0x58>
  filedup(f);
ffffffff801069d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801069da:	48 89 c7             	mov    %rax,%rdi
ffffffff801069dd:	e8 61 ab ff ff       	call   ffffffff80101543 <filedup>
  return fd;
ffffffff801069e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff801069e5:	c9                   	leave
ffffffff801069e6:	c3                   	ret

ffffffff801069e7 <sys_read>:

int
sys_read(void)
{
ffffffff801069e7:	f3 0f 1e fa          	endbr64
ffffffff801069eb:	55                   	push   %rbp
ffffffff801069ec:	48 89 e5             	mov    %rsp,%rbp
ffffffff801069ef:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffffffff801069f3:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff801069f7:	48 89 c2             	mov    %rax,%rdx
ffffffff801069fa:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801069ff:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106a04:	e8 81 fe ff ff       	call   ffffffff8010688a <argfd>
ffffffff80106a09:	85 c0                	test   %eax,%eax
ffffffff80106a0b:	78 2d                	js     ffffffff80106a3a <sys_read+0x53>
ffffffff80106a0d:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffffffff80106a11:	48 89 c6             	mov    %rax,%rsi
ffffffff80106a14:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff80106a19:	e8 7f fc ff ff       	call   ffffffff8010669d <argint>
ffffffff80106a1e:	85 c0                	test   %eax,%eax
ffffffff80106a20:	78 18                	js     ffffffff80106a3a <sys_read+0x53>
ffffffff80106a22:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106a25:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80106a29:	48 89 c6             	mov    %rax,%rsi
ffffffff80106a2c:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106a31:	e8 be fc ff ff       	call   ffffffff801066f4 <argptr>
ffffffff80106a36:	85 c0                	test   %eax,%eax
ffffffff80106a38:	79 07                	jns    ffffffff80106a41 <sys_read+0x5a>
    return -1;
ffffffff80106a3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106a3f:	eb 16                	jmp    ffffffff80106a57 <sys_read+0x70>
  return fileread(f, p, n);
ffffffff80106a41:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106a44:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80106a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a4c:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106a4f:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a52:	e8 a0 ac ff ff       	call   ffffffff801016f7 <fileread>
}
ffffffff80106a57:	c9                   	leave
ffffffff80106a58:	c3                   	ret

ffffffff80106a59 <sys_write>:

int
sys_write(void)
{
ffffffff80106a59:	f3 0f 1e fa          	endbr64
ffffffff80106a5d:	55                   	push   %rbp
ffffffff80106a5e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106a61:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffffffff80106a65:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff80106a69:	48 89 c2             	mov    %rax,%rdx
ffffffff80106a6c:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80106a71:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106a76:	e8 0f fe ff ff       	call   ffffffff8010688a <argfd>
ffffffff80106a7b:	85 c0                	test   %eax,%eax
ffffffff80106a7d:	78 2d                	js     ffffffff80106aac <sys_write+0x53>
ffffffff80106a7f:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffffffff80106a83:	48 89 c6             	mov    %rax,%rsi
ffffffff80106a86:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff80106a8b:	e8 0d fc ff ff       	call   ffffffff8010669d <argint>
ffffffff80106a90:	85 c0                	test   %eax,%eax
ffffffff80106a92:	78 18                	js     ffffffff80106aac <sys_write+0x53>
ffffffff80106a94:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106a97:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80106a9b:	48 89 c6             	mov    %rax,%rsi
ffffffff80106a9e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106aa3:	e8 4c fc ff ff       	call   ffffffff801066f4 <argptr>
ffffffff80106aa8:	85 c0                	test   %eax,%eax
ffffffff80106aaa:	79 07                	jns    ffffffff80106ab3 <sys_write+0x5a>
    return -1;
ffffffff80106aac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106ab1:	eb 16                	jmp    ffffffff80106ac9 <sys_write+0x70>
  return filewrite(f, p, n);
ffffffff80106ab3:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106ab6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80106aba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106abe:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106ac1:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ac4:	e8 fa ac ff ff       	call   ffffffff801017c3 <filewrite>
}
ffffffff80106ac9:	c9                   	leave
ffffffff80106aca:	c3                   	ret

ffffffff80106acb <sys_close>:

int
sys_close(void)
{
ffffffff80106acb:	f3 0f 1e fa          	endbr64
ffffffff80106acf:	55                   	push   %rbp
ffffffff80106ad0:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106ad3:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
ffffffff80106ad7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffffffff80106adb:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffffffff80106adf:	48 89 c6             	mov    %rax,%rsi
ffffffff80106ae2:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106ae7:	e8 9e fd ff ff       	call   ffffffff8010688a <argfd>
ffffffff80106aec:	85 c0                	test   %eax,%eax
ffffffff80106aee:	79 07                	jns    ffffffff80106af7 <sys_close+0x2c>
    return -1;
ffffffff80106af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106af5:	eb 2f                	jmp    ffffffff80106b26 <sys_close+0x5b>
  proc->ofile[fd] = 0;
ffffffff80106af7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106afe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106b02:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106b05:	48 63 d2             	movslq %edx,%rdx
ffffffff80106b08:	48 83 c2 08          	add    $0x8,%rdx
ffffffff80106b0c:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff80106b13:	00 00 
  fileclose(f);
ffffffff80106b15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106b19:	48 89 c7             	mov    %rax,%rdi
ffffffff80106b1c:	e8 78 aa ff ff       	call   ffffffff80101599 <fileclose>
  return 0;
ffffffff80106b21:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80106b26:	c9                   	leave
ffffffff80106b27:	c3                   	ret

ffffffff80106b28 <sys_fstat>:

int
sys_fstat(void)
{
ffffffff80106b28:	f3 0f 1e fa          	endbr64
ffffffff80106b2c:	55                   	push   %rbp
ffffffff80106b2d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106b30:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffffffff80106b34:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff80106b38:	48 89 c2             	mov    %rax,%rdx
ffffffff80106b3b:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80106b40:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106b45:	e8 40 fd ff ff       	call   ffffffff8010688a <argfd>
ffffffff80106b4a:	85 c0                	test   %eax,%eax
ffffffff80106b4c:	78 1a                	js     ffffffff80106b68 <sys_fstat+0x40>
ffffffff80106b4e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80106b52:	ba 14 00 00 00       	mov    $0x14,%edx
ffffffff80106b57:	48 89 c6             	mov    %rax,%rsi
ffffffff80106b5a:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106b5f:	e8 90 fb ff ff       	call   ffffffff801066f4 <argptr>
ffffffff80106b64:	85 c0                	test   %eax,%eax
ffffffff80106b66:	79 07                	jns    ffffffff80106b6f <sys_fstat+0x47>
    return -1;
ffffffff80106b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106b6d:	eb 13                	jmp    ffffffff80106b82 <sys_fstat+0x5a>
  return filestat(f, st);
ffffffff80106b6f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80106b73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106b77:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106b7a:	48 89 c7             	mov    %rax,%rdi
ffffffff80106b7d:	e8 11 ab ff ff       	call   ffffffff80101693 <filestat>
}
ffffffff80106b82:	c9                   	leave
ffffffff80106b83:	c3                   	ret

ffffffff80106b84 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffffffff80106b84:	f3 0f 1e fa          	endbr64
ffffffff80106b88:	55                   	push   %rbp
ffffffff80106b89:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106b8c:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffffffff80106b90:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff80106b94:	48 89 c6             	mov    %rax,%rsi
ffffffff80106b97:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106b9c:	e8 d8 fb ff ff       	call   ffffffff80106779 <argstr>
ffffffff80106ba1:	85 c0                	test   %eax,%eax
ffffffff80106ba3:	78 15                	js     ffffffff80106bba <sys_link+0x36>
ffffffff80106ba5:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffffffff80106ba9:	48 89 c6             	mov    %rax,%rsi
ffffffff80106bac:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106bb1:	e8 c3 fb ff ff       	call   ffffffff80106779 <argstr>
ffffffff80106bb6:	85 c0                	test   %eax,%eax
ffffffff80106bb8:	79 0a                	jns    ffffffff80106bc4 <sys_link+0x40>
    return -1;
ffffffff80106bba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106bbf:	e9 6a 01 00 00       	jmp    ffffffff80106d2e <sys_link+0x1aa>
  if((ip = namei(old)) == 0)
ffffffff80106bc4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80106bc8:	48 89 c7             	mov    %rax,%rdi
ffffffff80106bcb:	e8 4b c0 ff ff       	call   ffffffff80102c1b <namei>
ffffffff80106bd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106bd4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106bd9:	75 0a                	jne    ffffffff80106be5 <sys_link+0x61>
    return -1;
ffffffff80106bdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106be0:	e9 49 01 00 00       	jmp    ffffffff80106d2e <sys_link+0x1aa>

  begin_trans();
ffffffff80106be5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106bea:	e8 81 cf ff ff       	call   ffffffff80103b70 <begin_trans>

  ilock(ip);
ffffffff80106bef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106bf3:	48 89 c7             	mov    %rax,%rdi
ffffffff80106bf6:	e8 1d b3 ff ff       	call   ffffffff80101f18 <ilock>
  if(ip->type == T_DIR){
ffffffff80106bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106bff:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106c03:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106c07:	75 20                	jne    ffffffff80106c29 <sys_link+0xa5>
    iunlockput(ip);
ffffffff80106c09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c0d:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c10:	e8 d7 b5 ff ff       	call   ffffffff801021ec <iunlockput>
    commit_trans();
ffffffff80106c15:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106c1a:	e8 9d cf ff ff       	call   ffffffff80103bbc <commit_trans>
    return -1;
ffffffff80106c1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106c24:	e9 05 01 00 00       	jmp    ffffffff80106d2e <sys_link+0x1aa>
  }

  ip->nlink++;
ffffffff80106c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c2d:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106c31:	83 c0 01             	add    $0x1,%eax
ffffffff80106c34:	89 c2                	mov    %eax,%edx
ffffffff80106c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c3a:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106c3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c42:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c45:	e8 c4 b0 ff ff       	call   ffffffff80101d0e <iupdate>
  iunlock(ip);
ffffffff80106c4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c4e:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c51:	e8 37 b4 ff ff       	call   ffffffff8010208d <iunlock>

  if((dp = nameiparent(new, name)) == 0)
ffffffff80106c56:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106c5a:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffffffff80106c5e:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106c61:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c64:	e8 d9 bf ff ff       	call   ffffffff80102c42 <nameiparent>
ffffffff80106c69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106c6d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106c72:	74 71                	je     ffffffff80106ce5 <sys_link+0x161>
    goto bad;
  ilock(dp);
ffffffff80106c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c78:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c7b:	e8 98 b2 ff ff       	call   ffffffff80101f18 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffffffff80106c80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c84:	8b 10                	mov    (%rax),%edx
ffffffff80106c86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c8a:	8b 00                	mov    (%rax),%eax
ffffffff80106c8c:	39 c2                	cmp    %eax,%edx
ffffffff80106c8e:	75 1e                	jne    ffffffff80106cae <sys_link+0x12a>
ffffffff80106c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c94:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80106c97:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffffffff80106c9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c9f:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106ca2:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ca5:	e8 72 bc ff ff       	call   ffffffff8010291c <dirlink>
ffffffff80106caa:	85 c0                	test   %eax,%eax
ffffffff80106cac:	79 0e                	jns    ffffffff80106cbc <sys_link+0x138>
    iunlockput(dp);
ffffffff80106cae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106cb2:	48 89 c7             	mov    %rax,%rdi
ffffffff80106cb5:	e8 32 b5 ff ff       	call   ffffffff801021ec <iunlockput>
    goto bad;
ffffffff80106cba:	eb 2a                	jmp    ffffffff80106ce6 <sys_link+0x162>
  }
  iunlockput(dp);
ffffffff80106cbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106cc0:	48 89 c7             	mov    %rax,%rdi
ffffffff80106cc3:	e8 24 b5 ff ff       	call   ffffffff801021ec <iunlockput>
  iput(ip);
ffffffff80106cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ccc:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ccf:	e8 2f b4 ff ff       	call   ffffffff80102103 <iput>

  commit_trans();
ffffffff80106cd4:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106cd9:	e8 de ce ff ff       	call   ffffffff80103bbc <commit_trans>

  return 0;
ffffffff80106cde:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106ce3:	eb 49                	jmp    ffffffff80106d2e <sys_link+0x1aa>
    goto bad;
ffffffff80106ce5:	90                   	nop

bad:
  ilock(ip);
ffffffff80106ce6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106cea:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ced:	e8 26 b2 ff ff       	call   ffffffff80101f18 <ilock>
  ip->nlink--;
ffffffff80106cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106cf6:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106cfa:	83 e8 01             	sub    $0x1,%eax
ffffffff80106cfd:	89 c2                	mov    %eax,%edx
ffffffff80106cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106d03:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106d07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106d0b:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d0e:	e8 fb af ff ff       	call   ffffffff80101d0e <iupdate>
  iunlockput(ip);
ffffffff80106d13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106d17:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d1a:	e8 cd b4 ff ff       	call   ffffffff801021ec <iunlockput>
  commit_trans();
ffffffff80106d1f:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d24:	e8 93 ce ff ff       	call   ffffffff80103bbc <commit_trans>
  return -1;
ffffffff80106d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106d2e:	c9                   	leave
ffffffff80106d2f:	c3                   	ret

ffffffff80106d30 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
ffffffff80106d30:	f3 0f 1e fa          	endbr64
ffffffff80106d34:	55                   	push   %rbp
ffffffff80106d35:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106d38:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80106d3c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff80106d40:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffffffff80106d47:	eb 42                	jmp    ffffffff80106d8b <isdirempty+0x5b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80106d49:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106d4c:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff80106d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106d54:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80106d59:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d5c:	e8 7b b7 ff ff       	call   ffffffff801024dc <readi>
ffffffff80106d61:	83 f8 10             	cmp    $0x10,%eax
ffffffff80106d64:	74 0c                	je     ffffffff80106d72 <isdirempty+0x42>
      panic("isdirempty: readi");
ffffffff80106d66:	48 c7 c7 e4 9f 10 80 	mov    $0xffffffff80109fe4,%rdi
ffffffff80106d6d:	e8 dd 9b ff ff       	call   ffffffff8010094f <panic>
    if(de.inum != 0)
ffffffff80106d72:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff80106d76:	66 85 c0             	test   %ax,%ax
ffffffff80106d79:	74 07                	je     ffffffff80106d82 <isdirempty+0x52>
      return 0;
ffffffff80106d7b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d80:	eb 1c                	jmp    ffffffff80106d9e <isdirempty+0x6e>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff80106d82:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106d85:	83 c0 10             	add    $0x10,%eax
ffffffff80106d88:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80106d8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106d8f:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80106d92:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106d95:	39 c2                	cmp    %eax,%edx
ffffffff80106d97:	72 b0                	jb     ffffffff80106d49 <isdirempty+0x19>
  }
  return 1;
ffffffff80106d99:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffffffff80106d9e:	c9                   	leave
ffffffff80106d9f:	c3                   	ret

ffffffff80106da0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
ffffffff80106da0:	f3 0f 1e fa          	endbr64
ffffffff80106da4:	55                   	push   %rbp
ffffffff80106da5:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106da8:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffffffff80106dac:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffffffff80106db0:	48 89 c6             	mov    %rax,%rsi
ffffffff80106db3:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106db8:	e8 bc f9 ff ff       	call   ffffffff80106779 <argstr>
ffffffff80106dbd:	85 c0                	test   %eax,%eax
ffffffff80106dbf:	79 0a                	jns    ffffffff80106dcb <sys_unlink+0x2b>
    return -1;
ffffffff80106dc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106dc6:	e9 c5 01 00 00       	jmp    ffffffff80106f90 <sys_unlink+0x1f0>
  if((dp = nameiparent(path, name)) == 0)
ffffffff80106dcb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80106dcf:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffffffff80106dd3:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106dd6:	48 89 c7             	mov    %rax,%rdi
ffffffff80106dd9:	e8 64 be ff ff       	call   ffffffff80102c42 <nameiparent>
ffffffff80106dde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106de2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106de7:	75 0a                	jne    ffffffff80106df3 <sys_unlink+0x53>
    return -1;
ffffffff80106de9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106dee:	e9 9d 01 00 00       	jmp    ffffffff80106f90 <sys_unlink+0x1f0>

  begin_trans();
ffffffff80106df3:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106df8:	e8 73 cd ff ff       	call   ffffffff80103b70 <begin_trans>

  ilock(dp);
ffffffff80106dfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e01:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e04:	e8 0f b1 ff ff       	call   ffffffff80101f18 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffffffff80106e09:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffffffff80106e0d:	48 c7 c6 f6 9f 10 80 	mov    $0xffffffff80109ff6,%rsi
ffffffff80106e14:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e17:	e8 fd b9 ff ff       	call   ffffffff80102819 <namecmp>
ffffffff80106e1c:	85 c0                	test   %eax,%eax
ffffffff80106e1e:	0f 84 4d 01 00 00    	je     ffffffff80106f71 <sys_unlink+0x1d1>
ffffffff80106e24:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffffffff80106e28:	48 c7 c6 f8 9f 10 80 	mov    $0xffffffff80109ff8,%rsi
ffffffff80106e2f:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e32:	e8 e2 b9 ff ff       	call   ffffffff80102819 <namecmp>
ffffffff80106e37:	85 c0                	test   %eax,%eax
ffffffff80106e39:	0f 84 32 01 00 00    	je     ffffffff80106f71 <sys_unlink+0x1d1>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffffffff80106e3f:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffffffff80106e43:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffffffff80106e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e4b:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106e4e:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e51:	e8 f1 b9 ff ff       	call   ffffffff80102847 <dirlookup>
ffffffff80106e56:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106e5a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106e5f:	0f 84 0f 01 00 00    	je     ffffffff80106f74 <sys_unlink+0x1d4>
    goto bad;
  ilock(ip);
ffffffff80106e65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e69:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e6c:	e8 a7 b0 ff ff       	call   ffffffff80101f18 <ilock>

  if(ip->nlink < 1)
ffffffff80106e71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e75:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106e79:	66 85 c0             	test   %ax,%ax
ffffffff80106e7c:	7f 0c                	jg     ffffffff80106e8a <sys_unlink+0xea>
    panic("unlink: nlink < 1");
ffffffff80106e7e:	48 c7 c7 fb 9f 10 80 	mov    $0xffffffff80109ffb,%rdi
ffffffff80106e85:	e8 c5 9a ff ff       	call   ffffffff8010094f <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
ffffffff80106e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e8e:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106e92:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106e96:	75 21                	jne    ffffffff80106eb9 <sys_unlink+0x119>
ffffffff80106e98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e9c:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e9f:	e8 8c fe ff ff       	call   ffffffff80106d30 <isdirempty>
ffffffff80106ea4:	85 c0                	test   %eax,%eax
ffffffff80106ea6:	75 11                	jne    ffffffff80106eb9 <sys_unlink+0x119>
    iunlockput(ip);
ffffffff80106ea8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106eac:	48 89 c7             	mov    %rax,%rdi
ffffffff80106eaf:	e8 38 b3 ff ff       	call   ffffffff801021ec <iunlockput>
    goto bad;
ffffffff80106eb4:	e9 bc 00 00 00       	jmp    ffffffff80106f75 <sys_unlink+0x1d5>
  }

  memset(&de, 0, sizeof(de));
ffffffff80106eb9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff80106ebd:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff80106ec2:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80106ec7:	48 89 c7             	mov    %rax,%rdi
ffffffff80106eca:	e8 70 f2 ff ff       	call   ffffffff8010613f <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80106ecf:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffffffff80106ed2:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff80106ed6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106eda:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80106edf:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ee2:	e8 7d b7 ff ff       	call   ffffffff80102664 <writei>
ffffffff80106ee7:	83 f8 10             	cmp    $0x10,%eax
ffffffff80106eea:	74 0c                	je     ffffffff80106ef8 <sys_unlink+0x158>
    panic("unlink: writei");
ffffffff80106eec:	48 c7 c7 0d a0 10 80 	mov    $0xffffffff8010a00d,%rdi
ffffffff80106ef3:	e8 57 9a ff ff       	call   ffffffff8010094f <panic>
  if(ip->type == T_DIR){
ffffffff80106ef8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106efc:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106f00:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106f04:	75 21                	jne    ffffffff80106f27 <sys_unlink+0x187>
    dp->nlink--;
ffffffff80106f06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f0a:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106f0e:	83 e8 01             	sub    $0x1,%eax
ffffffff80106f11:	89 c2                	mov    %eax,%edx
ffffffff80106f13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f17:	66 89 50 16          	mov    %dx,0x16(%rax)
    iupdate(dp);
ffffffff80106f1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f1f:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f22:	e8 e7 ad ff ff       	call   ffffffff80101d0e <iupdate>
  }
  iunlockput(dp);
ffffffff80106f27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f2b:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f2e:	e8 b9 b2 ff ff       	call   ffffffff801021ec <iunlockput>

  ip->nlink--;
ffffffff80106f33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106f37:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106f3b:	83 e8 01             	sub    $0x1,%eax
ffffffff80106f3e:	89 c2                	mov    %eax,%edx
ffffffff80106f40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106f44:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106f48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106f4c:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f4f:	e8 ba ad ff ff       	call   ffffffff80101d0e <iupdate>
  iunlockput(ip);
ffffffff80106f54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106f58:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f5b:	e8 8c b2 ff ff       	call   ffffffff801021ec <iunlockput>

  commit_trans();
ffffffff80106f60:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106f65:	e8 52 cc ff ff       	call   ffffffff80103bbc <commit_trans>

  return 0;
ffffffff80106f6a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106f6f:	eb 1f                	jmp    ffffffff80106f90 <sys_unlink+0x1f0>
    goto bad;
ffffffff80106f71:	90                   	nop
ffffffff80106f72:	eb 01                	jmp    ffffffff80106f75 <sys_unlink+0x1d5>
    goto bad;
ffffffff80106f74:	90                   	nop

bad:
  iunlockput(dp);
ffffffff80106f75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f79:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f7c:	e8 6b b2 ff ff       	call   ffffffff801021ec <iunlockput>
  commit_trans();
ffffffff80106f81:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106f86:	e8 31 cc ff ff       	call   ffffffff80103bbc <commit_trans>
  return -1;
ffffffff80106f8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106f90:	c9                   	leave
ffffffff80106f91:	c3                   	ret

ffffffff80106f92 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffffffff80106f92:	f3 0f 1e fa          	endbr64
ffffffff80106f96:	55                   	push   %rbp
ffffffff80106f97:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106f9a:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff80106f9e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffffffff80106fa2:	89 c8                	mov    %ecx,%eax
ffffffff80106fa4:	89 f1                	mov    %esi,%ecx
ffffffff80106fa6:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffffffff80106faa:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffffffff80106fae:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffffffff80106fb2:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffffffff80106fb6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80106fba:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106fbd:	48 89 c7             	mov    %rax,%rdi
ffffffff80106fc0:	e8 7d bc ff ff       	call   ffffffff80102c42 <nameiparent>
ffffffff80106fc5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106fc9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106fce:	75 0a                	jne    ffffffff80106fda <create+0x48>
    return 0;
ffffffff80106fd0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106fd5:	e9 88 01 00 00       	jmp    ffffffff80107162 <create+0x1d0>
  ilock(dp);
ffffffff80106fda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106fde:	48 89 c7             	mov    %rax,%rdi
ffffffff80106fe1:	e8 32 af ff ff       	call   ffffffff80101f18 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
ffffffff80106fe6:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffffffff80106fea:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffffffff80106fee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ff2:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106ff5:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ff8:	e8 4a b8 ff ff       	call   ffffffff80102847 <dirlookup>
ffffffff80106ffd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80107001:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80107006:	74 4c                	je     ffffffff80107054 <create+0xc2>
    iunlockput(dp);
ffffffff80107008:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010700c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010700f:	e8 d8 b1 ff ff       	call   ffffffff801021ec <iunlockput>
    ilock(ip);
ffffffff80107014:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107018:	48 89 c7             	mov    %rax,%rdi
ffffffff8010701b:	e8 f8 ae ff ff       	call   ffffffff80101f18 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
ffffffff80107020:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffffffff80107025:	75 17                	jne    ffffffff8010703e <create+0xac>
ffffffff80107027:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010702b:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff8010702f:	66 83 f8 02          	cmp    $0x2,%ax
ffffffff80107033:	75 09                	jne    ffffffff8010703e <create+0xac>
      return ip;
ffffffff80107035:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107039:	e9 24 01 00 00       	jmp    ffffffff80107162 <create+0x1d0>
    iunlockput(ip);
ffffffff8010703e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107042:	48 89 c7             	mov    %rax,%rdi
ffffffff80107045:	e8 a2 b1 ff ff       	call   ffffffff801021ec <iunlockput>
    return 0;
ffffffff8010704a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010704f:	e9 0e 01 00 00       	jmp    ffffffff80107162 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffffffff80107054:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffffffff80107058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010705c:	8b 00                	mov    (%rax),%eax
ffffffff8010705e:	89 d6                	mov    %edx,%esi
ffffffff80107060:	89 c7                	mov    %eax,%edi
ffffffff80107062:	e8 bc ab ff ff       	call   ffffffff80101c23 <ialloc>
ffffffff80107067:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff8010706b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80107070:	75 0c                	jne    ffffffff8010707e <create+0xec>
    panic("create: ialloc");
ffffffff80107072:	48 c7 c7 1c a0 10 80 	mov    $0xffffffff8010a01c,%rdi
ffffffff80107079:	e8 d1 98 ff ff       	call   ffffffff8010094f <panic>

  ilock(ip);
ffffffff8010707e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107082:	48 89 c7             	mov    %rax,%rdi
ffffffff80107085:	e8 8e ae ff ff       	call   ffffffff80101f18 <ilock>
  ip->major = major;
ffffffff8010708a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010708e:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffffffff80107092:	66 89 50 12          	mov    %dx,0x12(%rax)
  ip->minor = minor;
ffffffff80107096:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010709a:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffffffff8010709e:	66 89 50 14          	mov    %dx,0x14(%rax)
  ip->nlink = 1;
ffffffff801070a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070a6:	66 c7 40 16 01 00    	movw   $0x1,0x16(%rax)
  iupdate(ip);
ffffffff801070ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070b0:	48 89 c7             	mov    %rax,%rdi
ffffffff801070b3:	e8 56 ac ff ff       	call   ffffffff80101d0e <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
ffffffff801070b8:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffffffff801070bd:	75 69                	jne    ffffffff80107128 <create+0x196>
    dp->nlink++;  // for ".."
ffffffff801070bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801070c3:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff801070c7:	83 c0 01             	add    $0x1,%eax
ffffffff801070ca:	89 c2                	mov    %eax,%edx
ffffffff801070cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801070d0:	66 89 50 16          	mov    %dx,0x16(%rax)
    iupdate(dp);
ffffffff801070d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801070d8:	48 89 c7             	mov    %rax,%rdi
ffffffff801070db:	e8 2e ac ff ff       	call   ffffffff80101d0e <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffffffff801070e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070e4:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff801070e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070eb:	48 c7 c6 f6 9f 10 80 	mov    $0xffffffff80109ff6,%rsi
ffffffff801070f2:	48 89 c7             	mov    %rax,%rdi
ffffffff801070f5:	e8 22 b8 ff ff       	call   ffffffff8010291c <dirlink>
ffffffff801070fa:	85 c0                	test   %eax,%eax
ffffffff801070fc:	78 1e                	js     ffffffff8010711c <create+0x18a>
ffffffff801070fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107102:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80107105:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107109:	48 c7 c6 f8 9f 10 80 	mov    $0xffffffff80109ff8,%rsi
ffffffff80107110:	48 89 c7             	mov    %rax,%rdi
ffffffff80107113:	e8 04 b8 ff ff       	call   ffffffff8010291c <dirlink>
ffffffff80107118:	85 c0                	test   %eax,%eax
ffffffff8010711a:	79 0c                	jns    ffffffff80107128 <create+0x196>
      panic("create dots");
ffffffff8010711c:	48 c7 c7 2b a0 10 80 	mov    $0xffffffff8010a02b,%rdi
ffffffff80107123:	e8 27 98 ff ff       	call   ffffffff8010094f <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffffffff80107128:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010712c:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff8010712f:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffffffff80107133:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107137:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010713a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010713d:	e8 da b7 ff ff       	call   ffffffff8010291c <dirlink>
ffffffff80107142:	85 c0                	test   %eax,%eax
ffffffff80107144:	79 0c                	jns    ffffffff80107152 <create+0x1c0>
    panic("create: dirlink");
ffffffff80107146:	48 c7 c7 37 a0 10 80 	mov    $0xffffffff8010a037,%rdi
ffffffff8010714d:	e8 fd 97 ff ff       	call   ffffffff8010094f <panic>

  iunlockput(dp);
ffffffff80107152:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107156:	48 89 c7             	mov    %rax,%rdi
ffffffff80107159:	e8 8e b0 ff ff       	call   ffffffff801021ec <iunlockput>

  return ip;
ffffffff8010715e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffffffff80107162:	c9                   	leave
ffffffff80107163:	c3                   	ret

ffffffff80107164 <sys_open>:

int
sys_open(void)
{
ffffffff80107164:	f3 0f 1e fa          	endbr64
ffffffff80107168:	55                   	push   %rbp
ffffffff80107169:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010716c:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffffffff80107170:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff80107174:	48 89 c6             	mov    %rax,%rsi
ffffffff80107177:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010717c:	e8 f8 f5 ff ff       	call   ffffffff80106779 <argstr>
ffffffff80107181:	85 c0                	test   %eax,%eax
ffffffff80107183:	78 15                	js     ffffffff8010719a <sys_open+0x36>
ffffffff80107185:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffffffff80107189:	48 89 c6             	mov    %rax,%rsi
ffffffff8010718c:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80107191:	e8 07 f5 ff ff       	call   ffffffff8010669d <argint>
ffffffff80107196:	85 c0                	test   %eax,%eax
ffffffff80107198:	79 0a                	jns    ffffffff801071a4 <sys_open+0x40>
    return -1;
ffffffff8010719a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010719f:	e9 60 01 00 00       	jmp    ffffffff80107304 <sys_open+0x1a0>
  if(omode & O_CREATE){
ffffffff801071a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801071a7:	25 00 02 00 00       	and    $0x200,%eax
ffffffff801071ac:	85 c0                	test   %eax,%eax
ffffffff801071ae:	74 44                	je     ffffffff801071f4 <sys_open+0x90>
    begin_trans();
ffffffff801071b0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801071b5:	e8 b6 c9 ff ff       	call   ffffffff80103b70 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
ffffffff801071ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801071be:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff801071c3:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff801071c8:	be 02 00 00 00       	mov    $0x2,%esi
ffffffff801071cd:	48 89 c7             	mov    %rax,%rdi
ffffffff801071d0:	e8 bd fd ff ff       	call   ffffffff80106f92 <create>
ffffffff801071d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    commit_trans();
ffffffff801071d9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801071de:	e8 d9 c9 ff ff       	call   ffffffff80103bbc <commit_trans>
    if(ip == 0)
ffffffff801071e3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801071e8:	75 62                	jne    ffffffff8010724c <sys_open+0xe8>
      return -1;
ffffffff801071ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801071ef:	e9 10 01 00 00       	jmp    ffffffff80107304 <sys_open+0x1a0>
  } else {
    if((ip = namei(path)) == 0)
ffffffff801071f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801071f8:	48 89 c7             	mov    %rax,%rdi
ffffffff801071fb:	e8 1b ba ff ff       	call   ffffffff80102c1b <namei>
ffffffff80107200:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80107204:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80107209:	75 0a                	jne    ffffffff80107215 <sys_open+0xb1>
      return -1;
ffffffff8010720b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107210:	e9 ef 00 00 00       	jmp    ffffffff80107304 <sys_open+0x1a0>
    ilock(ip);
ffffffff80107215:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107219:	48 89 c7             	mov    %rax,%rdi
ffffffff8010721c:	e8 f7 ac ff ff       	call   ffffffff80101f18 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
ffffffff80107221:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107225:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80107229:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff8010722d:	75 1d                	jne    ffffffff8010724c <sys_open+0xe8>
ffffffff8010722f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80107232:	85 c0                	test   %eax,%eax
ffffffff80107234:	74 16                	je     ffffffff8010724c <sys_open+0xe8>
      iunlockput(ip);
ffffffff80107236:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010723a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010723d:	e8 aa af ff ff       	call   ffffffff801021ec <iunlockput>
      return -1;
ffffffff80107242:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107247:	e9 b8 00 00 00       	jmp    ffffffff80107304 <sys_open+0x1a0>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffffffff8010724c:	e8 83 a2 ff ff       	call   ffffffff801014d4 <filealloc>
ffffffff80107251:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80107255:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff8010725a:	74 15                	je     ffffffff80107271 <sys_open+0x10d>
ffffffff8010725c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107260:	48 89 c7             	mov    %rax,%rdi
ffffffff80107263:	e8 b9 f6 ff ff       	call   ffffffff80106921 <fdalloc>
ffffffff80107268:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffffffff8010726b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff8010726f:	79 26                	jns    ffffffff80107297 <sys_open+0x133>
    if(f)
ffffffff80107271:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80107276:	74 0c                	je     ffffffff80107284 <sys_open+0x120>
      fileclose(f);
ffffffff80107278:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010727c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010727f:	e8 15 a3 ff ff       	call   ffffffff80101599 <fileclose>
    iunlockput(ip);
ffffffff80107284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107288:	48 89 c7             	mov    %rax,%rdi
ffffffff8010728b:	e8 5c af ff ff       	call   ffffffff801021ec <iunlockput>
    return -1;
ffffffff80107290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107295:	eb 6d                	jmp    ffffffff80107304 <sys_open+0x1a0>
  }
  iunlock(ip);
ffffffff80107297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010729b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010729e:	e8 ea ad ff ff       	call   ffffffff8010208d <iunlock>

  f->type = FD_INODE;
ffffffff801072a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801072a7:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffffffff801072ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801072b1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801072b5:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffffffff801072b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801072bd:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffffffff801072c4:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801072c7:	83 e0 01             	and    $0x1,%eax
ffffffff801072ca:	85 c0                	test   %eax,%eax
ffffffff801072cc:	0f 94 c0             	sete   %al
ffffffff801072cf:	89 c2                	mov    %eax,%edx
ffffffff801072d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801072d5:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffffffff801072d8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801072db:	83 e0 01             	and    $0x1,%eax
ffffffff801072de:	85 c0                	test   %eax,%eax
ffffffff801072e0:	75 0a                	jne    ffffffff801072ec <sys_open+0x188>
ffffffff801072e2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801072e5:	83 e0 02             	and    $0x2,%eax
ffffffff801072e8:	85 c0                	test   %eax,%eax
ffffffff801072ea:	74 07                	je     ffffffff801072f3 <sys_open+0x18f>
ffffffff801072ec:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff801072f1:	eb 05                	jmp    ffffffff801072f8 <sys_open+0x194>
ffffffff801072f3:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801072f8:	89 c2                	mov    %eax,%edx
ffffffff801072fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801072fe:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffffffff80107301:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffffffff80107304:	c9                   	leave
ffffffff80107305:	c3                   	ret

ffffffff80107306 <sys_mkdir>:

int
sys_mkdir(void)
{
ffffffff80107306:	f3 0f 1e fa          	endbr64
ffffffff8010730a:	55                   	push   %rbp
ffffffff8010730b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010730e:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_trans();
ffffffff80107312:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107317:	e8 54 c8 ff ff       	call   ffffffff80103b70 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffffffff8010731c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107320:	48 89 c6             	mov    %rax,%rsi
ffffffff80107323:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107328:	e8 4c f4 ff ff       	call   ffffffff80106779 <argstr>
ffffffff8010732d:	85 c0                	test   %eax,%eax
ffffffff8010732f:	78 26                	js     ffffffff80107357 <sys_mkdir+0x51>
ffffffff80107331:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107335:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff8010733a:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff8010733f:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80107344:	48 89 c7             	mov    %rax,%rdi
ffffffff80107347:	e8 46 fc ff ff       	call   ffffffff80106f92 <create>
ffffffff8010734c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80107350:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80107355:	75 11                	jne    ffffffff80107368 <sys_mkdir+0x62>
    commit_trans();
ffffffff80107357:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010735c:	e8 5b c8 ff ff       	call   ffffffff80103bbc <commit_trans>
    return -1;
ffffffff80107361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107366:	eb 1b                	jmp    ffffffff80107383 <sys_mkdir+0x7d>
  }
  iunlockput(ip);
ffffffff80107368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010736c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010736f:	e8 78 ae ff ff       	call   ffffffff801021ec <iunlockput>
  commit_trans();
ffffffff80107374:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107379:	e8 3e c8 ff ff       	call   ffffffff80103bbc <commit_trans>
  return 0;
ffffffff8010737e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107383:	c9                   	leave
ffffffff80107384:	c3                   	ret

ffffffff80107385 <sys_mknod>:

int
sys_mknod(void)
{
ffffffff80107385:	f3 0f 1e fa          	endbr64
ffffffff80107389:	55                   	push   %rbp
ffffffff8010738a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010738d:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
ffffffff80107391:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107396:	e8 d5 c7 ff ff       	call   ffffffff80103b70 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
ffffffff8010739b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff8010739f:	48 89 c6             	mov    %rax,%rsi
ffffffff801073a2:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801073a7:	e8 cd f3 ff ff       	call   ffffffff80106779 <argstr>
ffffffff801073ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801073af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801073b3:	78 52                	js     ffffffff80107407 <sys_mknod+0x82>
     argint(1, &major) < 0 ||
ffffffff801073b5:	48 8d 45 e4          	lea    -0x1c(%rbp),%rax
ffffffff801073b9:	48 89 c6             	mov    %rax,%rsi
ffffffff801073bc:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff801073c1:	e8 d7 f2 ff ff       	call   ffffffff8010669d <argint>
  if((len=argstr(0, &path)) < 0 ||
ffffffff801073c6:	85 c0                	test   %eax,%eax
ffffffff801073c8:	78 3d                	js     ffffffff80107407 <sys_mknod+0x82>
     argint(2, &minor) < 0 ||
ffffffff801073ca:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff801073ce:	48 89 c6             	mov    %rax,%rsi
ffffffff801073d1:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff801073d6:	e8 c2 f2 ff ff       	call   ffffffff8010669d <argint>
     argint(1, &major) < 0 ||
ffffffff801073db:	85 c0                	test   %eax,%eax
ffffffff801073dd:	78 28                	js     ffffffff80107407 <sys_mknod+0x82>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffffffff801073df:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff801073e2:	0f bf c8             	movswl %ax,%ecx
ffffffff801073e5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff801073e8:	0f bf d0             	movswl %ax,%edx
ffffffff801073eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801073ef:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff801073f4:	48 89 c7             	mov    %rax,%rdi
ffffffff801073f7:	e8 96 fb ff ff       	call   ffffffff80106f92 <create>
ffffffff801073fc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     argint(2, &minor) < 0 ||
ffffffff80107400:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80107405:	75 11                	jne    ffffffff80107418 <sys_mknod+0x93>
    commit_trans();
ffffffff80107407:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010740c:	e8 ab c7 ff ff       	call   ffffffff80103bbc <commit_trans>
    return -1;
ffffffff80107411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107416:	eb 1b                	jmp    ffffffff80107433 <sys_mknod+0xae>
  }
  iunlockput(ip);
ffffffff80107418:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010741c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010741f:	e8 c8 ad ff ff       	call   ffffffff801021ec <iunlockput>
  commit_trans();
ffffffff80107424:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107429:	e8 8e c7 ff ff       	call   ffffffff80103bbc <commit_trans>
  return 0;
ffffffff8010742e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107433:	c9                   	leave
ffffffff80107434:	c3                   	ret

ffffffff80107435 <sys_chdir>:

int
sys_chdir(void)
{
ffffffff80107435:	f3 0f 1e fa          	endbr64
ffffffff80107439:	55                   	push   %rbp
ffffffff8010743a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010743d:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
ffffffff80107441:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107445:	48 89 c6             	mov    %rax,%rsi
ffffffff80107448:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010744d:	e8 27 f3 ff ff       	call   ffffffff80106779 <argstr>
ffffffff80107452:	85 c0                	test   %eax,%eax
ffffffff80107454:	78 17                	js     ffffffff8010746d <sys_chdir+0x38>
ffffffff80107456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010745a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010745d:	e8 b9 b7 ff ff       	call   ffffffff80102c1b <namei>
ffffffff80107462:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80107466:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff8010746b:	75 07                	jne    ffffffff80107474 <sys_chdir+0x3f>
    return -1;
ffffffff8010746d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107472:	eb 6e                	jmp    ffffffff801074e2 <sys_chdir+0xad>
  ilock(ip);
ffffffff80107474:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107478:	48 89 c7             	mov    %rax,%rdi
ffffffff8010747b:	e8 98 aa ff ff       	call   ffffffff80101f18 <ilock>
  if(ip->type != T_DIR){
ffffffff80107480:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107484:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80107488:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff8010748c:	74 13                	je     ffffffff801074a1 <sys_chdir+0x6c>
    iunlockput(ip);
ffffffff8010748e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107492:	48 89 c7             	mov    %rax,%rdi
ffffffff80107495:	e8 52 ad ff ff       	call   ffffffff801021ec <iunlockput>
    return -1;
ffffffff8010749a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010749f:	eb 41                	jmp    ffffffff801074e2 <sys_chdir+0xad>
  }
  iunlock(ip);
ffffffff801074a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801074a5:	48 89 c7             	mov    %rax,%rdi
ffffffff801074a8:	e8 e0 ab ff ff       	call   ffffffff8010208d <iunlock>
  iput(proc->cwd);
ffffffff801074ad:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801074b4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801074b8:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff801074bf:	48 89 c7             	mov    %rax,%rdi
ffffffff801074c2:	e8 3c ac ff ff       	call   ffffffff80102103 <iput>
  proc->cwd = ip;
ffffffff801074c7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801074ce:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801074d2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801074d6:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffffffff801074dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801074e2:	c9                   	leave
ffffffff801074e3:	c3                   	ret

ffffffff801074e4 <sys_exec>:

int
sys_exec(void)
{
ffffffff801074e4:	f3 0f 1e fa          	endbr64
ffffffff801074e8:	55                   	push   %rbp
ffffffff801074e9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801074ec:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  uintp uargv, uarg;

  if(argstr(0, &path) < 0 || arguintp(1, &uargv) < 0){
ffffffff801074f3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff801074f7:	48 89 c6             	mov    %rax,%rsi
ffffffff801074fa:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801074ff:	e8 75 f2 ff ff       	call   ffffffff80106779 <argstr>
ffffffff80107504:	85 c0                	test   %eax,%eax
ffffffff80107506:	78 18                	js     ffffffff80107520 <sys_exec+0x3c>
ffffffff80107508:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffffffff8010750f:	48 89 c6             	mov    %rax,%rsi
ffffffff80107512:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80107517:	e8 ad f1 ff ff       	call   ffffffff801066c9 <arguintp>
ffffffff8010751c:	85 c0                	test   %eax,%eax
ffffffff8010751e:	79 0a                	jns    ffffffff8010752a <sys_exec+0x46>
    return -1;
ffffffff80107520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107525:	e9 d6 00 00 00       	jmp    ffffffff80107600 <sys_exec+0x11c>
  }
  memset(argv, 0, sizeof(argv));
ffffffff8010752a:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffffffff80107531:	ba 00 01 00 00       	mov    $0x100,%edx
ffffffff80107536:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010753b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010753e:	e8 fc eb ff ff       	call   ffffffff8010613f <memset>
  for(i=0;; i++){
ffffffff80107543:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(i >= NELEM(argv))
ffffffff8010754a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010754d:	83 f8 1f             	cmp    $0x1f,%eax
ffffffff80107550:	76 0a                	jbe    ffffffff8010755c <sys_exec+0x78>
      return -1;
ffffffff80107552:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107557:	e9 a4 00 00 00       	jmp    ffffffff80107600 <sys_exec+0x11c>
    if(fetchuintp(uargv+sizeof(uintp)*i, &uarg) < 0)
ffffffff8010755c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010755f:	48 98                	cltq
ffffffff80107561:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80107568:	00 
ffffffff80107569:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffffffff80107570:	48 01 c2             	add    %rax,%rdx
ffffffff80107573:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffffffff8010757a:	48 89 c6             	mov    %rax,%rsi
ffffffff8010757d:	48 89 d7             	mov    %rdx,%rdi
ffffffff80107580:	e8 86 ef ff ff       	call   ffffffff8010650b <fetchuintp>
ffffffff80107585:	85 c0                	test   %eax,%eax
ffffffff80107587:	79 07                	jns    ffffffff80107590 <sys_exec+0xac>
      return -1;
ffffffff80107589:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010758e:	eb 70                	jmp    ffffffff80107600 <sys_exec+0x11c>
    if(uarg == 0){
ffffffff80107590:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffffffff80107597:	48 85 c0             	test   %rax,%rax
ffffffff8010759a:	75 2a                	jne    ffffffff801075c6 <sys_exec+0xe2>
      argv[i] = 0;
ffffffff8010759c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010759f:	48 98                	cltq
ffffffff801075a1:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffffffff801075a8:	ff 00 00 00 00 
      break;
ffffffff801075ad:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffffffff801075ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801075b2:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffffffff801075b9:	48 89 d6             	mov    %rdx,%rsi
ffffffff801075bc:	48 89 c7             	mov    %rax,%rdi
ffffffff801075bf:	e8 ed 99 ff ff       	call   ffffffff80100fb1 <exec>
ffffffff801075c4:	eb 3a                	jmp    ffffffff80107600 <sys_exec+0x11c>
    if(fetchstr(uarg, &argv[i]) < 0)
ffffffff801075c6:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffffffff801075cd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801075d0:	48 63 d2             	movslq %edx,%rdx
ffffffff801075d3:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff801075d7:	48 01 c2             	add    %rax,%rdx
ffffffff801075da:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffffffff801075e1:	48 89 d6             	mov    %rdx,%rsi
ffffffff801075e4:	48 89 c7             	mov    %rax,%rdi
ffffffff801075e7:	e8 7e ef ff ff       	call   ffffffff8010656a <fetchstr>
ffffffff801075ec:	85 c0                	test   %eax,%eax
ffffffff801075ee:	79 07                	jns    ffffffff801075f7 <sys_exec+0x113>
      return -1;
ffffffff801075f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801075f5:	eb 09                	jmp    ffffffff80107600 <sys_exec+0x11c>
  for(i=0;; i++){
ffffffff801075f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffffffff801075fb:	e9 4a ff ff ff       	jmp    ffffffff8010754a <sys_exec+0x66>
}
ffffffff80107600:	c9                   	leave
ffffffff80107601:	c3                   	ret

ffffffff80107602 <sys_pipe>:

int
sys_pipe(void)
{
ffffffff80107602:	f3 0f 1e fa          	endbr64
ffffffff80107606:	55                   	push   %rbp
ffffffff80107607:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010760a:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffffffff8010760e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107612:	ba 08 00 00 00       	mov    $0x8,%edx
ffffffff80107617:	48 89 c6             	mov    %rax,%rsi
ffffffff8010761a:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010761f:	e8 d0 f0 ff ff       	call   ffffffff801066f4 <argptr>
ffffffff80107624:	85 c0                	test   %eax,%eax
ffffffff80107626:	79 0a                	jns    ffffffff80107632 <sys_pipe+0x30>
    return -1;
ffffffff80107628:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010762d:	e9 b0 00 00 00       	jmp    ffffffff801076e2 <sys_pipe+0xe0>
  if(pipealloc(&rf, &wf) < 0)
ffffffff80107632:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff80107636:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff8010763a:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010763d:	48 89 c7             	mov    %rax,%rdi
ffffffff80107640:	e8 80 d4 ff ff       	call   ffffffff80104ac5 <pipealloc>
ffffffff80107645:	85 c0                	test   %eax,%eax
ffffffff80107647:	79 0a                	jns    ffffffff80107653 <sys_pipe+0x51>
    return -1;
ffffffff80107649:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010764e:	e9 8f 00 00 00       	jmp    ffffffff801076e2 <sys_pipe+0xe0>
  fd0 = -1;
ffffffff80107653:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffffffff8010765a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010765e:	48 89 c7             	mov    %rax,%rdi
ffffffff80107661:	e8 bb f2 ff ff       	call   ffffffff80106921 <fdalloc>
ffffffff80107666:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80107669:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010766d:	78 15                	js     ffffffff80107684 <sys_pipe+0x82>
ffffffff8010766f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107673:	48 89 c7             	mov    %rax,%rdi
ffffffff80107676:	e8 a6 f2 ff ff       	call   ffffffff80106921 <fdalloc>
ffffffff8010767b:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff8010767e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffffffff80107682:	79 43                	jns    ffffffff801076c7 <sys_pipe+0xc5>
    if(fd0 >= 0)
ffffffff80107684:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80107688:	78 1e                	js     ffffffff801076a8 <sys_pipe+0xa6>
      proc->ofile[fd0] = 0;
ffffffff8010768a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107691:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107695:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80107698:	48 63 d2             	movslq %edx,%rdx
ffffffff8010769b:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010769f:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff801076a6:	00 00 
    fileclose(rf);
ffffffff801076a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801076ac:	48 89 c7             	mov    %rax,%rdi
ffffffff801076af:	e8 e5 9e ff ff       	call   ffffffff80101599 <fileclose>
    fileclose(wf);
ffffffff801076b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801076b8:	48 89 c7             	mov    %rax,%rdi
ffffffff801076bb:	e8 d9 9e ff ff       	call   ffffffff80101599 <fileclose>
    return -1;
ffffffff801076c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801076c5:	eb 1b                	jmp    ffffffff801076e2 <sys_pipe+0xe0>
  }
  fd[0] = fd0;
ffffffff801076c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801076cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801076ce:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffffffff801076d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801076d4:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffffffff801076d8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff801076db:	89 02                	mov    %eax,(%rdx)
  return 0;
ffffffff801076dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801076e2:	c9                   	leave
ffffffff801076e3:	c3                   	ret

ffffffff801076e4 <outw>:
{
ffffffff801076e4:	55                   	push   %rbp
ffffffff801076e5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801076e8:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801076ec:	89 fa                	mov    %edi,%edx
ffffffff801076ee:	89 f0                	mov    %esi,%eax
ffffffff801076f0:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801076f4:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801076f8:	0f b7 45 f8          	movzwl -0x8(%rbp),%eax
ffffffff801076fc:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80107700:	66 ef                	out    %ax,(%dx)
}
ffffffff80107702:	90                   	nop
ffffffff80107703:	c9                   	leave
ffffffff80107704:	c3                   	ret

ffffffff80107705 <sys_fork>:

extern struct ptable ptable;

int
sys_fork(void)
{
ffffffff80107705:	f3 0f 1e fa          	endbr64
ffffffff80107709:	55                   	push   %rbp
ffffffff8010770a:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffffffff8010770d:	e8 84 db ff ff       	call   ffffffff80105296 <fork>
}
ffffffff80107712:	5d                   	pop    %rbp
ffffffff80107713:	c3                   	ret

ffffffff80107714 <sys_exit>:

int
sys_exit(void)
{
ffffffff80107714:	f3 0f 1e fa          	endbr64
ffffffff80107718:	55                   	push   %rbp
ffffffff80107719:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffffffff8010771c:	e8 01 de ff ff       	call   ffffffff80105522 <exit>
  return 0;  // not reached
ffffffff80107721:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107726:	5d                   	pop    %rbp
ffffffff80107727:	c3                   	ret

ffffffff80107728 <sys_wait>:

int
sys_wait(void)
{
ffffffff80107728:	f3 0f 1e fa          	endbr64
ffffffff8010772c:	55                   	push   %rbp
ffffffff8010772d:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffffffff80107730:	e8 77 df ff ff       	call   ffffffff801056ac <wait>
}
ffffffff80107735:	5d                   	pop    %rbp
ffffffff80107736:	c3                   	ret

ffffffff80107737 <sys_kill>:

int
sys_kill(void)
{
ffffffff80107737:	f3 0f 1e fa          	endbr64
ffffffff8010773b:	55                   	push   %rbp
ffffffff8010773c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010773f:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffffffff80107743:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffffffff80107747:	48 89 c6             	mov    %rax,%rsi
ffffffff8010774a:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010774f:	e8 49 ef ff ff       	call   ffffffff8010669d <argint>
ffffffff80107754:	85 c0                	test   %eax,%eax
ffffffff80107756:	79 07                	jns    ffffffff8010775f <sys_kill+0x28>
    return -1;
ffffffff80107758:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010775d:	eb 0a                	jmp    ffffffff80107769 <sys_kill+0x32>
  return kill(pid);
ffffffff8010775f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80107762:	89 c7                	mov    %eax,%edi
ffffffff80107764:	e8 01 e4 ff ff       	call   ffffffff80105b6a <kill>
}
ffffffff80107769:	c9                   	leave
ffffffff8010776a:	c3                   	ret

ffffffff8010776b <sys_getpinfo>:

int sys_getpinfo(void) 
{
ffffffff8010776b:	f3 0f 1e fa          	endbr64
ffffffff8010776f:	55                   	push   %rbp
ffffffff80107770:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107773:	48 83 ec 20          	sub    $0x20,%rsp
    struct pstat *pstat;

    argptr(0, (void*)&pstat, sizeof(*pstat));
ffffffff80107777:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff8010777b:	ba 00 04 00 00       	mov    $0x400,%edx
ffffffff80107780:	48 89 c6             	mov    %rax,%rsi
ffffffff80107783:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107788:	e8 67 ef ff ff       	call   ffffffff801066f4 <argptr>

    if (pstat == 0) {
ffffffff8010778d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80107791:	48 85 c0             	test   %rax,%rax
ffffffff80107794:	75 0a                	jne    ffffffff801077a0 <sys_getpinfo+0x35>
        return -1;
ffffffff80107796:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010779b:	e9 ca 00 00 00       	jmp    ffffffff8010786a <sys_getpinfo+0xff>
    }

    acquire(&ptable.lock);
ffffffff801077a0:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801077a7:	e8 07 e6 ff ff       	call   ffffffff80105db3 <acquire>
    struct proc *p;
    int i;
    for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) 
ffffffff801077ac:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff801077b3:	80 
ffffffff801077b4:	e9 92 00 00 00       	jmp    ffffffff8010784b <sys_getpinfo+0xe0>
    {
        i = p - ptable.proc;
ffffffff801077b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801077bd:	48 2d 68 04 11 80    	sub    $0xffffffff80110468,%rax
ffffffff801077c3:	48 c1 f8 04          	sar    $0x4,%rax
ffffffff801077c7:	48 89 c2             	mov    %rax,%rdx
ffffffff801077ca:	48 b8 ef ee ee ee ee 	movabs $0xeeeeeeeeeeeeeeef,%rax
ffffffff801077d1:	ee ee ee 
ffffffff801077d4:	48 0f af c2          	imul   %rdx,%rax
ffffffff801077d8:	89 45 f4             	mov    %eax,-0xc(%rbp)
        /* if (p->state == UNUSED) { */
        /*     pstat->inuse[i] = 0; */
        /* } else { */
        /*     pstat->inuse[i] = 1; */
        /* } */
        pstat->inuse[i] = p->inuse;
ffffffff801077db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801077df:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801077e3:	8b 8a e0 00 00 00    	mov    0xe0(%rdx),%ecx
ffffffff801077e9:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801077ec:	48 63 d2             	movslq %edx,%rdx
ffffffff801077ef:	89 0c 90             	mov    %ecx,(%rax,%rdx,4)
        pstat->pid[i] = p->pid;
ffffffff801077f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801077f6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801077fa:	8b 52 1c             	mov    0x1c(%rdx),%edx
ffffffff801077fd:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff80107800:	48 63 c9             	movslq %ecx,%rcx
ffffffff80107803:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
ffffffff80107807:	89 14 88             	mov    %edx,(%rax,%rcx,4)
        pstat->ticks[i] = p->ticks;
ffffffff8010780a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010780e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80107812:	8b 92 e4 00 00 00    	mov    0xe4(%rdx),%edx
ffffffff80107818:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff8010781b:	48 63 c9             	movslq %ecx,%rcx
ffffffff8010781e:	48 81 c1 c0 00 00 00 	add    $0xc0,%rcx
ffffffff80107825:	89 14 88             	mov    %edx,(%rax,%rcx,4)
        pstat->tickets[i] = p->tickets;
ffffffff80107828:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010782c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80107830:	8b 92 e8 00 00 00    	mov    0xe8(%rdx),%edx
ffffffff80107836:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff80107839:	48 63 c9             	movslq %ecx,%rcx
ffffffff8010783c:	48 83 c1 40          	add    $0x40,%rcx
ffffffff80107840:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) 
ffffffff80107843:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff8010784a:	00 
ffffffff8010784b:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80107852:	80 
ffffffff80107853:	0f 85 60 ff ff ff    	jne    ffffffff801077b9 <sys_getpinfo+0x4e>
    }
    release(&ptable.lock);
ffffffff80107859:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80107860:	e8 29 e6 ff ff       	call   ffffffff80105e8e <release>
    return 0;
ffffffff80107865:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010786a:	c9                   	leave
ffffffff8010786b:	c3                   	ret

ffffffff8010786c <sys_getpid>:

int
sys_getpid(void)
{
ffffffff8010786c:	f3 0f 1e fa          	endbr64
ffffffff80107870:	55                   	push   %rbp
ffffffff80107871:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffffffff80107874:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010787b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010787f:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffffffff80107882:	5d                   	pop    %rbp
ffffffff80107883:	c3                   	ret

ffffffff80107884 <sys_sbrk>:

uintp
sys_sbrk(void)
{
ffffffff80107884:	f3 0f 1e fa          	endbr64
ffffffff80107888:	55                   	push   %rbp
ffffffff80107889:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010788c:	48 83 ec 10          	sub    $0x10,%rsp
  uintp addr;
  uintp n;

  if(arguintp(0, &n) < 0)
ffffffff80107890:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107894:	48 89 c6             	mov    %rax,%rsi
ffffffff80107897:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010789c:	e8 28 ee ff ff       	call   ffffffff801066c9 <arguintp>
ffffffff801078a1:	85 c0                	test   %eax,%eax
ffffffff801078a3:	79 09                	jns    ffffffff801078ae <sys_sbrk+0x2a>
    return -1;
ffffffff801078a5:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffffffff801078ac:	eb 2e                	jmp    ffffffff801078dc <sys_sbrk+0x58>
  addr = proc->sz;
ffffffff801078ae:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801078b5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801078b9:	48 8b 00             	mov    (%rax),%rax
ffffffff801078bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffffffff801078c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801078c4:	89 c7                	mov    %eax,%edi
ffffffff801078c6:	e8 09 d9 ff ff       	call   ffffffff801051d4 <growproc>
ffffffff801078cb:	85 c0                	test   %eax,%eax
ffffffff801078cd:	79 09                	jns    ffffffff801078d8 <sys_sbrk+0x54>
    return -1;
ffffffff801078cf:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffffffff801078d6:	eb 04                	jmp    ffffffff801078dc <sys_sbrk+0x58>
  return addr;
ffffffff801078d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801078dc:	c9                   	leave
ffffffff801078dd:	c3                   	ret

ffffffff801078de <sys_sleep>:

int
sys_sleep(void)
{
ffffffff801078de:	f3 0f 1e fa          	endbr64
ffffffff801078e2:	55                   	push   %rbp
ffffffff801078e3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801078e6:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
ffffffff801078ea:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff801078ee:	48 89 c6             	mov    %rax,%rsi
ffffffff801078f1:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801078f6:	e8 a2 ed ff ff       	call   ffffffff8010669d <argint>
ffffffff801078fb:	85 c0                	test   %eax,%eax
ffffffff801078fd:	79 07                	jns    ffffffff80107906 <sys_sleep+0x28>
    return -1;
ffffffff801078ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107904:	eb 70                	jmp    ffffffff80107976 <sys_sleep+0x98>
  acquire(&tickslock);
ffffffff80107906:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff8010790d:	e8 a1 e4 ff ff       	call   ffffffff80105db3 <acquire>
  ticks0 = ticks;
ffffffff80107912:	8b 05 d0 cf 00 00    	mov    0xcfd0(%rip),%eax        # ffffffff801148e8 <ticks>
ffffffff80107918:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffffffff8010791b:	eb 38                	jmp    ffffffff80107955 <sys_sleep+0x77>
    if(proc->killed){
ffffffff8010791d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107924:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107928:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff8010792b:	85 c0                	test   %eax,%eax
ffffffff8010792d:	74 13                	je     ffffffff80107942 <sys_sleep+0x64>
      release(&tickslock);
ffffffff8010792f:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff80107936:	e8 53 e5 ff ff       	call   ffffffff80105e8e <release>
      return -1;
ffffffff8010793b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107940:	eb 34                	jmp    ffffffff80107976 <sys_sleep+0x98>
    }
    sleep(&ticks, &tickslock);
ffffffff80107942:	48 c7 c6 80 48 11 80 	mov    $0xffffffff80114880,%rsi
ffffffff80107949:	48 c7 c7 e8 48 11 80 	mov    $0xffffffff801148e8,%rdi
ffffffff80107950:	e8 c2 e0 ff ff       	call   ffffffff80105a17 <sleep>
  while(ticks - ticks0 < n){
ffffffff80107955:	8b 05 8d cf 00 00    	mov    0xcf8d(%rip),%eax        # ffffffff801148e8 <ticks>
ffffffff8010795b:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff8010795e:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff80107961:	39 d0                	cmp    %edx,%eax
ffffffff80107963:	72 b8                	jb     ffffffff8010791d <sys_sleep+0x3f>
  }
  release(&tickslock);
ffffffff80107965:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff8010796c:	e8 1d e5 ff ff       	call   ffffffff80105e8e <release>
  return 0;
ffffffff80107971:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107976:	c9                   	leave
ffffffff80107977:	c3                   	ret

ffffffff80107978 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffffffff80107978:	f3 0f 1e fa          	endbr64
ffffffff8010797c:	55                   	push   %rbp
ffffffff8010797d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107980:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;
  
  acquire(&tickslock);
ffffffff80107984:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff8010798b:	e8 23 e4 ff ff       	call   ffffffff80105db3 <acquire>
  xticks = ticks;
ffffffff80107990:	8b 05 52 cf 00 00    	mov    0xcf52(%rip),%eax        # ffffffff801148e8 <ticks>
ffffffff80107996:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffffffff80107999:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff801079a0:	e8 e9 e4 ff ff       	call   ffffffff80105e8e <release>
  return xticks;
ffffffff801079a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff801079a8:	c9                   	leave
ffffffff801079a9:	c3                   	ret

ffffffff801079aa <sys_getfavnum>:

int
sys_getfavnum(void)
{
ffffffff801079aa:	f3 0f 1e fa          	endbr64
ffffffff801079ae:	55                   	push   %rbp
ffffffff801079af:	48 89 e5             	mov    %rsp,%rbp
ffffffff801079b2:	48 83 ec 10          	sub    $0x10,%rsp
  int favnum = 7;
ffffffff801079b6:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)

  return favnum;
ffffffff801079bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff801079c0:	c9                   	leave
ffffffff801079c1:	c3                   	ret

ffffffff801079c2 <sys_halt>:

void
sys_halt(void)
{
ffffffff801079c2:	f3 0f 1e fa          	endbr64
ffffffff801079c6:	55                   	push   %rbp
ffffffff801079c7:	48 89 e5             	mov    %rsp,%rbp
  outw(0x604, 0x2000);
ffffffff801079ca:	be 00 20 00 00       	mov    $0x2000,%esi
ffffffff801079cf:	bf 04 06 00 00       	mov    $0x604,%edi
ffffffff801079d4:	e8 0b fd ff ff       	call   ffffffff801076e4 <outw>
}
ffffffff801079d9:	90                   	nop
ffffffff801079da:	5d                   	pop    %rbp
ffffffff801079db:	c3                   	ret

ffffffff801079dc <outb>:
{
ffffffff801079dc:	55                   	push   %rbp
ffffffff801079dd:	48 89 e5             	mov    %rsp,%rbp
ffffffff801079e0:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801079e4:	89 fa                	mov    %edi,%edx
ffffffff801079e6:	89 f0                	mov    %esi,%eax
ffffffff801079e8:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801079ec:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801079ef:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff801079f3:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff801079f7:	ee                   	out    %al,(%dx)
}
ffffffff801079f8:	90                   	nop
ffffffff801079f9:	c9                   	leave
ffffffff801079fa:	c3                   	ret

ffffffff801079fb <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
ffffffff801079fb:	f3 0f 1e fa          	endbr64
ffffffff801079ff:	55                   	push   %rbp
ffffffff80107a00:	48 89 e5             	mov    %rsp,%rbp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
ffffffff80107a03:	be 34 00 00 00       	mov    $0x34,%esi
ffffffff80107a08:	bf 43 00 00 00       	mov    $0x43,%edi
ffffffff80107a0d:	e8 ca ff ff ff       	call   ffffffff801079dc <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
ffffffff80107a12:	be 9c 00 00 00       	mov    $0x9c,%esi
ffffffff80107a17:	bf 40 00 00 00       	mov    $0x40,%edi
ffffffff80107a1c:	e8 bb ff ff ff       	call   ffffffff801079dc <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
ffffffff80107a21:	be 2e 00 00 00       	mov    $0x2e,%esi
ffffffff80107a26:	bf 40 00 00 00       	mov    $0x40,%edi
ffffffff80107a2b:	e8 ac ff ff ff       	call   ffffffff801079dc <outb>
  picenable(IRQ_TIMER);
ffffffff80107a30:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107a35:	e8 59 cf ff ff       	call   ffffffff80104993 <picenable>
}
ffffffff80107a3a:	90                   	nop
ffffffff80107a3b:	5d                   	pop    %rbp
ffffffff80107a3c:	c3                   	ret

ffffffff80107a3d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  push %r15
ffffffff80107a3d:	41 57                	push   %r15
  push %r14
ffffffff80107a3f:	41 56                	push   %r14
  push %r13
ffffffff80107a41:	41 55                	push   %r13
  push %r12
ffffffff80107a43:	41 54                	push   %r12
  push %r11
ffffffff80107a45:	41 53                	push   %r11
  push %r10
ffffffff80107a47:	41 52                	push   %r10
  push %r9
ffffffff80107a49:	41 51                	push   %r9
  push %r8
ffffffff80107a4b:	41 50                	push   %r8
  push %rdi
ffffffff80107a4d:	57                   	push   %rdi
  push %rsi
ffffffff80107a4e:	56                   	push   %rsi
  push %rbp
ffffffff80107a4f:	55                   	push   %rbp
  push %rdx
ffffffff80107a50:	52                   	push   %rdx
  push %rcx
ffffffff80107a51:	51                   	push   %rcx
  push %rbx
ffffffff80107a52:	53                   	push   %rbx
  push %rax
ffffffff80107a53:	50                   	push   %rax

  mov  %rsp, %rdi  # frame in arg1
ffffffff80107a54:	48 89 e7             	mov    %rsp,%rdi
  call trap
ffffffff80107a57:	e8 32 00 00 00       	call   ffffffff80107a8e <trap>

ffffffff80107a5c <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  pop %rax
ffffffff80107a5c:	58                   	pop    %rax
  pop %rbx
ffffffff80107a5d:	5b                   	pop    %rbx
  pop %rcx
ffffffff80107a5e:	59                   	pop    %rcx
  pop %rdx
ffffffff80107a5f:	5a                   	pop    %rdx
  pop %rbp
ffffffff80107a60:	5d                   	pop    %rbp
  pop %rsi
ffffffff80107a61:	5e                   	pop    %rsi
  pop %rdi
ffffffff80107a62:	5f                   	pop    %rdi
  pop %r8
ffffffff80107a63:	41 58                	pop    %r8
  pop %r9
ffffffff80107a65:	41 59                	pop    %r9
  pop %r10
ffffffff80107a67:	41 5a                	pop    %r10
  pop %r11
ffffffff80107a69:	41 5b                	pop    %r11
  pop %r12
ffffffff80107a6b:	41 5c                	pop    %r12
  pop %r13
ffffffff80107a6d:	41 5d                	pop    %r13
  pop %r14
ffffffff80107a6f:	41 5e                	pop    %r14
  pop %r15
ffffffff80107a71:	41 5f                	pop    %r15

  # discard trapnum and errorcode
  add $16, %rsp
ffffffff80107a73:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffffffff80107a77:	48 cf                	iretq

ffffffff80107a79 <rcr2>:

static inline uintp
rcr2(void)
{
ffffffff80107a79:	55                   	push   %rbp
ffffffff80107a7a:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107a7d:	48 83 ec 10          	sub    $0x10,%rsp
  uintp val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffffffff80107a81:	0f 20 d0             	mov    %cr2,%rax
ffffffff80107a84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffffffff80107a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80107a8c:	c9                   	leave
ffffffff80107a8d:	c3                   	ret

ffffffff80107a8e <trap>:
#endif

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffffffff80107a8e:	f3 0f 1e fa          	endbr64
ffffffff80107a92:	55                   	push   %rbp
ffffffff80107a93:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107a96:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80107a9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(tf->trapno == T_SYSCALL){
ffffffff80107a9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107aa2:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107aa6:	48 83 f8 40          	cmp    $0x40,%rax
ffffffff80107aaa:	75 4f                	jne    ffffffff80107afb <trap+0x6d>
    if(proc->killed)
ffffffff80107aac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107ab3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ab7:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107aba:	85 c0                	test   %eax,%eax
ffffffff80107abc:	74 05                	je     ffffffff80107ac3 <trap+0x35>
      exit();
ffffffff80107abe:	e8 5f da ff ff       	call   ffffffff80105522 <exit>
    proc->tf = tf;
ffffffff80107ac3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107aca:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ace:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80107ad2:	48 89 50 28          	mov    %rdx,0x28(%rax)
    syscall();
ffffffff80107ad6:	e8 e2 ec ff ff       	call   ffffffff801067bd <syscall>
    if(proc->killed)
ffffffff80107adb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107ae2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ae6:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107ae9:	85 c0                	test   %eax,%eax
ffffffff80107aeb:	0f 84 d5 02 00 00    	je     ffffffff80107dc6 <trap+0x338>
      exit();
ffffffff80107af1:	e8 2c da ff ff       	call   ffffffff80105522 <exit>
    return;
ffffffff80107af6:	e9 cb 02 00 00       	jmp    ffffffff80107dc6 <trap+0x338>
  }

  switch(tf->trapno){
ffffffff80107afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107aff:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107b03:	48 83 e8 20          	sub    $0x20,%rax
ffffffff80107b07:	48 83 f8 1f          	cmp    $0x1f,%rax
ffffffff80107b0b:	0f 87 09 01 00 00    	ja     ffffffff80107c1a <trap+0x18c>
ffffffff80107b11:	48 8b 04 c5 f0 a0 10 	mov    -0x7fef5f10(,%rax,8),%rax
ffffffff80107b18:	80 
ffffffff80107b19:	3e ff e0             	notrack jmp *%rax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
ffffffff80107b1c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107b23:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b27:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107b2a:	84 c0                	test   %al,%al
ffffffff80107b2c:	75 71                	jne    ffffffff80107b9f <trap+0x111>
      acquire(&tickslock);
ffffffff80107b2e:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff80107b35:	e8 79 e2 ff ff       	call   ffffffff80105db3 <acquire>
      ticks++;
ffffffff80107b3a:	8b 05 a8 cd 00 00    	mov    0xcda8(%rip),%eax        # ffffffff801148e8 <ticks>
ffffffff80107b40:	83 c0 01             	add    $0x1,%eax
ffffffff80107b43:	89 05 9f cd 00 00    	mov    %eax,0xcd9f(%rip)        # ffffffff801148e8 <ticks>
      if (proc && (tf->cs & 3) == 3) {
ffffffff80107b49:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107b50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b54:	48 85 c0             	test   %rax,%rax
ffffffff80107b57:	74 2e                	je     ffffffff80107b87 <trap+0xf9>
ffffffff80107b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b5d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107b64:	83 e0 03             	and    $0x3,%eax
ffffffff80107b67:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107b6b:	75 1a                	jne    ffffffff80107b87 <trap+0xf9>
          proc->ticks++;
ffffffff80107b6d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107b74:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b78:	8b 90 e4 00 00 00    	mov    0xe4(%rax),%edx
ffffffff80107b7e:	83 c2 01             	add    $0x1,%edx
ffffffff80107b81:	89 90 e4 00 00 00    	mov    %edx,0xe4(%rax)
      }
      wakeup(&ticks);
ffffffff80107b87:	48 c7 c7 e8 48 11 80 	mov    $0xffffffff801148e8,%rdi
ffffffff80107b8e:	e8 a0 df ff ff       	call   ffffffff80105b33 <wakeup>
      release(&tickslock);
ffffffff80107b93:	48 c7 c7 80 48 11 80 	mov    $0xffffffff80114880,%rdi
ffffffff80107b9a:	e8 ef e2 ff ff       	call   ffffffff80105e8e <release>
    }
    lapiceoi();
ffffffff80107b9f:	e8 61 bc ff ff       	call   ffffffff80103805 <lapiceoi>
    break;
ffffffff80107ba4:	e9 6f 01 00 00       	jmp    ffffffff80107d18 <trap+0x28a>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffffffff80107ba9:	e8 53 b3 ff ff       	call   ffffffff80102f01 <ideintr>
    lapiceoi();
ffffffff80107bae:	e8 52 bc ff ff       	call   ffffffff80103805 <lapiceoi>
    break;
ffffffff80107bb3:	e9 60 01 00 00       	jmp    ffffffff80107d18 <trap+0x28a>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffffffff80107bb8:	e8 f0 b9 ff ff       	call   ffffffff801035ad <kbdintr>
    lapiceoi();
ffffffff80107bbd:	e8 43 bc ff ff       	call   ffffffff80103805 <lapiceoi>
    break;
ffffffff80107bc2:	e9 51 01 00 00       	jmp    ffffffff80107d18 <trap+0x28a>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffffffff80107bc7:	e8 df 03 00 00       	call   ffffffff80107fab <uartintr>
    lapiceoi();
ffffffff80107bcc:	e8 34 bc ff ff       	call   ffffffff80103805 <lapiceoi>
    break;
ffffffff80107bd1:	e9 42 01 00 00       	jmp    ffffffff80107d18 <trap+0x28a>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
ffffffff80107bd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107bda:	48 8b 88 88 00 00 00 	mov    0x88(%rax),%rcx
ffffffff80107be1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107be5:	48 8b 90 90 00 00 00 	mov    0x90(%rax),%rdx
            cpu->id, tf->cs, tf->eip);
ffffffff80107bec:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107bf3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107bf7:	0f b6 00             	movzbl (%rax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
ffffffff80107bfa:	0f b6 c0             	movzbl %al,%eax
ffffffff80107bfd:	89 c6                	mov    %eax,%esi
ffffffff80107bff:	48 c7 c7 48 a0 10 80 	mov    $0xffffffff8010a048,%rdi
ffffffff80107c06:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107c0b:	e8 b0 89 ff ff       	call   ffffffff801005c0 <cprintf>
    lapiceoi();
ffffffff80107c10:	e8 f0 bb ff ff       	call   ffffffff80103805 <lapiceoi>
    break;
ffffffff80107c15:	e9 fe 00 00 00       	jmp    ffffffff80107d18 <trap+0x28a>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffffffff80107c1a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c21:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c25:	48 85 c0             	test   %rax,%rax
ffffffff80107c28:	74 13                	je     ffffffff80107c3d <trap+0x1af>
ffffffff80107c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c2e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107c35:	83 e0 03             	and    $0x3,%eax
ffffffff80107c38:	48 85 c0             	test   %rax,%rax
ffffffff80107c3b:	75 4f                	jne    ffffffff80107c8c <trap+0x1fe>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
ffffffff80107c3d:	e8 37 fe ff ff       	call   ffffffff80107a79 <rcr2>
ffffffff80107c42:	48 89 c6             	mov    %rax,%rsi
ffffffff80107c45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c49:	48 8b 88 88 00 00 00 	mov    0x88(%rax),%rcx
              tf->trapno, cpu->id, tf->eip, rcr2());
ffffffff80107c50:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107c57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c5b:	0f b6 00             	movzbl (%rax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
ffffffff80107c5e:	0f b6 d0             	movzbl %al,%edx
ffffffff80107c61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c65:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107c69:	49 89 f0             	mov    %rsi,%r8
ffffffff80107c6c:	48 89 c6             	mov    %rax,%rsi
ffffffff80107c6f:	48 c7 c7 70 a0 10 80 	mov    $0xffffffff8010a070,%rdi
ffffffff80107c76:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107c7b:	e8 40 89 ff ff       	call   ffffffff801005c0 <cprintf>
      panic("trap");
ffffffff80107c80:	48 c7 c7 a2 a0 10 80 	mov    $0xffffffff8010a0a2,%rdi
ffffffff80107c87:	e8 c3 8c ff ff       	call   ffffffff8010094f <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107c8c:	e8 e8 fd ff ff       	call   ffffffff80107a79 <rcr2>
ffffffff80107c91:	48 89 c1             	mov    %rax,%rcx
ffffffff80107c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c98:	48 8b b8 88 00 00 00 	mov    0x88(%rax),%rdi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
ffffffff80107c9f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107ca6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107caa:	0f b6 00             	movzbl (%rax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107cad:	44 0f b6 c8          	movzbl %al,%r9d
ffffffff80107cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107cb5:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffffffff80107cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107cc0:	48 8b 50 78          	mov    0x78(%rax),%rdx
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
ffffffff80107cc4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107ccb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ccf:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffffffff80107cd6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107cdd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ce1:	8b 40 1c             	mov    0x1c(%rax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107ce4:	51                   	push   %rcx
ffffffff80107ce5:	57                   	push   %rdi
ffffffff80107ce6:	48 89 d1             	mov    %rdx,%rcx
ffffffff80107ce9:	48 89 f2             	mov    %rsi,%rdx
ffffffff80107cec:	89 c6                	mov    %eax,%esi
ffffffff80107cee:	48 c7 c7 a8 a0 10 80 	mov    $0xffffffff8010a0a8,%rdi
ffffffff80107cf5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107cfa:	e8 c1 88 ff ff       	call   ffffffff801005c0 <cprintf>
ffffffff80107cff:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
    proc->killed = 1;
ffffffff80107d03:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d0a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d0e:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffffffff80107d15:	eb 01                	jmp    ffffffff80107d18 <trap+0x28a>
    break;
ffffffff80107d17:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffffffff80107d18:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d1f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d23:	48 85 c0             	test   %rax,%rax
ffffffff80107d26:	74 2b                	je     ffffffff80107d53 <trap+0x2c5>
ffffffff80107d28:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d2f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d33:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107d36:	85 c0                	test   %eax,%eax
ffffffff80107d38:	74 19                	je     ffffffff80107d53 <trap+0x2c5>
ffffffff80107d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107d3e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107d45:	83 e0 03             	and    $0x3,%eax
ffffffff80107d48:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107d4c:	75 05                	jne    ffffffff80107d53 <trap+0x2c5>
    exit();
ffffffff80107d4e:	e8 cf d7 ff ff       	call   ffffffff80105522 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffffffff80107d53:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d5a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d5e:	48 85 c0             	test   %rax,%rax
ffffffff80107d61:	74 26                	je     ffffffff80107d89 <trap+0x2fb>
ffffffff80107d63:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d6a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d6e:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80107d71:	83 f8 04             	cmp    $0x4,%eax
ffffffff80107d74:	75 13                	jne    ffffffff80107d89 <trap+0x2fb>
ffffffff80107d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107d7a:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107d7e:	48 83 f8 20          	cmp    $0x20,%rax
ffffffff80107d82:	75 05                	jne    ffffffff80107d89 <trap+0x2fb>
    yield();
ffffffff80107d84:	e8 24 dc ff ff       	call   ffffffff801059ad <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffffffff80107d89:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107d90:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107d94:	48 85 c0             	test   %rax,%rax
ffffffff80107d97:	74 2e                	je     ffffffff80107dc7 <trap+0x339>
ffffffff80107d99:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107da0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107da4:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107da7:	85 c0                	test   %eax,%eax
ffffffff80107da9:	74 1c                	je     ffffffff80107dc7 <trap+0x339>
ffffffff80107dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107daf:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107db6:	83 e0 03             	and    $0x3,%eax
ffffffff80107db9:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107dbd:	75 08                	jne    ffffffff80107dc7 <trap+0x339>
    exit();
ffffffff80107dbf:	e8 5e d7 ff ff       	call   ffffffff80105522 <exit>
ffffffff80107dc4:	eb 01                	jmp    ffffffff80107dc7 <trap+0x339>
    return;
ffffffff80107dc6:	90                   	nop
}
ffffffff80107dc7:	c9                   	leave
ffffffff80107dc8:	c3                   	ret

ffffffff80107dc9 <inb>:
{
ffffffff80107dc9:	55                   	push   %rbp
ffffffff80107dca:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107dcd:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80107dd1:	89 f8                	mov    %edi,%eax
ffffffff80107dd3:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80107dd7:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80107ddb:	89 c2                	mov    %eax,%edx
ffffffff80107ddd:	ec                   	in     (%dx),%al
ffffffff80107dde:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80107de1:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80107de5:	c9                   	leave
ffffffff80107de6:	c3                   	ret

ffffffff80107de7 <outb>:
{
ffffffff80107de7:	55                   	push   %rbp
ffffffff80107de8:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107deb:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80107def:	89 fa                	mov    %edi,%edx
ffffffff80107df1:	89 f0                	mov    %esi,%eax
ffffffff80107df3:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80107df7:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80107dfa:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80107dfe:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80107e02:	ee                   	out    %al,(%dx)
}
ffffffff80107e03:	90                   	nop
ffffffff80107e04:	c9                   	leave
ffffffff80107e05:	c3                   	ret

ffffffff80107e06 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffffffff80107e06:	f3 0f 1e fa          	endbr64
ffffffff80107e0a:	55                   	push   %rbp
ffffffff80107e0b:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107e0e:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffffffff80107e12:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107e17:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffffffff80107e1c:	e8 c6 ff ff ff       	call   ffffffff80107de7 <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffffffff80107e21:	be 80 00 00 00       	mov    $0x80,%esi
ffffffff80107e26:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffffffff80107e2b:	e8 b7 ff ff ff       	call   ffffffff80107de7 <outb>
  outb(COM1+0, 115200/9600);
ffffffff80107e30:	be 0c 00 00 00       	mov    $0xc,%esi
ffffffff80107e35:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107e3a:	e8 a8 ff ff ff       	call   ffffffff80107de7 <outb>
  outb(COM1+1, 0);
ffffffff80107e3f:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107e44:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffffffff80107e49:	e8 99 ff ff ff       	call   ffffffff80107de7 <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffffffff80107e4e:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff80107e53:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffffffff80107e58:	e8 8a ff ff ff       	call   ffffffff80107de7 <outb>
  outb(COM1+4, 0);
ffffffff80107e5d:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107e62:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffffffff80107e67:	e8 7b ff ff ff       	call   ffffffff80107de7 <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffffffff80107e6c:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80107e71:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffffffff80107e76:	e8 6c ff ff ff       	call   ffffffff80107de7 <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffffffff80107e7b:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107e80:	e8 44 ff ff ff       	call   ffffffff80107dc9 <inb>
ffffffff80107e85:	3c ff                	cmp    $0xff,%al
ffffffff80107e87:	74 37                	je     ffffffff80107ec0 <uartearlyinit+0xba>
    return;
  uart = 1;
ffffffff80107e89:	c7 05 59 ca 00 00 01 	movl   $0x1,0xca59(%rip)        # ffffffff801148ec <uart>
ffffffff80107e90:	00 00 00 

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffffffff80107e93:	48 c7 45 f8 f0 a1 10 	movq   $0xffffffff8010a1f0,-0x8(%rbp)
ffffffff80107e9a:	80 
ffffffff80107e9b:	eb 16                	jmp    ffffffff80107eb3 <uartearlyinit+0xad>
    uartputc(*p);
ffffffff80107e9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107ea1:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107ea4:	0f be c0             	movsbl %al,%eax
ffffffff80107ea7:	89 c7                	mov    %eax,%edi
ffffffff80107ea9:	e8 59 00 00 00       	call   ffffffff80107f07 <uartputc>
  for(p="xv6...\n"; *p; p++)
ffffffff80107eae:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff80107eb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107eb7:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107eba:	84 c0                	test   %al,%al
ffffffff80107ebc:	75 df                	jne    ffffffff80107e9d <uartearlyinit+0x97>
ffffffff80107ebe:	eb 01                	jmp    ffffffff80107ec1 <uartearlyinit+0xbb>
    return;
ffffffff80107ec0:	90                   	nop
}
ffffffff80107ec1:	c9                   	leave
ffffffff80107ec2:	c3                   	ret

ffffffff80107ec3 <uartinit>:

void
uartinit(void)
{
ffffffff80107ec3:	f3 0f 1e fa          	endbr64
ffffffff80107ec7:	55                   	push   %rbp
ffffffff80107ec8:	48 89 e5             	mov    %rsp,%rbp
  if (!uart)
ffffffff80107ecb:	8b 05 1b ca 00 00    	mov    0xca1b(%rip),%eax        # ffffffff801148ec <uart>
ffffffff80107ed1:	85 c0                	test   %eax,%eax
ffffffff80107ed3:	74 2f                	je     ffffffff80107f04 <uartinit+0x41>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffffffff80107ed5:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffffffff80107eda:	e8 ea fe ff ff       	call   ffffffff80107dc9 <inb>
  inb(COM1+0);
ffffffff80107edf:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107ee4:	e8 e0 fe ff ff       	call   ffffffff80107dc9 <inb>
  picenable(IRQ_COM1);
ffffffff80107ee9:	bf 04 00 00 00       	mov    $0x4,%edi
ffffffff80107eee:	e8 a0 ca ff ff       	call   ffffffff80104993 <picenable>
  ioapicenable(IRQ_COM1, 0);
ffffffff80107ef3:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107ef8:	bf 04 00 00 00       	mov    $0x4,%edi
ffffffff80107efd:	e8 e0 b2 ff ff       	call   ffffffff801031e2 <ioapicenable>
ffffffff80107f02:	eb 01                	jmp    ffffffff80107f05 <uartinit+0x42>
    return;
ffffffff80107f04:	90                   	nop
}
ffffffff80107f05:	5d                   	pop    %rbp
ffffffff80107f06:	c3                   	ret

ffffffff80107f07 <uartputc>:

void
uartputc(int c)
{
ffffffff80107f07:	f3 0f 1e fa          	endbr64
ffffffff80107f0b:	55                   	push   %rbp
ffffffff80107f0c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107f0f:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80107f13:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffffffff80107f16:	8b 05 d0 c9 00 00    	mov    0xc9d0(%rip),%eax        # ffffffff801148ec <uart>
ffffffff80107f1c:	85 c0                	test   %eax,%eax
ffffffff80107f1e:	74 45                	je     ffffffff80107f65 <uartputc+0x5e>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffffffff80107f20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80107f27:	eb 0e                	jmp    ffffffff80107f37 <uartputc+0x30>
    microdelay(10);
ffffffff80107f29:	bf 0a 00 00 00       	mov    $0xa,%edi
ffffffff80107f2e:	e8 f8 b8 ff ff       	call   ffffffff8010382b <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffffffff80107f33:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80107f37:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80107f3b:	7f 14                	jg     ffffffff80107f51 <uartputc+0x4a>
ffffffff80107f3d:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107f42:	e8 82 fe ff ff       	call   ffffffff80107dc9 <inb>
ffffffff80107f47:	0f b6 c0             	movzbl %al,%eax
ffffffff80107f4a:	83 e0 20             	and    $0x20,%eax
ffffffff80107f4d:	85 c0                	test   %eax,%eax
ffffffff80107f4f:	74 d8                	je     ffffffff80107f29 <uartputc+0x22>
  outb(COM1+0, c);
ffffffff80107f51:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80107f54:	0f b6 c0             	movzbl %al,%eax
ffffffff80107f57:	89 c6                	mov    %eax,%esi
ffffffff80107f59:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107f5e:	e8 84 fe ff ff       	call   ffffffff80107de7 <outb>
ffffffff80107f63:	eb 01                	jmp    ffffffff80107f66 <uartputc+0x5f>
    return;
ffffffff80107f65:	90                   	nop
}
ffffffff80107f66:	c9                   	leave
ffffffff80107f67:	c3                   	ret

ffffffff80107f68 <uartgetc>:

static int
uartgetc(void)
{
ffffffff80107f68:	f3 0f 1e fa          	endbr64
ffffffff80107f6c:	55                   	push   %rbp
ffffffff80107f6d:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffffffff80107f70:	8b 05 76 c9 00 00    	mov    0xc976(%rip),%eax        # ffffffff801148ec <uart>
ffffffff80107f76:	85 c0                	test   %eax,%eax
ffffffff80107f78:	75 07                	jne    ffffffff80107f81 <uartgetc+0x19>
    return -1;
ffffffff80107f7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107f7f:	eb 28                	jmp    ffffffff80107fa9 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
ffffffff80107f81:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107f86:	e8 3e fe ff ff       	call   ffffffff80107dc9 <inb>
ffffffff80107f8b:	0f b6 c0             	movzbl %al,%eax
ffffffff80107f8e:	83 e0 01             	and    $0x1,%eax
ffffffff80107f91:	85 c0                	test   %eax,%eax
ffffffff80107f93:	75 07                	jne    ffffffff80107f9c <uartgetc+0x34>
    return -1;
ffffffff80107f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107f9a:	eb 0d                	jmp    ffffffff80107fa9 <uartgetc+0x41>
  return inb(COM1+0);
ffffffff80107f9c:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107fa1:	e8 23 fe ff ff       	call   ffffffff80107dc9 <inb>
ffffffff80107fa6:	0f b6 c0             	movzbl %al,%eax
}
ffffffff80107fa9:	5d                   	pop    %rbp
ffffffff80107faa:	c3                   	ret

ffffffff80107fab <uartintr>:

void
uartintr(void)
{
ffffffff80107fab:	f3 0f 1e fa          	endbr64
ffffffff80107faf:	55                   	push   %rbp
ffffffff80107fb0:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffffffff80107fb3:	48 c7 c7 68 7f 10 80 	mov    $0xffffffff80107f68,%rdi
ffffffff80107fba:	e8 30 8c ff ff       	call   ffffffff80100bef <consoleintr>
}
ffffffff80107fbf:	90                   	nop
ffffffff80107fc0:	5d                   	pop    %rbp
ffffffff80107fc1:	c3                   	ret

ffffffff80107fc2 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  push $0
ffffffff80107fc2:	6a 00                	push   $0x0
  push $0
ffffffff80107fc4:	6a 00                	push   $0x0
  jmp alltraps
ffffffff80107fc6:	e9 72 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107fcb <vector1>:
.globl vector1
vector1:
  push $0
ffffffff80107fcb:	6a 00                	push   $0x0
  push $1
ffffffff80107fcd:	6a 01                	push   $0x1
  jmp alltraps
ffffffff80107fcf:	e9 69 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107fd4 <vector2>:
.globl vector2
vector2:
  push $0
ffffffff80107fd4:	6a 00                	push   $0x0
  push $2
ffffffff80107fd6:	6a 02                	push   $0x2
  jmp alltraps
ffffffff80107fd8:	e9 60 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107fdd <vector3>:
.globl vector3
vector3:
  push $0
ffffffff80107fdd:	6a 00                	push   $0x0
  push $3
ffffffff80107fdf:	6a 03                	push   $0x3
  jmp alltraps
ffffffff80107fe1:	e9 57 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107fe6 <vector4>:
.globl vector4
vector4:
  push $0
ffffffff80107fe6:	6a 00                	push   $0x0
  push $4
ffffffff80107fe8:	6a 04                	push   $0x4
  jmp alltraps
ffffffff80107fea:	e9 4e fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107fef <vector5>:
.globl vector5
vector5:
  push $0
ffffffff80107fef:	6a 00                	push   $0x0
  push $5
ffffffff80107ff1:	6a 05                	push   $0x5
  jmp alltraps
ffffffff80107ff3:	e9 45 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80107ff8 <vector6>:
.globl vector6
vector6:
  push $0
ffffffff80107ff8:	6a 00                	push   $0x0
  push $6
ffffffff80107ffa:	6a 06                	push   $0x6
  jmp alltraps
ffffffff80107ffc:	e9 3c fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108001 <vector7>:
.globl vector7
vector7:
  push $0
ffffffff80108001:	6a 00                	push   $0x0
  push $7
ffffffff80108003:	6a 07                	push   $0x7
  jmp alltraps
ffffffff80108005:	e9 33 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010800a <vector8>:
.globl vector8
vector8:
  push $8
ffffffff8010800a:	6a 08                	push   $0x8
  jmp alltraps
ffffffff8010800c:	e9 2c fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108011 <vector9>:
.globl vector9
vector9:
  push $0
ffffffff80108011:	6a 00                	push   $0x0
  push $9
ffffffff80108013:	6a 09                	push   $0x9
  jmp alltraps
ffffffff80108015:	e9 23 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010801a <vector10>:
.globl vector10
vector10:
  push $10
ffffffff8010801a:	6a 0a                	push   $0xa
  jmp alltraps
ffffffff8010801c:	e9 1c fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108021 <vector11>:
.globl vector11
vector11:
  push $11
ffffffff80108021:	6a 0b                	push   $0xb
  jmp alltraps
ffffffff80108023:	e9 15 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108028 <vector12>:
.globl vector12
vector12:
  push $12
ffffffff80108028:	6a 0c                	push   $0xc
  jmp alltraps
ffffffff8010802a:	e9 0e fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010802f <vector13>:
.globl vector13
vector13:
  push $13
ffffffff8010802f:	6a 0d                	push   $0xd
  jmp alltraps
ffffffff80108031:	e9 07 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108036 <vector14>:
.globl vector14
vector14:
  push $14
ffffffff80108036:	6a 0e                	push   $0xe
  jmp alltraps
ffffffff80108038:	e9 00 fa ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010803d <vector15>:
.globl vector15
vector15:
  push $0
ffffffff8010803d:	6a 00                	push   $0x0
  push $15
ffffffff8010803f:	6a 0f                	push   $0xf
  jmp alltraps
ffffffff80108041:	e9 f7 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108046 <vector16>:
.globl vector16
vector16:
  push $0
ffffffff80108046:	6a 00                	push   $0x0
  push $16
ffffffff80108048:	6a 10                	push   $0x10
  jmp alltraps
ffffffff8010804a:	e9 ee f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010804f <vector17>:
.globl vector17
vector17:
  push $17
ffffffff8010804f:	6a 11                	push   $0x11
  jmp alltraps
ffffffff80108051:	e9 e7 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108056 <vector18>:
.globl vector18
vector18:
  push $0
ffffffff80108056:	6a 00                	push   $0x0
  push $18
ffffffff80108058:	6a 12                	push   $0x12
  jmp alltraps
ffffffff8010805a:	e9 de f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010805f <vector19>:
.globl vector19
vector19:
  push $0
ffffffff8010805f:	6a 00                	push   $0x0
  push $19
ffffffff80108061:	6a 13                	push   $0x13
  jmp alltraps
ffffffff80108063:	e9 d5 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108068 <vector20>:
.globl vector20
vector20:
  push $0
ffffffff80108068:	6a 00                	push   $0x0
  push $20
ffffffff8010806a:	6a 14                	push   $0x14
  jmp alltraps
ffffffff8010806c:	e9 cc f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108071 <vector21>:
.globl vector21
vector21:
  push $0
ffffffff80108071:	6a 00                	push   $0x0
  push $21
ffffffff80108073:	6a 15                	push   $0x15
  jmp alltraps
ffffffff80108075:	e9 c3 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010807a <vector22>:
.globl vector22
vector22:
  push $0
ffffffff8010807a:	6a 00                	push   $0x0
  push $22
ffffffff8010807c:	6a 16                	push   $0x16
  jmp alltraps
ffffffff8010807e:	e9 ba f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108083 <vector23>:
.globl vector23
vector23:
  push $0
ffffffff80108083:	6a 00                	push   $0x0
  push $23
ffffffff80108085:	6a 17                	push   $0x17
  jmp alltraps
ffffffff80108087:	e9 b1 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010808c <vector24>:
.globl vector24
vector24:
  push $0
ffffffff8010808c:	6a 00                	push   $0x0
  push $24
ffffffff8010808e:	6a 18                	push   $0x18
  jmp alltraps
ffffffff80108090:	e9 a8 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108095 <vector25>:
.globl vector25
vector25:
  push $0
ffffffff80108095:	6a 00                	push   $0x0
  push $25
ffffffff80108097:	6a 19                	push   $0x19
  jmp alltraps
ffffffff80108099:	e9 9f f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010809e <vector26>:
.globl vector26
vector26:
  push $0
ffffffff8010809e:	6a 00                	push   $0x0
  push $26
ffffffff801080a0:	6a 1a                	push   $0x1a
  jmp alltraps
ffffffff801080a2:	e9 96 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080a7 <vector27>:
.globl vector27
vector27:
  push $0
ffffffff801080a7:	6a 00                	push   $0x0
  push $27
ffffffff801080a9:	6a 1b                	push   $0x1b
  jmp alltraps
ffffffff801080ab:	e9 8d f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080b0 <vector28>:
.globl vector28
vector28:
  push $0
ffffffff801080b0:	6a 00                	push   $0x0
  push $28
ffffffff801080b2:	6a 1c                	push   $0x1c
  jmp alltraps
ffffffff801080b4:	e9 84 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080b9 <vector29>:
.globl vector29
vector29:
  push $0
ffffffff801080b9:	6a 00                	push   $0x0
  push $29
ffffffff801080bb:	6a 1d                	push   $0x1d
  jmp alltraps
ffffffff801080bd:	e9 7b f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080c2 <vector30>:
.globl vector30
vector30:
  push $0
ffffffff801080c2:	6a 00                	push   $0x0
  push $30
ffffffff801080c4:	6a 1e                	push   $0x1e
  jmp alltraps
ffffffff801080c6:	e9 72 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080cb <vector31>:
.globl vector31
vector31:
  push $0
ffffffff801080cb:	6a 00                	push   $0x0
  push $31
ffffffff801080cd:	6a 1f                	push   $0x1f
  jmp alltraps
ffffffff801080cf:	e9 69 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080d4 <vector32>:
.globl vector32
vector32:
  push $0
ffffffff801080d4:	6a 00                	push   $0x0
  push $32
ffffffff801080d6:	6a 20                	push   $0x20
  jmp alltraps
ffffffff801080d8:	e9 60 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080dd <vector33>:
.globl vector33
vector33:
  push $0
ffffffff801080dd:	6a 00                	push   $0x0
  push $33
ffffffff801080df:	6a 21                	push   $0x21
  jmp alltraps
ffffffff801080e1:	e9 57 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080e6 <vector34>:
.globl vector34
vector34:
  push $0
ffffffff801080e6:	6a 00                	push   $0x0
  push $34
ffffffff801080e8:	6a 22                	push   $0x22
  jmp alltraps
ffffffff801080ea:	e9 4e f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080ef <vector35>:
.globl vector35
vector35:
  push $0
ffffffff801080ef:	6a 00                	push   $0x0
  push $35
ffffffff801080f1:	6a 23                	push   $0x23
  jmp alltraps
ffffffff801080f3:	e9 45 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801080f8 <vector36>:
.globl vector36
vector36:
  push $0
ffffffff801080f8:	6a 00                	push   $0x0
  push $36
ffffffff801080fa:	6a 24                	push   $0x24
  jmp alltraps
ffffffff801080fc:	e9 3c f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108101 <vector37>:
.globl vector37
vector37:
  push $0
ffffffff80108101:	6a 00                	push   $0x0
  push $37
ffffffff80108103:	6a 25                	push   $0x25
  jmp alltraps
ffffffff80108105:	e9 33 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010810a <vector38>:
.globl vector38
vector38:
  push $0
ffffffff8010810a:	6a 00                	push   $0x0
  push $38
ffffffff8010810c:	6a 26                	push   $0x26
  jmp alltraps
ffffffff8010810e:	e9 2a f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108113 <vector39>:
.globl vector39
vector39:
  push $0
ffffffff80108113:	6a 00                	push   $0x0
  push $39
ffffffff80108115:	6a 27                	push   $0x27
  jmp alltraps
ffffffff80108117:	e9 21 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010811c <vector40>:
.globl vector40
vector40:
  push $0
ffffffff8010811c:	6a 00                	push   $0x0
  push $40
ffffffff8010811e:	6a 28                	push   $0x28
  jmp alltraps
ffffffff80108120:	e9 18 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108125 <vector41>:
.globl vector41
vector41:
  push $0
ffffffff80108125:	6a 00                	push   $0x0
  push $41
ffffffff80108127:	6a 29                	push   $0x29
  jmp alltraps
ffffffff80108129:	e9 0f f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010812e <vector42>:
.globl vector42
vector42:
  push $0
ffffffff8010812e:	6a 00                	push   $0x0
  push $42
ffffffff80108130:	6a 2a                	push   $0x2a
  jmp alltraps
ffffffff80108132:	e9 06 f9 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108137 <vector43>:
.globl vector43
vector43:
  push $0
ffffffff80108137:	6a 00                	push   $0x0
  push $43
ffffffff80108139:	6a 2b                	push   $0x2b
  jmp alltraps
ffffffff8010813b:	e9 fd f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108140 <vector44>:
.globl vector44
vector44:
  push $0
ffffffff80108140:	6a 00                	push   $0x0
  push $44
ffffffff80108142:	6a 2c                	push   $0x2c
  jmp alltraps
ffffffff80108144:	e9 f4 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108149 <vector45>:
.globl vector45
vector45:
  push $0
ffffffff80108149:	6a 00                	push   $0x0
  push $45
ffffffff8010814b:	6a 2d                	push   $0x2d
  jmp alltraps
ffffffff8010814d:	e9 eb f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108152 <vector46>:
.globl vector46
vector46:
  push $0
ffffffff80108152:	6a 00                	push   $0x0
  push $46
ffffffff80108154:	6a 2e                	push   $0x2e
  jmp alltraps
ffffffff80108156:	e9 e2 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010815b <vector47>:
.globl vector47
vector47:
  push $0
ffffffff8010815b:	6a 00                	push   $0x0
  push $47
ffffffff8010815d:	6a 2f                	push   $0x2f
  jmp alltraps
ffffffff8010815f:	e9 d9 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108164 <vector48>:
.globl vector48
vector48:
  push $0
ffffffff80108164:	6a 00                	push   $0x0
  push $48
ffffffff80108166:	6a 30                	push   $0x30
  jmp alltraps
ffffffff80108168:	e9 d0 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010816d <vector49>:
.globl vector49
vector49:
  push $0
ffffffff8010816d:	6a 00                	push   $0x0
  push $49
ffffffff8010816f:	6a 31                	push   $0x31
  jmp alltraps
ffffffff80108171:	e9 c7 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108176 <vector50>:
.globl vector50
vector50:
  push $0
ffffffff80108176:	6a 00                	push   $0x0
  push $50
ffffffff80108178:	6a 32                	push   $0x32
  jmp alltraps
ffffffff8010817a:	e9 be f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010817f <vector51>:
.globl vector51
vector51:
  push $0
ffffffff8010817f:	6a 00                	push   $0x0
  push $51
ffffffff80108181:	6a 33                	push   $0x33
  jmp alltraps
ffffffff80108183:	e9 b5 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108188 <vector52>:
.globl vector52
vector52:
  push $0
ffffffff80108188:	6a 00                	push   $0x0
  push $52
ffffffff8010818a:	6a 34                	push   $0x34
  jmp alltraps
ffffffff8010818c:	e9 ac f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108191 <vector53>:
.globl vector53
vector53:
  push $0
ffffffff80108191:	6a 00                	push   $0x0
  push $53
ffffffff80108193:	6a 35                	push   $0x35
  jmp alltraps
ffffffff80108195:	e9 a3 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010819a <vector54>:
.globl vector54
vector54:
  push $0
ffffffff8010819a:	6a 00                	push   $0x0
  push $54
ffffffff8010819c:	6a 36                	push   $0x36
  jmp alltraps
ffffffff8010819e:	e9 9a f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081a3 <vector55>:
.globl vector55
vector55:
  push $0
ffffffff801081a3:	6a 00                	push   $0x0
  push $55
ffffffff801081a5:	6a 37                	push   $0x37
  jmp alltraps
ffffffff801081a7:	e9 91 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081ac <vector56>:
.globl vector56
vector56:
  push $0
ffffffff801081ac:	6a 00                	push   $0x0
  push $56
ffffffff801081ae:	6a 38                	push   $0x38
  jmp alltraps
ffffffff801081b0:	e9 88 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081b5 <vector57>:
.globl vector57
vector57:
  push $0
ffffffff801081b5:	6a 00                	push   $0x0
  push $57
ffffffff801081b7:	6a 39                	push   $0x39
  jmp alltraps
ffffffff801081b9:	e9 7f f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081be <vector58>:
.globl vector58
vector58:
  push $0
ffffffff801081be:	6a 00                	push   $0x0
  push $58
ffffffff801081c0:	6a 3a                	push   $0x3a
  jmp alltraps
ffffffff801081c2:	e9 76 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081c7 <vector59>:
.globl vector59
vector59:
  push $0
ffffffff801081c7:	6a 00                	push   $0x0
  push $59
ffffffff801081c9:	6a 3b                	push   $0x3b
  jmp alltraps
ffffffff801081cb:	e9 6d f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081d0 <vector60>:
.globl vector60
vector60:
  push $0
ffffffff801081d0:	6a 00                	push   $0x0
  push $60
ffffffff801081d2:	6a 3c                	push   $0x3c
  jmp alltraps
ffffffff801081d4:	e9 64 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081d9 <vector61>:
.globl vector61
vector61:
  push $0
ffffffff801081d9:	6a 00                	push   $0x0
  push $61
ffffffff801081db:	6a 3d                	push   $0x3d
  jmp alltraps
ffffffff801081dd:	e9 5b f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081e2 <vector62>:
.globl vector62
vector62:
  push $0
ffffffff801081e2:	6a 00                	push   $0x0
  push $62
ffffffff801081e4:	6a 3e                	push   $0x3e
  jmp alltraps
ffffffff801081e6:	e9 52 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081eb <vector63>:
.globl vector63
vector63:
  push $0
ffffffff801081eb:	6a 00                	push   $0x0
  push $63
ffffffff801081ed:	6a 3f                	push   $0x3f
  jmp alltraps
ffffffff801081ef:	e9 49 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081f4 <vector64>:
.globl vector64
vector64:
  push $0
ffffffff801081f4:	6a 00                	push   $0x0
  push $64
ffffffff801081f6:	6a 40                	push   $0x40
  jmp alltraps
ffffffff801081f8:	e9 40 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801081fd <vector65>:
.globl vector65
vector65:
  push $0
ffffffff801081fd:	6a 00                	push   $0x0
  push $65
ffffffff801081ff:	6a 41                	push   $0x41
  jmp alltraps
ffffffff80108201:	e9 37 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108206 <vector66>:
.globl vector66
vector66:
  push $0
ffffffff80108206:	6a 00                	push   $0x0
  push $66
ffffffff80108208:	6a 42                	push   $0x42
  jmp alltraps
ffffffff8010820a:	e9 2e f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010820f <vector67>:
.globl vector67
vector67:
  push $0
ffffffff8010820f:	6a 00                	push   $0x0
  push $67
ffffffff80108211:	6a 43                	push   $0x43
  jmp alltraps
ffffffff80108213:	e9 25 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108218 <vector68>:
.globl vector68
vector68:
  push $0
ffffffff80108218:	6a 00                	push   $0x0
  push $68
ffffffff8010821a:	6a 44                	push   $0x44
  jmp alltraps
ffffffff8010821c:	e9 1c f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108221 <vector69>:
.globl vector69
vector69:
  push $0
ffffffff80108221:	6a 00                	push   $0x0
  push $69
ffffffff80108223:	6a 45                	push   $0x45
  jmp alltraps
ffffffff80108225:	e9 13 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010822a <vector70>:
.globl vector70
vector70:
  push $0
ffffffff8010822a:	6a 00                	push   $0x0
  push $70
ffffffff8010822c:	6a 46                	push   $0x46
  jmp alltraps
ffffffff8010822e:	e9 0a f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108233 <vector71>:
.globl vector71
vector71:
  push $0
ffffffff80108233:	6a 00                	push   $0x0
  push $71
ffffffff80108235:	6a 47                	push   $0x47
  jmp alltraps
ffffffff80108237:	e9 01 f8 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010823c <vector72>:
.globl vector72
vector72:
  push $0
ffffffff8010823c:	6a 00                	push   $0x0
  push $72
ffffffff8010823e:	6a 48                	push   $0x48
  jmp alltraps
ffffffff80108240:	e9 f8 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108245 <vector73>:
.globl vector73
vector73:
  push $0
ffffffff80108245:	6a 00                	push   $0x0
  push $73
ffffffff80108247:	6a 49                	push   $0x49
  jmp alltraps
ffffffff80108249:	e9 ef f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010824e <vector74>:
.globl vector74
vector74:
  push $0
ffffffff8010824e:	6a 00                	push   $0x0
  push $74
ffffffff80108250:	6a 4a                	push   $0x4a
  jmp alltraps
ffffffff80108252:	e9 e6 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108257 <vector75>:
.globl vector75
vector75:
  push $0
ffffffff80108257:	6a 00                	push   $0x0
  push $75
ffffffff80108259:	6a 4b                	push   $0x4b
  jmp alltraps
ffffffff8010825b:	e9 dd f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108260 <vector76>:
.globl vector76
vector76:
  push $0
ffffffff80108260:	6a 00                	push   $0x0
  push $76
ffffffff80108262:	6a 4c                	push   $0x4c
  jmp alltraps
ffffffff80108264:	e9 d4 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108269 <vector77>:
.globl vector77
vector77:
  push $0
ffffffff80108269:	6a 00                	push   $0x0
  push $77
ffffffff8010826b:	6a 4d                	push   $0x4d
  jmp alltraps
ffffffff8010826d:	e9 cb f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108272 <vector78>:
.globl vector78
vector78:
  push $0
ffffffff80108272:	6a 00                	push   $0x0
  push $78
ffffffff80108274:	6a 4e                	push   $0x4e
  jmp alltraps
ffffffff80108276:	e9 c2 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010827b <vector79>:
.globl vector79
vector79:
  push $0
ffffffff8010827b:	6a 00                	push   $0x0
  push $79
ffffffff8010827d:	6a 4f                	push   $0x4f
  jmp alltraps
ffffffff8010827f:	e9 b9 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108284 <vector80>:
.globl vector80
vector80:
  push $0
ffffffff80108284:	6a 00                	push   $0x0
  push $80
ffffffff80108286:	6a 50                	push   $0x50
  jmp alltraps
ffffffff80108288:	e9 b0 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010828d <vector81>:
.globl vector81
vector81:
  push $0
ffffffff8010828d:	6a 00                	push   $0x0
  push $81
ffffffff8010828f:	6a 51                	push   $0x51
  jmp alltraps
ffffffff80108291:	e9 a7 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108296 <vector82>:
.globl vector82
vector82:
  push $0
ffffffff80108296:	6a 00                	push   $0x0
  push $82
ffffffff80108298:	6a 52                	push   $0x52
  jmp alltraps
ffffffff8010829a:	e9 9e f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010829f <vector83>:
.globl vector83
vector83:
  push $0
ffffffff8010829f:	6a 00                	push   $0x0
  push $83
ffffffff801082a1:	6a 53                	push   $0x53
  jmp alltraps
ffffffff801082a3:	e9 95 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082a8 <vector84>:
.globl vector84
vector84:
  push $0
ffffffff801082a8:	6a 00                	push   $0x0
  push $84
ffffffff801082aa:	6a 54                	push   $0x54
  jmp alltraps
ffffffff801082ac:	e9 8c f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082b1 <vector85>:
.globl vector85
vector85:
  push $0
ffffffff801082b1:	6a 00                	push   $0x0
  push $85
ffffffff801082b3:	6a 55                	push   $0x55
  jmp alltraps
ffffffff801082b5:	e9 83 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082ba <vector86>:
.globl vector86
vector86:
  push $0
ffffffff801082ba:	6a 00                	push   $0x0
  push $86
ffffffff801082bc:	6a 56                	push   $0x56
  jmp alltraps
ffffffff801082be:	e9 7a f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082c3 <vector87>:
.globl vector87
vector87:
  push $0
ffffffff801082c3:	6a 00                	push   $0x0
  push $87
ffffffff801082c5:	6a 57                	push   $0x57
  jmp alltraps
ffffffff801082c7:	e9 71 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082cc <vector88>:
.globl vector88
vector88:
  push $0
ffffffff801082cc:	6a 00                	push   $0x0
  push $88
ffffffff801082ce:	6a 58                	push   $0x58
  jmp alltraps
ffffffff801082d0:	e9 68 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082d5 <vector89>:
.globl vector89
vector89:
  push $0
ffffffff801082d5:	6a 00                	push   $0x0
  push $89
ffffffff801082d7:	6a 59                	push   $0x59
  jmp alltraps
ffffffff801082d9:	e9 5f f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082de <vector90>:
.globl vector90
vector90:
  push $0
ffffffff801082de:	6a 00                	push   $0x0
  push $90
ffffffff801082e0:	6a 5a                	push   $0x5a
  jmp alltraps
ffffffff801082e2:	e9 56 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082e7 <vector91>:
.globl vector91
vector91:
  push $0
ffffffff801082e7:	6a 00                	push   $0x0
  push $91
ffffffff801082e9:	6a 5b                	push   $0x5b
  jmp alltraps
ffffffff801082eb:	e9 4d f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082f0 <vector92>:
.globl vector92
vector92:
  push $0
ffffffff801082f0:	6a 00                	push   $0x0
  push $92
ffffffff801082f2:	6a 5c                	push   $0x5c
  jmp alltraps
ffffffff801082f4:	e9 44 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801082f9 <vector93>:
.globl vector93
vector93:
  push $0
ffffffff801082f9:	6a 00                	push   $0x0
  push $93
ffffffff801082fb:	6a 5d                	push   $0x5d
  jmp alltraps
ffffffff801082fd:	e9 3b f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108302 <vector94>:
.globl vector94
vector94:
  push $0
ffffffff80108302:	6a 00                	push   $0x0
  push $94
ffffffff80108304:	6a 5e                	push   $0x5e
  jmp alltraps
ffffffff80108306:	e9 32 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010830b <vector95>:
.globl vector95
vector95:
  push $0
ffffffff8010830b:	6a 00                	push   $0x0
  push $95
ffffffff8010830d:	6a 5f                	push   $0x5f
  jmp alltraps
ffffffff8010830f:	e9 29 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108314 <vector96>:
.globl vector96
vector96:
  push $0
ffffffff80108314:	6a 00                	push   $0x0
  push $96
ffffffff80108316:	6a 60                	push   $0x60
  jmp alltraps
ffffffff80108318:	e9 20 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010831d <vector97>:
.globl vector97
vector97:
  push $0
ffffffff8010831d:	6a 00                	push   $0x0
  push $97
ffffffff8010831f:	6a 61                	push   $0x61
  jmp alltraps
ffffffff80108321:	e9 17 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108326 <vector98>:
.globl vector98
vector98:
  push $0
ffffffff80108326:	6a 00                	push   $0x0
  push $98
ffffffff80108328:	6a 62                	push   $0x62
  jmp alltraps
ffffffff8010832a:	e9 0e f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010832f <vector99>:
.globl vector99
vector99:
  push $0
ffffffff8010832f:	6a 00                	push   $0x0
  push $99
ffffffff80108331:	6a 63                	push   $0x63
  jmp alltraps
ffffffff80108333:	e9 05 f7 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108338 <vector100>:
.globl vector100
vector100:
  push $0
ffffffff80108338:	6a 00                	push   $0x0
  push $100
ffffffff8010833a:	6a 64                	push   $0x64
  jmp alltraps
ffffffff8010833c:	e9 fc f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108341 <vector101>:
.globl vector101
vector101:
  push $0
ffffffff80108341:	6a 00                	push   $0x0
  push $101
ffffffff80108343:	6a 65                	push   $0x65
  jmp alltraps
ffffffff80108345:	e9 f3 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010834a <vector102>:
.globl vector102
vector102:
  push $0
ffffffff8010834a:	6a 00                	push   $0x0
  push $102
ffffffff8010834c:	6a 66                	push   $0x66
  jmp alltraps
ffffffff8010834e:	e9 ea f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108353 <vector103>:
.globl vector103
vector103:
  push $0
ffffffff80108353:	6a 00                	push   $0x0
  push $103
ffffffff80108355:	6a 67                	push   $0x67
  jmp alltraps
ffffffff80108357:	e9 e1 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010835c <vector104>:
.globl vector104
vector104:
  push $0
ffffffff8010835c:	6a 00                	push   $0x0
  push $104
ffffffff8010835e:	6a 68                	push   $0x68
  jmp alltraps
ffffffff80108360:	e9 d8 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108365 <vector105>:
.globl vector105
vector105:
  push $0
ffffffff80108365:	6a 00                	push   $0x0
  push $105
ffffffff80108367:	6a 69                	push   $0x69
  jmp alltraps
ffffffff80108369:	e9 cf f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010836e <vector106>:
.globl vector106
vector106:
  push $0
ffffffff8010836e:	6a 00                	push   $0x0
  push $106
ffffffff80108370:	6a 6a                	push   $0x6a
  jmp alltraps
ffffffff80108372:	e9 c6 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108377 <vector107>:
.globl vector107
vector107:
  push $0
ffffffff80108377:	6a 00                	push   $0x0
  push $107
ffffffff80108379:	6a 6b                	push   $0x6b
  jmp alltraps
ffffffff8010837b:	e9 bd f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108380 <vector108>:
.globl vector108
vector108:
  push $0
ffffffff80108380:	6a 00                	push   $0x0
  push $108
ffffffff80108382:	6a 6c                	push   $0x6c
  jmp alltraps
ffffffff80108384:	e9 b4 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108389 <vector109>:
.globl vector109
vector109:
  push $0
ffffffff80108389:	6a 00                	push   $0x0
  push $109
ffffffff8010838b:	6a 6d                	push   $0x6d
  jmp alltraps
ffffffff8010838d:	e9 ab f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108392 <vector110>:
.globl vector110
vector110:
  push $0
ffffffff80108392:	6a 00                	push   $0x0
  push $110
ffffffff80108394:	6a 6e                	push   $0x6e
  jmp alltraps
ffffffff80108396:	e9 a2 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010839b <vector111>:
.globl vector111
vector111:
  push $0
ffffffff8010839b:	6a 00                	push   $0x0
  push $111
ffffffff8010839d:	6a 6f                	push   $0x6f
  jmp alltraps
ffffffff8010839f:	e9 99 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083a4 <vector112>:
.globl vector112
vector112:
  push $0
ffffffff801083a4:	6a 00                	push   $0x0
  push $112
ffffffff801083a6:	6a 70                	push   $0x70
  jmp alltraps
ffffffff801083a8:	e9 90 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083ad <vector113>:
.globl vector113
vector113:
  push $0
ffffffff801083ad:	6a 00                	push   $0x0
  push $113
ffffffff801083af:	6a 71                	push   $0x71
  jmp alltraps
ffffffff801083b1:	e9 87 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083b6 <vector114>:
.globl vector114
vector114:
  push $0
ffffffff801083b6:	6a 00                	push   $0x0
  push $114
ffffffff801083b8:	6a 72                	push   $0x72
  jmp alltraps
ffffffff801083ba:	e9 7e f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083bf <vector115>:
.globl vector115
vector115:
  push $0
ffffffff801083bf:	6a 00                	push   $0x0
  push $115
ffffffff801083c1:	6a 73                	push   $0x73
  jmp alltraps
ffffffff801083c3:	e9 75 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083c8 <vector116>:
.globl vector116
vector116:
  push $0
ffffffff801083c8:	6a 00                	push   $0x0
  push $116
ffffffff801083ca:	6a 74                	push   $0x74
  jmp alltraps
ffffffff801083cc:	e9 6c f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083d1 <vector117>:
.globl vector117
vector117:
  push $0
ffffffff801083d1:	6a 00                	push   $0x0
  push $117
ffffffff801083d3:	6a 75                	push   $0x75
  jmp alltraps
ffffffff801083d5:	e9 63 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083da <vector118>:
.globl vector118
vector118:
  push $0
ffffffff801083da:	6a 00                	push   $0x0
  push $118
ffffffff801083dc:	6a 76                	push   $0x76
  jmp alltraps
ffffffff801083de:	e9 5a f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083e3 <vector119>:
.globl vector119
vector119:
  push $0
ffffffff801083e3:	6a 00                	push   $0x0
  push $119
ffffffff801083e5:	6a 77                	push   $0x77
  jmp alltraps
ffffffff801083e7:	e9 51 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083ec <vector120>:
.globl vector120
vector120:
  push $0
ffffffff801083ec:	6a 00                	push   $0x0
  push $120
ffffffff801083ee:	6a 78                	push   $0x78
  jmp alltraps
ffffffff801083f0:	e9 48 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083f5 <vector121>:
.globl vector121
vector121:
  push $0
ffffffff801083f5:	6a 00                	push   $0x0
  push $121
ffffffff801083f7:	6a 79                	push   $0x79
  jmp alltraps
ffffffff801083f9:	e9 3f f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801083fe <vector122>:
.globl vector122
vector122:
  push $0
ffffffff801083fe:	6a 00                	push   $0x0
  push $122
ffffffff80108400:	6a 7a                	push   $0x7a
  jmp alltraps
ffffffff80108402:	e9 36 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108407 <vector123>:
.globl vector123
vector123:
  push $0
ffffffff80108407:	6a 00                	push   $0x0
  push $123
ffffffff80108409:	6a 7b                	push   $0x7b
  jmp alltraps
ffffffff8010840b:	e9 2d f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108410 <vector124>:
.globl vector124
vector124:
  push $0
ffffffff80108410:	6a 00                	push   $0x0
  push $124
ffffffff80108412:	6a 7c                	push   $0x7c
  jmp alltraps
ffffffff80108414:	e9 24 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108419 <vector125>:
.globl vector125
vector125:
  push $0
ffffffff80108419:	6a 00                	push   $0x0
  push $125
ffffffff8010841b:	6a 7d                	push   $0x7d
  jmp alltraps
ffffffff8010841d:	e9 1b f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108422 <vector126>:
.globl vector126
vector126:
  push $0
ffffffff80108422:	6a 00                	push   $0x0
  push $126
ffffffff80108424:	6a 7e                	push   $0x7e
  jmp alltraps
ffffffff80108426:	e9 12 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010842b <vector127>:
.globl vector127
vector127:
  push $0
ffffffff8010842b:	6a 00                	push   $0x0
  push $127
ffffffff8010842d:	6a 7f                	push   $0x7f
  jmp alltraps
ffffffff8010842f:	e9 09 f6 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108434 <vector128>:
.globl vector128
vector128:
  push $0
ffffffff80108434:	6a 00                	push   $0x0
  push $128
ffffffff80108436:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffffffff8010843b:	e9 fd f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108440 <vector129>:
.globl vector129
vector129:
  push $0
ffffffff80108440:	6a 00                	push   $0x0
  push $129
ffffffff80108442:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffffffff80108447:	e9 f1 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010844c <vector130>:
.globl vector130
vector130:
  push $0
ffffffff8010844c:	6a 00                	push   $0x0
  push $130
ffffffff8010844e:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffffffff80108453:	e9 e5 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108458 <vector131>:
.globl vector131
vector131:
  push $0
ffffffff80108458:	6a 00                	push   $0x0
  push $131
ffffffff8010845a:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffffffff8010845f:	e9 d9 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108464 <vector132>:
.globl vector132
vector132:
  push $0
ffffffff80108464:	6a 00                	push   $0x0
  push $132
ffffffff80108466:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffffffff8010846b:	e9 cd f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108470 <vector133>:
.globl vector133
vector133:
  push $0
ffffffff80108470:	6a 00                	push   $0x0
  push $133
ffffffff80108472:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffffffff80108477:	e9 c1 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010847c <vector134>:
.globl vector134
vector134:
  push $0
ffffffff8010847c:	6a 00                	push   $0x0
  push $134
ffffffff8010847e:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffffffff80108483:	e9 b5 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108488 <vector135>:
.globl vector135
vector135:
  push $0
ffffffff80108488:	6a 00                	push   $0x0
  push $135
ffffffff8010848a:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffffffff8010848f:	e9 a9 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108494 <vector136>:
.globl vector136
vector136:
  push $0
ffffffff80108494:	6a 00                	push   $0x0
  push $136
ffffffff80108496:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffffffff8010849b:	e9 9d f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084a0 <vector137>:
.globl vector137
vector137:
  push $0
ffffffff801084a0:	6a 00                	push   $0x0
  push $137
ffffffff801084a2:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffffffff801084a7:	e9 91 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084ac <vector138>:
.globl vector138
vector138:
  push $0
ffffffff801084ac:	6a 00                	push   $0x0
  push $138
ffffffff801084ae:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffffffff801084b3:	e9 85 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084b8 <vector139>:
.globl vector139
vector139:
  push $0
ffffffff801084b8:	6a 00                	push   $0x0
  push $139
ffffffff801084ba:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffffffff801084bf:	e9 79 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084c4 <vector140>:
.globl vector140
vector140:
  push $0
ffffffff801084c4:	6a 00                	push   $0x0
  push $140
ffffffff801084c6:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffffffff801084cb:	e9 6d f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084d0 <vector141>:
.globl vector141
vector141:
  push $0
ffffffff801084d0:	6a 00                	push   $0x0
  push $141
ffffffff801084d2:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffffffff801084d7:	e9 61 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084dc <vector142>:
.globl vector142
vector142:
  push $0
ffffffff801084dc:	6a 00                	push   $0x0
  push $142
ffffffff801084de:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffffffff801084e3:	e9 55 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084e8 <vector143>:
.globl vector143
vector143:
  push $0
ffffffff801084e8:	6a 00                	push   $0x0
  push $143
ffffffff801084ea:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffffffff801084ef:	e9 49 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801084f4 <vector144>:
.globl vector144
vector144:
  push $0
ffffffff801084f4:	6a 00                	push   $0x0
  push $144
ffffffff801084f6:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffffffff801084fb:	e9 3d f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108500 <vector145>:
.globl vector145
vector145:
  push $0
ffffffff80108500:	6a 00                	push   $0x0
  push $145
ffffffff80108502:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffffffff80108507:	e9 31 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010850c <vector146>:
.globl vector146
vector146:
  push $0
ffffffff8010850c:	6a 00                	push   $0x0
  push $146
ffffffff8010850e:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffffffff80108513:	e9 25 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108518 <vector147>:
.globl vector147
vector147:
  push $0
ffffffff80108518:	6a 00                	push   $0x0
  push $147
ffffffff8010851a:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffffffff8010851f:	e9 19 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108524 <vector148>:
.globl vector148
vector148:
  push $0
ffffffff80108524:	6a 00                	push   $0x0
  push $148
ffffffff80108526:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffffffff8010852b:	e9 0d f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108530 <vector149>:
.globl vector149
vector149:
  push $0
ffffffff80108530:	6a 00                	push   $0x0
  push $149
ffffffff80108532:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffffffff80108537:	e9 01 f5 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010853c <vector150>:
.globl vector150
vector150:
  push $0
ffffffff8010853c:	6a 00                	push   $0x0
  push $150
ffffffff8010853e:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffffffff80108543:	e9 f5 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108548 <vector151>:
.globl vector151
vector151:
  push $0
ffffffff80108548:	6a 00                	push   $0x0
  push $151
ffffffff8010854a:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffffffff8010854f:	e9 e9 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108554 <vector152>:
.globl vector152
vector152:
  push $0
ffffffff80108554:	6a 00                	push   $0x0
  push $152
ffffffff80108556:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffffffff8010855b:	e9 dd f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108560 <vector153>:
.globl vector153
vector153:
  push $0
ffffffff80108560:	6a 00                	push   $0x0
  push $153
ffffffff80108562:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffffffff80108567:	e9 d1 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010856c <vector154>:
.globl vector154
vector154:
  push $0
ffffffff8010856c:	6a 00                	push   $0x0
  push $154
ffffffff8010856e:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffffffff80108573:	e9 c5 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108578 <vector155>:
.globl vector155
vector155:
  push $0
ffffffff80108578:	6a 00                	push   $0x0
  push $155
ffffffff8010857a:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffffffff8010857f:	e9 b9 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108584 <vector156>:
.globl vector156
vector156:
  push $0
ffffffff80108584:	6a 00                	push   $0x0
  push $156
ffffffff80108586:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffffffff8010858b:	e9 ad f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108590 <vector157>:
.globl vector157
vector157:
  push $0
ffffffff80108590:	6a 00                	push   $0x0
  push $157
ffffffff80108592:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffffffff80108597:	e9 a1 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010859c <vector158>:
.globl vector158
vector158:
  push $0
ffffffff8010859c:	6a 00                	push   $0x0
  push $158
ffffffff8010859e:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffffffff801085a3:	e9 95 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085a8 <vector159>:
.globl vector159
vector159:
  push $0
ffffffff801085a8:	6a 00                	push   $0x0
  push $159
ffffffff801085aa:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffffffff801085af:	e9 89 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085b4 <vector160>:
.globl vector160
vector160:
  push $0
ffffffff801085b4:	6a 00                	push   $0x0
  push $160
ffffffff801085b6:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffffffff801085bb:	e9 7d f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085c0 <vector161>:
.globl vector161
vector161:
  push $0
ffffffff801085c0:	6a 00                	push   $0x0
  push $161
ffffffff801085c2:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffffffff801085c7:	e9 71 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085cc <vector162>:
.globl vector162
vector162:
  push $0
ffffffff801085cc:	6a 00                	push   $0x0
  push $162
ffffffff801085ce:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffffffff801085d3:	e9 65 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085d8 <vector163>:
.globl vector163
vector163:
  push $0
ffffffff801085d8:	6a 00                	push   $0x0
  push $163
ffffffff801085da:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffffffff801085df:	e9 59 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085e4 <vector164>:
.globl vector164
vector164:
  push $0
ffffffff801085e4:	6a 00                	push   $0x0
  push $164
ffffffff801085e6:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffffffff801085eb:	e9 4d f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085f0 <vector165>:
.globl vector165
vector165:
  push $0
ffffffff801085f0:	6a 00                	push   $0x0
  push $165
ffffffff801085f2:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffffffff801085f7:	e9 41 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801085fc <vector166>:
.globl vector166
vector166:
  push $0
ffffffff801085fc:	6a 00                	push   $0x0
  push $166
ffffffff801085fe:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffffffff80108603:	e9 35 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108608 <vector167>:
.globl vector167
vector167:
  push $0
ffffffff80108608:	6a 00                	push   $0x0
  push $167
ffffffff8010860a:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffffffff8010860f:	e9 29 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108614 <vector168>:
.globl vector168
vector168:
  push $0
ffffffff80108614:	6a 00                	push   $0x0
  push $168
ffffffff80108616:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffffffff8010861b:	e9 1d f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108620 <vector169>:
.globl vector169
vector169:
  push $0
ffffffff80108620:	6a 00                	push   $0x0
  push $169
ffffffff80108622:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffffffff80108627:	e9 11 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010862c <vector170>:
.globl vector170
vector170:
  push $0
ffffffff8010862c:	6a 00                	push   $0x0
  push $170
ffffffff8010862e:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffffffff80108633:	e9 05 f4 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108638 <vector171>:
.globl vector171
vector171:
  push $0
ffffffff80108638:	6a 00                	push   $0x0
  push $171
ffffffff8010863a:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffffffff8010863f:	e9 f9 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108644 <vector172>:
.globl vector172
vector172:
  push $0
ffffffff80108644:	6a 00                	push   $0x0
  push $172
ffffffff80108646:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffffffff8010864b:	e9 ed f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108650 <vector173>:
.globl vector173
vector173:
  push $0
ffffffff80108650:	6a 00                	push   $0x0
  push $173
ffffffff80108652:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffffffff80108657:	e9 e1 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010865c <vector174>:
.globl vector174
vector174:
  push $0
ffffffff8010865c:	6a 00                	push   $0x0
  push $174
ffffffff8010865e:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffffffff80108663:	e9 d5 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108668 <vector175>:
.globl vector175
vector175:
  push $0
ffffffff80108668:	6a 00                	push   $0x0
  push $175
ffffffff8010866a:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffffffff8010866f:	e9 c9 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108674 <vector176>:
.globl vector176
vector176:
  push $0
ffffffff80108674:	6a 00                	push   $0x0
  push $176
ffffffff80108676:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffffffff8010867b:	e9 bd f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108680 <vector177>:
.globl vector177
vector177:
  push $0
ffffffff80108680:	6a 00                	push   $0x0
  push $177
ffffffff80108682:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffffffff80108687:	e9 b1 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010868c <vector178>:
.globl vector178
vector178:
  push $0
ffffffff8010868c:	6a 00                	push   $0x0
  push $178
ffffffff8010868e:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffffffff80108693:	e9 a5 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108698 <vector179>:
.globl vector179
vector179:
  push $0
ffffffff80108698:	6a 00                	push   $0x0
  push $179
ffffffff8010869a:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffffffff8010869f:	e9 99 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086a4 <vector180>:
.globl vector180
vector180:
  push $0
ffffffff801086a4:	6a 00                	push   $0x0
  push $180
ffffffff801086a6:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffffffff801086ab:	e9 8d f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086b0 <vector181>:
.globl vector181
vector181:
  push $0
ffffffff801086b0:	6a 00                	push   $0x0
  push $181
ffffffff801086b2:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffffffff801086b7:	e9 81 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086bc <vector182>:
.globl vector182
vector182:
  push $0
ffffffff801086bc:	6a 00                	push   $0x0
  push $182
ffffffff801086be:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffffffff801086c3:	e9 75 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086c8 <vector183>:
.globl vector183
vector183:
  push $0
ffffffff801086c8:	6a 00                	push   $0x0
  push $183
ffffffff801086ca:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffffffff801086cf:	e9 69 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086d4 <vector184>:
.globl vector184
vector184:
  push $0
ffffffff801086d4:	6a 00                	push   $0x0
  push $184
ffffffff801086d6:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffffffff801086db:	e9 5d f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086e0 <vector185>:
.globl vector185
vector185:
  push $0
ffffffff801086e0:	6a 00                	push   $0x0
  push $185
ffffffff801086e2:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffffffff801086e7:	e9 51 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086ec <vector186>:
.globl vector186
vector186:
  push $0
ffffffff801086ec:	6a 00                	push   $0x0
  push $186
ffffffff801086ee:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffffffff801086f3:	e9 45 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801086f8 <vector187>:
.globl vector187
vector187:
  push $0
ffffffff801086f8:	6a 00                	push   $0x0
  push $187
ffffffff801086fa:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffffffff801086ff:	e9 39 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108704 <vector188>:
.globl vector188
vector188:
  push $0
ffffffff80108704:	6a 00                	push   $0x0
  push $188
ffffffff80108706:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffffffff8010870b:	e9 2d f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108710 <vector189>:
.globl vector189
vector189:
  push $0
ffffffff80108710:	6a 00                	push   $0x0
  push $189
ffffffff80108712:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffffffff80108717:	e9 21 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010871c <vector190>:
.globl vector190
vector190:
  push $0
ffffffff8010871c:	6a 00                	push   $0x0
  push $190
ffffffff8010871e:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffffffff80108723:	e9 15 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108728 <vector191>:
.globl vector191
vector191:
  push $0
ffffffff80108728:	6a 00                	push   $0x0
  push $191
ffffffff8010872a:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffffffff8010872f:	e9 09 f3 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108734 <vector192>:
.globl vector192
vector192:
  push $0
ffffffff80108734:	6a 00                	push   $0x0
  push $192
ffffffff80108736:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffffffff8010873b:	e9 fd f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108740 <vector193>:
.globl vector193
vector193:
  push $0
ffffffff80108740:	6a 00                	push   $0x0
  push $193
ffffffff80108742:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffffffff80108747:	e9 f1 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010874c <vector194>:
.globl vector194
vector194:
  push $0
ffffffff8010874c:	6a 00                	push   $0x0
  push $194
ffffffff8010874e:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffffffff80108753:	e9 e5 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108758 <vector195>:
.globl vector195
vector195:
  push $0
ffffffff80108758:	6a 00                	push   $0x0
  push $195
ffffffff8010875a:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffffffff8010875f:	e9 d9 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108764 <vector196>:
.globl vector196
vector196:
  push $0
ffffffff80108764:	6a 00                	push   $0x0
  push $196
ffffffff80108766:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffffffff8010876b:	e9 cd f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108770 <vector197>:
.globl vector197
vector197:
  push $0
ffffffff80108770:	6a 00                	push   $0x0
  push $197
ffffffff80108772:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffffffff80108777:	e9 c1 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010877c <vector198>:
.globl vector198
vector198:
  push $0
ffffffff8010877c:	6a 00                	push   $0x0
  push $198
ffffffff8010877e:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffffffff80108783:	e9 b5 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108788 <vector199>:
.globl vector199
vector199:
  push $0
ffffffff80108788:	6a 00                	push   $0x0
  push $199
ffffffff8010878a:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffffffff8010878f:	e9 a9 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108794 <vector200>:
.globl vector200
vector200:
  push $0
ffffffff80108794:	6a 00                	push   $0x0
  push $200
ffffffff80108796:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffffffff8010879b:	e9 9d f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087a0 <vector201>:
.globl vector201
vector201:
  push $0
ffffffff801087a0:	6a 00                	push   $0x0
  push $201
ffffffff801087a2:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffffffff801087a7:	e9 91 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087ac <vector202>:
.globl vector202
vector202:
  push $0
ffffffff801087ac:	6a 00                	push   $0x0
  push $202
ffffffff801087ae:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffffffff801087b3:	e9 85 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087b8 <vector203>:
.globl vector203
vector203:
  push $0
ffffffff801087b8:	6a 00                	push   $0x0
  push $203
ffffffff801087ba:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffffffff801087bf:	e9 79 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087c4 <vector204>:
.globl vector204
vector204:
  push $0
ffffffff801087c4:	6a 00                	push   $0x0
  push $204
ffffffff801087c6:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffffffff801087cb:	e9 6d f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087d0 <vector205>:
.globl vector205
vector205:
  push $0
ffffffff801087d0:	6a 00                	push   $0x0
  push $205
ffffffff801087d2:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffffffff801087d7:	e9 61 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087dc <vector206>:
.globl vector206
vector206:
  push $0
ffffffff801087dc:	6a 00                	push   $0x0
  push $206
ffffffff801087de:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffffffff801087e3:	e9 55 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087e8 <vector207>:
.globl vector207
vector207:
  push $0
ffffffff801087e8:	6a 00                	push   $0x0
  push $207
ffffffff801087ea:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffffffff801087ef:	e9 49 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801087f4 <vector208>:
.globl vector208
vector208:
  push $0
ffffffff801087f4:	6a 00                	push   $0x0
  push $208
ffffffff801087f6:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffffffff801087fb:	e9 3d f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108800 <vector209>:
.globl vector209
vector209:
  push $0
ffffffff80108800:	6a 00                	push   $0x0
  push $209
ffffffff80108802:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffffffff80108807:	e9 31 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010880c <vector210>:
.globl vector210
vector210:
  push $0
ffffffff8010880c:	6a 00                	push   $0x0
  push $210
ffffffff8010880e:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffffffff80108813:	e9 25 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108818 <vector211>:
.globl vector211
vector211:
  push $0
ffffffff80108818:	6a 00                	push   $0x0
  push $211
ffffffff8010881a:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffffffff8010881f:	e9 19 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108824 <vector212>:
.globl vector212
vector212:
  push $0
ffffffff80108824:	6a 00                	push   $0x0
  push $212
ffffffff80108826:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffffffff8010882b:	e9 0d f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108830 <vector213>:
.globl vector213
vector213:
  push $0
ffffffff80108830:	6a 00                	push   $0x0
  push $213
ffffffff80108832:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffffffff80108837:	e9 01 f2 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010883c <vector214>:
.globl vector214
vector214:
  push $0
ffffffff8010883c:	6a 00                	push   $0x0
  push $214
ffffffff8010883e:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffffffff80108843:	e9 f5 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108848 <vector215>:
.globl vector215
vector215:
  push $0
ffffffff80108848:	6a 00                	push   $0x0
  push $215
ffffffff8010884a:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffffffff8010884f:	e9 e9 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108854 <vector216>:
.globl vector216
vector216:
  push $0
ffffffff80108854:	6a 00                	push   $0x0
  push $216
ffffffff80108856:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffffffff8010885b:	e9 dd f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108860 <vector217>:
.globl vector217
vector217:
  push $0
ffffffff80108860:	6a 00                	push   $0x0
  push $217
ffffffff80108862:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffffffff80108867:	e9 d1 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010886c <vector218>:
.globl vector218
vector218:
  push $0
ffffffff8010886c:	6a 00                	push   $0x0
  push $218
ffffffff8010886e:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffffffff80108873:	e9 c5 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108878 <vector219>:
.globl vector219
vector219:
  push $0
ffffffff80108878:	6a 00                	push   $0x0
  push $219
ffffffff8010887a:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffffffff8010887f:	e9 b9 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108884 <vector220>:
.globl vector220
vector220:
  push $0
ffffffff80108884:	6a 00                	push   $0x0
  push $220
ffffffff80108886:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffffffff8010888b:	e9 ad f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108890 <vector221>:
.globl vector221
vector221:
  push $0
ffffffff80108890:	6a 00                	push   $0x0
  push $221
ffffffff80108892:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffffffff80108897:	e9 a1 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010889c <vector222>:
.globl vector222
vector222:
  push $0
ffffffff8010889c:	6a 00                	push   $0x0
  push $222
ffffffff8010889e:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffffffff801088a3:	e9 95 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088a8 <vector223>:
.globl vector223
vector223:
  push $0
ffffffff801088a8:	6a 00                	push   $0x0
  push $223
ffffffff801088aa:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffffffff801088af:	e9 89 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088b4 <vector224>:
.globl vector224
vector224:
  push $0
ffffffff801088b4:	6a 00                	push   $0x0
  push $224
ffffffff801088b6:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffffffff801088bb:	e9 7d f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088c0 <vector225>:
.globl vector225
vector225:
  push $0
ffffffff801088c0:	6a 00                	push   $0x0
  push $225
ffffffff801088c2:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffffffff801088c7:	e9 71 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088cc <vector226>:
.globl vector226
vector226:
  push $0
ffffffff801088cc:	6a 00                	push   $0x0
  push $226
ffffffff801088ce:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffffffff801088d3:	e9 65 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088d8 <vector227>:
.globl vector227
vector227:
  push $0
ffffffff801088d8:	6a 00                	push   $0x0
  push $227
ffffffff801088da:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffffffff801088df:	e9 59 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088e4 <vector228>:
.globl vector228
vector228:
  push $0
ffffffff801088e4:	6a 00                	push   $0x0
  push $228
ffffffff801088e6:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffffffff801088eb:	e9 4d f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088f0 <vector229>:
.globl vector229
vector229:
  push $0
ffffffff801088f0:	6a 00                	push   $0x0
  push $229
ffffffff801088f2:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffffffff801088f7:	e9 41 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801088fc <vector230>:
.globl vector230
vector230:
  push $0
ffffffff801088fc:	6a 00                	push   $0x0
  push $230
ffffffff801088fe:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffffffff80108903:	e9 35 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108908 <vector231>:
.globl vector231
vector231:
  push $0
ffffffff80108908:	6a 00                	push   $0x0
  push $231
ffffffff8010890a:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffffffff8010890f:	e9 29 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108914 <vector232>:
.globl vector232
vector232:
  push $0
ffffffff80108914:	6a 00                	push   $0x0
  push $232
ffffffff80108916:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffffffff8010891b:	e9 1d f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108920 <vector233>:
.globl vector233
vector233:
  push $0
ffffffff80108920:	6a 00                	push   $0x0
  push $233
ffffffff80108922:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffffffff80108927:	e9 11 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010892c <vector234>:
.globl vector234
vector234:
  push $0
ffffffff8010892c:	6a 00                	push   $0x0
  push $234
ffffffff8010892e:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffffffff80108933:	e9 05 f1 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108938 <vector235>:
.globl vector235
vector235:
  push $0
ffffffff80108938:	6a 00                	push   $0x0
  push $235
ffffffff8010893a:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffffffff8010893f:	e9 f9 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108944 <vector236>:
.globl vector236
vector236:
  push $0
ffffffff80108944:	6a 00                	push   $0x0
  push $236
ffffffff80108946:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffffffff8010894b:	e9 ed f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108950 <vector237>:
.globl vector237
vector237:
  push $0
ffffffff80108950:	6a 00                	push   $0x0
  push $237
ffffffff80108952:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffffffff80108957:	e9 e1 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010895c <vector238>:
.globl vector238
vector238:
  push $0
ffffffff8010895c:	6a 00                	push   $0x0
  push $238
ffffffff8010895e:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffffffff80108963:	e9 d5 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108968 <vector239>:
.globl vector239
vector239:
  push $0
ffffffff80108968:	6a 00                	push   $0x0
  push $239
ffffffff8010896a:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffffffff8010896f:	e9 c9 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108974 <vector240>:
.globl vector240
vector240:
  push $0
ffffffff80108974:	6a 00                	push   $0x0
  push $240
ffffffff80108976:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffffffff8010897b:	e9 bd f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108980 <vector241>:
.globl vector241
vector241:
  push $0
ffffffff80108980:	6a 00                	push   $0x0
  push $241
ffffffff80108982:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffffffff80108987:	e9 b1 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff8010898c <vector242>:
.globl vector242
vector242:
  push $0
ffffffff8010898c:	6a 00                	push   $0x0
  push $242
ffffffff8010898e:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffffffff80108993:	e9 a5 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108998 <vector243>:
.globl vector243
vector243:
  push $0
ffffffff80108998:	6a 00                	push   $0x0
  push $243
ffffffff8010899a:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffffffff8010899f:	e9 99 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089a4 <vector244>:
.globl vector244
vector244:
  push $0
ffffffff801089a4:	6a 00                	push   $0x0
  push $244
ffffffff801089a6:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffffffff801089ab:	e9 8d f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089b0 <vector245>:
.globl vector245
vector245:
  push $0
ffffffff801089b0:	6a 00                	push   $0x0
  push $245
ffffffff801089b2:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffffffff801089b7:	e9 81 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089bc <vector246>:
.globl vector246
vector246:
  push $0
ffffffff801089bc:	6a 00                	push   $0x0
  push $246
ffffffff801089be:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffffffff801089c3:	e9 75 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089c8 <vector247>:
.globl vector247
vector247:
  push $0
ffffffff801089c8:	6a 00                	push   $0x0
  push $247
ffffffff801089ca:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffffffff801089cf:	e9 69 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089d4 <vector248>:
.globl vector248
vector248:
  push $0
ffffffff801089d4:	6a 00                	push   $0x0
  push $248
ffffffff801089d6:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffffffff801089db:	e9 5d f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089e0 <vector249>:
.globl vector249
vector249:
  push $0
ffffffff801089e0:	6a 00                	push   $0x0
  push $249
ffffffff801089e2:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffffffff801089e7:	e9 51 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089ec <vector250>:
.globl vector250
vector250:
  push $0
ffffffff801089ec:	6a 00                	push   $0x0
  push $250
ffffffff801089ee:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffffffff801089f3:	e9 45 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff801089f8 <vector251>:
.globl vector251
vector251:
  push $0
ffffffff801089f8:	6a 00                	push   $0x0
  push $251
ffffffff801089fa:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffffffff801089ff:	e9 39 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108a04 <vector252>:
.globl vector252
vector252:
  push $0
ffffffff80108a04:	6a 00                	push   $0x0
  push $252
ffffffff80108a06:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffffffff80108a0b:	e9 2d f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108a10 <vector253>:
.globl vector253
vector253:
  push $0
ffffffff80108a10:	6a 00                	push   $0x0
  push $253
ffffffff80108a12:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffffffff80108a17:	e9 21 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108a1c <vector254>:
.globl vector254
vector254:
  push $0
ffffffff80108a1c:	6a 00                	push   $0x0
  push $254
ffffffff80108a1e:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffffffff80108a23:	e9 15 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108a28 <vector255>:
.globl vector255
vector255:
  push $0
ffffffff80108a28:	6a 00                	push   $0x0
  push $255
ffffffff80108a2a:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffffffff80108a2f:	e9 09 f0 ff ff       	jmp    ffffffff80107a3d <alltraps>

ffffffff80108a34 <v2p>:
static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff80108a34:	55                   	push   %rbp
ffffffff80108a35:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108a38:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80108a3c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80108a40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108a44:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff80108a49:	48 01 d0             	add    %rdx,%rax
ffffffff80108a4c:	c9                   	leave
ffffffff80108a4d:	c3                   	ret

ffffffff80108a4e <p2v>:
static inline void *p2v(uintp a) { return (void *) ((a) + ((uintp)KERNBASE)); }
ffffffff80108a4e:	55                   	push   %rbp
ffffffff80108a4f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108a52:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80108a56:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80108a5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108a5e:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80108a64:	c9                   	leave
ffffffff80108a65:	c3                   	ret

ffffffff80108a66 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
ffffffff80108a66:	f3 0f 1e fa          	endbr64
ffffffff80108a6a:	55                   	push   %rbp
ffffffff80108a6b:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108a6e:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80108a72:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108a76:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80108a7a:	89 55 dc             	mov    %edx,-0x24(%rbp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
ffffffff80108a7d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108a81:	48 c1 e8 15          	shr    $0x15,%rax
ffffffff80108a85:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80108a8a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108a91:	00 
ffffffff80108a92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108a96:	48 01 d0             	add    %rdx,%rax
ffffffff80108a99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(*pde & PTE_P){
ffffffff80108a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108aa1:	48 8b 00             	mov    (%rax),%rax
ffffffff80108aa4:	83 e0 01             	and    $0x1,%eax
ffffffff80108aa7:	48 85 c0             	test   %rax,%rax
ffffffff80108aaa:	74 1b                	je     ffffffff80108ac7 <walkpgdir+0x61>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
ffffffff80108aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108ab0:	48 8b 00             	mov    (%rax),%rax
ffffffff80108ab3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108ab9:	48 89 c7             	mov    %rax,%rdi
ffffffff80108abc:	e8 8d ff ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80108ac1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80108ac5:	eb 4d                	jmp    ffffffff80108b14 <walkpgdir+0xae>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
ffffffff80108ac7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80108acb:	74 10                	je     ffffffff80108add <walkpgdir+0x77>
ffffffff80108acd:	e8 fb a8 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80108ad2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80108ad6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80108adb:	75 07                	jne    ffffffff80108ae4 <walkpgdir+0x7e>
      return 0;
ffffffff80108add:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108ae2:	eb 4c                	jmp    ffffffff80108b30 <walkpgdir+0xca>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
ffffffff80108ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108ae8:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108aed:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108af2:	48 89 c7             	mov    %rax,%rdi
ffffffff80108af5:	e8 45 d6 ff ff       	call   ffffffff8010613f <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
ffffffff80108afa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108afe:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b01:	e8 2e ff ff ff       	call   ffffffff80108a34 <v2p>
ffffffff80108b06:	48 83 c8 07          	or     $0x7,%rax
ffffffff80108b0a:	48 89 c2             	mov    %rax,%rdx
ffffffff80108b0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108b11:	48 89 10             	mov    %rdx,(%rax)
  }
  return &pgtab[PTX(va)];
ffffffff80108b14:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108b18:	48 c1 e8 0c          	shr    $0xc,%rax
ffffffff80108b1c:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80108b21:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108b28:	00 
ffffffff80108b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108b2d:	48 01 d0             	add    %rdx,%rax
}
ffffffff80108b30:	c9                   	leave
ffffffff80108b31:	c3                   	ret

ffffffff80108b32 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uintp size, uintp pa, int perm)
{
ffffffff80108b32:	f3 0f 1e fa          	endbr64
ffffffff80108b36:	55                   	push   %rbp
ffffffff80108b37:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108b3a:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff80108b3e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80108b42:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80108b46:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffffffff80108b4a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffffffff80108b4e:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uintp)va);
ffffffff80108b52:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80108b56:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108b5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((uintp)va) + size - 1);
ffffffff80108b60:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff80108b64:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108b68:	48 01 d0             	add    %rdx,%rax
ffffffff80108b6b:	48 83 e8 01          	sub    $0x1,%rax
ffffffff80108b6f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108b75:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffffffff80108b79:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80108b7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108b81:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80108b86:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108b89:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b8c:	e8 d5 fe ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff80108b91:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80108b95:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108b9a:	75 07                	jne    ffffffff80108ba3 <mappages+0x71>
      return -1;
ffffffff80108b9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80108ba1:	eb 54                	jmp    ffffffff80108bf7 <mappages+0xc5>
    if(*pte & PTE_P)
ffffffff80108ba3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108ba7:	48 8b 00             	mov    (%rax),%rax
ffffffff80108baa:	83 e0 01             	and    $0x1,%eax
ffffffff80108bad:	48 85 c0             	test   %rax,%rax
ffffffff80108bb0:	74 0c                	je     ffffffff80108bbe <mappages+0x8c>
      panic("remap");
ffffffff80108bb2:	48 c7 c7 f8 a1 10 80 	mov    $0xffffffff8010a1f8,%rdi
ffffffff80108bb9:	e8 91 7d ff ff       	call   ffffffff8010094f <panic>
    *pte = pa | perm | PTE_P;
ffffffff80108bbe:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffffffff80108bc1:	48 98                	cltq
ffffffff80108bc3:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffffffff80108bc7:	48 83 c8 01          	or     $0x1,%rax
ffffffff80108bcb:	48 89 c2             	mov    %rax,%rdx
ffffffff80108bce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108bd2:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffffffff80108bd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108bd9:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff80108bdd:	74 12                	je     ffffffff80108bf1 <mappages+0xbf>
      break;
    a += PGSIZE;
ffffffff80108bdf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108be6:	00 
    pa += PGSIZE;
ffffffff80108be7:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffffffff80108bee:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffffffff80108bef:	eb 88                	jmp    ffffffff80108b79 <mappages+0x47>
      break;
ffffffff80108bf1:	90                   	nop
  }
  return 0;
ffffffff80108bf2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80108bf7:	c9                   	leave
ffffffff80108bf8:	c3                   	ret

ffffffff80108bf9 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffffffff80108bf9:	f3 0f 1e fa          	endbr64
ffffffff80108bfd:	55                   	push   %rbp
ffffffff80108bfe:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108c01:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80108c05:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108c09:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80108c0d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;
  
  if(sz >= PGSIZE)
ffffffff80108c10:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffffffff80108c17:	76 0c                	jbe    ffffffff80108c25 <inituvm+0x2c>
    panic("inituvm: more than a page");
ffffffff80108c19:	48 c7 c7 fe a1 10 80 	mov    $0xffffffff8010a1fe,%rdi
ffffffff80108c20:	e8 2a 7d ff ff       	call   ffffffff8010094f <panic>
  mem = kalloc();
ffffffff80108c25:	e8 a3 a7 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80108c2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffffffff80108c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108c32:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108c37:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108c3c:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c3f:	e8 fb d4 ff ff       	call   ffffffff8010613f <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
ffffffff80108c44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108c48:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c4b:	e8 e4 fd ff ff       	call   ffffffff80108a34 <v2p>
ffffffff80108c50:	48 89 c2             	mov    %rax,%rdx
ffffffff80108c53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108c57:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffffffff80108c5d:	48 89 d1             	mov    %rdx,%rcx
ffffffff80108c60:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108c65:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108c6a:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c6d:	e8 c0 fe ff ff       	call   ffffffff80108b32 <mappages>
  memmove(mem, init, sz);
ffffffff80108c72:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff80108c75:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff80108c79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108c7d:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108c80:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c83:	e8 ae d5 ff ff       	call   ffffffff80106236 <memmove>
}
ffffffff80108c88:	90                   	nop
ffffffff80108c89:	c9                   	leave
ffffffff80108c8a:	c3                   	ret

ffffffff80108c8b <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffffffff80108c8b:	f3 0f 1e fa          	endbr64
ffffffff80108c8f:	55                   	push   %rbp
ffffffff80108c90:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108c93:	53                   	push   %rbx
ffffffff80108c94:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff80108c98:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffffffff80108c9c:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffffffff80108ca0:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
ffffffff80108ca4:	89 4d b4             	mov    %ecx,-0x4c(%rbp)
ffffffff80108ca7:	44 89 45 b0          	mov    %r8d,-0x50(%rbp)
  uint i, pa, n;
  pte_t *pte;

  if((uintp) addr % PGSIZE != 0)
ffffffff80108cab:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108caf:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80108cb4:	48 85 c0             	test   %rax,%rax
ffffffff80108cb7:	74 0c                	je     ffffffff80108cc5 <loaduvm+0x3a>
    panic("loaduvm: addr must be page aligned");
ffffffff80108cb9:	48 c7 c7 18 a2 10 80 	mov    $0xffffffff8010a218,%rdi
ffffffff80108cc0:	e8 8a 7c ff ff       	call   ffffffff8010094f <panic>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80108cc5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff80108ccc:	e9 a1 00 00 00       	jmp    ffffffff80108d72 <loaduvm+0xe7>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffffffff80108cd1:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80108cd4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108cd8:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff80108cdc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108ce0:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108ce5:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108ce8:	48 89 c7             	mov    %rax,%rdi
ffffffff80108ceb:	e8 76 fd ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff80108cf0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff80108cf4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80108cf9:	75 0c                	jne    ffffffff80108d07 <loaduvm+0x7c>
      panic("loaduvm: address should exist");
ffffffff80108cfb:	48 c7 c7 3b a2 10 80 	mov    $0xffffffff8010a23b,%rdi
ffffffff80108d02:	e8 48 7c ff ff       	call   ffffffff8010094f <panic>
    pa = PTE_ADDR(*pte);
ffffffff80108d07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108d0b:	48 8b 00             	mov    (%rax),%rax
ffffffff80108d0e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffffffff80108d13:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if(sz - i < PGSIZE)
ffffffff80108d16:	8b 45 b0             	mov    -0x50(%rbp),%eax
ffffffff80108d19:	2b 45 ec             	sub    -0x14(%rbp),%eax
ffffffff80108d1c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffffffff80108d21:	77 0b                	ja     ffffffff80108d2e <loaduvm+0xa3>
      n = sz - i;
ffffffff80108d23:	8b 45 b0             	mov    -0x50(%rbp),%eax
ffffffff80108d26:	2b 45 ec             	sub    -0x14(%rbp),%eax
ffffffff80108d29:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff80108d2c:	eb 07                	jmp    ffffffff80108d35 <loaduvm+0xaa>
    else
      n = PGSIZE;
ffffffff80108d2e:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%rbp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
ffffffff80108d35:	8b 55 b4             	mov    -0x4c(%rbp),%edx
ffffffff80108d38:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80108d3b:	8d 1c 02             	lea    (%rdx,%rax,1),%ebx
ffffffff80108d3e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80108d41:	48 89 c7             	mov    %rax,%rdi
ffffffff80108d44:	e8 05 fd ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80108d49:	48 89 c6             	mov    %rax,%rsi
ffffffff80108d4c:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80108d4f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80108d53:	89 d1                	mov    %edx,%ecx
ffffffff80108d55:	89 da                	mov    %ebx,%edx
ffffffff80108d57:	48 89 c7             	mov    %rax,%rdi
ffffffff80108d5a:	e8 7d 97 ff ff       	call   ffffffff801024dc <readi>
ffffffff80108d5f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff80108d62:	74 07                	je     ffffffff80108d6b <loaduvm+0xe0>
      return -1;
ffffffff80108d64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80108d69:	eb 18                	jmp    ffffffff80108d83 <loaduvm+0xf8>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80108d6b:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%rbp)
ffffffff80108d72:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80108d75:	3b 45 b0             	cmp    -0x50(%rbp),%eax
ffffffff80108d78:	0f 82 53 ff ff ff    	jb     ffffffff80108cd1 <loaduvm+0x46>
  }
  return 0;
ffffffff80108d7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80108d83:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80108d87:	c9                   	leave
ffffffff80108d88:	c3                   	ret

ffffffff80108d89 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
ffffffff80108d89:	f3 0f 1e fa          	endbr64
ffffffff80108d8d:	55                   	push   %rbp
ffffffff80108d8e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108d91:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80108d95:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108d99:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff80108d9c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  char *mem;
  uintp a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
ffffffff80108d9f:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80108da2:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffffffff80108da5:	73 08                	jae    ffffffff80108daf <allocuvm+0x26>
    return oldsz;
ffffffff80108da7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80108daa:	e9 b0 00 00 00       	jmp    ffffffff80108e5f <allocuvm+0xd6>

  a = PGROUNDUP(oldsz);
ffffffff80108daf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80108db2:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80108db8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108dbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffffffff80108dc2:	e9 88 00 00 00       	jmp    ffffffff80108e4f <allocuvm+0xc6>
    mem = kalloc();
ffffffff80108dc7:	e8 01 a6 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80108dcc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffffffff80108dd0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80108dd5:	75 2d                	jne    ffffffff80108e04 <allocuvm+0x7b>
      cprintf("allocuvm out of memory\n");
ffffffff80108dd7:	48 c7 c7 59 a2 10 80 	mov    $0xffffffff8010a259,%rdi
ffffffff80108dde:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108de3:	e8 d8 77 ff ff       	call   ffffffff801005c0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
ffffffff80108de8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
ffffffff80108deb:	8b 4d e0             	mov    -0x20(%rbp),%ecx
ffffffff80108dee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108df2:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108df5:	48 89 c7             	mov    %rax,%rdi
ffffffff80108df8:	e8 64 00 00 00       	call   ffffffff80108e61 <deallocuvm>
      return 0;
ffffffff80108dfd:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108e02:	eb 5b                	jmp    ffffffff80108e5f <allocuvm+0xd6>
    }
    memset(mem, 0, PGSIZE);
ffffffff80108e04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108e08:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108e0d:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108e12:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e15:	e8 25 d3 ff ff       	call   ffffffff8010613f <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
ffffffff80108e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108e1e:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e21:	e8 0e fc ff ff       	call   ffffffff80108a34 <v2p>
ffffffff80108e26:	48 89 c2             	mov    %rax,%rdx
ffffffff80108e29:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffffffff80108e2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108e31:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffffffff80108e37:	48 89 d1             	mov    %rdx,%rcx
ffffffff80108e3a:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108e3f:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e42:	e8 eb fc ff ff       	call   ffffffff80108b32 <mappages>
  for(; a < newsz; a += PGSIZE){
ffffffff80108e47:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108e4e:	00 
ffffffff80108e4f:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80108e52:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80108e56:	0f 82 6b ff ff ff    	jb     ffffffff80108dc7 <allocuvm+0x3e>
  }
  return newsz;
ffffffff80108e5c:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffffffff80108e5f:	c9                   	leave
ffffffff80108e60:	c3                   	ret

ffffffff80108e61 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uintp oldsz, uintp newsz)
{
ffffffff80108e61:	f3 0f 1e fa          	endbr64
ffffffff80108e65:	55                   	push   %rbp
ffffffff80108e66:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108e69:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80108e6d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80108e71:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80108e75:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  uintp a, pa;

  if(newsz >= oldsz)
ffffffff80108e79:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108e7d:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffffffff80108e81:	72 09                	jb     ffffffff80108e8c <deallocuvm+0x2b>
    return oldsz;
ffffffff80108e83:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80108e87:	e9 ba 00 00 00       	jmp    ffffffff80108f46 <deallocuvm+0xe5>

  a = PGROUNDUP(newsz);
ffffffff80108e8c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108e90:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80108e96:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108e9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffffffff80108ea0:	e9 8f 00 00 00       	jmp    ffffffff80108f34 <deallocuvm+0xd3>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffffffff80108ea5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80108ea9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108ead:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108eb2:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108eb5:	48 89 c7             	mov    %rax,%rdi
ffffffff80108eb8:	e8 a9 fb ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff80108ebd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(!pte)
ffffffff80108ec1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80108ec6:	75 0a                	jne    ffffffff80108ed2 <deallocuvm+0x71>
      a += (NPTENTRIES - 1) * PGSIZE;
ffffffff80108ec8:	48 81 45 f8 00 f0 1f 	addq   $0x1ff000,-0x8(%rbp)
ffffffff80108ecf:	00 
ffffffff80108ed0:	eb 5a                	jmp    ffffffff80108f2c <deallocuvm+0xcb>
    else if((*pte & PTE_P) != 0){
ffffffff80108ed2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108ed6:	48 8b 00             	mov    (%rax),%rax
ffffffff80108ed9:	83 e0 01             	and    $0x1,%eax
ffffffff80108edc:	48 85 c0             	test   %rax,%rax
ffffffff80108edf:	74 4b                	je     ffffffff80108f2c <deallocuvm+0xcb>
      pa = PTE_ADDR(*pte);
ffffffff80108ee1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108ee5:	48 8b 00             	mov    (%rax),%rax
ffffffff80108ee8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108eee:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffffffff80108ef2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108ef7:	75 0c                	jne    ffffffff80108f05 <deallocuvm+0xa4>
        panic("kfree");
ffffffff80108ef9:	48 c7 c7 71 a2 10 80 	mov    $0xffffffff8010a271,%rdi
ffffffff80108f00:	e8 4a 7a ff ff       	call   ffffffff8010094f <panic>
      char *v = p2v(pa);
ffffffff80108f05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108f09:	48 89 c7             	mov    %rax,%rdi
ffffffff80108f0c:	e8 3d fb ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80108f11:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffffffff80108f15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108f19:	48 89 c7             	mov    %rax,%rdi
ffffffff80108f1c:	e8 fe a3 ff ff       	call   ffffffff8010331f <kfree>
      *pte = 0;
ffffffff80108f21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108f25:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffffffff80108f2c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108f33:	00 
ffffffff80108f34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108f38:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffffffff80108f3c:	0f 82 63 ff ff ff    	jb     ffffffff80108ea5 <deallocuvm+0x44>
    }
  }
  return newsz;
ffffffff80108f42:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffffffff80108f46:	c9                   	leave
ffffffff80108f47:	c3                   	ret

ffffffff80108f48 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
ffffffff80108f48:	f3 0f 1e fa          	endbr64
ffffffff80108f4c:	55                   	push   %rbp
ffffffff80108f4d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108f50:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80108f54:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  uint i;
  if(pgdir == 0)
ffffffff80108f58:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108f5d:	75 0c                	jne    ffffffff80108f6b <freevm+0x23>
    panic("freevm: no pgdir");
ffffffff80108f5f:	48 c7 c7 77 a2 10 80 	mov    $0xffffffff8010a277,%rdi
ffffffff80108f66:	e8 e4 79 ff ff       	call   ffffffff8010094f <panic>
  deallocuvm(pgdir, 0x3fa00000, 0);
ffffffff80108f6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108f6f:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108f74:	be 00 00 a0 3f       	mov    $0x3fa00000,%esi
ffffffff80108f79:	48 89 c7             	mov    %rax,%rdi
ffffffff80108f7c:	e8 e0 fe ff ff       	call   ffffffff80108e61 <deallocuvm>
  for(i = 0; i < NPDENTRIES-2; i++){
ffffffff80108f81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80108f88:	eb 54                	jmp    ffffffff80108fde <freevm+0x96>
    if(pgdir[i] & PTE_P){
ffffffff80108f8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80108f8d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108f94:	00 
ffffffff80108f95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108f99:	48 01 d0             	add    %rdx,%rax
ffffffff80108f9c:	48 8b 00             	mov    (%rax),%rax
ffffffff80108f9f:	83 e0 01             	and    $0x1,%eax
ffffffff80108fa2:	48 85 c0             	test   %rax,%rax
ffffffff80108fa5:	74 33                	je     ffffffff80108fda <freevm+0x92>
      char * v = p2v(PTE_ADDR(pgdir[i]));
ffffffff80108fa7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80108faa:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108fb1:	00 
ffffffff80108fb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108fb6:	48 01 d0             	add    %rdx,%rax
ffffffff80108fb9:	48 8b 00             	mov    (%rax),%rax
ffffffff80108fbc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108fc2:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fc5:	e8 84 fa ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80108fca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      kfree(v);
ffffffff80108fce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108fd2:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fd5:	e8 45 a3 ff ff       	call   ffffffff8010331f <kfree>
  for(i = 0; i < NPDENTRIES-2; i++){
ffffffff80108fda:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80108fde:	81 7d fc fd 01 00 00 	cmpl   $0x1fd,-0x4(%rbp)
ffffffff80108fe5:	76 a3                	jbe    ffffffff80108f8a <freevm+0x42>
    }
  }
  kfree((char*)pgdir);
ffffffff80108fe7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108feb:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fee:	e8 2c a3 ff ff       	call   ffffffff8010331f <kfree>
}
ffffffff80108ff3:	90                   	nop
ffffffff80108ff4:	c9                   	leave
ffffffff80108ff5:	c3                   	ret

ffffffff80108ff6 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
ffffffff80108ff6:	f3 0f 1e fa          	endbr64
ffffffff80108ffa:	55                   	push   %rbp
ffffffff80108ffb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108ffe:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109002:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80109006:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffffffff8010900a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff8010900e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109012:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80109017:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010901a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010901d:	e8 44 fa ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff80109022:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffffffff80109026:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff8010902b:	75 0c                	jne    ffffffff80109039 <clearpteu+0x43>
    panic("clearpteu");
ffffffff8010902d:	48 c7 c7 88 a2 10 80 	mov    $0xffffffff8010a288,%rdi
ffffffff80109034:	e8 16 79 ff ff       	call   ffffffff8010094f <panic>
  *pte &= ~PTE_U;
ffffffff80109039:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010903d:	48 8b 00             	mov    (%rax),%rax
ffffffff80109040:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffffffff80109044:	48 89 c2             	mov    %rax,%rdx
ffffffff80109047:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010904b:	48 89 10             	mov    %rdx,(%rax)
}
ffffffff8010904e:	90                   	nop
ffffffff8010904f:	c9                   	leave
ffffffff80109050:	c3                   	ret

ffffffff80109051 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
ffffffff80109051:	f3 0f 1e fa          	endbr64
ffffffff80109055:	55                   	push   %rbp
ffffffff80109056:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109059:	53                   	push   %rbx
ffffffff8010905a:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff8010905e:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
ffffffff80109062:	89 75 b4             	mov    %esi,-0x4c(%rbp)
  pde_t *d;
  pte_t *pte;
  uintp pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffffffff80109065:	e8 31 07 00 00       	call   ffffffff8010979b <setupkvm>
ffffffff8010906a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff8010906e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80109073:	75 0a                	jne    ffffffff8010907f <copyuvm+0x2e>
    return 0;
ffffffff80109075:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010907a:	e9 0f 01 00 00       	jmp    ffffffff8010918e <copyuvm+0x13d>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff8010907f:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffffffff80109086:	00 
ffffffff80109087:	e9 da 00 00 00       	jmp    ffffffff80109166 <copyuvm+0x115>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffffffff8010908c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80109090:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80109094:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80109099:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010909c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010909f:	e8 c2 f9 ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff801090a4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff801090a8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff801090ad:	75 0c                	jne    ffffffff801090bb <copyuvm+0x6a>
      panic("copyuvm: pte should exist");
ffffffff801090af:	48 c7 c7 92 a2 10 80 	mov    $0xffffffff8010a292,%rdi
ffffffff801090b6:	e8 94 78 ff ff       	call   ffffffff8010094f <panic>
    if(!(*pte & PTE_P))
ffffffff801090bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801090bf:	48 8b 00             	mov    (%rax),%rax
ffffffff801090c2:	83 e0 01             	and    $0x1,%eax
ffffffff801090c5:	48 85 c0             	test   %rax,%rax
ffffffff801090c8:	75 0c                	jne    ffffffff801090d6 <copyuvm+0x85>
      panic("copyuvm: page not present");
ffffffff801090ca:	48 c7 c7 ac a2 10 80 	mov    $0xffffffff8010a2ac,%rdi
ffffffff801090d1:	e8 79 78 ff ff       	call   ffffffff8010094f <panic>
    pa = PTE_ADDR(*pte);
ffffffff801090d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801090da:	48 8b 00             	mov    (%rax),%rax
ffffffff801090dd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff801090e3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    flags = PTE_FLAGS(*pte);
ffffffff801090e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801090eb:	48 8b 00             	mov    (%rax),%rax
ffffffff801090ee:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff801090f3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if((mem = kalloc()) == 0)
ffffffff801090f7:	e8 d1 a2 ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801090fc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffffffff80109100:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff80109105:	74 72                	je     ffffffff80109179 <copyuvm+0x128>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
ffffffff80109107:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010910b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010910e:	e8 3b f9 ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80109113:	48 89 c1             	mov    %rax,%rcx
ffffffff80109116:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff8010911a:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff8010911f:	48 89 ce             	mov    %rcx,%rsi
ffffffff80109122:	48 89 c7             	mov    %rax,%rdi
ffffffff80109125:	e8 0c d1 ff ff       	call   ffffffff80106236 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
ffffffff8010912a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010912e:	89 c3                	mov    %eax,%ebx
ffffffff80109130:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80109134:	48 89 c7             	mov    %rax,%rdi
ffffffff80109137:	e8 f8 f8 ff ff       	call   ffffffff80108a34 <v2p>
ffffffff8010913c:	48 89 c2             	mov    %rax,%rdx
ffffffff8010913f:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
ffffffff80109143:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109147:	41 89 d8             	mov    %ebx,%r8d
ffffffff8010914a:	48 89 d1             	mov    %rdx,%rcx
ffffffff8010914d:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80109152:	48 89 c7             	mov    %rax,%rdi
ffffffff80109155:	e8 d8 f9 ff ff       	call   ffffffff80108b32 <mappages>
ffffffff8010915a:	85 c0                	test   %eax,%eax
ffffffff8010915c:	78 1e                	js     ffffffff8010917c <copyuvm+0x12b>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff8010915e:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
ffffffff80109165:	00 
ffffffff80109166:	8b 45 b4             	mov    -0x4c(%rbp),%eax
ffffffff80109169:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff8010916d:	0f 82 19 ff ff ff    	jb     ffffffff8010908c <copyuvm+0x3b>
      goto bad;
  }
  return d;
ffffffff80109173:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109177:	eb 15                	jmp    ffffffff8010918e <copyuvm+0x13d>
      goto bad;
ffffffff80109179:	90                   	nop
ffffffff8010917a:	eb 01                	jmp    ffffffff8010917d <copyuvm+0x12c>
      goto bad;
ffffffff8010917c:	90                   	nop

bad:
  freevm(d);
ffffffff8010917d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109181:	48 89 c7             	mov    %rax,%rdi
ffffffff80109184:	e8 bf fd ff ff       	call   ffffffff80108f48 <freevm>
  return 0;
ffffffff80109189:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010918e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80109192:	c9                   	leave
ffffffff80109193:	c3                   	ret

ffffffff80109194 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
ffffffff80109194:	f3 0f 1e fa          	endbr64
ffffffff80109198:	55                   	push   %rbp
ffffffff80109199:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010919c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801091a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801091a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffffffff801091a8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff801091ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801091b0:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff801091b5:	48 89 ce             	mov    %rcx,%rsi
ffffffff801091b8:	48 89 c7             	mov    %rax,%rdi
ffffffff801091bb:	e8 a6 f8 ff ff       	call   ffffffff80108a66 <walkpgdir>
ffffffff801091c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffffffff801091c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801091c8:	48 8b 00             	mov    (%rax),%rax
ffffffff801091cb:	83 e0 01             	and    $0x1,%eax
ffffffff801091ce:	48 85 c0             	test   %rax,%rax
ffffffff801091d1:	75 07                	jne    ffffffff801091da <uva2ka+0x46>
    return 0;
ffffffff801091d3:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801091d8:	eb 2c                	jmp    ffffffff80109206 <uva2ka+0x72>
  if((*pte & PTE_U) == 0)
ffffffff801091da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801091de:	48 8b 00             	mov    (%rax),%rax
ffffffff801091e1:	83 e0 04             	and    $0x4,%eax
ffffffff801091e4:	48 85 c0             	test   %rax,%rax
ffffffff801091e7:	75 07                	jne    ffffffff801091f0 <uva2ka+0x5c>
    return 0;
ffffffff801091e9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801091ee:	eb 16                	jmp    ffffffff80109206 <uva2ka+0x72>
  return (char*)p2v(PTE_ADDR(*pte));
ffffffff801091f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801091f4:	48 8b 00             	mov    (%rax),%rax
ffffffff801091f7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff801091fd:	48 89 c7             	mov    %rax,%rdi
ffffffff80109200:	e8 49 f8 ff ff       	call   ffffffff80108a4e <p2v>
ffffffff80109205:	90                   	nop
}
ffffffff80109206:	c9                   	leave
ffffffff80109207:	c3                   	ret

ffffffff80109208 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
ffffffff80109208:	f3 0f 1e fa          	endbr64
ffffffff8010920c:	55                   	push   %rbp
ffffffff8010920d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109210:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80109214:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80109218:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffffffff8010921b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffffffff8010921f:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  char *buf, *pa0;
  uintp n, va0;

  buf = (char*)p;
ffffffff80109222:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80109226:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffffffff8010922a:	e9 9a 00 00 00       	jmp    ffffffff801092c9 <copyout+0xc1>
    va0 = (uint)PGROUNDDOWN(va);
ffffffff8010922f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff80109232:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffffffff80109237:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffffffff8010923b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010923f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80109243:	48 89 d6             	mov    %rdx,%rsi
ffffffff80109246:	48 89 c7             	mov    %rax,%rdi
ffffffff80109249:	e8 46 ff ff ff       	call   ffffffff80109194 <uva2ka>
ffffffff8010924e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffffffff80109252:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80109257:	75 07                	jne    ffffffff80109260 <copyout+0x58>
      return -1;
ffffffff80109259:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010925e:	eb 78                	jmp    ffffffff801092d8 <copyout+0xd0>
    n = PGSIZE - (va - va0);
ffffffff80109260:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff80109263:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80109267:	48 29 c2             	sub    %rax,%rdx
ffffffff8010926a:	48 8d 82 00 10 00 00 	lea    0x1000(%rdx),%rax
ffffffff80109271:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffffffff80109275:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80109278:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff8010927c:	73 07                	jae    ffffffff80109285 <copyout+0x7d>
      n = len;
ffffffff8010927e:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80109281:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffffffff80109285:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109289:	89 c6                	mov    %eax,%esi
ffffffff8010928b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff8010928e:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffffffff80109292:	48 89 c2             	mov    %rax,%rdx
ffffffff80109295:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109299:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff8010929d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801092a1:	89 f2                	mov    %esi,%edx
ffffffff801092a3:	48 89 c6             	mov    %rax,%rsi
ffffffff801092a6:	48 89 cf             	mov    %rcx,%rdi
ffffffff801092a9:	e8 88 cf ff ff       	call   ffffffff80106236 <memmove>
    len -= n;
ffffffff801092ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801092b2:	29 45 d0             	sub    %eax,-0x30(%rbp)
    buf += n;
ffffffff801092b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801092b9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffffffff801092bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801092c1:	05 00 10 00 00       	add    $0x1000,%eax
ffffffff801092c6:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  while(len > 0){
ffffffff801092c9:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
ffffffff801092cd:	0f 85 5c ff ff ff    	jne    ffffffff8010922f <copyout+0x27>
  }
  return 0;
ffffffff801092d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801092d8:	c9                   	leave
ffffffff801092d9:	c3                   	ret

ffffffff801092da <lgdt>:
{
ffffffff801092da:	55                   	push   %rbp
ffffffff801092db:	48 89 e5             	mov    %rsp,%rbp
ffffffff801092de:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801092e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801092e6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  pd[0] = size-1;
ffffffff801092e9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff801092ec:	83 e8 01             	sub    $0x1,%eax
ffffffff801092ef:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff801092f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801092f7:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff801092fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801092ff:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff80109303:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
  pd[3] = (uintp)p >> 32;
ffffffff80109307:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010930b:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff8010930f:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff80109313:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109317:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff8010931b:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffffffff8010931f:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff80109323:	0f 01 10             	lgdt   (%rax)
}
ffffffff80109326:	90                   	nop
ffffffff80109327:	c9                   	leave
ffffffff80109328:	c3                   	ret

ffffffff80109329 <lidt>:
{
ffffffff80109329:	55                   	push   %rbp
ffffffff8010932a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010932d:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109331:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80109335:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  pd[0] = size-1;
ffffffff80109338:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff8010933b:	83 e8 01             	sub    $0x1,%eax
ffffffff8010933e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff80109342:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109346:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff8010934a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010934e:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff80109352:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
  pd[3] = (uintp)p >> 32;
ffffffff80109356:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010935a:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff8010935e:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff80109362:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109366:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff8010936a:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffffffff8010936e:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff80109372:	0f 01 18             	lidt   (%rax)
}
ffffffff80109375:	90                   	nop
ffffffff80109376:	c9                   	leave
ffffffff80109377:	c3                   	ret

ffffffff80109378 <ltr>:
{
ffffffff80109378:	55                   	push   %rbp
ffffffff80109379:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010937c:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80109380:	89 f8                	mov    %edi,%eax
ffffffff80109382:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffffffff80109386:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff8010938a:	0f 00 d8             	ltr    %eax
}
ffffffff8010938d:	90                   	nop
ffffffff8010938e:	c9                   	leave
ffffffff8010938f:	c3                   	ret

ffffffff80109390 <lcr3>:

static inline void
lcr3(uintp val) 
{
ffffffff80109390:	55                   	push   %rbp
ffffffff80109391:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109394:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80109398:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffffffff8010939c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093a0:	0f 22 d8             	mov    %rax,%cr3
}
ffffffff801093a3:	90                   	nop
ffffffff801093a4:	c9                   	leave
ffffffff801093a5:	c3                   	ret

ffffffff801093a6 <v2p>:
static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff801093a6:	55                   	push   %rbp
ffffffff801093a7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801093aa:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801093ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801093b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093b6:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff801093bb:	48 01 d0             	add    %rdx,%rax
ffffffff801093be:	c9                   	leave
ffffffff801093bf:	c3                   	ret

ffffffff801093c0 <tvinit>:
static pde_t *kpgdir0;
static pde_t *kpgdir1;

void wrmsr(uint msr, uint64 val);

void tvinit(void) {}
ffffffff801093c0:	f3 0f 1e fa          	endbr64
ffffffff801093c4:	55                   	push   %rbp
ffffffff801093c5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801093c8:	90                   	nop
ffffffff801093c9:	5d                   	pop    %rbp
ffffffff801093ca:	c3                   	ret

ffffffff801093cb <idtinit>:
void idtinit(void) {}
ffffffff801093cb:	f3 0f 1e fa          	endbr64
ffffffff801093cf:	55                   	push   %rbp
ffffffff801093d0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801093d3:	90                   	nop
ffffffff801093d4:	5d                   	pop    %rbp
ffffffff801093d5:	c3                   	ret

ffffffff801093d6 <mkgate>:

static void mkgate(uint *idt, uint n, void *kva, uint pl, uint trap) {
ffffffff801093d6:	f3 0f 1e fa          	endbr64
ffffffff801093da:	55                   	push   %rbp
ffffffff801093db:	48 89 e5             	mov    %rsp,%rbp
ffffffff801093de:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801093e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801093e6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff801093e9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffffffff801093ed:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffffffff801093f0:	44 89 45 d4          	mov    %r8d,-0x2c(%rbp)
  uint64 addr = (uint64) kva;
ffffffff801093f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801093f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  n *= 4;
ffffffff801093fc:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  trap = trap ? 0x8F00 : 0x8E00; // TRAP vs INTERRUPT gate;
ffffffff80109400:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff80109404:	74 07                	je     ffffffff8010940d <mkgate+0x37>
ffffffff80109406:	b8 00 8f 00 00       	mov    $0x8f00,%eax
ffffffff8010940b:	eb 05                	jmp    ffffffff80109412 <mkgate+0x3c>
ffffffff8010940d:	b8 00 8e 00 00       	mov    $0x8e00,%eax
ffffffff80109412:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | ((SEG_KCODE << 3) << 16);
ffffffff80109415:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109419:	0f b7 d0             	movzwl %ax,%edx
ffffffff8010941c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff8010941f:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffffffff80109426:	00 
ffffffff80109427:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010942b:	48 01 c8             	add    %rcx,%rax
ffffffff8010942e:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffffffff80109434:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | trap | ((pl & 3) << 13); // P=1 DPL=pl
ffffffff80109436:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010943a:	66 b8 00 00          	mov    $0x0,%ax
ffffffff8010943e:	0b 45 d4             	or     -0x2c(%rbp),%eax
ffffffff80109441:	89 c2                	mov    %eax,%edx
ffffffff80109443:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80109446:	c1 e0 0d             	shl    $0xd,%eax
ffffffff80109449:	25 00 60 00 00       	and    $0x6000,%eax
ffffffff8010944e:	89 c1                	mov    %eax,%ecx
ffffffff80109450:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109453:	83 c0 01             	add    $0x1,%eax
ffffffff80109456:	89 c0                	mov    %eax,%eax
ffffffff80109458:	48 8d 34 85 00 00 00 	lea    0x0(,%rax,4),%rsi
ffffffff8010945f:	00 
ffffffff80109460:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109464:	48 01 f0             	add    %rsi,%rax
ffffffff80109467:	09 ca                	or     %ecx,%edx
ffffffff80109469:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffffffff8010946b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010946f:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80109473:	48 89 c1             	mov    %rax,%rcx
ffffffff80109476:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109479:	83 c0 02             	add    $0x2,%eax
ffffffff8010947c:	89 c0                	mov    %eax,%eax
ffffffff8010947e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80109485:	00 
ffffffff80109486:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010948a:	48 01 d0             	add    %rdx,%rax
ffffffff8010948d:	89 ca                	mov    %ecx,%edx
ffffffff8010948f:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffffffff80109491:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109494:	83 c0 03             	add    $0x3,%eax
ffffffff80109497:	89 c0                	mov    %eax,%eax
ffffffff80109499:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff801094a0:	00 
ffffffff801094a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801094a5:	48 01 d0             	add    %rdx,%rax
ffffffff801094a8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffffffff801094ae:	90                   	nop
ffffffff801094af:	c9                   	leave
ffffffff801094b0:	c3                   	ret

ffffffff801094b1 <tss_set_rsp>:

static void tss_set_rsp(uint *tss, uint n, uint64 rsp) {
ffffffff801094b1:	f3 0f 1e fa          	endbr64
ffffffff801094b5:	55                   	push   %rbp
ffffffff801094b6:	48 89 e5             	mov    %rsp,%rbp
ffffffff801094b9:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff801094bd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801094c1:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff801094c4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  tss[n*2 + 1] = rsp;
ffffffff801094c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801094cb:	01 c0                	add    %eax,%eax
ffffffff801094cd:	83 c0 01             	add    $0x1,%eax
ffffffff801094d0:	89 c0                	mov    %eax,%eax
ffffffff801094d2:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff801094d9:	00 
ffffffff801094da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801094de:	48 01 d0             	add    %rdx,%rax
ffffffff801094e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff801094e5:	89 10                	mov    %edx,(%rax)
  tss[n*2 + 2] = rsp >> 32;
ffffffff801094e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801094eb:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff801094ef:	48 89 c1             	mov    %rax,%rcx
ffffffff801094f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801094f5:	83 c0 01             	add    $0x1,%eax
ffffffff801094f8:	01 c0                	add    %eax,%eax
ffffffff801094fa:	89 c0                	mov    %eax,%eax
ffffffff801094fc:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80109503:	00 
ffffffff80109504:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109508:	48 01 d0             	add    %rdx,%rax
ffffffff8010950b:	89 ca                	mov    %ecx,%edx
ffffffff8010950d:	89 10                	mov    %edx,(%rax)
}
ffffffff8010950f:	90                   	nop
ffffffff80109510:	c9                   	leave
ffffffff80109511:	c3                   	ret

ffffffff80109512 <tss_set_ist>:

static void tss_set_ist(uint *tss, uint n, uint64 ist) {
ffffffff80109512:	f3 0f 1e fa          	endbr64
ffffffff80109516:	55                   	push   %rbp
ffffffff80109517:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010951a:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010951e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80109522:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80109525:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  tss[n*2 + 7] = ist;
ffffffff80109529:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010952c:	01 c0                	add    %eax,%eax
ffffffff8010952e:	83 c0 07             	add    $0x7,%eax
ffffffff80109531:	89 c0                	mov    %eax,%eax
ffffffff80109533:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010953a:	00 
ffffffff8010953b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010953f:	48 01 d0             	add    %rdx,%rax
ffffffff80109542:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80109546:	89 10                	mov    %edx,(%rax)
  tss[n*2 + 8] = ist >> 32;
ffffffff80109548:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010954c:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80109550:	48 89 c1             	mov    %rax,%rcx
ffffffff80109553:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80109556:	83 c0 04             	add    $0x4,%eax
ffffffff80109559:	01 c0                	add    %eax,%eax
ffffffff8010955b:	89 c0                	mov    %eax,%eax
ffffffff8010955d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80109564:	00 
ffffffff80109565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109569:	48 01 d0             	add    %rdx,%rax
ffffffff8010956c:	89 ca                	mov    %ecx,%edx
ffffffff8010956e:	89 10                	mov    %edx,(%rax)
}
ffffffff80109570:	90                   	nop
ffffffff80109571:	c9                   	leave
ffffffff80109572:	c3                   	ret

ffffffff80109573 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffffffff80109573:	f3 0f 1e fa          	endbr64
ffffffff80109577:	55                   	push   %rbp
ffffffff80109578:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010957b:	48 83 ec 40          	sub    $0x40,%rsp
  uint64 *gdt;
  uint *tss;
  uint64 addr;
  void *local;
  struct cpu *c;
  uint *idt = (uint*) kalloc();
ffffffff8010957f:	e8 49 9e ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80109584:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  int n;
  memset(idt, 0, PGSIZE);
ffffffff80109588:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010958c:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80109591:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109596:	48 89 c7             	mov    %rax,%rdi
ffffffff80109599:	e8 a1 cb ff ff       	call   ffffffff8010613f <memset>

  for (n = 0; n < 256; n++)
ffffffff8010959e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801095a5:	eb 2b                	jmp    ffffffff801095d2 <seginit+0x5f>
    mkgate(idt, n, vectors[n], 0, 0);
ffffffff801095a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801095aa:	48 98                	cltq
ffffffff801095ac:	48 8b 14 c5 b0 b6 10 	mov    -0x7fef4950(,%rax,8),%rdx
ffffffff801095b3:	80 
ffffffff801095b4:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffffffff801095b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801095bb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffffffff801095c1:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff801095c6:	48 89 c7             	mov    %rax,%rdi
ffffffff801095c9:	e8 08 fe ff ff       	call   ffffffff801093d6 <mkgate>
  for (n = 0; n < 256; n++)
ffffffff801095ce:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801095d2:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffffffff801095d9:	7e cc                	jle    ffffffff801095a7 <seginit+0x34>
  mkgate(idt, 64, vectors[64], 3, 1);
ffffffff801095db:	48 8b 15 ce 22 00 00 	mov    0x22ce(%rip),%rdx        # ffffffff8010b8b0 <vectors+0x200>
ffffffff801095e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801095e6:	41 b8 01 00 00 00    	mov    $0x1,%r8d
ffffffff801095ec:	b9 03 00 00 00       	mov    $0x3,%ecx
ffffffff801095f1:	be 40 00 00 00       	mov    $0x40,%esi
ffffffff801095f6:	48 89 c7             	mov    %rax,%rdi
ffffffff801095f9:	e8 d8 fd ff ff       	call   ffffffff801093d6 <mkgate>

  lidt((void*) idt, PGSIZE);
ffffffff801095fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109602:	be 00 10 00 00       	mov    $0x1000,%esi
ffffffff80109607:	48 89 c7             	mov    %rax,%rdi
ffffffff8010960a:	e8 1a fd ff ff       	call   ffffffff80109329 <lidt>

  // create a page for cpu local storage 
  local = kalloc();
ffffffff8010960f:	e8 b9 9d ff ff       	call   ffffffff801033cd <kalloc>
ffffffff80109614:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  memset(local, 0, PGSIZE);
ffffffff80109618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010961c:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80109621:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109626:	48 89 c7             	mov    %rax,%rdi
ffffffff80109629:	e8 11 cb ff ff       	call   ffffffff8010613f <memset>

  gdt = (uint64*) local;
ffffffff8010962e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109632:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffffffff80109636:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010963a:	48 05 00 04 00 00    	add    $0x400,%rax
ffffffff80109640:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffffffff80109644:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80109648:	48 83 c0 40          	add    $0x40,%rax
ffffffff8010964c:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + (PGSIZE / 2));
ffffffff80109652:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109656:	48 05 00 08 00 00    	add    $0x800,%rax
ffffffff8010965c:	48 89 c6             	mov    %rax,%rsi
ffffffff8010965f:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffffffff80109664:	e8 b2 6a ff ff       	call   ffffffff8010011b <wrmsr>

  c = &cpus[cpunum()];
ffffffff80109669:	e8 e2 a0 ff ff       	call   ffffffff80103750 <cpunum>
ffffffff8010966e:	48 63 d0             	movslq %eax,%rdx
ffffffff80109671:	48 89 d0             	mov    %rdx,%rax
ffffffff80109674:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80109678:	48 29 d0             	sub    %rdx,%rax
ffffffff8010967b:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010967f:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80109685:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  c->local = local;
ffffffff80109689:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010968d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80109691:	48 89 90 e8 00 00 00 	mov    %rdx,0xe8(%rax)

  cpu = c;
ffffffff80109698:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010969c:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffffffff801096a3:	ff ff 
  proc = 0;
ffffffff801096a5:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffffffff801096ac:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffffffff801096b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801096b6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  gdt[0] =         0x0000000000000000;
ffffffff801096ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801096be:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_KCODE] = 0x0020980000000000;  // Code, DPL=0, R/X
ffffffff801096c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801096c9:	48 83 c0 08          	add    $0x8,%rax
ffffffff801096cd:	48 b9 00 00 00 00 00 	movabs $0x20980000000000,%rcx
ffffffff801096d4:	98 20 00 
ffffffff801096d7:	48 89 08             	mov    %rcx,(%rax)
  gdt[SEG_UCODE] = 0x0020F80000000000;  // Code, DPL=3, R/X
ffffffff801096da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801096de:	48 83 c0 20          	add    $0x20,%rax
ffffffff801096e2:	48 bf 00 00 00 00 00 	movabs $0x20f80000000000,%rdi
ffffffff801096e9:	f8 20 00 
ffffffff801096ec:	48 89 38             	mov    %rdi,(%rax)
  gdt[SEG_KDATA] = 0x0000920000000000;  // Data, DPL=0, W
ffffffff801096ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801096f3:	48 83 c0 10          	add    $0x10,%rax
ffffffff801096f7:	48 b9 00 00 00 00 00 	movabs $0x920000000000,%rcx
ffffffff801096fe:	92 00 00 
ffffffff80109701:	48 89 08             	mov    %rcx,(%rax)
  gdt[SEG_KCPU]  = 0x0000000000000000;  // unused
ffffffff80109704:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109708:	48 83 c0 18          	add    $0x18,%rax
ffffffff8010970c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = 0x0000F20000000000;  // Data, DPL=3, W
ffffffff80109713:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109717:	48 83 c0 28          	add    $0x28,%rax
ffffffff8010971b:	48 be 00 00 00 00 00 	movabs $0xf20000000000,%rsi
ffffffff80109722:	f2 00 00 
ffffffff80109725:	48 89 30             	mov    %rsi,(%rax)
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff80109728:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010972c:	48 c1 e0 10          	shl    $0x10,%rax
ffffffff80109730:	48 89 c2             	mov    %rax,%rdx
ffffffff80109733:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
ffffffff8010973a:	00 00 00 
ffffffff8010973d:	48 21 c2             	and    %rax,%rdx
                   (0x00E9LL << 40) | (((addr >> 24) & 0xFF) << 56);
ffffffff80109740:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80109744:	48 c1 e8 18          	shr    $0x18,%rax
ffffffff80109748:	48 c1 e0 38          	shl    $0x38,%rax
ffffffff8010974c:	48 89 d1             	mov    %rdx,%rcx
ffffffff8010974f:	48 09 c1             	or     %rax,%rcx
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff80109752:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109756:	48 83 c0 30          	add    $0x30,%rax
                   (0x00E9LL << 40) | (((addr >> 24) & 0xFF) << 56);
ffffffff8010975a:	48 ba 67 00 00 00 00 	movabs $0xe90000000067,%rdx
ffffffff80109761:	e9 00 00 
ffffffff80109764:	48 09 ca             	or     %rcx,%rdx
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff80109767:	48 89 10             	mov    %rdx,(%rax)
  gdt[SEG_TSS+1] = (addr >> 32);
ffffffff8010976a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010976e:	48 83 c0 38          	add    $0x38,%rax
ffffffff80109772:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffffffff80109776:	48 c1 ea 20          	shr    $0x20,%rdx
ffffffff8010977a:	48 89 10             	mov    %rdx,(%rax)

  lgdt((void*) gdt, 8 * sizeof(uint64));
ffffffff8010977d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109781:	be 40 00 00 00       	mov    $0x40,%esi
ffffffff80109786:	48 89 c7             	mov    %rax,%rdi
ffffffff80109789:	e8 4c fb ff ff       	call   ffffffff801092da <lgdt>

  ltr(SEG_TSS << 3);
ffffffff8010978e:	bf 30 00 00 00       	mov    $0x30,%edi
ffffffff80109793:	e8 e0 fb ff ff       	call   ffffffff80109378 <ltr>
};
ffffffff80109798:	90                   	nop
ffffffff80109799:	c9                   	leave
ffffffff8010979a:	c3                   	ret

ffffffff8010979b <setupkvm>:
// because we need to find the other levels later, we'll stash
// backpointers to them in the top two entries of the level two
// table.
pde_t*
setupkvm(void)
{
ffffffff8010979b:	f3 0f 1e fa          	endbr64
ffffffff8010979f:	55                   	push   %rbp
ffffffff801097a0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801097a3:	48 83 ec 20          	sub    $0x20,%rsp
  pde_t *pml4 = (pde_t*) kalloc();
ffffffff801097a7:	e8 21 9c ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801097ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pde_t *pdpt = (pde_t*) kalloc();
ffffffff801097b0:	e8 18 9c ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801097b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  pde_t *pgdir = (pde_t*) kalloc();
ffffffff801097b9:	e8 0f 9c ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801097be:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  memset(pml4, 0, PGSIZE);
ffffffff801097c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801097c6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801097cb:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801097d0:	48 89 c7             	mov    %rax,%rdi
ffffffff801097d3:	e8 67 c9 ff ff       	call   ffffffff8010613f <memset>
  memset(pdpt, 0, PGSIZE);
ffffffff801097d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801097dc:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801097e1:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801097e6:	48 89 c7             	mov    %rax,%rdi
ffffffff801097e9:	e8 51 c9 ff ff       	call   ffffffff8010613f <memset>
  memset(pgdir, 0, PGSIZE);
ffffffff801097ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801097f2:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801097f7:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801097fc:	48 89 c7             	mov    %rax,%rdi
ffffffff801097ff:	e8 3b c9 ff ff       	call   ffffffff8010613f <memset>
  pml4[511] = v2p(kpdpt) | PTE_P | PTE_W | PTE_U;
ffffffff80109804:	48 8b 05 55 b1 00 00 	mov    0xb155(%rip),%rax        # ffffffff80114960 <kpdpt>
ffffffff8010980b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010980e:	e8 93 fb ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109813:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80109817:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff8010981e:	48 83 c8 07          	or     $0x7,%rax
ffffffff80109822:	48 89 02             	mov    %rax,(%rdx)
  pml4[0] = v2p(pdpt) | PTE_P | PTE_W | PTE_U;
ffffffff80109825:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109829:	48 89 c7             	mov    %rax,%rdi
ffffffff8010982c:	e8 75 fb ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109831:	48 83 c8 07          	or     $0x7,%rax
ffffffff80109835:	48 89 c2             	mov    %rax,%rdx
ffffffff80109838:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010983c:	48 89 10             	mov    %rdx,(%rax)
  pdpt[0] = v2p(pgdir) | PTE_P | PTE_W | PTE_U; 
ffffffff8010983f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109843:	48 89 c7             	mov    %rax,%rdi
ffffffff80109846:	e8 5b fb ff ff       	call   ffffffff801093a6 <v2p>
ffffffff8010984b:	48 83 c8 07          	or     $0x7,%rax
ffffffff8010984f:	48 89 c2             	mov    %rax,%rdx
ffffffff80109852:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109856:	48 89 10             	mov    %rdx,(%rax)

  // virtual backpointers
  pgdir[511] = ((uintp) pml4) | PTE_P;
ffffffff80109859:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010985d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109861:	48 05 f8 0f 00 00    	add    $0xff8,%rax
ffffffff80109867:	48 83 ca 01          	or     $0x1,%rdx
ffffffff8010986b:	48 89 10             	mov    %rdx,(%rax)
  pgdir[510] = ((uintp) pdpt) | PTE_P;
ffffffff8010986e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80109872:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109876:	48 05 f0 0f 00 00    	add    $0xff0,%rax
ffffffff8010987c:	48 83 ca 01          	or     $0x1,%rdx
ffffffff80109880:	48 89 10             	mov    %rdx,(%rax)

  return pgdir;
ffffffff80109883:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
};
ffffffff80109887:	c9                   	leave
ffffffff80109888:	c3                   	ret

ffffffff80109889 <kvmalloc>:
// space for scheduler processes.
//
// linear map the first 4GB of physical memory starting at 0xFFFFFFFF80000000
void
kvmalloc(void)
{
ffffffff80109889:	f3 0f 1e fa          	endbr64
ffffffff8010988d:	55                   	push   %rbp
ffffffff8010988e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109891:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  kpml4 = (pde_t*) kalloc();
ffffffff80109895:	e8 33 9b ff ff       	call   ffffffff801033cd <kalloc>
ffffffff8010989a:	48 89 05 b7 b0 00 00 	mov    %rax,0xb0b7(%rip)        # ffffffff80114958 <kpml4>
  kpdpt = (pde_t*) kalloc();
ffffffff801098a1:	e8 27 9b ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801098a6:	48 89 05 b3 b0 00 00 	mov    %rax,0xb0b3(%rip)        # ffffffff80114960 <kpdpt>
  kpgdir0 = (pde_t*) kalloc();
ffffffff801098ad:	e8 1b 9b ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801098b2:	48 89 05 b7 b0 00 00 	mov    %rax,0xb0b7(%rip)        # ffffffff80114970 <kpgdir0>
  kpgdir1 = (pde_t*) kalloc();
ffffffff801098b9:	e8 0f 9b ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801098be:	48 89 05 b3 b0 00 00 	mov    %rax,0xb0b3(%rip)        # ffffffff80114978 <kpgdir1>
  iopgdir = (pde_t*) kalloc();
ffffffff801098c5:	e8 03 9b ff ff       	call   ffffffff801033cd <kalloc>
ffffffff801098ca:	48 89 05 97 b0 00 00 	mov    %rax,0xb097(%rip)        # ffffffff80114968 <iopgdir>
  memset(kpml4, 0, PGSIZE);
ffffffff801098d1:	48 8b 05 80 b0 00 00 	mov    0xb080(%rip),%rax        # ffffffff80114958 <kpml4>
ffffffff801098d8:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801098dd:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801098e2:	48 89 c7             	mov    %rax,%rdi
ffffffff801098e5:	e8 55 c8 ff ff       	call   ffffffff8010613f <memset>
  memset(kpdpt, 0, PGSIZE);
ffffffff801098ea:	48 8b 05 6f b0 00 00 	mov    0xb06f(%rip),%rax        # ffffffff80114960 <kpdpt>
ffffffff801098f1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801098f6:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801098fb:	48 89 c7             	mov    %rax,%rdi
ffffffff801098fe:	e8 3c c8 ff ff       	call   ffffffff8010613f <memset>
  memset(iopgdir, 0, PGSIZE);
ffffffff80109903:	48 8b 05 5e b0 00 00 	mov    0xb05e(%rip),%rax        # ffffffff80114968 <iopgdir>
ffffffff8010990a:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff8010990f:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109914:	48 89 c7             	mov    %rax,%rdi
ffffffff80109917:	e8 23 c8 ff ff       	call   ffffffff8010613f <memset>
  kpml4[511] = v2p(kpdpt) | PTE_P | PTE_W;
ffffffff8010991c:	48 8b 05 3d b0 00 00 	mov    0xb03d(%rip),%rax        # ffffffff80114960 <kpdpt>
ffffffff80109923:	48 89 c7             	mov    %rax,%rdi
ffffffff80109926:	e8 7b fa ff ff       	call   ffffffff801093a6 <v2p>
ffffffff8010992b:	48 8b 15 26 b0 00 00 	mov    0xb026(%rip),%rdx        # ffffffff80114958 <kpml4>
ffffffff80109932:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff80109939:	48 83 c8 03          	or     $0x3,%rax
ffffffff8010993d:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[511] = v2p(kpgdir1) | PTE_P | PTE_W;
ffffffff80109940:	48 8b 05 31 b0 00 00 	mov    0xb031(%rip),%rax        # ffffffff80114978 <kpgdir1>
ffffffff80109947:	48 89 c7             	mov    %rax,%rdi
ffffffff8010994a:	e8 57 fa ff ff       	call   ffffffff801093a6 <v2p>
ffffffff8010994f:	48 8b 15 0a b0 00 00 	mov    0xb00a(%rip),%rdx        # ffffffff80114960 <kpdpt>
ffffffff80109956:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff8010995d:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109961:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[510] = v2p(kpgdir0) | PTE_P | PTE_W;
ffffffff80109964:	48 8b 05 05 b0 00 00 	mov    0xb005(%rip),%rax        # ffffffff80114970 <kpgdir0>
ffffffff8010996b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010996e:	e8 33 fa ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109973:	48 8b 15 e6 af 00 00 	mov    0xafe6(%rip),%rdx        # ffffffff80114960 <kpdpt>
ffffffff8010997a:	48 81 c2 f0 0f 00 00 	add    $0xff0,%rdx
ffffffff80109981:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109985:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[509] = v2p(iopgdir) | PTE_P | PTE_W;
ffffffff80109988:	48 8b 05 d9 af 00 00 	mov    0xafd9(%rip),%rax        # ffffffff80114968 <iopgdir>
ffffffff8010998f:	48 89 c7             	mov    %rax,%rdi
ffffffff80109992:	e8 0f fa ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109997:	48 8b 15 c2 af 00 00 	mov    0xafc2(%rip),%rdx        # ffffffff80114960 <kpdpt>
ffffffff8010999e:	48 81 c2 e8 0f 00 00 	add    $0xfe8,%rdx
ffffffff801099a5:	48 83 c8 03          	or     $0x3,%rax
ffffffff801099a9:	48 89 02             	mov    %rax,(%rdx)
  for (n = 0; n < NPDENTRIES; n++) {
ffffffff801099ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801099b3:	eb 51                	jmp    ffffffff80109a06 <kvmalloc+0x17d>
    kpgdir0[n] = (n << PDXSHIFT) | PTE_PS | PTE_P | PTE_W;
ffffffff801099b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801099b8:	c1 e0 15             	shl    $0x15,%eax
ffffffff801099bb:	0c 83                	or     $0x83,%al
ffffffff801099bd:	89 c1                	mov    %eax,%ecx
ffffffff801099bf:	48 8b 05 aa af 00 00 	mov    0xafaa(%rip),%rax        # ffffffff80114970 <kpgdir0>
ffffffff801099c6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801099c9:	48 63 d2             	movslq %edx,%rdx
ffffffff801099cc:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff801099d0:	48 01 c2             	add    %rax,%rdx
ffffffff801099d3:	48 63 c1             	movslq %ecx,%rax
ffffffff801099d6:	48 89 02             	mov    %rax,(%rdx)
    kpgdir1[n] = ((n + 512) << PDXSHIFT) | PTE_PS | PTE_P | PTE_W;
ffffffff801099d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801099dc:	05 00 02 00 00       	add    $0x200,%eax
ffffffff801099e1:	c1 e0 15             	shl    $0x15,%eax
ffffffff801099e4:	0c 83                	or     $0x83,%al
ffffffff801099e6:	89 c1                	mov    %eax,%ecx
ffffffff801099e8:	48 8b 05 89 af 00 00 	mov    0xaf89(%rip),%rax        # ffffffff80114978 <kpgdir1>
ffffffff801099ef:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801099f2:	48 63 d2             	movslq %edx,%rdx
ffffffff801099f5:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff801099f9:	48 01 c2             	add    %rax,%rdx
ffffffff801099fc:	48 63 c1             	movslq %ecx,%rax
ffffffff801099ff:	48 89 02             	mov    %rax,(%rdx)
  for (n = 0; n < NPDENTRIES; n++) {
ffffffff80109a02:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80109a06:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
ffffffff80109a0d:	7e a6                	jle    ffffffff801099b5 <kvmalloc+0x12c>
  }
  for (n = 0; n < 16; n++)
ffffffff80109a0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80109a16:	eb 2c                	jmp    ffffffff80109a44 <kvmalloc+0x1bb>
    iopgdir[n] = (DEVSPACE + (n << PDXSHIFT)) | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffffffff80109a18:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80109a1b:	c1 e0 15             	shl    $0x15,%eax
ffffffff80109a1e:	2d 00 00 00 02       	sub    $0x2000000,%eax
ffffffff80109a23:	0c 9b                	or     $0x9b,%al
ffffffff80109a25:	89 c1                	mov    %eax,%ecx
ffffffff80109a27:	48 8b 05 3a af 00 00 	mov    0xaf3a(%rip),%rax        # ffffffff80114968 <iopgdir>
ffffffff80109a2e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80109a31:	48 63 d2             	movslq %edx,%rdx
ffffffff80109a34:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff80109a38:	48 01 d0             	add    %rdx,%rax
ffffffff80109a3b:	89 ca                	mov    %ecx,%edx
ffffffff80109a3d:	48 89 10             	mov    %rdx,(%rax)
  for (n = 0; n < 16; n++)
ffffffff80109a40:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80109a44:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffffffff80109a48:	7e ce                	jle    ffffffff80109a18 <kvmalloc+0x18f>
  switchkvm();
ffffffff80109a4a:	e8 03 00 00 00       	call   ffffffff80109a52 <switchkvm>
}
ffffffff80109a4f:	90                   	nop
ffffffff80109a50:	c9                   	leave
ffffffff80109a51:	c3                   	ret

ffffffff80109a52 <switchkvm>:

void
switchkvm(void)
{
ffffffff80109a52:	f3 0f 1e fa          	endbr64
ffffffff80109a56:	55                   	push   %rbp
ffffffff80109a57:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffffffff80109a5a:	48 8b 05 f7 ae 00 00 	mov    0xaef7(%rip),%rax        # ffffffff80114958 <kpml4>
ffffffff80109a61:	48 89 c7             	mov    %rax,%rdi
ffffffff80109a64:	e8 3d f9 ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109a69:	48 89 c7             	mov    %rax,%rdi
ffffffff80109a6c:	e8 1f f9 ff ff       	call   ffffffff80109390 <lcr3>
}
ffffffff80109a71:	90                   	nop
ffffffff80109a72:	5d                   	pop    %rbp
ffffffff80109a73:	c3                   	ret

ffffffff80109a74 <switchuvm>:

void
switchuvm(struct proc *p)
{
ffffffff80109a74:	f3 0f 1e fa          	endbr64
ffffffff80109a78:	55                   	push   %rbp
ffffffff80109a79:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109a7c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109a80:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  void *pml4;
  uint *tss;
  pushcli();
ffffffff80109a84:	e8 71 c5 ff ff       	call   ffffffff80105ffa <pushcli>
  if(p->pgdir == 0)
ffffffff80109a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109a8d:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109a91:	48 85 c0             	test   %rax,%rax
ffffffff80109a94:	75 0c                	jne    ffffffff80109aa2 <switchuvm+0x2e>
    panic("switchuvm: no pgdir");
ffffffff80109a96:	48 c7 c7 c6 a2 10 80 	mov    $0xffffffff8010a2c6,%rdi
ffffffff80109a9d:	e8 ad 6e ff ff       	call   ffffffff8010094f <panic>
  tss = (uint*) (((char*) cpu->local) + 1024);
ffffffff80109aa2:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffffffff80109aa9:	ff ff 
ffffffff80109aab:	48 8b 80 e8 00 00 00 	mov    0xe8(%rax),%rax
ffffffff80109ab2:	48 05 00 04 00 00    	add    $0x400,%rax
ffffffff80109ab8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  tss_set_rsp(tss, 0, (uintp)proc->kstack + KSTACKSIZE);
ffffffff80109abc:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffffffff80109ac3:	ff ff 
ffffffff80109ac5:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80109ac9:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffffffff80109ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109ad4:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109ad9:	48 89 c7             	mov    %rax,%rdi
ffffffff80109adc:	e8 d0 f9 ff ff       	call   ffffffff801094b1 <tss_set_rsp>
  pml4 = (void*) PTE_ADDR(p->pgdir[511]);
ffffffff80109ae1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109ae5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109ae9:	48 05 f8 0f 00 00    	add    $0xff8,%rax
ffffffff80109aef:	48 8b 00             	mov    (%rax),%rax
ffffffff80109af2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80109af8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  lcr3(v2p(pml4));
ffffffff80109afc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109b00:	48 89 c7             	mov    %rax,%rdi
ffffffff80109b03:	e8 9e f8 ff ff       	call   ffffffff801093a6 <v2p>
ffffffff80109b08:	48 89 c7             	mov    %rax,%rdi
ffffffff80109b0b:	e8 80 f8 ff ff       	call   ffffffff80109390 <lcr3>
  popcli();
ffffffff80109b10:	e8 39 c5 ff ff       	call   ffffffff8010604e <popcli>
}
ffffffff80109b15:	90                   	nop
ffffffff80109b16:	c9                   	leave
ffffffff80109b17:	c3                   	ret
