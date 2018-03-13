#include <stdio.h>

#include "riscv-disas.h"

void print_insn(uint64_t pc, uint64_t inst)
{
    char buf[128] = { 0 };
    disasm_inst(buf, sizeof(buf), rv64, pc, inst);
    printf("0x%" PRIx64 ":  %s\n", pc, buf);
}

int main()
{
    print_insn(0x10000, 0xf1402573);
    print_insn(0x10004, 0x00000597);
    print_insn(0x10008, 0x01058593);
    print_insn(0x1000c, 0x204002b7);
}
