extern printf 
extern scanf 

SECTION .data
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "Divisors are: ", 0
    out_fmt_2: db "%ld ", 0
    newline: db 10, 0

SECTION .bss
    n: resq 1
    i: resq 1
    ;rem: resq 1

SECTION .text
    global main

main:
    push rbp

    mov rdi, enter
    xor rax, rax 
    call printf 

    mov rdi, in_fmt 
    mov rsi, n 
    xor rax, rax 
    call scanf 

    mov rdi, out_fmt
    xor rax, rax 
    call printf

    mov qword [i], 1

loop:
    mov rax, [n]
    xor rdx, rdx
    div qword [i]
    cmp rdx, 0
    jne next 
    
    mov rdi, out_fmt_2
    mov rsi, [i]
    xor rax, rax 
    call printf 

next: 
    mov rax, [i]
    add rax, 1 
    mov [i], rax 

    mov rax, [i]
    mov rbx, [n]
    cmp rax, rbx
    jle loop 

    mov rdi, newline
    xor rax, rax 
    call printf 

    xor rax, rax
    pop rbp 
    ret