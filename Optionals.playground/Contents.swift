import UIKit

/* Content:
    
    1 - Optionals
    2 - Unwrapping Optionals
    3 - Force Unwrapping
    4 - Optional Binding
    5 - Introducing Guard
    6 - Nil Coalescing
 
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 
 */

// Introducing nil

// Nil represents the absence of value. Optionals are a special type of Swift that can handle it.

// In the usual way of programming, the code below could have a value in the occupation or to represent absence of value an empty string

var name = "André Rodrigues de Jesus"
var age = 29
var occupation = "Software Developer" // "" to represent the absence of occupation

// This kind of value to represent the absence of some value is known as Sentinel and usually are representd by "" or 0(Zero).

// To solve this situation, Swift introduced a new type of value, Optionals. If you're handling a non-optional type, then you're guaranteed to have a value, otherwise you have to handle the nil case.

// To understand better optional, imagine that around the value of the variable there is a box and to access the value, you need to unwrap it before use the value.

var errorCode: Int?

// The code above means the variable itself is like a box containing either an Int or nil.

// Note: You can add the question mark after any type to create an optional type.

// You can set it to a value or nil

errorCode = 100
errorCode = nil

// Mini - exercises

// 1 - Make an optional String called myFavoriteSong. If you have a favorite song, set it to a string representing that song. If you have more than one favorite song or no favorite, set the optional to nil.

var myFavoriteSong: String? = nil

// 2 - Create a constant called parsedInt and set it equal to Int("10") which tries to parse the string 10 and convert it to an Int. Check the type of parsedInt using Option-Click. Why is it an optional?

var parsedInt = Int("10")

// Because the conversion can be others thing than an Int or the absence of a value.

// 3 - Change the string being parsed in the above exercise to a non-integer (try dog for example). What does parsedInt equal now?

parsedInt = Int("dog")

// parsedInt is equal nil


// Unwrapping Optionals

// Example of what happens with an optional if you don't unwrapping

var result: Int? = 30
print(result as Any)

// print(result + 1) If you try to run this code, The compiler will complain because the value wasn't unwrapped.


// Forcing Unwrapping example

var authorName: String? = "André Rodrigues de Jesus"
var authorAge: Int? = 29

var unwrappedAuthorName = authorName!
print(unwrappedAuthorName)

// If you try to unwrap a nil value like so, your application could crash. Use Force unwrapping sparingly.

authorName = nil
// unwrappedAuthorName = authorName!

// The error above happens in the runtime rather than the compiler time. If this code code were inside your app, the runtime error would cause your app to crash.

// To avoid it, you can use an if statement to unwrap before use the value

if authorName != nil {
    print("Author name is \(String(describing: authorName))")
} else { print("No Author.") }

// The code is safe, but with this technique, you'll have to remember to check nil every time you need the authorName.


// Optional Binding example

if let unwrapAuthorName = authorName {
    print("Author name is \(unwrapAuthorName)")
} else { print("No author.") }

// Unwrapping multiples values at same time

authorName = "André Rodrigues de Jesus"

if let authorName = authorName,
   let authorAge = authorAge {
    print("The author is \(authorName) who is \(authorAge) years old.")
}

// Unwrapping multiples values with Boolean Checks

if let unwrappedAuthorName = authorName,
   let unwrappedAuthorAge = authorAge,
   unwrappedAuthorAge >= 40 {
    print("THe author name is \(unwrappedAuthorName) who is \(String(describing: authorAge)) years old.")
} else {
    print("No author pr no age or age less than 40.")
}

// Mini - exercises

// 1 - Using your myFavoriteSong variable from earlier, use optional binding to check if it contains a value. If it does, print out the value. If it doesn’t, print "I don’t have a favorite song.

if let mySong = myFavoriteSong {
    print("My favorite song is \(mySong)")
} else { print("I don't have a favorite song") }

// 2 - Change myFavoriteSong to the opposite of what it is now. If it’s nil, set it to a string; if it’s a string, set it to nil. Observe how your printed result changes.

myFavoriteSong = "Dia Branco - Grande Encontro 20 anos"

if let mySong = myFavoriteSong {
    print("My favorite song is \(mySong)")
} else { print("I don't have a favorite song") }


// Introducing Guard Statement

// You use guard to check a condition like the if and switch statement. The guard statement comprises guard followed by a condition that can include Boolean expressions and optional bindings.

