# apellido-post2-u4

Laboratorio 2 de la Unidad 4 - Arquitectura de Computadores. Implementación de macros con parámetros, bucles LOOP y condicionales CMP/Jcc en NASM para DOS de 16 bits.

## Prerrequisitos
- DOSBox 0.74+
- NASM 2.14+
- ALINK 1.6
- CWSDPMI (requerido por ALINK)

## Compilación y ejecución

```asm
nasm -f obj programa2.asm -o programa2.obj
alink programa2.obj -oEXE -o programa2.exe -entry main
programa2.exe
```

> Si aparece "No DPMI-host found", ejecutar `cwsdpmi` antes de alink.

## Salida esperada

=== Macros y Control de Flujo ===
[Linea A] Primera impresion
[Linea A] Primera impresion
[Linea A] Primera impresion
[Linea B] Segunda impresion
[Linea B] Segunda impresion
Resultado de la suma: 6
El valor mayor es: 9
Los valores son iguales.
Fin del programa.

## Archivos
- `macros.asm` — biblioteca de macros utilitarias (incluida via `%include`)
- `programa2.asm` — programa principal
- `capturas/` — evidencia de compilación y ejecución
