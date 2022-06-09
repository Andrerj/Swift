import UIKit

// Excerpt From: By Ray Fix. “Swift Apprentice.” Apple Books.


// BASIC CONCEPTS


// Var declaration

var greeting = "Hello, playground"

// Print variable in debug area

print(greeting)


// Arithmetic

// Integer Numbers

2 + 6

10 - 2

2 * 4

24 / 3


// Decimal Numbers

2.5 + 5.5

11.4 - 3.4

2.0 * 4.0

24.0 / 3.0


// Remainder Operator

28 % 10

// For use the same operation with decimal numbers you use this:

(28.0).truncatingRemainder(dividingBy: 10)


// Shift Operator

// These commands take the binary form of a number shift to the left or right and return it in decimal form. Ex:

14 << 2

// 14(00001110) shift to 56(00111000)

32 >> 3

// 32(00100000) shift to 4(00000100)


// Math Functions

// sin

sin(45 * Double.pi / 180)

//cos

cos(135 * Double.pi / 180)

// square root

(2.0).squareRoot()

// max and min

max(5, 10)
min(5, 10)


// Naming Data

// constants

let number: Int = 10
let pi: Double = 3.14159

// variables

var variableNumber: Int = 5
variableNumber = 12

variableNumber = 1_000_000

// In Swift you can add underscore to a number in order to turn it in a more human-readable

var 🐶: String = "Dog"

// In Swift you can use the full range of Unicode as emoji in var declaration as well as in the var value


// Increment and Decrement

var i: Int = 1

i += 1

i -= 1

i += i

i += i


// Mini - Exercises

// 1 - “Declare a constant of type Int called myAge and set it to your age.”

let myAge: Int = 31

// 2 - “Declare a variable of type Double called averageAge. Initially, set it to your own age. Then, set it to the average of your age and my own age of 30.”

var averageAge: Double = (31.2 + 30.5) / 2

// 3 - “Create a constant called testNumber and initialize it with whatever integer you’d like. Next, create another constant called evenOdd and set it equal to testNumber modulo 2. Now change testNumber to various numbers. What do you notice about evenOdd?”

let testNumber: Int = 46
let evenOdd: Int = testNumber % 2

// Create a variable called answer and initialize it with the value 0. Increment it by 1. Add 10 to it. Multiply it by 10. Then, shift it to the right by 3. After all of these operations, what’s the answer?

var answer: Int = 0

answer += 1
answer += 10
answer *= 10

answer >> 3

// 110(01101110)
// 110(00001101)
