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
