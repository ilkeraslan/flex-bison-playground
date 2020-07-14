/* Implements a scanner which recognizes arithmetic symbols, numbers and EOL */
/* Prints results to log.txt */
/* Compile using flex scanner_files.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename1> <filename2> ... <filenameN> */

/* Definitions */
%{
    /* Consents to manage token id */
    enum yytokentype {
        NUMBER = 258,
        ADD = 259,
        SUB = 260,
        MUL = 261,
        DIV = 262,
        ABS = 263,
        EOL = 264 /* end of line */
    };

    int yylval = 0; /* To save number value */
    FILE *log_file;
%}

/* Rules */
%option noyywrap
%%
"+" {return ADD;}
"-" {return SUB;}
"*" {return MUL;}
"/" {return DIV;}
"|" {return ABS;}
[0-9]+  {yylval = atoi(yytext); return NUMBER;}
\n      {return EOL;}
[ \t]   { /* ignore white space and tab */ }
.   { printf("Mystery character %c\n", *yytext); }
%%

/* Code */
int main(int argc, char *argv[]) {
    int token;
    log_file = fopen("log.txt", "a");

    if(argc <= 1) {
        fprintf(log_file, "No file/s passed.\n");
        fprintf(log_file, "----------------------\n");
        return -1;
    }

    for(int i=1; i<argc; i++) {
        yyin = fopen(argv[i], "r");

        if(yyin == NULL) {
            fprintf(log_file, "File does not exist.\n");
            fprintf(log_file, "----------------------\n");
            return -2;
        }

        yyrestart(yyin);

        while(token = yylex()) {
            printf("%d", token);
            fprintf(log_file, "%d", token);
            if(token == NUMBER) {
                printf(" = %d\n", yylval);
                fprintf(log_file, " = %d\n", yylval);
            } else {
                printf("\n");
                fprintf(log_file, "\n");
            }
        }

        printf("----------------------\n");
        fprintf(log_file, "----------------------\n");

        fclose(yyin);
    }

    fclose(log_file);

    return 0;
}