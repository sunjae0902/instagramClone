//
//  FeedView.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                    Spacer()
                    Image(systemName: "heart")
                        .imageScale(.large)
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                LazyVStack { // 한 번에 모두 로딩 x
                    ForEach(viewModel.posts) { post in
                        FeedCellView(post: post)
                    }
                }
                Spacer()
            }
        }
        .refreshable {
            await viewModel.loadAllPosts()
        }
        .task {
            await viewModel.loadAllPosts()
        }
    }
}

#Preview {
    FeedView()
}
