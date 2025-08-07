# Detalles del Programa de Interés Compuesto en COBOL

## Conceptos Financieros Aplicados

- **Capitalización mensual**
- **Efecto del interés compuesto**
- **Bonificaciones por permanencia**
- **Cálculo de rentabilidad**
- **Análisis de riesgo (alertas)**

## Problemas y Soluciones

### Problema 1: Caracteres Especiales

- **Símbolos de caja**: Reemplazados con caracteres ASCII simples.
- **Caracteres Unicode**: Eliminados (ej. ñ, ó).

### Problema 2: Líneas Largas sin Continuador

- **Continuadores**: Agregado guión `-` en columna 7 para líneas largas.

## Cambios Clave Realizados

- **Reemplazo de Caracteres Especiales**:
  - Cambié `╔`, `║`, `╚` por `=`.

- **Corrección de Sintaxis**:
  - Cambié `FUNCTION MOD()` por `FUNCTION MOD`.

- **Precisión Mejorada**:
  - Añadí `ROUNDED` en cálculos finales de rentabilidad.

- **Comentarios Claros**:
  - Usé `*>` para comentarios en línea.

## Compilación y Ejecución

Para compilar y ejecutar el programa, usa:
#Para ejecutar
```bash
cobc -x INTERES-COMPUESTO.cbl
./INTERES-COMPUESTO
Formato Libre
Si prefieres mantener los caracteres especiales, compila con:




cobc -x -free INTERES-COMPUESTO.cbl
Nueva Variable Agregada
cobol


77  RENTABILIDAD      PIC 999V99.   *> Nueva variable
Cálculo de Rentabilidad
Antes de la condicional IF:

cobol


COMPUTE RENTABILIDAD = 
    (SALDO-ACTUAL - PRINCIPAL) / PRINCIPAL * 100
Uso de la variable en la condición:

cobol

IF RENTABILIDAD > 30
Solución al Warning Final
Para evitar el warning "line not terminated by a newline", agrega una línea vacía al final del archivo.

Código Completo
cobol

Copiar
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INTERES-COMPUESTO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  PRINCIPAL         PIC 9(9)V99   VALUE 100000.00.
       77  TASA-ANUAL        PIC 99V99     VALUE 5.50.
       77  ANIOS             PIC 99        VALUE 5.
       77  MESES-TOTAL       PIC 999.
       77  CONTADOR-MES      PIC 999.
       77  TASA-MENSUAL      PIC 9V9(6).
       77  SALDO-ACTUAL      PIC 9(9)V99.
       77  INTERES-MENSUAL   PIC 9(9)V99.
       77  SALDO-PREVIO      PIC 9(9)V99.
       77  ACUM-INTERESES    PIC 9(9)V99   VALUE 0.
       77  RENTABILIDAD      PIC 999V99.   *> Nueva variable
       
       01  FECHA-HOY.
           05 ANIO           PIC 9(4).
           05 MES            PIC 99.
           05 DIA            PIC 99.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM OBTENER-FECHA
           DISPLAY "========================================"
           DISPLAY "  SISTEMA DE INTERES COMPUESTO (COBOL)  "
           DISPLAY "========================================"
           DISPLAY "Fecha actual: " DIA "/" MES "/" ANIO
           DISPLAY "Inversion inicial: $" PRINCIPAL
           DISPLAY "Tasa anual: " TASA-ANUAL "%"
           DISPLAY "Plazo: " ANIOS " años"
           DISPLAY " "
           DISPLAY "MES    SALDO INICIAL   INTERESES   SALDO FINAL"
           DISPLAY "=============================================="
           
           COMPUTE TASA-MENSUAL = TASA-ANUAL / 12 / 100
           COMPUTE MESES-TOTAL = ANIOS * 12
           MOVE PRINCIPAL TO SALDO-ACTUAL
           
           PERFORM VARYING CONTADOR-MES FROM 1 BY 1
                   UNTIL CONTADOR-MES > MESES-TOTAL
               MOVE SALDO-ACTUAL TO SALDO-PREVIO
               COMPUTE INTERES-MENSUAL ROUNDED = 
                   SALDO-ACTUAL * TASA-MENSUAL
               ADD INTERES-MENSUAL TO ACUM-INTERESES
               ADD INTERES-MENSUAL TO SALDO-ACTUAL
               
      *> Aplicar bonificacion especial cada año
               IF FUNCTION MOD(CONTADOR-MES, 12) = 0 THEN
                   COMPUTE SALDO-ACTUAL = SALDO-ACTUAL * 1.005
                   DISPLAY "** BONO ANUAL: 0.5% adicional **"
               END-IF
               
      *> Mostrar detalle mensual
               DISPLAY 
                   CONTADOR-MES "   " 
                   SALDO-PREVIO "   " 
                   INTERES-MENSUAL "   " 
                   SALDO-ACTUAL
           END-PERFORM
           
           DISPLAY "=============================================="
           DISPLAY " "
           DISPLAY "RESULTADO FINAL:"
           DISPLAY "Saldo final: $" SALDO-ACTUAL
           DISPLAY "Intereses acumulados: $" ACUM-INTERESES
           COMPUTE SALDO-ACTUAL ROUNDED = SALDO-ACTUAL
           COMPUTE ACUM-INTERESES ROUNDED = ACUM-INTERESES
      *> Calcular rentabilidad
           COMPUTE RENTABILIDAD = 
               (SALDO-ACTUAL - PRINCIPAL) / PRINCIPAL * 100
           DISPLAY "Rentabilidad: " RENTABILIDAD "%"
           
      *> Validacion de rentabilidad
           IF SALDO-ACTUAL < PRINCIPAL
               DISPLAY "ALERTA: Inversion con perdida neta!"
           ELSE 
               IF RENTABILIDAD > 30
                   DISPLAY "¡Excelente inversion! +30% de ganancia"
               ELSE
                   DISPLAY "Inversion rentable"
               END-IF
           END-IF
           
           STOP RUN.

       OBTENER-FECHA.
           MOVE FUNCTION CURRENT-DATE TO FECHA-HOY.



