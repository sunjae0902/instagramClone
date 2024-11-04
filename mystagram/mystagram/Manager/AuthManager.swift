//
//  AuthManager.swift
//  mystagram
//
//  Created by sunjae on 11/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class AuthManager {
    static let shared = AuthManager()
    var currentUserSession: FirebaseAuth.User?
    
    init() {
        currentUserSession = Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, name: String, nickname: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUserSession = result.user
            guard let userId = currentUserSession?.uid else { return }
            await uploadUserData(userId: userId, email: email, name: name, nickname: nickname)
        } catch {
            print("failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func uploadUserData(userId: String, email: String, name: String, nickname: String) async {
        let user = User(id: userId, email: email, name: name, nickname: nickname)
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            // firestore에 유저 정보 업로드
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
        } catch {
            print("failed to upload user data with error \(error.localizedDescription)")
        }
       
        
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            currentUserSession = nil
            
        } catch {
            print("failed to sign out with error \(error.localizedDescription)")
        }
    }
}
