.intel_syntax noprefix

.text
.align 16
.global readi32
readi32:
    push rbp
    mov  rbp, rsp

    sub  rsp, 32               # было 24 — ломало 16-байтное выравнивание
    xor  eax, eax
    lea  rdi, [rip + .L2]      # "%d"
    mov  rsi, rsp              # буфер под int
    call scanf
    mov  ecx, eax
    mov  eax, dword ptr [rsp]
    clc
    cmp  ecx, 1
    je   .L1
    stc
.L1:
    add  rsp, 32               # было 24
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L2: .asciz "%d"

.text
.align 16
.global writei32
writei32:
    push rbp
    mov  rbp, rsp
    mov  esi, edi
    xor  eax, eax              # для varargs
    lea  rdi, [rip + .L3]      # "%d"
    call printf
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L3: .asciz "%d"

.text
.align 16
.global finish
finish:
    xor  edi, edi
    call exit

.text
.align 16
.global nl
nl:
    push rbp
    mov  rbp, rsp
    mov  edi, 10               # '\n'
    call putchar
    pop  rbp
    ret

.text
.align 16
.global readi64
readi64:
    push rbp
    mov  rbp, rsp

    sub  rsp, 32               # было 24 — выравниваем на 16 перед scanf
    xor  eax, eax
    lea  rdi, [rip + .L4]      # "%lld"
    mov  rsi, rsp              # буфер под long long
    call scanf
    mov  ecx, eax
    mov  rax, qword ptr [rsp]  # 64-битное значение в RAX
    mov  rdx, rax
    sar  rdx, 32               # старшие 32 бита со знаком → EDX
    clc
    cmp  ecx, 1
    je   .L5
    stc
.L5:
    add  rsp, 32               # было 24
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L4: .asciz "%lld"

.text
.align 16
.global writei64
writei64:
    push rbp
    mov  rbp, rsp
    mov  rsi, rdi
    xor  eax, eax
    lea  rdi, [rip + .L6]      # "%lld"
    call printf
    pop  rbp
    ret

.section .string,"aMS",@progbits,1
.L6: .asciz "%lld"

# убрать предупреждение про исполняемый стек
.section .note.GNU-stack,"",@progbits
