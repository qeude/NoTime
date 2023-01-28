//
//  NoTimeApp.swift
//  NoTime
//
//  Created by Quentin Eude on 24/12/2022.
//

import DesignSystem
import Env
import SwiftUI

@main
struct NoTimeApp: App {
  @StateObject private var router = Router()

  var body: some Scene {
    WindowGroup {
      HomeView()
        .applyTheme()
        .environmentObject(router)
    }
  }
}

