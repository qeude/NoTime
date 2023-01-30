//
//  HomeView.swift
//  NoTime
//
//  Created by Quentin Eude on 28/01/2023.
//

import DesignSystem
import Env
import Models
import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var router: Router

  var body: some View {
    NavigationStack(path: $router.path) {
      VStack(spacing: 32) {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.primary500)
          .frame(width: 200, height: 200)
        Spacer()
        VStack(spacing: 24) {
          Button {
          } label: {
            Text(R.string.localizable.homeAbout())
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.secondary))
          Button {
          } label: {
            Text(R.string.localizable.homeHowToPlay())
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.secondary))
          Button {
            startNewGame()
          } label: {
            Text(R.string.localizable.homeCreateNewGame())
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.primary))
        }
        .fixedSize(horizontal: true, vertical: false)
        Spacer()
      }
      .navigationTitle("\(R.string.localizable.sharedAppName())!")
      .navigationBarTitleDisplayMode(.large)
      .applyTheme()
      .withAppRouter()
    }
  }

  private func startNewGame() {
    router.navigate(to: .createTeams)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(Router())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.dark500)
  }
}
