extern printf
extern scanf

SECTION .data
a: dq 0
b: dq 0
in: db "%ld", 0
out: db "Maximum = %ld", 10, 0

SECTION .text
global main

main:
    push rbp
    mov rbp, rsp

    lea rdi, [in]
    lea rsi, [a]
    xor rax, rax
    call scanf

    lea rdi, [in]
    lea rsi, [b]
    xor rax, rax
    call scanf

    mov rdi, [a]
    mov rsi, [b]
    call max

    mov rsi, rax
    lea rdi, [out]
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    ret

max:
    push rbp
    mov rbp, rsp

    cmp rdi, rsi
    jge first_is_max
    mov rax, rsi

    mov rsp, rbp
    pop rbp
    ret

first_is_max:
    mov rax, rdi
    ret