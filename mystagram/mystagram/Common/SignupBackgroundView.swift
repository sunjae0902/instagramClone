//
//  SignupBackgroundView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct SignupBackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content:() -> Content) {
        self.content = content()
    }
    
    var body: some View {
        @Environment(\.dismiss) var dismiss
        ZStack {
            GradientBackgroundView()
            content
        }
        .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left").tint(.black)
                    }
                }
            }
    }
}
