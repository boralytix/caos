        .text
        .align  16
        .global readi32
readi32:
        push    rbp
        mov     rbp, rsp

        sub     rsp, 24
        xor     eax, eax
        lea     rdi, [rip + .L2]
        mov     rsi, rsp
        call    scanf
        mov     ecx, eax
        mov     eax, DWORD PTR [rsp]
        clc
        cmp     ecx, 1
        je      .L1
        stc
.L1:
        lea     rsp, [rsp + 24]
        pop     rbp
        ret

        .section    .string, "aMS", @progbits, 1
.L2:
        .asciz  "%d"

        .text
        .align  16
        .global writei32
writei32:
        push    rbp
        mov     rbp, rsp
        mov     esi, edi
        xor     eax, eax
        lea     rdi, [rip + .L3]
        call    printf
        pop     rbp
        ret

        .section    .string, "aMS", @progbits, 1
.L3:
        .asciz  "%d"

        .text
        .align  16
        .global finish
finish:
        xor     edi, edi
        call    exit

        .text
        .align  16
        .global nl
nl:
        push    rbp
        mov     rbp, rsp
        mov     edi, 10             # '\n'
        call    putchar
        pop     rbp
        ret

        .text
        .align  16
        .global readi64
readi64:
        push    rbp
        mov     rbp, rsp

        sub     rsp, 24
        xor     eax, eax
        lea     rdi, [rip + .L4]
        mov     rsi, rsp
        call    scanf
        mov     ecx, eax
        mov     rax, QWORD PTR [rsp]
        clc
        cmp     ecx, 1
        je      .L5
        stc
.L5:
        lea     rsp, [rsp + 24]
        pop     rbp
        ret

        .section    .string, "aMS", @progbits, 1
.L4:
        .asciz  "%lld"

        .text
        .align  16
        .global writei64
writei64:
        push    rbp
        mov     rbp, rsp
        mov     rsi, rdi
        xor     eax, eax
        lea     rdi, [rip + .L6]
        call    printf
        pop     rbp
        ret

        .section    .string, "aMS", @progbits, 1
.L6:
        .asciz  "%lld"
