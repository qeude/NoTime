import SwiftUI

public struct NoTimeButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @State private var tapAnimation: Bool = false

  private func offset(isPressed: Bool) -> CGFloat {
    guard isEnabled else { return 0 }
    return isPressed || tapAnimation ? Constants.Offset.pressed : Constants.Offset.default
  }

  var backgroundColor: Color {
    isEnabled ? Colors.Background.accent : Colors.Background.disabled
  }

  var textColor: Color {
    isEnabled ? Colors.Text.dark : Colors.Text.primary
  }

  public func makeBody(configuration: Self.Configuration) -> some View {
    return configuration.label
      .foregroundColor(textColor)
      .offset(y: offset(isPressed: configuration.isPressed))
      .padding(Constants.padding)
      .background(
        ZStack {
          if isEnabled {
            RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Colors.Background.accentAlt)
          }
          RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(backgroundColor)
            .offset(y: offset(isPressed: configuration.isPressed))
        }
      )
      .onChange(of: configuration.isPressed, perform: { newValue in
        if newValue {
          tapAnimation = true
          Task { @MainActor in
            try? await Task.sleep(for: .seconds(Constants.animationDuration))
            tapAnimation = false
          }
        }
      })
      .animation(.linear(duration: Constants.animationDuration), value: tapAnimation)
      .animation(.linear(duration: Constants.animationDuration), value: configuration.isPressed)
  }
}

// MARK: Constants
extension NoTimeButtonStyle {
  private enum Constants {
    static let padding: CGFloat = 12
    static let cornerRadius: CGFloat = 12
    static let animationDuration: CGFloat = 0.2
    enum Offset {
      static let `default`: CGFloat = -6
      static let pressed: CGFloat = -2
    }
  }
}

// MARK: Convenient usage
extension ButtonStyle where Self == NoTimeButtonStyle {
  public static var designSystem: Self {
    return .init()
  }
}

// MARK: Previews
struct NoTimeButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Button {
      } label: {
        Text("Design System Button")
      }
      .previewLayout(
        .fixed(
          width: 200,
          height: 100)
      )
      .buttonStyle(.designSystem)
      .previewDisplayName("Enabled")
      Button {
      } label: {
        Text("Design System Button")
      }
      .previewLayout(
        .fixed(
          width: 200,
          height: 100)
      )
      .disabled(true)
      .buttonStyle(.designSystem)
      .previewDisplayName("Disabled")
    }
  }
}
