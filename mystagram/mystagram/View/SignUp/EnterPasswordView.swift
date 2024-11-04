//
//  EnterPasswordView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//
 
import SwiftUI

struct EnterPasswordView: View {
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignupBackgroundView {
            VStack {
                Text("비밀번호 만들기").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5).padding(.horizontal)
                
                Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).padding(.horizontal)
                
                SecureField("비밀번호(6자 이상)", text: $signUpViewModel.password)
                    .modifier(SimpleTextFieldModifier())
                NavigationLink {
                    EnterNameView()
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
    EnterPasswordView()
}