func guardMyCastle(name: String?) {
    guard let castleName = name else {
        print("No castle!")
        return
    }
    
    // At this point, 'castleName' is a non-optional value
    
    print("Your castle called \(castleName) was guarded!")
    
}


// Example of guard between function

/// Verify numbers of side from given shape.
///
/// - Parameters:
///     - shape: String type of value of shape.
/// - Returns: How many sides shape has.

func calculateNumberOfSides(shape: String) -> Int? {
    switch shape {
    case "Triangle":
        return 3
    case "Square":
        return 4
    case "Rectangle":
        return 4
    case "Pentagon":
        return 5
    case "Hexagon":
        return 6
    default:
        return nil
    }
}

/// Verify how many sides the given shape has.
///
/// - Parameters:
///     - shape: A String type representation of a shape.

func maybePrintSides(shape: String) {
    guard let sides = calculateNumberOfSides(shape: shape) else {
        print("I don't know the number of sides for \(shape)")
        return
    }
    
    print("A \(shape) has \(sides) sides.")
    
}

// Nil Coalescing

// This alternative works when you want to get a value from optional no matter what. So its create a sentinel value when the optional is nil.

var optionalInt: Int? = 10
var mustHaveInt = optionalInt ?? 0

// The code above is equivalent to:

var otherOptionalInt: Int?
var otherMustHaveInt: Int

if let unwrapped = otherOptionalInt {
    otherMustHaveInt = unwrapped
} else {
    otherMustHaveInt = 5
}


// Challenges

/* You be the compiler

 Which of the following are valid statements?

 var name: String? = "Ray" - True
 var age: Int = nil - False
 let distance: Float = 26.7 - True
 var middleName: String? = nil - True

*/

/* 2 - First, create a function that returns the number of times an integer can be divided by another integer without a remainder. The function should return nil if the division doesn’t produce a whole number. Name the function divideIfWhole.
 
 Then, write code that tries to unwrap the optional result of the function. There should be two cases: upon success, print "Yep, it divides \(answer) times", and upon failure, print "Not divisible :[".
 
 Finally, test your function:
 Divide 10 by 2. This should print "Yep, it divides 5 times."
 Divide 10 by 3. This should print "Not divisible :[."
 
 Hint 1: Use the following as the start of the function signature:
 
 func divideIfWhole(_ value: Int, by divisor: Int)
 
 You’ll need to add the return type, which will be an optional!
 
 Hint 2: You can use the modulo operator (%) to determine if a value is divisible by another; recall that this operation returns the remainder from the division of two numbers. For example, 10 % 2 = 0 means that 10 is divisible by 2 with no remainder, whereas 10 % 3 = 1 means that 10 is divisible by 3 with a remainder of 1.

*/

func divideIfWhole(number: Int, divisor: Int) -> Int? {
    
    guard number % divisor == 0 else {
        print("Not divisible :[")
        return nil
    }
    
    let result = number / divisor
    print("Yep, it divides \(result) times")
    return result
}

divideIfWhole(number: 10, divisor: 2)

/* 3 - The code you wrote in the last challenge used if statements. In this challenge, refactor that code to use nil coalescing instead. This time, make it print "It divides X times" in all cases, but if the division doesn’t result in a whole number, then X should be 0.
 
*/

func divideIfWhole(_ number: Int, _ divisor: Int) {
    let result = number % divisor == 0 ? number / 2 : 0
    print("It divides \(result) times")
}

divideIfWhole(10, 3)

/* 4 - Consider the following nested optional — it corresponds to a number inside a box inside a box inside a box.
 
 let number: Int??? = 10
 
 If you print number you get the following:
 
 print(number)
 // Optional(Optional(Optional(10)))

 print(number!)
 // Optional(Optional(10))
 
 Do the following:
 
 1 - Fully force unwrap and print number.
 2 - Optionally bind and print number with if let.
 3 - Write a function printNumber(_ number: Int???) that uses guard to print the number only if it is bound.
 
*/

let num: Int??? = 10

// 1

print(num!!!)

// 2

if let number = num,
   let number1 = number,
   let number2 = number1 {
    print(number2)
}

// 3

func printNumber(_ number: Int???) {
    guard let num = number,
          let num1 = num,
          let num2 = num1 else {
        return
    }
    
    print(num2)
}

printNumber(num)
