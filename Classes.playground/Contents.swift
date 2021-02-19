import UIKit

/*  Content:
        
     1 - Creating classes
     2 - Reference types
     3 - The heap vs stack
     4 - Working with references
     5 - Object identity
     6 - Methods and mutability
     7 - Mutability and constants
     8 - Understanding state and side effect
     9 - Extending a class using an extension
     10 - When to use a class versus structs
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Classes are the reference types counterpart of value types structs.

// Usually structures are used to represent values, while classes are used to represent objects.


class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName =  lastName
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    static func memberOf(person: Person, group: [Person]) -> Bool {
        
        return group.contains {
            $0 === person
        }
    }
}

let andre = Person(firstName: "André", lastName: "Rodrigues de Jesus")

// Unlike structs, a class doesn't provide an automatic memberwise initializer. So you must provide one. If you forget to provide the compiler will flag it.


// Reference Types

// In Swift, an instance of structure is a immutable value whereas an instance of a class is a muttable object.

// Unlike structure, a class doesn't store an actual instance. It stores a reference to a location in memory that stores the instance.

// Example

class SimplePerson {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

var person = SimplePerson(name: "João Carrão")
var anotherPerson = person

// When you assign here one variable to another, both of them start to point to same place im memory, while in a struct the second variable would copy the value of the first one.

struct StructSimplePerson {
    let name: String
}

var joao = StructSimplePerson(name: "João Carrão")
var outroJoao = joao


// The heap vs the stack

// When you create a reference type such as class, the instance is stored in a region known as the heap. Instances of the value type are stored in a region called stack.

// The system uses the stack to stores anything on the immediate thread of execution, it's tightly managed and optimized by the CPU. When a fucnction creates a variable, the stack stores that variable and then destroys it whe nthe function exits. Since the stack is so strictly organized, it's very efficient, and thus quite fast.

// The system uses the heap to store instance of reference types. The heap is generally a large pool of memory from which the system can request and dynamically allocate blocks of memory. Lifetime is flexible and dynamic.

// The heap doesn't not automatically destroys it data like stack does. This make creating and removing data a slower process compare to the stack.

// When you create an instance of a class, your code requests a block of memory on the heap to store the instance itself.

// When you create an instance of a struct(that is not a part of a class), the instance itself is stored in the stack and the heap is never envolved.


// Working with References

// Reminder of how struct works:

struct Location {
    let x: Int
    let y: Int
}

struct DeliveryArea {
    let center: Location
    var range: Double
}

var area1 = DeliveryArea(center: Location(x: 2, y: 4), range: 2.5)

var area2 = area1
print(area1.range)
print(area2.range)

area1.range = 4.0
print(area1.range)
print(area2.range)

// Here area2 receives a copy of area1. When a new value is assign to area1, it only reflects in the area1 variable.

// Class example

var homeOwner = andre
print(homeOwner.firstName)
andre.firstName = "Dedé"
andre.firstName
homeOwner.firstName

// Both of the instances show the same result meaning they reference to the same place.

// In classes any change in one instance would affect anything holding a reference to others which reference to the same place. With structs you would have to update each copy individually.

// Mini - exercise

// Change the value of lastName on homeOwner, then try reading fullName on both john and homeOwner. What do you observe?

homeOwner.lastName = "Carlitos Brown"
andre.fullName
homeOwner.fullName

// Fullnames of both instances were changed.


// Object identity

// To verify if an object identity is equal to another, we use the === operator

andre === homeOwner

// Remember the == operator checks if a value is equal and the === if identity is equal. The last one compares if the memory address are the same for the instances.

let imposterAndre = Person(firstName: "Dedé", lastName: "Carlitos Brown")
andre === imposterAndre

// The assigment of new instance change the identity of object

homeOwner = imposterAndre
andre === homeOwner

homeOwner = andre
homeOwner === andre

// Example to find a true identity with various instances

var imposters = (0...100).map { _ in
    Person(firstName: "Dedé", lastName: "Carlitos Brown")
}

// Equality is not effective when you cannot identify by name alone

imposters.contains {
    $0.firstName == andre.firstName && $0.lastName == andre.lastName
}

// With identity operator

imposters.contains {
    $0 === andre
}

// Hiding the real one inside the imposters

imposters.insert(andre, at: Int.random(in: 0..<100))

// Checking again

imposters.contains {
    $0 === andre
}

// Taking of the real one from the imposter list and modify the value

if let indexOfAndre = imposters.firstIndex(where: { $0 === andre }) {
    imposters[indexOfAndre].lastName = "Rodrigues de Jesus"
}

andre.fullName

// Mini - exercises

/* Write a function memberOf(person: Person, group: [Person]) -> Bool that will return true if person can be found inside group, and false if it can not.

 Test it by creating two arrays of five Person objects for group and using john as the person. Put john in one of the arrays, but not in the other.
*/

