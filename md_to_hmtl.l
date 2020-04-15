/* Converts Markdown to HTML */
/* Compile using `flex md_to_html.l` */
/* gcc lex.yy.c -lfl in Linux, gcc lex.yy.c -ll in Mac */
/* Execution example -> ./a.out <filename1> */

/* Definitions */
%{
    /* Consents to manage token id */
    enum yytokentype {
        HEADING_1 = 258,
        HEADING_2 = 259,
        HEADING_3 = 260,
        HEADING_4 = 261,
        HEADING_5 = 262,
        HEADING_6 = 263,
        EOL = 264 /* end of line */
    };

    FILE *output_file; /* Reference for the output file */
%}

/* Rules */
%%
"# " {return HEADING_1;}
"## " {return HEADING_2;}
"### " {return HEADING_3;}
"#### " {return HEADING_4;}
"##### " {return HEADING_5;}
"###### " {return HEADING_6;}
\n {return EOL;}
%%

/* Code */
int main(int argc, char *argv[]) {
    int token;
    output_file = fopen("output.html", "w");

    if(argc <= 1) {
        printf("No input file.\n");
        return -1;
    }

    if(argc > 2) {
        printf("Too many input files.\n");
        return -2;
    }

    yyin = fopen(argv[1], "r");
    if(yyin == NULL) {
        printf("File does not exist.\n");
        return -3;
    }

    yyrestart(yyin);

    while(token = yylex()) {
        switch(token) {
            case HEADING_1 :
                fprintf(output_file, "<h1></h1>\n");
                break;
            case HEADING_2 :
                fprintf(output_file, "<h2></h2>\n");
                break;
            case HEADING_3 :
                fprintf(output_file, "<h3></h3>\n");
                break;
            case HEADING_4 :
                fprintf(output_file, "<h4></h4>\n");
                break;
            case HEADING_5 :
                fprintf(output_file, "<h5></h5>\n");
                break;
            case HEADING_6 :
                fprintf(output_file, "<h6></h6>\n");
                break;
            default :
                printf("%c\n", *yytext);
        }
    }

    fclose(yyin);
    fclose(output_file);

    return 0;
}