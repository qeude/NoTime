import SwiftUI

public struct DesignSystemButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @State private var tapAnimation: Bool = false
  var style: DesignSystemButtonStyle.Style

  private func offset(isPressed: Bool) -> CGFloat {
    guard isEnabled else { return 0 }
    return isPressed || tapAnimation ? Constants.Offset.pressed : Constants.Offset.default
  }

  private var backgroundColor: Color {
    isEnabled ? Colors.Button.Background.primary : Colors.Button.Background.disabled
  }

  private var textColor: Color {
    isEnabled ? Colors.Button.Text.dark : Colors.Button.Text.disabled
  }

  public func makeBody(configuration: Self.Configuration) -> some View {
    return configuration.label
      .fontWeight(.semibold)
      .foregroundColor(textColor)
      .offset(y: offset(isPressed: configuration.isPressed))
      .padding(Constants.padding)
      .background(background(configuration: configuration))
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

  @ViewBuilder private func background(configuration: Self.Configuration) -> some View {
    switch style {
    case .roundedRectangle:
      ZStack {
        if isEnabled {
          RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Colors.Button.Background.primaryAlt)
        }
        RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(backgroundColor)
          .offset(y: offset(isPressed: configuration.isPressed))
      }
    case .circle:
      ZStack {
        if isEnabled {
          Circle().fill(Colors.Button.Background.primaryAlt)
        }
        Circle().fill(backgroundColor)
          .offset(y: offset(isPressed: configuration.isPressed))
      }
    }
  }
}

extension DesignSystemButtonStyle {
  public enum Style {
    case roundedRectangle
    case circle
  }
}

// MARK: Constants
extension DesignSystemButtonStyle {
  private enum Constants {
    static let padding: CGFloat = 12
    static let cornerRadius: CGFloat = 12
    static let animationDuration: CGFloat = 0.2
    enum Offset {
      static let `default`: CGFloat = -4
      static let pressed: CGFloat = 0
    }
  }
}

// MARK: Convenient usage
extension ButtonStyle where Self == DesignSystemButtonStyle {
  public static func designSystem(_ style: DesignSystemButtonStyle.Style) -> Self {
    return .init(style: style)
  }
}

// MARK: Previews
struct DesignSystemButtonStyle_Previews: PreviewProvider {
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
      .buttonStyle(.designSystem(.roundedRectangle))
      .previewDisplayName("Rounded Rectangle Enabled")
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
      .buttonStyle(.designSystem(.roundedRectangle))
      .previewDisplayName("Rounded Rectangle Disabled")
      Button {
      } label: {
        Image(systemName: "plus")
          .fontWeight(.bold)
      }
      .previewLayout(
        .fixed(
          width: 200,
          height: 100)
      )
      .buttonStyle(.designSystem(.circle))
      .previewDisplayName("Circle Enabled")
      Button {
      } label: {
        Image(systemName: "plus")
          .fontWeight(.bold)
      }
      .previewLayout(
        .fixed(
          width: 200,
          height: 100)
      )
      .disabled(true)
      .buttonStyle(.designSystem(.circle))
      .previewDisplayName("Circle Disabled")
    }
  }
}
