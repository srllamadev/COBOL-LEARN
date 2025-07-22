       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULO-IMPUESTO-RENTA.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARCHIVO-EMPRESAS ASSIGN TO "EMPRESAS.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD ARCHIVO-EMPRESAS.
       01 REGISTRO-EMPRESA.
           05 EMP-CODIGO          PIC 9(5).
           05 EMP-NOMBRE          PIC X(30).
           05 EMP-INGRESOS        PIC 9(12)V99.
           05 EMP-GASTOS          PIC 9(12)V99.
           05 EMP-TIPO            PIC X(1).
               88 PEQUENA-EMPRESA VALUE "P".
               88 MEDIANA-EMPRESA VALUE "M".
               88 GRANDE-EMPRESA  VALUE "G".

       WORKING-STORAGE SECTION.
       01 WS-VARIABLES-CALCULO.
           05 WS-UTIL-BRUTA       PIC 9(12)V99.  *> Nombre acortado
           05 WS-UTIL-GRAVABLE    PIC 9(12)V99.  *> Nombre acortado
           05 WS-IMPUESTO-CALC    PIC 9(12)V99.  *> Nombre acortado
           05 WS-TASA-IMPUESTO    PIC 9V999.
           05 WS-DEDUCCION        PIC 9(8)V99.   *> Nombre acortado

       01 WS-CONSTANTES.
           05 TASA-PEQUENA        PIC 9V999 VALUE 0.150.
           05 TASA-MEDIANA        PIC 9V999 VALUE 0.250.
           05 TASA-GRANDE         PIC 9V999 VALUE 0.300.
           05 LIMITE-EXENCION     PIC 9(8)V99 VALUE 50000.00.
           05 DEDUCCION-PEQUENA   PIC 9(6)V99 VALUE 10000.00.
           05 DEDUCCION-MEDIANA   PIC 9(6)V99 VALUE 25000.00.
           05 DEDUCCION-GRANDE    PIC 9(6)V99 VALUE 50000.00.

       01 WS-INDICADORES.
           05 WS-EOF              PIC X VALUE "N".
               88 FIN-ARCHIVO     VALUE "S".

       01 WS-TOTALES.
           05 WS-TOTAL-EMPRESAS   PIC 9(5) VALUE ZERO.
           05 WS-TOTAL-IMPUESTOS  PIC 9(12)V99 VALUE ZERO.

       PROCEDURE DIVISION.
       MAIN-PROGRAMA.
           PERFORM INICIALIZAR
           PERFORM PROCESAR-ARCHIVO
           PERFORM MOSTRAR-TOTALES
           STOP RUN.

       INICIALIZAR.
           OPEN INPUT ARCHIVO-EMPRESAS
           DISPLAY "SISTEMA DE CALCULO DE IMPUESTO SOBRE LA RENTA"
           DISPLAY "=================================================="
           DISPLAY " ".

       PROCESAR-ARCHIVO.
           PERFORM LEER-REGISTRO
           PERFORM UNTIL FIN-ARCHIVO
               PERFORM CALCULAR-IMPUESTO-EMPRESA
               PERFORM MOSTRAR-CALCULO
               PERFORM LEER-REGISTRO
           END-PERFORM
           CLOSE ARCHIVO-EMPRESAS.

       LEER-REGISTRO.
           READ ARCHIVO-EMPRESAS
               AT END
                   SET FIN-ARCHIVO TO TRUE
           END-READ.

       CALCULAR-IMPUESTO-EMPRESA.
           MOVE ZERO TO WS-IMPUESTO-CALC
           MOVE ZERO TO WS-TASA-IMPUESTO
           MOVE ZERO TO WS-DEDUCCION

           COMPUTE WS-UTIL-BRUTA = EMP-INGRESOS - EMP-GASTOS

           IF WS-UTIL-BRUTA <= ZERO
               MOVE ZERO TO WS-IMPUESTO-CALC
           ELSE
               IF WS-UTIL-BRUTA <= LIMITE-EXENCION
                   MOVE ZERO TO WS-IMPUESTO-CALC
               ELSE
                   EVALUATE TRUE
                       WHEN PEQUENA-EMPRESA
                           MOVE TASA-PEQUENA TO WS-TASA-IMPUESTO
                           MOVE DEDUCCION-PEQUENA TO WS-DEDUCCION
                       WHEN MEDIANA-EMPRESA
                           MOVE TASA-MEDIANA TO WS-TASA-IMPUESTO
                           MOVE DEDUCCION-MEDIANA TO WS-DEDUCCION
                       WHEN GRANDE-EMPRESA
                           MOVE TASA-GRANDE TO WS-TASA-IMPUESTO
                           MOVE DEDUCCION-GRANDE TO WS-DEDUCCION
                       WHEN OTHER
                           DISPLAY "ERROR: TIPO NO VALIDO " EMP-TIPO
                           MOVE ZERO TO WS-IMPUESTO-CALC
                   END-EVALUATE

                   COMPUTE WS-UTIL-GRAVABLE = WS-UTIL-BRUTA - WS-DEDUCCION

                   IF WS-UTIL-GRAVABLE <= ZERO
                       MOVE ZERO TO WS-IMPUESTO-CALC
                   ELSE
                       COMPUTE WS-IMPUESTO-CALC = WS-UTIL-GRAVABLE * WS-TASA-IMPUESTO
                   END-IF
               END-IF
           END-IF

           ADD 1 TO WS-TOTAL-EMPRESAS
           ADD WS-IMPUESTO-CALC TO WS-TOTAL-IMPUESTOS.

       MOSTRAR-CALCULO.
           DISPLAY "EMPRESA: " EMP-CODIGO " - " EMP-NOMBRE
           DISPLAY "  INGRESOS: " EMP-INGRESOS
           DISPLAY "  GASTOS: " EMP-GASTOS  
           DISPLAY "  UTILIDAD BRUTA: " WS-UTIL-BRUTA
           
           IF WS-UTIL-BRUTA <= ZERO
               DISPLAY "  ESTADO: SIN UTILIDADES - IMPUESTO: 0.00"
           ELSE
               IF WS-UTIL-BRUTA <= LIMITE-EXENCION
                   DISPLAY "  ESTADO: EXENTA - IMPUESTO: 0.00"
               ELSE
                   DISPLAY "  TIPO EMPRESA: " EMP-TIPO
                   DISPLAY "  TASA APLICADA: " WS-TASA-IMPUESTO
                   DISPLAY "  DEDUCCION: " WS-DEDUCCION
                   DISPLAY "  UTILIDAD GRAVABLE: " WS-UTIL-GRAVABLE
                   DISPLAY "  IMPUESTO A PAGAR: " WS-IMPUESTO-CALC
               END-IF
           END-IF
           
           DISPLAY " ".

       MOSTRAR-TOTALES.
           DISPLAY "=================================================="
           DISPLAY "RESUMEN FINAL:"
           DISPLAY "TOTAL DE EMPRESAS PROCESADAS: " WS-TOTAL-EMPRESAS
           DISPLAY "TOTAL DE IMPUESTOS CALCULADOS: " WS-TOTAL-IMPUESTOS
           DISPLAY "==================================================".