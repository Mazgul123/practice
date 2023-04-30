changestr.o: changestr.asm changestr.h
	nasm -f elf32 changestr.asm -o changestr.o
main.o: main.c
	gcc -m32 -c main.c -o main.o
res: main.o changestr.o
	gcc -m32 main.o changestr.o -o res
run: res
	./res
