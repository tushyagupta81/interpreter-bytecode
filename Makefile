CC=gcc
CFLAGS=-Wall -Wextra

SRC_DIR=src
BUILD_DIR=build

SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))
TARGET = $(BUILD_DIR)/interpreter-bytecode.out

all: $(TARGET)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -g -c $< -o $@

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

run: $(TARGET)
	@./$(TARGET)

clean:
	rm $(BUILD_DIR)/**
