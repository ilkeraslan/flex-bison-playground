CC=gcc
CFLAGS=-I.

calculator: y.tab.c lex.yy.c
	$(CC) -o calculator y.tab.c
y.tab.c: calculator.y lex.yy.c
	yacc calculator.y
lex.yy.c: calculator.l
	lex calculator.l
clean:
	rm -f lex.yy.c y.tab.c calculator