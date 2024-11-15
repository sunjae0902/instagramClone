//
//  FeedCellView.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    @State var viewModel: FeedCellViewModel // init에서 초기화
    
    init(post: Post) { // 데이터를 읽기만 할 경우, 모델을 직접 넘겨줌(뷰 모델 없어도 되지만 비즈니스 로직이 추가될 예정이므로 뷰 모델 사용하겠음)
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                if let user = viewModel.post.user {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                }
            } label: {
                HStack {
                    if let imageUrl = viewModel.post.user?.profileImageUrl {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay{
                                Circle()
                                    .stroke(Color.instagramPurple, lineWidth: 2)
                            }
                        
                        .padding(.trailing, 6)}
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay{
                                Circle()
                                    .stroke(Color.instagramPurple, lineWidth: 2)
                            }
                            .foregroundStyle(Color.gray500)
                    }
                    
                    Text("\(viewModel.post.user?.nickname ?? "")")
                        .font(.titleLarge)
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.horizontal)
                .padding(.bottom, 3)
            }
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
            HStack {
                let isLike = viewModel.post.isLike ?? false
                
                FeedDetailTileView(text: "\(viewModel.post.like)",
                                   leadingIcon: {Image(systemName:  isLike ? "heart.fill" : "heart").foregroundStyle(isLike ? .red : .primary)},
                                   action: {
                    Task{
                        isLike == true ? await viewModel.unlike() : await viewModel.like()
                    }
                }).padding(.trailing, 5)
                // 수정 
                FeedDetailTileView(text: "12",
                                   leadingIcon: {Image(systemName: "bubble.right")},
                                   action: {
                    
                })
                Spacer()
                Image(systemName: "bookmark")
            }
            .imageScale(.large)
            .padding(.horizontal)
            .padding(.bottom, 1)
            Text("\(viewModel.post.user?.nickname ?? "")" + " " + viewModel.post.caption)
                .font(.bodyLarge)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 1)
            Text("댓글 25개 더보기")
                .foregroundStyle(.gray)
                .font(.bodySmall)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 1)
            Text(viewModel.post.date.relativeTimeString())
                .foregroundStyle(.gray)
                .font(.bodySmall)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .padding(.bottom)
        .alert("오류", isPresented: $viewModel.isError) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("동작을 완료하지 못했어요.")
        }
    }
}

#Preview {
    FeedCellView(post: Post(id: "ididid", userId: "userId", caption: "lalala", like: 1, imageUrl: "", date: Date()))
}

