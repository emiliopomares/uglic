
uglic:	y.tab.o translator.o lex.yy.o hardcoded.o UGLIAPIBinder.o UGLIinternal.o
	gcc -o uglic y.tab.o translator.o lex.yy.o hardcoded.o UGLIAPIBinder.o UGLIinternal.o -framework Foundation

UGLIAPIBinder.o: UGLIAPIBinder.m
	gcc -c UGLIAPIBinder.m

translator.o: translator.m
	gcc -c translator.m

UGLIinternal.o: UGLIinternal.m
	gcc -c UGLIinternal.m

hardcoded.o: hardcoded.c
	gcc -c hardcoded.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

y.tab.c: ugli.y
	yacc -d ugli.y

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: ugli.l
	lex ugli.l	
