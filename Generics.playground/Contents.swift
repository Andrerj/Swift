import UIKit

/*  Content:
        
     1 - Introducing generics
     2 - Values defined by other values and types
     3 - Anatomy of generic types
     4 - Type constraints
     5 - Arrays
     6 - Dictionaries
     7 - Optionals
     8 - Generic function as parameters
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Everytime you use an array, you actually are using generics.

// In a example modeling pets and theirs keepers, you could do this using different values for each or differents types. Using types, the Swift type checker can reason about your code at compile time. Not only do you need to do less at runtime, but you can catch problems that would have slipped under the radar had you just used values.


// Values defined by other values

// Model of a petshop running only dogs and cats

enum PetKind {
    case cat
    case dog
}

// Now, a model for the keepers

struct KeeperKind {
    var keeperOf: PetKind
}

// Initialize keepers

let catKeeper = KeeperKind(keeperOf: .cat)
let dogKeeper = KeeperKind(keeperOf: .dog)

// There are two points to observe in this model

// First, you're representing the different kinds of pets and keepers by varying the the values of types. There’s only one type for pet kinds — PetKind — and one type for keeper kinds — KeeperKind. Different kinds of pets are represented only by distinct values of the PetKind type, just as different kinds of keepers are represented by distinct values of the KeeperKind type.

// Second, one range of possible values, determines another range of the values. Specifically, the range of possible KeeperKind values mirrors the range of possible PetKind values.

// If you need to add another type you simply create a new case in the enumeration and uses it to create a new keeper.

// In contrast to the example above, you could have defined a second unrelated enumeration instead of KeeperKind:

enum EnumKeeperKind {
    case catKeeper
    case dogKeeper
}

// Using the enum above, nothing would enforce the relationship seen in the example before, except your diligence in always updating one type to mirror the other. If you added PetKind.snake but forgot to add EnumKeeperKind.snakeKeeper, then things would get out of whack.

// But with KeeperKind, you explicitly established a relationship via the property of type PetKind. Every PetKind value implies a corresponding a KeeperKind Value.


// Types defined by other types

// The type above basically works by varying the values of types. You can defining by varying the types.

// Instead of defining a single type for dogs and cats, you define a single typle for each one.

class Cat: Pet {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
class Dog: Pet {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// If you thought to create a class Keeper for each one, them you would have the same problem as before with enumKeeperKind.

// What you'd like is to establish the same relationship as the ones defined in values defined by other values, but without doing that automatically. For that, generics are used.


// Anatomy of generic types

// Generics provide a mechanism for using one set of types to define a new set of types.

// In the example before, you could define a generic type for Keeper like so

class Keeper<Animal> {
    var name: String
    var morningCare: Animal
    var afternoonCare: Animal
    
    init(name: String, morningCare: Animal, afternoonCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.afternoonCare = afternoonCare
    }
}

// This definition immediately defines all the corresponding keeper types like this: Keeper<Cat> and Keeper<Dog>

// To verify these types are real you can create values of them, specifying the entire type in the initializer

// var aCat = Keeper<Cat>() - Before the inclusion of properties

// First, Keeper is a generic type. But you can say generic is not a type at all, rather it is a recipe for making real types or concrete types.

// On error to examplify the sentence above is if you try to create an instance of Keeper only, the compiler would complain

// var aKeeper = Keeper() ERROR

// The compiler complains because it doesn't know the type you want. That Animal, is the type parameter of Keeper

// Keeper<Cat> and Keeper<Dog> are different types even tough the generic is the same, this is known as the specialization of the generic type.

// You just need to choose the name of generics and its type to define a generics. It is good practice to choose a parameter type related to the generic name.

// In one stroke, the generic type Keeper<Animal> define a family of new types.


// Using the types parameters

// The keepers is specialized in only one type of animals dog or cat. But in general he is a keeper of animal, so the property must be from the type Animal.

 
let andreKeeper = Keeper<Cat>(name: "André", morningCare: Cat(name: "Whiskas"), afternoonCare: Cat(name: "Felix"))

// Mini - exercises

// 1 - Try instantiating another Keeper but this time for dogs.

let joseKeeper = Keeper<Dog>(name: "Jose", morningCare: Dog(name: "Costela"), afternoonCare: Dog(name: "Nina"))

// 2 - What do you think would happen if you tried to instantiate a Keeper with a dog in the morning and a cat in the afternoon?

// The compiler would complain about the specialization of type.

// 3 - What happens if you try to instantiate a Keeper, but for strings?

let keep = Keeper<String>(name: "Keep", morningCare: "George", afternoonCare: "Sif")

// The compiler will accept the generic type with String specialization.


// Type Constraints

// In your definition of Keeper, the identifier Animal serves as a type parameter, which is a named placeholder for some actual type that will be supplied later. This is much like the parameter cat in a simple function like func feed(cat: Cat) { /* open can, etc... */ }. But when calling this function, you can’t simply pass any argument to the function. You can only pass values of type Cat.

