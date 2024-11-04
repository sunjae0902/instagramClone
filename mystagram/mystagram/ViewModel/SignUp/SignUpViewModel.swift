//
//  SignUpViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/4/24.
//

import SwiftUI
import FirebaseAuth

@Observable
class SignUpViewModel {
    var email = ""
    var password = ""
    var name = ""
    var nickname = ""
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, name: name, nickname: nickname)
        email = ""
        password = ""
        name = ""
        nickname = ""
    }
    
}
