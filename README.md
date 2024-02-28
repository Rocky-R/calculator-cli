# CLI Calculator

---

This is a simple CLI for running calculator modules.
While originally designed as a reverse polish notation calculator, the interface is easily extendable with new modules.
See the [Adding Modules](#adding-modules) section below.

## Installation

--- 
Note: You must have `ruby 3.2.x` installed to run this application

1. Clone this repository to your local machine
2. Navigate to the root dir in your terminal
3. Run `bin/calculator` to start the CLI


## Documentation

---

### Basic Usage
These are the general commands that are available regardless of module:

`module`: Lists the current active module 

`[module_name]`: Changes the active module to specified `module_name`

`stack`: Displays the current number stack

`c`: Clears the current stack

`q`: Quits the application


### RPN Module

---

This module performs calculations using [Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation).
See below for example usage.

**Notes:**
* Providing less than two operands will result in an error
* Any calculations that result in `NaN` IE zero division, will return `nil` and the result will not be pushed to the stack
* Providing an operator by itself will only work if at least two numbers are in the stack

### RPN Module Example Input/Output



    > 7 
    Result: 7
    > 8
    Result: 8
    > +
    Result: 15

---

    > 5 5 6 7 + -
    Result: -8.0

---

    > 8 +
    Error: Insufficient operands

---

    > 3
    Result: 3
    > 9
    Result: 9
    > stack
    Current stack: [3.0, 9.0]
    > *
    Result: 27.0

### Adding Modules

---

To add a new module to the CLI, follow these steps:
1. Create a new module with your desired functionality and add it to the `lib/calculator` directory
   1. Note: The new module must contain a `calculate` method. See the `lib/calculator/rpn.rb` file for an example
2. Add the new module name to the `AVAILABLE_MODULES` array within the `lib/calculator/cli.rb` file.
   1. Note: Be sure to use `snake_case` when using multi-word module names. IE `cool_new_module`
3. When you run the CLI, you should now see your module listed in `Available modules are:` portion of the welcome message


### Additional Notes

---

* This code is my attempt at meeting all requirements of the original exercise while also creating something that is refactorable and extendable with new features
* If I spent more time on this, I would add a few more features
  * A simple REST api interface for using the calculator modules in web apps
  * Add in app documentation via `help` command
  * Streamline/Refactor the module installation process (gather module names programmatically rather than a static list)
  * Refactor app to run in docker or similar to avoid ruby version requirements 
  * Move utility and helper command execution into separate module
