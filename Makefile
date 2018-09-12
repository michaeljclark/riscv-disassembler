RISCV_PREFIX ?= riscv64-unknown-elf-
RISCV_DISAS_OBJ = build/obj/riscv-disas.o
RISCV_DISAS_LIB = build/lib/riscv-disas.a

CFLAGS = -O2
PROGRAMS = build/bin/test-disas build/bin/test-encode
TESTS = build/tests/minimal-test.txt

all: $(PROGRAMS) $(TESTS)

clean:
	rm -fr build

test: all
	cat build/tests/minimal-test.txt
	./build/bin/test-disas

build/obj/%.o: src/%.c
	@echo CC $@ ; mkdir -p $(@D) ; $(CC) $(CFLAGS) -c $^ -o $@

build/bin/%: build/obj/%.o $(RISCV_DISAS_LIB)
	@echo LD $@ ; mkdir -p $(@D) ; $(CC) $(CFLAGS) $^ -o $@

build/lib/riscv-disas.a: $(RISCV_DISAS_OBJ)
	@echo AR $@ ; mkdir -p $(@D) ; $(AR) cr $@ $^

build/tests/%.txt: build/tests/%.bin
	@echo CC $@ ; mkdir -p $(@D) ; $(RISCV_PREFIX)objdump -d $^ > $@

build/tests/%.bin: tests/%.s
	@echo CC $@ ; mkdir -p $(@D) ; $(RISCV_PREFIX)gcc -nostdlib $^ -o $@
