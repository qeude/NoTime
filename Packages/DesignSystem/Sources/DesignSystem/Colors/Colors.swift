import Combine
import SwiftUI

extension UIColor {
  static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
    guard #available(iOS 13.0, *) else { return light }
    return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
  }
}

public struct Colors {
  private static func color(light: Color, dark: Color) -> Color {
    return Color(UIColor.dynamicColor(light: UIColor(light), dark: UIColor(dark)))
  }
}

extension Colors {
  public struct Background {
    public static var primary: Color = color(light: Color(hex: Palette.neutral0.rawValue), dark: Color(hex: Palette.neutral900.rawValue))
    public static var accent: Color = color(light: Color(hex: Palette.yellow500.rawValue), dark: Color(hex: Palette.yellow500.rawValue))
    public static var accentAlt: Color = color(light: Color(hex: Palette.yellow700.rawValue), dark: Color(hex: Palette.yellow800.rawValue))
  }

  public struct Text {
    public static var primary = color(light: Color(hex: Palette.neutral900.rawValue), dark: Color(hex: Palette.neutral100.rawValue))
    public static var secondary = color(light: Color(hex: Palette.neutral100.rawValue), dark: Color(hex: Palette.neutral900.rawValue))
    public static var light = color(light: Color(hex: Palette.neutral100.rawValue), dark: Color(hex: Palette.neutral100.rawValue))
    public static var dark = color(light: Color(hex: Palette.neutral900.rawValue), dark: Color(hex: Palette.neutral900.rawValue))
  }

  public struct Stroke {
    public static var base = color(light: Color(hex: Palette.neutral300.rawValue), dark: Color(hex: Palette.neutral600.rawValue))
  }

  public struct TextField {
    public struct Background {
      public static var primary = color(light: Color(hex: Palette.neutral200.rawValue), dark: Color(hex: Palette.neutral700.rawValue))
      public static var primaryAlt = color(light: Color(hex: Palette.neutral500.rawValue), dark: Color(hex: Palette.neutral400.rawValue))
    }
  }

  public struct Button {
    public struct Background {
      public static var primary: Color = color(light: Color(hex: Palette.yellow500.rawValue), dark: Color(hex: Palette.yellow500.rawValue))
      public static var primaryAlt: Color = color(light: Color(hex: Palette.yellow700.rawValue), dark: Color(hex: Palette.yellow800.rawValue))
      public static var disabled: Color = color(light: Color(hex: Palette.yellow300.rawValue), dark: Color(hex: Palette.yellow300.rawValue))
    }

    public struct Text {
      public static var primary = color(light: Color(hex: Palette.neutral900.rawValue), dark: Color(hex: Palette.neutral100.rawValue))
      public static var secondary = color(light: Color(hex: Palette.neutral100.rawValue), dark: Color(hex: Palette.neutral900.rawValue))
      public static var light = color(light: Color(hex: Palette.neutral100.rawValue), dark: Color(hex: Palette.neutral100.rawValue))
      public static var dark = color(light: Color(hex: Palette.neutral900.rawValue), dark: Color(hex: Palette.neutral900.rawValue))
      public static var disabled = color(light: Color(hex: Palette.neutral300.rawValue), dark: Color(hex: Palette.neutral300.rawValue))

    }
  }
}


extension Colors {
  private enum Palette: Int {
    case yellow100 = 0xFFEED1
    case yellow300 = 0xFFDDA3
    case yellow500 = 0xFFC766
    case yellow700 = 0xC59548
    case yellow800 = 0x9D773B
    case neutral0 = 0xFFFFFF
    case neutral100 = 0xE6E6E6
    case neutral200 = 0xCCCCCC
    case neutral300 = 0xB3B3B3
    case neutral400 = 0x999999
    case neutral500 = 0x808080
    case neutral600 = 0x666666
    case neutral700 = 0x4D4D4D
    case neutral800 = 0x333333
    case neutral900 = 0x1A1A1A
    case neutral1000 = 0x000000
  }
}
