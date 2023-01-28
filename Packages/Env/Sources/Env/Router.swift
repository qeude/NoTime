import Foundation
import SwiftUI

public enum RouterDestinations: Hashable {
  case homePage
  case createTeams
  case selectCategories
  case round
  case pointsVerification
  case leaderboard
}

public enum SheetDestinations: Identifiable {
  public var id: String {
    "id"
  }
}

@MainActor
public class Router: ObservableObject {
  @Published public var path: [RouterDestinations] = []
  @Published public var presentedSheet: SheetDestinations?

  public init() {}

  public func navigate(to: RouterDestinations) {
    path.append(to)
  }
}
