//
//  CustomProgressView.swift
//  mystagram
//
//  Created by sunjae on 11/16/24.
//

import SwiftUI

struct CustomProgressView: View {
    let text: String
    
    var body: some View {
        ProgressView(text)
            .font(.titleMedium)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(10)
    }
}
