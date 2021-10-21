cmake_minimum_required (VERSION 3.12)
project(riscv-disassembler VERSION 0.0.1)
enable_testing()

include_directories(src)
add_library(rvasm src/riscv-disas.c)

foreach(test t1 t2)
	add_executable(${test} tests/${test}.c)
	target_link_libraries(${test} rvasm)
	add_test(TEST-DECODE ${test})
endforeach()