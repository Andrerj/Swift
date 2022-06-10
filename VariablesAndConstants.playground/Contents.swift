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



// Challenges


// 1 - “Declare a constant Int called myAge and set it equal to your age. Also declare an Int variable called dogs and set it equal to the number of dogs you own. Then imagine you bought a new puppy and increment the dogs variable by one.”

let myNewAge: Int = 31
var dogs: Int = 0
dogs += 1


/* 2 - "Given the follow code:
 
age: Int = 16
print(age)
age = 30
print(age)

 Modify the first line so that it compiles. Did you use var or let?”

 */

var age: Int = 16
print(age)
age = 30
print(age)


/* 3 - "Consider the following code:
 
 let x: Int = 46
 let y: Int = 10
 
 Work out what answer equals when you add the following lines of code:
 
 // 1
 let answer1: Int = (x * 100) + y
 // 2
 let answer2: Int = (x * 100) + (y * 100)
 // 3
 let answer3: Int = (x * 100) + (y / 10)”

 */

let x: Int = 46
let y: Int = 10

let answer1: Int = (x * 100) + y
print(answer1)

let answer2: Int = (x * 100) + (y * 100)
print(answer2)

let answer3: Int = (x * 100) + (y / 10)
print(answer3)


/* 4 - “Add as many parentheses to the following calculation, ensuring that it doesn’t change the result of the calculation.
 
    8 - 4 * 2 + 6 / 3 * 4”
 */

(8 - (4 * 2) + (6 / 3) * 4)


// 5 - “Declare three constants called rating1, rating2 and rating3 of type Double and assign each a value. Calculate the average of the three and store the result in a constant named averageRating.”


let rating1: Double = 45.3
let rating2: Double = 93.63
let rating3: Double = 05.12
var averageRating: Double = 0

averageRating = (rating1 + rating2 + rating3) / 3


// 6 - “The power of an electrical appliance can be calculated by multiplying the voltage by the current. Declare a constant named voltage of type Double and assign it a value. Then declare a constant called current of type Double and assign it a value. Finally calculate the power of the electrical appliance you’ve just created storing it in a constant called power of type Double.”

let voltage: Double = 110
let current: Double = 45
let power: Double = voltage * current

// 7 - “The resistance of such an appliance can be then calculated (in a long-winded way) as the power divided by the current squared. Calculate the resistance and store it in a constant called resistance of type Double.”

let resistance: Double = power / current.squareRoot()

// 8 - “You can create a random integer number by using the function arc4random(). This creates a number anywhere between 0 and 4294967295. You can use the modulo operator to truncate this random number to whatever range you want. Declare a constant randomNumber and assign it a random number generated with arc4random(). Then calculate a constant called diceRoll and use the random number you just found to create a random number between 1 and 6.”

var randomNumber: Int = Int(arc4random())


// 9 - “A quadratic equation is something of the form a⋅x² + b⋅x + c = 0. The values of x which satisfy this can be solved by using the equation x = (-b ± sqrt(b² - 4⋅a⋅c)) / (2⋅a). Declare three constants named a, b and c of type Double. Then calculate the two values for x using the equation above (noting that the ± means plus or minus — so one value of x for each). Store the results in constants called root1 and root2 of type Double.”

let a = 4.0
let b = 5.0
let c = -1.0

let x1: Double = (-b + sqrt(((b * b) - 4 * a * c)) / (2 * a))
let x2: Double = (-b - sqrt(((b * b) - 4 * a * c)) / (2 * a))
