%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OPENING_PARANTHESIS CLOSING_PARANTHESIS

%% /* Rules in simplified BNF */

calclist: /* nothing */
  | calclist exp EOL { printf("= %d\n", $1); }
  ;

exp: factor
  | exp ADD factor { $$ = $1 + $3; }
  | exp SUB factor { $$ = $1 - $3; }
  ;

factor: term
  | factor MUL term { $$ = $1 * $3; }
  | factor DIV term { $$ = $1 / $3; }
  ;

term: NUMBER
  | ABS term { $$ = $2 >= 0 ? $2 : - $2; }
  | OPENING_PARANTHESIS exp CLOSING_PARANTHESIS { $$ = $2; }
  ;

%%

int main(int argc, char **argv) {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
    return -1;
}