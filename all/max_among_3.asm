extern printf
extern scanf

SECTION .data
    a: dq 0
    b: dq 0
    c: dq 0
    max: dq 0

    enter: db "Enter three numbers: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld is the maximum number", 10, 0

SECTION .text
    global main

main:
    push rbp

    mov rdi, enter
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

    mov rdi, in_fmt
    mov rsi, c
    xor rax, rax
    call scanf

    mov rax, [a]
    mov rbx, [b]
    cmp rbx, rax
    jle skip_b

    mov rax, rbx

skip_b:
    mov rbx, [c]
    cmp rbx, rax
    jle skip_c
    mov rax, rbx

skip_c:
    mov [max], rax

    mov rdi, out_fmt
    mov rsi, [max]
    xor rax, rax
    call printf

    pop rbp
    ret