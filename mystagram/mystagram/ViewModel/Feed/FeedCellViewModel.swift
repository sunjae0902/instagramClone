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
    var commentCount: Int = 0
    var isError: Bool = false
    
    init(post: Post){
        self.post = post
        Task {
            await loadPostUser()
            await checkLike()
            await loadCommentCount()
        }
    }
}

extension FeedCellViewModel {
    func like() async {
        
        post.isLike = true
        post.like += 1
        
        do {
            try await PostManager.like(post: post)
        } catch { // 실패 시 롤백
            post.isLike = false
            post.like -= 1
            isError = true
            print("Failed to like post: \(error.localizedDescription)")
        }
    }
    
    func unlike() async {
        post.isLike = false
        post.like -= 1
        
        do {
            try await PostManager.unlike(post: post)
        } catch {
            post.isLike = true
            post.like += 1
            isError = true
            print("Failed to unlike post: \(error.localizedDescription)")
        }
    }
    
    func checkLike() async {
        post.isLike = await PostManager.checkLike(post: post)
    }
}

extension FeedCellViewModel {
    func loadPostUser() async {
        self.post.user = await AuthManager.shared.loadUserData(userId: post.userId)
    }
    func loadCommentCount() async {
        self.commentCount = await CommentManager.loadCommentCount(postId: post.id)
    }
}
