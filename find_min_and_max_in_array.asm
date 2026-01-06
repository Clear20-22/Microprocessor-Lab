extern printf
extern scanf

section .data
    take_int: db "%ld", 0
    output_format: db "%ld %ld", 10, 0
    

    min: dq 0
    max: dq 0
    n: dq 0
    arr: times 100 dq 0
    


section .text
    global main

        main:
            push rbp
            mov rbp, rsp

            call take_size
            call take_array_input
            call find_min_max

            xor rax, rax
            leave
            ret
        
        take_size:
            push rbp
            mov rbp, rsp
            
            mov rdi, take_int
            lea rsi, [rel n]
            xor rax, rax
            call scanf
            
            leave
            ret
        
        take_array_input:
            push rbp
            mov rbp, rsp
            push r12
            push r13
            
            mov r13, qword [rel n]  
            xor r12, r12           
            
        take_array_loop:
            cmp r12, r13
            jge .done_input
            
    
            mov rdi, take_int
            mov rax, r12
            shl rax, 3             
            lea rsi, [rel arr]
            add rsi, rax
            xor rax, rax
            call scanf
            
            inc r12
            jmp take_array_loop
        .done_input:
            pop r13
            pop r12
            leave
            ret
        
        find_min_max:
            push rbp
            mov rbp, rsp
            push r12
            push r13
            
            mov rax, qword [rel arr]
            mov qword [rel max], rax
            mov qword [rel min], rax
            
            mov r13, qword [rel n] 
            mov r12, 1              

        find_loop:
            cmp r12, r13
            jge .done_find
            
            mov rax, r12
            shl rax, 3             
            lea rbx, [rel arr]
            add rbx, rax
            mov rax, qword [rbx]   
            
            cmp rax, qword [rel max]
            jle .check_min
            mov qword [rel max], rax
            jmp .next
        .check_min:
            cmp rax, qword [rel min]
            jge .next
            mov qword [rel min], rax
        .next:
            inc r12
            jmp find_loop
        .done_find:
            mov rdi, output_format
            mov rsi, qword [rel max]
            mov rdx, qword [rel min]
            xor rax, rax
            call printf
            
            pop r13
            pop r12
            leave
            ret