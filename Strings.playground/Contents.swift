import UIKit

/*  Content:
        
     1 - Strings as collections
     2 - Grapheme clusters
     3 - Indexing strings
     4 - Equality with combining characters
     5 - String as a bi-directional collections
     6 - Raw String
     7 - Substrings
     8 - Open-ended range
     9 - Character properties
     10 - Encoding
 
    
    Some code and excerpts are from: By Ray Fix. “Swift Apprentice.” Apple Books.
 */

// Strings as collections

// example

let string = "André Rodrigues de Jesus"

for c in string {
    print(c)
}

// You can also use other operations like you used ti collections

string.count

// Even though you can use some operations from collections, some of them won't apply here, like subscripting

// let fourthChar = string[3]

// If you try the code above, you'd get an error. You can't access string like an array because it doesn't have a fixed size for same words by example. Strings works with grapheme clusters


// Grapheme Clusters

// Strings are made of a collection of Unicode characters.

// Until now, you have considered one code point to precisely equal one character, and vice-versa. But it may come as surprise, but there aree two ways to represent some characters.

// By example the word café, can be represented by the single character é(233) or the letter e(101) and the acute accent(769). The last example is known as the combining character and the combination of the code points from e(101) and acute accent(769) is known grapheme cluster defined by the Unicode standard.

// Grapheme cluster are represented by the type Character in Swift.

// Another example of grapheme cluster are emojis with the color changed.


// Example of collection and grapheme cluster

let cafeNormal = "café"
let cafeCombining = "cafe\u{0301}" // The code here is written using the Unicode shorthand and the hexadecimal form

// Here the numbers are equal because Swift evaluates it as a collection of grapheme cluster

cafeNormal.count
cafeCombining.count

// To verify if they are using combining characters, you can use the unicodeScalars view.

cafeNormal.unicodeScalars.count
cafeCombining.unicodeScalars.count

// You can even find the code points which form string
print()

for codePoint in cafeNormal.unicodeScalars {
    print("\(codePoint) - \(codePoint.value)")
}

print()

for codePoint in cafeCombining.unicodeScalars {
    print("\(codePoint) - \(codePoint.value)")
}


// Indexing Strings

// Unlike using integer subscripting, in Swift you need to operate on the specific string index type in order to index strings.

// Examples

let firstIndex = cafeCombining.startIndex

// If you option + click the constant above you verify it is of the type String.Index and not an Integer.

// You can then use this value to obtain the character in there.

let firstChar = cafeCombining[firstIndex]


// Similarly, you can obtain the last grapheme cluster

var lastIndex = cafeCombining.endIndex
// let lastChar = cafeCombining[lastIndex]

// The error above happens because the last index in string is actually 1 past the end of string. So you must use other alternative to achieve the last char

lastIndex = cafeCombining.index(before: cafeCombining.endIndex)
let lastChar = cafeCombining[lastIndex]

// Alternatively, you could offset from the first character

let fourthIndex = cafeCombining.index(cafeCombining.startIndex, offsetBy: 3)
let fourthChar = cafeCombining[fourthIndex]

// You can access the code point on The Character type like you did in String

fourthChar.unicodeScalars.count

fourthChar.unicodeScalars.forEach { codePoint in
    print(codePoint.value)
}


// Equality with combining characters

// Combining characters can make equality of string a little tricky. Even though on the screen they use the same glyph, under the hood are represented in different ways.

// Many languages would consider cafeNormal and cafeCombining different because they compare code point to code point. Swift, however, consider to be equal by default.

let equal = cafeNormal == cafeCombining

// Swift uses a technique known as canonicalization. It means before make comparison, the compiler converts to use the same special character representation.


// String as a bi-directional collections

let name = "André"
let backwardsName = name.reversed()
print(backwardsName)

// Here the collection created from reverse() is not a String, but actually ReversedCollection<String>. This is a clever optimization. This create a thin "wrapper" around any collection that allows to use the collection without incurring additional memory usage.

// You can access like so

let secondCharIndex = backwardsName.index(after: backwardsName.startIndex)
let secondChar = backwardsName[secondCharIndex]

// If you actually want a String from the reversed collection, you could typecast

