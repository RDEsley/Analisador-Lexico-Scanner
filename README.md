# Analisador léxico (Scanner) — Java--

Implementação do **Trabalho 1 — Scanner** da disciplina de Compiladores: analisador léxico para a linguagem **Java--**, gerado com **JFlex**, com leitura de arquivo `.txt` e saída no formato exigido pelo enunciado.

## Integrantes do Projeto: 

Richard Esley, Fernanda Mey, Matheus Brandão, Vitor de Assis, Ryan Ribeiro, Rafael Furtado.

## Requisitos de execução

| Ferramenta | Uso |
|------------|-----|
| **Java 8+** (`java` no `PATH`) | Executar o analisador e, opcionalmente, o compilador |
| **JDK** (`javac` no `PATH` ou `JAVA_HOME`) | Compilação direta de `Scanner.java` (preferencial) |
| **Rede** (apenas na primeira execução do script) | Download automático do JFlex, CUP runtime e ECJ em `tools/` |

Se só existir **JRE**, o script `scripts/build.ps1` usa o **ECJ** (Eclipse Compiler for Java) 3.19, compatível com Java 8.

## Estrutura do repositório

```
.
├── README.md
├── scanner/
│   ├── Scanner.flex          # Especificação léxica (fonte principal)
│   └── Scanner.java          # Gerado pelo JFlex (também exigido na entrega)
├── exemplos/                 # Entradas de teste (ver exemplos/README.md)
│   ├── programa_inicial/
│   │   └── entrada.txt
│   ├── controle_fluxo/
│   │   └── entrada.txt
│   ├── literais_identificadores/
│   │   └── entrada.txt
│   └── operadores_e_arrays/
│       └── entrada.txt
├── output/                   # Saídas espelhando cada caso (ver output/README.md)
│   ├── programa_inicial/
│   │   └── saida.txt
│   ├── controle_fluxo/
│   │   └── saida.txt
│   ├── literais_identificadores/
│   │   └── saida.txt
│   └── operadores_e_arrays/
│       └── saida.txt
├── build.bat                 # Atalho na raiz -> scripts\build.bat
├── run-tests.bat             # Atalho na raiz -> scripts\run-tests.bat
├── scripts/
│   ├── build.ps1             # JFlex + compilação + todos os testes
│   ├── build.bat
│   ├── run-tests.ps1         # Só reexecuta os testes (-SkipGeneration)
│   └── run-tests.bat
└── tools/                    # JARs baixados pelo build (não versionados)
```

Convenções:

- **`scanner/`** — analisador léxico: `Scanner.flex`, `Scanner.java` (gerado pelo JFlex) e `Scanner.class` (após compilar; serve só para executar).
- **`exemplos/<caso>/entrada.txt`** — um programa de teste por pasta (`caso` = nome do cenário).
- **`output/<caso>/saida.txt`** — lista de tokens gerada para aquele `entrada.txt` (mesmo nome de pasta que em `exemplos/`). Ver **`output/README.md`** para explicar os exemplos e o formato da saída.
- **`tools/`** — JARs do JFlex, CUP e ECJ (opcionais no Git; baixados pelo build se faltarem).

## Build e execução rápida

### Recomendado no Windows (evita erro de *Execution Policy*)

Na raiz do projeto, use o **Prompt de Comando** ou o PowerShell chamando o `.bat` (ele já usa `-ExecutionPolicy Bypass`):

```bat
build.bat
```

Ou, a partir da pasta `scripts`:

```bat
scripts\build.bat
```

Só reexecutar os testes (sem JFlex nem `javac`), com `scanner/Scanner.class` já gerado:

```bat
run-tests.bat
```

### Se quiser usar PowerShell com arquivos `.ps1`

Chamar explicitamente com *Bypass* (não altera a política do sistema de forma permanente):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-tests.ps1
```

Se você rodar `.\scripts\build.ps1` direto e aparecer *"a execução de scripts foi desabilitada"*, é a política normal do Windows: use um dos métodos acima em vez de mudar a política global só por causa deste projeto.

O script:

1. Garante os JARs em `tools/` (baixa se faltarem).
2. Executa o **JFlex** e grava `scanner/Scanner.java`.
3. Compila com **`javac`** ou **ECJ**.
4. Para **cada** pasta `exemplos/*/`, lê `entrada.txt` e grava `output/<pasta>/saida.txt` (UTF-8, `chcp 65001` no Windows).

### Execução manual (um caso)

```bat
chcp 65001
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -cp scanner Scanner exemplos\programa_inicial\entrada.txt
```

## Formato de saída (conforme enunciado)

Cada token em uma linha:

```text
[linha,coluna] tipo: valor
```

Exemplo: `[1,1] palavra reservada: program`

## Conformidade com o PDF (checklist)

| Item do enunciado | Implementação |
|-------------------|----------------|
| Ler arquivo `.txt` com código Java-- | `main` gerada pelo JFlex (`%standalone`) lê o caminho passado por argumento |
| Palavras reservadas, identificadores, literais, símbolos | Regras em `scanner/Scanner.flex` |
| **Reais** (float estilo Java): `3.14`, `0.0`; **não** `5.`, `.5`, vírgula decimal | Macro `real = dígitos + '.' + dígitos` |
| **Hexadecimal** com prefixo `0x` minúsculo; pelo menos um dígito; `0X` inválido | `"0x"{hex_digito}+` |
| Comentários `/*` … `*/` estilo Java | Padrão JFlex `"/*"~"*/"` |
| Saída: tipo, valor, linha, coluna | Método `token()` com `yyline + 1`, `yycolumn + 1` |
| Seção 5.4 — testes variados | Vários cenários em `exemplos/*/` (programa com classe; **if/else/while** e `read`/`print`; literais e `intx`; **operadores** `==`/`!=`/`>=`/`<=`/`%` e **arrays** `[` `]`) com saídas em `output/*/` |

**Nota (seção 3.3.2 do PDF):** texto ambíguo sobre comentários; o comportamento é o de **Java** (o bloco fecha no primeiro `*/`, sem aninhamento de blocos).

## Regenerar só o analisador (JFlex)

```powershell
java -cp "tools\jflex-1.9.1.jar;tools\java-cup-runtime-11b-20160615.jar" jflex.Main -d scanner scanner\Scanner.flex
```

## Referências

- [JFlex](https://jflex.de/)
- Enunciado: *Trabalho Prático — Analisador Léxico (Scanner)*, disciplina Compiladores.

## Entrega na disciplina

O PDF pede `Scanner.flex`, `Scanner.java`, um `entrada.txt` de teste e um arquivo de saída. Para **um pacote mínimo**, use por exemplo o par **programa inicial**:

| Pedido no enunciado | Sugestão neste repositório |
|---------------------|----------------------------|
| `Scanner.flex` | `scanner/Scanner.flex` |
| `Scanner.java` | `scanner/Scanner.java` |
| `entrada.txt` | Copiar `exemplos/programa_inicial/entrada.txt` (pode renomear para `entrada.txt` na pasta de entrega) |
| Arquivo de saída | Copiar `output/programa_inicial/saida.txt` (após rodar o build) |

Os outros casos (`controle_fluxo`, `literais_identificadores`, `operadores_e_arrays`) servem para **documentação / secção de resultados** (lista de testes), conforme o PDF.

## Licença / uso

Projeto acadêmico.

## Integrantes do Projeto: 

Richard Esley, Fernanda Mey, Matheus Brandão, Vitor de Assis, Ryan Ribeiro, Rafael Furtado.