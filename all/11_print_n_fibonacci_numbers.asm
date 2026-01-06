extern printf 
extern scanf 

SECTION .data 
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld fibonacci number: ", 0
    out_fmt_2: db "%ld ", 0
    newline: db 10, 0

SECTION .bss 
    n: resq 1
    i: resq 1
    a: resq 1
    b: resq 1
    tmp: resq 1 

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
    mov rsi, [n]
    xor rax, rax
    call printf 

    mov qword [a], 0 
    mov qword [b], 1 
    mov qword [i], 0  

fib_loop: 
    mov rax, [i]
    cmp rax, [n]
    jge done

    mov rax, [i] 
    cmp rax, 0 
    je print_a

    mov rax, [i]
    cmp rax, 1
    je print_b

    mov rax, [a]
    add rax, [b]
    mov [tmp], rax
    mov rax, [tmp]
    
    mov rdi, out_fmt_2
    mov rsi, rax 
    xor rax, rax 
    call printf

    mov rax, [b]
    mov [a], rax
    mov rax, [tmp]
    mov [b], rax 
    jmp inc_i

print_a:
    mov rax, [a]

    mov rdi, out_fmt_2
    mov rsi, rax 
    xor rax, rax 
    call printf 

    jmp inc_i

print_b:
    mov rax, [b]

    mov rdi, out_fmt_2
    mov rsi, rax 
    xor rax, rax 
    call printf 

    jmp inc_i

inc_i: 
    inc qword [i]
    jmp fib_loop 

done:
    mov rdi, newline
    xor rax, rax 
    call printf 

    pop rbp 
    ret 