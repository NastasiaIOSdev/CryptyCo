
import SwiftUI

enum AppColors {
    static let red = Color(hex: 0xFF6464)
    static let grey = Color(hex: 0x9395A4)
    static let black = Color(hex: 0x26273C)
    static let background = Color(hex: 0xE5E5E5)
    static let green = Color(hex: 0x5FC88F)
    static let appBlue = Color(hex: 0x1D85FF)
    static let yellow = Color(hex: 0xFDDD2D)
}

extension Color {
    init(hex: UInt64) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}
