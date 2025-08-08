       IDENTIFICATION DIVISION.
       PROGRAM-ID. PrintDemo.
       AUTHOR. srllamadev.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CONSOLE IS CRT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUMERO          PIC 9(2) VALUE 42.

       PROCEDURE DIVISION.
       *>  Limpiar pantalla comando dependiente sistema
           DISPLAY " " BLANK SCREEN.

       *>  Imprimir mensaje básico
           DISPLAY "Hola desde COBOL".
       *>  Este es el salto de linea
           DISPLAY "".
       *>  Múltiples elementos con espacio
           DISPLAY "Cobol" SPACE "es" SPACE "genial".

       *>  Separador personalizado (equivalente a sep)
           DISPLAY "COBOL-ES-INTERESANTE".

       *>  Imprimir número
           DISPLAY NUMERO.

       *>  Triple comillas (simuladas)
           DISPLAY "Esto es una ""palabra"" dentro de triple comillas".

           STOP RUN.