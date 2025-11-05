extern printf 
extern scanf 

SECTION .data 
    enter: db "Enter three integers: ", 0
    in_fmt: db "%ld %ld %ld", 0
    out_fmt: db "Average = %.2f", 10, 0
    three: dq 3.0 

SECTION .bss
    a: resq 1
    b: resq 1
    c: resq 1
    sum: resq 1
    avg: resd 1

SECTION .text 
    global main 

main:
    push rbp

    mov rdi, enter 
    xor rax, rax 
    call printf 

    mov rdi, in_fmt
    mov rsi, a
    mov rdx, b
    mov rcx, c
    xor rax, rax 
    call scanf 

    mov rax, [a]
    add rax, [b]
    add rax, [c]
    mov [sum], rax

    cvtsi2sd xmm0, rax
    movsd xmm1, qword [three]
    divsd xmm0, xmm1 
    movsd [avg], xmm0

    mov rdi, out_fmt 
    movsd xmm0, [avg]
    xor rax, rax
    call printf 

    pop rbp 
    ret 