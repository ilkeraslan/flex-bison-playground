/* Implements wc command for a file in Linux */
/* Compile using flex wc_file.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename> */

%{
    int characters = 0;
    int words = 0;
    int sentences = 0;
    FILE *log_file;
%}

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

    yyin = fopen(argv[1], "r");

    if(yyin == NULL) {
        fprintf(log_file, "File does not exist.\n");
        fprintf(log_file, "----------------------\n");
        return -2;
    }

    yylex();
    printf("Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
    fprintf(log_file, "Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
    fprintf(log_file, "----------------------\n");
    fclose(yyin);
    return 0;
}