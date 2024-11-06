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
    var currentAuthUser: FirebaseAuth.User? // Authentication에서 가져온 유저
    var currentUser: User?
    
    init() {
        currentAuthUser = Auth.auth().currentUser
        Task{
            await loadUserData()
        }
    }
    
    func createUser(email: String, password: String, name: String, nickname: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            await uploadUserData(userId: userId, email: email, name: name, nickname: nickname)
        } catch {
            print("failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func uploadUserData(userId: String, email: String, name: String, nickname: String) async {
        let user = User(id: userId, email: email, name: name, nickname: nickname)
        self.currentUser = user
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            // firestore에 유저 정보 업로드 (auth에 저장된 uid 보내서, 매칭)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
        } catch {
            print("failed to upload user data with error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async {
        guard let userId = self.currentAuthUser?.uid else { return }
        do {
            self.currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self) // User 타입으로 가져와라
        } catch {
            print("failed to load user data with error \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentAuthUser = result.user
        } catch {
            print("failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            currentAuthUser = nil
            currentUser = nil
        } catch {
            print("failed to sign out with error \(error.localizedDescription)")
        }
    }
}
