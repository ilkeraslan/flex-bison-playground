/*
 * Declarations for the calculator
 */

/* Interface to lexer */
extern int yylineno; /* from lexer */
void yyerror(char *s, ...);

/* Abstract Syntax Tree nodes */
struct abstract_syntax_tree
{
    int nodetype;
    struct abstract_syntax_tree *left;
    struct abstract_syntax_tree *right;
};

struct number_value
{
    int nodetype;
    double number;
};

/* Abstract Syntax Tree builder */
struct abstract_syntax_tree *new_ast(
    int nodetype,
    struct abstract_syntax_tree *left,
    struct abstract_syntax_tree *right);

struct abstract_syntax_tree *new_number_value(double value);

/* Abstract Syntax Tree evaluater */
double evaluate(struct abstract_syntax_tree *);

/* Removes and deletes an Abstract Syntax Tree */
void free_tree(struct abstract_syntax_tree *);