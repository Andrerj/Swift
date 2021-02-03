import UIKit

/*  Content:
        
     1 - Closure
     2 - Shorthand syntax
     3 - Functions with closures
     4 - Custom sorting with closures
     5 - Iterating over collections with closures
     6 - Lazy Collections
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// CLOSURES

// A closure is simply a function without name. You can assign it to a variable and pass it around like any other value.

// Declaration of a closure

var multiplyClosure: (Int, Int) -> Int

// initial definition to compile the closure

multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b
}

// Diferent from functions, the closure has a parameter list and a return type to indicate what is expected for it.

// Use of the closure

var result = multiplyClosure(4, 2)


// Shorthand Syntax

// If the closure consists of a single return, you can leave out the return keyword

multiplyClosure = { (a: Int, b: Int) -> Int in
    a * b
}

// You can use Swift inference to omit the type of parameters

multiplyClosure = { (a, b) -> Int in
    a * b
}

// You can also omit the parameters list

multiplyClosure = {
    $0 * $1
}

// The example above, should be used only when the result are short.


// Functions with Closures

func operateOnNumbers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

// The function above receive a closure as the third parameter. You can use it like so

let addClosure = { (a: Int, b: Int) in
    a + b
}

operateOnNumbers(345, 783, operation: addClosure)

// You can also define the closure inline the function without the need to define and pass it to a variable or constant.

operateOnNumbers(12, 65, operation: {(a: Int, b: Int) -> Int in
    a * b
})

// Even more, you can use the shorthand with $

operateOnNumbers(50, 10, operation: { $0 / $1 })

// Swift is smart enough to enable you just pass the some operators as parameter to closure

operateOnNumbers(10, 45, operation: +)

// You can simplify even more, but this approach only works if the closure is the last parameter of function.

operateOnNumbers(144, 564) {
    $0 + $1
}


// Closures with no return value

let voidClosure: () -> Void = {
    print("Swift")
}

voidClosure()


// Capturing from the enclosure

var counter = 0

let incrementCounter = {
    counter += 1
}

// The closure here is declared in the same escope as the variable counter, and for this reason is able to access and change the value of counter. The closure is said to capture the value of closure.

incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
print(counter)

// The fact closures can be used to capture values can be really useful like in this example

func countingClosure() -> () -> Int {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}

// The closure returned from this function will increment its internal counter each time its called. Each time you call this function, you'll get a different counter.

let counter1 = countingClosure()
let counter2 = countingClosure()

counter1()
counter2()
counter1()
counter1()
counter2()


// Custom sorting with closures

// By specifying a closure, you can customize how things can be ordered

let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE"]

let sorted1 = names.sorted()
print(sorted1) // Alphabetical order

let sorted2 = names.sorted {
    $0.count > $1.count
}

print(sorted2) // Count order


// Iterating over collections with closures

// forEach example where you can loop over the elements and perform an operation in each one

let values = [1, 2, 3, 4, 5, 6]

values.forEach {
    print("\($0): \($0 * $0)")
}

// filter example

var prices = [1.5, 10, 4.99, 2.30, 8.19]
print(prices)

let largerPrices = prices.filter {
    $0 > 5
}

print(largerPrices)

// The signature of the function above is func filter(_ isIncluded: (Element) -> Bool) -> [Element]

// first example

let largePrice = prices.first {
    $0 > 5
}

print(largePrice!)

// map example

let salesPrices = prices.map {
    $0 * 0.9
}

print(salesPrices)

// The map function will perform a calculation in each element of the array and return a new array containing each result with the order maintained

// You also can use map to change the type of values

let userInput = ["0", "11", "hahaha", "42"]

let numbers1 = userInput.map {
    Int($0)
}

print(numbers1)

// Also you can use compactMap to filter out invalid values

let numbers2 = userInput.compactMap {
    Int($0)
}

print(numbers2)

// reduce take two values. A starter value and a closure. The closure take two values: The current value and an element from array. The closure returns the next value that should be passed into the closure as the current value paramater.

// This could be used with the prices array to calculate the total

let sum = prices.reduce(0) {
    $0 + $1
}

print(sum)


// These function can also be used with dictionaries

// You can, for example, calculate the sum of all the price of items in your shop by the stock of items.

let stock = [1.5: 5, 10: 2, 4.99: 20, 2.3: 5, 8.19: 30]

let stockSum = stock.reduce(0) {
    $0 + $1.key * Double($1.value)
}

print(stockSum)

// Here, the second parameter from reduce is a named tuple containing the key and value.

// There is another version of reduce named reduce(into:_:). You'd use it when the result you're reducing a collection into is an array aor a dictionary.

let farmAnimals = ["Horse": 5, "Cow": 10, "Sheep": 50, "Dog": 1]

let allAnimals = farmAnimals.reduce(into: []) { (result, this: (key: String, value: Int)) in
    for _ in 0..<this.value {
        result.append(this.key)
    }
}

print(allAnimals)

// It works exactly the same way as the other version, exceptthat you don't return something from the closure. Instead, each iteration gives you a mutable value. In this way, there is only ever one array in this example that is created and append to.


// Should you need to chop up an array, there are a few more functions that can be helpful

let removeFirst = prices.dropFirst()
let removeFirstTwo = prices.dropFirst(2)

// The dropFirst function takes a single parameter that defaults to 1 and returns an array with the required number of elements removed from the front.

print(prices)

print(removeFirst)
print(removeFirstTwo)

// Just like the example above dropLast can be useful

let removeLast = prices.dropLast()
let removeLastTwo = prices.dropLast(2)

print(removeLast)
print(removeLastTwo)

// And you can also select only the first or last elements

let firstTwo = prices.prefix(2)
let lastTwo = prices.suffix(2)

// And you can also remove all elements in a collection that don't satisfy a condition

prices.removeAll() { $0 > 2 }
print(prices)


// Lazy collections

// This approach is used when you have to deal with a collection that is huge or even infinite. You can see the prime numbers example.

func isPrime(_ number: Int) -> Bool {
    if number == 1 { return false }
    if number == 2 || number == 3 { return true }
    
    for i in 2...Int(Double(number).squareRoot()) {
        if number % i == 0 { return false }
    }
    
    return true
}

var primes: [Int] = []
var i = 1

while primes.count < 10 {
    if isPrime(i) { primes.append(i) }
    i += 1
}

primes.forEach { print($0, terminator: " ") }

// The example above works, but functional way is a better approach. The functional way to get the first ten primes would be to have the sequence of all the primes and then use prefix() to get the first ten. However, get an sequence of infinite length and get the prefix() you need the lazy operations to tell Swift create the collection on demand when it's needed.

// You could rewrite the code above like so

let otherPrimes = (1...).lazy
    .filter { isPrime($0) }
    .prefix(10)

print()
otherPrimes.forEach { print($0, terminator: " ") }

// You started the code above with an open ended collection. Which means 1 until infinity.

// Then you use lazy to tell Swift hat you want this to be a lazy collection.

// Then you use filter and prefix to filter out the primes and choose the first ten.

// At that point, sequence has not been generated. No primes are checked. It is only on the second statement, the primes.forEach that the sequence is evaluated and the first ten prime numbers are printed out.


// Mini - exercises

// 1 - Create a constant array called names that contains some names as strings. Any names will do — make sure there’s more than three. Now use reduce to create a string that is the concatenation of each name in the array.

let people = ["André", "Ana", "Bruno", "Arthur", "Gio", "Jessica", "Mayara", "Carlos", "João"]

let peopleUnited = people.reduce("") {
    $0 + $1
}

print()
print(peopleUnited)

// 2 - Using the same names array, first filter the array to contain only names that are longer than four characters, and then create the same concatenation of names as in the above exercise. (Hint: You can chain these operations together.)

let onlySomePeople = people
    .filter { $0.count > 4 }
    .reduce("") { $0 + $1 }

print(onlySomePeople)

// 3 - Create a constant dictionary called namesAndAges that contains some names as strings mapped to ages as integers. Now use filter to create a dictionary containing only people under the age of 18.

let namesAndAges = ["André": 29, "Ana": 25, "Bruno": 46, "Arthur": 15, "Gio": 18, "Jessica": 34, "Mayara": 53, "Carlos": 60, "João": 71]

let namesUnder18 = namesAndAges.filter {
    $0.value < 18
}

print(namesUnder18)

// 4 - Using the same namesAndAges dictionary, filter out the adults (those 18 or older) and then use map to convert to an array containing just the names (i.e. drop the ages).

let peopleAbove18 = namesAndAges
    .filter { $0.value >= 18 }
    .map { $0.key }

print(peopleAbove18)


// Challenges

/* 1 - Your first challenge is to write a function that will run a given closure a given number of times.
 
 Declare the function like so:
 
 func repeatTask(times: Int, task: () -> Void)
 
 The function should run the task closure, times number of times. Use this function to print "Swift Apprentice is a great book!" 10 times.
 
 */

