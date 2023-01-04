//
//  CardView.swift
//  NoTime
//
//  Created by Quentin Eude on 04/01/2023.
//

import SwiftUI

struct CardView: View {
  private let title: String
  private let allowsInteractions: Bool
  private var onSwipe: (SwipeDirection) -> Void = { _ in }

  @State private var translation: CGSize = .zero
  @State private var dragGestureStartPoint: CGPoint = .zero
  

  init(title: String, allowsInteractions: Bool) {
    self.title = title
    self.allowsInteractions = allowsInteractions
  }

  var body: some View {
    GeometryReader { geo in
      Text(title)
        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        .background(Color.yellow)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 2)
        .offset(self.translation)
        .rotationEffect(self.rotation(geo))
        .simultaneousGesture(allowsInteractions ? self.dragGesture(geo) : nil)
    }
  }

  private func dragGesture(_ geometry: GeometryProxy) -> some Gesture {
    DragGesture()
      .onChanged { value in
        self.translation = value.translation
        if dragGestureStartPoint == .zero {
          self.dragGestureStartPoint = value.location
        }
      }
      .onEnded { value in
        self.translation = value.translation
        if let direction = self.swipeDirection(geometry) {

          withAnimation { self.onSwipe(direction) }
        } else {
          withAnimation { self.dragGestureStartPoint = .zero }
          withAnimation { self.translation = .zero }
        }
      }
  }

  private func rotation(_ geometry: GeometryProxy) -> Angle {
    let factor: CGFloat = 30
    let scale = geometry.size.height / factor
    let value = (dragGestureStartPoint.y / scale) - (factor / 2)
    return .degrees(
      Double(translation.width / geometry.size.width) * -value
    )
  }

  private var degrees: Double {
    var degrees = atan2(translation.width, -translation.height) * 180 / .pi
    if degrees < 0 { degrees += 360 }
    return Double(degrees)
  }

  private func swipeDirection(_ geometry: GeometryProxy) -> SwipeDirection? {
    guard let direction = SwipeDirection.direction(from: degrees) else { return nil }
    let threshold = min(geometry.size.width, geometry.size.height) * 0.5
    let distance = hypot(translation.width, translation.height)
    return distance > threshold ? direction : nil
  }

}

extension CardView {
  func onSwipe(_ action: @escaping (SwipeDirection) -> Void) -> Self {
    var updated = self
    updated.onSwipe = action
    return updated
  }
}

extension CardView {
  enum SwipeDirection {
    case left, right

    public static func direction(from degrees: Double) -> Self? {
      switch degrees {
      case 045..<135: return .right
      case 225..<315: return .left
      default: return nil
      }
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(title: "Hello world! 🎉", allowsInteractions: true)
      .padding(.vertical, 150)
      .padding(.horizontal, 50)
  }
}
