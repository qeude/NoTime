//
//  ContentView.swift
//  NoTime
//
//  Created by Quentin Eude on 24/12/2022.
//

import DesignSystem
import Env
import Models
import SwiftUI

struct CreateTeamsView: View {
  enum FocusedField {
    case team, player
  }
  @EnvironmentObject private var router: Router
  @StateObject private var viewModel = CreateTeamsViewModel()

  @State private var playerToAdd: String = ""
  @State private var showRemoveAlert: Bool = false
  @FocusState private var focusedField: FocusedField?

  var body: some View {
    VStack(alignment: .center, spacing: 16) {
      header
      currentTeam
      footer
    }
    .alert(R.string.localizable.createTeamsRemoveTeamTitle(viewModel.selectedTeam.name), isPresented: $showRemoveAlert, actions: {
      Button(R.string.localizable.sharedYes(), role: .destructive) {
        withAnimation {
          viewModel.removeCurrentTeam()
        }
      }
      Button(R.string.localizable.sharedNo(), role: .cancel) { }
    }, message: {
      Text(R.string.localizable.createTeamsRemoveTeamMessage(viewModel.selectedTeam.name))
    })
    .navigationTitle(R.string.localizable.createTeamsTitle())
    .navigationBarTitleDisplayMode(.large)
    .padding()
    .applyTheme()
  }


  @ViewBuilder private var header: some View {
    HStack {
      Spacer(minLength: 0)
      SegmentedControl(selectedIndex: $viewModel.selectedIndex, items: $viewModel.teams, keyPath: \.name)
      Spacer()
      Button {
        viewModel.addTeam()
      } label: {
        Image(systemName: "plus")
      }
      .buttonStyle(.designSystem(.primary))
      .disabled(!viewModel.canAddTeam)
    }
  }

  @ViewBuilder private var currentTeam: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        DesignSystemTextField(tile: "Team name", text: $viewModel.teams[viewModel.selectedIndex].name, placeholder: R.string.localizable.createTeamsTeamNamePlaceholder())
          .focused($focusedField, equals: .team)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
        Button {
          showRemoveAlert = true
        } label: {
          Image(systemName: "trash")
        }
        .buttonStyle(.designSystem(.secondary))
        .disabled(!viewModel.canRemoveTeam)
      }
      VStack(alignment: .leading, spacing: 0) {
        if viewModel.selectedTeam.persons.isEmpty {
          Text(R.string.localizable.createTeamsNoPlayer())
            .textStyle(.designSystem(.body(.bold)))
        } else {
          List {
            ForEach(Array(viewModel.selectedTeam.persons.enumerated()), id: \.1) { index, person in
              HStack {
                Text(person)
                Spacer()
                Image(systemName: "xmark")
                  .onTapGesture {
                    viewModel.selectedTeam.persons.remove(at: index)
                  }
              }
              .frame(height: 44)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
          }
          .listStyle(.plain)
        }
        Spacer()
        if !viewModel.selectedTeam.isFull {
          HStack {
            DesignSystemTextField(tile: "", text: $playerToAdd, placeholder: R.string.localizable.createTeamsAddPlayerPlaceholder())
              .focused($focusedField, equals: .player)
              .textInputAutocapitalization(.never)
              .autocorrectionDisabled(true)
              .submitLabel(.next)
              .onSubmit {
                add(player: playerToAdd)
              }
            Button {
              add(player: playerToAdd)
            } label: {
              Image(systemName: "arrow.right")
            }
            .buttonStyle(.designSystem(.primary))
            .disabled(!viewModel.selectedTeam.canAdd(player: playerToAdd))
          }
        } else {
          Text(R.string.localizable.createTeamsTeamFull())
            .textStyle(.designSystem(.body(.bold)))
        }
      }
    }
  }

  @ViewBuilder private var footer: some View {
    VStack(alignment: .leading) {
      if !viewModel.isValid {
        Text(R.string.localizable.createTeamsWarningNotValid(viewModel.teams.filter { !$0.hasEnoughtPlayers }.compactMap { $0.name }.joined(separator: ", ")))
          .foregroundColor(Color.error400)
          .textStyle(.designSystem(.small()))
      }
      Button {
        router.navigate(to: .selectCategories)
      } label: {
        Text(R.string.localizable.sharedContinue())
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.designSystem(.primary))
      .disabled(!viewModel.isValid)
    }
  }

  private func add(player: String) {
    viewModel.selectedTeam.add(player: playerToAdd)
    playerToAdd = ""
    focusedField = .player
  }
}

struct CreateTeamsView_Previews: PreviewProvider {
  struct PreviewsContainer: View {
    @StateObject private var game = {
      let game = Game()
      game.teams = [
        Team(name: "\(R.string.localizable.createTeamsNewTeamPrefix()) 1"),
            Team(name: "\(R.string.localizable.createTeamsNewTeamPrefix()) 2")
      ]
      return game
    }()

    var body: some View {
      CreateTeamsView()
        .environment(\.locale, .init(identifier: "fr"))
        .background(Color.dark500)
    }
  }

  static var previews: some View {
    PreviewsContainer()
  }
}
