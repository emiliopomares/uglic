includedir = /usr/include/GNUstep


uglic:	y.tab.o translator.o lex.yy.o hardcoded.o UGLIAPIBinder.o UGLIinternal.o
	gcc -o uglic y.tab.o translator.o lex.yy.o hardcoded.o UGLIAPIBinder.o UGLIinternal.o `gnustep-config --objc-flags` -L/usr/lib/GNUstep/Libraries -lobjc -lgnustep-base -I$(includedir)

UGLIAPIBinder.o: UGLIAPIBinder.m
	gcc -c UGLIAPIBinder.m -I$(includedir)

translator.o: translator.m
	gcc -c translator.m -I$(includedir)

UGLIinternal.o: UGLIinternal.m
	gcc -c UGLIinternal.m -I$(includedir)

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
