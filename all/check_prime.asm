extern printf
extern scanf

SECTION .data
    a: dq 0

    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld is a prime number", 10, 0
    out_fmt_2: db "%ld is not a prime number", 10, 0

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

    mov rax, [a]
    cmp rax, 2
    jb not_prime

    mov rbx, 2

check:
    cmp rbx, rax
    jge prime
    xor rdx, rdx
    div rbx
    cmp rdx, 0
    je not_prime
    mov rax, [a]
    inc rbx
    jmp check

prime:
    mov rdi, out_fmt
    mov rsi, [a]
    xor rax, rax
    call printf

    jmp end

not_prime:
    mov rdi, out_fmt_2
    mov rsi, [a]
    xor rax, rax
    call printf

    jmp end

end:
    mov rax, 0
    pop rbp
    ret