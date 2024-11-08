//
//  FeedCellViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import Foundation

@Observable
class FeedCellViewModel {
    var post: Post
    
    init(post: Post){
        self.post = post
        Task {
            self.post.user = await AuthManager().loadUserData(userId: post.userId)
        }
    }
}
