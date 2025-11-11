.intel_syntax noprefix
.text
.global my_sin

my_sin:
    movsd xmm1, xmm0
    movsd xmm2, xmm0
    movsd xmm0, xmm1
    mov rax, 1
    cvtsi2sd xmm3, rax
    movsd xmm4, xmm3
    mov rax, 14
    mov rcx, rax

.loop:
    mov rax, 2
    cvtsi2sd xmm5, rax
    mulsd xmm5, xmm4
    mov rax, 1
    cvtsi2sd xmm6, rax
    addsd xmm5, xmm6
    mov rax, 2
    cvtsi2sd xmm6, rax
    mulsd xmm6, xmm4
    mov rax, 3
    cvtsi2sd xmm7, rax
    addsd xmm6, xmm7
    mulsd xmm5, xmm6
    movsd xmm6, xmm1
    mulsd xmm6, xmm1
    mulsd xmm6, xmm2
    divsd xmm6, xmm5
    mov rax, -1
    cvtsi2sd xmm7, rax
    mulsd xmm6, xmm7
    movsd xmm2, xmm6
    addsd xmm0, xmm2
    mov rax, 1
    cvtsi2sd xmm7, rax
    addsd xmm4, xmm7
    dec rcx
    jnz .loop
    ret
