CC=gcc
CFLAGS=-Wall

%.o: src/*.c
	@echo "== Compiling object files =="
	$(CC) $(CFLAGS) -c -I include/ $^
	@mkdir -p build
	@mv *.o build/
	@echo -e "== Compiling done ==\n"

interpreter-bytecode.out: build/*.o
	@echo "== Linking comiled files =="
	$(CC) $(CFLAGS) -o build/$@ $^
	@echo -e "== Linking done =="

run:
	@./build/interpreter-bytecode.out

clean:
	rm build/**
