extern printf 
extern scanf 

SECTION .data 
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "Factorial = %ld", 10, 0

SECTION .bss 
    n: resq 1
    fact: resq 1 

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

    mov rax, [n]
    cmp rax, 0 
    je fact_zero
    mov rcx, rax 
    mov rbx, 1  

factorial: 
    imul rbx, rcx 
    dec rcx 
    jnz factorial

    mov [fact], rbx 
    jmp print 

fact_zero: 
    mov qword [fact], 1

print:
    mov rdi, out_fmt
    mov rsi, [fact]
    xor rax, rax 
    call printf 

    pop rbp 
    ret 