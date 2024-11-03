//
//  BlueButtonView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct BlueButtonView<Content: View>: View {
    let label: Content
    let action: () -> Void // closure
    
    init(action: @escaping () -> Void, @ViewBuilder label:() -> Content) {
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
            .font(.titleLarge)
            .foregroundStyle(.white).frame(width: 363, height: 42)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
       
    }
}
