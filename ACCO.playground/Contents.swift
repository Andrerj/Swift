import UIKit
import XCTest

/*  Content:
        
     1 - Problems introduced by lack of access control
     2 - Access modifiers types
     3 - Organizing code in extensions
     4 - Extension by behavior/ by conformance
     5 - available()
     6 - Opaque return methods
     7 - Swift Package Manager
     8 - Testing
     9 - Making things @testable
     10 - The setUp and tearDown methods
 
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Access Control, Code Organization and Testing

// The Swift types can be declared with properties, methods, initializers and other nested types. These elements can be thought as the interface to your code and is sometimes referred as the API(Application Program Interface).
 
// As code grows in complexity is important to control it and keep track of the internal states. The access control allows you to control the viewable interface of your code.

// Access control lets you the library author, hide implementation complexity for uses. This hidden state is sometimes referred as the invariant, which your public interface should always mantain.

// Preventing direct access to the internal state of a model and maintaining the invariant is a fundamental software design concept known as encapsulation.


//Problems Introduced by lack of access control

// Example:

/// Protocol describing core functionality of a Bank Account
//protocol Account {
//    associatedtype Currency
//
//    var balance: Currency { get }
//    func deposit(amount: Currency)
//    func withdraw(amount: Currency)
//}
//
//// conforming to the protocol
//
//typealias Dollars = Double
//
///// A U.S. Dollar based "basic" account.
//
//class BasicAccount: Account {
//    private(set) var balance: Dollars = 0.0
//
//    func deposit(amount: Dollars) {
//        balance += amount
//    }
//
//    func withdraw(amount: Dollars) {
//        if amount <= balance { balance -= amount } else { balance = 0 }
//    }
//}

// Altough this code is straightforward, it has a slight issue. The balance property is designed to be a read-only property, it only has get defined.

// However the implementation of BasicAccount requires balance to be declared as a variable so that value can be update when funds are deposited or withdraw.

// Nothing can prevent other codes from directly assigning new values for balance.

//let account = BasicAccount()

// Deposit and withdraw some money
//account.deposit(amount: 10.00)
//account.withdraw(amount: 5.00)

// Or do evil things
//account.balance = 1000000


// Note access control is not a feature to prevent against malicious hackers, rather it helps you to to express intent by generating compiler' errors if a user try to implement code directly.


// Introducing access control

// You can add access modifier by placing a modifier keyword in front of a property, method or type declaration

// Add private(set) before balance

// in the example above the set property from balance was made private. After that, the attempt to input a value directly won't be possible.


// Access modifiers types

// There are some types of access modifiers:

// private: Accesible only to the type and its nested types and extensions. Example: A property only visible inside a class, its functions and its extensions

// fileprivate: Accessible from anywhere within the source file. Example: If balance is assigned with fileprivate, it turs visible inside the file where it was written.

// internal: Acessible from anywhere within the module in which is defined. This id the Default access level. Example: In this case, if balance was internal, it would be visible to this file and any other inside the same module(In playground would be a file in the same level of path. If you create a file inside Sources directory, it would be another module, and the entity with the internal access modifier won't be visible)

// public: Acessible from anywhere within the module and also others modules inside the project. Example: In this case the property would be visible for Sources Directory too.

// open: Same as the public, but the property, function or anything with this access modifier can be overridden by code in another module.



// Private

// The private access modifier restricts access to the entity it is defined in, its nested types and also the extensions on the same file can access the entity.

// Example by extending the behaviour of BasicAccount  to make a CheckingAccount

//class CheckingAccount: BasicAccount {
//    private let accountNumber = UUID().uuidString
//
//    class Check {
//        let account: String
//        var amount: Dollars
//        private(set) var cashed = false
//
//        func cash() {
//            cashed = true
//        }
//
//        init(amount: Dollars, from account: CheckingAccount) {
//            self.amount = amount
//            self.account = account.accountNumber
//        }
//    }
//
//    func writeCheck(amount: Dollars) -> Check? {
//        guard balance > amount else {
//            return nil
//        }
//
//        let check = Check(amount: amount, from: self)
//        withdraw(amount: check.amount)
//        return check
//    }
//
//    func deposit(_ check: Check) {
//        guard !check.cashed else {
//            return
//        }
//
//        deposit(amount: check.amount)
//        // check.cashed = true
//        check.cash()
//    }
//}

// In the example above CheckingAccount has a private member accountNumber and a nested type Check.

// CheckingAccount must be able to write and cash checks.

// Creating a checking account for Andre deposit R$300.00

let andreChecking = CheckingAccount()
andreChecking.deposit(amount: 300.00)

//andreChecking.balance

// Write a check for R$200.00

//let check = andreChecking.writeCheck(amount: 200.00)!

// Creating a checking account for Zé

//let zeChecking = CheckingAccount()
//zeChecking.deposit(check)
//zeChecking.balance
//andreChecking.balance

// If you try to cash the check again, you'd be denied

//zeChecking.deposit(check)
//zeChecking.balance
//andreChecking.balance

// The code above works great but what is interesting here is the code access given to the instance. A CheckingAccount instance has the accountNumber property but can't be accessed from the instance by its definition.

// Likewise, Check makes the setter for cashed private and requires consumers use cash(). -- Test inside deposit(check:) function.

// Even though accountNumber was not visible on CheckingAccount, the number is made accessible by anyone holding a Check

//check.account


// Playground Sources

// Move the Account protocol, BasicAccount class and the Dollars typealias to Accounts.swift

// The code inside Sources folder is treated as another module from the code within playground.



// File Private

// It's closely related to private, which permits access to any code written in the same file as the entity, instead of the same lexical scope and extensions within the same file that private provides.

// The code will be tested in Accounts and Checking files. Where Account, BasicAccount and CheckingAccount were moved to.

// For now, nothing is preventing from a coder to create a Check on their own. In a safe code, you want a Check only to only originate from CheckAccount

// If you try to add private in the initializer inside Check class while you prevent bad code, it also prevents CheckingAccount from create an instance as well.

// private entities can be accessed from anything within lexical scope, but in this case CheckingAccount is one step outside the scope of Check. Fortunately, this is where fileprivate is very useful.

// Now CheckingAccount can still write checks, but you can’t create them from anywhere else. The fileprivate modifier is ideal for code that is “cohesive” within a source file; that is, code that is closely related or serves enough of a common purpose to have shared but protected access. Check and CheckingAccount are examples of two cohesive types.



// Internal, public and open

// Internal is the default state of access for your code. Its behavior define that an entity can be accessed from anywhere the module in which is defined.

// To this point all your code were written from a single playground, which means it's all been in the same module.

// When you added code to the Sources directory in your playground, you effectively created a module that your playground consumed.


// Internal

// If you uncomment the andreChecking the compiler will complain that cannot find CheckingAccount in the scope. That is because it is in another module.


// Public

// To make CheckAccount visible, you need to make it public.

// An entity that is public can be accessed by outside of its module.

// While the type itself  is public, its members are still internal and unavailable outside the module. You need to make them public also.

// When you move both BasicAccount and CheckingAccount for the respective files inside Source, you changed the module in which they are. Meaning they would only visible now with public or open.


// Open

class SavingAccounts: BasicAccount {
    var interestRate: Double
    private let pin: Int
    
    @available(*, deprecated, message: "Use init(interestRate:pin:) instead")
    init(interestRate: Double) {
        self.interestRate = interestRate
        pin = 0
    }
    
    init(interestRate: Double, pin: Int) {
        self.interestRate = interestRate
        self.pin = pin
    }
    
    @available(*, deprecated, message: "Use processInterest(pin:) instead")
    func processInterest() {
            let interest = balance * interestRate
            deposit(amount: interest)
    }
    
    func processInterest(pin: Int) {
        if pin == self.pin {
            let interest = balance * interestRate
            deposit(amount: interest)
        }
    }
}

// For a class to be overriden, the modifier must be open. Otherwise the compiler will complain.

// Even though BasicAccount was defined as open, its member are public what means they won't be overriden.


// Mini - Exercise

// 1 - Create a struct Person in a new Sources file. This struct should have first, last and fullName properties that are readable but not writable by the playground.

let person = Person(firstName: "André", lastName: "Rodrigues de Jesus")
// person.firstName = "José" ERROR
person.fullName

// 2 - Create a similar type, except make it a class and call it ClassyPerson. In the playground, subclass ClassyPerson with class Doctor and make a doctor’s fullName print the prefix "Dr.".

class Doctor: ClassyPerson {
    
    override var fullName: String {
        "Dr. " + self.firstName + " " + self.lastName
    }
}
let classyPerson = Doctor(firstName: "José", lastName: "Rodrigues")
classyPerson.fullName



// Organizing code in extensions

// Extension by behavior

// You can apply access modifiers to extensions, which will help you categorize entire sections of code as public, internal or private.

// Addin some fraud features to CheckingAccount to verify the checks. See in Checking.Swift


// Extension by protocol conformance

// You've already seen this technique in protocol playground. Another example is make CheckingAccount conform to CustomStringConvertible


// available()

// If you take a look at SavingsAccount, you’ll notice that you can abuse processInterest() by calling it multiple times and adding interest to the account repeatedly. To make this function more secure, you can add a PIN to the account.


let savingAccount = SavingAccounts(interestRate: 45.0, pin: 123)
savingAccount.processInterest(pin: 123)

// Imagine that you send the updated code to the bank, but the bank's code doesn't compile because it was using your old SavingAccount class.

// To prevent breaking code that uses old implementation, you need to deprecate the code rather than replacing it. Swift has built-in support for this.

// Bring back the old implementation of the initializer and processInterest() and add @available

// After the inclusion of @available, the old methods still works but the compiler will generate a warning with your custom message.

let anotherSavingAccount = SavingAccounts(interestRate: 5.04)

/* Example of @available code in SavingAccount
 
 @available(*, deprecated, message: "Use init(interestRate:pin:) instead")

 “The asterisk in the parameters denotes which platforms are affected by this deprecation. It accepts the values *, iOS, iOSMac, tvOS or watchOS. The second parameter details whether this method is deprecated, renamed or unavailable.
 */



