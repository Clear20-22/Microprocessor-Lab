extern	printf
extern	scanf

SECTION .data
x:      dq 0
result: dq 0

enter:    db "Enter a number: ", 0
in_fmt: db "%ld", 0
out_fmt: db "Sum from 1 to %ld = %ld", 10, 0

SECTION .text
global main
main:
    push rbp

    mov rax, 0
    mov rdi, enter
    call printf

    
    mov rax, 0
    mov rdi, in_fmt
    mov rsi, x
    call scanf

    
    mov rax, [x]
    mov rbx, rax
    add rbx, 1          
    imul rax, rbx       ; result=(x*(x+1))/2
    mov rbx, 2
    xor rdx, rdx    
    div rbx         
    mov [result], rax


    mov rdi, out_fmt
    mov rsi, [x]
    mov rdx, [result]
    mov rax, 0
    call printf

    pop rbp
    mov rax, 0
    ret
