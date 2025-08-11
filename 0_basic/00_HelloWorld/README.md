# Compilation and Execution
## To compile and run the program, use:

### To run

```cobol
cobc -x HELLO.cbl
./HELLO
```
## Free Format
### If you prefer to keep the special characters, compile with:

```cobol
cobc -x -free HELLO.cbl
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
       PROGRAM-ID. HELLO.
```

* **`PROGRAM-ID`**:

  Reserved word to declare the **program name**. After this word, the identifier (in this case `HELLO`) that represents the program is written.

* **`HELLO`**:
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
  Division in which all variables, constants, registers, and data structures that the program will use are defined.
  In this example, no data is declared, but the division is included by standard structure.

---

```cobol
       PROCEDURE DIVISION.
```

* **`PROCEDURE DIVISION`**:
  Division where the **executable code** of the program is written.
  Contains the instructions that the compiler will process at runtime.

---

```cobol
           DISPLAY "HELLO mundo desde COBOL uwu".
```

* **`DISPLAY`**:
  PRINT statement that outputs the text "HELLO WORLD" to the console.
  Reserved word that **displays text on the screen** or sends output to a standard output device.
  Text must be enclosed in quotation marks.
* **`"HELLO mundo desde COBOL uwu"`**:
  Text string that is printed as is on the screen.
---

```cobol
           STOP RUN.
```

* **`STOP RUN`**:
  Reserved word that indicates **fin de la ejecución del programa**.
  Frees up resources and returns control to the operating system.

---

## Visual summary of divisions in COBOL

| Distribution           | Purpose                                                         |
| ------------------ | ----------------------------------------------------------------- |
| **IDENTIFICATION** |Program identification and metadata.                          |
| **ENVIRONMENT**    | Environment description and file/device configuration. |
| **DATA**           | Declaration of variables and data structures.                  |
| **PROCEDURE**      | Executable code and instructions that the program will carry out.      |

---
