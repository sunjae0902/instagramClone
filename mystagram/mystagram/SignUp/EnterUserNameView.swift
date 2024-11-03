//
//  EnterUserNameView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct EnterUserNameView: View {
    var body: some View {
        SignupBackgroundView {
            VStack {
                Text("사용자 이름 입력").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5)
                
                Text("사용자 이름을 직접 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다.").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
                 
                TextField("사용자 이름", text: .constant(""))
                    .modifier(SimpleTextFieldModifier())
                NavigationLink {
                    SignUpView()
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
    EnterUserNameView()
}
