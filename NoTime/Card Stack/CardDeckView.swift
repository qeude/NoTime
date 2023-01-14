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
  let test: Double = Double.random(in: -8..<8)

  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.id == rhs.id
  }
}

struct CardDeckView: View {
  @Binding private var cards: [Card]

  init(cards: Binding<[Card]>) {
    self._cards = cards
  }

  var body: some View {
    ZStack {
      ForEach(cards, id: \.id) { value in
        let isTopCard = value.id == cards.last?.id
        CardView(title: value.name, allowsInteractions: isTopCard)
          .onSwipe { direction in
            switch direction {
            case .left:
              guard let lastCard = cards.popLast() else { return }
              cards.insert(lastCard, at: 0)
            case .right:
              cards.removeLast()
            }

          }
          .rotationEffect(Angle(degrees: value.test))
      }
    }
    .padding(.vertical, 210)
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


