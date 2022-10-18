all: clean _fxsave

_fxsave:
	nasm -f elf64 fxsave.s
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -z execstack fxsave.o -o fxsave

clean:
	rm -f fxsave fxsave.o

