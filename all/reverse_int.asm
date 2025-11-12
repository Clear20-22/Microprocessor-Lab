extern printf
extern scanf

SECTION .data
    enter: db "Enter a number: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "Reverse(%ld) = %ld", 10, 0

SECTION .bss
    n: resq 1
    rev: resq 1
    sign: resq 1

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
    jge positive
    neg rax 
    mov qword [sign], 1
    jmp after_sign

positive:
    mov qword [sign], 0

after_sign:
    mov rcx, 0

reverse:
    cmp rax, 0
    je check_sign
    xor rdx, rdx
    mov rbx, 10
    div rbx
    imul rcx, rcx, 10
    add rcx, rdx
    jmp reverse

check_sign:
    mov [rev], rcx
    mov rax, [rev]
    cmp qword [sign], 0
    je done
    neg rax
    mov [rev], rax

done:
    mov rdi, out_fmt
    mov rsi, [n]
    mov rdx, [rev]
    xor rax, rax
    call printf

    pop rbp
    ret