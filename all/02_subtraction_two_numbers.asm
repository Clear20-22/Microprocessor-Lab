extern printf
extern scanf

SECTION .data
    a: dq 5
    b: dq 2
    c: dq 0

    enter: db "Enter two numbers: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld - %ld = %ld", 10, 0
    out_fmt_2: db "%s", 0

SECTION .text
    global main

main:
    push rbp

    mov rdi, out_fmt_2
    mov rsi, enter
    xor rax, rax
    call printf

    mov rdi, in_fmt
    mov rsi, a
    xor rax, rax
    call scanf

    mov rdi, in_fmt
    mov rsi, b
    xor rax, rax
    call scanf

    mov rax, [a]
    mov rbx, [b]
    sub rax, rbx
    mov [c], rax

    mov rdi, out_fmt
    mov rsi, [a]
    mov rdx, [b]
    mov rcx, [c]
    xor rax, rax
    call printf

    pop rbp

    xor rax, rax
    ret