import UIKit

/*  Content:
        
     1 - First enum
     2 - Raw values
     3 - String raw values
     4 - Unordered raw values
     5 - Associated values
     6 - Enumeration as state machine
     7 - Iterating through all cases
     8 - Enumerations without any cases
     9 - Optionals
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Enumeration

// An enumeration is a list of related values that define a common type and let you work with values in a type-safe way.

// The compiler will catch a error if your code expect an enum Direction for example and receive a float like 10.4 or a mispelled direction like "Soouth"

// Good examples of enum are colors(Red, blue, green, so on), naipes(heart, spades, clubs and diamonds) and roles(admin, editor, reader).

// In Swift Enums share some similarities with classes and structs and can have methods and computed properties, all whileacting as a convenient state machine.


let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

func semester(for month: String) -> String {
    switch month {
    case "August", "September", "October", "November", "December":
        return "Autumn"
    case "January", "February", "March", "April", "May":
        return "Spring"
    default:
        return "Not in the school year"
    }
}

semester(for: "April")

// Declaring a enumeration

//enum Month {
//    case january
//    case february
//    case march
//    case april
//    case may
//    case june
//    case july
//    case august
//    case september
//    case october
//    case november
//    case december
//}

// The commonly accept best practice is to create enum's case with lowercase first letter

// You can simplify the example above by collapsing the case clause in one line

enum Month {
    case january, february, march, april, may, june, july, august, september, october, november, december
    
    var semester: String {
        switch month {
        case Month.august, Month.september, Month.october, Month.november, Month.december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        case .june, .july:
            return "Not in the school year"
        }
    }
}


// Deciphering an enumeration in a function

// You can rewrite the function to use enums clause

func semester(_ month: Month) -> String {
    switch month {
    case Month.august, Month.september, Month.october, Month.november, Month.december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    case .june, .july:
        return "Not in the school year"
    }
}

// Since Swift is strongly-typed, you can simplify the function by removing the enumeration name in places where the compiler already knows the type.

// switch clauses must be exhaustive with their cases. Since is impossible to match every String value, you creata a default cause. With enums you have a limited set of values you can match. So if you have a case for each member of enum, you can remove the default.

// There is another benefit to getting rid of default. If in a future update someone add new members, the compiler would automatically flag this and any other switch statement as being non-exhaustive

var month = Month.april
semester(month)

month = .september
semester(month)

/* Mini - exercise
 
 Wouldn’t it be nice to request the semester from an instance like month.semester instead of using the function? Add a semester computed property to the month enumeration so that you can run this code:
 
 let semester = month.semester // "Autumn"
 
*/

month = .july
month.semester


// Raw values

// Unlike enums values in C, Swift enum values are not backed by integers as default. But can associate a raw value with each enumeration case simply by declaring the raw value in the enumeration


//enum Months: Int {
//    case january = 1, february = 2, march = 3, april = 4, may = 5, june = 6, july = 7, august = 8, september = 9, october = 10, november = 11, december = 12
//
//    var semester: String {
//        switch month {
//        case Month.august, Month.september, Month.october, Month.november, Month.december:
//            return "Autumn"
//        case .january, .february, .march, .april, .may:
//            return "Spring"
//        case .june, .july:
//            return "Not in the school year"
//        }
//    }
//}

// Swift enumerations are flexible: you can specify other raw value types like String, Float or Character. As in C, if you use integers and don’t specify values as you’ve done here, Swift will automatically assign the values 0, 1, 2 and up.

// In the case above, is better start with 1

// There is shorthand you can use giving an Int value to a enum member. If you give the number 1 by example for january, automatically Swift will increment the value for the others months.

enum Months: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
    
    var semester: String {
        switch month {
        case Month.august, Month.september, Month.october, Month.november, Month.december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        case .june, .july:
            return "Not in the school year"
        }
    }
    
    var monthsUntilBreak: Int {
        Months.december.rawValue - self.rawValue
    }
    
    var monthsUntilMidBreak: Int {
        let diff = Months.june.rawValue - self.rawValue
        
        if diff < 0 {
            return 12 - abs(diff)
        } else {
            return diff
        }
    }
    
    
}

let aMonth = Months.february // If two enums have the same members, you'll have to specify the enum
print(aMonth.rawValue)


// Example of raw's value use

func monthsUntilBreak(from month: Months) -> Int {
    Months.december.rawValue - month.rawValue
}

monthsUntilBreak(from: .april)

