import UIKit

/*  Content:
        
     1 - Arrays
     2 - Acessing elements
     3 - Using subscripting
     4 - ArraySlice
     5 - Modifying Arrays
     6 - Iterating through array
    
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */


// Arrays

// Example of an immutable literal array

let evenNumbers = [2, 4, 6, 8]

// The type of the array above is infered by the type of the values inside it. [Int]

// Example of array with all it values set to a default value

let allZeros = Array(repeating: 0, count: 5)

// Its a good practice declare arrays that aren't going to change as constants

let vowels = ["A", "E", "I", "O", "U"]


// Acessing Elements

var players = ["Alice", "Bob", "Cindy", "Dan"]
print(players)

// Check if there is an element inside the array

players.isEmpty

// Check how many elements are inside the array

if players.count < 2 { print("We need 2 players") } else { print("Let's start!") }

// Verify the first element

let first = players.first

print(first as Any)

if let firstPlayer = first { print(firstPlayer) }

// Verify the last one

let last = players.last
print(last!)

// Verify the element if the minimun and maximun value of the array

print([2,3,1].min() as Any)
print([2,3,1].first as Any)

[2,3,1].max()


// Using Subscripting

// This syntax lets you access any value directly by using its index inside square brackets:

var firstPlayer = players[0]

print("First player is: \(firstPlayer)")

// Note: if you use an index out of the bounds of array the compiler will complain


// Using countable ranges to make an ArraySlice

let upcomingPlayersSlice = players[1...2]
print(upcomingPlayersSlice[1], upcomingPlayersSlice[2])

// The constant upcomingPlayersSlice is actually an ArraySlice

// You can also create a new array from an ArraySlice

let upcomingPlayersArray = Array(players[1...2])
print(upcomingPlayersArray[0], upcomingPlayersArray[1])


// Checking element

players.contains("Alice")

// Example with the game

func isEliminated(player: String) -> Bool {
    !players.contains(player)
}

isEliminated(player: "Alice")


// Modifying Arrays

// Appending Elements

players.append("Eli")

// Appending with subscripting

players += ["Gina"]
print(players)

// Inserting elements

players.insert("Frank", at: 5)
print(players)

// Removing Elements

var removedPlayer = players.removeLast()
print("\(removedPlayer) was removed")

// Remove with index identifier

removedPlayer = players.remove(at: 2)
print("\(removedPlayer) was removed")

// Mini - exercise

// 1 - Use firstIndex(of:) to determine the position of the element "Dan" in players.

let findElement = players.firstIndex(of: "Dan")
var index = 0

if let element = findElement {
    index = element
}

removedPlayer = players.remove(at: index)
print("\(removedPlayer) was removed")

print(players)


// Updating Elements

players[3] = "Franklin"
print(players)

// Subscripting with ranges to update multiple values

players[0...1] = ["Donna", "Craig", "Brian", "Anna"]
print(players)

// In the example above, the array get the first two values and substitute with the new values


// Moving Elements

// One solution, would be change one by one

let playerAnna = players.remove(at: 3)
players.insert(playerAnna, at: 0)
print(players)

// Other would be swaping values

players.swapAt(1, 2)
print(players)


// Iterating through array

let scores = [2, 8, 6, 1, 2, 1]

// For - Loop

for player in players {
    print(player)
}

// You can use a tuple for enumerate the players

for (count, players) in players.enumerated() {
    print("\(count + 1) - \(players)")
}

// Example with function and sum of the elements of array

func sumOfElements(array: [Int]) -> Int {
    var sum = 0
    
    for n in array {
        sum = sum + n
    }
    
    return sum
}

sumOfElements(array: scores)

// Mini - Exercises

// Write a for-in loop that prints the players’ names and scores.

func playersScore(array: [Int]) {
    
    for (index,player) in players.enumerated() {
        print("Player: \(player) - Score: \(array[index])")
    }
}

playersScore(array: scores)


// Running time for array operations

// Accessing Elements: The cost of fetching an element is cheap. It happens in constant time. Big O notation: O(1)

// Inserting Elements

// If you add in the beginning of array, the compiler will have to shift the other elements for make a room for the new one. It's linear time. Big O notation: O(n)

// If you add in the middle of array, it still be linear time, with the required time of n/2. Big O notation: O(n)

// If you add the element to end of array and there is room in it, the consume time will be constant, O(1). Otherwise, Swift will create a new one and copy the entire array, making it O(n).

// Deleting Elements

// Similar to inserting if you remove an element to the end, it will be constant time O(1), otherwise it will be linear time O(n).

// Searching Elements

// If the element is the first in the line, the search will end after a single operation O(1). Otherwise the search will be O(n)


