import UIKit

/*  Content:
        
     1 - Dictionaries
     2 - Modifying dictionaries
     3 - Running time for dictionary operations
     4 - Sets
    
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */


// Dictionaries

// Literal dictionary example

var nameAndScores: [String : Int] = ["Anna" : 2, "Brian" : 2, "Craig" : 8, "Donna" : 6]

print(nameAndScores)

// Dictionaries aren't indexed, so it is unordered

// Create an empty dictionary

var pairs: [String : Int] = [:]

// You can define a dictionary's capacity

pairs.reserveCapacity(20)


// Acessing Values

// Subscripting example

print(nameAndScores["Anna"]!)

// the return type here is an optional, meaning if Swift doesn't find the key, it will return nil

nameAndScores["Greg"]

// Using properties and methods

// Dictionary, like arrays, conform to Swift's Collection protocol. Because of that, they share many of the same properties.

nameAndScores.isEmpty
nameAndScores.count


// Modifying Dictionaries


// Adding pairs

var bobData = [
    "name" : "Bob",
    "profession" : "Card Player",
    "country" : "Brazil"
]

bobData.updateValue("CA", forKey: "state")

// Short way to add pair

bobData["city"] = "San Francisco"

// Mini - exercises

// 1 - Write a function that prints a given player’s city and state.

func printCityAndState(_ player: [String : String]) -> (String, String) {
    
    let city = player["city"]
    let state = player["state"]
    
    let cities = city ?? ""
    let states = state ?? ""
    
    return (cities, states)
}

let cityAndState = printCityAndState(bobData)
print(cityAndState)

// Updating Values

bobData.updateValue("Bobby", forKey: "name")

// If the key doesn't exist, it will create a new one and add the value

// Adding with subscripting

bobData["profession"] = "Mailman"

// Removing a pair

bobData.removeValue(forKey: "state")

// Removing with subscripting

bobData["city"] = nil


// Iterating through dictionaries

// As the items in a dictionary are pairs, you need to use a tuple

for (player, score) in nameAndScores {
    print("\(player) - \(score)")
}

// Iterating only over the keys

for player in nameAndScores.keys {
    print("\(player) ", terminator: "")
}
print("")


// Running time for dictionary operations

// Keys must be hashable or otherwise will get a compiler error. Hashing is the process to transform a value in a numeric value. All basic types in Swift are hashable and have a hash value. This value has to be deterministic. Meaning the value has to returning always the same hash value.

// To work properly, dictionaries has to have a great hashing function, otherwise all of the operation will be linear time O(n). Fortunately the built-in types have great, general purpose hashable implementations.

// Acessing Elements: Constant operation, O(1)

// Inserting Elements: Constant operation, O(1)

// Deleting Elements: Constant operation, O(1)

// Searching Elements: Constant operation, O(1)


// Sets

// Set is an unordered collection of uniques values of the same type. It can be useful when you don't want a value to appear twice in your collection.

// Creating Sets

let setOne: Set<Int> = [1]

// Set Literals

// Set don't have their own literal. TO create a sset with initial values, you need to be explicity

var explicitSet: Set<Int> = [1, 2, 3, 1]

// Note that after compiled there is only one 1 inside the set.

// You are able to let the compiler infer the type.

var someSet = Set([1, 2, 3, 1])
print(someSet)


// Acessing Elements

// You can use contains to check the existence of an element

someSet.contains(5)
someSet.contains(3)

// Adding Elements

someSet.insert(5)

// Remove Elements

let removedElement = someSet.remove(1)
print(removedElement!)


// Challenges

/* 1 - Which of the following are valid statements?
 
 1. let array1 = [Int]() - Valid
 2. let array2 = [] - Not valid
 3. let array3: [String] = [] - Valid
 
 For the next five statements, array4 has been declared as:
 
 let array4 = [1, 2, 3]

 4. print(array4[0]) - Valid
 5. print(array4[5]) - Not valid
 6. array4[1...2] - Valid
 7. array4[0] = 4 - not valid
 8. array4.append(4) - not valid
 
 For the final five statements, array5 has been declared as:
 
 var array5 = [1, 2, 3]
 
 9. array5[0] = array5[1] - Valid
 10. array5[0...1] = [4, 5] - Valid
 11. array5[0] = "Six" = Not valid
 12. array5 += 6 - Not valid
 13. for item in array5 { print(item) } - Valid
 
 */

// 2 - Write a function that removes the first occurrence of a given integer from an array of integers. This is the signature of the function:

func removingOnce(_ item: Int, from array: [Int]) -> [Int] {
    guard let index = array.firstIndex(of: item) else {
        print("The item was not found in array")
        return array
    }
    
    var newArray = array
    newArray.remove(at: index)
    
    return newArray
}

let array = [3, 5, 12, 67, 34, 48, 4, 9, 11]

removingOnce(6, from: array)

// 3 - Write a function that removes all occurrences of a given integer from an array of integers. This is the signature of the function:

let array3 = [2, 4, 6, 1, 5, 7, 5, 2, 4, 5, 3, 5]

func removing(_ item: Int, from array: [Int]) -> [Int] {
    var newArray = array
    var moveIndex = 0
    
    for value in newArray {
        if value == item {
            newArray.remove(at: moveIndex)
            moveIndex -= 1
        }
        moveIndex += 1
    }
    
    return newArray
}

let arrayItemRemoved = removing(5, from: array3)

print("Original array: \(array3)")
print("Array with items removed: \(arrayItemRemoved)")

