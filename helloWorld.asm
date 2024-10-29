section .data
    msg db 'Hola, mundo', 0xa  ; Mensaje a imprimir con un salto de línea

section .text
    global _start

_start:
    ; Escribir el mensaje en la salida estándar
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg        ; dirección del mensaje
    mov rdx, 12         ; longitud del mensaje
    syscall             ; llamada al sistema

    ; Salir del programa
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; estado de salida: 0
    syscall             ; llamada al sistema
