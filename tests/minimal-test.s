.option rvc
.globl _start
_start:
.half 0         # unimp
.half 1         # c.nop
.half 0xd       # c.nop 3
.half 0x401     # illegal (c.addi 0)
addi          s1,sp,512
addi          s0,s0,1
csrrs         a0,mhartid,zero
auipc         a1,0
lui           t0,132096
.half 0x13      # nop
.word 0
