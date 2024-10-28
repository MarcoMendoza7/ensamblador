section .data
    num1 db 5          ; Primer número
    num2 db 10         ; Segundo número
    result db 0        ; Variable para almacenar el resultado
    msg db 'El resultado es: ', 0

section .text
    global _start

_start:
    ; Cargar los números
    mov al, [num1]     ; Cargar num1 en el registro AL
    add al, [num2]     ; Sumar num2 al registro AL
    mov [result], al   ; Almacenar el resultado

    ; Preparar para imprimir el resultado
    mov edx, 21        ; Longitud del mensaje
    mov ecx, msg       ; Mensaje a imprimir
    mov ebx, 1         ; Descriptor de archivo para stdout
    mov eax, 4         ; syscall: sys_write
    int 0x80           ; Llamar al kernel

    ; Imprimir el resultado
    mov eax, [result]  ; Cargar el resultado en EAX
    add eax, '0'       ; Convertir a carácter ASCII
    mov [msg + 18], al ; Colocar el carácter en el mensaje

    mov edx, 22        ; Nueva longitud del mensaje
    mov ecx, msg       ; Mensaje a imprimir
    mov eax, 4         ; syscall: sys_write
    int 0x80           ; Llamar al kernel

    ; Salir del programa
    mov eax, 1         ; syscall: sys_exit
    xor ebx, ebx       ; Código de salida 0
    int 0x80           ; Llamar al kernel