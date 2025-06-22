# Bytecode Interpreter (CLOX)

> Follows the 2<sup>nd</sup> part the the book [Crafting Interpreters](https://craftinginterpreters.com/chunks-of-bytecode.html)

## Prerequisite

- Make - to automate the build scripts
- C complier - set the CC variable in the Makefile to the compiler of your choice

## How to run

```sh
git clone https://github.com/tushyagupta81/interpreter-bytecode.git
cd interpreter-bytecode
./run <lox file>
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
    - [ ] How to overcome the >> like issue in C++ where >> colided with something like \<vector<vector>>
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
  - Also added support for other operators such as >, \<, ==, >=, \<=, etc
  - Using only \<, >, ==, ! as the base operators to make the other ones.
    - Other operators take 2 instructions like ! and < to make >=
  - [ ] Challenges
    - [ ] Remove some binary operators like we did for \<= etc
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
    - [ ] What will you do for \<string> + \<other type> and what do other languages do
- Chapter 20
  - Made a custom/hand rolled HashTable
  - Uses the FNV-1a algorithm for hash function
  - Using open addressing with linear mapping and tombstones for deletion
  - Hashmap uses strings as key and Value as value
  - Hash for the strings in calculated on creation of them as we are already doing a O(n) operation during that time
  - We intern(internalize) all the strings created in the program into the Hashmap
  - We also compare keys by
    1. Length
    1. Hash
    1. char by char comparission if earlier conditions pass
    - This ensures fast == on strings during runtime
  - [ ] Challenges
    - [ ] Add key suprrort for other primitive types such as numbers, bools, etc. What sort of complexity does it add if we also need to check for user defined classes and objects
    - [ ] Look up some hashtable implementations with diffrent algos in them and why those were choosen
    - [ ] Write a benchmark for our hashmap
- Chapter 21
  - Global variables using the previously made hashmap
  - Assignment to variable names and retrival of global variables
  - [ ] Challenges
    - [ ] Global variable name is added to the constants list everytime, optimise this approach to not reach the 256 limit
    - [ ] Global variable lookup is still slow, find a better approch with the same semantics
    - [ ] In REPL mode if a user uses a global variable that will be declared later it produces an error. Fix this approach and report an error only if that piece of code is ran without the declaration of that global variable
    - [ ] If we have an unused function with the global variable also not declared we will get no RUNTIME error. We can report these during the compile time
- Chapter 22
  - Local variables
    - They are stored on the stack itself and not like global variables
    - They each have a identifier attached to them
    - They work in levels and on the rightmost/top of the stack we have the highest level of scope
  - Blocks
    - We just increase the scope level of the variables
  - [ ] Challenges
    - [ ] More efficent approach than linear search for the variable we are looking for. Is the extra compute worth it?
    - [x] How do other langs handle var a = a;? How will you handle it
      - This is basically assigning the old value to the new value of same name. Although not allows in lox in the same scope level but it is useful in languages like python where we do multiple levels of cleaning/work on the same variable and instead of naming them seperatly we can just have them all together
    - [ ] Create constant variables that do not change. Justify your choice
    - [ ] Extend lox to hold more than 256 variables
- Chapter 23
  - Control Flow
    - If else statements
    - While and For loops
  - Achived control flow by manupilating the Instruction pointer to the correct jump locations
  - [ ] Challenges
    - [ ] Implement the switch statement
    - [ ] Implement the continue statement
    - [ ] Create a new type of control flow statement
- Chapter 24
  - Functions and Call stack
    - Created functions and ability to call them
    - Created a Call stack by pushing the name of funciton onto the stack and its parameters after it
    - Each function gets its own Compiler to compiler its chunk code
    - Native functions by using native C functions in LOX
    - [ ] Challenges
      - [ ] We access the ip a lot and it goes through multiple indirections and this can cause cache miss. Create a variable marked to be stored in the register and store the ip inside of it
      - [ ] Check for arity in native functions
      - [ ] Extend native functions to support runtime errors such as passing string into a int parameter
      - [ ] Implement some more native functions. See how practical they are to the language
- Chapter 25
  - Lexical scoping
    - Using the Upvalue implementation from Lua
    - Using Upvalues to points to values from the outscope and works in a recuresive manner
    - Upvalues can either be open or closed.
      - Open Upvalues are values that are still in the stack
      - Closed Upvalues are the values which have been taken off that stack and put/hoisted into the stack
        - We have a closed field on the Local struct to store the hoisted value when it gets closed. In this case the loction points to the closed fields instead of a index on the stack
    - TODO: fix error reporting for missing variables
    - [ ] Challenges
      - [ ] Wrap only functions that need upvalues in closure
      - [ ] How should lox behave in loops. Should there be new variables for each loop or use one variable for each loop. Implement independent variables for loops.
      - [ ] Write a lox program to mimic a object. Have a constructor, methods and make a add method

## Testing

> Coming soon
> Copied test files from craftinginterpreters but still need to write to logic to run them

### Why in C?

This one is written in C to help me understand memory managment in C, and then understanding why the modern C alternatives are good
