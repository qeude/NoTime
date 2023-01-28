//
//  AppRouter.swift
//  NoTime
//
//  Created by Quentin Eude on 28/01/2023.
//

import Env
import SwiftUI

@MainActor
extension View {
  func withAppRouter() -> some View {
    navigationDestination(for: RouterDestinations.self) { destination in
      switch destination {
      case .createTeams:
        GameView()
      default:
        EmptyView()
      }
    }
  }

  func withSheetDestinations(sheetDestinations: Binding<SheetDestinations?>) -> some View {
    sheet(item: sheetDestinations) { destination in
      EmptyView()
    }
  }
}
