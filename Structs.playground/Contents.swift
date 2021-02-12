import UIKit

/*  Content:
        
     1 - Introducing structures
     2 - Acessing members
     3 - Introducing methods
     4 - Strucuture as values
     5 - Conforming to a protocol
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Example with a pizza's delivery without and with structures

// Without struct

let restaurantLocation = (2, 4)
let restaurantRange = 2.5

//// Pythagorean Theorem
//
//func distance(from source: (x: Int, y: Int), to target: (x: Int, y: Int)) -> Double {
//    let distanceX = Double(source.x - target.x)
//    let distanceY = Double(source.y - target.y)
//
//    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
//}

// First example without struct

//func isInDeliveryRange(location: (x: Int, y: Int)) -> Bool {
//    let deliveryDistance = distance(from: location, to: restaurantLocation)
//    return deliveryDistance < restaurantRange
//}

// The code above is perfect for when you only have one restaurant but if your business expand, you'll need to create an instance from each new restaurant inside the function

let otherRestaurantLocation = (7, 8)
let otherRestaurantRange = 1.5

// Second example without struct

//func isInDeliveryRange(location: (x: Int, y: Int)) -> Bool {
//    let deliveryDistance = distance(from: location, to: restaurantLocation)
//    let secondDeliveryDistance = distance(from: location, to: otherRestaurantLocation)
//
//    return deliveryDistance < restaurantRange || secondDeliveryDistance < otherRestaurantRange
//}

// To avoid this situation, you can use a struct. Struct is known as one of named types.


// Basic example of a structure

struct Location {
    let x: Int
    let y: Int
}

// In a named type, the constants and variables inside it are known as properties.


// Instantiate a struct

let storeLocation = Location(x: 2, y: 4)

// The parameter showed when you wrote Location is known as initializer.

// Initializers enforce that all the properties are set before you starting using them.

// Create an Struct for the delivery area of restaurants

struct DeliveryArea: CustomStringConvertible {
    let center: Location
    var radius: Double
    var description: String {
        """
        Area with center: (x: \(center.x), y: \(center.y)),
        radius: \(radius)
        """
    }
    
    func contains(_ location: Location) -> Bool {
        let distanceFromCenter = distance(from: center, to: location)
        return distanceFromCenter < radius
    }
    
    func overlaps(with area: DeliveryArea) -> Bool {
        return distance(from: center, to: area.center) <= (radius + area.radius)
    }
}

var storeArea = DeliveryArea(center: storeLocation, radius: 4)


// Acessing members

// Like you did with others types, you can access properties and methods with dot syntax

print(storeArea.radius)
print(storeArea.center.x)

// You can also assign values like so

storeArea.radius = 2.5

// Define a property as constant or variable determine with you can change it.

// In addition to its properties and methods, you must declare your struct with var if you want to be able to change it after initialization

let fixedArea = DeliveryArea(center: storeLocation, radius: 4)
//fixedArea.radius = 5


// Mini-exercise

// Rewrite isInDeliveryRange to use Location and DeliveryArea.

// Pythagorean Theorem

func distance(from source: Location, to target: Location) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

// Function with use of struct Location

//func isInDeliveryRange(location: Location) -> Bool {
//    let deliveryDistance = distance(from: location, to: storeLocation)
//
//    return deliveryDistance < restaurantRange
//}


// Introducing methods

// Using some capabilities of struct, you can create a pizza delivery range calculator

let areas = [DeliveryArea(center: Location(x: 2, y: 4), radius: 2.5), DeliveryArea(center: Location(x: 9, y: 7), radius: 4.5)]

func isInDeliveryRange(_ location: Location) -> Bool {
    for area in areas {
        let distanceToStore = distance(from: area.center, to: location)
        
        if distanceToStore < area.radius { return true }
    }
    return false
}

let customer1 = Location(x: 8, y: 1)
let customer2 = Location(x: 5, y: 5)

print(isInDeliveryRange(customer1))
print(isInDeliveryRange(customer2))

// Much like a structure can have properties, it can also define it own functions. The function contains() inside DeliveryArea runs the same code as isInDeliveryRange() with a better approach. You can now use dot syntax to verify if a location is inside a delivery area.

let area = DeliveryArea(center: Location(x: 5, y: 5), radius: 4.5)
let customerLocation = Location(x: 2, y: 2)
area.contains(customerLocation)


// Mini - exercises

// 1 - Change distance(from:to:) to use Location as your parameters instead of x-y tuples.

// 2 - Change contains(_:) to call the new distance(from:to:) with Location.

// 3 - Add a method overlaps(with:) on DeliveryArea that can tell you if the area overlaps with another area.


// Structure as values

// Structures creates what are known a value types. A value type is a type whose instances are copied on assignment

// Example

var a = 5
var b = a

print(a)
print(b)

a = 10

print(a)
print(b)

// Struct example

var area1 = DeliveryArea(center: Location(x: 2, y: 4), radius: 2.5)
var area2 = area1

print(area1.radius)
print(area2.radius)

area1.radius = 4
print(area1.radius)
print(area2.radius)

// The disconnection demonstrates the value semantics working with structs. When you assign one value of a variable to another, they still are completely independent.

// Many of the standard Swift types are defined as structures, such as: Int, Double, String, Bool, Array and Dictionary. Its value semantics provide many advantages over their reference counterpart.


// Conforming to a protocol

// Example of a protocol

//public struct Int: FixedWidthInteger, SignedInteger {
//
//}

// Protocols contain a set of requirements that conforming types must satisfy.

// You can add for example the CustomStringConvertible from standard library to the DeliveryArea and make it to conform to it.

// The variable description inside DeliveryArea is what is known as computed property.

// Because any type conforming to CustomStringConvertible must define description, so you can call description on any instance of any type that conforms to CustomStringConvertible. The Swift standard library takes advantage of this with the print() function. That function will use description in the console instead of a rather noisy default description:

print(area1)
print(area2)


// Challenges

/* 1 - Imagine you’re at a fruit tree farm and you grow different kinds of fruits: pears, apples, and oranges. After the fruits are picked, a truck brings them in to be processed at the central facility. Since the fruits are all mixed together on the truck, the workers in the central facility have to sort them into the correct inventory container one-by-one.

 Implement an algorithm that receives a truck full of different kinds of fruits and places each fruit into the correct inventory container.
Keep track of the total weight of fruit processed by the facility and print out how many of each fruit are in the inventory.
 */


