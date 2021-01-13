import UIKit

/* Content:
    
    1 - Comparison Operators
    2 - Boolean Logic
    3 - String Equality
    4 - If statement
    5 - Short Circuiting
    6 - Encapsulating Variables
    7 - Loops
    
   Studies made from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */



// Comparison Operators

// Boolean type

let yes: Bool = true
let no = false

// Boolean operators

// To compare values in Swift, uses the equality operator(==) to verify they are equal.

let does1equals2 = (1 == 2)

// Or the != to verify if they are not.

let does1notEquals2 = (1 != 2)

// You can use the ! operator to toggles the sentence of your code

let alsoTrue = !(1 == 2)

// The greater than and less than operator

let is1greaterThan2 = 1 > 2
let is1lessThan2 = 1 < 2


// Boolean Logic

// Uses of AND(&&) and OR(||)

// If the use operator &&, all the arguments from the code must be true

var and = true && true
and = true && false
and = false && false

// If the use of ||, only one argument must be true in order to be true. And the code only be false if all the arguments are false

var or = true || true
or = true || false
or = false || false

// The boolean logic is usually applied to verify multiple conditions.

let andTrue = 1 < 2 && 4 > 3
let andFalse = 1 < 2 && 3 > 4

let orTrue = 1 < 2 || 3 > 4
let orFalse = 1 == 2 || 3 == 4

// You can use boolean logic to verify more than one comparison, like so:

let andOr = (1 < 2 && 3 > 4) || 1 < 4


// String Equality

// Example of string comparison

let dog = "Dog"
let cat = "Cat"

let dogEqualsCat = dog == cat

// You can verify too with the greater and less operator. In this case the compiler will compare the variables by the encoding table standard, usually UTF-8.

let order = cat < dog


// Toggling a bool

// You can use the function toggle() to alter the value from a boolean value

var switchState = true

switchState.toggle()
switchState.toggle()


// Mini - exercises

// 1 - Create a constant called myAge and set it to your age. Then, create a constant named isTeenager that uses Boolean logic to determine if the age denotes someone in the age range of 13 to 19.

let myAge = 29
let isTeenager = (myAge >= 13) && (myAge <= 19)

// 2 - Create another constant named theirAge and set it to my age, which is 30. Then, create a constant named bothTeenagers that uses Boolean logic to determine if both you and I are teenagers.

let theirAge = 14
let bothTeenagers = isTeenager && ((theirAge >= 13) && theirAge <= 19)

// 3 - Create a constant named reader and set it to your name as a string. Create a constant named coder and set it to my name, André Rodrigues. Create a constant named authorIsReader that uses string equality to determine if reader and author are equal.

let reader = "João Feijão"
let coder = "André Rodrigues"
let coderIsReader = reader == coder

// 4 - Create a constant named readerBeforeCoder which uses string comparison to determine if reader comes before author.

let readerBeforeCoder = reader < coder


// The If statement

// If example

if 2 > 1 {
    print("Two is bigger than 1.")
}

// If example wit conditions and else clause

let animal = "Fox"

if animal == "Cat" || animal == "Dog" {
    print("Animal is a house pet.")
} else {
    print("Animal is not a house pet.")
}

// If example with else clause and changing the variable depends on the clause

let hourOfDay = 12
var timeOfDay = ""

if hourOfDay < 6 {
    timeOfDay = "Early Morning"
} else
if hourOfDay < 12 {
    timeOfDay = "Morning"
} else
if hourOfDay < 17 {
    timeOfDay = "Afternoon"
} else
if hourOfDay < 20 {
    timeOfDay = "Evening"
} else
if hourOfDay < 24 {
    timeOfDay = "Late Evening"
} else {
    timeOfDay = "INVALID HOUR"
}

print(timeOfDay)


// Short - Circuiting

// In case some condition if false before the end of the code, the whole condition can never be true, so Swift will not even bother to check the other part form condition. Example:

if 1 > 2 && coder == "Andre" {
    print("Will never be executed.")
}


// Encapsulating Variables

// Here you see the concept of scope, which means a variable can be captured inside brackets and its value is only knows inside it.

// Example: You earn $25 for every hour up to 40 hours, and $50 for every hour thereafter.

var hoursWorked = 45
var price = 0

if hoursWorked > 40 {
    let hoursOver40 = hoursWorked - 40
    price += hoursOver40 * 50
    hoursWorked -= hoursOver40
}

price += hoursWorked * 25

// In the example above, there is a new declaration inside the brackets and that code is only live on inside it. If you try use hoursOver40 outside, the compiler will complain.


// The ternary conditional operator

// With the ternary operator, you could achieve something like this:

let a = 5
let b = 10

var min: Int
if a < b { min = a} else { min = b}

var max: Int
if a > b { max = a} else { max = b}

// In a simple and efficient way:

 min = a < b ? a : b
 max = a > b ? a : b


// Mini - exercises

// 1 - Create a constant named myAge and initialize it with your age. Write an if statement to print out Teenager if your age is between 13 and 19, and Not a teenager if your age is not between 13 and 19.

if (myAge >= 13) && (myAge <= 19) {
    print("Teenager")
} else {
    print("Not a Teenager")
}

// 2 - Create a constant named answer and use a ternary condition to set it equal to the result you print out for the same cases in the above exercise. Then print out answer.

let answer = (myAge >= 13 && myAge <= 19) ? "Teenager" : "Not a Teenager"


// Loops

// while loop example

var sum = 1

while sum < 1000 {
    sum = sum + (sum + 1)
    print(sum)
}

// repeat-while loop example
sum = 0

repeat {
    sum = sum + (sum + 1)
    print(sum)
} while sum < 1000

// Even though the loops above had the same result, it not always the case.

