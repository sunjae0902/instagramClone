//
//  PostManager.swift
//  mystagram
//
//  Created by sunjae on 11/15/24.
//

import SwiftUI
import FirebaseFirestore

class PostManager {
    static func loadAllPosts() async -> [Post]? {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).getDocuments().documents
            // documnets에서 반복문 돌면서 하나씩 append하는 코드와 동일
            let posts = try documents.map({ document in return try document.data(as: Post.self)})
            return posts
        } catch {
            print("failed to load posts with error \(error.localizedDescription)")
            return nil
        }
    }
    
    static func loadUserPosts(userId: String) async -> [Post]? {
        do{
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: userId).getDocuments().documents
            
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            // 모든 데이터가 추가 되었을 때, 한 번에 저장 후 표시하기위함
            return posts
            
        } catch {
            print("failed to load user posts with error \(error.localizedDescription)")
            return nil
        }
        
    }
}

extension PostManager {
    static func like(post: Post) async throws {
           guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
           
           let usersCollection = Firestore.firestore().collection("users")
           let postsCollection = Firestore.firestore().collection("posts")
           
        async let userLikeUpdate: Void = usersCollection.document(userId).collection("user-like").document(post.id).setData([:])
        async let postLikeUpdate: Void = postsCollection.document(post.id).collection("post-like").document(userId).setData([:])
        async let postLikeCountUpdate: Void = postsCollection.document(post.id).updateData(["like" : post.like])

           _ = try await (userLikeUpdate, postLikeUpdate, postLikeCountUpdate)
       }
       
       static func unlike(post: Post) async throws {
           guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
           
           let usersCollection = Firestore.firestore().collection("users")
           let postsCollection = Firestore.firestore().collection("posts")
           
           async let userLikeDelete: Void = usersCollection.document(userId).collection("user-like").document(post.id).delete()
           async let postLikeDelete: Void = postsCollection.document(post.id).collection("post-like").document(userId).delete()
           async let postLikeCountUpdate: Void = postsCollection.document(post.id).updateData(["like" : post.like])

           _ = try await (userLikeDelete, postLikeDelete, postLikeCountUpdate)
       }
    
    static func checkLike(post: Post) async -> Bool {
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return false }
        
        do {
            // userId의 좋아요 정보에 postId가 있는지 확인
            let isLike = try await Firestore.firestore().collection("users").document(userId).collection("user-like").document(post.id).getDocument().exists
            return isLike
        } catch {
            print("failed to check like-info with error \(error.localizedDescription)")
            return false;
        }
    }
}
