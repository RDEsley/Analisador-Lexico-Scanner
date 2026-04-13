# JFLAP — modelagem e testes (autômatos finitos)

O [JFLAP](https://www.jflap.org/) serve aqui para **desenhar e testar** autômatos finitos que descrevem **parte** do comportamento do analisador léxico (reconhecer se uma cadeia pertence a uma linguagem de tokens). O código final do trabalho está no **JFlex** (`scanner/Scanner.flex`); estes `.jff` são o **apoio formal** pedido pela disciplina.

## Arquivos nesta pasta

| Arquivo | O que modela |
|---------|----------------|
| `identificador_java--.jff` | **Identificadores** da gramática Java--: começam com **letra** (`a`–`z`, `A`–`Z`) e depois podem ter letras, dígitos ou **`_`**. |
| `numero_inteiro_positivo.jff` | **Número inteiro** sem sinal: uma ou mais casas decimais (`0`–`9`). |

São autômatos **determinísticos** (um símbolo lido, uma transição clara). Eles **não** substituem o `Scanner.flex` (que junta palavras reservadas, comentários, hex, reais, etc.); mostram o raciocínio em diagrama de estados.

## Como abrir e testar

1. Instale o JFLAP (versão usada na disciplina, em geral **JFLAP 7.x** ou a indicada pela professora).
2. **File → Open** e escolha um `.jff` desta pasta.
3. Para testar várias entradas de uma vez: menu **Input** → **Run Inputs** (ou **Multiple Run** conforme a versão), informe cadeias **uma por linha** e veja **Accept** / **Reject**.

### Sugestões de cadeias

**Identificador (`identificador_java--.jff`)**

- Aceitas: `x`, `main`, `intx`, `Teste`, `v_1`
- Rejeitadas: `1nome` (não pode começar com dígito), `_x` (não pode começar com `_`), vazio

**Inteiro positivo (`numero_inteiro_positivo.jff`)**

- Aceitas: `0`, `42`, `007`
- Rejeitadas: vazio, `12a`, `-3` (o menos não faz parte deste autômato)

## Relação com os exemplos em `exemplos/`

Quando o programa Java-- usa um nome (`main`, `buf`) ou um número (`15`, `0xFF`), o **scanner** emite linhas como `[linha,coluna] tipo: valor` em `output/.../saida.txt`. Os `.jff` acima são modelos **só** para o formato de **identificador** e de **sequência de dígitos**; o JFlex aplica regras adicionais (palavra reservada antes de identificador, `0x` para hex, etc.).

## Referência

- Site oficial: [https://www.jflap.org/](https://www.jflap.org/)
