extern printf
extern scanf 

SECTION .data
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld x %ld = %ld", 10, 0

SECTION .bss
    n: resq 1
    i: resq 1
    prod: resq 1

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

    mov qword [i], 1

loop:
    mov rax, [i]
    cmp rax, 10
    jg end 
    mov rax, [n] 
    imul rax, [i]
    mov [prod], rax 
     
    mov rdi, out_fmt
    mov rsi, [n]
    mov rdx, [i]
    mov rcx, [prod]
    xor rax, rax 
    call printf 

    mov rax, [i]
    add rax, 1
    mov [i], rax 
    jmp loop 

end:
    pop rbp
    ret