// Opaque return types

// Imagine you need to create an API for your banking library and write a function to create new accounts and return it. One of the requirements of this API is to hide implementation details so that clients are encouraged to write generic code. It means you shouldn't expose the type of account you're creating, be it a BasicAccount, CheckingAccount or SavingAccount. Instead you'll just return some instance that conforms to the protocol Account.

// In order to enable that, you need to first make Account protocol public. And then, you're able to create your function.

func createAccount() -> some Account {
    CheckingAccount()
}

// If you try to return only Account, the compiler will complain that the return type of Account needs to be generic because it has associated types.(BasicAccount, SavingAccount nad CheckingAccount)

// To solve that add the keyword some before the return

// This is an opaque return type and it lets the function decide what type of Account it wants to return without exposing the class type.



// Swift Package Manager

// SwiftPM lets you "package" your module so that you or other developers can use it in their code with ease.

// For example, a module that implements the logic of downloading images from the web is useful in many projects. Instead of copying & pasting to all your projects that need image downloading functionality, you could import this module and return it.

// See more here: https://swift.org/package-manager/



// Testing

// Imagine new engineers are tasked to update SavingAccounts, for that they'll need to change your code and that can be risky. For that situation and to prevent bugs in the logic, is a good way to write unit tests.

// Unit tests are piece of codes whose purpose is to test that your existing code  works as expected. For example you might write a test that deposits $100 to a new aacount and verify if the balance is indeed $100.

