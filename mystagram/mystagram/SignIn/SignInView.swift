//
//  SignInView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        NavigationStack {
            ZStack { // 자식 뷰가 부모 뷰 위로 쌓이는 구조
                GradientBackgroundView()
                VStack {
                    Spacer()
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        TextField("이메일 주소", text: .constant(""))
                            .textInputAutocapitalization(.never)
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                            }
                            .padding(.horizontal)
                        
                        SecureField("비밀번호", text: .constant(""))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                            }
                            .padding(.horizontal)
                        
                        Button {
                        } label: {
                            Text("로그인")
                                .font(.titleLarge)
                                .foregroundColor(.white)
                                .frame(width: 363, height: 42)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        Button {
                        } label: {
                            Text("비밀번호를 잊으셨나요?")
                                .foregroundColor(.black)
                                .font(.titleLarge)
                        }
                    }
                    Spacer()
                    NavigationLink {
                        EnterEmailView()
                    } label: {
                        Text("새 계정 만들기")
                            .font(.titleLarge)
                            .foregroundColor(.blue)
                            .frame(width: 363, height: 42)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 1)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    SignInView()
}