sum = 1

while sum < 1 {
    sum = sum + (sum + 1)
    print(sum)
}

repeat {
    sum = sum + (sum + 1)
    print(1)
} while sum < 1

// In the examples above, the while loop will never be executed because the condition checker happens before the code, while in the repeat loop th condition checker happens after the code be executed.


// Breaking out a loop

// You can stop a loop using the keyword break

sum = 1

while true {
    sum = sum + (sum + 1)
    print(sum)
    if sum > 500 {  break   }
}


// Mini - exercises

// 1 - Create a variable named counter and set it equal to 0. Create a while loop with the condition counter < 10 which prints out counter is X (where X is replaced with counter value) and then increments counter by 1.

var counter = 0

while counter < 10 {
    print("counter is \(counter)")
    counter += 1
}


// 2 - Create a variable named counter and set it equal to 0. Create another variable named roll and set it equal to 0. Create a repeat-while loop. Inside the loop, set roll equal to Int.random(in: 0...5) which means to pick a random number between 0 and 5. Then increment counter by 1. Finally, print After X rolls, roll is Y where X is the value of counter and Y is the value of roll. Set the loop condition such that the loop finishes when the first 0 is rolled.

counter = 0
var roll = 0

repeat {
    roll = Int.random(in: 0...5)
    counter += 1
    if roll == 0 {
        print("After \(counter) rolls, roll is \(roll).")
        break
    }
} while true


// Chalenge

/* 1 - What’s wrong with the following code?
 
 let firstName = "Matt"

 if firstName == "Matt" {
   let lastName = "Galloway"
 } else if firstName == "Ray" {
   let lastName = "Wenderlich"
 }
 let fullName = firstName + " " + lastName
*/

// Answer: The lastName only be available inside the scope.

/* 2 - In each of the following statements, what is the value of the Boolean answer constant?
 
 let answer = true && true      Answer: true
 let answer = false || false    Answer: false
 let answer = (true && 1 != 2) || (4 > 3 && 100 < 1)    Answer: true
 let answer = ((10 / 2) > 3) && ((10 % 2) == 0)”        Answer: true

*/

/* 3 - Imagine you’re playing a game of snakes & ladders that goes from position 1 to position 20. On it, there are ladders at position 3 and 7 which take you to 15 and 12 respectively. Then there are snakes at positions 11 and 17 which take you to 2 and 9 respectively.
 
 Create a constant called currentPosition which you can set to whatever position between 1 and 20 which you like. Then create a constant called diceRoll which you can set to whatever roll of the dice you want. Finally, calculate the final position taking into account the ladders and snakes, calling it nextPosition.
*/

let currentPosition = 7
let diceRoll = 4
var nextPosition = currentPosition + diceRoll

if nextPosition == 3 {  nextPosition = 15   } else
if nextPosition == 7 {  nextPosition = 12   } else
if nextPosition == 11 { nextPosition = 2    } else
if nextPosition == 17 { nextPosition = 9    }

print("The final position is: \(nextPosition)")

/* 4 - Given a month (represented with a String in all lowercase) and the current year (represented with an Int), calculate the number of days in the month. Remember that because of leap years, "february" has 29 days when the year is a multiple of 4 but not a multiple of 100. February also has 29 days when the year is a multiple of 400.
 
*/

let month: String = "april"
let year: Int = 2000

if month == "january" || month == "march" || month == "may" || month == "july" || month == "august" || month == "october" || month == "december" {
    print("\(month) has 31 days.")
} else
if month == "april" || month == "june" || month == "september" || month == "november" {
    print("\(month) has 30 days.")
} else
if (year % 4 == 0) && (year % 100 != 0) {   print("\(month) has 29 days.")  }
else {  print("\(month) has 28 days.")}

// 5 - Given a number, determine the next power of two above or equal to that number.

var number = 865
var trial = 1
var times = 0

while trial < number {
    trial = trial * 2
    times += 1
}

print("Next power of 2 >= \(number) is \(trial) which is 2 to the power of \(times)")

// 6 - Given a number, print the triangular number of that depth.

number = 10
var count = 1
var tNumber = 0

while count <= number {
    tNumber = tNumber + count
    count += 1
}

print("The triangle number of the depth \(number) is \(tNumber)")

/* 7 - Calculate the n’th Fibonacci number. Remember that Fibonacci numbers start its sequence with 1 and 1, and then subsequent numbers in the sequence are equal to the previous two values added */

var c = 1
var n = 10
var f0 = 0
var f1 = 1
var aux = 0
var f = 0

while c < n {
    if n == 0 { f = 0; break } else
    if n == 1 { f = 1; break } else {
        f = f0 + f1
        
        aux = f
        f0 = f1
        f1 = aux
    }
    c += 1
}
 
print("The Fibonacci number for \(n) is \(f)")

// 8 - Use a loop to print out the times table up to 12 of a given factor.

let num = 13
c = 1

while c <= 12 {
    let times = num * c
    print("\(num) X \(c) = \(times)")
    c += 1
}

/* 9 - Print a table showing the number of combinations to create each number from 2 to 12 given 2 six-sided dice rolls. You should not use a formula but rather compute the number of combinations exhaustively by considering each possible dice roll.
 */

var d1 = 1
var d2 = 1
var target = 2
var combination = 0
var ct = 0


while target <= 12 {
    while d1 <= 6 {
        while d2 <= 6 {
            combination = d1 + d2
            //print(target)
            //print("d1 = \(d1) - d2 = \(d2)")
            if combination == target {
                ct += 1
            }
            d2 += 1
        }
        d1 += 1
        d2 = 1
    }
    print("Combinations found for \(target): \(ct)")
    d1 = 1
    ct = 0
    target += 1
}

