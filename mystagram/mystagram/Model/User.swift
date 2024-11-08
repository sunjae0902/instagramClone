//
//  User.swift
//  mystagram
//
//  Created by sunjae on 11/4/24.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    var name: String // 추후에 변경할 수 있는 것은 var로
    var nickname: String
    var bio: String? // 자기소개
    var profileImageUrl: String?
}