let a = Person(firstName: "Ananias", lastName: "Abacaxi")
let b = Person(firstName: "Bananinha", lastName: "Banoffe")
let c = Person(firstName: "Cajuina", lastName: "Caju")
let l = Person(firstName: "Larangildo", lastName: "Orange")
let p = Person(firstName: "Pêra", lastName: "Maça")

let groupA = [a, b, c, l, p]
let groupB = [b, c, p, andre, l]

Person.memberOf(person: andre, group: groupA)
Person.memberOf(person: andre, group: groupB)


// Method as mutability


// Instances of classes are mutable objects whereas instances of structures are immutable values.

struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    
    // Example to see state
    
    var credits = 0.0
    
    var gpa: Double {
        var totalPoints = 0.0
        var totalCredits = 0.0
        
        for grade in grades {
            totalPoints += grade.points
            totalCredits += grade.credits
        }
        return totalPoints / totalCredits
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
        credits += grade.credits
    }
}

let jane = Student(firstName: "Jane", lastName: "da Floresta")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
var math = Grade(letter: "A", points: 16.0, credits: 4.0)

jane.recordGrade(history)
jane.recordGrade(math)

// Note that recordGrade(_:) can mutate the array grades by adding more values to the end. Although this mutates the current object, the keyword mutating is not required.

// If you had tried this with a struct, you'd have wound up with a compiler error. That's because structs are immutable. When you change the value of a struct, instead of modifying it, actually you're making a new value.


// Mutability and constants

// In the last example even though you checked jane as a constant, you were able to modify.

// When you are working with reference types, the value is a reference. So in the jane example whats is a constant is the reference. If you try to change jane assigning a new instance of Student, the compiler would complain. But you can change its properties and methods.

// Whoever if you assign the instance of a class in a variable, you would be able to assign other instances with new references.

var peba = Student(firstName: "Peba", lastName: "Antonio")
var leon = Student(firstName: "Leon", lastName: "Marrom")
// jane = leon error
peba = leon

// When nothing is reference to a memory, in the example above peba is not reference where it used to, the memory is freed.

// Mini - exercise

/* Add a computed property to Student that returns the student’s Grade Point Average, or GPA. A GPA is defined as the number of points earned divided by the number of credits taken. For the example above, Jane earned (9 + 16 = 25) points while taking (3 + 4 = 7) credits, making her GPA (25 / 7 = 3.57).
 
*/

jane.gpa


// Understanding state and side effect

// If you update a class instance with a new value every reference to that instance will also see the new value. You can use this to your advantage. Perhaps you pass a Student instance to a sports team, a report card and a class roster. Imagine all of these entities need to know the student’s grades, and because they all point to the same instance, they’ll all see new grades as the instance records them.

// The result of this sharing is that class instance have state. Changes in state can sometimes be obvious, but often are not. Observe:

jane.credits

// The teacher made a mistake; math has 5 credits

math = Grade(letter: "A", points: 20.0, credits: 5.0)
jane.recordGrade(math)

// Should be 8 not 12
jane.credits

// Whoever wrote the modified Student class did so somewhat naïvely by assuming that the same grade won’t get recorded twice!

// Because class instances are mutable, you need to be careful about unexpected behavior around shared references.

// Extending a class using an extension

extension Student {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}


// When to use a class versus structs

// Values vs Objects

// Consider that every instance of a reference type have an identity meaning that every object is unique. No two objects are considered equal simply because they hold the same state. Hence, you use === to see if objects are truly equal and not just containing the same state.

// In contrast, instances of value type, which are values, are considered equal with they hold the same value.

/* “Speed considerations are a thing, as structs rely on the faster stack while classes rely on the slower heap. If you’ll have many more instances (hundreds and greater), or if these instances will only exist in memory for a short time — lean towards using a struct. If your instance will have a longer lifecycle in memory, or if you’ll create relatively few instances, then class instances on the heap shouldn’t create much overhead.”
 */

