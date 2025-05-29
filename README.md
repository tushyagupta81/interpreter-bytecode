# Bytecode Interpreter (CLOX)
> Follows the 2<sup>nd</sup> part the the book [Crafting Interpreters](https://craftinginterpreters.com/chunks-of-bytecode.html)

## Prerequisite
- Make - to automate the build scripts
- C complier - set the CC variable in the Makefile to the compiler of your choice

## How to run
```sh
make run
```

## Current Progress
- Chapter 14
    - Simple instructions like Return
    - Constant values
    - [ ] Challenges
        - [ ] Better way to encode the line numbers
            - We are currently wasting memory by using a new array with the line numbes stored in them
            - Hint run length encoding
        - [ ] Overcome limit of 256 OP per chunk
            - Can use more bytes per OP or
            - Make a new OP that uses like the next 3 bytes to store the constants
        - [ ] Write your own memory managment without using the realloc, malloc, and free
- Chapter 15
    - Virtual Machine
        - Runs op_codes according to ... codes
    - Stack for value manupilation(arithmatic +-/\*)
    - [ ] Challenges
        - [ ] Remove either OP_NEGATE or OP_SUBTRACT
        - [ ] Fix stack overflow in VM
        - [ ] OP_NEGATE without poping in place itself and check the performance changes

## Testing
> Coming soon

### Why in C?
This one is written in C to help me understand memory managment in C, and then understanding why the modern C alternatives are good
