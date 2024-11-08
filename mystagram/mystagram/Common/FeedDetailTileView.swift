//
//  FeedDetailTileView.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import SwiftUI

struct FeedDetailTileView: View {
    let text: String
    let leadingIcon: Image
    
    var body: some View {
        HStack {
            leadingIcon
                .padding(.trailing, -5)
            Text(text)
                .font(.titleMedium)
        }
    }
}
