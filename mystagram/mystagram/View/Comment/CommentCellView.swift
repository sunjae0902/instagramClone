//
//  CommentCellView.swift
//  mystagram
//
//  Created by sunjae on 11/18/24.
//

import SwiftUI
import Kingfisher

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            if let imageUrl = comment.commentUser?.profileImageUrl {
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
            VStack(alignment: .leading) {
                HStack {
                    Text(comment.commentUser?.nickname ?? "")
                        .font(.titleMedium)
                    Text(comment.date.relativeTimeString())
                        .foregroundStyle(.gray)
                        .font(.bodySmall)
                }
                Text(comment.commentText).font(.titleSmall)
            }
        }
    }
}
