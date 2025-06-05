# Bytecode Interpreter (CLOX)
> Follows the 2<sup>nd</sup> part the the book [Crafting Interpreters](https://craftinginterpreters.com/chunks-of-bytecode.html)

## Prerequisite
- Make - to automate the build scripts
- C complier - set the CC variable in the Makefile to the compiler of your choice

## How to run
```sh
git clone https://github.com/tushyagupta81/interpreter-bytecode.git
cd interpreter-bytecode
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
- Chapter 16
    - Scanner
        - We don't convert values from string into for eg numbers or even string we just point to them inside the source so as to skip allocating memory to handle all of these
    - [ ] Challenges
        - [ ] String interpolation like "dfsdfds ${some code or expression}"
        - [ ] How to overcome the >> like issue in C++ where >> colided with something like <vector<vector>>
        - [ ] contextual keywords - for eg await is a keyword only in a async function
- Chapter 17
    - Compiler & Parser
        - Pratt Parser
            - It works with operators and operands and groups together operators and operands by binding power(precedence)
            - For repeatiable results we assign a little bit higher binding power on one side of the operator. This also helps to define if the operator is left associative or right associative
            - The parser walks through the tokens and aligns them in a postfix like manner into the chunk.
        - [ ] Challenges
            - [x] Explore the stack trace of how complex arithmatic equations walk throught the Pratt Parser
            - [ ] What are token that can work for both prefix and infix(line TOKEN_MINUS)
            - [ ] How will you handle "mixfix" operators like the ternary operator ?:
- Chapter 18
    - Values hold diffrent kinds of values. We use a tagged union to store the values as raw bits and a type enum to store which type of value that Value is
    - Cappable to handle numbers, bools, nil
    - Also added support for other operators such as >, <, ==, >=, <=, etc
    - Using only <, >, ==, ! as the base operators to make the other ones.
        - Other operators take 2 instructions like ! and < to make >=
    - [ ] Challenges
        - [ ] Remove some binary operators like we did for <= etc
        - [ ] Add more binary operators for ones taking 2 instructions to improve speed and efficiency
- Chapter 19
    - Representing Strings using an Obj
    - An Obj is anything stored on the heap
    - We use the heap here as strings are variable length
    - Also made a pseudo garbage collector(Only frees all the objects at the end of compilation)
        - Obj's are made like a linked list so that we can store all the Objs to free later
    - [ ] Challenges
        - [ ] We need 2 allocations to make the ObjString and one for the chars itself. Try to lower it using "flexible array members"
        - [ ] We copy our strings to the heap so that we are sure we can free them. Instead make a Constant String with points to the source code where we know we can't free the string
        - [ ] What will you do for \<string\> + \<other type\> and what do other languages do


## Testing
> Coming soon

### Why in C?
This one is written in C to help me understand memory managment in C, and then understanding why the modern C alternatives are good
