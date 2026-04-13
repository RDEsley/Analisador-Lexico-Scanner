import java.io.*;

%%

%standalone
%line
%column
%class Scanner

%{
    private void token(String tipo, String valor) {
        System.out.printf("[%d,%d] %s: %s%n",
            yyline + 1, yycolumn + 1, tipo, valor);
    }
%}

/* Macros */
digito      = [0-9]
hex_digito  = [0-9a-fA-F]
letra       = [a-zA-Z]
ident       = {letra}({letra}|{digito}|"_")*
inteiro     = {digito}+
hexadecimal = "0x"{hex_digito}+
real        = {digito}+"."{digito}+
espaco      = [ \t\r\n]+

%%

/* Comentario multilinha estilo Java; primeiro par asterisco-barra encerra o bloco (sem aninhamento). */
"/*"~"*/"           { /* ignora */ }

/* Palavras reservadas (gramática Java--) */
"program"           { token("palavra reservada", yytext()); }
"class"             { token("palavra reservada", yytext()); }
"final"             { token("palavra reservada", yytext()); }
"void"              { token("palavra reservada", yytext()); }
"new"               { token("palavra reservada", yytext()); }
"if"                { token("palavra reservada", yytext()); }
"else"              { token("palavra reservada", yytext()); }
"while"             { token("palavra reservada", yytext()); }
"return"            { token("palavra reservada", yytext()); }
"read"              { token("palavra reservada", yytext()); }
"print"             { token("palavra reservada", yytext()); }
"int"               { token("palavra reservada", yytext()); }
"float"             { token("palavra reservada", yytext()); }
"char"              { token("palavra reservada", yytext()); }

/* Números: hex e real antes do inteiro */
{hexadecimal}       { token("número hexadecimal", yytext()); }
{real}              { token("número real", yytext()); }
{inteiro}           { token("número inteiro", yytext()); }

{ident}             { token("identificador", yytext()); }

"=="                { token("símbolo", yytext()); }
"!="                { token("símbolo", yytext()); }
">="                { token("símbolo", yytext()); }
"<="                { token("símbolo", yytext()); }
">"                 { token("símbolo", yytext()); }
"<"                 { token("símbolo", yytext()); }

"+"                 { token("símbolo", yytext()); }
"-"                 { token("símbolo", yytext()); }
"*"                 { token("símbolo", yytext()); }
"/"                 { token("símbolo", yytext()); }
"%"                 { token("símbolo", yytext()); }

"="                 { token("símbolo", yytext()); }
";"                 { token("símbolo", yytext()); }
","                 { token("símbolo", yytext()); }
"."                 { token("símbolo", yytext()); }
"("                 { token("símbolo", yytext()); }
")"                 { token("símbolo", yytext()); }
"{"                 { token("símbolo", yytext()); }
"}"                 { token("símbolo", yytext()); }
"["                 { token("símbolo", yytext()); }
"]"                 { token("símbolo", yytext()); }

"'"[^"'"]"'"        { token("caractere", yytext()); }

{espaco}            { /* ignora */ }

[^]                 { System.err.printf("[%d,%d] ERRO LÉXICO: caractere inválido '%s'%n",
                        yyline + 1, yycolumn + 1, yytext()); }