/* “If your data will never change or you need a simple data store, then use structures. If you need to update your data and you need it to contain logic to update its own state, then use classes. Often, it’s best to begin with a struct. If you need the added capabilities of a class sometime later, then you just convert the struct to a class.”
 
*/


// Challenges

/* 1 - Imagine you’re writing a movie-viewing app in Swift. Users can create lists of movies and share those lists with other users. Create a User and a List class that uses reference semantics to help maintain lists between users.
 
 User: Has a method addList(_:) that adds the given list to a dictionary of List objects (using the name as a key), and list(forName:) -> List? that returns the List for the provided name.
 
 List: Contains a name and an array of movie titles. A print method will print all the movies in the list.
 
 Create jane and john users and have them create and share lists. Have both jane and john modify the same list and call print from both users. Are all the changes reflected?
 What happens when you implement the same with structs? What problems do you run into?
*/

class List {
    let name: String
    var movieTitles: [String]
    
    init(name: String, movieTitles: [String]) {
        self.name = name
        self.movieTitles = movieTitles
    }
    
    func printMoviesInList() {
        print("Movies in \(self.name):")
        
        for movie in movieTitles {
            print(" - \(movie)")
        }
    }
}

class User {
    var listsOfList: [String : List] = [:]
    
    func addList(list: List) {
        listsOfList.updateValue(list, forKey: list.name)
    }
    
    func list(for name: String) -> List? {
        let verifyList = listsOfList.contains {
            $0.key == name
        }
        
        guard verifyList else {
            return nil
        }
        
        return listsOfList[name]
    }
}

let listA = List(name: "list A", movieTitles: ["Coco", "Forrest Gump", "Pretty Woman", "Independence Day"])

listA.printMoviesInList()

let andrerj = User()
let jana = User()

andrerj.addList(list: listA)
jana.addList(list: listA)

// Add Andre last movie seen

andrerj.listsOfList["list A"]?.movieTitles.append("Rambo")
andrerj.listsOfList["list A"]?.movieTitles.append("Terminator")

// Add Jana last movie seen

jana.listsOfList["list A"]?.movieTitles.append("Die Hard")

// Check list from both users

andrerj.listsOfList["list A"]?.printMoviesInList()
jana.listsOfList["list A"]?.printMoviesInList()

// If you try to recreate the same code above with a structure, Jana's list and Andre's list woul be different because their values are not shared, instead the values are only copied at that moment. In the case above jana would't see Rambo and Terminator and andre wouldn't see Die Hard in the list.

/* 2 - Your challenge here is to build a set of objects to support a T-shirt store. Decide if each object should be a class or a struct, and why.
 
 TShirt: Represents a shirt style you can buy. Each TShirt has a size, color, price, and an optional image on the front.
 
 User: A registered user of the t-shirt store app. A user has a name, email, and a ShoppingCart (see below).
 
 Address: Represents a shipping address and contains the name, street, city, and zip code.
 ShoppingCart: Holds a current order, which is composed of an array of TShirt that the User wants to buy, as well as a method to calculate the total cost. Additionally, there is an Address that represents where the order will be shipped.
*/

struct TShirt {
    let size: String
    let color: String
    let price: Double
    let optionalImage: String
}

class UserTShirt {
    let name: String
    let email: String
    let shoopingCart: ShoppingCart = ShoppingCart()
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

struct Address {
    let name: String
    let street: String
    let city: String
    let zipCode: Int
    
}

class ShoppingCart {
    var currentOrder: [TShirt] = []
    var addressToship: Address = Address(name: "", street: "", city: "", zipCode: 000000)
    
    func totalCost() {
        var totalTshirts = 0.0
        
        for tshirt in currentOrder {
            totalTshirts += tshirt.price
        }
        print(totalTshirts)
    }
}

let tshirt1 = TShirt(size: "G", color: "Black", price: 14.99, optionalImage: "Skate")
let tshirt2 = TShirt(size: "G", color: "White", price: 18.99, optionalImage: "Flower")
let tshirt3 = TShirt(size: "GG", color: "Blue", price: 21.99, optionalImage: "Sun")

let andrerjao = UserTShirt(name: "André Rodrigues", email: "andrerj@mail.com")

let myAddress = Address(name: "Avenue", street: "Senator Batist", city: "São Bernardo", zipCode: 00000000)

let myOrder = ShoppingCart()
myOrder.currentOrder.append(tshirt1)
myOrder.currentOrder.append(tshirt2)
myOrder.currentOrder.append(tshirt3)
myOrder.addressToship = myAddress

myOrder.totalCost()
