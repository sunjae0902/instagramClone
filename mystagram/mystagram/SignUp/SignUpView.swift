//
//  SignUpView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Image("instagramLogo2").resizable().scaledToFit().frame(width: 120)
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .opacity(0.5)
                    .foregroundStyle(Color.gray)
                    .overlay {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2).opacity(0.5).frame(width: 185, height: 185)
                    }
                Text("user님, Instagram에 오신 것을 환영합니다.")
                    .font(.title).padding(.top, 20).padding(.horizontal)
                Spacer()
                Button {
                    
                } label: {
                    Text("완료")
                        .font(.titleLarge)
                        .foregroundStyle(.white).frame(width: 363, height: 42)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
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

#Preview {
    SignUpView()
}
