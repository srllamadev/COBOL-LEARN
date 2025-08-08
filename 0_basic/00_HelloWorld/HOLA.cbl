       IDENTIFICATION DIVISION.
       PROGRAM-ID. PrintDemo.
       AUTHOR. Autor.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUMERO          PIC 9(2) VALUE 42.
       01  RETURN-CODE     PIC S9(9) BINARY.

       PROCEDURE DIVISION.
      * Limpiar pantalla (alternativa portable)
           CALL "SYSTEM" USING "clear" RETURNING RETURN-CODE
           IF RETURN-CODE NOT = 0
              CALL "SYSTEM" USING "cls" RETURNING RETURN-CODE
           END-IF.

      * Imprimir mensaje básico
           DISPLAY "¡Hola, Cobol!".

      * Múltiples elementos con espacio
           DISPLAY "Python" SPACE "es" SPACE "genial".

      * Separador personalizado (equivalente a sep)
           DISPLAY "Python-es-brutal".

      * Control de fin de línea (equivalente a end)
           DISPLAY "Esto se imprime " WITH NO ADVANCING
           DISPLAY "en una línea".

      * Imprimir número
           DISPLAY NUMERO.

      * Comillas dentro de cadenas
           DISPLAY 'Esto es una "pulgada" dentro de comillas simples'.
           DISPLAY "Esto es una ""pulgada"" dentro de comillas dobles".

      * Triple comillas (simuladas)
           DISPLAY "Esto es una ""pulgada"" dentro de triple comillas".

           STOP RUN.