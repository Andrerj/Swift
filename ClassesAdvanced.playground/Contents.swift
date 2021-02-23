import UIKit

/*  Content:
        
     1 - Introducing Inheritance
     2 - Polymorphism
     3 - Runtime hierarchy checks
     4 - Inheritance, methods and override
     5 - Introducing super
     6 - Preventing inheritance
     7 - Inheritance and class initialiation
     8 - Two-phase initialization
     9 - Required and convenience initializers
     10 - When and why to subclass
     11 - Shared base classes
     12 - Understanding the class lifecycle
     13 - Retain cycles and weak references
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    deinit {
        print("\(firstName) \(lastName) is being  removed from memory!")
    }
}

//class Student {
//    var firstName: String
//    var lastName: String
//    var grades: [Grade] = []
//
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    func recordGrade(grade: Grade) {
//        grades.append(grade)
//    }
//}

// The example above is a redundance of classes because Student is a person, and share some of features. The example above can be solved with the use of Inheritance.

// Student's example with inheritance

class Student: Person {
    var grades: [Grade] = []
    weak var partner: Student?
    
    func recordGrade(grade: Grade) {
        grades.append(grade)
    }
    
    deinit {
        print("\(firstName) is being deallocated")
    }
}

// Through inheritance, an instance from Student automatically gets all the properties from Person.

let andre = Student(firstName: "André", lastName: "Rodrigues")
let ana = Person(firstName: "Ana", lastName: "Banana")

andre.firstName
ana.firstName

// Additionally, only the Student object will have all of properties and methods defined in Student

let history = Grade(letter: "B", points: 9.0, credits: 3.0)
andre.recordGrade(grade: history)

// A class that inherits from another class is known as subclass or a derived class, and the class from which it inherits is known as superclass or base class.

/* Rules for subclass:

 - A Swift class can only inherits from only one other class, a concept known as single inheritance.
 
 - There's no limit to depth of subclassing, meaning you can subclass from a class that is also a subclass
 */

// Example of subclassing from a subclass

class BandMember: Student {
    var minimumPracticeTime = 2
}

class OboePlayer: BandMember {
    // Example of override
    
    override var minimumPracticeTime: Int {
        get {
            super.minimumPracticeTime
        }
        set {
            super.minimumPracticeTime = newValue / 2
        }
    }
}

// A chain of classes are known as class hierarchy. In this example it would be OboePlayer -> BandMember -> Student -> Person

// A class hierarchy is analogous to a family tree. Because of this analogy, a superclass is also called the parent class of its child class.


// Polymorphism

// The student/person relationship demonstrates a computer science known as polymorphism. In brief, it is a programming language's ability to treat an object differently based on context.

// Example: A OboePlayer is a Oboeplayer, but it's also a Person. Because it derives from Person, you could use a Oboeplayer object anywhere you'd use a Person object.

// Example of polymorphism

func phoneBookName(person: Person) -> String {
    "\(person.lastName), \(person.firstName)"
}

let person = Person(firstName: "Persona", lastName: "Ingrata")
let oboePlayer = OboePlayer(firstName: "João", lastName: "Bobão")

phoneBookName(person: person)
phoneBookName(person: oboePlayer)

// The function has no idea that the object passed in is anything other than the regular Person.


// Runtime hierarchy checks

// With polymorphism you can find situations where the specific type behind a value can be different.

var hallMonitor = Student(firstName: "Monica", lastName: "Tonica")
hallMonitor = oboePlayer

// Because hallMonitor was defined as a Student, the compiler won't allow you to attempt calling properties and methods for a more derived type.

// In the case above even though oboePlayer was assigned to hallMonitor, you can't see properties from a OboePlayer only from Student class.

// Also Swift provides the keyword as to treat a property or a variable as another type

// as: Cast to a specific type that is known at compile time to suceed, such as casting to a supertype.

// as?: An optional downcast(to a subtype). If the downcast fails, the return wil be nil

// as!: A forced downcast. It it fails the program will crash.

// This as forms can be used in various contexts to treat hallMonitor as a BandMember or the oboePlayer as a Student

oboePlayer as Student
// (oboePlayer as Student).minimumPracticeTime ERROR

hallMonitor as? BandMember
(hallMonitor as? BandMember)?.minimumPracticeTime

(hallMonitor as! BandMember).minimumPracticeTime

// The as? option is particularly useful in if let or guard statements

if let hallMonitor = hallMonitor as? BandMember {
    print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime) hours per week.")
}

