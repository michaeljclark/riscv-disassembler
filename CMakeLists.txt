cmake_minimum_required (VERSION 3.12)
project(riscv-disassembler VERSION 0.0.1)
enable_testing()

add_library(rvasm src/riscv-disas.c)

add_executable(test_encode src/test-encode.c)
target_link_libraries(test_encode rvasm)
add_test(TEST-DECODE test_encode)

add_executable(test_decode src/test-decode.c)
target_link_libraries(test_decode rvasm)
add_test(TEST-ENCODE test_decode)
