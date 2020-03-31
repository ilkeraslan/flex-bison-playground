/* Implements wc command for multiple files in Linux */
/* Prints results to log.txt */
/* Compile using flex wc_files.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename1> <filename2> ... <filenameN> */

%{
    int characters = 0;
    int words = 0;
    int sentences = 0;
    FILE *log_file;
%}

%option noyywrap
%%
[a-zA-Z]+ { words++; characters += strlen(yytext); }
\n  { characters++; sentences++; }
.   { characters++; }
%%

int main(int argc, char *argv[]) {
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
        yylex();
        printf("Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
        fprintf(log_file, "Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);

        /* Reset variables */
        characters = 0;
        words = 0;
        sentences = 0;

        fclose(yyin);
    }

    fprintf(log_file, "----------------------\n");
    fclose(log_file);
    return 0;
}