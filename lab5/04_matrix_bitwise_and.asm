extern printf
extern scanf
extern malloc
extern free

section .data
enter: db "Enter matrix dimensions (rows cols): ", 0
msg_in1: db 10, "Enter elements for Matrix 1 (%dx%d):", 10, 0
msg_in2: db 10, "Enter elements for Matrix 2 (%dx%d):", 10, 0
msg_prompt: db "Enter element [%d][%d]: ", 0
msg1: db 10, "Matrix 1:", 10, 0
msg2: db 10, "Matrix 2:", 10, 0
msg3: db 10, "Result (Matrix1 AND Matrix2):", 10, 0
space: db " ", 0
newline: db 10, 0
fmt_num: db "%d", 0
fmt_in: db "%d", 0
fmt_two_ints: db "%d %d", 0

section .bss
rows: resd 1
cols: resd 1
size: resd 1
matrix1: resb 10000    
matrix2: resb 10000
result: resb 10000
input_val: resd 1

section .text
global main

main:
    push rbp
    mov rbp, rsp
    and rsp, -16
    
    lea rdi, [rel enter]
    xor eax, eax
    call printf
    
    lea rdi, [rel fmt_two_ints]
    lea rsi, [rel rows]
    lea rdx, [rel cols]
    xor eax, eax
    call scanf
    
    mov eax, [rel rows]
    imul eax, [rel cols]
    mov [rel size], eax
    
    lea rdi, [rel msg_in1]
    mov esi, [rel rows]
    mov edx, [rel cols]
    xor eax, eax
    call printf
    
    lea rdi, [rel matrix1]
    call read_matrix
    
    lea rdi, [rel msg_in2]
    mov esi, [rel rows]
    mov edx, [rel cols]
    xor eax, eax
    call printf
    
    lea rdi, [rel matrix2]
    call read_matrix
    
    lea rdi, [rel msg1]
    xor eax, eax
    call printf
    
    lea rsi, [rel matrix1]
    call print_matrix
    
    lea rdi, [rel msg2]
    xor eax, eax
    call printf
    
    lea rsi, [rel matrix2]
    call print_matrix
    
    call matrix_and_operation
    
    lea rdi, [rel msg3]
    xor eax, eax
    call printf
    
    lea rsi, [rel result]
    call print_matrix
    
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret

read_matrix:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    
    mov [rbp-8], rdi      
    mov qword [rbp-16], 0
    
row_loop:
    mov rax, [rbp-16]
    cmp eax, [rel rows]
    jge read_done
    
    mov qword [rbp-24], 0 
    
col_loop:
    mov rax, [rbp-24]
    cmp eax, [rel cols]
    jge next_row
    
    mov rdi, [rbp-16]
    mov rsi, [rbp-24]
    push rdi
    push rsi
    
    lea rdi, [rel msg_prompt]
    pop rdx
    pop rsi
    xor eax, eax
    call printf
    
    lea rdi, [rel fmt_in]
    lea rsi, [rel input_val]
    xor eax, eax
    call scanf
    
    mov eax, [rbp-16]
    imul eax, [rel cols]
    add eax, [rbp-24]
    
    mov r10, [rbp-8]
    mov r11d, [rel input_val]
    mov byte [r10 + rax], r11b
    
    inc qword [rbp-24]
    jmp col_loop
    
next_row:
    inc qword [rbp-16]
    jmp row_loop
    
read_done:
    leave
    ret

matrix_and_operation:
    push rbp
    mov rbp, rsp
    
    xor rcx, rcx      
    
loop:
    cmp ecx, [rel size]
    jge done
    
    lea rsi, [rel matrix1]
    mov al, [rsi + rcx]
    lea rsi, [rel matrix2]
    mov bl, [rsi + rcx]
    
    and al, bl
    
    lea rsi, [rel result]
    mov [rsi + rcx], al
    
    inc rcx
    jmp loop
    
done:
    pop rbp
    ret

print_matrix:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    mov [rbp-8], rsi      
    mov qword [rbp-16], 0 
    
print_loop:
    mov eax, [rbp-16]
    cmp eax, [rel size]
    jge print_done
    
    mov r10, [rbp-8]
    movzx rsi, byte [r10 + rax]
    
    lea rdi, [rel fmt_num]
    xor eax, eax
    call printf
    
    lea rdi, [rel space]
    xor eax, eax
    call printf
    
    inc qword [rbp-16]
    mov eax, [rbp-16]
    
    xor edx, edx
    div dword [rel cols]
    cmp edx, 0
    jne print_loop
    
    lea rdi, [rel newline]
    xor eax, eax
    call printf
    
    jmp print_loop
    
print_done:
    leave
    ret