struct Fruit {
    let name: String
    let weight: Int
}

let truck: [Fruit] = [ Fruit(name: "Orange", weight: Int.random(in: 70...100)),
                       Fruit(name: "Pear", weight: Int.random(in: 70...100)),
                       Fruit(name: "Apple", weight: Int.random(in: 70...100)),
                       Fruit(name: "Orange", weight: Int.random(in: 70...100)),
                       Fruit(name: "Apple", weight: Int.random(in: 70...100))
]

var appleContainer: [Fruit] = []
var pearContainer: [Fruit] = []
var orangeContainer: [Fruit] = []
var totalWeight = 0

func factory(truck: [Fruit])
{
    for fruit in truck
    {
        switch fruit.name {
        case "Apple":
            appleContainer.append(fruit)
        case "Pear":
            pearContainer.append(fruit)
        case "Orange":
            orangeContainer.append(fruit)
        default:
            print("Error")
        }
        
        totalWeight += fruit.weight
    }
}

factory(truck: truck)
var descriptionFactory = """
    
    Fruit Factory

Total fruit weight: \(totalWeight) grams
Apple quantity: \(appleContainer.count)
Pear quantity: \(pearContainer.count)
Orange quantity: \(orangeContainer.count)
"""

print(descriptionFactory)

// 2 - Create a T-shirt structure that has size, color and material options. Provide methods to calculate the cost of a shirt based on its attributes.

struct TShirt {
    let size: String
    let color: String
    let material: String
    
    func cost(shirt: TShirt) -> Double {
        var price = 0.0
        
        switch shirt.size {
        case "small", "medium", "large" :
            price = 10.0
        case "xlarge":
            price = 11.0
        case "xxlarge":
            price = 12.0
        default:
            print("Special size")
            price = 15.0
        }
        
        switch shirt.material {
        case "cotton", "polyester":
            price += 10.0
        case "linen":
            price += 12.0
        default:
            print("Special material")
            price += 15.0
        }
        
        return price
    }
}

var myShirt = TShirt(size: "large", color: "red", material: "cotton")
myShirt.cost(shirt: myShirt)

/* 3 - Write the engine for a Battleship-like game. If you aren’t familiar with Battleship, see here: http://bit.ly/2nT3JBU
 
 Use an (x, y) coordinate system for your locations and model using a structure.
 
 Ships should also be modeled with structures. Record an origin, direction and length.
 
 Each ship should be able to report if a “shot” has resulted in a “hit”.

*/

// Rules: Use x: 15, y: 15 coordinates
// Direction must be horizontal or vertical from origin

struct shipLocation {
    let x: Int
    let y: Int
}

struct Battleship {
    let origin: shipLocation
    let direction: String
    let length: Int
    
    func wasHit(coordinates: shipLocation) {
        let posX = coordinates.x
        let posY = coordinates.y
        
        switch direction {
        case "vertical":
            if posX == origin.x && (posY >= origin.y && posY < origin.y + length) {
                print("Was hit!")
            } else { print("miss!") }
        case "horizontal":
            if posY == origin.y && (posX >= origin.x && posX < origin.x + length) {
                print("Was hit!")
            } else { print("miss!") }
        default:
            print("Error")
        }
    }
}

let carrier = Battleship(origin: shipLocation(x: 3, y: 1), direction: "horizontal", length: 5)
let battleship = Battleship(origin: shipLocation(x: 10, y: 9), direction: "vertical", length: 4)
let cruiser = Battleship(origin: shipLocation(x: 2, y: 6), direction: "vertical", length: 3)
let submarine = Battleship(origin: shipLocation(x: 5, y: 7), direction: "horizontal", length: 3)
let destroyer = Battleship(origin: shipLocation(x: 12, y: 12), direction: "horizontal", length: 2)

var ships = [carrier, battleship, cruiser, submarine, destroyer]

func playGame(shoot: shipLocation) {
    
    for ship in ships {
        ship.wasHit(coordinates: shoot)
    }
}

playGame(shoot: shipLocation(x: 3, y: 1))