func repeatTask(times: Int, task: () -> Void) {
    for _ in 1...times {
        task()
    }
}

let swiftApprentice = { () in
    print("Swift Apprentice is great!")
}

repeatTask(times: 5, task: swiftApprentice)

/* 2 - In this challenge, you’re going to write a function that you can reuse to create different mathematical sums.
 Declare the function like so:
 
 func mathSum(length: Int, series: (Int) -> Int) -> Int
 
 The first parameter, length, defines the number of values to sum. The second parameter, series, is a closure that can be used to generate a series of values. series should have a parameter that is the position of the value in the series and return the value at that position.
 
 mathSum should calculate length number of values, starting at position 1, and return their sum.
 Use the function to find the sum of the first 10 square numbers, which equals 385. Then use the function to find the sum of the first 10 Fibonacci numbers, which equals 143. For the Fibonacci numbers, you can use the function you wrote in the functions chapter — or grab it from the solutions if you’re unsure your solution is correct.
 
 */

func mathSum(length: Int, series: (Int) -> Int) -> Int {
    var result = 0
    for i in 1...length {
        result += series(i)
    }
    
    return result
}

// Functional version of mathSum

func mathSum(_ length: Int,_ series: (Int) -> Int) -> Int {
    return (1...length).map { series($0) }.reduce(0, +)
}

