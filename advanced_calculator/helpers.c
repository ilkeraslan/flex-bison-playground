/*
 * Helper functions for advanced calculator
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>

/* Symbol table */

/* Procedure to hash a symbol */
static unsigned hash_symbol(char *symbol) {
    unsigned int hash = 0;
    unsigned c;

    while (c = *symbol++) {
        hash = hash*9 ^ c;
    }

    return hash;
}

/* Procedure to lookup */
struct symbol *lookup(char *symbol) {
    struct symbol *sp = &symtab[hash_symbol(symbol) % NHASH];
    int symbol_count = NHASH; /* looked symbol count */

    while(--symbol_count >= 0) {
        if(sp->name && !strcmp(sp->name, symbol)) {
            return sp;
        }

        /* New entry */
        if(!sp->name) {
            sp->name = strdup(symbol);
            sp->value = 0;
            sp->function = NULL;
            sp->symbols = NULL;
            return sp;
        }

        /* Try the next entry */
        if(++sp >= symtab + NHASH) {
            sp = symtab;
        }
    }

    yyerror("Symbol table overflow\n");
    abort();
}

/* Procedure to build a new Abstract Syntax Tree */
struct abstract_syntax_tree *new_ast(
    int nodetype, 
    struct abstract_syntax_tree *left,
    struct abstract_syntax_tree *right) {
    // TODO
}

/* Procedure to build a new number */
struct abstract_syntax_tree *new_number(double value) {
    // TODO
}

/* Procedure to build a new compare */
struct abstract_syntax_tree *new_compare(
    int compare_type,
    struct abstract_syntax_tree *left,
    struct abstract_syntax_tree *right
) {
    // TODO
}

/* Procedure to build a new function */
struct abstract_syntax_tree *new_function(
    int function_type,
    struct abstract_syntax_tree *left
) {
    // TODO
}

/* Procedure to build a new call */
struct abstract_syntax_tree *new_call(
    struct symbol *s,
    struct abstract_syntax_tree *left
) {
    // TODO
}

/* Procedure to build a new reference */
struct abstract_syntax_tree *new_reference(
    struct symbol *s) {
    // TODO
}

/* Procedure to build a new assignment */
struct abstract_syntax_tree *new_assignment(
    struct symbol *s,
    struct abstract_syntax_tree *value) {
    // TODO
}

/* Procedure to build a new flow */
struct abstract_syntax_tree *new_flow(
    int nodetype,
    struct abstract_syntax_tree *condition,
    struct abstract_syntax_tree *then_list,
    struct abstract_syntax_tree *else_list) {
    // TODO
}

/* Procedure to free a tree of Abstract Syntax Tree */
void free_tree(struct abstract_syntax_tree *tree) {
    // TODO
}

/* Procedure to create a nwe symbol list */
struct symbol_list *new_symbol_list(
    struct symbol *symbol,
    struct symbol_list *next
) {
    // TODO
}

/* Procedure to free a list of symbols */
void free_symbol_list(struct symbol_list *symb_list) {
    // TODO
}