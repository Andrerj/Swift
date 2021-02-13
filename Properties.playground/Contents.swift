import UIKit

/*  Content:
        
     1 - Stored Properties
     2 - Computed Properties
     3 - Type Properties
     4 - Property Observers
     5 - Lazy Properties
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Properties are variables and constants inside a type.

struct Car {
    let make: String
    let color: String
    var tank: FuelTank
}

// There are two types of properties. Stored properties like the one above which means they store actual values and the computed properties. This kind of property actually has no allocated memory to them, rather they get calculated on-the-fly each time you access them.


// Stored Properties

struct Contact {
    var fullName: String
    let emailAddres: String
    var relationship: String = "Friend"
}

// Swift automatically creates a initializer for you based on the properties on a structure.

var person = Contact(fullName: " André Rodrigues de Jesus", emailAddres: "andrerj@mail.com")

// Accesing values

let name = person.fullName
let email = person.emailAddres

// You can assign values to properties as long as they're are defined as variables, and the parent instance is stored in a variable

person.fullName = "André Rodrigo de Jesus   "
let andre = person.fullName

// To prevent the change above, the property inside the struct must be marked as a constant

// person.emailAddres = "newemail@mail" error


// Default values

// If you can make a reasonable assumption, you can give a default value to a property.

// For now on, any contact created will have the "Friend" status, unless you change it when create a new instance

// Swift is able to create a new initializer based on the default value

var newPerson = Contact(fullName: "José Ferrari", emailAddres: "ferrari@mail.com")
var newPerson2 = Contact(fullName: "Maria Fina", emailAddres: "fininha@mail.com", relationship: "Sister")


// Computed Properties

// A computed property calculates a value rather than store and must be declared as a variable.

// Computed properties also must include a type, because the type needs to know what to expect to as a return value.

 // Basic example

struct User {
    var firstName: String
    var lastName: String
    
    // example of computed property
    
    var fullName: String {
        return firstName + " " + lastName
    }
}

let user = User(firstName: "André", lastName: "Rodrigues")
user.fullName

// Computed properties give a getter and an optional setter. The can be used in or out from classes, structs and enums.

// get makes the variable readable. To assign a value, you must use a set, what makes it writeable.

// You can assign a local name inside the parentheses after the set keyword. This local variable will get the passed value to the computed property. If you don't provide a name for the assigned value in the setter definition, the compiler will allocate the name of newValue.

// Example with get and set

var salaryPerYear = 67000

var salaryPerWeek: Int {
    get {
        return salaryPerYear / 52
    }
    set(newSalaryPerWeek) {
        return salaryPerYear = newSalaryPerWeek * 52
    }
}

salaryPerYear
salaryPerWeek = 4000
salaryPerYear

// Example with a enum

enum Property {
    case one
    case two
    
    var description: String {
        switch self {
        case .one: return "Variant one"
        case .two: return "Variant two"
        }
    }
}

// Example with a class

class Rectangle {
    var width = 0.0
    var height = 0.0
    
    var area: Double {
        get {
            return width * height
        }
        set {
            self.width = sqrt(newValue)
            self.height = sqrt(newValue)
        }
    }
}

var rectangle = Rectangle()
rectangle.area
rectangle.area = 120
rectangle.width
rectangle.height

// Here in the example above, the width and height properties are calculated when a value is assigned to area.


// Type Properties

struct Level {
    
    // Type property example
    
    static var highestLevel = 1
    let id: Int
    var boss: String
    
    // Property observers example
    
    var unlocked: Bool {
        didSet {
            if unlocked && id > Self.highestLevel {
                Self.highestLevel = id
            }
        }
    }
    
    
}

let level1 = Level(id: 1, boss: "Chameleon", unlocked: true)
var level2 = Level(id: 2, boss: "Squid", unlocked: false)
let level3 = Level(id: 3, boss: "Chupacabra", unlocked: false)
let level4 = Level(id: 4, boss: "Yeti", unlocked: false)

// In the example above, you can use a a type property to store the game's progress as the player unlock each level. To use a type property you must declare the keyword static before the constant or variable.

// Here the property is a property on Level itself rather than the instances of Level

// let highestLevel = level4.highestLevel error

// Instead you access on the type itself

let highestLevel = Level.highestLevel

// Using a type property means you can retrieve the same stored property value from anywhere in the code for you app or algorithm


// Property Observers

// In the example from Level would be useful to automatically set highestLevel when the player unlock a new one. For that you need to listen to property changes. For that there is two types observers, a willSet and a didSet.

// A willSet observer is called when a property is about to be changed while a didSet observer is called after a property has been changed. Their syntax is similiar to getters and setters.

Level.highestLevel
level2.unlocked = true
Level.highestLevel


/* Few things to note:
 
 - The didset is called after the values been set.
 - Even though you're are inside of a instance of the type, you still have to access type properties with the type name prefix. You are required to use the full name Level.highestLevel or Self.highestLevel.
 */

