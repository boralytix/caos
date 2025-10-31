# Makefile для задачи i64-to-i32 (lab02)
# Синтаксис Intel, сборка с использованием simpleio_x86_64.S

SIMPLEIO := ../../asm/simpleio_x86_64.S
TARGET   := i64_to_i32
SRC      := solution02_01.s $(SIMPLEIO)

CC       := gcc
LDFLAGS  := -no-pie

.PHONY: all run clean test

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(LDFLAGS) -o $@ $(SRC)

run: $(TARGET)
	./$(TARGET)

test: all
	python3 -m unittest -v

clean:
	rm -f $(TARGET)
