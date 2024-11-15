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
            await checkLike()
        }
    }
}

extension FeedCellViewModel {
    func like() async {
        await PostManager.like(post: post) // remote update
        post.isLike = true // local update
        post.like += 1
    }
    func unlike() async {
        await PostManager.unlike(post: post)
        post.isLike = false
        post.like -= 1
    }
    func checkLike() async {
        post.isLike = await PostManager.checkLike(post: post)
        
    }
}
