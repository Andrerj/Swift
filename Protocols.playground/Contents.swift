import UIKit

/*  Content:
        
     1 - Introducing protocols
     2 - Protocol syntax
     3 - Methods in protocol
     4 - Properties in protocol
     5 - Initializers in protocol
     6 - Protocol inheritance
     7 - Implementing Protocol
     8 - Associated types with protocols
     9 - Protcol composition
     10 - Extension and protocol conformance
     11 - Protocols in the standard library
     12 - Free Functions
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Protocol is the last named type in Swift, but unlike the the other named types, protocols don't define anything  you instantiate directly.  Instead, they define an interface or blueprint that actual concrete types conform to.

// Protocol example

protocol Vehicle {
    func accelerate()
    func stop()
}

// The big differene you'll notice is that protocol doesn't contain any implementation. That's means you can't instantiate a Vehicle directly.

// Instead you use protocol in other types to enforce methods and properties to other types.


// Protocol syntax

// A protocol can be adopted by any of the other three named types and when on of them adopt a protocol, is requred to conform to its methods and properties.

class Unicycle: Vehicle {
    var pedddling = false
    
    func accelerate() {
        pedddling = true
    }
    
    func stop() {
        pedddling = false
    }
}

// Note: it looks like class inheritance but it isn't.

// If you try to remove any method from Unicycle, the compiler would complain that this class doesn't conform to the protocol.


// Methods in protocol

// You define protocols much like you would in any class, struct or enum

enum Direction {
    case left
    case right
}

protocol DirectionalVehicle {
    func accelerate()
    func stop()
    func turn(_ direction: Direction)
    func description() -> String
}

// Methods defined in protocols can't have default parameters

// To provide direction as an optional argument, you'd define both versions of the method explicitly

protocol OptionalDirectionalVehicle {
    func turn()
    func turn(_ direction: Direction)
}

// Keep in mind if you conform to OptionalDirectionalVehicle, you must conform for both methods


// Properties in protocol

// Example:

protocol VehicleProperties {
    var weight: Int { get }
    var name: String { get set }
}

// When defining properties to a protocol, you must explictly mark them as get or get set, similar to the way you declared computed properties.

// The fact you must mark get and set on properties shows that a protocol doesn't know about a property's implementation, which means it makes no assumption about the property's storage. You can implement these properties requirements as computed properties or as regular variable.

// Even if the property has only a get requirement, you're still allowed to implement it as stored property or a read-write computed property, as the requirement in the protocol are only minimum requirements.


// Initializers in protocols

// Protocols can't be initialized but they can declare initializers that conforming types should have

protocol Account {
    var value: Double { get set }
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

// In any type that conforms to Account is required to have initializers. If you conform to a protocol with required initializers using a class type, those initializers must use the required keyword

class BitcoinAccount: Account {
    var value: Double
    
    required init(initialAmount: Double) {
        value = initialAmount
    }
    
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0.0 else {
            return nil
        }
        value = transferAccount.value
    }
}

var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)

//let account = BitcoinAccount.init(initialAmount: 30.00)
//account.value
//let transferAccount = BitcoinAccount.init(transferAccount: account)
//transferAccount?.value

// Note: in the example above if you try to assign BitconAccount directly to accountType, you'll need to use the method type(of: ) to use accountType


// Protocol inheritance

// You can have protocols that inherits from others protocols. Using the example of Vehicles, you may wish to define a protocol that contains all the qualities of Vehicle, but specify to vehicles with wheels.

protocol WheeledVehicle: Vehicle {
    var numberOfWheel: Int { get }
    var wheelSize: Double { get set }
}

// Now any type you mark as conforming to the WheeledVehicle protocol will have all the members defined within the braces, in addition to all of the members of Vehicle.

// Mini - exercises

// 1 - Create a protocol Area that defines a read-only property area of type Double.

protocol Area {
    var area: Double { get }
}

// 2 - Implement Area with structs representing Square, Triangle and Circle.

struct Square: Area {
    var base: Double
    
    var area: Double {
        base * base
    }
}

struct Triangle: Area {
    var height: Double
    var base: Double
    
    var area: Double {
        height * base / 2
    }
}

enum CircleVariable {
    case radius
    case diameter
    case circumference
}

struct Circle: Area {
    var variable: CircleVariable
    var value: Double

    var area: Double {
        switch variable {
        case .radius:
            return Double.pi * pow(value, 2)
        case .diameter:
            return (Double.pi / 4) * (pow(value, 2))
        case .circumference:
            return pow(value, 2) / (4.0 * (Double.pi))
        }
    }
}


var circle = Circle(variable: .radius, value: 3.0)
circle.area

circle = Circle(variable: .diameter, value: 6.0)
circle.area

circle = Circle(variable: .circumference, value: 18.84955592)
circle.area

// 3 - Add a circle, a square and a triangle to an array. Convert the array of shapes to an array of areas using map.

let square = Square(base: 5.0)
let triangle = Triangle(height: 5.0, base: 10.0)

let shapes: [Area] = [square, triangle, circle]
print(shapes.map { $0.area })


// Implementing protocol

// When you conform to a protocol, you must conform to all its properties and methods

class Bike: WheeledVehicle {
    let numberOfWheel: Int = 2
    var wheelSize: Double = 16.0

    
    var peddling = false
    var brakesApplied = false

    func accelerate() {
        peddling = true
        brakesApplied = false
        
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

// Implementing properties

// The numberOfWheels constant fulfills the get requirement. The wheelSize variable fulfills both get and set requirements.

// Protocols don’t care how you implement their requirements, as long as you implement them.


// Associated types with protocols

// When using a associatedtype in a protocol, you're simply stating there is a type used in protocol, without specifying what type this should be. It’s up to the protocol adopter to decide what the exact type should be.

// This lets you give arbitrary names to types without specifying exactly which type it will eventually be:

protocol WeightCalculatable {
    associatedtype WeightType
    var weight: WeightType { get }
}

class HeavyThing: WeightCalculatable {
    typealias WeightType = Int
    var weight: Int { 100 }
}

class LightThing: WeightCalculatable {
    typealias WeightType = Double
    var weight: Double { 2.0 }
}

// In these examples, you use typealias to be explicit about the associated type. This usually, isn't required, as the compiler can often infer the type.

// The contract of WeightCalculatable now changes depending on the choice of associated type in the adopting type. Note that this prevents you from using the protocol as a simple variable type, because the compiler doesn’t know what WeightType will be ahead of time.

//let weightedThing: WeightCalculatable = LightThing()
// ERROR! It can only be used as a generic constraint


// Implementing multiple protocols

// A class can only inherits from a single class, this is the property of single inheritance. In contrast a class(structs, and enums) can be made to conform to as many protocols you want.

// You could instead of creating WheeledVehicle that inherits from Vehicle, create your own protocol Wheeled

protocol Wheeled {
    var numberOfWheel: Int { get }
    var wheelSize: Double { get set }
}

class Trycicle: Wheeled, Vehicle {
    var numberOfWheel: Int = 3
    
    var wheelSize: Double = 18.0
    
    func accelerate() {
        print("It's accelerating")
    }
    
    func stop() {
        print("it's stoped")
    }
}


// Protocol composition

// Sometimes you need to access properties or functions of different protocols like numberOfWheel from Wheeled and stop() from Vehicle, you're able to do it using the & operator.

func roundAndRound(transportation: Vehicle & Wheeled) {
    transportation.stop()
    print("The breaks are being applied to \(transportation.numberOfWheel) wheels.")
}

roundAndRound(transportation: Trycicle())


// Extensions and protocol conformance

// You can also adopting protocols using extensions. This let you add protocol conformances for types you don't own.

protocol Reflective {
    var typeName: String { get }
}

extension String: Reflective {
    var typeName: String {
        "I'm a string"
    }
}

let title = "Swift Apprentice"
title.typeName

// Even thoug String is the part of standard library, you're still able to make it conform to a protocol.

// Another advantage is that you can group together the protocol adoption with the requisites methods and proeprties.

class AnotherBike: Wheeled {
    var peddling = false
    let numberOfWheel: Int = 2
    var wheelSize: Double = 16.0
}

extension AnotherBike: Vehicle {
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

// This pair the methods with AnotherBike. If you were to remove Vehicle protocol from AnotherBike, you could simply delete the extension.

// Note: You can’t declare stored properties in extensions. You can still declare stored properties in the original type declaration and satisfy protocol conformance to any protocol adopted in an extension, but completely implementing protocols in extensions isn’t always possible due to the limits of extensions.


// Requiring reference semantics

// Protocols can be adopted both for value types as for reference types. So you might wonder what type protocol is. The truth is it depends. Protocols will match the type for what they were conformed.

// Example with a struct and a class

protocol Named {
    var name: String { get set }
}

class ClassyName: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct StructyName: Named {
    var name: String
}

var named: Named = ClassyName(name: "Classy")
var copy = named

named.name = "Still Classy"
copy.name
named.name


named = StructyName(name: "Structy")
copy = named

named.name = "Still Structy?"
named.name
copy.name

// You can see above that the protocol Named assumes value type or reference type conforms the type it is applied to.

// Whoever, the situation is not always clear, so you can request a type when designing a protocol.

protocol X: class {
    var isAMutant: Bool { get }
}


// Protocols in the standard library

// The Swift standard library uses protocols extensively.

// Equatable

// some of the simple codes compares two values with the operator ==

let a = 5
let b = 5

a == b

let swiftA = "Swift"
let swiftB = "Swift"

swiftA == swiftB

// But you can't use == in any type.

// Example to check if two records are equal

class Record {
    var wins: Int
    var losses: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
}

let recordA = Record(wins: 10, losses: 5)
let recordB = Record(wins: 10, losses: 5)

// recordA == recordB ERROR

// You can't apply the simple operator == to class. This operator is reserved for the standard Swift types like Int and String. But the use of the operator is not magic, they're  a simple struct. This mean you can extend the use of the operator to your own code.

// Both Int and String conform to the Equatable protocol from the the standard library that defines a single static method:

//protocol Equatable {
//    static func ==(lhs:Self, rhs:Self) -> Bool
//}

// Now you can apply on your class or struct

extension Record: Equatable {
    static func == (lhs: Record, rhs: Record) -> Bool {
        lhs.wins == rhs.wins && lhs.losses == rhs.losses
    }
}

// Here you're overloading the == operator for compare two instances.

recordA == recordB


// Comparable

// This is a subprotocol of equatable and is used to others comparison operator

//protocol Comparable: Equatable {
//    static func <(lhs: Self, rhs:Self) -> Bool
//    static func <=(lhs: Self, rhs: Self) -> Bool
//    static func >=(lhs: Self, rhs: Self) -> Bool
//    static func >(lhs: Self, rhs: Self) -> Bool
//}

// In addition to the equality operator ==, Comparable requires you to overload the comparison operators <, <=, > and >= for your type. In practice, you’ll usually only provide <, as the standard library can implement <=, > and >= for you, using your implementations of == and <.

extension Record: Comparable {
    static func < (lhs: Record, rhs: Record) -> Bool {
        if lhs.wins == rhs.wins {
            return lhs.losses > rhs.losses
        }
        return lhs.wins < rhs.wins
    }
}

recordA.wins = 5
recordB.wins = 12

recordA < recordB


// Free Functions

// Swift also provides many free functions and methods for types that conform to Equatable and Comparable

// For any collection you define that contains a Comparable type, such as an Array, you have access to methods such as sort() that are part of the standard library

let teamA = Record(wins: 14, losses: 11)
let teamB = Record(wins: 23, losses: 8)
let teamC = Record(wins: 23, losses: 9)

var league = [teamA, teamB, teamC]
league.sort()

// Since you've given the ability to compare two values, know you've have access for some of useful free functions

league.max()
league.min()
league.starts(with: [teamA, teamC])
league.contains(teamA)


// Other useful protocols

// Hashable

// This is a ssubprotocol of Equatable, is a requirement for any type you want to use as a key to a Dictionary. For value types (structs, enums) the compiler will generate Equatable and Hashable conformance for you automatically, but you will need to do it yourself for reference (class) types.

// Hash values help you quickly find elements in a collection. In order for this to work, values that are considered equal by == must also have the same hash value.

// Example of Hashable with class

class Student {
    let email: String
    let firstName: String
    let lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension Student: Hashable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        lhs.email == rhs.email && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
}


// You use email, firstName and lastName as the basis for equality. A good implementation of hash would be to use all of these properties by combining them using the Hasher type passed in. The hasher does the heavy lifting of properly composing the values.

// You can now use the Student type as the key in a Dictionary:

let andre = Student(email: "andre@mail.com", firstName: "André", lastName: "Rodrigues")
let andreMap = [andre: "14B"]


// Custom String Convertible

// The very handy CustomStringConvertible protocol helps you log and debug instances.

// When you call print() on an instance such as a Student, Swift prints a vague description:

print(andre)

// This property customizes how the instance appears in print() statements and in the debugger

//protocol CustomStringConvertible {
//  var description: String { get }
//}

// By adopting CustomStringConvertible on the Student type, you can provide a more readable representation.

extension Student: CustomStringConvertible {
    var description: String {
        "\(firstName) \(lastName)"
    }
}

andre.description


// Challenges

/* Create a collection of protocols for tasks at a pet shop that has dogs, cats, fish and birds.
 The pet shop duties can be broken down into these tasks:

 - All pets need to be fed.
 - Pets that can fly need to be caged.
 - Pets that can swim need to be put in a tank.
 - Pets that walk need exercise.
 - Tanks and cages need to occasionally be cleaned.

 Create classes or structs for each animal and adopt the appropriate protocols. Feel free to simply use a print() statement for the method implementations.
 
 Create homogeneous arrays for animals that need to be fed, caged, cleaned, walked, and tanked. Add the appropriate animals to these arrays. The arrays should be declared using the protocol as the element type, for example var caged: [Cageable]
 
 Write a loop that will perform the proper tasks (such as feed, cage, walk) on each element of each array.
 
*/

