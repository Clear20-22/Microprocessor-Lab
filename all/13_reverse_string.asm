extern printf 
extern scanf 
extern strlen

SECTION .data
    enter: db "Enter a string: ", 0
    in_fmt: db "%s", 0
    out_fmt: db "Reverse String: %s", 10, 0

SECTION .bss 
    str: resb 100 
    rev: resb 100 

SECTION .text 
    global main

main: 
    push rbp 

    mov rdi, enter
    xor rax, rax 
    call printf 

    mov rdi, in_fmt
    lea rsi, [str]
    xor rax, rax 
    call scanf

    lea rdi, [str]
    call strlen 
    mov rcx, rax 

    lea rsi, [str]
    lea rdi, [rev]
    add rsi, rcx 
    dec rsi 
    mov rbx, rcx

reverse: 
    cmp rbx, 0
    je done 
    mov al, [rsi]  
    mov [rdi], al
    dec rsi 
    inc rdi
    dec rbx 
    jmp reverse 

done:
    mov byte [rdi], 0

    mov rdi, out_fmt 
    lea rsi, [rev]
    xor rax, rax 
    call printf 

    pop rbp 
    ret