.intel_syntax noprefix

.global process
.global R
.global A
.global B

.data
A: .int 0
B: .int 0
R: .int 0

.text
process:
    mov eax, [rip + A]
    mov ecx, [rip + B]
    xor edx, edx
    
    test eax, eax
    jz .zero
    
    test ecx, ecx
    jz .zero
    
    mov esi, eax
    mov edi, ecx
    xor ebx, ebx
    
    cmp esi, 0
    jge .check_b
    neg esi
    not ebx

.check_b:
    cmp edi, 0
    jge .loop
    neg edi
    not ebx

.loop:
    test edi, 1
    jz .shift
    add edx, esi

.shift:
    shl esi, 1
    shr edi, 1
    jnz .loop

.sign:
    test ebx, ebx
    jz .store
    neg edx

.store:
    mov [rip + R], edx
    ret

.zero:
    mov [rip + R], edx
    ret
