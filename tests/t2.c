#include <stdio.h>

#include "riscv-disas.h"

#define array_size(arr) (sizeof(arr) / sizeof(arr[0]))

void dissassemble(uint64_t pc, const uint8_t *data, size_t data_len)
{
    char buf[128] = { 0 };
    size_t offset = 0, inst_len;
    rv_inst inst;
    while (offset < data_len)
    {
        inst_fetch(data + offset, &inst, &inst_len);
        disasm_inst(buf, sizeof(buf), rv64, pc + offset, inst);
        printf("0x%" PRIx64 ":  %s\n", pc + offset, buf);
        offset += inst_len;
    }
}

void t1()
{
    static const uint8_t inst_arr[] = {
        0x00, 0x00, // illegal
        0x00, 0x01, // nop
        0x00, 0x0d, // addi zero,zero,3
        0x01, 0x04, // mv s0,s0
        0x04, 0x04, // addi s1,sp,512
        0x05, 0x40, // addi  s0,s0,1
        0x73, 0x25, 0x40, 0xf1, // csrrs a0,mhartid,zero
        0x97, 0x05, 0x00, 0x00, // auipc a1,0
        0xb7, 0x02, 0x40, 0x20, // lui t0,541065216
        0x13, 0x00, 0x00, 0x00, // nop
    };
    dissassemble(0x10078, inst_arr, array_size(inst_arr));
}

int main()
{
    t1();
}
