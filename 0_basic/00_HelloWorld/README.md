## Compilación y Ejecución

# Para compilar y ejecutar el programa, usa:
# Para ejecutar
```bash
cobc -x HOLA.cbl
./HOLA
```
# Formato Libre
# Si prefieres mantener los caracteres especiales, compila con:

```bash
cobc -x -free HOLA.cbl

Perfecto, te voy a documentar tu código COBOL línea por línea en **formato Markdown**, explicando cada palabra reservada y lo que hace en este contexto.

Aquí tienes el resultado listo para que lo subas a tu GitHub:

---

# Explicación línea por línea del código COBOL

```cobol
       IDENTIFICATION DIVISION.
```

* **`IDENTIFICATION DIVISION`**:
  División obligatoria en todo programa COBOL.
  Sirve para identificar el programa y contiene información descriptiva.
  Es la primera división que debe aparecer en un programa COBOL.

---

```cobol
       PROGRAM-ID. HOLA.
```

* **`PROGRAM-ID`**:
  Palabra reservada para declarar el **nombre del programa**.
  Después de esta palabra, se escribe el identificador (en este caso `HOLA`) que representa al programa.
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
           DISPLAY "Hola ".
```

* Igual que la línea anterior, pero mostrando solo la palabra **Hola** seguida de un espacio.

---

```cobol
           DISPLAY "Test update github".
```

* Otra instrucción `DISPLAY`, esta vez mostrando el texto `"Test update github"`.
  Útil para verificar cambios en versiones de control como GitHub.

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
