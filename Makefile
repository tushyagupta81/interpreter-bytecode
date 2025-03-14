CC=gcc

%.o: *.c
	@echo "== Compiling object files =="
	$(CC) $^ -c
	@echo -e "== Compiling done ==\n"

interpreter-bytecode.out: *.o
	@echo "== Linking comiled files =="
	$(CC) -o $@ $^
	@echo -e "== Linking done =="

run:
	@./interpreter-bytecode.out

clean:
	rm *.o *.out