// Sum of square numbers
mathSum(length: 10) { number in
    number * number
}

// Sum of Fibonacci

func fibonacci(_ number: Int) -> Int {
    if number <= 0 { return 0 }
    if number == 1 || number == 2 { return 1 }
    
    return fibonacci(number - 1) + fibonacci(number - 2)
}

mathSum(length: 10, series: fibonacci)

/* 3 - In this final challenge, you will have a list of app names with associated ratings they’ve been given. Note — these are all fictional apps! Create the data dictionary like so:
 
 let appRatings = [
   "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
   "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
   "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
 ]
 
 First, create a dictionary called averageRatings that will contain a mapping of app names to average ratings. Use forEach to iterate through the appRatings dictionary, then use reduce to calculate the average rating. Store this rating in the averageRatings dictionary. Finally, use filter and map chained together to get a list of the app names whose average rating is greater than 3.

*/

let appRatings = [
    "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
    "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
    "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
]

var averageRatings: [String: Double] = [:]

for app in appRatings.keys {
    averageRatings.updateValue(0.0, forKey: app)
}

appRatings.forEach {
    let sumOfValues = $0.value.reduce(0) {
        $0 + $1
    }
    let average = Double(sumOfValues) / Double($0.value.count)
    averageRatings.updateValue(average, forKey: $0.key)
}

let appsRatingBiggerThan3 = averageRatings
    .filter { $0.value > 3 }
    .map { $0.key }

print(appsRatingBiggerThan3)
