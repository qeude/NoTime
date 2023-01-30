import Foundation
import Models

public class Game: ObservableObject {
  @Published public var teams: [Team] = []
  @Published public var categories: [Models.Category] = []
  @Published public var state: State = .initial

  public init() {}

  public enum State {
    case initial
    case creating
    case round(_ number: Int, team: Team)
    case check(_ round: Int, team: Team)
    case ended
  }
}