// At present, you could offer any type at all as the kept Animal, even something nonsensically unlike an animal, like a String or Int.

// This is no good. What you’d like is something analogous to a function, something where you can restrict what kinds of types are allowed to fill the type parameter. In Swift, you do this with various kinds of type constraints.

// Type constraint applied directly to a type parameter

class AnotherKeeper<Animal: Pet> {
    
}

//  Here, the constraint : Pet requires that the type assigned to Animal must be a subclass of Pet, if Pet is a class, or must implement the Pet protocol, if Pet is a protocol.

protocol Pet {
    var name: String { get }
}

class AnotherCat: Pet {
    var name: String = ""
}


// You can define this contraint directly to the class(like above) or using extensions to the type. This last kind of implementation is known as retro-actively model

class AnotherDog {}

extension AnotherDog: Pet {
    var name: String {
        ""
    }
}

// The other, more complex and general kind of type constraint uses a generic where clause. This clause can constrain type parameters as well as associated types.

/* Furthermore, you can attach this where clause to extensions as well. To demonstrate this, suppose you want all Cat arrays to support the method meow().
 
 You can use an extension to specify that when the array’s Element is a Cat the array provides meow():”
*/

extension Array where Element: Cat {
    func meow() {
        forEach {
            print("\($0.name) says meow!")
        }
    }
}

let cat1 = Cat(name: "Whiskas")
let cat2 = Cat(name: "Farinha")
let cats: [Cat] = [cat1, cat2]
cats.meow()

// You can specify that a type should conform to some protocol only if it meets certain constraints.

// Suppose that anything that can meow is Meowable. You could write that every Array is Meowable if its elements are

protocol Meowable {
    func meow()
}

extension Cat: Meowable {
    func meow() {
        print("\(self.name) says meow!")
    }
}

extension Array: Meowable where Element: Meowable {
    func meow() {
        forEach { $0.meow() }
    }
}

let dog = Dog(name: "Boss")
let animals: [Pet] = [cat1, cat2, dog]

cats.meow()
// animals.meow() - The method meow won't appear

// This is called conditional conformance, a subtle but powerful mechanism of composition.



// Arrays

// While the original Keeper type illustrates that a generic type doesn’t need to store anything or use its type parameter, the most common example of a generic type does both. This is, of course, the Array type.

// The need of generic arrays was part of the original motivation to invent generic types. Since many programs need arrays which are homogenenous, generic arrays make all the code safer.

// You've been using Array all along, but only with sintatic sugar: [Element] instead of Array<Element>.

// Array declared

let animalAges: [Int] = [2,5,7,9]

// This equivalent to

let animalAge: Array<Int> = [2, 5, 7, 9]

// Array<Element> and [Element] are exactly interchangeable. So you could even call an array's default initializer by writing [Int]() instead of Array<Int>().


// Dictionaries

// Swift generics allow for multiple type parameters and for complex sets of restrictions on them. These let you use generic types and protocols with associated types to model complex algorithms and data structures. A Dictionary is a straightforward example of this.

// Dictionary has two type parameters in the comma-separated generic parameter list that falls between the angle brackets

// struct Dictionary<Key: Hashable, Value> {}

