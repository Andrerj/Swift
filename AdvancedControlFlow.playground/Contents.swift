import UIKit

/* Content:
 
    1 - Countable Ranges
    2 - Random Value
    3 - For loop
    4 - Continue and labeled Statements
    5 - Switch
    6 - Pattern Matching

 Studies made from: By Ray Fix. “Swift Apprentice.” Apple Books.
 
 */

// Countable Ranges

// It lets you represents a sequence of countable integers.

// countable closed range

let closedRange = 0...5

// countable half-open range

let halfOpenRange = 0..<5

// This kind of ranges must always be increasing. In other words, the second number must be greater or equal to the first.


// Random Value

// In Swift, the capability to generate random numbers is built-in with the language.

while Int.random(in: 1...6) != 6 {
    print("It is not a Six!")
}


// For Loops

// Example with closed range.(Triangle Numbers)

let count = 10
var sum = 0

for i in 1...count {
    sum += i
    print("Start of iteration: i = \(i), sum = \(sum)")
}

// Example with half-open range and omit of the i variable.(Fibonacci)

sum = 1
var lastSum = 0

for _ in 0..<10 {
    let temp = sum
    sum = sum + lastSum
    lastSum = temp
    print("Sequence of Fibonacci: \(sum)")
}

// Example of a loop with conditional

sum = 0

for i in 1...count where i % 2 == 1 {
    print("Only odd values: \(i)")
}


// Continue and Labeled Statements

// Example of continue with a grid(8 x 8) where it is used when the row is even

sum = 0

for row in 0..<8 {
    print()
    if row % 2 == 0 {
        continue
    }
    
    for column in 0..<8 {
        sum = row * column
        print(sum, terminator: " ")
    }
}

// Example of labeled statements with a grid(8 x 8) where the sum of all cells are done, excluding those the column are greater than row

sum = 0

rowLoop: for row in 0..<8 {
    print()
    columnLoop: for column in 0..<8 {
        if row == column {
            continue rowLoop
        }
        sum = row * column
        print(sum, terminator: " ")
    }
}
print("\n\n")

// Mini-exercise

// 1 - Create a constant named range, and set it equal to a range starting at 1 and ending with 10 inclusive. Write a for loop that iterates over this range and prints the square of each number.

let range = 1...10

for i in range {
    let square: Int = i * i
    print(square)
}

// 2 - Write a for loop to iterate over the same range as in the exercise above and print the square root of each number. You’ll need to type convert your loop constant.

print("\n")
for i in range {
    let iDouble: Double = Double(i)
    let squareRoot: Double = iDouble.squareRoot()
    print(squareRoot)
}

// 3 - Above, you saw a for loop that iterated over only the even rows like so:

sum = 0
for row in 0..<8 {
  if row % 2 == 0 {
    continue
  }
  for column in 0..<8 {
    sum += row * column
  }
}
print(sum)

// Change this to use a where clause on the first for loop to skip even rows instead of using continue. Check that the sum is 448 as in the initial example.

sum = 0
for row in 0..<8 where row % 2 == 1 {
    for column in 0..<8 {
        sum += row * column
    }
}
print(sum)


// Switch

// Example

let number = 10

switch number {
case 0:
    print("0")
default:
    print("Non-zero")
}

// String Example

let string = "dog"

switch string {
case "dog", "cat":
    print("Animal is a house pet.")
default:
    print("Animal is not a house pet.")
}

// Advanced switch statements

// Example

let hourOfDay = 12
var timeOfDay = ""

switch hourOfDay {
case 0, 1, 2, 3, 4, 5:
    timeOfDay = "Early Morning"
case 6, 7, 8, 9, 10, 11, 12:
    timeOfDay = "Morning"
case 13, 14, 15, 16:
    timeOfDay = "Afternoon"
case 17, 18, 19:
    timeOfDay = "Evening"
case 20, 21, 22, 23:
    timeOfDay = "Late Evening"
default:
    timeOfDay = "INVALID HOUR!"
}

print(timeOfDay)

// Example with range

var postMatchReview = ""
let goalsScored = 4

switch goalsScored {
case 0:
    postMatchReview = "No goal scored, no win"
case 1...3:
    postMatchReview = "A good win! Well maybe..."
case 4...10:
    postMatchReview = "WHAT?! Surely you were playing agains kids, isn't?"
default:
    postMatchReview = "Maybe, something went wrong!"
}

print(postMatchReview)

// Example with am match case to a condition based on a propertyof the value.

switch number {
case let x where x % 2 == 0:
    print("Even")
default:
    print("Odd")
}

// The method by which you can match values based on condition is known as pattern matching.

// You also could omit the constant you created, like so:

