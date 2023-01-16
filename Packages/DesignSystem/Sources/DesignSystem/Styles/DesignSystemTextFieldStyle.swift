import SwiftUI

public struct DesignSystemTextFieldStyle: TextFieldStyle {
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(8)
      .overlay {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .stroke(Colors.Stroke.base, lineWidth: 1)
      }
  }
}

// MARK: Convenient usage
extension TextFieldStyle where Self == DesignSystemTextFieldStyle {
  public static var designSystem: Self {
    return .init()
  }
}

// MARK: Previews
struct DesignSystemTextFieldStyle_Previews: PreviewProvider {
  struct PreviewsContainer: View {
      @State private var text = "Test"

      var body: some View {
        TextField("Hello world", text: $text)
          .textFieldStyle(.designSystem)
      }
  }

  static var previews: some View {
    PreviewsContainer()
  }
}
