//
//  User.swift
//  mystagram
//
//  Created by sunjae on 11/4/24.
//

import Foundation
import FirebaseAuth

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var name: String // 추후에 변경할 수 있는 것은 var로
    var nickname: String
    var bio: String? // 자기소개
    var profileImageUrl: String?
    var isFollowing: Bool?
    
    var userCountInfo: UserCountInfo?
    
    var isCurrentUser: Bool {
        guard let currentUserId = AuthManager.shared.currentUser?.id else { return false}
        return currentUserId == id
    }
}
