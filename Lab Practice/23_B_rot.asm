extern printf
extern scanf

SECTION .data
    enter_n: db "Enter array size: ", 0
    enter_k: db "Enter rotation k: ", 0
    enter_elem: db "Enter %ld integers: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld ", 0  
    out_fmt_2: db "Rotated Array: ", 0
    newline: db 10, 0

SECTION .bss
    n: resq 1
    k: resq 1
    arr: resq 100
    temp: resq 100
    i: resq 1

SECTION .text
    global main

take_array_input:
    push rbp
    mov rbp, rsp
    
    mov rax, 0
    mov [i], rax

.input_loop:
    mov rax, [i]
    cmp rax, [n]
    jge .input_done

    mov rdi, in_fmt
    lea rsi, [arr + rax*8]
    xor rax, rax
    call scanf

    inc qword [i]
    jmp .input_loop

.input_done:
    pop rbp
    ret

rotate_array:
    push rbp
    mov rbp, rsp
    
    mov rax, [k]
    mov rbx, [n]
    xor rdx, rdx
    div rbx                  
    mov [k], rdx

    mov rax, 0
    mov [i], rax 

.rotate_loop:
    mov rax, [i]
    cmp rax, [n]
    jge .rotate_done

    mov rbx, [i]
    add rbx, [k]
    mov rcx, [n]
    cmp rbx, rcx
    jl .no_wrap
    sub rbx, rcx
.no_wrap:
    mov rdx, [arr + rax*8]
    mov [temp + rbx*8], rdx

    inc qword [i]
    jmp .rotate_loop

.rotate_done:
    pop rbp
    ret

main:
    push rbp

    mov rdi, enter_n
    xor rax, rax
    call printf

    mov rdi, in_fmt
    mov rsi, n
    xor rax, rax
    call scanf

    mov rdi, enter_k
    xor rax, rax
    call printf

    mov rdi, in_fmt
    mov rsi, k
    xor rax, rax
    call scanf

    mov rdi, enter_elem
    mov rsi, [n]
    xor rax, rax 
    call printf

    call take_array_input

    call rotate_array

print_result:
    mov rdi, out_fmt_2
    xor rax, rax 
    call printf 

    mov rax, 0
    mov [i], rax

print_loop:
    mov rax, [i]
    cmp rax, [n]
    jge exit

    mov rdi, out_fmt
    mov rsi, [temp + rax*8]
    xor rax, rax
    call printf

    inc qword [i]
    jmp print_loop

exit:
    mov rdi, newline 
    xor rax, rax 
    call printf

    pop rbp
    mov rax, 0
    ret
