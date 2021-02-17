import UIKit

/*  Content:
        
     1 - Method Refresher
     2 - Comparing methods to computed properties
     3 - Initializers
     4 - Mutating methods
     5 - Type methods
     6 - Adding to existing structures with extensions
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */


// Method Refresher

var numbers = [1, 2, 3]
numbers.removeLast()
numbers


// Comparing methods to computed properties

// The two of them are really similar. It comes down to a matter of style. There are few  helpful thoughts to help you decide each of them to use.

/* - Properties hold values that you can get and set, while methods perform work.
 
 Should I implement this value getter as a method or computed property?
 
 Need a setter? Yes, create a computed property. No. Extensive computation or DB access? Yes, create a method. No. computed property
 
 */


// Turning a function in a method

// In the code below, how could you convert monthsUntilWinterBreak(date:) into a method?

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

struct SimpleDate {
    var month: String = "January"
    var day: Int = 1
    
    // Initializer with default value
    
//    init() {
//        self.month = "January"
//        day = 1
//    }
    
    // Initializer to instances with only month work
    
//    init(month: String) {
//        self.month = month
//        day = 1
//    }
    
    // Initializer equals to automatic memberwise initializer
    
//    init(month: String, day: Int) {
//        self.month = month
//        self.day = day
//    }
    
    // Answer
    
    func monthsUntilBreak(from date: SimpleDate) -> Int {
        months.firstIndex(of: "December")! - months.firstIndex(of: date.month)!
    }
    
    // With use of self
    
    func monthsUntilBreak() -> Int {
        months.firstIndex(of: "December")! - months.firstIndex(of: self.month)!
    }
    
    // Computed property
    
    var monthsUntilBreaking: Int {
        get {
            return months.firstIndex(of: "December")! - months.firstIndex(of: self.month)!
        }
    }
    
    // mutating method
    
//    mutating func advance() {
//        day += 1
//    }
    
    // answer challenge 2
    
    mutating func advance() {
        switch month {
        case "January", "March", "May", "July", "August", "October", "December":
            if day == 31 {
                if month == "December" {
                    day = 1
                    month = months[0]
                } else {
                    day = 1
                    month = months[months.firstIndex(of: month)! + 1]
                }
            } else { day += 1 }
        
        case "April", "June", "September", "November":
            if day == 30 {
                day = 1
                month = months[months.firstIndex(of: month)! + 1]
            } else { day += 1 }
        
        case "February" :
            if day == 28 || day == 29 {
                day = 1
                month = months[months.firstIndex(of: month)! + 1]
            } else { day += 1 }
        default:
            print("error")
        }
    }
}

func monthsUntilBreak(from date: SimpleDate) -> Int {
    months.firstIndex(of: "December")! - months.firstIndex(of: date.month)!
}

// Making a method is easy as moving the function inside the structure definition

// There is not keyword for a method. It is just a function inside a named type. You call a method with dot syntax.

//var date = SimpleDate(month: "April")
//date.monthsUntilBreak(from: date)

// In the example above, the instance is passing itself for its own method. What is a little awkward.

// date.monthsUntilBreak()

// If you try to call it without the parameter, it will give you an error.

// For the sitaution like this, the keyword self is used. To access a value of instance inside the structure definition you use self. The Swift compiler passes it in your method as a secret parameter. The method definition will change as seen in the structure.

//date.monthsUntilBreak()

// self is your reference to instance, but most of the times you don't need to call it. Swift understand your intentif you just use a variable name. In the example above: month

// Mini - exercise

// Since monthsUntilWinterBreak() returns a single value and there’s not much calculation involved, transform the method into a computed property with a getter component.

//date.monthsUntilBreaking


// Initializers

// Initializers are a special methods you call to create an instance. They omit the func keyword and use the init. An initializer can have parameters, but it doesn't have to.

// For now, you can't initialize a instance of SimpleDate with no parameters. For that you need add a initializer with a default value

// let newDate = SimpleDate(month: <#T##String#>)

//let newDate = SimpleDate()
//newDate.month
//newDate.monthsUntilBreaking

// You need to give values for all stored properties to create an instance without parameters.

// Initializers never return a value


// Initializers in Structure

// By creating a custom initializer like you did before,  you forgo the option to use the the automatic memberwise initializer which gives you an init with parameters to complete.

// To achieve the same automatic initializer, you need to define a custom one like the one you forgo.

//let valentinesDay  = SimpleDate(month: "February", day: 14)
//valentinesDay.month
//valentinesDay.day


// Default Values and Initializers

// There is a more straightforward way to achieve a no-parameter initializer. When you set default values to your properties, the automatic memberwise initializer will take the default values into account.

// With the default values, both init() and init(month: day:) were removed.

// Even though the initializers are gone, you still can use both styles

let newYearsDay = SimpleDate()
newYearsDay.month
newYearsDay.day

let valentinesDay = SimpleDate(month: "February", day: 14)
valentinesDay.month
valentinesDay.day


// Whats happening is that automatic memberwise initializer is available since you didn't declare a any custom initializers. It provides you the init(month: day:) for you since those parameters are the properties and also init() since its smart enough to realize properties have default values.

