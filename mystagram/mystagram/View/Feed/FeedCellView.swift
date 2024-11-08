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
            HStack {
                KFImage(URL(string: viewModel.post.user?.profileImageUrl ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .overlay{
                        Circle()
                            .stroke(Color.instagramPurple, lineWidth: 2)
                    }
                    .padding(.trailing, 6)
                Text("nickname")
                    .font(.titleLarge)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
            HStack {
                FeedDetailTileView(text: "\(viewModel.post.like)", leadingIcon: Image(systemName: "heart")).padding(.trailing, 5)
                FeedDetailTileView(text: "12", leadingIcon: Image(systemName: "bubble.right"))
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
    }
}

#Preview {
    FeedCellView(post: Post(id: "ididid", userId: "userId", caption: "lalala", like: 1, imageUrl: "", date: Date()))
}
