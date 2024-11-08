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
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).getDocuments().documents
            // documnets에서 반복문 돌면서 하나씩 append하는 코드와 동일
            self.posts = try documents.map({ document in return try document.data(as: Post.self)})
        } catch {
            print("failed to load posts with error \(error.localizedDescription)")
        }
    }
}
