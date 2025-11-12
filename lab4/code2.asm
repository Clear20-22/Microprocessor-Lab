extern printf
extern scanf

SECTION .data
enter: db "Enter a number: ", 0
enter_2: db "%s", 0
in: db "%ld", 0
out: db "%ld x %ld = %ld", 10, 0

SECTION .bss
n: resq 1
i: resq 1
prod: resq 1

SECTION .text

global main
main:
    push rbp

    mov rdi, enter_2
    mov rsi, enter
    xor rax, rax
    call printf

    mov rdi, in
    mov rsi, n 
    xor rax, rax 
    call scanf

    mov qword [i], 1

.loop_start:
    mov rax, [i]
    cmp rax, 10
    jg .loop_end
    mov rax, [n]
    imul rax, [i]
    mov [prod], rax

    mov rdi, out
    mov rsi, [n]
    mov rdx, [i]
    mov rcx, [prod]
    xor rax, rax
    call printf

    mov rax, [i]
    add rax, 1
    mov [i], rax

    jmp .loop_start

.loop_end:
    mov rax, 0
    pop rbp
    ret