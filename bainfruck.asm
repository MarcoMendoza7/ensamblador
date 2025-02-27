section .bss
    tape resb 30000      ; Memoria de la máquina Brainfuck (30 KB)

section .data
    msg db "Introduce código Brainfuck:", 0x0A
    msg_len equ $ - msg

    read_buf times 300 db 0  ; Buffer para leer el código fuente

section .text
    global _start

_start:
    ; Mostrar mensaje
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg        ; mensaje
    mov edx, msg_len    ; longitud
    int 0x80

    ; Leer código Brainfuck desde stdin
    mov eax, 3          ; syscall read
    mov ebx, 0          ; stdin
    mov ecx, read_buf   ; buffer de entrada
    mov edx, 300        ; tamaño del buffer
    int 0x80            ; leer entrada del usuario

    mov esi, read_buf   ; ESI apunta al código
    mov edi, tape       ; EDI apunta a la memoria del programa (cinta)

bf_loop:
    mov al, [esi]       ; Leer carácter
    cmp al, 0           ; Si es NULL (fin del código), salir
    je exit

    cmp al, '>'         ; Si es '>', mover derecha
    jne check_left
    inc edi
    jmp next_char

check_left:
    cmp al, '<'         ; Si es '<', mover izquierda
    jne check_plus
    dec edi
    jmp next_char

check_plus:
    cmp al, '+'         ; Si es '+', incrementar celda
    jne check_minus
    inc byte [edi]
    jmp next_char

check_minus:
    cmp al, '-'         ; Si es '-', decrementar celda
    jne check_dot
    dec byte [edi]
    jmp next_char

check_dot:
    cmp al, '.'         ; Si es '.', imprimir celda
    jne check_comma
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, 1
    int 0x80
    jmp next_char

check_comma:
    cmp al, ','         ; Si es ',', leer input
    jne check_open_bracket
    mov eax, 3
    mov ebx, 0
    mov ecx, edi
    mov edx, 1
    int 0x80
    jmp next_char

check_open_bracket:
    cmp al, '['         ; Si es '[', manejar loops
    jne check_close_bracket
    cmp byte [edi], 0
    jne next_char
    inc esi
    mov bl, 1
find_close:
    mov al, [esi]
    cmp al, 0
    je exit
    cmp al, '['
    jne check_end_bracket
    inc bl
check_end_bracket:
    cmp al, ']'
    jne find_close
    dec bl
    jnz find_close
    jmp next_char

check_close_bracket:
    cmp al, ']'         ; Si es ']', regresar a '[' si la celda no es 0
    jne next_char
    cmp byte [edi], 0
    je next_char
    dec esi
    mov bl, 1
find_open:
    mov al, [esi]
    cmp al, 0
    je exit
    cmp al, ']'
    jne check_start_bracket
    inc bl
check_start_bracket:
    cmp al, '['
    jne find_open
    dec bl
    jnz find_open
    jmp next_char

next_char:
    inc esi
    jmp bf_loop

exit:
    mov eax, 1      ; syscall exit
    xor ebx, ebx    ; código de salida 0
    int 0x80
