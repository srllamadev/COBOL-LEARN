# 编译和执行
## 要编译和运行程序，请使用：

### 运行

```cobol
cobc -x HELLO.cbl
./HELLO
```
## 自由格式
### 如果你更喜欢保留特殊字符，请使用：

```cobol
cobc -x -free HELLO.cbl
```

# COBOL 代码逐行解释

```cobol
       IDENTIFICATION DIVISION.
```

* **`IDENTIFICATION DIVISION`**:
- 所有 COBOL 程序中必不可少的部分。
- 用于识别程序并包含描述信息。
- 必须是 COBOL 程序中的第一个部分。

---

```cobol
       PROGRAM-ID. HELLO.
```

* **`PROGRAM-ID`**:

  保留字，用于声明 **程序名称**。在此单词之后，写出标识符（在本例中为 `HELLO`），表示该程序。

* **`HELLO`**:
  分配给程序的名称。不能包含空格，通常按照约定用大写字母书写。

---

```cobol
       ENVIRONMENT DIVISION.
```

* **`ENVIRONMENT DIVISION`**:
  描述程序执行环境特征的部分。
  可以包含输入/输出设备、文件和系统配置的信息。
  在此示例中，该部分没有使用更多信息。

---

```cobol
       DATA DIVISION.
```

* **`DATA DIVISION`**:
  定义程序将使用的所有变量、常量、寄存器和数据结构的部分。
  在此示例中，没有声明数据，但该部分是标准结构的一部分。

---

```cobol
       PROCEDURE DIVISION.
```

* **`PROCEDURE DIVISION`**:
  编写程序 **可执行代码** 的部分。
  包含编译器在运行时处理的指令。

---

```cobol
           DISPLAY "HELLO WORLD".
```

* **`DISPLAY`**:
  输出语句，将文本 "HELLO WORLD" 打印到控制台。
  保留字，用于 **在屏幕上显示文本** 或将输出发送到标准输出设备。
  文本必须用引号括起来。
* **`"HELLO"`**:
  作为文本字符串直接打印在屏幕上的内容。
---

```cobol
           STOP RUN.
```

* **`STOP RUN`**:
  保留字，表示 **程序执行结束**。
  释放资源并将控制权返回给操作系统。

---

## COBOL 各部分的视觉总结

| 部分                 | 目的                                                         |
| ------------------ | ------------------------------------------------------------- |
| **IDENTIFICATION** | 程序识别和元数据。                                          |
| **ENVIRONMENT**    | 环境描述和文件/设备配置。                                   |
| **DATA**           | 变量和数据结构的声明。                                      |
| **PROCEDURE**      | 可执行代码和程序将执行的指令。                              |