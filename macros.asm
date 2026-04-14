; macros.asm - biblioteca de macros utilitarias para NASM 16-bit DOS

; Macro: terminar programa DOS con codigo de salida 0
%macro fin_dos 0
    mov ax, 4C00h
    int 21h
%endmacro

; Macro: imprimir nueva linea (CR + LF)
%macro nueva_linea 0
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov ah, 02h
    mov dl, 0Ah
    int 21h
%endmacro

; Macro: imprimir cadena terminada en "$"
; %1 = etiqueta de la cadena
%macro print_str 1
    mov ah, 09h
    mov dx, %1
    int 21h
%endmacro

; Macro: imprimir un caracter unico
; %1 = valor ASCII del caracter (inmediato o registro)
%macro print_char 1
    mov ah, 02h
    mov dl, %1
    int 21h
%endmacro

; Macro: leer un caracter desde teclado (sin eco)
; Resultado queda en AL
%macro leer_char 0
    mov ah, 07h
    int 21h
%endmacro

; Macro: imprimir una cadena N veces
; %1 = etiqueta de la cadena a imprimir
; %2 = numero de repeticiones (inmediato numerico)
%macro repetir_str 2
    mov cx, %2              ; CX = contador de repeticiones
%%ciclo:                    ; %% genera etiqueta unica por expansion
    mov ah, 09h
    mov dx, %1
    int 21h
    loop short %%ciclo      ; CX--; si CX != 0, repetir
%endmacro

; Macro: imprimir digito decimal de un valor 0-9 almacenado en AL
%macro print_digito 0
    push ax                 ; preservar AX
    and al, 0Fh             ; asegurar nibble bajo (0-9)
    add al, 30h             ; convertir a ASCII: 0->"0", 9->"9"
    mov ah, 02h
    mov dl, al
    int 21h
    pop ax                  ; restaurar AX
%endmacro
