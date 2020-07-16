%{
#include <stdio.h>
#include <stdlib.h>
#include "ast_builder.h"
%}

/* Types to be used in parser symbol values */
%union {
    struct abstract_syntax_tree *tree;
    double value;
}

/* Token declaration */
%token <value> NUMBER
%token EOL

/* Assign tree value to exp, factor, and term */
%type <tree> expression factor term

%%
calclist: /* nothing */
  | calclist expression EOL {
      printf("= %4.4g\n", evaluate($2));
      free_tree($2);
      printf("> ");
    }
  | calclist EOL { printf("> "); } /* blank line, comment */
  ;

expression: factor
  | expression '+' factor { $$ = new_ast('+', $1,$3); }
  | expression '-' factor { $$ = new_ast('-', $1,$3); }
  ;

factor: term
  | factor '*' term { $$ = new_ast('*', $1,$3); }
  | factor '/' term { $$ = new_ast('/', $1,$3); }
  ;

term: NUMBER { $$ = new_number_value($1); }
  | '|' term { $$ = new_ast('|', $2, NULL); }
  | '(' expression ')' { $$ = $2; }
  | '-' term { $$ = new_ast('M', $2, NULL); }
  ;
%%