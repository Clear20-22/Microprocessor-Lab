extern printf 
extern scanf 

SECTION .data
enter: db "Enter your name: ", 0
enter_2: db "Enter your marks(Phy, Math, Bio): ", 0
pass: db "P", 10, 0
fail: db "F", 10, 0
in_fmt: db "%s", 0
in_fmt_2: db "%ld", 0
out_fmt: db "%s, your average is %.2f and your grade is: ", 0

SECTION .bss
str: resb 100 
a: resq 1
b: resq 1
c: resq 1
avg: resq 1

SECTION .text
global main

main:
    push rbp 

    mov rdi, enter 
    xor rax, rax 
    call printf 

    mov rdi, in_fmt
    lea rsi, [str] 
    xor rax, rax 
    call scanf

    mov rdi, enter_2
    xor rax, rax 
    call printf 

    mov rdi, in_fmt_2
    mov rsi, a 
    xor rax, rax 
    call scanf 

    mov rdi, in_fmt_2
    mov rsi, b 
    xor rax, rax 
    call scanf 

    mov rdi, in_fmt_2
    mov rsi, c 
    xor rax, rax 
    call scanf 

    mov rax, [a]
    mov rbx, [b]
    add rax, rbx

    mov rbx, [c]
    add rax, rbx

    mov rbx, 3
    div rbx 
