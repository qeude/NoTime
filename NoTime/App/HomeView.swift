//
//  HomeView.swift
//  NoTime
//
//  Created by Quentin Eude on 28/01/2023.
//

import DesignSystem
import Env
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
            Text("About")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.secondary))
          Button {
          } label: {
            Text("How to play")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.secondary))
          Button {
            router.navigate(to: .createTeams)
          } label: {
            Text("Start a new game")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.designSystem(.primary))
        }
        .fixedSize(horizontal: true, vertical: false)
        Spacer()
      }
      .navigationTitle("No Time!")
      .navigationBarTitleDisplayMode(.large)
      .applyTheme()
      .withAppRouter()
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.dark500)
  }
}
