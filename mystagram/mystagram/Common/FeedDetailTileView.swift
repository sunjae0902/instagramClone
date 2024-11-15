//
//  FeedDetailTileView.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import SwiftUI

struct FeedDetailTileView<Content: View>: View {
    let text: String
    let leadingIcon: Content
    let action: () -> Void // closure
    
    init(text: String, @ViewBuilder leadingIcon: () -> Content, action: @escaping () -> Void) {
        self.text = text
        self.leadingIcon = leadingIcon()
        self.action = action
    }
    
    var body: some View {
        HStack {
            Button{
                action()
            } label: {
                leadingIcon
                    .padding(.trailing, -5)
            }
            Text(text)
                .font(.titleMedium)
        }
    }
}