// You can use the rawValue to instantiate an enum value with an initializer. You can use init(rawValue) to do this.

let fifthMonth = Months(rawValue: 5)
monthsUntilBreak(from: fifthMonth!)

// There is no guarantee that the raw value you submitted exists in the enumeration, so the initializers return an optional. Enumeration initializers with the rawValue: parameter are failable initializers, meaning if it goes wrong, the initializer will return nil.

/* Mini - exercise
 
 Make monthsUntilWinterBreak a computed property of the Month enumeration, so that you can execute the following code:
 
 let monthsLeft = fifthMonth.monthsUntilWinterBreak // 7”

*/

fifthMonth?.monthsUntilBreak


// String raw values

// Similar to the handy trick of incrementing an Int raw value, if you specify a raw value type of String you’ll get another automatic conversion.


enum Icon: String {
    case music
    case sports
    case weather
    
    var fileName: String {
        "\(rawValue).png"
    }
}

let icon = Icon.weather
icon.fileName

// Calling raw value inside the enumeration definition is equivalent to calling self.rawValue. Since the raw value is a string, you can use it to build a file name.

// Note you didn’t have to specify a String for each member value. If you set the raw value type of the enumeration to String and don’t specify any raw values yourself, the compiler will use the enumeration case names as raw values.


// Unordered raw values

// Integer raw values don’t have to be in an incremental order.

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

// You can instantiate values of this type and access their rawValue as usual

var coin = Coin.quarter
coin.rawValue

// Mini - execise

// Create an array called coinPurse that contains coins. Add an assortment of pennies, nickels, dimes and quarters to it.

var purseCoins: [Coin] = []
purseCoins.append(coin)

coin = Coin.dime
purseCoins.append(coin)

coin = Coin.penny
purseCoins.append(coin)


coin = Coin.nickel
purseCoins.append(coin)

coin = Coin.nickel
purseCoins.append(coin)

coin = Coin.quarter
purseCoins.append(coin)

// Associated Values

// This features lets you associate custom values to with each enumeration case.

/* Here some qualities of associated values:
 
    1 - Each enumeration case has zero or more associated values
    2 - The associated values for each enumeration case have their own data type
    3 - You can define associated values with label names like you would  for named function parameters
 */

// An enumeration can have raw values or can have associated values but not both.

// In the last mini-exercise, you defined a coin purse. Let’s say you took your money to the bank and deposited it. You could then go to an ATM and withdraw your money:

var balance = 100

//func withdraw(amount: Int) {
//    balance -= amount
//}

// The ATM will never let you withdraw more than you put in, so it needs a way to let you know whether the transaction was successful. You can implement this as an enumeration with associated values:

enum WithdrawResult {
    case success(newBalance: Int)
    case error(message: String)
}

// Each case has a required value to go along with it. For the success case, the associated Int will hold the new balance; for the error case, the associated String will have some kind of error message.

// Then you can rewrite the function to use the enum

func withdraw(amount: Int) -> WithdrawResult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money!")
    }
}

// The associated values are very helpful when you need to return different types.

let result = withdraw(amount: 99)

switch result {
case .success(newBalance: let newbalance):
    print("Your new balance is: \(newbalance)")
case .error(message: let message):
    print(message)
}

// Notice how you used let bindings to read the associated values. Associated values aren’t properties you can access freely, so you’ll need bindings like these to read them. Remember that the newly bound constants newBalance and message are local to the switch cases. They aren’t required to have the same name as the associated values, although it’s common practice to do so.


// One real word usage for associated values in a enumeration is from internet servers

enum HTTPMethod {
    case get
    case post(body: String)
}

// In the bank account example, you had multiple values you wanted to check for in the enumeration. In places where you only have one, you could instead use pattern matching in an if case or guard case statement. Here’s how that works:

let request = HTTPMethod.post(body: "Hi There")

guard case .post(let body) = request else {
    fatalError("No message was posted")
}
print(body)


// Enumeration as state machine

// An enumeration is an example of a state machine, meaning it can only ever be a single enumeration value at a time.

enum TrafficLight {
    case red, yellow, green
}

let trafficLight = TrafficLight.red

// Mini - exercise

// A household light switch is another example of a state machine. Create an enumeration for a light that can switch .on and .off.

enum LightSwitch {
    case on
    case off
}

let lightSwitch = LightSwitch.off


// Iterating through all cases

// Loop through all of the cases of enumeration

enum Pet: CaseIterable {
    case cat, dog, bird, turtle, fish, hamster
}

