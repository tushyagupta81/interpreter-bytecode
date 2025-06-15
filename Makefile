CC=clang
CFLAGS=-Wall -Wextra -Werror -I$(INCLUDE_DIR) -MMD -MP

SRC_DIR=src
BUILD_DIR=build
INCLUDE_DIR=include

SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))
DEPS := $(OBJECTS:.o=.d)
TARGET = $(BUILD_DIR)/interpreter

all: $(TARGET)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

run: $(TARGET)
	@./$(TARGET)

debug: CFLAGS += -g
debug: clean all

clean:
	rm -rf $(BUILD_DIR)

-include $(DEPS)
