.intel_syntax noprefix
.global syscall
.text

# Обёртка для системных вызовов Linux x86-64 (SysV ABI → syscall ABI).
# Вход (у нашей обёртки):
#   rdi = sysno
#   rsi = arg1
#   rdx = arg2
#   rcx = arg3
#   r8  = arg4
#   r9  = arg5
# (arg6 не используем в этой задаче)
#
# На выход:
#   rax = возвращённое значение системного вызова (или -errno)

syscall:
    # Пролог
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15
    # syscall трогает rcx и r11 — тоже сохраним
    push r11
    push rcx

    # Сложим входные регистры на стек, чтобы разложить их под ABI syscalls
    # Порядок (сверху будет rdi/sysno):
    push r9
    push r8
    push rcx
    push rdx
    push rsi
    push rdi

    # Восстанавливаем в порядке, требуемом инструкцией syscall:
    # rax=sysno, rdi=arg1, rsi=arg2, rdx=arg3, r10=arg4, r8=arg5
    pop rax        # sysno
    pop rdi        # arg1
    pop rsi        # arg2
    pop rdx        # arg3 (у нас он приходил в rcx)
    pop r10        # arg4 (приходил в r8)
    pop r8         # arg5 (приходил в r9)
    # arg6 (r9) не используем — не трогаем стек дальше

    syscall

    # Эпилог
    pop rcx
    pop r11
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    ret