switch number {
case _ where number % 2 == 0:
    print("Even")
default:
    print("Odd")
}

// Partial Matching

//Example

var coordinates = (x: 3, y: 2, z: 5)

switch coordinates {
case (0, 0, 0):
    print("Origin")
case (_, 0, 0):
    print("On the x-axis.")
case (0, _, 0):
    print("On the y-axis.")
case (0, 0, _):
    print("On the z-axis.")
default:
    print("Somewhere in the space.")
}

// Example with binding the value to print it using interpolation

switch coordinates {
case (0, 0, 0):
    print("Origin")
case (let x, 0, 0):
    print("On the x-axis at x = \(x)")
case (0, let y, 0):
    print("On the y-axis at y = \(y)")
case (0, 0, let z):
    print("On the z-axis at z = \(z)")
case let (x, y, z):
    print("Somewhere in the space, where x = \(x), y = \(y), z = \(z)")
}

// Example with a let-where clause syntax to match more complex clause.

switch coordinates {
case let (x, y, _) where y == x:
    print("Along the y == x line")
case let (x, y,_) where y == x * x:
    print("Along the y == x^2 line")
default:
    break
}

// Mini - exercises

// 1 - Write a switch statement that takes an age as an integer and prints out the life stage related to that age. You can make up the life stages, or use my categorization as follows: 0-2 years, Infant; 3-12 years, Child; 13-19 years, Teenager; 20-39, Adult; 40-60, Middle aged; 61+, Elderly.

var age = 56

switch age {
case 0...2:
    print("The people from the data age is in Infant category.")
case 3...12:
    print("The people from the data age is in Child category.")
case 13...19:
    print("The people from the data age is in Teenager category.")
case 20...39:
    print("The people from the data age is in Adult category.")
case 40...60:
    print("The people from the data age is in Middle-aged category.")
case 60...:
    print("The people from the data age is in Elderly category.")
default:
    print("Thre is no negative age, your dumbness")
}

// 2 - Write a switch statement that takes a tuple containing a string and an integer. The string is a name, and the integer is an age. Use the same cases that you used in the previous exercise and let syntax to print out the name followed by the life stage. For example, for myself it would print out "Matt is an adult.".

let name = "André"
age = 29

switch (name, age) {
case (_, age) where age >= 0 && age <= 2:
    print("\(name) is an infant.")
case (_, age) where age >= 3 && age <= 12:
    print("\(name) is an adult.")
case (_, age) where age >= 13 && age <= 19:
    print("\(name) is a teenager.")
case (_, age) where age >= 20 && age <= 39:
    print("\(name) is an adult.")
case (_, age) where age >= 40 && age <= 60:
    print("\(name) is a midle-aged.")
case (_, age) where age >= 60:
    print("\(name) is an elderly.")
default:
    print("Error")
}


// Challenges

/* 1 - In the following for loop, what will be the value of sum, and how many iterations will happen?
 
 var sum = 0
 for i in 0...5 {
   sum += i
 }

 */

// Answer: There will be 6 iterations and the final value of sum will be 15

/* 2 - In the while loop below, how many instances of “a” will there be in aLotOfAs? Hint: aLotOfAs.count tells you how many characters are in the string aLotOfAs.
    
 var aLotOfAs = ""
 while aLotOfAs.count < 10 {
   aLotOfAs += "a"
 }
 
*/

// Answer: 10

var aLotOfAs = ""
while aLotOfAs.count < 10 {
  aLotOfAs += "a"
}

// 3 - Consider the following switch statement:

 switch coordinates {
 case let (x, y, z) where x == y && y == z:
   print("x = y = z")
 case (_, _, 0):
   print("On the x/y plane")
 case (_, 0, _):
   print("On the x/z plane")
 case (0, _, _):
   print("On the y/z plane")
 default:
   print("Nothing special")
 }

 //What will this code print when coordinates is each of the following?
 
  coordinates = (1, 5, 0) // On the x/y plane
  coordinates = (2, 2, 2) // x = y = z
  coordinates = (3, 0, 1) // On the x/z plane
  coordinates = (3, 2, 5) // Nothing special
  coordinates = (0, 2, 4) // On the y/z plane

// A closed range can never be empty. Why?

// Because the closed range must always increasing. If you try to create a closed range from 10..<10, for example, it will be empty.

// 5 - Print a countdown from 10 to 0. (Note: do not use the reversed() method, which will be introduced later.)

var decrease = 10
for i in 0...10 {
    print(decrease, terminator: " ")
    decrease -= 1
    
}
print("\n")
// 6 - Print 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0. (Note: do not use the stride(from:by:to:) function, which will be introduced later.)

for i in 0...10 {
    let value = Double(i) / 10
    print(value)
}