// willSet and didSet are only available to stored properties.

// They are not called when a property is set on initialization, only after you assigne a new value to the variable which is observed.


// Limiting a variable

// Example:

struct LightBulb {
    static let maxCurrent = 40
    var current = 0 {
        didSet {
            if current > LightBulb.maxCurrent {
                print("""
                Current is too high,
                falling back to previous setting.
                """)
                current = oldValue
            }
        }
    }
}

// In the example above, if the current flowing into the bulb exceeds the maximum value, it will revert to its last sucessful value.

var light = LightBulb()
light.current = 50
var current = light.current
light.current = 40
current = light.current

// Mini - exercise

/* 1 - In the light bulb example, the bulb goes back to a successful setting if the current gets too high. In real life, that wouldn’t work. The bulb would burn out!

Your task is to rewrite the structure so that the bulb turns off before the current burns it out.
 
 Hint: You’ll need to use the willSet observer that gets called before value is changed. The value that is about to be set is available in the constant newValue. The trick is that you can’t change this newValue, and it will still be set, so you’ll have to go beyond adding a willSet observer. :]

*/

struct NewLightBulb {
    static let maxCurrent = 40
    var isOn = false
    
    var current = LightBulb.maxCurrent {
        willSet {
            if newValue > Self.maxCurrent {
                print("Current is too high, turning off to prevent burn out.")
                isOn = false
            }
            
        }
    }
}

var bulb = NewLightBulb()
bulb.isOn = true
bulb.current
bulb.current = 30
bulb.current
bulb.isOn
bulb.current = 50
bulb.isOn


// Lazy Properties

// This kind of property is useful for such thing as downloads or when you need make serious calculation.

// Example:

struct Circle {
    lazy var pi = {
        ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
    }()
    
    var radius = 0.0
    var circumference: Double {
        mutating get {
            pi * radius * 2
        }
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}

// In the struct above, you're not using the pi from the standard library.

// You can create a new circle with its initializer and the pi calculation won't run yet:

var circle = Circle(radius: 5)

// The calculation of pi waits patiently until you need it. Which occurs only when you cal circumference

let circumference = circle.circumference

// pi uses a { }() pattern to calculate its value, even though it’s a stored property. The trailing parentheses execute the code inside the closure curly braces immediately. But since pi is marked as lazy, this calculation is postponed until the first time you access the property.

// Circumference is a computed property, while pi is stored, which means it only will be executed one time when it were called.

// Note: Since the value of pi changes, the getter where it was used must be marked as mutating

// Since pi is a stored property of the structure, you need a custom initializer to use only the radius. Remember the automatic initializer of a structure includes all of the stored properties.


// Challenges

/* 1 - Rewrite the IceCream structure below to use default values and lazy initialization:
 
 struct IceCream {
   let name: String
   let ingredients: [String]
 }
 
 Use default values for the properties.
 
 Lazily initialize the ingredients array.

*/

struct IceCream {
    var name: String = "Vanilla"
    lazy var ingredients: [String] = {
        ["milk", "sugar", "egg yolks", "milk fat", "gelatin", "vanila"]
    }()
}

var iceCream = IceCream()
iceCream.ingredients.append("strawberry")
iceCream.name = "Strawberry"

/* 2 - At the beginning of the chapter, you saw a Car structure. Dive into the inner workings of the car and rewrite the FuelTank structure below with property observer functionality:
 
 struct FuelTank {
   var level: Double // decimal percentage between 0 and 1
 }
 
 Add a lowFuel stored property of Boolean type to the structure.

 Flip the lowFuel Boolean when the level drops below 10%.
 
 Ensure that when the tank fills back up, the lowFuel warning will turn off.
 
 Set the level to a minimum of 0 or a maximum of 1 if it gets set above or below the expected values.
 
 Add a FuelTank property to Car.
 
 */

struct FuelTank {
    var lowFuel: Bool = false
    var level: Double {
        didSet {
            if level < 0 { level = 0 }
            if level > 1 { level = 1 }
            lowFuel = level < 0.1
        }
    }
    
}

var tank = FuelTank(level: 5)
tank.level
tank.lowFuel
tank.level = 0.01
tank.level
tank.lowFuel
tank.level = 10
tank.level
tank.lowFuel
tank.level = -10
tank.level
tank.lowFuel
tank.level = 0.75
tank.level
tank.lowFuel
