//
//  EnterNameView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI


struct EnterNameView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Text("이름 입력").font(.title).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
                
                TextField("성명", text: .constant(""))
                    .textInputAutocapitalization(.never)
                    .padding(12)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                    }
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
    EnterNameView()
}
