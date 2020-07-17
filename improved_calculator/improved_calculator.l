%option noyywrap nodefault yylineno

%{
#include "ast_builder.h"
#include "improved_calculator.tab.h"
%}

/* float exponent */
EXP ([Ee][-+]?[0-9]+)

%%
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")" { return yytext[0]; } /* return the character itself as token */

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.value = atof(yytext); return NUMBER; } /* assign the value */

\n { return EOL; }
"//".*
[ \t] { /* do nothing ignore whitespace */ }
. { yyerror("Character not recognized %c\n", *yytext); }
%%