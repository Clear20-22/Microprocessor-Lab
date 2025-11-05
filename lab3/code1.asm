extern printf
extern scanf

SECTION .data

a: dq 5
b: dq 2
c: dq 0

enter: db "Enter two numbers: ",0
out: db "gcd(%ld, %ld) =%ld", 10, 0
out_2: db "%s", 10, 0
in: db "%ld", 0

SECTION .text

global main
main:
    push rbp
    mov rax, 0
    mov rdi, out_2
    mov rsi, enter
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, a
    call scanf

    mov rax, 0
    mov rdi, in
    mov rsi, b
    call scanf

    mov rax, [a]
    mov rbx, [b]

gcd:
    cmp rbx, 0
    je gcd_done
    xor rdx, rdx
    div rbx
    mov rax, rbx
    mov rbx, rdx
    jmp gcd

gcd_done:
    mov [c], rax
    mov rax, 0
    mov rdi, out
    mov rsi, [a]
    mov rdx, [b]
    mov rcx, [c]
    call printf

    mov rax, 0
    pop rbp
    ret
