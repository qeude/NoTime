//
//  ContentView.swift
//  NoTime
//
//  Created by Quentin Eude on 24/12/2022.
//

import SwiftUI
import DesignSystem

struct ContentView: View {
  @State private var cards = [
    Card(id: UUID(), name: "Santa Claus"),
    Card(id: UUID(), name: "Doudi"),
    Card(id: UUID(), name: "Fireman"),
    Card(id: UUID(), name: "Banana"),
    Card(id: UUID(), name: "Zidane"),
    Card(id: UUID(), name: "Charles Leclerc"),
    Card(id: UUID(), name: "The Weekend"),
    Card(id: UUID(), name: "Spongebob"),
    Card(id: UUID(), name: "Pikachu"),
    Card(id: UUID(), name: "Naruto"),
    Card(id: UUID(), name: "Kratos"),
    Card(id: UUID(), name: "Isaac"),
    Card(id: UUID(), name: "Domingo"),
  ].shuffled()
  
  var body: some View {
    VStack {
      CardDeckView(cards: $cards)
      Button {
        resetCards()
      } label: {
        Text("Reset cards")
      }
      .buttonStyle(.designSystem)
    }
  }

  private func resetCards() {
    cards = [
      Card(id: UUID(), name: "Santa Claus"),
      Card(id: UUID(), name: "Doudi"),
      Card(id: UUID(), name: "Fireman"),
      Card(id: UUID(), name: "Banana"),
      Card(id: UUID(), name: "Zidane"),
      Card(id: UUID(), name: "Charles Leclerc"),
      Card(id: UUID(), name: "The Weekend"),
      Card(id: UUID(), name: "Spongebob"),
      Card(id: UUID(), name: "Pikachu"),
      Card(id: UUID(), name: "Naruto"),
      Card(id: UUID(), name: "Kratos"),
      Card(id: UUID(), name: "Isaac"),
      Card(id: UUID(), name: "Domingo"),
    ].shuffled()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
