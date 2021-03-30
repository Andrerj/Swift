import Foundation

public enum GameCharacterType {
    case elf
    case giant
    case wizard
}

public protocol GameCharacter: class {
    var name: String { get }
    var hitPoints: Int { get set }
    var atackPoints: Int {  get }
}

class Elf: GameCharacter {
    let name: String = "Elf"
    var hitPoints: Int = 3
    var atackPoints: Int = 10
}

class Giant: GameCharacter {
    let name: String = "Giant"
    var hitPoints: Int = 10
    let atackPoints: Int = 3
}

class Wizard: GameCharacter {
    let name: String = "Wizard"
    var hitPoints: Int = 5
    let atackPoints: Int = 5
}

public struct GameCharacterFactory {
  static public func make(ofType type: GameCharacterType) -> GameCharacter {
    switch type {
    case .elf:
      return Elf()
    case .giant:
      return Giant()
    case .wizard:
      return Wizard()
    }
  }
}

public func battle(_ character1: GameCharacter, vs character2: GameCharacter) {
    character2.hitPoints -= character1.atackPoints
    
    if character2.hitPoints <= 0 {
        print("\(character2.name) defeated!")
        return
    }
    
    if character1.hitPoints <= 0 {
        print("\(character1.name) defeated!")
        return
    }
}
