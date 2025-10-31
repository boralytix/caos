SHELL := /bin/bash

SIMPLEIO := $(abspath ../../../asm/simpleio_x86_64.S)

TARGET    := countdown
SRC_LOCAL := solution02_02.s

CC      := gcc
LDFLAGS := -no-pie

.PHONY: all run test clean echo

all: $(TARGET)

$(TARGET): $(SRC_LOCAL) $(SIMPLEIO)
	$(CC) $(LDFLAGS) -o $@ $(SRC_LOCAL) $(SIMPLEIO)

run: $(TARGET)
	@echo "Введите 32-битное знаковое число:"
	./$(TARGET)

test: $(TARGET)
	python3 -m unittest discover -s tests -p "test_*.py" -v

clean:
	rm -f $(TARGET)

echo:
	@echo "SIMPLEIO = $(SIMPLEIO)"
	@ls -l $(SIMPLEIO)
