       IDENTIFICATION DIVISION.
       PROGRAM-ID. SISTEMA-INVENTARIO.
       AUTHOR. TU-NOMBRE.
       DATE-WRITTEN. 21/07/2025.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARCHIVO-PRODUCTOS ASSIGN TO "PRODUCTOS.DAT"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  ARCHIVO-PRODUCTOS.
       01  REGISTRO-PRODUCTO.
           05  CODIGO-PRODUCTO      PIC X(6).
           05  NOMBRE-PRODUCTO      PIC X(30).
           05  PRECIO-UNITARIO      PIC 9(5)V99.
           05  STOCK-ACTUAL         PIC 9(4).
           05  STOCK-MINIMO         PIC 9(4).

       WORKING-STORAGE SECTION.
       *> Variables para el menú y control
       01  OPCION-MENU             PIC 9(1).
       01  CONTINUAR               PIC X(1) VALUE "S".
       01  EOF-FLAG                PIC X(1) VALUE "N".
           88  FIN-ARCHIVO         VALUE "Y".
       
       *> Array para almacenar productos en memoria
       01  TABLA-PRODUCTOS.
           05  CONTADOR-PRODUCTOS  PIC 9(3) VALUE 0.
           05  PRODUCTO-ITEM       OCCURS 100 TIMES
                                   INDEXED BY IDX-PRODUCTO.
               10  TAB-CODIGO      PIC X(6).
               10  TAB-NOMBRE      PIC X(30).
               10  TAB-PRECIO      PIC 9(5)V99.
               10  TAB-STOCK       PIC 9(4).
               10  TAB-MINIMO      PIC 9(4).
               10  TAB-ESTADO      PIC X(15).

       *> Variables de trabajo y cálculo
       01  VALOR-TOTAL-INVENTARIO  PIC 9(8)V99.
       01  PRODUCTOS-CRITICOS      PIC 9(3) VALUE 0.
       01  PRODUCTO-BUSCADO        PIC X(6).
       01  ENCONTRADO              PIC X(1) VALUE "N".
           88  PRODUCTO-EXISTE     VALUE "Y".

       *> Variables para estadísticas
       01  ESTADISTICAS.
           05  TOTAL-PRODUCTOS     PIC 9(3).
           05  PRECIO-PROMEDIO     PIC 9(5)V99.
           05  STOCK-PROMEDIO      PIC 9(4)V99.

       PROCEDURE DIVISION.
       PROGRAMA-PRINCIPAL.
           PERFORM INICIALIZAR-SISTEMA
           PERFORM CARGAR-DATOS-ARCHIVO
           
           PERFORM UNTIL CONTINUAR NOT = "S"
               PERFORM MOSTRAR-MENU
               PERFORM PROCESAR-OPCION
               IF OPCION-MENU NOT = 6
                   DISPLAY " "
                   DISPLAY "¿Continuar? (S/N): " WITH NO ADVANCING
                   ACCEPT CONTINUAR
               ELSE
                   MOVE "N" TO CONTINUAR
               END-IF
           END-PERFORM
           
           PERFORM GUARDAR-DATOS-ARCHIVO
           DISPLAY "¡Sistema cerrado correctamente!"
           STOP RUN.

       INICIALIZAR-SISTEMA.
           DISPLAY "=== SISTEMA DE INVENTARIO V2.0 ===".
           DISPLAY "Inicializando sistema...".
           MOVE 0 TO CONTADOR-PRODUCTOS
           MOVE 0 TO VALOR-TOTAL-INVENTARIO.

       CARGAR-DATOS-ARCHIVO.
           OPEN INPUT ARCHIVO-PRODUCTOS
           MOVE "N" TO EOF-FLAG
           
           PERFORM UNTIL FIN-ARCHIVO
               READ ARCHIVO-PRODUCTOS
                   AT END
                       SET FIN-ARCHIVO TO TRUE
                   NOT AT END
                       ADD 1 TO CONTADOR-PRODUCTOS
                       SET IDX-PRODUCTO TO CONTADOR-PRODUCTOS
                       MOVE CODIGO-PRODUCTO TO TAB-CODIGO(IDX-PRODUCTO)
                       MOVE NOMBRE-PRODUCTO TO TAB-NOMBRE(IDX-PRODUCTO)
                       MOVE PRECIO-UNITARIO TO TAB-PRECIO(IDX-PRODUCTO)
                       MOVE STOCK-ACTUAL TO TAB-STOCK(IDX-PRODUCTO)
                       MOVE STOCK-MINIMO TO TAB-MINIMO(IDX-PRODUCTO)
                       PERFORM EVALUAR-ESTADO-STOCK
               END-READ
           END-PERFORM
           
           CLOSE ARCHIVO-PRODUCTOS
           DISPLAY "Productos cargados: " CONTADOR-PRODUCTOS.

       EVALUAR-ESTADO-STOCK.
           EVALUATE TRUE
               WHEN TAB-STOCK(IDX-PRODUCTO) = 0
                   MOVE "SIN STOCK" TO TAB-ESTADO(IDX-PRODUCTO)
               WHEN TAB-STOCK(IDX-PRODUCTO) < TAB-MINIMO(IDX-PRODUCTO)
                   MOVE "CRITICO" TO TAB-ESTADO(IDX-PRODUCTO)
                   ADD 1 TO PRODUCTOS-CRITICOS
               WHEN TAB-STOCK(IDX-PRODUCTO) < 
                    (TAB-MINIMO(IDX-PRODUCTO) * 2)
                   MOVE "BAJO" TO TAB-ESTADO(IDX-PRODUCTO)
               WHEN OTHER
                   MOVE "NORMAL" TO TAB-ESTADO(IDX-PRODUCTO)
           END-EVALUATE.

       MOSTRAR-MENU.
           DISPLAY " ".
           DISPLAY "=== MENÚ PRINCIPAL ===".
           DISPLAY "1. Listar todos los productos".
           DISPLAY "2. Buscar producto por código".
           DISPLAY "3. Productos en estado crítico".
           DISPLAY "4. Calcular valor total del inventario".
           DISPLAY "5. Estadísticas generales".
           DISPLAY "6. Salir".
           DISPLAY "Selecciona una opción (1-6): " WITH NO ADVANCING.
           ACCEPT OPCION-MENU.

       PROCESAR-OPCION.
           EVALUATE OPCION-MENU
               WHEN 1
                   PERFORM LISTAR-PRODUCTOS
               WHEN 2
                   PERFORM BUSCAR-PRODUCTO
               WHEN 3
                   PERFORM MOSTRAR-PRODUCTOS-CRITICOS
               WHEN 4
                   PERFORM CALCULAR-VALOR-INVENTARIO
               WHEN 5
                   PERFORM CALCULAR-ESTADISTICAS
               WHEN 6
                   DISPLAY "Saliendo del sistema..."
               WHEN OTHER
                   DISPLAY "Opción inválida. Intenta de nuevo."
           END-EVALUATE.

       LISTAR-PRODUCTOS.
           DISPLAY " ".
           DISPLAY "=== LISTADO COMPLETO DE PRODUCTOS ===".
           DISPLAY "CÓDIGO  NOMBRE                   PRECIO    STOCK  MIN   ESTADO".
           DISPLAY "--------------------------------------------------------------".
           
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
               DISPLAY TAB-CODIGO(IDX-PRODUCTO) " " 
                       TAB-NOMBRE(IDX-PRODUCTO)(1:20) " "
                       TAB-PRECIO(IDX-PRODUCTO) " "
                       TAB-STOCK(IDX-PRODUCTO) " "
                       TAB-MINIMO(IDX-PRODUCTO) " "
                       TAB-ESTADO(IDX-PRODUCTO)
           END-PERFORM.

       BUSCAR-PRODUCTO.
           DISPLAY " ".
           DISPLAY "Ingresa el código del producto: " WITH NO ADVANCING.
           ACCEPT PRODUCTO-BUSCADO.
           
           MOVE "N" TO ENCONTRADO
           
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
                      OR PRODUCTO-EXISTE
               IF TAB-CODIGO(IDX-PRODUCTO) = PRODUCTO-BUSCADO
                   SET PRODUCTO-EXISTE TO TRUE
                   DISPLAY " "
                   DISPLAY "=== PRODUCTO ENCONTRADO ==="
                   DISPLAY "Código: " TAB-CODIGO(IDX-PRODUCTO)
                   DISPLAY "Nombre: " TAB-NOMBRE(IDX-PRODUCTO)
                   DISPLAY "Precio: $" TAB-PRECIO(IDX-PRODUCTO)
                   DISPLAY "Stock actual: " TAB-STOCK(IDX-PRODUCTO)
                   DISPLAY "Stock mínimo: " TAB-MINIMO(IDX-PRODUCTO)
                   DISPLAY "Estado: " TAB-ESTADO(IDX-PRODUCTO)
               END-IF
           END-PERFORM
           
           IF NOT PRODUCTO-EXISTE
               DISPLAY "Producto no encontrado."
           END-IF.

       MOSTRAR-PRODUCTOS-CRITICOS.
           DISPLAY " ".
           DISPLAY "=== PRODUCTOS EN ESTADO CRÍTICO ===".
           MOVE 0 TO PRODUCTOS-CRITICOS
           
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
               IF TAB-ESTADO(IDX-PRODUCTO) = "CRITICO" OR
                  TAB-ESTADO(IDX-PRODUCTO) = "SIN STOCK"
                   ADD 1 TO PRODUCTOS-CRITICOS
                   DISPLAY TAB-CODIGO(IDX-PRODUCTO) " - " 
                           TAB-NOMBRE(IDX-PRODUCTO)(1:25) " - "
                           TAB-ESTADO(IDX-PRODUCTO) " (Stock: " 
                           TAB-STOCK(IDX-PRODUCTO) ")"
               END-IF
           END-PERFORM
           
           DISPLAY "Total productos críticos: " PRODUCTOS-CRITICOS.

       CALCULAR-VALOR-INVENTARIO.
           MOVE 0 TO VALOR-TOTAL-INVENTARIO
           
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
               COMPUTE VALOR-TOTAL-INVENTARIO = 
                   VALOR-TOTAL-INVENTARIO + 
                   (TAB-PRECIO(IDX-PRODUCTO) * TAB-STOCK(IDX-PRODUCTO))
           END-PERFORM
           
           DISPLAY " ".
           DISPLAY "=== VALOR TOTAL DEL INVENTARIO ===".
           DISPLAY "Valor total: $" VALOR-TOTAL-INVENTARIO.

       CALCULAR-ESTADISTICAS.
           MOVE CONTADOR-PRODUCTOS TO TOTAL-PRODUCTOS
           MOVE 0 TO PRECIO-PROMEDIO
           MOVE 0 TO STOCK-PROMEDIO
           
           *> Calcular promedios
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
               ADD TAB-PRECIO(IDX-PRODUCTO) TO PRECIO-PROMEDIO
               ADD TAB-STOCK(IDX-PRODUCTO) TO STOCK-PROMEDIO
           END-PERFORM
           
           IF CONTADOR-PRODUCTOS > 0
               DIVIDE PRECIO-PROMEDIO BY CONTADOR-PRODUCTOS
                   GIVING PRECIO-PROMEDIO ROUNDED
               DIVIDE STOCK-PROMEDIO BY CONTADOR-PRODUCTOS
                   GIVING STOCK-PROMEDIO ROUNDED
           END-IF
           
           DISPLAY " ".
           DISPLAY "=== ESTADÍSTICAS GENERALES ===".
           DISPLAY "Total de productos: " TOTAL-PRODUCTOS.
           DISPLAY "Precio promedio: $" PRECIO-PROMEDIO.
           DISPLAY "Stock promedio: " STOCK-PROMEDIO.
           DISPLAY "Productos críticos: " PRODUCTOS-CRITICOS.
           DISPLAY "Valor total inventario: $" VALOR-TOTAL-INVENTARIO.

       GUARDAR-DATOS-ARCHIVO.
           OPEN OUTPUT ARCHIVO-PRODUCTOS
           
           PERFORM VARYING IDX-PRODUCTO FROM 1 BY 1
                   UNTIL IDX-PRODUCTO > CONTADOR-PRODUCTOS
               MOVE TAB-CODIGO(IDX-PRODUCTO) TO CODIGO-PRODUCTO
               MOVE TAB-NOMBRE(IDX-PRODUCTO) TO NOMBRE-PRODUCTO
               MOVE TAB-PRECIO(IDX-PRODUCTO) TO PRECIO-UNITARIO
               MOVE TAB-STOCK(IDX-PRODUCTO) TO STOCK-ACTUAL
               MOVE TAB-MINIMO(IDX-PRODUCTO) TO STOCK-MINIMO
               WRITE REGISTRO-PRODUCTO
           END-PERFORM
           
           CLOSE ARCHIVO-PRODUCTOS.