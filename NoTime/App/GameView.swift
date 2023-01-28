//
//  ContentView.swift
//  NoTime
//
//  Created by Quentin Eude on 24/12/2022.
//

import DesignSystem
import SwiftUI
import Models

struct GameView: View {
  @State private var selectedIndex: Int = 0
  @State private var teams: [Team] = [
    Team(name: "Team 1"),
    Team(name: "Team 2")
  ]
  @State private var playerToAdd: String = ""

  var body: some View {
    VStack(alignment: .center, spacing: 16) {
      Text("No Time")
      SegmentedControl(selectedIndex: $selectedIndex, items: $teams, keyPath: \.name) {
        withAnimation {
          teams.append(
            Team(name: "Team \(teams.count + 1)")
          )
        }
      }
      .padding(8)
      currentTeam
      Spacer()
      Button {
        teams.append(
          Team(name: "Team \(teams.count + 1)")
        )
      } label: {
        Text("Start game")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.designSystem(.primary))
    }
    .navigationTitle("Create your teams ❤️")
    .navigationBarTitleDisplayMode(.large)
    .padding()
    .applyTheme()
  }

  @ViewBuilder private var currentTeam: some View {
    let selectedTeam = teams[selectedIndex]
    VStack(alignment: .leading, spacing: 8) {
      Text("Players")
        .font(.title)
        .fontWeight(.bold)
      if selectedTeam.persons.isEmpty {
        Text("No player yet in this team.")
      } else {
        ForEach(Array(selectedTeam.persons.enumerated()), id: \.1) { index, person in
          HStack {
            Text(person)
            Button {
              teams[selectedIndex].persons.remove(at: index)
            } label: {
              Image(systemName: "xmark")
            }
          }
          .padding(6)
          .background(
            RoundedRectangle(cornerRadius: 8).fill(Color.primary500)
          )
        }
      }
      Spacer()
      HStack {
        DesignSystemTextField(tile: "", text: $playerToAdd, placeholder: "Add a new player")
        Button {
          teams[selectedIndex].persons.append(playerToAdd)
        } label: {
          Image(systemName: "arrow.right")
        }
        .buttonStyle(.designSystem(.primary))
      }
    }
  }

}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView()
      .background(Color.dark500)
  }
}