protocol Feed {
    func feed()
}

protocol Clean {
    func clean()
}

protocol Fly: Clean {
    func putInCage()
}

protocol Swin: Clean {
    func putInTank()
}

protocol Walk {
    func walking()
}

class Dog: Feed, Walk {
    func feed() {
        print("Time to feed the dog!")
    }
    
    func walking() {
        print("C'mon boy! Time to go walk")
    }
}

class Cat: Feed, Walk {
    func feed() {
        print("Time to feed the cat!")
    }
    
    func walking() {
        print("C'mon boy! Time to go walk")
    }
}

class Bird: Feed, Fly {
    func feed() {
        print("Feed the bird!")
    }
    
    func putInCage() {
        print("Put the bird in a cage man!")
    }
    
    func clean() {
        print("Time to clean up!")
    }
}

class Fish: Feed, Swin {
    func feed() {
        print("Feed the fish!")
    }
    
    func putInTank() {
        print("Come on man! You know the fish goes in a tank, right?!")
    }
    
    func clean() {
        print("Time to clean up!")
    }
}

let dog = Dog()
let cat = Cat()
let fish = Fish()
let bird = Bird()

let walkingDuties: [Walk] = [dog, cat]
let feedingDuties: [Feed] = [dog, cat, fish, bird]
let cleaningDuties: [Clean] = [bird, fish]
let tankingDuties: [Swin] = [fish]
let cagingDuties: [Fly] = [bird]

for animal in walkingDuties {
    animal.walking()
}

for animal in feedingDuties {
    animal.feed()
}

for animal in cleaningDuties {
    animal.clean()
}

for animal in tankingDuties {
    animal.putInTank()
}

for animal in cagingDuties {
    animal.putInCage()
}