// The type constraint Key:Hashable require that any type serving as the key for the dictionary be hashable

// To instantiate types such as Dictionary with multiple types, simply provide a comma-separated type argument list

let intNames: Dictionary<Int, String> = [42: "forty-two"]


// Optionals

// Optionals are implemented as enumerations but they're also just another generic type, which you could have defined yourself.

// Example

enum OptionalDate {
    case none
    case some(Date)
}

enum OptionalString {
    case none
    case some(String)
}

struct FormResults {
    var birthday: OptionalDate
    var lastName: OptionalString
}

// If you found yourself doing this job extensively, then at some point you could generalize this in a generic type that represented the concept of “a value of a certain type that might be present”

enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

// At this point, you would have reproduced Swift’s own Optional<Wrapped> type, since this is quite close to the definition in the Swift standard library! It turns out, Optional<Wrapped> is close to being a plain old generic type, like one you could write yourself.

// Why “close”? It would only be a plain old generic type if you interacted with optionals only by writing out their full types, like so:

var birthDate: Optional<Date> = .none

// But it's more common and convetional to write the sintatic sugar version

var birth: Date? = nil


// Generic functions as parameters

// Functions can be generic as well. A function's type parameter list comes after the function name. You can then use generic parameters in the rest of definition.

func swapped<T, U>(_ x: T, _ y: U) -> (U, T) {
    (y, x)
}

swapped(35, "José")


// Challenges

/* Consider the pet and keeper example from earlier in the chapter:
 
 class Cat {
   var name: String

   init(name: String) {
     self.name = name
   }
 }

 class Dog {
   var name: String

   init(name: String) {
     self.name = name
   }
 }

 class Keeper<Animal> {
   var name: String
   var morningCare: Animal
   var afternoonCare: Animal

   init(name: String, morningCare: Animal, afternoonCare: Animal) {
     self.name = name
     self.morningCare = morningCare
     self.afternoonCare = afternoonCare
   }
 }
 
 Imagine that instead of looking after only two animals, every keeper looks after a changing number of animals throughout the day. It could be one, two, or ten animals per keeper instead of just morning and afternoon ones. You’d have to do things like the following:
 
 let christine = Keeper<Cat>(name: "Christine")

 christine.lookAfter(someCat)
 christine.lookAfter(anotherCat)

 You’d want to be able to access the count of all of animals for a keeper like christine.countAnimals and to access the 51st animal via a zero-based index like christine.animalAtIndex(50).

 Of course, you’re describing your old friend the array type, Array<Element>!
 
 Your challenge is to update the Keeper type to have this kind of interface. You’ll probably want to include a private array inside Keeper, and then provide methods and properties on Keeper to allow outside access to the array.
 
*/

class TheCat: Pet {
  var name: String

  init(name: String) {
    self.name = name
  }
}

class TheDog: Pet {
  var name: String

  init(name: String) {
    self.name = name
  }
}

class TheBird: Pet {
  var name: String

  init(name: String) {
    self.name = name
  }
}

class ThePig: Pet {
  var name: String

  init(name: String) {
    self.name = name
  }
}

class TheKeeper<Animal> {
    var name: String
    var animals: [Animal] = []

    init(name: String) {
        self.name = name
    }
    
    func lookAfter(_ animal: Animal) {
        animals.append(animal)
    }
    
    func animalAtIndex(_ index: Int) -> Animal {
        animals[index]
    }
}

let andreTheKeeper = TheKeeper<Pet>(name: "André Rodrigues de Jesus")

let costela = TheDog(name: "Costela")
let whiskas = TheCat(name: "Whiskas")
let piupiu = TheBird(name: "Piupiu")
let picapau = TheBird(name: "Picapau")
let babe = ThePig(name: "Babe")

andreTheKeeper.lookAfter(costela)
andreTheKeeper.lookAfter(whiskas)
andreTheKeeper.lookAfter(piupiu)
andreTheKeeper.lookAfter(picapau)
andreTheKeeper.lookAfter(babe)

andreTheKeeper.animals.count
let pet = andreTheKeeper.animalAtIndex(3)
print(pet.name)
