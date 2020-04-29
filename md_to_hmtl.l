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
        EOL = 264 /* end of line */,
        WORD = 265,
        SPACE = 266,
        ITALIC = 267,
        BOLD = 268
    };

    FILE *output_file; /* Reference for the output file */
%}

/* Rules */
%%
^#[ ] {return HEADING_1;}
^##[ ] {return HEADING_2;}
^###[ ] {return HEADING_3;}
^####[ ] {return HEADING_4;}
^#####[ ] {return HEADING_5;}
^######[ ] {return HEADING_6;}
_.+_ {return ITALIC;}
\*.+\* {return BOLD;}
\n {return EOL;}
[0-9A-Za-z_,\-\.:/]+ {return WORD;}
[ ] {return SPACE;}
%%

void print_heading(size_t type) {
    int token;

    // Print the opening tag
    fprintf(output_file, "<h%zu>", type);
    
    // Get the next token, because we know that we are already in h tag
    token = yylex();

    // Until EOL, write in to file
    while(token != EOL) {
        if(token == ITALIC) {
            fprintf(output_file, "<i>%s</i>", yytext);
        } else if(token == BOLD) {
            fprintf(output_file, "<b>%s</b>", yytext);
        } else {
            fprintf(output_file, "%s", yytext);
        }
        
        token = yylex();
    }
    
    // Print the closing tag
    fprintf(output_file, "</h%zu>\n", type);
}

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
                print_heading(1);
                break;
            case HEADING_2 :
                print_heading(2);
                break;
            case HEADING_3 :
                print_heading(3);
                break;
            case HEADING_4 :
                print_heading(4);
                break;
            case HEADING_5 :
                print_heading(5);
                break;
            case HEADING_6 :
                print_heading(6);
                break;
            case EOL :
                fprintf(output_file, "\n");
                break;
            default :
                if(token == ITALIC) {
                    fprintf(output_file, "<i>%s</i>", yytext);
                } else if(token == BOLD) {
                    fprintf(output_file, "<b>%s</b>", yytext);
                } else {
                    fprintf(output_file, "%s", yytext);
                }
        }
    }

    fclose(yyin);
    fclose(output_file);

    return 0;
}