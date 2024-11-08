//
//  AppColor.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

extension Color {
    static let gradientYellow = Color(hex: "#FFF9F1")
    static let gradientRed = Color(hex: "#FDF2F6")
    static let gradientBlue = Color(hex: "#EDF6FF")
    static let gradientGreen = Color(hex: "#EEFBF2")
    static let gray200 = Color(.gray.opacity(0.2))
    static let gray500 = Color(.gray.opacity(0.5))
    static let instagramPurple = Color(hex: "#bf0bb4")
}

extension Color {
    init(hex: String) {
         let scanner = Scanner(string: hex)
         _ = scanner.scanString("#")
         
         var rgb: UInt64 = 0
         scanner.scanHexInt64(&rgb)
         
         let r = Double((rgb >> 16) & 0xFF) / 255.0
         let g = Double((rgb >>  8) & 0xFF) / 255.0
         let b = Double((rgb >>  0) & 0xFF) / 255.0
         self.init(red: r, green: g, blue: b)
       }
}

