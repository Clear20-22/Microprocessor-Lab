extern printf
extern scanf

SECTION .data
enter: db "Enter a number: ", 0
enter_2: db "%s", 0
in: db "%ld", 0
out: db "Reverse(%ld) = %ld", 10, 0

SECTION .bss
n: resq 1
rev: resq 1
sign: resq 1

SECTION .text

global main
main:
    push rbp

    mov rdi, enter_2
    mov rsi, enter
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, n 
    call scanf

    mov rax, [n] 

    cmp rax, 0
    jge .positive 
    neg rax
    mov qword [sign], 1
    jmp .after_sign

.positive:
    mov qword [sign], 0

.after_sign:
    mov rcx, 0

.rev_loop:
    cmp rax, 0
    je .rev_done
    xor rdx, rdx
    mov rbx, 10
    div rbx
    imul rcx, rcx, 10
    add rcx, rdx
    jmp .rev_loop

.rev_done:
    mov [rev], rcx
    mov rax, [rev]
    cmp qword [sign], 0
    je .store_final
    neg rax
    mov [rev], rax

.store_final:
    mov rax, 0
    mov rdi, out
    mov rsi, [n]
    mov rdx, [rev]
    call printf

    mov rax, 0
    pop rbp
    ret
