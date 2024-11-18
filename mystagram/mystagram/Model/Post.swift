//
//  PostModel.swift
//  mystagram
//
//  Created by sunjae on 11/2/24.
//

import Foundation

// struct Post: Encodable, Decodable {
struct Post: Codable, Identifiable { // 인코딩/디코딩 가능, 반복문에서 식별 가능
    let id: String
    let userId: String
    let caption: String
    var like: Int
    var isLike: Bool?
    let imageUrl: String
    let date: Date
    
    var user: User?
}

extension Post {
    static var DUMMY_POST = Post(id: UUID().uuidString, userId: UUID().uuidString, caption: "test caption", like: 0, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/mystagram-ae5c3.firebasestorage.app/o/images%2F0254D77D-14C6-4753-AD86-0DABCBEED66C?alt=media&token=fb3e49e2-2f29-4e81-bb88-e6072086d5f6", date: Date())
}
