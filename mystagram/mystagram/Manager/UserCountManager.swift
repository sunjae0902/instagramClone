//
//  UserCountManager.swift
//  mystagram
//
//  Created by sunjae on 11/19/24.
//

import Foundation
import FirebaseFirestore

struct UserCountInfo: Codable {
    let postCount: Int
    let followingCount: Int
    let followerCount: Int
}

class UserCountManager {
    
    static func loadUserCountInfo(userId: String?) async -> UserCountInfo? { // nil 일때는 현재 유저에 대해.
        guard let userId else { return nil }
         // async-let 동시 실행
        do {
            async let followingDocuments = try await Firestore.firestore()
                .collection("following")
                .document(userId).collection("user-following")
                .getDocuments()
            let followingCount = try await followingDocuments.count
            
            async let followerDocuments = try await Firestore.firestore()
                .collection("follower")
                .document(userId).collection("user-follower")
                .getDocuments()
            let followerCount = try await followerDocuments.count
            
            async let postDocuments = try await Firestore.firestore()
                .collection("posts")
                .whereField("userId", isEqualTo: userId)
                .getDocuments()
            let postCount = try await postDocuments.count
            
            return UserCountInfo(postCount: postCount, followingCount: followingCount, followerCount: followerCount)
            
        } catch {
            print("failed to load user count info with error \(error.localizedDescription)")
            return nil
        }
   }
}
