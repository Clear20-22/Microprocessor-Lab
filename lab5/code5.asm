extern printf
extern scanf

section .data
name_prompt: db "Enter student name: ",0
score_prompt: db "Enter three scores (0-100) separated by space or newline: ",0
nl: db 10
pass: db "P",0
fail: db "F",0
three: dd 3.0
fifty: dd 50.0
sp:  db ' '

section .bss
name: resb 32
buf:  resb 32
nums: resd 4

section .text
global main

main:
    mov eax, 4
    mov ebx, 1
    mov ecx, name_prompt
    mov edx, 22
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name
    mov edx, 32
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, score_prompt
    mov edx, 60
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buf
    mov edx, 32
    int 0x80

    mov esi, buf
    xor ecx, ecx
parse:
    cmp ecx, 3
    je calc

skip:
    mov al, [esi]
    cmp al, '0'
    jb next
    cmp al, '9'
    ja next
    jmp digit
next:
    inc esi
    jmp skip

digit:
    call read_num
    mov [nums + ecx*4], eax
    inc ecx
    jmp parse

calc:
    fild dword [nums]
    fild dword [nums+4]
    fadd st1, st0
    fxch st1
    fild dword [nums+8]
    fadd st0, st2
    fld dword [three]
    fdivp st1, st0
    fstp dword [nums+12]

    fld dword [nums+12]
    fld dword [fifty]
    fcomip st0, st1
    fstp st0
    ja p
f:
    mov ecx, fail
    jmp out
p:
    mov ecx, pass

out:
    mov eax, 4
    mov ebx, 1
    mov edx, 32
    mov ecx, name
    int 0x80

    mov eax, [nums]
    call print_num
    call print_sp
    mov eax, [nums+4]
    call print_num
    call print_sp
    mov eax, [nums+8]
    call print_num
    call print_sp

    fld dword [nums+12]
    fistp dword [nums+12]
    mov eax, [nums+12]
    call print_num
    call print_sp

    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

read_num:
    xor eax, eax
loop:
    mov bl, [esi]
    cmp bl, '0'
    jb end
    cmp bl, '9'
    ja end
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp loop
end:
    ret

print_num:
    pusha
    mov edi, buf
    mov ecx, 0
    cmp eax, 0
    jne conv
    mov byte [edi], '0'
    mov edx, 1
    jmp wr
conv:
    mov ebx, 10
rev:
    xor edx, edx
    div ebx
    add dl, '0'
    push dx
    inc ecx
    test eax, eax
    jnz rev

wr_loop:
    cmp ecx, 0
    je done
    pop dx
    mov [edi], dl
    inc edi
    dec ecx
    jmp wr_loop
done:
    mov edx, edi
    sub edx, buf
    mov ecx, buf
    mov eax, 4
    mov ebx, 1
    int 0x80
    popa
    ret

print_sp:
    mov eax, 4
    mov ebx, 1
    mov ecx, sp
    mov edx, 1
    int 0x80
    ret