// 4 - Arrays have a reversed() method that returns an array holding the same elements as the original array, in reverse order. Write a function that does the same thing, without using reversed(). This is the signature of the function:

let array4 = [1, 2, 3, 4, 5, 6, 7, 8]

func reversed(_ array: [Int]) -> [Int] {
    var newArray: [Int] = []
    var i = 0
    
    for index in stride(from: array.count - 1, through: 0, by: -1) {
        newArray.append(array[index])
        i += 1
    }
    
    return newArray
}

let reversedArray = reversed(array4)

print("Original array: \(array4)")
print("Reversed array: \(reversedArray)")

// 5 - Write a function that returns the middle element of an array. When array size is even, return the first of the two middle elememnts.

func middle(_ array: [Int]) -> Int? {
    
    let index = array.count / 2
    
    if array.count % 2 == 0 {
        return array[index - 1]
    } else {
        return array[index]
    }
}

middle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

// 6 - Write a function that calculates the minimum and maximum value in an array of integers. Calculate these values yourself; don’t use the methods min and max. Return nil if the given array is empty.

func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    
    guard !numbers.isEmpty else {
        return nil
    }
    
    var array = numbers
    var aux = 0
    
    for i in stride(from: 0, through: array.count - 1, by: 1) {
        for j in stride(from: i, through: array.count - 1, by: 1) {
            if array[i] > array[j] {
                //print("i: \(i) - Value: \(array[i]) | j: \(j) - Value \(array[j])")
                aux = array[i]
                array[i] = array[j]
                array[j] = aux
            }
        }
    }
    //print(array)
    let min = array.first!
    let max = array.last!
    return (min, max)
}

//let array6 = [Int]()
let array6 = [3, 5, 2, 8, 4, 1]
minMax(of: array6)

/* 7 - Which of the following are valid statements?
 
 1. let dict1: [Int, Int] = [:] - Not valid
 2. let dict2 = [:] - Not valid
 3. let dict3: [Int: Int] = [:] - Valid
 
 For the next four statements, use the following dictionary:
 
 let dict4 = ["One": 1, "Two": 2, "Three": 3]
 
 4. dict4[1] - Not valid
 5. dict4["One"] - Valid
 6. dict4["Zero"] = 0 - Not valid
 7. dict4[0] = "Zero" - Not valid
 
 For the next three statements, use the following dictionary:
 
 var dict5 = ["NY": "New York", "CA": "California"]
 
 8. dict5["NY"] - Valid
 9. dict5["WA"] = "Washington" - Valid
 10. dict5["CA"] = nil - Valid

*/

// 8 - Given a dictionary with two-letter state codes as keys, and the full state names as values, write a function that prints all the states with names longer than eight characters. For example, for the dictionary ["NY": "New York", "CA": "California"], the output would be California.

var states = ["NY": "New York", "CA": "California", "WA": "Washington", "TX": "Texas"]

func printStatesLongerThan8(_ dict: [String : String]) {
    
    for state in dict.values {
        if state.count > 8 {
            print(state)
        }
    }
}

printStatesLongerThan8(states)

// 9 - Write a function that combines two dictionaries into one. If a certain key appears in both dictionaries, ignore the pair from the first dictionary. This is the function’s signature:

func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
    var newDict = dict1
    
    for item in dict2 {
        newDict.updateValue(item.value, forKey: item.key)
    }
    
    return newDict
}

let dict1 = ["SP" : "São Paulo", "RJ" : "Rio de Janeiro", "PR" : "Paraná", "SC" : "Santa Catarina"]

let dict2 = ["RN" : "Rio Grande do Norte", "PA" : "Pará", "CE" : "Ceará"]

let statesOfBrazil = merging(dict1, with: dict2)

print(statesOfBrazil.values)

/* 10 - Declare a function occurrencesOfCharacters that calculates which characters occur in a string, as well as how often each of these characters occur. Return the result as a dictionary. This is the function signature:
 
 func occurrencesOfCharacters(in text: String) -> [Character: Int]
 
 Hint: String is a collection of characters that you can iterate over with a for statement.Bonus: To make your code shorter, dictionaries have a special subscript operator that let you add a default value if it is not found in the dictionary. For example, dictionary["a", default: 0] creates a 0 entry for the character "a" if it is not found instead of just returning nil.

*/

func occurencesOfCharacthers(in text: String) -> [Character : Int] {
    var dict: [Character : Int] = [:]
    for char in text {
        if dict[char] == nil {
            dict[char] = 1
        } else {
            dict[char]! += 1
        }
    }
    print(dict)
    return dict
}

occurencesOfCharacthers(in: "paralelepipedo")

// 11 - Write a function that returns true if all of the values of a dictionary are unique. Use a set to test uniqueness. This is the function signature:

func isUnique(_ dictionary: [String: Int]) -> Bool {
    
    var set: Set<Int> = []
    var n  = 0
    
    for item in dictionary.values {
        n = item
        set.insert(n)
    }
    
    let bool: Bool = set.count == dictionary.count ? true : false
    
    return bool
}

let dict11 = ["Zero" : 0, "Beta" : 1, "Alpha" : 2, "Gama" : 0]
isUnique(dict11)

// 11 - Given the dictionary:

 var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]

// Set the value of the key "Patrick" to nil and completely remove the key and value for "Ray".

nameTitleLookup["Patrick"] = nil
nameTitleLookup["Ray"] = nil

print(nameTitleLookup)
