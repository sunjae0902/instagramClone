//
//  ProfileView.swift
//  mystagram
//
//  Created by sunjae on 11/5/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    let columns: [GridItem] = [ // flexiable, fixed, adaptive
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(viewModel.nickname)
                        .font(.createFont(weight: .regular, size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading) // 내부 정렬
                        .padding(.horizontal)
                    HStack {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else if let imageUrl = viewModel.user?.profileImageUrl {
                            let url = URL(string: imageUrl)
                            KFImage(url)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                                .foregroundStyle(Color.gray500)
                        }
                        VStack {
                            Text("\(viewModel.postCount ?? 0)")
                                .font(.titleMedium)
                            Text("게시물")
                        }.frame(maxWidth: .infinity)
                        VStack {
                            Text("\(viewModel.followerCount ?? 0)")
                                .font(.titleMedium)
                            Text("팔로워")
                        }.frame(maxWidth: .infinity)
                        VStack {
                            Text("\(viewModel.followingCount ?? 0)")
                                . font(.titleMedium)
                            Text("팔로잉")
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    Text(viewModel.name)
                        .font(.titleSmall)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 2 )
                    Text(viewModel.bio)
                        .font(.titleSmall)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if viewModel.user?.isCurrentUser == true {
                        NavigationLink {
                            ProfileEditingView(viewModel: viewModel)
                        } label: {
                            Text("프로필 편집")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .foregroundStyle(.black)
                                .background(Color.gray200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    } else {
                        let isFollowing = viewModel.user?.isFollowing ?? false
                        Button {
                            if isFollowing {
                                viewModel.unfollow()
                            } else {
                                viewModel.follow()
                            }
                        } label: {
                            Text(isFollowing ? "팔로잉" : "팔로우")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .foregroundStyle(isFollowing ? .black : .white)
                                .background(isFollowing ? Color.gray200 : .blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    }
                    Divider()
                        .padding()
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach (viewModel.posts) { post in // 각 행에 반복
                            let url = URL(string: post.imageUrl)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                        }
                    }
                    .task {
                        await viewModel.loadUserPosts()
                    }
                    //.onAppear() // 뷰가 떳을 때 실행, 동기 실행
                    Spacer()
                }
            }
        }
            .task {
                await viewModel.loadUserCountInfo()
            }
            .refreshable {
                await viewModel.loadUserCountInfo()
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
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
    ProfileView()
}
