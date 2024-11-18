//
//  EnterNameView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI


struct EnterNameView: View {
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignupBackgroundView {
            VStack {
                Text("이름 입력").font(.createFont(weight: .regular, size: 28)).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).padding(.horizontal)
                
                TextField("성명", text: $signUpViewModel.name)
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
            }
        }
    }
}

#Preview {
    EnterNameView()
}
