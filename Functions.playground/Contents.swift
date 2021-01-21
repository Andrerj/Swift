import UIKit

/* Content:
 
    1 - Functions
    2 - Functions Parameters
    3 - Return Values
    4 - Advanced parameter handling
    5 - Overloading
    6 - Function as variables

 Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 
 */


// Functions

// Example

func printMyName() {
    print("André Rodrigues de Jesus")
}

printMyName()

// Functions Parameters

// Example

func printMultipleOfFive(value: Int) {
    print("\(value) * 5 = \(value * 5)")
}

printMultipleOfFive(value: 5)

// Example with multiple parameters

func printMultipleOf(multiplier: Int, and value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}

printMultipleOf(multiplier: 6, and: 8)

// Example with no external name

func printMultiple(_ multiplier: Int, _ value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}

printMultiple(5, 8)

// Example with default value

func printMultipleOf(_ multiplier: Int, _ value: Int = 2) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}

printMultipleOf(6)


// Return Values

func multiply(_ number: Int, by multiplier: Int) -> Int {
    return number * multiplier
}

let result = multiply(12, by: 7)

// Example returning tuples

func multiplyAndDivide(_ number: Int, by factor: Int) -> (product: Int, quocient: Int) {
    return (number * factor, number / factor)
}

let results = multiplyAndDivide(45, by: 9)
results.product
results.quocient

// Note: When you have only one statement inside the function, you can remove the keyword return


// Advanced handling parameter

/* If you try execute the code below
 
 func incrementAndPrint(_ value: Int) {
    value += 1
    print(value)
 }
 
 The result would be: Left side of mutating operator isn't mutable: 'value' is a 'let' constant

 Swift copies the value before passing it to the function, a behavior known as pass-by-value
 */

// Usually you don't want the function to be able to change the value of a parameter, but sometimes you do want to let it, a behavior known as copy-in copy-out or call by value-result.

// You change the value with the keyword inout before the type of parameter

func incrementAndPrint(_ value: inout Int) {
    value += 1
    print(value)
}

var val = 5
incrementAndPrint(&val)

// The function increments val and retain the modified data after the function finishes.


// Overloading

// Overloading is the capability of using a single name to similar functions. Like you did with multipleOf() functions.

// The compiler must still be able to tell differences between these functions, usually achieved by different numbers of parameters, different parameter types or names.

// You can also overload a function name based on a different return type.

func getValue() -> Int {
    31
}

func getValue() -> String {
    "André Rodrigues"
}

// If you try to call any of the functions above without specifying the type, Swift compiler would complain.

let valueInt: Int = getValue()
let valueString: String = getValue()


// Mini - exercises

// 1 - Write a function named printFullName that takes two strings called firstName and lastName. The function should print out the full name defined as firstName + " " + lastName. Use it to print out your own full name.

func printFullName(firstName: String, lastName: String) {
    print(firstName + " " + lastName)
}

printFullName(firstName: "André", lastName: "Rodrigues de Jesus")

// 2 - Change the declaration of printFullName to have no external name for either parameter.

func printFullName(_ firstName: String, _ lastName: String) {
    print(firstName + " " + lastName)
}

printFullName("José", "Augusto")

// 3 - Write a function named calculateFullName that returns the full name as a string. Use it to store your own full name in a constant.

func calculateFullName(firstName: String, lastName: String) -> String {
    let fullName = firstName + " " + lastName
    return fullName
}

calculateFullName(firstName: "Diego", lastName: "Armando")

// 4 - Change calculateFullName to return a tuple containing both the full name and the length of the name. You can find a string’s length by using the count property. Use this function to determine the length of your own full name.

func calculateFullName(_ firstName: String, _ lastName: String) -> (String, Int) {
    let fullName = firstName + " " + lastName
    
    return (fullName, fullName.count)
}

calculateFullName("Nice", "Bispo")


// Function as variables

// You can assign a function to a constant or variable like any other type of value.

func add(_ a: Int, _ b: Int) -> Int {
    a + b
}

var function = add

// Here the type of function will be the same of function. Now you can use the variable function like so:

function(4, 2)

func subtract(_ a: Int, b: Int) -> Int {
    a - b
}

function = subtract

function(4, 2)

// Like the example above, passing a function to a variable means you can pass functions to another functions.

func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = function(a, b)
    print(result)
}

printResult(add, 6, 7)

/* Example of a no-return function

func noReturn() -> Never {

}
 
func infiniteLoop() -> Never {
    while true { }
}
 
*/

// The only good reason to know about this type of return is that the compiler make some optimizations when generating the code of a no-return type.


// Commenting functions

// Swift uses the defacto Doxygen commenting standard. Example:

/// Calculates the average of three values
///
/// - Parameters:
///     - a: The first value.
///     - b: The second value.
///     - c: The third value.
/// - Returns: The average of three values.

