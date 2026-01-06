extern printf
extern scanf

SECTION .data

a: dq 0
b: dq 0
c: dq 0
max: dq 0

enter_a: db "Enter first number: ", 0
enter_b: db "Enter second number: ", 0
enter_c: db "Enter third number: ", 0
out: db "Maximum number is : %ld", 10, 0
in: db "%ld", 0

SECTION .text

global main
main:
    push rbp

    mov rax, 0
    mov rdi, out
    mov rsi, enter_a
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, a 
    call scanf

    mov rax, 0
    mov rdi, out
    mov rsi, enter_b
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, b
    call scanf

    mov rax, 0
    mov rdi, out
    mov rsi, enter_c
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, c
    call scanf

    mov rax, [a]
    mov rbx, [b]
    cmp rbx, rax
    jle skip_b
    ;jle = jump if less or equal
    mov rax, rbx

skip_b:
    mov rbx, [c]
    cmp rbx, rax
    jle skip_c
    mov rax, rbx

skip_c: 
    mov [max], rax
    mov rax, 0
    mov rdi, out
    mov rsi, [max]
    call printf

    mov rax, 0
    pop rbp
    ret


