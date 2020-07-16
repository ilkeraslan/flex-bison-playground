%{
#include <stdio.h>
#include <stdlib.h>
#include "ast_builder.h"
%}

%union {
    struct abstract_syntax_tree *tree;
    double value;
}

/* Token declaration */
%token <d> NUMBER
%token EOL

%type <tree> exp factor term