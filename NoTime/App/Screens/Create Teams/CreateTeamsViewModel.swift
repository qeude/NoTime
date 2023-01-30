//
//  CreateTeamsViewModel.swift
//  NoTime
//
//  Created by Quentin Eude on 05/02/2023.
//

import Foundation
import Models

class CreateTeamsViewModel: ObservableObject {
  @Published var teams: [Team] = [
    Team(name: "\(R.string.localizable.createTeamsNewTeamPrefix()) 1"),
    Team(name: "\(R.string.localizable.createTeamsNewTeamPrefix()) 2")
  ]

  @Published var selectedIndex: Int = 0 {
    didSet {
      if teams[oldValue].name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        teams[oldValue].name = "\(R.string.localizable.createTeamsNewTeamPrefix()) \(oldValue + 1)"
      }
    }
  }

  var selectedTeam: Team {
    get {
      teams[selectedIndex]
    }
    set(value) {
      teams[selectedIndex] = value
    }
  }
}

extension CreateTeamsViewModel {
  func removeCurrentTeam() {
    guard canRemoveTeam else { return }
    let indexToRemove = selectedIndex
    selectedIndex = indexToRemove - 1
    teams.remove(at: indexToRemove)
  }

  var canRemoveTeam: Bool {
    teams.count > 2
  }

  var canAddTeam: Bool {
    teams.count < 6
  }

  func addTeam() {
    guard canAddTeam else { return }
    teams.append(Team(name: "\(R.string.localizable.createTeamsNewTeamPrefix()) \(teams.count + 1)"))
    selectedIndex = teams.count - 1
  }

  var isValid: Bool {
    teams
      .allSatisfy { $0.hasEnoughtPlayers && $0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
    && teams
      .map(\.persons)
      .reduce([], +)
      .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
  }
}
