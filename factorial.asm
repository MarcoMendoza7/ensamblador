section .data
    num db 5                 ; Número para calcular el factorial
    result db 0              ; Almacena el resultado
    msg db 'El factorial es: ', 0  ; Mensaje a imprimir

section .text
    global _start

_start:
    ; Calcular el factorial
    movzx rax, byte [num]    ; Cargar el número en rax
    mov rbx, rax              ; Copiar el número a rbx
    dec rbx                   ; Decrementar rbx para empezar el cálculo
    mov rcx, 1                ; Inicializar el resultado en rcx a 1

factorial_loop:
    ; Si rbx es 0, terminar el bucle
    cmp rbx, 0
    je print_result           ; Si rbx es 0, saltar a imprimir resultado

    ; Multiplicar el resultado por el número actual
    imul rcx, rax            ; rcx = rcx * rax

    ; Decrementar rax y rbx
    dec rax                   ; Decrementar el número
    dec rbx                   ; Decrementar el contador
    jmp factorial_loop        ; Volver al inicio del bucle

print_result:
    ; Escribir el mensaje
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, msg              ; dirección del mensaje
    mov rdx, 20               ; longitud del mensaje
    syscall                   ; llamada al sistema

    ; Convertir el resultado a ASCII y imprimir
    mov rax, rcx              ; Resultado del factorial
    call print_number          ; Llamar a la función para imprimir el número

    ; Terminar el programa
    mov rax, 60               ; syscall: exit
    xor rdi, rdi              ; status: 0
    syscall                   ; llamada al sistema

print_number:
    ; Imprimir un número en rax (0-255)
    mov rbx, 10               ; Divisor para conversión a base 10
    xor rcx, rcx              ; Contador de dígitos

.convert_loop:
    xor rdx, rdx              ; Limpiar rdx antes de la división
    div rbx                   ; rax = rax / 10, rdx = rax % 10
    push rdx                  ; Guardar el dígito
    inc rcx                   ; Aumentar el contador de dígitos
    test rax, rax             ; Verificar si el cociente es cero
    jnz .convert_loop         ; Si no es cero, seguir dividiendo

.print_loop:
    pop rax                   ; Recuperar el dígito
    add al, '0'               ; Convertir a carácter ASCII
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, rax              ; carácter a imprimir
    mov rdx, 1                ; longitud: 1
    syscall                   ; llamada al sistema
    dec rcx                   ; Disminuir el contador
    jnz .print_loop           ; Si hay más dígitos, imprimir

    ret                       ; Volver de la función
