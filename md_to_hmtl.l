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
        SPACE = 266
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
\n {return EOL;}
[0-9A-Za-z_,\-\.:/]+ {return WORD;}
[ ] {return SPACE;}
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
                // Print the opening tag
                fprintf(output_file, "<h1>");
                
                // Get the next token, because we know that we are already in h1 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h1>");
                break;
            case HEADING_2 :
                // Print the opening tag
                fprintf(output_file, "<h2>");
                
                // Get the next token, because we know that we are already in h2 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h2>");
                break;
            case HEADING_3 :
                // Print the opening tag
                fprintf(output_file, "<h3>");
                
                // Get the next token, because we know that we are already in h3 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h3>");
                break;
            case HEADING_4 :
                // Print the opening tag
                fprintf(output_file, "<h4>");
                
                // Get the next token, because we know that we are already in h4 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h4>");
                break;
            case HEADING_5 :
                // Print the opening tag
                fprintf(output_file, "<h5>");
                
                // Get the next token, because we know that we are already in h5 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h5>");
                break;
            case HEADING_6 :
                // Print the opening tag
                fprintf(output_file, "<h6>");
                
                // Get the next token, because we know that we are already in h6 tag
                token = yylex();

                // Until EOL, write in to file
                while(token != EOL) {
                    fprintf(output_file, "%s", yytext);
                    token = yylex();
                }
                
                // Print the closing tag
                fprintf(output_file, "</h6>");
                break;
            case EOL :
                fprintf(output_file, "\n");
                break;
            default :
                fprintf(output_file, "%s", yytext);
        }
    }

    fclose(yyin);
    fclose(output_file);

    return 0;
}