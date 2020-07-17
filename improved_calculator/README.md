To compile:
- `bison -d improved_calculator.y`
- `flex -o improved_calculator.lex.c improved_calculator.l`
- `gcc -o improved_calculator improved_calculator.tab.c improved_calculator.lex.c c_routines.c`