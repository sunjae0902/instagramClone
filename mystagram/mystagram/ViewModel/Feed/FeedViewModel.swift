//
//  FeedViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import Foundation
import FirebaseFirestore

@Observable
class FeedViewModel {
    
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllPosts()
        }
    }
    
    func loadAllPosts() async {
        guard let posts = await PostManager.loadAllPosts() else { return }
        self.posts = posts
    }
}
