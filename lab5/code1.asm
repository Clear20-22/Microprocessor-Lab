extern printf
extern scanf

SECTION .data
a: dq 0
b: dq 0
in: db "%ld", 0
out: db "Sum = %ld", 10, 0

SECTION .text
global main

main:
    push rbp
    mov rbp, rsp

    lea rdi, [in]
    lea rsi, [a]
    call scanf

    lea rdi, [in]
    lea rsi, [b]
    call scanf

    mov rdi, [a]
    mov rsi, [b]
    call sum

    mov rsi, rax
    lea rdi, [out]
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp 
    ret

sum:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    add rax, rsi

    mov rsp, rbp
    pop rbp
    ret
