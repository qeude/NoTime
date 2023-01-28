import SwiftUI

public extension View {
  func applyTheme() -> some View {
    modifier(ThemeApplier())
  }
}


struct ThemeApplier: ViewModifier {
  @Environment(\EnvironmentValues.colorScheme) var colorScheme

  func body(content: Content) -> some View {
    content
      .preferredColorScheme(.dark)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.dark500)
      .tint(Color.primary500)
      .foregroundColor(.white)
      .onAppear {
        setWindowTint(Color.primary500)
        setBarsColor(Color.primary500)
      }
  }

  private func setWindowTint(_ color: Color) {
    allWindows()
      .forEach {
        $0.tintColor = UIColor(color)
      }
  }

  private func setBarsColor(_ color: Color) {
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().barTintColor = UIColor(color)
    UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: DesignSystemTextStyle.Style.title1.name, size: DesignSystemTextStyle.Style.title1.size) ?? .systemFont(ofSize: DesignSystemTextStyle.Style.title1.size)]
    UINavigationBar.appearance().topItem?.backButtonDisplayMode = .minimal
  }

  private func allWindows() -> [UIWindow] {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
  }
}
