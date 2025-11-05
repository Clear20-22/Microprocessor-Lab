extern printf 
extern scanf 

SECTION .data 
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "Fibonacci(%ld) = %ld", 10, 0

SECTION .bss 
    n: resq 1
    fib: resq 1 

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
    je fib_zero
    cmp rax, 1
    je fib_one 

    mov rcx, rax 
    dec rcx
    mov rbx, 0
    mov rdx, 1  

fibonacci: 
    mov rax, rbx 
    add rax, rdx 
    mov rbx, rdx 
    mov rdx, rax 
    loop fibonacci ; loop n-1 times

    mov [fib], rdx 
    jmp print

fib_zero: 
    mov qword [fib], 0
    jmp print 

fib_one:
    mov qword [fib], 1

print:
    mov rdi, out_fmt
    mov rsi, [n]
    mov rdx, [fib]
    xor rax, rax 
    call printf 

    pop rbp 
    ret 