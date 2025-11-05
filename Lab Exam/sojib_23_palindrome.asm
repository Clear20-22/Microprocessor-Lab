extern printf
extern scanf
extern strlen

section .data
    take_str: db "%s", 0
    yes_msg: db "YES", 10, 0
    no_msg: db "NO", 10, 0
    str_buffer: times 101 db 0  ; Buffer for input string
section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ; Read input string
    mov rdi, take_str
    lea rsi, [rel str_buffer]
    xor rax, rax
    call scanf

    ; Call is_palindrome function
    lea rdi, [rel str_buffer]
    call is_palindrome

    ; Check result and print appropriate message
    cmp rax, 1
    je .is_palindrome
    
    mov rdi, no_msg
    xor rax, rax
    call printf
    jmp .done

.is_palindrome:
    mov rdi, yes_msg
    xor rax, rax
    call printf

.done:
    xor rax, rax
    leave
    ret

; Function: is_palindrome
; Input: rdi = pointer to string
; Output: rax = 1 if palindrome, 0 if not
is_palindrome:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    
    mov r12, rdi        ; r12 = string pointer
    
    ; Get string length
    call strlen
    mov r13, rax        ; r13 = length
    
    ; Set up two pointers
    mov r14, 0          ; left pointer (start)
    dec r13             ; right pointer (end, length-1)

.check_loop:
    cmp r14, r13
    jge .is_palindrome_true    ; If pointers meet or cross, it's a palindrome
    
    ; Compare characters at left and right positions
    movzx rax, byte [r12 + r14]  ; left character
    movzx rbx, byte [r12 + r13]  ; right character
    
    cmp rax, rbx
    jne .is_palindrome_false     ; Different characters = not palindrome
    
    ; Move pointers toward center
    inc r14             ; left++
    dec r13             ; right--
    jmp .check_loop

.is_palindrome_true:
    mov rax, 1          ; Return 1 (true)
    jmp .done_check

.is_palindrome_false:
    mov rax, 0          ; Return 0 (false)

.done_check:
    pop r14
    pop r13
    pop r12
    leave
    ret
        
        