// You can also mix and match, passing only the properties that you care

let octoberFirst = SimpleDate(month: "October")
octoberFirst.month
octoberFirst.day

let januaryTwentySecond = SimpleDate(day: 22)
januaryTwentySecond.month
januaryTwentySecond.day


// Introducing mutating methods

// Methods in a structures can't change the values of the instance without being marked as mutating

// Since structure is a value type, if a method changes the value of one of the properties, then the original and the copied instance will no longer be equivalent.

// By marking a method as mutating, you're telling to the Swift compiler this method must not be called on constants. If you call this method on a constant instance of structure, the compile will flag an error.


// Type methods

// Like type properties, you can also use type methods to access data accross all instances. Like you did in properties too, you must mark the method with the static keyword.

// Type methods are useful for things that are about a type in general, rather than something about specific instances.

struct Math {
    static func fatorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
    
    static func triangleNumber(of number: Int) -> Int {
        (1...number).reduce(0, +)
    }
    
    static func isEven(_ number: Int) -> Bool {
        return number % 2 == 0
    }
    
    static func isOdd(_ number: Int) -> Bool {
        return number % 2 == 1
    }
}

Math.fatorial(of: 6)

// Instead of having a bunch of free-standing functions, you can group related functions togheter as type methods in a structure. The structure is said to act as a namespace.

// Mini - exercise

// “Add a type method to the Math structure that calculates the n-th triangle number. It will be very similar to the factorial formula, except instead of multiplying the numbers, you add them.

Math.triangleNumber(of: 10)


// Adding to existing an existing structure with extensions.

// When you don't have access or don't want to mess with the structure, it is possible to add methods, initializers and computed properties with a extension.

extension Math {
    static func primeFactors(of value: Int) -> [Int]
    {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        
        while testFactor * testFactor <= remainingValue
        {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else { testFactor += 1 }
        }
        
        if remainingValue > 1 { primes.append(remainingValue) }
        
        return primes
    }
}

Math.primeFactors(of: 81)

// In a extension, you cannot add a stored property.


// Keeping the compiler-generated initializaer using extensions

// With the SimpleDate structure, you saw when you add your init(), the compiler-generated memberwise dissapear. It turns out that you can keep both if you add your init() in a extension.

struct Date {
    var month = "January"
    var day = 1
      
      func monthsUntilWinterBreak() -> Int {
        months.firstIndex(of: "December")! -
        months.firstIndex(of: month)!
      }
      
      mutating func advance() {
        day += 1
      }
    
}

extension Date {
    init(month: Int, day: Int) {
        self.month = months[month-1]
        self.day = day
    }
}
    
let aDate = Date(month: 5, day: 6)
aDate.month
aDate.day


// Challenges

/* 1 - Given the Circle structure below:

 struct Circle {
  
  var radius = 0.0

  var area: Double {
    .pi * radius * radius
  }

  init(radius: Double) {
    self.radius = radius
  }
}
 
Write a method that can change an instance’s area by a growth factor. For example, if you call circle.grow(byFactor: 3), the area of the instance will triple.

 Hint: Add a setter to area.
*/

struct Circle {
    var radius = 0.0
    
    var teste = 0.0
    
    var area: Double {
        get {
            .pi * radius * radius
            
        }
        set {
            // newValue here is the value from get calculation
            radius = (newValue / .pi).squareRoot()
            print(newValue)
            print(radius)
        }
    }
    
    mutating func grow(byFactor: Double) {
        area *= byFactor
    }
}

var circle = Circle(radius: 2.0)
circle.area
circle.grow(byFactor: 3)
circle.area

/* 2 - Here is a naïve way of writing advance() for the SimpleDate structure you saw earlier in the chapter:

let months = ["January", "February", "March",
             "April", "May", "June",
             "July", "August", "September",
             "October", "November", "December"]

struct SimpleDate {
 var month: String
 var day: Int

 mutating func advance() {
   day += 1
 }
}

var date = SimpleDate(month: "December", day: 31)
date.advance()
date.month // December; should be January!
date.day // 32; should be 1!”
*/

var someDate = SimpleDate(month: "December", day: 31)
someDate.advance()
someDate.month
someDate.day


// 3 - Add type methods named isEven and isOdd to your Math namespace that return true if a number is even or odd respectively.

Math.isEven(6)
Math.isOdd(3)
Math.isEven(3)
Math.isOdd(6)

// 4 - It turns out that Int is simply a struct. Add the computed properties isEven and isOdd to Int using an extension.

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }
    
    var isOdd: Bool {
        (self + 1) % 2 == 0
    }
}

2.isEven
3.isEven
4.isOdd
5.isOdd

// 5 - Add the method primeFactors() to Int. Since this is an expensive operation, this is best left as an actual method.

extension Int {
    static func primeFactors(of value: Int) -> [Int]
    {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        
        while testFactor * testFactor <= remainingValue
        {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else { testFactor += 1 }
        }
        
        if remainingValue > 1 { primes.append(remainingValue) }
        
        return primes
    }
}

Int.primeFactors(of: 90)
