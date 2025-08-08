# Compilation and Execution
## To compile and run the program, use:

### To run

```cobol
cobc -x HOLA.cbl
./HOLA
```
## Free Format
### If you prefer to keep the special characters, compile with:

```cobol
cobc -x -free HOLA.cbl
```

# Line by line explanation of the COBOL code

```cobol
       IDENTIFICATION DIVISION.
```

* **`IDENTIFICATION DIVISION`**:
- Mandatory division in all COBOL programs.
- It serves to identify the program and contains descriptive information.
- It is the first division that must appear in a COBOL program.

---

```cobol
       PROGRAM-ID. HOLA.
```

* **`PROGRAM-ID`**:
  Palabra reservada para declarar el **nombre del programa**.
  Después de esta palabra, se escribe el identificador (en este caso `HOLA`) que representa al programa.

  Reserved word to declare the **program name**. After this word, the identifier (in this case `HOLA`) that represents the program is written.

* **`HOLA`**:
  Nombre asignado al programa. No puede contener espacios y suele escribirse en mayúsculas por convención.

---

```cobol
       ENVIRONMENT DIVISION.
```

* **`ENVIRONMENT DIVISION`**:
  División donde se describen las características del entorno donde el programa se ejecutará.
  Puede incluir información sobre dispositivos de entrada/salida, archivos y configuración del sistema.
  En este ejemplo, no se usa más información dentro de esta división.

---

```cobol
       DATA DIVISION.
```

* **`DATA DIVISION`**:
  División en la que se definen todas las variables, constantes, registros y estructuras de datos que el programa utilizará.
  En este ejemplo, no se declaran datos, pero la división se incluye por estructura estándar.

---

```cobol
       PROCEDURE DIVISION.
```

* **`PROCEDURE DIVISION`**:
  División donde se escribe el **código ejecutable** del programa.
  Contiene las instrucciones que el compilador procesará en tiempo de ejecución.

---

```cobol
           DISPLAY "Hola mundo desde COBOL uwu".
```

* **`DISPLAY`**:
  Palabra reservada que **muestra texto en pantalla** o envía salida a un dispositivo de salida estándar.
  El texto debe ir entre comillas.
* **`"Hola mundo desde COBOL uwu"`**:
  Cadena de texto que se imprime tal cual en pantalla.
---

```cobol
           STOP RUN.
```

* **`STOP RUN`**:
  Palabra reservada que indica **fin de la ejecución del programa**.
  Libera recursos y retorna el control al sistema operativo.

---

## 📌 Resumen visual de las divisiones en COBOL

| División           | Propósito                                                         |
| ------------------ | ----------------------------------------------------------------- |
| **IDENTIFICATION** | Identificación y metadatos del programa.                          |
| **ENVIRONMENT**    | Descripción del entorno y configuración de archivos/dispositivos. |
| **DATA**           | Declaración de variables y estructuras de datos.                  |
| **PROCEDURE**      | Código ejecutable e instrucciones que realizará el programa.      |

---

Si quieres, puedo hacerte **otra versión del mismo documento pero con un diagrama visual** para que en tu GitHub sea más amigable y atractivo.
