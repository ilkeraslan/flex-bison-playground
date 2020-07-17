#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "ast_builder.h"

struct abstract_syntax_tree *new_ast(
    int nodetype,
    struct abstract_syntax_tree *left,
    struct abstract_syntax_tree *right
) {
    struct abstract_syntax_tree *ast = malloc(sizeof(struct abstract_syntax_tree));

    if (!ast) {
        yyerror("no space for ast");
        exit(0);
    }

    ast->nodetype = nodetype;
    ast->left = left;
    ast->right = right;

    return ast;
}

struct abstract_syntax_tree *new_number_value(double value) {
    struct number_value *val = malloc(sizeof(struct number_value));

    if(!val) {
        yyerror("no space for number value");
        exit(0);
    }

    val->nodetype = 'K';
    val->number = value;

    return (struct abstract_syntax_tree *)val;
}

double evaluate(struct abstract_syntax_tree *tree) {
    double subtree_value;

    switch(tree->nodetype) {
        case 'K': subtree_value = ((struct number_value *)tree)->number;
            break;
        case '+': subtree_value = evaluate(tree->left) + evaluate(tree->right);
            break;
        case '-': subtree_value = evaluate(tree->left) - evaluate(tree->right);
            break;
        case '*': subtree_value = evaluate(tree->left) * evaluate(tree->right);
            break;
        case '/': subtree_value = evaluate(tree->left) / evaluate(tree->right);
            break;
        case '|': subtree_value = evaluate(tree->left);
            if(subtree_value < 0) {
                subtree_value = -subtree_value;
            }
            break;
        case 'M': subtree_value = -evaluate(tree->left);
            break;
        default: printf("an internal error occured: bad node %c\n", tree->nodetype);
    }

    return subtree_value;
}

void free_tree(struct abstract_syntax_tree *) {
    // TODO
}

void yyerror(char *s, ...) {
    va_list arguments_print;
    va_start(arguments_print, s);

    fprintf(stderr, "%d: error: ", yylineno);
    vprintf(stderr, s, arguments_print);
    fprintf(stderr, "\n");
}

int main() {
    printf("> ");
    return yyparse();
}