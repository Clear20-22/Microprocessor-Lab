extern printf
extern scanf

SECTION .data
    enter_n: db "Enter array size: ", 0
    enter_thresh: db "Enter threshold: ", 0
    enter_elem: db "Enter %ld integers: ", 0
    in_fmt: db "%ld", 0
    out_fmt: db "Average: %.2lf", 10, 0
    out_0: db "0", 10, 0
    newline: db 10, 0

SECTION .bss
    n: resq 1
    threshold: resq 1
    arr: resq 100
    i: resq 1
    sum: resq 1
    count: resq 1

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

compute_average:
    push rbp
    mov rbp, rsp
    
    mov qword [sum], 0
    mov qword [count], 0
    mov rax, 0
    mov [i], rax

.sum_loop:
    mov rax, [i]
    cmp rax, [n]
    jge .compute_done

    mov rbx, [arr + rax*8]   
    cmp rbx, [threshold]
    jle .skip_element

    add [sum], rbx
    inc qword [count]

.skip_element:
    inc qword [i]
    jmp .sum_loop

.compute_done:
    pop rbp
    ret

display_result:
    push rbp
    mov rbp, rsp
    
    mov rax, [count]
    cmp rax, 0
    je .no_elements

    cvtsi2sd xmm0, qword [sum]     
    cvtsi2sd xmm1, qword [count]  
    divsd xmm0, xmm1          

    mov rdi, out_fmt
    mov rax, 1              
    call printf
    jmp .display_done

.no_elements:
    mov rdi, out_0
    xor rax, rax
    call printf

.display_done:
    mov rdi, newline
    xor rax, rax
    call printf
    
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

    mov rdi, enter_thresh
    xor rax, rax
    call printf

    mov rdi, in_fmt
    mov rsi, threshold
    xor rax, rax
    call scanf

    mov rax, [n]
    mov rdi, enter_elem
    mov rsi, rax
    xor rax, rax
    call printf

    call take_array_input
    call compute_average
    call display_result

    pop rbp
    mov rax, 0
    ret
