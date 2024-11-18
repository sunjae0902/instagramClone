//
//  CommentManager.swift
//  mystagram
//
//  Created by sunjae on 11/18/24.
//

import Foundation
import FirebaseFirestore

class CommentManager {
    static func uploadComment(comment: Comment, postId: String) async {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        do {
            try await Firestore.firestore().collection("posts")
                .document(postId)
                .collection("post-comment")
                .addDocument(data: commentData)
        } catch {
            print("failed to upload comment with error \(error.localizedDescription)")
        }
    }
    
    static func loadComment(postId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore().collection("posts")
                .document(postId)
                .collection("post-comment")
                .order(by: "date", descending: true)
                .getDocuments().documents
            let comments = documents.compactMap { document in
                try? document.data(as: Comment.self)
            }
            return comments
        } catch {
            print("failed to load comment with error \(error.localizedDescription)")
            return []
        }
    }
    
    static func loadCommentCount(postId: String) async -> Int {
        do {
            let documents = try await Firestore.firestore().collection("posts")
                .document(postId)
                .collection("post-comment")
                .getDocuments().documents
            return documents.count
        } catch {
            print("failed to load comment count with error \(error.localizedDescription)")
            return 0
        }
    }
}
