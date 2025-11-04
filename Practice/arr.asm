extern printf
extern scanf

section .data
    take_int: db "%ld", 0
    enter_num: db "Enter number of elements: ", 0
    enter_element: db "Enter element %ld: ", 0
    print_arr: db "The array elements are: ", 10, 0
    arr_format: db "%ld ", 0
    newline: db 10, 0
    
    n: dq 0
    arr: times 100 dq 0         

section .text
    global main

main:
    push rbp
    mov rbp, rsp
    
    call take_input
    call fill_array
    call print_array
    
    xor rax, rax
    leave
    ret

take_input:
    push rbp
    mov rbp, rsp
    
    mov rdi, enter_num
    xor rax, rax
    call printf

    mov rdi, take_int
    lea rsi, [rel n]
    xor rax, rax
    call scanf

    leave
    ret

fill_array:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    
    mov r13, qword [rel n]  ; r13 = n (limit)
    xor r12, r12            ; r12 = 0 (counter)

.fill_loop:
    cmp r12, r13
    jge .done_fill

    ; Print prompt
    mov rdi, enter_element
    mov rsi, r12
    inc rsi                 ; 1-based for user
    xor rax, rax
    call printf

    ; Calculate address: arr + r12 * 8
    mov rdi, take_int
    mov rax, r12
    shl rax, 3              ; multiply by 8
    lea rsi, [rel arr]
    add rsi, rax
    xor rax, rax
    call scanf

    inc r12
    jmp .fill_loop

.done_fill:
    pop r13
    pop r12
    leave
    ret

print_array:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    
    mov rdi, print_arr
    xor rax, rax
    call printf
    
    mov r13, qword [rel n]  ; r13 = n (limit)
    xor r12, r12            ; r12 = 0 (counter)

.print_loop:
    cmp r12, r13
    jge .done_print

    ; Calculate address and load value: arr[r12]
    mov rdi, arr_format
    mov rax, r12
    shl rax, 3              ; multiply by 8
    lea rsi, [rel arr]
    add rsi, rax
    mov rsi, qword [rsi]    ; load the value
    xor rax, rax
    call printf

    inc r12
    jmp .print_loop

.done_print:
    mov rdi, newline
    xor rax, rax
    call printf
    
    pop r13
    pop r12
    leave
    ret