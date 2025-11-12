extern printf
extern scanf

SECTION .data
    enter_n: db "Enter array size: ", 0
    enter_elem: db "Enter %ld integers: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "%ld %ld", 10, 0   
    out_fmt_2: db "Unique numbers and their frequencies:", 10, 0

SECTION .bss
    n: resq 1
    arr: resq 100
    i: resq 1
    j: resq 1
    temp: resq 1

SECTION .text
    global main

take_array_input:
    push rbp
    mov rbp, rsp
    
    mov qword [i], 0

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

display_output:
    push rbp
    mov rbp, rsp
    
    mov rdi, out_fmt_2
    xor rax, rax 
    call printf      

    mov qword [i], 0

.next_unique:
    mov rax, [i]
    cmp rax, [n]
    jge .output_done

    mov rbx, [arr + rax*8]  
    mov rcx, 1             
    inc qword [i]

.count_loop:
    mov rax, [i]
    cmp rax, [n]
    jge .print_pair

    mov rdx, [arr + rax*8]
    cmp rdx, rbx
    jne .print_pair

    inc rcx
    inc qword [i]
    jmp .count_loop

.print_pair:
    mov rdi, out_fmt
    mov rsi, rbx
    mov rdx, rcx
    xor rax, rax
    call printf

    jmp .next_unique

.output_done:
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

    mov rdi, enter_elem
    mov rsi, [n]
    xor rax, rax
    call printf

    call take_array_input

sort_array:
    mov rbx, [n]   

    mov rdi, out_fmt_2
    xor rax, rax 
    call printf      

outer_loop:
    dec rbx
    jle count_freq
    mov qword [i], 0

inner_loop:
    mov rax, [i]
    mov rcx, [n]
    dec rcx
    cmp rax, rcx
    jge outer_loop

    mov rdx, [arr + rax*8]
    mov rsi, [arr + rax*8 + 8]
    cmp rdx, rsi
    jle no_swap
    mov [arr + rax*8], rsi
    mov [arr + rax*8 + 8], rdx

no_swap:
    inc qword [i]
    jmp inner_loop

count_freq:
    call display_output

done:
    pop rbp
    ret