extern printf
extern scanf
extern strlen

SECTION .data
in: db "%s", 0
out: db "Reversed string: %s", 10, 0

SECTION .bss
s: resb 100

SECTION .text
global main

main:
    push rbp
    mov rbp, rsp

    mov rdi, in
    mov rsi, s
    xor rax, rax
    call scanf

    mov rdi, s
    call reverse_str

    mov rsi, rdi
    mov rdi, out
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    ret

reverse_str:
    push rbx
    mov rbx, rdi

    mov rdi, rbx
    call strlen
    dec rax
    mov rcx, rax
    xor rdx, rdx

reverse_loop:
    cmp rdx, rcx
    jge end

    mov al, [rbx+rdx]
    mov r8b, [rbx+rcx]
    mov [rbx+rdx], r8b
    mov [rbx+rcx], al

    inc rdx
    dec rcx
    jmp reverse_loop

end:
    mov rdi, rbx
    pop rbx
    ret