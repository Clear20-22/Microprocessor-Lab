extern printf
extern scanf

SECTION .data

enter: db "Enter a number: ", 0
enter_2: db "%s", 0
in: db "%ld", 0
out: db "%ld ", 0
newline: db 10, 0

SECTION .bss
n: resq 1
i: resq 1
rem: resq 1

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
    mov rax, [n]
    xor rdx, rdx
    div qword [i]
    cmp rdx, 0
    jne .next

    mov rdi, out
    mov rsi, [i]
    xor rax, rax
    call printf

.next:
    mov rax, [i]
    add rax, 1
    mov [i], rax

    mov rax, [i]
    mov rbx, [n]
    cmp rax, rbx
    jle .loop_start

    mov rdi, newline
    xor rax, rax
    call printf


    mov rax, 0
    pop rbp
    ret