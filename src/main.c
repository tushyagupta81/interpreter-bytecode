#include "include/chunk.h"
#include "include/common.h"
#include "include/debug.h"

#include "chunk.c"
#include "debug.c"
#include "memory.c"

int main(int argc, char **argv) {
  Chunk chunk;
  initChunk(&chunk);
  writeChunk(&chunk, OP_RETURN);
  disassembleChunk(&chunk, "test chunk");
  freeChunk(&chunk);
  return 0;
}
