//
//  TextFieldModifier.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct SimpleTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
            }
            .padding(.horizontal)
    }
}
