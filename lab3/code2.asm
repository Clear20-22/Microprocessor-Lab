extern printf
extern scanf

SECTION .data

x: dq 0
enter: db "Enter a number: ", 0
prime: db "The number is prime", 10, 0
not_prime: db "The number is not prime", 10, 0
out: db "%s", 0
in: db "%ld", 0

SECTION .text

global main
main:
    push rbp

    mov rax, 0
    mov rdi, out
    mov rsi, enter
    call printf

    mov rax, 0
    mov rdi, in
    mov rsi, x 
    call scanf

    mov rax, [x]
    cmp rax, 2
    jb not_prime_label

    mov rbx, 2

;je = jump if equal
;jb = jump if below

check_loop:
    cmp rbx, rax
    jge prime_label
    ;jge = jump if greater or equal
    xor rdx, rdx
    div rbx
    cmp rdx, 0
    je not_prime_label
    mov rax, [x]
    inc rbx
    ;inc = increment
    jmp check_loop

prime_label:
    mov rax, 0
    mov rdi, out
    mov rsi, prime 
    call printf
    jmp end

not_prime_label:
    mov rax, 0
    mov rdi, out
    mov rsi, not_prime
    call printf
    jmp end

end:
    mov rax, 0
    pop rbp
    ret
