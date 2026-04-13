<div align="center">

# 🔍 Analisador Léxico (Scanner) — Java--

**Analisador léxico completo para a linguagem Java--, gerado com JFlex**

[![Java](https://img.shields.io/badge/Java-8%2B-ED8B00?style=flat&logo=openjdk&logoColor=white)](https://www.java.com/)
[![JFlex](https://img.shields.io/badge/JFlex-1.9.1-blue?style=flat)](https://jflex.de/)
[![Licença](https://img.shields.io/badge/Licença-Acadêmica-lightgrey?style=flat)](#-licença)

*Trabalho 1 da disciplina de Compiladores — leitura de arquivo `.txt`, tokenização e saída formatada conforme o enunciado.*

</div>

---

## 📋 Sumário

- [Sobre o Projeto](#-sobre-o-projeto)
- [Integrantes](#-integrantes)
- [Demonstração Rápida](#-demonstração-rápida)
- [Pré-requisitos](#-pré-requisitos)
- [Como Executar](#-como-executar)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Tokens Reconhecidos](#-tokens-reconhecidos)
- [Casos de Teste](#-casos-de-teste)
- [Conformidade com o Enunciado](#-conformidade-com-o-enunciado)
- [Regenerar o Analisador (JFlex)](#-regenerar-o-analisador-jflex)
- [Entrega na Disciplina](#-entrega-na-disciplina)
- [Referências](#-referências)
- [Licença](#-licença)

---

## 💡 Sobre o Projeto

Este projeto implementa um **analisador léxico (scanner)** para a linguagem **Java--**, uma versão simplificada de Java usada na disciplina de Compiladores. O scanner:

- Lê um arquivo-fonte `.txt` contendo código Java--
- Identifica e classifica cada **token** (palavras reservadas, identificadores, literais, símbolos e operadores)
- Exibe a saída no formato `[linha,coluna] tipo: valor`
- Ignora comentários de bloco (`/* ... */`) e espaços em branco
- Reporta erros léxicos para caracteres inválidos

O analisador é gerado automaticamente a partir da especificação `Scanner.flex` utilizando o [JFlex](https://jflex.de/), e os autômatos de apoio foram modelados no [JFLAP](https://www.jflap.org/).

---

## 👥 Integrantes

| Nome |
|------|
| Richard Esley |
| Fernanda Mey |
| Matheus Brandão |
| Vitor de Assis |
| Ryan Ribeiro |
| Rafael Furtado |

---

## 🚀 Demonstração Rápida

**Entrada** (`exemplos/programa_inicial/entrada.txt`):

```java
program P

class Teste {
  int v1;
  float v2;
}

/* este é um comentário
   de várias linhas */

{
  void main()
  {
    Teste t = new Teste;
    t.v1 = 123;
    t.v2 = 4.56;
    print(t.v1, 5);
    print(t.v2, 0x10);
  }
}
```

**Saída** (primeiros tokens):

```text
[1,1] palavra reservada: program
[1,9] identificador: P
[3,1] palavra reservada: class
[3,7] identificador: Teste
[3,13] símbolo: {
[4,3] palavra reservada: int
[4,7] identificador: v1
[4,9] símbolo: ;
...
[16,12] número real: 4.56
...
[18,17] número hexadecimal: 0x10
...
```

> 💬 O comentário de bloco (`/* ... */`) é ignorado e não aparece na saída.

---

## ⚙️ Pré-requisitos

| Ferramenta | Finalidade | Observação |
|------------|-----------|------------|
| **Java 8+** | Executar o analisador | `java` deve estar no `PATH` |
| **JDK** (`javac`) | Compilar `Scanner.java` | Preferencial; `JAVA_HOME` ou `PATH` |
| **Rede** | Download automático de dependências | Apenas na **primeira execução** |

> 📝 Se só existir **JRE** (sem `javac`), o script de build usa automaticamente o **ECJ** (Eclipse Compiler for Java) 3.19, compatível com Java 8.

---

## 🔧 Como Executar

### Build completo (recomendado)

Na raiz do projeto (Windows):

```bat
build.bat
```

O script realiza automaticamente:

1. 📦 Baixa os JARs necessários em `tools/` (JFlex, CUP runtime, ECJ) — se faltarem
2. ⚙️ Executa o **JFlex** e gera `scanner/Scanner.java`
3. 🔨 Compila com **`javac`** (ou **ECJ**, caso `javac` não esteja disponível)
4. ▶️ Executa o scanner para **cada** caso de teste em `exemplos/*/` e grava as saídas em `output/*/saida.txt`

### Apenas reexecutar os testes

Se `scanner/Scanner.class` já existir, pule a geração e compilação:

```bat
run-tests.bat
```

### Execução manual (um caso específico)

```bat
chcp 65001
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -cp scanner Scanner exemplos\programa_inicial\entrada.txt
```

### Via PowerShell

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-tests.ps1
```

---

## 📁 Estrutura do Repositório

```
.
├── 📄 README.md                  # Este arquivo
├── 📂 scanner/
│   ├── Scanner.flex              # Especificação léxica (fonte principal)
│   └── Scanner.java              # Gerado pelo JFlex (exigido na entrega)
├── 📂 jflap/                     # Autômatos .jff para testes no JFLAP
│   ├── README.md
│   ├── identificador_java--.jff
│   └── numero_inteiro_positivo.jff
├── 📂 exemplos/                  # Entradas de teste
│   ├── programa_inicial/
│   ├── controle_fluxo/
│   ├── literais_identificadores/
│   └── operadores_e_arrays/
├── 📂 output/                    # Saídas geradas (espelham exemplos/)
│   ├── programa_inicial/
│   ├── controle_fluxo/
│   ├── literais_identificadores/
│   └── operadores_e_arrays/
├── 📂 scripts/
│   ├── build.ps1                 # Build completo (JFlex + compilação + testes)
│   ├── build.bat
│   ├── run-tests.ps1             # Só reexecuta os testes
│   └── run-tests.bat
├── 📂 Trabalho_01_documentacao_pdf/
│   └── Trabalho-1-Scanner.pdf    # Enunciado do trabalho
├── build.bat                     # Atalho → scripts/build.bat
├── run-tests.bat                 # Atalho → scripts/run-tests.bat
└── 📂 tools/                     # JARs baixados automaticamente (não versionados)
```

| Pasta | Descrição |
|-------|-----------|
| `scanner/` | Analisador léxico: `.flex` (fonte), `.java` (gerado) e `.class` (compilado) |
| `exemplos/` | Um programa Java-- de teste por subpasta (`entrada.txt`) |
| `output/` | Saída de tokens correspondente a cada caso de teste (`saida.txt`) |
| `jflap/` | Diagramas de autômatos finitos para modelagem formal — ver [`jflap/README.md`](jflap/README.md) |
| `tools/` | Dependências externas (JFlex, CUP, ECJ) baixadas pelo build |

---

## 🏷️ Tokens Reconhecidos

O scanner reconhece as seguintes categorias léxicas:

| Categoria | Exemplos | Regra |
|-----------|----------|-------|
| **Palavras reservadas** | `program`, `class`, `if`, `else`, `while`, `int`, `float`, `void`, `new`, `return`, `read`, `print`, `final`, `char` | Casamento exato antes de identificadores |
| **Identificadores** | `main`, `Teste`, `intx`, `v_1` | Letra seguida de letras, dígitos ou `_` |
| **Número inteiro** | `123`, `0`, `42` | Um ou mais dígitos decimais |
| **Número real** | `3.14`, `4.56`, `0.0` | Dígitos `.` dígitos (ambos os lados obrigatórios) |
| **Número hexadecimal** | `0x10`, `0xFF`, `0x1a3f` | Prefixo `0x` (minúsculo) + dígitos hex |
| **Caractere** | `'z'`, `'A'` | Aspas simples envolvendo um caractere |
| **Símbolos** | `+`, `-`, `*`, `/`, `%`, `=`, `;`, `,`, `.`, `(`, `)`, `{`, `}`, `[`, `]` | Caracteres individuais |
| **Operadores compostos** | `==`, `!=`, `>=`, `<=`, `>`, `<` | Reconhecidos como lexema único |
| **Comentários** | `/* ... */` | Ignorados na saída (sem aninhamento) |

### Formato de saída

Cada token ocupa uma linha:

```text
[linha,coluna] tipo: valor
```

Exemplo: `[1,1] palavra reservada: program`

---

## 🧪 Casos de Teste

| Caso | Descrição | O que cobre |
|------|-----------|-------------|
| [`programa_inicial`](exemplos/programa_inicial/) | Programa Java-- completo | `program`, `class`, campos, `new`, `print`, inteiro, real, hexadecimal |
| [`controle_fluxo`](exemplos/controle_fluxo/) | Estruturas de controle | `if`/`else`, `while`, `read`/`print`, operadores `<`, `+` |
| [`literais_identificadores`](exemplos/literais_identificadores/) | Literais e nomes | Reais, hex, caractere `'z'`, `intx` como identificador, comentário longo |
| [`operadores_e_arrays`](exemplos/operadores_e_arrays/) | Operadores e vetores | `==`, `!=`, `>=`, `<=`, `%`, `[`, `]`, `0xFF`, `return` |

Cada caso possui um `entrada.txt` em `exemplos/<caso>/` e a saída correspondente em `output/<caso>/saida.txt`.

> 📖 Para detalhes sobre cada caso, veja [`exemplos/README.md`](exemplos/README.md) e [`output/README.md`](output/README.md).

---

## ✅ Conformidade com o Enunciado

| Requisito do PDF | Status | Implementação |
|------------------|--------|---------------|
| Ler arquivo `.txt` com código Java-- | ✔️ | `main` gerada pelo JFlex (`%standalone`) lê o caminho por argumento |
| Palavras reservadas, identificadores, literais, símbolos | ✔️ | Regras em `scanner/Scanner.flex` |
| Números reais (`3.14`, `0.0`); **não** `5.`, `.5` | ✔️ | Macro `real = dígitos + '.' + dígitos` |
| Hexadecimal com `0x` minúsculo; `0X` inválido | ✔️ | `"0x"{hex_digito}+` |
| Comentários `/* … */` estilo Java | ✔️ | Padrão JFlex `"/*"~"*/"` |
| Saída com tipo, valor, linha e coluna | ✔️ | Método `token()` com `yyline + 1`, `yycolumn + 1` |
| Seção 5.4 — testes variados | ✔️ | 4 cenários em `exemplos/*/` com saídas em `output/*/` |
| JFLAP (modelagem com autômato) | ✔️ | Pasta `jflap/` com `.jff` + instruções |

> ⚠️ **Nota (seção 3.3.2):** o texto do PDF é ambíguo sobre comentários. O comportamento implementado segue o padrão **Java**: o bloco fecha no primeiro `*/`, sem aninhamento.

---

## 🔄 Regenerar o Analisador (JFlex)

Para regenerar `Scanner.java` manualmente a partir da especificação `.flex`:

```powershell
java -cp "tools\jflex-1.9.1.jar;tools\java-cup-runtime-11b-20160615.jar" jflex.Main -d scanner scanner\Scanner.flex
```

---

## 📦 Entrega na Disciplina

O PDF pede `Scanner.flex`, `Scanner.java`, um `entrada.txt` de teste e um arquivo de saída. Sugestão de **pacote mínimo**:

| Pedido no enunciado | Arquivo neste repositório |
|---------------------|---------------------------|
| `Scanner.flex` | [`scanner/Scanner.flex`](scanner/Scanner.flex) |
| `Scanner.java` | [`scanner/Scanner.java`](scanner/Scanner.java) |
| `entrada.txt` | [`exemplos/programa_inicial/entrada.txt`](exemplos/programa_inicial/entrada.txt) |
| Arquivo de saída | [`output/programa_inicial/saida.txt`](output/programa_inicial/saida.txt) |

> Os demais casos (`controle_fluxo`, `literais_identificadores`, `operadores_e_arrays`) servem para a **seção de resultados/documentação** exigida pelo PDF.

---

## 📚 Referências

- [JFlex](https://jflex.de/) — gerador de analisadores léxicos para Java
- [JFLAP](https://www.jflap.org/) — ferramenta para modelagem de autômatos finitos
- Enunciado: *Trabalho Prático — Analisador Léxico (Scanner)*, disciplina de Compiladores

---

## 📄 Licença

Projeto acadêmico — desenvolvido exclusivamente para fins educacionais na disciplina de Compiladores.