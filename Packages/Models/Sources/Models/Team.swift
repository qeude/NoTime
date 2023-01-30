import Foundation

public struct Team {
  public var name: String
  public var persons: [String]
  public var points: Int

  public init(name: String) {
    self.name = name
    self.persons = []
    self.points = 0
  }

  public var isFull: Bool {
    persons.count == 3
  }

  public var hasEnoughtPlayers: Bool {
    persons.count >= 2
  }

  public mutating func add(player: String) {
    guard canAdd(player: player) else { return }
    persons.append(player.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  public func canAdd(player: String) -> Bool {
    let trimmedPlayer = player.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmedPlayer.isEmpty == false && persons.contains(trimmedPlayer) == false && persons.count < 3
  }
}