// You may be wondering under what contexts you would use the as operator by itself. Any object contains all the properties and methods of its parent class, so what use is casting it to something it already is?

// Swift has a strong type system, and the interpretation of a specific type can have an effect on static dispatch., aka the processof deciding of which operation to use at compile time.


// Assume you have two functions with identical names and parameter names for two different parameter types:

func afterClassActivity(for student: Student) -> String {
    "Goes Home!"
}

func afterClassActivity(for student: BandMember) -> String {
    "Goes to practice!"
}

// If you were to pass the oboePlayer to the implementation above, the Swift's dispatch rules will select the more specific version that takes in an OboePlayer.

// If instead you were to cast oboePlayer to a Student, the Student version would be used.

afterClassActivity(for: oboePlayer)
afterClassActivity(for: oboePlayer as Student)


// Inheritance, methods and override

// Subclasses receive all properties and methods defined in their superclass, plus additional properties and methods the subclass defines for itself.

// Besides creating their own methods subclasses can override methods defined in its superclass.

// Example: Assume that students athletes become ineligible for the athletics program if they're failing three or more classes.

class StudentAthlete: Student {
    var failedClasses: [Grade] = []
    
    override func recordGrade(grade: Grade) {
        super.recordGrade(grade: grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligble: Bool {
        failedClasses.count < 3
    }
}

// If your subclass were to have an identical method declaration as its superclass, but you ommited the override keyword, the compiler will complain.


// Introducing super

// The super keyword is similar to self, except it will invoke the method in the nearest implementing superclass

// In the example above, the method will be executed as defined in the Student superclass before you can use the rest of AthleteStudent class.

// Although it isn’t always required, it’s often important to call super when overriding a method in Swift. The super call is what will record the grade itself in the grades array, because that behavior isn’t duplicated in StudentAthlete. Calling super is also a way of avoiding the need for duplicate code in StudentAthlete and Student.

// It's the best practice to call the super version of a method first when overriding.


// Preventing Inheritance

// Sometimes you want to disallow subclasses  of a particular class. Swift provides the final keyword to guarantee a class will never get a subclass

final class FinalStudent: Person {
    
}

// class FinalAthleteStudent: FinalStudent {} ERROR

// Additionally you can mark methods as final, if you want to allow a class to have subclasses but protect individual methods from overriden.

class AnotherStudent: Person {
    final func recordGrade(grade: Grade) {}
}

class AnotherAthleteStudent: AnotherStudent {
//    override func recordGrade(grade: Grade) {} ERROR
}

// There are benefits to initially marking any new class with final. This tell the compiler it doesn't need to look for subclasses.


// Inheritance and class initialization

// The two classes below are the same as Student and StudentAthelete. Only here to separate concepts learned

class NewStudent {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    static var graduates: [String] = []
    
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Other to initialize the object
    
    convenience init(transfer: Student) {
        self.init(firstName: transfer.firstName,
                      lastName: transfer.lastName)
    }
    
    func recordGrade(grade: Grade) {
        grades.append(grade)
    }
    
    deinit {
        print("Congratulations! \(firstName) \(lastName) finally graduated!")
        NewStudent.graduates.append("\(firstName) \(lastName)")
    }
}

class NewStudentAthlete: NewStudent {
    var sports: [String]
    var failedClasses: [Grade] = []
    
    // New Code
    
    // Code which automatically get a starter grade for NewStudentAthlete instance
    
    init(firstName: String, lastName: String, sports: [String]) {
        self.sports = sports //1
        let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0) //2
        super.init(firstName: firstName, lastName: lastName) //3
        recordGrade(grade: passGrade) //4
    }
    
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
    
    // Old code
    
    override func recordGrade(grade: Grade) {
        super.recordGrade(grade: grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligble: Bool {
        failedClasses.count < 3
    }
}

// The init above didn't work with the new initializer. Initializers are required to call super.init because without it, the superclass won't be able to provide initial states for all stored properties. In this case, firstName and lastName

// For that we call the super.init


// Two-phase initialization

// Because of Swift's requirement that all stored properties have initial values, initializers in subclasses must adhere to Swift's convention of two-phase initialization

// Phase one: Initializer all of properties in the class instance, from the bottom to the top of the class hierachy. You can't use properties and methods until phase one is complete.

// Phase two: You can now use properties and methods, as well as initializations that require the use of self.


// The New Code in the NewStudentAthlete class show the two phase initialization

// 1 - Initialize the sports property. This is part of of the first phase of initialization and has to be done early, before you call the superclass initializer.

// 2 - Although you can create local variables for things like grades, you can’t call recordGrade(_:) yet because the object is still in the first phase.

// 3 - Call super.init. When this returns, you know that you’ve also initialized every class in the hierarchy, because the same rules are applied at every level.

// 4 - After super.init returns, the initializer is in phase 2, so you call recordGrade(_:)

let athlete = NewStudentAthlete(firstName: "Zeca", lastName: "Urubu", sports: ["Basketball"])

athlete.grades

// Mini - exercises

// What’s different in the two-phase initialization in the base class Person, as compared to the others?

// Answer: You don't need to call or worry about super in the base class


// Required and convenience initializers

// You can have multiple initializers in a class, which means you could potentially call any of those initializers from a subclass.

// When you use the required keyword before an initializer, you're saying that all subclasses from the class you're must provide the required initializer.

// You can also use the keyword convenience before an initializer. The compiler forces a convenience initializer to call a non-convenience initializer (directly or indirectly), instead of handling the initialization of stored properties itself. A non-convenience initializer is called a designated initializer and is subject to the rules of two-phase initialization. All initializers you’ve written in previous examples were in fact designated initializers.

// You might want to mark an initializer as convenience if you only use that initializer as an easy way to initialize an object, but you still want it to leverage one of your designated initializers.

/* Summary of the compiler rules for using designated and convenience initializers:
 
 1 - A designated initializer must call a designated initializer from its immediate superclass.
 
 2 - A convenience initializer must call another initializer from the same class.
 
 3 - A convenience initializer must ultimately call a designated initializer.
 */


// When and why to subclass

// Single responsability

// In software development, the guideline known as the single responsibility principle states that any class should have a single concern. In Student/StudentAthlete, you might argue that it shouldn’t be the Student class’s job to encapsulate responsibilities that only make sense to student athletes.


// Strong types

// Subclassing creates an additional type. Which mean you can create an instance from the subclass type

class Team {
    var players: [NewStudentAthlete] = []
    
    var isEligible: Bool {
        for player in players {
            if !player.isEligble {
                return false
            }
        }
        return true
    }
}

// A team has players who are student athletes. If you tried to add a regular Student object to the array of players, the type system wouldn’t allow it. This can be useful as the compiler can help you enforce the logic and requirement of your system.


// Shared base class

// You can subclass a shared base class multiple times by classes that have mutually exclusive behaviour

// A button that can be pressed.
class Button {
    func press() {}
}

// An image that can be rendered on a button
class Image {}

// A button that is composed entirely of an image.
class ImageButton: Button {
    var image: Image
    
    init(image: Image) {
        self.image = image
    }
}

// A button that renders as text.

class TextButton: Button {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

/* In this example, you can imagine numerous Button subclasses that share only the fact that they can be pressed. The ImageButton and TextButton classes likely use different mechanisms to render a given button, so they might have to implement their own behavior to handle presses.
 
 You can see here how storing image and text in the Button class — not to mention any other kind of button there might be — would quickly become impractical. It makes sense for Button to be concerned with the press behavior, and the subclasses to handle the actual look and feel of the button.
 */


// Extensibility

/* Sometimes you need to extend the behavior of code you don’t own. In the example above, it’s possible Button is part of a framework you’re using, so there’s no way you can modify or extend the source code to fit your specific case.
 
 But you can subclass Button and add your custom subclass to use with code that’s expecting an object of type Button.

 */


// Understandind the class lifecycle

// The objects from classes are created and stored on the heap, unlike objects from the structs which are stored on the stack, and are not automatically destroyed from it. Without the utility of call stack, there's no automatic way of a process to know that a piece of memory will no longer be in use.

// In Swift the mechanism for deciding when to clean up unused object on the heap is known as reference counting. In short, each object has a reference count that is incremented for each constant or variable with a reference to that object, and decremented each time a reference is removed.

// When a reference count reaches zero, that means that object can be removed. Example

var someone = Person(firstName: "Gio", lastName: "Batata")
// Person object has a reference count of 1

var anotherSomeone: Person? = someone
// Person object has a reference count of 2

var lotsOfPeople = [someone, someone, anotherSomeone, someone]
// Person object has a reference count of 6

anotherSomeone = nil
// Person object has a reference count of 5

lotsOfPeople = []
// Person object has a reference count of 1

// Now we create another object and and replace someone with that reference.

someone = Person(firstName: "Johny", lastName: "Maça")

// Reference count 0 for the original Person object
// Variable someone now references a new object

// In the example above, we don't have to do any work because Swift has a feature known as Automatic Reference Counting or ARC.

// Note: In low-level languagues like C, you must clean up the memory by yourself. While in high-level languages like C# or Java, there is something called garbage collection similar to what Arc does.


// A deinitializer is a special method on classes that runs when an object's reference count reachs 0, but before Swift removes the object from memory. Example in class Person

// The method above is really useful to check if an object has any reference in memory

// Mini - exercise

// Modify the Student class to have the ability to record the student’s name to a list of graduates. Add the name of the student to the list when the object is deallocated.

var firstGraduate = NewStudent(firstName: "Flavia", lastName: "Cebola")
var secondGraduate = NewStudent(firstName: "Leo", lastName: "Repolho")

var impostor = NewStudent(firstName: "Caio", lastName: "Arroz")

firstGraduate = impostor
secondGraduate = impostor

print(NewStudent.graduates)


// Retain cycles and weak references

// Because classes in Swift rely on reference counting to remove them from memory, it’s important to understand the concept of a retain cycle.

var alice: Student? = Student(firstName: "Alice", lastName: "Morango")
var bob: Student? = Student(firstName: "Bob", lastName: "Uva")

alice?.partner = bob
bob?.partner = alice

// Suppose that both Bob and Alice drop school

alice = nil
bob = nil

// If you run the code above, you'll notice that Swift doesn't call deinit method with the message Alice/Bob is being deallocated.

// What happens above is that Alice and Bob has a reference to each other, so the reference count can never reaches zero. To make things worse, by assigning nil for them there aare no more references to the initial objects.

// This is a classic case of a retain cycle, which leads to a software bug known as a memory leak.

// With a memory leak, memory isn’t freed up even though its practical lifecycle has ended. Retain cycles are the most common cause of memory leaks. Fortunately, there’s a way that the Student object can reference another Student without being prone to retain cycles, and that’s by making the reference weak.

// This simple modification marks the partner variable as weak, which means the reference in this variable will not take part in reference counting. When a reference isn’t weak, it’s called a strong reference, which is the default in Swift. Weak references must be declared as optional types so that when the object that they are referencing is released, it automatically becomes nil.


// Challenges

// 1 - Create three simple classes called A, B, and C where C inherits from B and B inherits from A. In each class initializer, call print("I’m <X>!") both before and after super.init(). Create an instance of C called c. What order do you see each print() called in?

class A {
    init() {
        print("I'm A")
    }
    
    deinit {
        print("A is being deallocated")
    }
}

class B: A {
    override init() {
        print("I'm B")
        super.init()
        print("I'm B")
    }
    
    deinit {
        print("B is being deallocated")
    }
}

class C: B {
    override init() {
        print("I'm C")
        super.init()
        print("I'm C")
    }
    
    deinit {
        print("C is being deallocated")
    }
}

let c = C()

// My Guess -> C - B - A - B - C
// Answer -> C - B - A - B - C

// 2 - Implement deinit for each class. Create your instance c inside of a do { } scope which will cause the reference count to go to zero when it exits the scope. Which order are the classes deinitialized in?

do {
    _ = C()
}

// My Guess -> C - B - A
// Answer -> C - B - A

// 3 - Cast the instance of type C to an instance of type A. Which casting operation do you use and why?

let c3 = c as A

// The casting operation used is with as keyword only, because A is a superclass from C, so it's not possible to be nil

// 4 - Create a subclass of StudentAthlete called StudentBaseballPlayer and include properties for position, number, and battingAverage. What are the benefits and drawbacks of subclassing StudentAthlete in this scenario?

class NewStudentBaseballPlayer: NewStudentAthlete {
    var position: String
    var number: Int
    var battingAverage: Double = 0.0
    
    required init(firstName: String, lastName: String) {
        fatalError("init(firstName:lastName:) has not been implemented")
    }
    
    init(firstName: String, lastName: String, position: String, number: Int) {
        self.position = position
        self.number = number
        super.init(firstName: firstName, lastName: lastName)
    }
    
}

/*
 Benefits:
     - receive automatically all the properties its superclasses have.
 
 Drawback:
    - initializers starting to be messy
    - some properties can be a little weird to a subclass. Like sports to a NewStudentBaseballPlayer.
 */
