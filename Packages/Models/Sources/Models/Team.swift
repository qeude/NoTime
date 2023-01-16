import Foundation

public struct Team {
  public let name: String
  public var persons: [String]

  public init(name: String) {
    self.name = name
    self.persons = []
  }
}
