SHELL := /bin/bash

TARGET     := sys_echo
SRC_LOCAL  := solution02_05.s
SYSCALL_AS := $(abspath ../../../asm/syscall.S)

CC      := gcc
LDFLAGS := -no-pie

.PHONY: all run test clean echo

all: $(TARGET)

$(TARGET): $(SRC_LOCAL) $(SYSCALL_AS)
	$(CC) $(LDFLAGS) -o $@ $(SRC_LOCAL) $(SYSCALL_AS)

run: $(TARGET)
	@echo "Введите строку и нажмите Enter:"
	./$(TARGET)

test: $(TARGET)
	python3 -m unittest -v tests/test_05.py

clean:
	rm -f $(TARGET)

echo:
	@echo "SYSCALL = $(SYSCALL_AS)"
	@ls -l $(SYSCALL_AS)