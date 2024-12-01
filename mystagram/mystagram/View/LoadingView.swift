//
//  SwiftUIView.swift
//  mystagram
//
//  Created by sunjae on 12/1/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            HStack {
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110)
                Spacer()
            }.padding(.horizontal)
            Spacer()
            CustomProgressView(text: "Loading...")
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