let backawardsNameString = String(backwardsName)
print(backawardsNameString)


// Raw String

// This technique is useful when you want to avoid special characters or string interpolation. Instead, the complete string as you type it is what becomes the string.

// Example

let raw1 = #"Raw "No Escaping" \(no interpolation!). Use all the \ you want!"#
print(raw1)

// You can add the symbol # how many times you want in your string as long the beginning and end match.

let raw2 = ##"Aren't we "# clever"##
print(raw2)

// Even though this serves to avoid interpolation, you can still use it.

let can = "can do that too"
let raw3 = #"Yes we \#(can)!"#
print(raw3)


// Substrings

// Something really usual is manipulating strings to generate substring. You can achieve it in Swift using subscript that takes range of indices

let fullName = "André Rodrigues de Jesus"
let spaceIndex = fullName.firstIndex(of: " ")!

var firstName = fullName[fullName.startIndex..<spaceIndex]
print(firstName)

// Open-ended range

// This type of range only takes one index and assume the other to be the beginning or the end of collection. The first name could be rewritten like this:

firstName = fullName[..<spaceIndex]

// Similarly you coulde use it to go until the end of collection

var lastName = fullName[fullName.index(after: spaceIndex)...]
print(lastName)

// If you check the type of these substrings above, you'd notice they are from the type String.SubSequence rather than String. Which is only a typealias for Substring.

// You can force it to String with typecast

let lastNameString = String(lastName)

// The reason for the extra Substring type is optimization. Like the reversed, you don't need any extra memory to create.


// Character properties

// Verify if the character belongs to ASCII

let singleCharacter: Character = "x"
singleCharacter.isASCII

// UTF-8 the today's standard for communication is a super-set based from ASCII

let emojiCharacter: Character = "🥳"
emojiCharacter.isASCII

// Verify if something is whitespace

let space:Character = " "
space.isWhitespace

// Verify if is a hexadecimal digit

let hexDigit: Character = "r"
hexDigit.isHexDigit

// The conversion from string to integer can be done to non-Latin characters too.

let thaiNine: Character = "๙"
thaiNine.wholeNumberValue


// Encoding

// Strings can be stores with different types of encoding, like UTF-8, UTF-16, UTF-32 and so on. They are related with the size of bits to store data. Each bit will be known as code unit. One of the most popular is the UTF-8.

// In UTF-8, when the collection of code points from a string is up to 7 bits, that string and their code points are split in two or more byte to storage.

// For example the code point 0x00BD represents the character ½. In binary this is 10111101 and uses 8 bits. In UTF-8, it would comprise 2 codes units 11000010 and 10111101 where the 3 firsts numbers of the first code unit and the two first numbers of the second code unit are the patterns and what is left over from spaces is where the actual code point is.

// To 8-11 bits there'll be 2 code units, to 12-16 there'll be 3 codes units and 17-21 will be 4 codes units.


// In Swift, you could access the UTF-8 string encoding through the utf-8 view.

let char = "\u{00bd}"

for char in char.utf8 {
    print(char)
}

// If you calculate, the code in the for loop are 11000010 and 10111101 from the example above.

let characters = "+½⇨🙃"
let charactersUnicode = "+\u{00bd}\u{21e8}\u{1f643}"

for i in charactersUnicode.utf8 {
    print("\(i) : \(String(i, radix: 2))")
}

// Even though you can't see from print() the codes from charactersUnicode uses different qtd of code units. You can check one by one to verify it.


// Converting indexes  between enconding views

let arrowIndex = charactersUnicode.firstIndex(of: "\u{21e8}")!
charactersUnicode[arrowIndex]

// Here, arrowIndex is  of type String.Index and used to obtain the Character at that index.

// You can convert this index to the index relating to the start of this grapheme cluster in the unicodescalars, utf8 and utf16.

if let unicodeScalarsIndex = arrowIndex.samePosition(in: characters.unicodeScalars) {
  characters.unicodeScalars[unicodeScalarsIndex] // 8680
}

if let utf8Index = arrowIndex.samePosition(in: characters.utf8) {
  characters.utf8[utf8Index] // 226
}