func calculateAverage(of a: Double, and b: Double, and c: Double) -> Double {
    let total = a + b + c
    let average = total / 3
    return average
}

calculateAverage(of: 6, and: 65, and: 45.3)


// Challenges

/* 1 - In the last chapter you wrote some for loops with countable ranges. Countable ranges are limited in that they must always be increasing by one. The Swift stride(from:to:by:) and stride(from:through:by:) functions let you loop much more flexibly.
    
 For example, if you wanted to loop from 10 to 20 by 4’s you can write: */

for index in stride(from: 10, to: 22, by: 4) {
    print(index, terminator: " ")
}
print()

for index in stride(from: 10, through: 22, by: 4) {
    print(index, terminator: " ")
}

// What is the difference between the two stride function overloads?

// Answer: The difference between the two for loops is the first doesn't include the last number and the second one include the last number from the iteration.
print()

// Write a loop that goes from 10.0 to (and including) 9.0, decrementing by 0.1.

for index in stride(from: 10, through: 9.0, by: -0.1) {
    print(index, terminator: " ")
}

/* 2 - When I’m acquainting myself with a programming language, one of the first things I do is write a function to determine whether or not a number is prime. That’s your second challenge.
    
 First, write the following function:

 func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool

 You’ll use this to determine if one number is divisible by another. It should return true when number is divisible by divisor.
 
 Hint: You can use the modulo (%) operator to help you out here.
 
 Next, write the main function:
 
 func isPrime(_ number: Int) -> Bool
 
 This should return true if number is prime, and false otherwise. A number is prime if it’s only divisible by 1 and itself. You should loop through the numbers from 1 to the number and find the number’s divisors. If it has any divisors other than 1 and itself, then the number isn’t prime. You’ll need to use the isNumberDivisible(_:by:) function you wrote earlier.
 
 Use this function to check the following cases:

 isPrime(6) // false
 isPrime(13) // true
 isPrime(8893) // true
 
 Hint 1: Numbers less than 0 should not be considered prime. Check for this case at the start of the function and return early if the number is less than 0.
 
 Hint 2: Use a for loop to find divisors. If you start at 2 and end before the number itself, then as soon as you find a divisor, you can return false.
 
 Hint 3: If you want to get really clever, you can simply loop from 2 until you reach the square root of number, rather than going all the way up to number itself. I’ll leave it as an exercise for you to figure out why. It may help to think of the number 16, whose square root is 4. The divisors of 16 are 1, 2, 4, 8 and 16.

 */

/// Calculates if a number is divisible by another
///
/// - Parameters:
///     - number: The value to be tested
///     - divisor: The value which will test if number is divisible
///
/// - Returns: - True with the value is divisible or false if not.

func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool {
    if number % divisor == 0 {
        return true
    } else {
        return false
    }
}

isNumberDivisible(30, by: 3)

/// Verify if a number is prime
///
/// - Parameters:
///     - number: The value to be verified
/// - Returns: True if the value is prime or false if not.

func isPrime(_ number: Int) -> Bool {
    
    if number == 0 {
        false
    }
    
    for i in stride(from: 2, to: number , by: 1) {
        let result = isNumberDivisible(number, by: i)
        
        if result && i < number {
            return false
        }
    }
    
    return true
}

isPrime(6)
isPrime(13)
isPrime(8893)


/* 3 - In this challenge, you’re going to see what happens when a function calls itself, a behavior called recursion. This may sound unusual, but it can be quite useful.
 You’re going to write a function that computes a value from the Fibonacci sequence. Any value in the sequence is the sum of the previous two values. The sequence is defined such that the first two values equal 1. That is, fibonacci(1) = 1 and fibonacci(2) = 1.

 Write your function using the following declaration:
 
 func fibonacci(_ number: Int) -> Int
 
 Then, verify you’ve written the function correctly by executing it with the following numbers:
 
 fibonacci(1)  // = 1
 fibonacci(2)  // = 1
 fibonacci(3)  // = 2
 fibonacci(4)  // = 3
 fibonacci(5)  // = 5
 fibonacci(10) // = 55
 
 Hint 1: For values of number less than 0, you should return 0.
 
 Hint 2: To start the sequence, hard-code a return value of 1 when number equals 1 or 2.
 
 Hint 3: For any other value, you’ll need to return the sum of calling fibonacci with number - 1 and number - 2.

*/

/// Verify the the sum of fibonacci sequence in the given position
///
/// - Parameters:
///     - number: The value of position
/// - Returns: The sum of numbers from fibonacci

func fibonacci(_ number: Int) -> Int {
    if number <= 0 { return 0}
    if number == 1 || number == 2 { return 1 }
    
    return fibonacci(number - 1) + fibonacci(number - 2)
}

fibonacci(-4)
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(10)
