//
//  PostModel.swift
//  mystagram
//
//  Created by sunjae on 11/2/24.
//

import Foundation

// struct Post: Encodable, Decodable {
struct Post: Codable {
    let id: String
    let caption: String
    let like: Int
    let imageUrl: String
    let date: Date
}
