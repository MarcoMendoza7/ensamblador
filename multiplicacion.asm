section .data
    num1 db 6       ; primer número
    num2 db 7       ; segundo número
    result db 0     ; espacio para el resultado

section .text
    global _start

_start:
    ; Cargar los números en registros
    mov al, [num1]  ; cargar num1 en AL
    mov bl, [num2]  ; cargar num2 en BL
    mul bl          ; multiplicar AL por BL (AL = AL * BL)
    mov [result], al ; almacenar el resultado en la variable

    ; Terminar el programa
    mov eax, 1      ; código de syscall para salir
    xor ebx, ebx    ; código de salida 0
    int 0x80        ; llamada al kernel
