//
//  ProfileEditingView.swift
//  mystagram
//
//  Created by sunjae on 11/5/24.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.selectedItem){
                VStack {
                    if let profileImage = viewModel.profileImage { // 유저가 선택한 이미지
                        profileImage
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                    }
                    else if let imageUrl = viewModel.user?.profileImageUrl {
                        let url = URL(string: imageUrl)
                        KFImage(url)
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                    }
                        //                        AsyncImage(url: url) { image in // 이미 서버에 저장된 이미지를 네트워크 통신으로 보여줌, 캐싱 없음
                        //                            image
                        //                                .resizable()
                        //                                .frame(width: 75, height: 75)
                        //                                .clipShape(Circle())
                        //                                .padding(.bottom, 10)
                        //                        } placeholder: {
                        //                            ProgressView()
                        //                        }
                    //}
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                            .foregroundStyle(Color.gray500)
                    }
                    Text("사진 또는 아바타 수정")
                        .foregroundStyle(.blue)
                }
            }
            .onChange(of: viewModel.selectedItem) { // selectedItem이 변하면 실행
                oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("이름").foregroundStyle(.gray)
                    .font(.bodyLarge)
                TextField("이름", text: $viewModel.name).font(.createFont(weight: .regular, size: 20))
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("사용자 이름").foregroundStyle(.gray)
                    .font(.bodyLarge)
                TextField("사용자 이름", text: $viewModel.nickname).font(.createFont(weight: .regular, size: 20))
                    .textInputAutocapitalization(.never)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("소개").foregroundStyle(.gray)
                    .font(.bodyLarge)
                TextField("소개", text: $viewModel.bio).font(.createFont(weight: .regular, size: 20))
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Task {
                        await viewModel.updateUser()
                    }
                    dismiss() // 동작 완료 후 뒤로가도록
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    ProfileEditingView(viewModel: ProfileViewModel())
}
