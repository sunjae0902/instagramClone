//
//  SignInViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/4/24.
//

import Foundation

@Observable
class SignInViewModel {
    var email = ""
    var password = ""
    
    func checkEverythingFilled() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func signIn() async {
        if checkEverythingFilled() == true {
            await AuthManager.shared.signIn(email: email, password: password)
        } else {
            print("please fill email and password")
        }
    }
    
}
