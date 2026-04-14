; programa2.asm - Laboratorio Post2 Unidad 4
; Proposito: demostrar macros con parametros, bucles LOOP y condicionales CMP/Jcc

%include "macros.asm"       ; incluir biblioteca de macros utilitarias

; ── Datos inicializados ──────────────────────────────────────────────────
section .data
    titulo      db "=== Macros y Control de Flujo ===", 0Dh, 0Ah, 24h
    linea_a     db "[Linea A] Primera impresion", 0Dh, 0Ah, 24h
    linea_b     db "[Linea B] Segunda impresion", 0Dh, 0Ah, 24h
    msg_mayor   db "El valor mayor es: ", 24h
    msg_iguales db "Los valores son iguales.", 0Dh, 0Ah, 24h
    msg_suma    db "Resultado de la suma: ", 24h
    msg_fin     db "Fin del programa.", 0Dh, 0Ah, 24h

; ── Datos no inicializados ───────────────────────────────────────────────
section .bss
    valor_a     resw 1
    valor_b     resw 1

; ── Codigo ejecutable ────────────────────────────────────────────────────
section .text
    global main

main:
    ; Inicializar registro de segmento de datos
    mov ax, seg titulo      ; obtener segmento donde vive .data
    mov ds, ax              ; DS apunta a la seccion de datos

    ; 1. Encabezado con macro print_str
    print_str titulo

    ; 2. Demostracion de macro repetir_str
    repetir_str linea_a, 3  ; imprime linea_a exactamente 3 veces
    repetir_str linea_b, 2  ; imprime linea_b exactamente 2 veces

    ; 3. Suma 1+2+3 = 6, luego imprimir resultado
    print_str msg_suma
    mov cx, 3               ; N = 3 → 1+2+3 = 6
    call sumar_serie        ; resultado en AX = 6
    print_digito            ; imprime el digito "6"
    nueva_linea

    ; 4. Comparar 9 vs 4 → mayor es 9
    mov ax, 9
    mov bx, 4
    call comparar_e_imprimir

    ; 5. Comparar 5 vs 5 → iguales
    mov ax, 5
    mov bx, 5
    call comparar_e_imprimir

    ; 6. Mensaje final y terminacion
    print_str msg_fin
    fin_dos

; ────────────────────────────────────────────────────────────────────────
; Procedimiento: suma acumulativa 1+2+3+...+N
; Entrada:  CX = N
; Salida:   AX = suma total
; Modifica: AX (intencionalmente), preserva CX
; ────────────────────────────────────────────────────────────────────────
sumar_serie:
    push cx                 ; preservar CX (se modifica con LOOP)
    xor ax, ax              ; AX = 0 (acumulador)
.paso:
    add ax, cx              ; AX += CX (suma N, N-1, ..., 1)
    loop short .paso        ; CX--; si CX != 0, continuar
    pop cx                  ; restaurar CX original
    ret

; ────────────────────────────────────────────────────────────────────────
; Procedimiento: comparar AX y BX e imprimir el mayor
; Entrada:  AX = primer valor, BX = segundo valor (ambos 0-9)
; Salida:   ninguna (solo imprime en pantalla)
; Preserva: AX, BX
; ────────────────────────────────────────────────────────────────────────
comparar_e_imprimir:
    push ax
    push bx

    cmp ax, bx
    je  .son_iguales
    jg  .ax_mayor

    ; BX es mayor → AL = BL
    print_str msg_mayor
    mov al, bl
    print_digito
    nueva_linea
    jmp short .fin_comp

.ax_mayor:
    ; AX es mayor → AL = AL (ya esta en AL desde AX)
    print_str msg_mayor
    ; AL sigue siendo el byte bajo de AX (no se ha tocado)
    print_digito
    nueva_linea

.son_iguales:
    cmp ax, bx
    jne .fin_comp           ; evita imprimir si ya se proceso arriba
    print_str msg_iguales

.fin_comp:
    pop bx
    pop ax
    ret
