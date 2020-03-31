/* Implements wc command for a file in Linux */
/* Compile using flex <filename>.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename> */

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
    yyin = fopen(argv[1], "r");
    yylex();
    printf("Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
    fclose(yyin);
    return 0;
}