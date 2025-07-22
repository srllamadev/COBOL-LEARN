       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALIFICACION-ESTUDIANTE.
       AUTHOR. TU-NOMBRE.
       DATE-WRITTEN. 21/07/2025.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NOMBRE-ESTUDIANTE    PIC X(30).
       01  NOTA                 PIC 9(3).
       01  LETRA-CALIFICACION   PIC X(1).
       01  MENSAJE              PIC X(50).

       PROCEDURE DIVISION.
       INICIO.
           DISPLAY "=== SISTEMA DE CALIFICACIONES ===".
           DISPLAY "Ingresa el nombre del estudiante: ".
           ACCEPT NOMBRE-ESTUDIANTE.
           
           DISPLAY "Ingresa la nota (0-100): ".
           ACCEPT NOTA.
           
           *> Validar que la nota esté en rango válido
           IF NOTA < 0 OR NOTA > 100
               DISPLAY "ERROR: La nota debe estar entre 0 y 100"
               GO TO FIN-PROGRAMA
           END-IF.
           
           *> Asignar calificación con IF-THEN-ELSE anidados
           IF NOTA >= 90
               MOVE "A" TO LETRA-CALIFICACION
               MOVE "EXCELENTE" TO MENSAJE
           ELSE
               IF NOTA >= 80
                   MOVE "B" TO LETRA-CALIFICACION
                   MOVE "MUY BUENO" TO MENSAJE
               ELSE
                   IF NOTA >= 70
                       MOVE "C" TO LETRA-CALIFICACION
                       MOVE "BUENO" TO MENSAJE
                   ELSE
                       IF NOTA >= 60
                           MOVE "D" TO LETRA-CALIFICACION
                           MOVE "SUFICIENTE" TO MENSAJE
                       ELSE
                           MOVE "F" TO LETRA-CALIFICACION
                           MOVE "INSUFICIENTE" TO MENSAJE
                       END-IF
                   END-IF
               END-IF
           END-IF.
           
           *> Mostrar resultados
           DISPLAY " ".
           DISPLAY "=== RESULTADO ===".
           DISPLAY "Estudiante: " NOMBRE-ESTUDIANTE.
           DISPLAY "Nota: " NOTA.
           DISPLAY "Calificacion: " LETRA-CALIFICACION.
           DISPLAY "Comentario: " MENSAJE.
           
           *> Ejemplo adicional: Verificar si aprobó o no
           IF NOTA >= 60
               DISPLAY "Estado: APROBADO"
           ELSE
               DISPLAY "Estado: REPROBADO"
           END-IF.

       FIN-PROGRAMA.
           DISPLAY "Presiona ENTER para salir...".
           ACCEPT NOMBRE-ESTUDIANTE.
           STOP RUN.