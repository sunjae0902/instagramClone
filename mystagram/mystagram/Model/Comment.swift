//
//  Comment.swift
//  mystagram
//
//  Created by sunjae on 11/18/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    let commentText: String
    
    let postId: String
    let postUserId: String
    
    let commentUserId: String
    var commentUser: User?
    let date: Date
}
