
import SwiftUI

enum AppFonts {
    case regular15
    case medium12
    case medium14
    case medium18
    case medium20
    case medium28
    case semibold14
    case semibold15
    case semibold32
    case bold32
    
    var font: Font {
        switch self {
        case .regular15:
            return .custom("Poppins-Regular", size: 15)
        case .medium12:
            return .custom("Poppins-Medium", size: 12)
        case .medium14:
            return .custom("Poppins-Medium", size: 14)
        case .medium18:
            return .custom("Poppins-Medium", size: 16)
        case .medium20:
            return .custom("Poppins-Medium", size: 20)
        case .medium28:
            return .custom("Poppins-Medium", size: 28)
        case .semibold14:
            return .custom("Poppins-Light", size: 14)
        case .semibold15:
            return .custom("Poppins-SemiBold", size: 15)
        case .semibold32:
            return .custom("Poppins-SemiBold", size: 32)
        case .bold32:
            return .custom("Poppins-Bold", size: 32)
        }
    }
}