for pet in Pet.allCases {
    print(pet)
}


// Enumerations without any cases

// In Chapter 12, “Methods” you learned how to create a namespace for a group of related type methods. The example in that chapter looked like this:

//struct Math {
//  static func factorial(of number: Int) -> Int {
//    (1...number).reduce(1, *)
//  }
//}
//let factorial = Math.factorial(of: 6)

// With the struct above, you are still able to create an instance, even though it is empty. In cases like this, the better design is actually to transform Math in a enum.

enum Math {
    
    static let e = 2.7183
    
    static func fatorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}

let fatorial = Math.fatorial(of: 6)

// Now if you try to make an instance, the compiler will give an error

// Enumerations with no cases are sometimes referred to as uninhabited types or bottom types.

/* “ In order to create an instance of an enumeration though, you have to assign a member value as the state. If there are no member values, then you won’t be able to create an instance.
 
 That works perfectly for you in this case (pun intended). There’s no reason to have an instance of Math. You should make the design decision that there will never be an instance of the type.
 
 That will prevent future developers from accidentally creating an instance and help enforce its use as you intended. So in summary, choose a case-less enumeration when it would be confusing if a valueless instance existed.
 */

/* Mini - exercise

Euler’s number is useful in calculations for statistical bell curves and compound growth rates. Add the constant e, 2.7183, to your Math namespace. Then you can figure out how much money you’ll have if you invest $25,000 at 7% continuous interest for 20 years:
*/

let nestEgg = 25000 * pow(Math.e, 0.07 * 20) // $101,380.95


// Optionals

// Optionals uses enumeration. Optionals act as like containers that have  either something or nothing inside:

var age: Int?
age = 17
age = nil

// Optionals are really enumeration with two cases, .none means no value and .some means there is a value. Which is attached to the enumeration case as an associated value.

// You can extract the associated value from an optional with a switch statement

switch age {
case .none:
    print("No value")
case .some(let value):
    print("Got a value: \(value)")
}

// Although optionals are really enumerations under the hood, Swift hides the implementation details with things like optional binding, the ? and ! operators, and keywords such as nil.

let optionalNil: Int? = .none
optionalNil == nil
optionalNil == .none


// Challenges

// 1 - Take the coin example from earlier in the chapter then begin with the following array of coins:

let coinPurse: [Coin] = [.penny, .quarter, .nickel, .dime, .penny, .dime, .quarter]

// Write a function where you can pass in the array of coins, add up the value and then return the number of cents.


func sumCoins(_ coinPurse: [Coin]) -> Int {
    return coinPurse.reduce(0) {
        $0 + $1.rawValue
    }
}

sumCoins(coinPurse)

/* Take the example from earlier in the chapter and begin with the Month enumeration:
 
 enum Month: Int {
   case january = 1, february, march, april, may, june, july,
        august, september, october, november, december
 }
 
 Write a computed property to calculate the number of months until summer.

 Hint: You’ll need to account for a negative value if summer has already passed in the current year. To do that, imagine looping back around for the next full year.

*/

var monthsToJune = Months.april
monthsToJune.monthsUntilMidBreak

monthsToJune = Months.august
monthsToJune.monthsUntilMidBreak

/* 3 - Take the map example from earlier in the chapter and begin with the Direction enumeration:
 
 enum Direction {
   case north
   case south
   case east
   case west
 }

 Imagine starting a new level in a video game. The character makes a series of movements in the game. Calculate the position of the character on a top-down level map after making a set of movements:
 
 let movements: [Direction] = [.north, .north, .west, .south,
   .west, .south, .south, .east, .east, .south, .east]
 
 Hint: Use a tuple for the location:
 
 var location = (x: 0, y: 0)”

 */

enum Direction {
    case north
    case south
    case east
    case west
}

struct Location {
    var x = 0
    var y = 0
}

class Character {
    var name: String
    var position: Location
    
    init(name: String) {
        self.name = name
        self.position = Location(x: 0, y: 0)
    }
    
    func move(directions: [Direction]) -> Location {
        for move in directions {
            switch move {
            case .north:
                self.position.y += 1
            case .south:
                self.position.y -= 1
            case .east:
                self.position.x += 1
            case .west:
                self.position.x -= 1
            }
        }
        return position
    }
}

let movements: [Direction] = [.north, .north, .west, .south,
  .west, .south, .south, .east, .east, .south, .east]

let player = Character(name: "André")
let playerPosition = player.move(directions: movements)
print(playerPosition)