// Creating a a test class

// To create a test class, you need to import XCTest for your class

// Next you need to create a class that is a subclass of XCTestCase

class BankingTests: XCTestCase {
    
    var checkingAccount: CheckingAccount!
    
    override func setUp() {
        super.setUp()
        checkingAccount = CheckingAccount()
    }
    
    override func tearDown() {
        checkingAccount.withdraw(amount: checkingAccount.balance)
        super.tearDown()
    }
    
    
    func testNewAccountBalanceZero() {
      //let checkingAccount = CheckingAccount()
      XCTAssertEqual(checkingAccount.balance, 0)
    }
    
    func testCheckOverBudgetFails() {
        //let checkingAccount = CheckingAccount()
        let check = checkingAccount.writeCheck(amount: 100)
        print(checkingAccount.balance)
        XCTAssertNil(check)
    }
}

/* Then you must add some tests. Tests should cover the core functionality of your code and some edge cases. The acronym FIRST describes a concise set of criteria for effective unit tests. Those criteria are:
 
    - Fast: Tests should run quickly.
    - Independente/Isolated: Tests should not share state with each other.
    - Repeatable: You should obtain the same result every time the code is executed.
    - Self-validating: Tests should be fully automated. The output should be either “pass” or “fail”.
    - Timely: Ideally, tests should be written before you write the code they test (Test-Driven Development).
*/

