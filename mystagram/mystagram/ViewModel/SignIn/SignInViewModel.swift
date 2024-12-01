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
    var isLoading = false
    var isLoginSuccess = true
    
    func checkEverythingFilled() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func signIn() async {
        if checkEverythingFilled() == true {
            do {
                isLoading = true
                try await AuthManager.shared.signIn(email: email, password: password)
                isLoginSuccess = true
            } catch {
                isLoading = false
                isLoginSuccess = false
                email = ""
                password = ""
                print("failed to log in with error \(error.localizedDescription)")
            }
        } else {
            print("please fill email and password")
        }
    }
    
}
