/* Implements wc command in Linux */

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

main() {
    yylex();
    printf("Sencence: %8d, Words: %8d, Characters: %8d\n", sentences, words, characters);
}