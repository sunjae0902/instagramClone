//
//  SignUpView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignupBackgroundView {
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
                Text("\(signUpViewModel.nickname)님, Instagram에 오신 것을 환영합니다.")
                    .font(.createFont(weight: .regular, size: 28)).padding(.top, 20).padding(.horizontal)
                Spacer()
                BlueButtonView {
                    Task {
                        await signUpViewModel.createUser()
                    }
                    MainTabView()
                } label: {
                    Text("완료")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SignUpView()
}