if let utf16Index = arrowIndex.samePosition(in: characters.utf16) {
  characters.utf16[utf16Index] // 8680
}


// Challenges

/* 1 - Write a function that takes a string and prints out the count of each character in the string.
 
 For bonus points, print them ordered by the count of each character.
 
 For bonus-bonus points, print it as a nice histogram.
 
 Hint: You could use # characters to draw the bars.

*/

/// Print each character and how many times it appears in the string
///
/// - Parameters:
///     - string: a string with more than 0 characters

func countCharInString(_ string: String) {
    
    guard string.count > 0 else {
        return
    }

    var charInString: [Character:Int] = [:]
    
    for char in string {
        if charInString.keys.contains(char) {
            charInString[char]! += 1
        } else {
            charInString.updateValue(1, forKey: char)
        }
    }
    
    let stringSorted = charInString.sorted {
        $0.value > $1.value
    }
    
    stringSorted.forEach {
        print("\($0.key) - ", terminator: "")
        for _ in 1...$0.value {
            print("#", terminator: " ")
        }
        print()
    }
//    print(stringSorted)
}

let text = "O rato roeu a roupa do rei de roma"
countCharInString(text)

/* 2 - Write a function that tells you how many words there are in a string. Do it without splitting the string.

 Hint: try iterating through the string yourself.

*/

func wordsInString(_ string: String) -> Int {
    var countWords = 0
    
    for c in string {
        if c.isWhitespace { countWords += 1 }
    }
    countWords += 1
    return countWords
}

wordsInString(text)

// 3 - Write a function that takes a string which looks like "Galloway, Matt" and returns one which looks like "Matt Galloway", i.e., the string goes from "<LAST_NAME>, <FIRST_NAME>" to "<FIRST_NAME> <LAST_NAME>".

func invertNames(_ name: String) -> String {
    guard !name.isEmpty else {
        return "name is empty"
    }
    
    let commaIndex = name.firstIndex(of: ",")!
    let lastName = name[..<commaIndex]
    let firstName = name[name.index(commaIndex, offsetBy: 2)...]
    
    return String(firstName + " " + lastName)
}

invertNames("Rodrigues de Jesus, André")

/* 4 - A method exists on a string named components(separatedBy:) that will split the string into chunks, which are delimited by the given string, and return an array containing the results.
 
 Your challenge is to implement this yourself.
 
 Hint: There exists a view on String named indices that lets you iterate through all the indices (of type String.Index) in the string. You will need to use this.
 
*/

let words = "O rato roeu a roupa do rei de roma"

print(words.components(separatedBy: " "))

func splitInChunks(string: String, separator: Character) -> [String] {
    var chunks: [String] = []
    var word = ""
    let lastIndexOfSeparator = string.lastIndex(of: separator)!
    let lastWord = string[string.index(after: lastIndexOfSeparator)...]
    print(lastWord)
    
    for c in words {
        if c == separator {
            chunks += [word]
            word = ""
        } else {
            word += String(c)
        }
    }
    
    chunks += [String(lastWord)]
    print(chunks)
    
    return chunks
}

splitInChunks(string: words, separator: " ")


/* 5 - Write a function which takes a string and returns a version of it with each individual word reversed.
 
 For example, if the string is “My dog is called Rover” then the resulting string would be "yM god si dellac revoR".
 
 Try to do it by iterating through the indices of the string until you find a space, and then reversing what was before it. Build up the result string by continually doing that as you iterate through the string.
 
 Hint: You’ll need to do a similar thing as you did for Challenge 4 but reverse the word each time. Try to explain to yourself, or the closest unsuspecting family member, why this is better in terms of memory usage than using the function you created in the previous challenge.
 
 */

func reverseWords(_ string: String) -> String {
    var word = ""
    let separator: Character = " "
    var sentence = ""
    let lastIndexOfSeparator = string.lastIndex(of: separator)!
    let lastWord = string[string.index(after: lastIndexOfSeparator)...]
    
    for c in string {
        if c == separator {
            sentence += word.reversed() + " "
            word = ""
        } else {
            word += String(c)
        }
    }
    
    sentence += lastWord.reversed()
    print(sentence)
    return ""
}

reverseWords(words)
