/* Compile using flex concordance_generator.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */

%option noyywrap nodefault yylineno case-insensitive

/* Symbol table */
%{

struct symbol {
    char *name;
    struct reference *reference_list;
};

struct reference {
    struct reference *next;
    char *filename;
    int flags;
    int line_number;
};

/* Fixed size symbol table */
#define NHASH 9997
struct symbol symboltab[NHASH];

/* Function that returns a symbol structure */
struct symbol *lookup(char*);

/* Function that adds a reference with the current filename and line number */
void add_reference(int, char*, char*, int);

/* Current input file name */
char *current_filename;

%}

%%
    /* Skip common English words */
a |
an |
and |
are |
as |
at |
be |
but |
for |
in |
is |
it |
of |
on |
or |
that |
the |
this |
to /* ignore */

    /* Match a string of letters optionally followed by an apostrophe and s or t */
    /* Example: couldn't, he's */
[a-z]+(\'(s|t))? { add_reference(yylineno, current_filename, yytext, 0); }

    /* Match any other character or EOL to ignore */
.|\n
%%

int main(int argc, char *argv[]) {

    int i;

    if(argc < 2) {

        /* Read stdin if there is no filename */
        current_filename = "(stdin)";
        yylineno = 1;
        yylex();
    } else {

        for(i = 1; i < argc; i++) {
            FILE *file = fopen(argv[i], "r");

            /* If no file to read, error */
            if(!file) {
                perror(argv[1]);
                return (1);
            }

            /* Memorize current filename */
            current_filename = argv[i];

            yyrestart(file);
            yylineno = 1;
            yylex();
            fclose(file);
        }

        /* Alphabetize the symbol table and print the references */
        printrefs();
    }

    return 0;
}