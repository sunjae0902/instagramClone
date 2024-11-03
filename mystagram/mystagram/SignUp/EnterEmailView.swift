//
//  EnterEmailView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct EnterEmailView: View {
    var body: some View {
        SignupBackgroundView {
            VStack {
                Text("이메일 주소 입력").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
                 
                TextField("이메일 주소", text: .constant(""))
                    .modifier(SimpleTextFieldModifier())
                NavigationLink {
                    EnterPasswordView()
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
    EnterEmailView()
}
