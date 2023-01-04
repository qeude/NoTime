//
//  CardDeckView.swift
//  NoTime
//
//  Created by Quentin Eude on 04/01/2023.
//

import SwiftUI

struct Card: Identifiable, Equatable {
  let id: UUID
  let name: String
}

struct CardDeckView: View {
  @State private var currentIndex: Range<Array<Card>.Index>.Element
  @Binding private var cards: [Card]

  init(cards: Binding<[Card]>) {
    self._cards = cards
    self._currentIndex = State<Range<Array<Card>.Index>.Element>(initialValue: cards.startIndex)
  }

  var body: some View {
    ZStack {
      ForEach(Array(zip(cards.indices.reversed(), cards)), id:\.1.id) { (index, value) in
        let relativeIndex = self.cards.distance(from: self.currentIndex, to: index)
        CardView(title: value.name, allowsInteractions: relativeIndex == 0)
          .onSwipe { direction in
            cards.removeLast()
          }
          .rotationEffect(Angle(degrees: Double.random(in: -8..<8)))
      }
    }
    .padding(.vertical, 250)
    .padding(.horizontal, 110)
  }
}

struct CardDeckView_Previews: PreviewProvider {
  static var previews: some View {
    let cards = [
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
    ]

    CardDeckView(cards: .constant(cards))
  }
}


