# Pasta `output` — saídas do scanner

Cada subpasta tem o **mesmo nome** da pasta de teste em `exemplos/`. Dentro há um único arquivo: **`saida.txt`**, gerado ao rodar o build (UTF-8 no Windows com `chcp 65001`).

## O que deve ter em cada `saida.txt`

É a **lista de tokens** que o analisador léxico reconheceu no `entrada.txt` correspondente, **um token por linha**, no formato do trabalho:

```text
[linha,coluna] tipo: valor
```

- **linha** e **coluna**: posição (começando em 1) do **início** do lexema no arquivo de entrada.
- **tipo**: categoria léxica (ex.: `palavra reservada`, `identificador`, `número inteiro`, `símbolo`, …).
- **valor**: o texto exato reconhecido (o lexema), quando fizer sentido.

Comentários `/* … */` **não** aparecem na saída (são ignorados pelo scanner). Espaços em branco também.

## Os exemplos (o que cada um testa)

### 1. `programa_inicial/`

- **Entrada:** `exemplos/programa_inicial/entrada.txt`
- **Ideia:** programa parecido com o exemplo do PDF — `program`, `class`, campos `int`/`float`, bloco com `void main`, objeto `new`, atribuições com número inteiro, **número real** (`4.56`), **hexadecimal** (`0x10`) e chamadas `print`.
- **Saída:** `output/programa_inicial/saida.txt` — sequência de tokens desse código (palavras reservadas, identificadores, símbolos `;`, `(`, `)`, literais numéricos, etc.).

### 2. `controle_fluxo/`

- **Entrada:** `exemplos/controle_fluxo/entrada.txt`
- **Ideia:** cobrir **condicional** (`if` / `else`), **repetição** (`while`), **entrada/saída** (`read` / `print`) e operadores (`<`, `+`, `=`), como sugerido na documentação do trabalho (testes com estruturas de controle).
- **Saída:** `output/controle_fluxo/saida.txt` — tokens incluindo `if`, `else`, `while`, `read`, `print`, parênteses, chaves, números e `0x01`.

### 3. `literais_identificadores/`

- **Entrada:** `exemplos/literais_identificadores/entrada.txt`
- **Ideia:** **literais** (real `3.14` e `0.0`, hex `0x1a3f`, `0x0A`, caractere `'z'`), identificador **`intx`** (o analisador trata como um identificador só, não como a palavra `int` seguida de `x`) e **comentário de bloco longo** (texto dentro do comentário não vira token).
- **Saída:** `output/literais_identificadores/saida.txt` — lista de tokens após o comentário, com tipos como `número real`, `número hexadecimal`, `caractere`, etc.

### 4. `operadores_e_arrays/`

- **Entrada:** `exemplos/operadores_e_arrays/entrada.txt`
- **Ideia:** operadores **`>=`**, **`<=`**, **`==`**, **`!=`**, resto **`%`**, declaração com colchetes (`int buf[8];`), indexação `buf[0]` e literal hexadecimal `0xFF`, além de `return`.
- **Saída:** `output/operadores_e_arrays/saida.txt` — tokens com símbolos de duplo caractere reconhecidos como um único lexema.

## Tabela rápida

| Pasta em `output/` | Arquivo de entrada |
|--------------------|-------------------|
| `programa_inicial/` | `exemplos/programa_inicial/entrada.txt` |
| `controle_fluxo/` | `exemplos/controle_fluxo/entrada.txt` |
| `literais_identificadores/` | `exemplos/literais_identificadores/entrada.txt` |
| `operadores_e_arrays/` | `exemplos/operadores_e_arrays/entrada.txt` |

Para gerar de novo todas as saídas: na raiz do projeto, execute `build.bat` ou `scripts\build.bat`.
