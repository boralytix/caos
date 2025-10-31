.intel_syntax noprefix

.text
.align 16
.global readi32
readi32:
    push rbp
    mov  rbp, rsp

    sub  rsp, 24
    xor  eax, eax
    lea  rdi, [rip + .L2]    # "%d"
    mov  rsi, rsp            # адрес буфера под int
    call scanf
    mov  ecx, eax            # сколько полей считано
    mov  eax, dword ptr [rsp]# прочитанное значение в EAX
    clc
    cmp  ecx, 1
    je   .L1
    stc
.L1:
    lea  rsp, [rsp + 24]
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L2:
    .asciz "%d"

.text
.align 16
.global writei32
writei32:
    push rbp
    mov  rbp, rsp
    mov  esi, edi
    xor  eax, eax
    lea  rdi, [rip + .L3]
    call printf
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L3:
    .asciz "%d"

.text
.align 16
.global finish
finish:
    xor  edi, edi            # exit(0)
    call exit

.text
.align 16
.global nl
nl:
    push rbp
    mov  rbp, rsp
    mov  edi, 10             # '\n'
    call putchar
    pop  rbp
    ret

.text
.align 16
.global readi64
readi64:
    push rbp
    mov  rbp, rsp

    sub  rsp, 24
    xor  eax, eax
    lea  rdi, [rip + .L4]    # "%lld"
    mov  rsi, rsp            # адрес буфера под long long
    call scanf
    mov  ecx, eax
    mov  rax, qword ptr [rsp]   # полное 64-битное число в RAX
    mov  rdx, rax               # скопировать в RDX
    sar  rdx, 32                # арифм. сдвиг → старшие 32 бита со знаком в EDX
    clc
    cmp  ecx, 1
    je   .L5
    stc
.L5:
    lea  rsp, [rsp + 24]
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L4:
    .asciz "%lld"

.text
.align 16
.global writei64
writei64:
    push rbp
    mov  rbp, rsp
    mov  rsi, rdi
    xor  eax, eax
    lea  rdi, [rip + .L6]
    call printf
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L6:
    .asciz "%lld"

# убрать предупреждение про исполняемый стек
.section .note.GNU-stack,"",@progbits
