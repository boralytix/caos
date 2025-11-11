.intel_syntax noprefix
.text
.globl  main

.include "simpleio_x86_64.S"

main:
    call readi32
    cmp eax, 0
    jl finish
    mov ecx, eax

loop:
    mov eax, ecx
    call writei32
    call nl
    cmp ecx, 0
    je finish
    dec ecx
    jmp loop
