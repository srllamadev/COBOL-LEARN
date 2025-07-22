## Compilación y Ejecución

# Para compilar y ejecutar el programa, usa:
# Para ejecutar
```bash
cobc -x EXAMPLE1.cbl
./EXAMPLE1
```
# Formato Libre
# Si prefieres mantener los caracteres especiales, compila con:

```bash
cobc -x -free EXAMPLE1.cbl
```

### Explicación del código COBOL con IF-THEN-ELSE para calificaciones

Aquí te explico el funcionamiento paso a paso con un ejemplo de código COBOL:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULA-CALIFICACION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NOMBRE-ESTUDIANTE     PIC X(30).
       01  NOTA-ESTUDIANTE       PIC 9(3).
       01  CALIFICACION-LETRA    PIC X.
       01  ESTADO-APROBACION     PIC X(10).

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "Nombre del estudiante: "
           ACCEPT NOMBRE-ESTUDIANTE
           
           DISPLAY "Nota obtenida (0-100): "
           ACCEPT NOTA-ESTUDIANTE
           
      * --- VALIDACIÓN INICIAL (IF SIMPLE) ---
           IF NOTA-ESTUDIANTE < 0 OR NOTA-ESTUDIANTE > 100
               DISPLAY "ERROR: Nota inválida (debe ser 0-100)"
               STOP RUN
           END-IF
           
      * --- ASIGNACIÓN DE CALIFICACIÓN (IF ANIDADO) ---
           IF NOTA-ESTUDIANTE >= 90
               MOVE 'A' TO CALIFICACION-LETRA
           ELSE IF NOTA-ESTUDIANTE >= 80
               MOVE 'B' TO CALIFICACION-LETRA
           ELSE IF NOTA-ESTUDIANTE >= 70
               MOVE 'C' TO CALIFICACION-LETRA
           ELSE IF NOTA-ESTUDIANTE >= 60
               MOVE 'D' TO CALIFICACION-LETRA
           ELSE
               MOVE 'F' TO CALIFICACION-LETRA
           END-IF
           
      * --- DETERMINAR APROBACIÓN (IF-THEN-ELSE) ---
           IF NOTA-ESTUDIANTE >= 60
               MOVE "APROBADO" TO ESTADO-APROBACION
           ELSE
               MOVE "REPROBADO" TO ESTADO-APROBACION
           END-IF
           
      * --- MOSTRAR RESULTADOS ---
           DISPLAY "--------------------------------"
           DISPLAY "Estudiante: " NOMBRE-ESTUDIANTE
           DISPLAY "Calificación: " CALIFICACION-LETRA
           DISPLAY "Estado: " ESTADO-APROBACION
           
           STOP RUN.
```

### Puntos clave explicados:

1. **Validación inicial (IF simple):**
```cobol
IF NOTA-ESTUDIANTE < 0 OR NOTA-ESTUDIANTE > 100
    DISPLAY "ERROR: Nota inválida..."
    STOP RUN
END-IF
```
- Verifica que la nota esté en el rango 0-100 usando operadores lógicos (`OR`)
- Si no cumple, muestra error y termina el programa (`STOP RUN`)
- **END-IF** es obligatorio para cerrar el bloque

2. **Asignación de calificación (IF anidado):**
```cobol
IF NOTA-ESTUDIANTE >= 90
    MOVE 'A' TO CALIFICACION-LETRA
ELSE IF NOTA-ESTUDIANTE >= 80
    MOVE 'B' TO CALIFICACION-LETRA
...
ELSE
    MOVE 'F' TO CALIFICACION-LETRA
END-IF
```
- Usa una estructura **ELSE IF** anidada para evaluar múltiples condiciones
- Las condiciones se evalúan en orden descendente (de mayor a menor)
- **MOVE** asigna el valor a la variable según la condición
- Solo un bloque se ejecutará (el primero que cumpla la condición)

3. **Determinación de aprobación:**
```cobol
IF NOTA-ESTUDIANTE >= 60
    MOVE "APROBADO" TO ESTADO-APROBACION
ELSE
    MOVE "REPROBADO" TO ESTADO-APROBACION
END-IF
```
- IF-THEN-ELSE simple para determinar aprobación (>=60)
- No se requiere **THEN** explícito en COBOL (la acción va después de la condición)

### Características importantes de COBOL:

1. **Sintaxis de IF:**
```cobol
IF condición
   [sentencias...]
[ELSE
   [sentencias...]]
END-IF
```

2. **Operadores comunes:**
- `>` Mayor que
- `<` Menor que
- `>=` Mayor o igual que
- `<=` Menor o igual que
- `=` Igual a
- `OR`/`AND` Operadores lógicos

3. **Reglas esenciales:**
- **END-IF** es obligatorio para cada IF
- La indentación no es obligatoria pero mejora la legibilidad
- Las condiciones pueden usar variables literales o numéricas
- Se pueden agrupar condiciones con paréntesis:
  ```cobol
  IF (NOTA >= 50 AND NOTA < 60) OR (ASISTENCIA > 80)
  ```

### Flujo del programa:
1. Solicita nombre y nota
2. Valida que la nota sea 0-100
3. Asigna letra (A-F) según rango
4. Determina aprobación (>=60)
5. Muestra resultados formateados

Ejemplo de salida:
```
--------------------------------
Estudiante: MARÍA LÓPEZ
Calificación: B
Estado: APROBADO
```

Este ejemplo muestra cómo COBOL maneja lógica condicional compleja usando estructuras anidadas de IF-THEN-ELSE, manteniendo claridad mediante una indentación adecuada y cierre explícito de bloques con END-IF.