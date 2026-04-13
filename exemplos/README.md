# Entradas de teste (Java--)

Cada subpasta é um **caso de teste** independente. O arquivo de código-fonte de teste chama-se sempre **`entrada.txt`**.

| Pasta | O que este teste cobre |
|-------|------------------------|
| **`programa_inicial/`** | Programa com `program`, `class`, campos, `new`, `print`, inteiro, real e hexadecimal (próximo do estilo do enunciado). |
| **`controle_fluxo/`** | **Condicional** (`if` / `else`), **laço** (`while`), `read`, `print` e operadores (`<`, `+`, etc.). |
| **`literais_identificadores/`** | Números reais e hex, literal de caractere, nome **`intx`** (identificador, não a palavra `int`), comentário `/* … */` longo. |
| **`operadores_e_arrays/`** | Operadores de comparação **`>=`**, **`<=`**, **`==`**, **`!=`**, aritmética **`%`**, acesso a vetor **`[`** **`]`** e atribuição com hexadecimal (`0xFF`). |

A saída do scanner para cada caso fica em **`output/<mesmo_nome_da_pasta>/saida.txt`**. Gere de novo com **`build.bat`** na raiz do projeto (ou `scripts\build.bat`).
