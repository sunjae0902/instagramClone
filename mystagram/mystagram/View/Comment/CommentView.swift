//
//  CommentView.swift
//  mystagram
//
//  Created by sunjae on 11/18/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var viewModel: CommentViewModel
    @State var commentText: String = ""
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            Text("댓글").font(.createFont(weight: .semiBold, size: 18)).padding(.top, 30).padding(.bottom, 15)
            Divider()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.comments) { comment in
                        CommentCellView(comment: comment)
                    }
                }.padding(.horizontal)
            }
            Divider()
            HStack {
                if let imageUrl = AuthManager.shared.currentUser?.profileImageUrl {
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
                TextField("댓글 추가", text: $commentText, axis: .vertical).font(.titleSmall)
                Button {
                    Task {
                        await viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                } label : {
                    Text("보내기")
                }
                .tint(.black)
            }
            .padding()
            
        }
    }
}


#Preview {
    CommentView(post: Post.DUMMY_POST)
}
