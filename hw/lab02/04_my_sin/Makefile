SHELL := /bin/bash

TARGET      := my_sin_bin
OBJ_ASM     := solution02_04.o
OBJ_HARNESS := tests/harness.o

CC      := gcc
CFLAGS  := -O2 -Wall -Wextra
LDFLAGS := -no-pie

.PHONY: all run test clean

all: $(TARGET)

$(TARGET): $(OBJ_ASM) $(OBJ_HARNESS)
	$(CC) $(LDFLAGS) -o $@ $(OBJ_ASM) $(OBJ_HARNESS)

solution02_04.o: solution02_04.s
	$(CC) -c -x assembler -o $@ $<

tests/harness.o: tests/harness.c
	$(CC) $(CFLAGS) -c -o $@ $<

run: $(TARGET)
	@echo "Введите x (double), нажмите Enter:"
	./$(TARGET)

test: all
	python3 -m unittest -v tests/test_04.py

clean:
	rm -f $(TARGET) $(OBJ_ASM) $(OBJ_HARNESS)