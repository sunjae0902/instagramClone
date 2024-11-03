//
//  EnterNameView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI


struct EnterNameView: View {
    var body: some View {
        SignupBackgroundView {
            VStack {
                Text("이름 입력").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
                
                TextField("성명", text: .constant(""))
                    .modifier(SimpleTextFieldModifier())
                NavigationLink {
                    EnterUserNameView()
                } label: {
                    Text("다음")
                        .font(.titleLarge)
                        .foregroundColor(.white)
                        .frame(width: 363, height: 42)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    EnterNameView()
}
