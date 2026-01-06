extern printf
extern scanf
extern malloc
extern free

SECTION .data
    ; Format strings for input/output
    n_fmt: db "%ld", 0
    out_fmt: db "%ld ", 0
    newline: db 10, 0
    
    ; Memory tracking
    heap_ptr: dq 0
    node_count: dq 0

SECTION .bss
    n: resq 1                  ; Number of elements
    root: resq 1               ; Root of BST
    temp_val: resq 1           ; Temporary storage for values

SECTION .text
    global main

; Structure of a BST Node (24 bytes):
; [0-7]:   value (8 bytes)
; [8-15]:  left pointer (8 bytes)
; [16-23]: right pointer (8 bytes)

; Function: create_node
; Input: rdi = value
; Output: rax = pointer to new node
create_node:
    push rbp
    mov rbp, rsp
    push rbx
    
    mov rbx, rdi                ; Save value in rbx
    
    ; Allocate 24 bytes for node
    mov rdi, 24
    call malloc
    
    ; rax now contains pointer to new node
    mov qword [rax], rbx        ; node->value = rdi
    mov qword [rax + 8], 0      ; node->left = NULL
    mov qword [rax + 16], 0     ; node->right = NULL
    
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

; Function: insert_bst
; Input: rdi = node (current), rsi = value to insert
; Output: rax = new/modified node pointer
insert_bst:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    
    mov rbx, rdi                ; rbx = current node
    mov r12, rsi                ; r12 = value to insert
    
    ; If node is NULL, create new node
    cmp rbx, 0
    je .create_new
    
    ; Compare value with current node
    mov rax, [rbx]              ; rax = current node value
    cmp r12, rax                ; compare value with current node value
    jl .go_left
    
    ; Go right
    mov rdi, [rbx + 16]         ; rdi = right child
    mov rsi, r12
    call insert_bst
    mov [rbx + 16], rax         ; node->right = insert_bst(node->right, value)
    mov rax, rbx
    jmp .end_insert
    
.go_left:
    mov rdi, [rbx + 8]          ; rdi = left child
    mov rsi, r12
    call insert_bst
    mov [rbx + 8], rax          ; node->left = insert_bst(node->left, value)
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

; Function: inorder_traversal
; Input: rdi = node (current)
; Performs inorder traversal and prints values
inorder_traversal:
    push rbp
    mov rbp, rsp
    push rbx
    
    mov rbx, rdi                ; rbx = current node
    
    ; If node is NULL, return
    cmp rbx, 0
    je .end_inorder
    
    ; Traverse left subtree
    mov rdi, [rbx + 8]          ; rdi = left child
    call inorder_traversal
    
    ; Print current node value
    mov rdi, out_fmt
    mov rsi, [rbx]              ; rsi = node value
    xor rax, rax
    call printf
    
    ; Traverse right subtree
    mov rdi, [rbx + 16]         ; rdi = right child
    call inorder_traversal
    
.end_inorder:
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

; Main program
main:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    
    ; Read number of elements
    mov rdi, n_fmt
    mov rsi, n
    xor rax, rax
    call scanf
    
    ; Initialize root as NULL
    mov qword [root], 0
    
    ; Read elements and insert into BST
    mov r12, 0                  ; r12 = counter (i)
    
.read_loop:
    cmp r12, [n]
    jge .start_traversal
    
    ; Read next value
    mov rdi, n_fmt
    mov rsi, temp_val
    xor rax, rax
    call scanf
    
    ; Insert into BST
    mov rdi, [root]             ; rdi = current root
    mov rsi, [temp_val]         ; rsi = value to insert
    call insert_bst
    mov [root], rax             ; update root
    
    ; Increment counter
    inc r12
    jmp .read_loop
    
.start_traversal:
    ; Print inorder traversal
    mov rdi, [root]
    call inorder_traversal
    
    ; Print newline
    mov rdi, newline
    xor rax, rax
    call printf
    
    ; Cleanup
    xor rax, rax
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
