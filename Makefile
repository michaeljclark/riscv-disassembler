RISCV_DISAS_OBJ = obj/riscv-disas.o
RISCV_DISAS_LIB = lib/riscv-disas.a

PROGRAMS = bin/test-disas bin/test-encode

all: $(PROGRAMS)

clean:
	rm -fr obj lib bin

obj/%.o: src/%.c
	@echo CC $@ ; mkdir -p $(@D) ; $(CC) $(CFLAGS) -c $^ -o $@

bin/%: obj/%.o $(RISCV_DISAS_LIB)
	@echo LD $@ ; mkdir -p $(@D) ; $(CC) $(CFLAGS) $^ -o $@

lib/riscv-disas.a: $(RISCV_DISAS_OBJ)
	@echo AR $@ ; mkdir -p $(@D) ; $(AR) cr $@ $^
