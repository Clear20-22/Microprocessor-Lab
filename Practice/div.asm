extern printf
extern scanf

section .data
    print_: db "Hello World!", 10, 0
    print_formate: db "%s", 0
    take_int: db "%ld", 0
    enter_num: db "Enter a number: ", 0
    err_msg: db "Error: Division by zero is not allowed.", 10, 0
    print_ans: db "The result is: %ld", 10, 0

    a: dq 0
    b: dq 0
    c: dq 0

section .text
    global main

    main:
        push rbp
        mov rbp, rsp
        sub rsp, 8             
        
        call take_input
        call check_zero
        call do_div
        call print_div

        leave                  
        ret

    do_div:
        mov rax, qword [rel a]
        mov rbx, qword [rel b]
        xor rdx, rdx
        div rbx
        mov qword [rel c], rax
        ret
    
    print_div:
        mov rdi, print_ans
        mov rsi, qword [rel c] 
        xor rax, rax
        call printf
        ret
    
    take_input:
        mov rdi, enter_num
        xor rax, rax
        call printf

        mov rdi, take_int
        lea rsi, [rel a]      
        xor rax, rax
        call scanf

        mov rdi, take_int
        lea rsi, [rel b]       
        xor rax, rax
        call scanf
        ret

    check_zero:
        mov rax, qword [rel b]  
        cmp rax, 0
        jne .not_zero
        
        mov rdi, err_msg
        xor rax, rax
        call printf
        mov rax, 60
        xor rdi, rdi
        syscall
    .not_zero:
        ret
        
    fun:
        mov rdi, print_formate
        lea rsi, [rel print_]   
        xor rax, rax
        call printf
        ret