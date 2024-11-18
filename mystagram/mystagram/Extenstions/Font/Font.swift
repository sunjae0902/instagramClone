//
//  TextStyle.swift
//  helloWorld_swift_ui
//
//  Created by sunjae on 8/20/24.
//

import SwiftUI

extension Font {
    static let titleLarge = Font.custom("Pretendard-SemiBold", size: 18)
    static let titleMedium = Font.custom("Pretendard-SemiBold", size: 16)
    static let titleSmall = Font.custom("Pretendard-Medium", size: 16)
    
    static let bodyLarge = Font.custom("Pretendard-SemiBold", size: 14)
    static let bodyMedium = Font.custom("Pretendard-SemiBold", size: 14)
    static let bodySmall = Font.custom("Pretendard-Medium", size: 14)
    static let bodyXsmall = Font.custom("Pretendard-Medium", size: 13)
    
    static let LabelLarge = Font.custom("Pretendard-SemiBold", size: 12)
    static let LabelMedium = Font.custom("Pretendard-Medium", size: 12)
    static let LabelSmall = Font.custom("Pretendard-SemiBold", size: 10)
}

extension Font {
    enum FontWeight: String {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }

    static func createFont(weight: FontWeight, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
}


