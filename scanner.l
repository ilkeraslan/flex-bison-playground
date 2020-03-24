/* Implements a scanner which recognizes arithmetic symbols, numbers and EOL */
/* Compile using flex <filename>.l */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */

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
%}

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

int main() {
    int token;

    while(token = yylex()) {
        printf("%d", token);
        if(token == NUMBER) printf(" = %d\n", yylval);
        else printf("\n");
    }
    return 0;
}