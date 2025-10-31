SHELL := /bin/bash

TARGET     := mul_shift_add
OBJ_LOCAL  := solution02_03.o
OBJ_HARNESS:= tests/harness.o

CC      := gcc
CFLAGS  := -O2 -Wall -Wextra
LDFLAGS := -no-pie

.PHONY: all test clean

all: $(TARGET)

$(TARGET): $(OBJ_LOCAL) $(OBJ_HARNESS)
	$(CC) $(LDFLAGS) -o $@ $(OBJ_LOCAL) $(OBJ_HARNESS)

solution02_03.o: solution02_03.s
	$(CC) -c -x assembler -o $@ $<

tests/harness.o: tests/harness.c
	$(CC) $(CFLAGS) -c -o $@ $<

test: all
	python3 -m unittest -v tests/test_03.py

clean:
	rm -f $(TARGET) $(OBJ_LOCAL) $(OBJ_HARNESS)
