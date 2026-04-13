# Entradas de teste (Java--)

Cada subpasta é um **caso de teste** independente. O arquivo de código-fonte de teste chama-se sempre **`entrada.txt`**.

## Glossário (nomes das pastas)

- **`programa_inicial`:** um programa Java-- “completo” de exemplo (com `program`, `class`, `main`, `new`, `print`), parecido com o que costuma aparecer no enunciado.
- **`controle_fluxo`:** “fluxo” é **para onde o programa desvia** conforme condições e repetições. Aqui aparecem **`if` / `else`**, **`while`**, leitura **`read`** e escrita **`print`** — estruturas típicas de **decisão e laço**.
- **`literais_identificadores`:** **literal** é o valor escrito direto no código (número, caractere entre aspas simples). **Identificador** é o nome que o programador inventa (`x`, `intx`). Este teste mistura **números** (real, hex), **`'z'`** e o nome **`intx`** (para mostrar que não é a palavra `int` seguida de `x`).
- **`operadores_e_arrays`:** símbolos como **`==`**, **`!=`**, **`>=`**, **`<=`**, **`%`**, vetor **`buf[8]`** e índice **`buf[0]`**.

| Pasta | O que este teste cobre |
|-------|------------------------|
| **`programa_inicial/`** | Programa com `program`, `class`, campos, `new`, `print`, inteiro, real e hexadecimal (próximo do estilo do enunciado). |
| **`controle_fluxo/`** | **Condicional** (`if` / `else`), **laço** (`while`), `read`, `print` e operadores (`<`, `+`, etc.). |
| **`literais_identificadores/`** | Números reais e hex, literal de caractere, nome **`intx`** (identificador, não a palavra `int`), comentário `/* … */` longo. |
| **`operadores_e_arrays/`** | Operadores de comparação **`>=`**, **`<=`**, **`==`**, **`!=`**, aritmética **`%`**, acesso a vetor **`[`** **`]`** e atribuição com hexadecimal (`0xFF`). |

A saída do scanner para cada caso fica em **`output/<mesmo_nome_da_pasta>/saida.txt`**, gerada ao rodar **`build.bat`** na raiz (ou **`scripts\build.bat`**).