// To add test to a test class you just need add a function that starts with test.

// To run your tests add at the bottom, the code <className>.defaultTestSuite.run()

BankingTests.defaultTestSuite.run()


// XCTAssert

// XCTAssert functions are used in tests to assert certain conditions are met. For example, you can verify that a certain value is greater than zero or that an object isn’t nil.

// see testNewAccountBalanceZero() and testCheckOverBudgetFails() in BankingTests.



// Making things @testable

// When you import Foundation, Swift brings in the public interface for that module. For your banking app, you might create a Banking module that you can import. This lets you see the public interface. But you might want to check internal state with XCTAssert. Instead of making things public that really shouldn’t be you can do this in your test code:

// @testable import Banking

// This makes your internal interface visible. (Note: Private API remains private.) This is a great tool for testing but you should never do this in production code. Always stick to the public API there.



// The setUp and tearDown methods

// In the examples of test above you needed to create a CheckingAccount instance in each test. The setUp method is executed before each test, and its purpose is to initialize the needed state for the tests to run.

// Adding a property and override the setUp method you can delete the instances created in each method.

// Similarly the tearDown method runs after every test. It's a good place to release resources you acquired or when you need to reset the state or the object.

// For example you could reset the balance of the CheckingAccount instance to zero. This is not needed, since setUp will initialize new accounts, but you can add it for the sake of the example.



// Challenges

/* 1 - A singleton is a design pattern that restricts the instantiation of a class to one object.
 
 Use access modifiers to create a singleton class Logger. This Logger should:
 
    - Provide shared, public, global access to the single Logger object.
    - Not be able to be instantiated by consuming code.
    - Have a method log() that will print a string to the console.
*/

class Logger {
    
    static let object: Logger = Logger()
    
    // A private initializer is required to restrict instantiation so only the class itself can create objects.
    private init() {}
    
    func log(text: String) {
        print(text)
    }
}

Logger.object
let text: () = Logger.object.log(text: "A text from a singleton")


/* 2 - Declare a generic type Stack. A stack is a LIFO (last-in-first-out) data structure that supports the following operations:
 
 peek: returns the top element on the stack without removing it. Returns nil if the stack is empty.
 
 push: adds an element on top of the stack.
 
 pop: returns and removes the top element on the stack. Returns nil if the stack is empty.
 
 count: returns the size of the stack.
 
 Ensure that these operations are the only exposed interface. In other words, additional properties or methods needed to implement the type should not be visible.

*/

struct Stack<Element> {
    private var elements: [Element] = []
    
    var count: Int {
        elements.count
    }
    
    func peek() -> Element? {
        elements.last
    }
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop(_ element: Element) -> Element? {
        elements.popLast()
    }
}


/* 3 - Utilize something called a static factory method to create a game of Wizards vs. Elves vs. Giants.
    
 Add a file Characters.swift in the Sources folder of your playground.
 
 To begin:
 
 Create an enum GameCharacterType that defines values for elf, giant and wizard.
 
 Create a class protocol GameCharacter that has properties name, hitPoints and attackPoints. Implement this protocol for every character type.
 
 Create a struct GameCharacterFactory with a single static method make(ofType: GameCharacterType) -> GameCharacter.
 
 Create a global function battle that pits two characters against each other — with the first character striking first! If a character reaches 0 hit points, they have lost.
 
 Hints:
 
 The playground should not be able to see the concrete types that implement GameCharacter.
 
 Elves have 3 hit points, and 10 attack points. Wizards have 5 hit points and 5 attack points. Giants have 10 hit points and 3 attack points.

 The playground should know none of the above!

*/

let elf = GameCharacterFactory.make(ofType: .elf)
let giant = GameCharacterFactory.make(ofType: .giant)
let wizard = GameCharacterFactory.make(ofType: .wizard)

battle(elf, vs: giant)
battle(wizard, vs: giant)
battle(wizard, vs: elf)


