/* Implements wc command for multiple files in Linux */
/* Compile using flex wc_files.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename1> <filename2> ... <filenameN> */

%{
    int characters = 0;
    int words = 0;
    int sentences = 0;
%}

%%
[a-zA-Z]+ { words++; characters += strlen(yytext); }
\n  { characters++; sentences++; }
.   { characters++; }
%%

int main(int argc, char *argv[]) {
    for(int i=1; i<argc; i++) {
        yyin = fopen(argv[i], "r");
        yyrestart(yyin);
        yylex();
        printf("Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
        fclose(yyin);
    }

    return 0;
}