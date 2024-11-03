//
//  TextStyle.swift
//  helloWorld_swift_ui
//
//  Created by sunjae on 8/20/24.
//

import SwiftUI

let fontFamily:String = "Pretendard"

extension Font {
    static let titleLarge = Font.custom(fontFamily, size: 18).weight(.bold)
    static let titleMedium = Font.custom(fontFamily, size: 16).weight(.semibold)
    static let titleSmall = Font.custom(fontFamily, size: 16).weight(.medium)
    
    static let bodyLarge = Font.custom(fontFamily, size: 14).weight(.bold)
    static let bodyMedium = Font.custom(fontFamily, size: 14).weight(.semibold)
    static let bodySmall = Font.custom(fontFamily, size: 14).weight(.medium)
    static let bodyXsmall = Font.custom(fontFamily, size: 13).weight(.medium)
    
    static let LabelLarge = Font.custom(fontFamily, size: 12).weight(.semibold)
    static let LabelMedium = Font.custom(fontFamily, size: 12).weight(.medium)
    static let LabelSmall = Font.custom(fontFamily, size: 10).weight(.semibold)

}

