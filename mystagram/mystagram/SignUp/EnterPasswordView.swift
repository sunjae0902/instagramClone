//
//  EnterPasswordView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//
 
import SwiftUI

struct EnterPasswordView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Text("비밀번호 만들기").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5)
                
                Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
                
                SecureField("비밀번호", text: .constant(""))
                    .textInputAutocapitalization(.never)
                    .padding(12)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                    }
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
            }.padding(.horizontal)
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
    EnterPasswordView()
}
