extern printf
extern scanf
extern malloc
extern free

SECTION .data
    n_fmt: db "%ld", 0
    out_fmt: db "%ld ", 0
    newline: db 10, 0
    
    heap_ptr: dq 0
    node_count: dq 0

SECTION .bss
    n: resq 1                 
    root: resq 1              
    temp_val: resq 1          

SECTION .text
    global main

create_node:
    push rbp
    mov rbp, rsp
    push rbx
    
    mov rbx, rdi                
    
    mov rdi, 24
    call malloc
    
    mov qword [rax], rbx        
    mov qword [rax + 8], 0      
    mov qword [rax + 16], 0     
    
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

insert_bst:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    
    mov rbx, rdi                
    mov r12, rsi                
    
    cmp rbx, 0
    je .create_new
    
    mov rax, [rbx]             
    cmp r12, rax                
    jl .go_left
    
    mov rdi, [rbx + 16]       
    mov rsi, r12
    call insert_bst
    mov [rbx + 16], rax        
    mov rax, rbx
    jmp .end_insert
    
.go_left:
    mov rdi, [rbx + 8]         
    mov rsi, r12
    call insert_bst
    mov [rbx + 8], rax         
    mov rax, rbx
    jmp .end_insert
    
.create_new:
    mov rdi, r12
    call create_node
    
.end_insert:
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

inorder_traversal:
    push rbp
    mov rbp, rsp
    push rbx
    
    mov rbx, rdi              
    
    cmp rbx, 0
    je .end_inorder
    
    mov rdi, [rbx + 8]        
    call inorder_traversal
    
    mov rdi, out_fmt
    mov rsi, [rbx]            
    xor rax, rax
    call printf
    
    mov rdi, [rbx + 16]      
    call inorder_traversal
    
.end_inorder:
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    
    mov rdi, n_fmt
    mov rsi, n
    xor rax, rax
    call scanf
    
    mov qword [root], 0
    
    mov r12, 0                 
    
.read_loop:
    cmp r12, [n]
    jge .start_traversal
    
    mov rdi, n_fmt
    mov rsi, temp_val
    xor rax, rax
    call scanf
    
    mov rdi, [root]          
    mov rsi, [temp_val]     
    call insert_bst
    mov [root], rax        
    
    inc r12
    jmp .read_loop
    
.start_traversal:
    mov rdi, [root]
    call inorder_traversal
    
    mov rdi, newline
    xor rax, rax
    call printf
    
    xor rax, rax
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
