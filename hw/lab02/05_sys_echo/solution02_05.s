.intel_syntax noprefix
.text
.global main

.section .rodata
prefix: .asciz "ECHO: "

.section .bss
buffer: .space 64

.text
main:
    mov rdi, 0
    lea rsi, [rip + buffer]
    mov rdx, 64
    mov rax, 0
    syscall

    cmp rax, 0
    jle exit

    mov r8, rax

    mov rdi, 1
    lea rsi, [rip + prefix]
    mov rdx, 6
    mov rax, 1
    syscall

    mov rdi, 1
    lea rsi, [rip + buffer]
    mov rdx, r8
    mov rax, 1
    syscall

exit:
    mov rdi, 0
    mov rax, 60
    syscall
