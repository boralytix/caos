.intel_syntax noprefix

.include "simpleio_x86_64.S"

.section .text
.global _start

_start:
    call readi64
    cmp edx, 0
    jg .too_large_positive
    jl .check_negative
    jmp .output_number

.check_negative:
    cmp edx, 0xFFFFFFFF
    je .output_number
    jmp .too_small_negative

.too_large_positive:
    mov eax, 0x7FFFFFFF
    jmp .output

.too_small_negative:
    mov eax, 0x80000000
    jmp .output

.output_number:

.output:
    call writei32
    call nl
    call finish
.global main
