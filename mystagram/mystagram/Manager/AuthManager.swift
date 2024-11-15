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
    
    func loadUserData(userId: String) async -> User? {
        do {
            return try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self) // User 타입으로 가져와라
        } catch {
            print("failed to load user data with error \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadAllUsersData() async -> [User]? {
        do {
            let documents = try await Firestore.firestore().collection("users").getDocuments().documents
            let users = try documents.compactMap{document in return try document.data(as: User.self)}
            // documents.compactMap { e in return e.data }, nil 없이, 옵셔널 벗겨서 리턴
            return users
        } catch {
            print("failed to load all user data with error \(error.localizedDescription)")
            return nil
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

extension AuthManager {
    func follow(userId: String?) async {
        guard let currentUserId = currentUser?.id else { return }
        guard let userId else { return }
        
        do {
            // async let -> 두 로직이 순서에 상관없이 동시에 실행되도록.
            async let _ = try await Firestore.firestore()
                .collection("following")
                .document(currentUserId)
                .collection("user-following") // 하위 컬렉션이 만들어진 구조, 팔로잉
                .document(userId)
                .setData([:])
            
            async let _ = try await Firestore.firestore()
                .collection("follower")
                .document(userId)
                .collection("user-follower") // 상대방의 팔로워에 추가
                .document(currentUserId)
                .setData([:]) // 빈 데이터(Id만 저장)
        } catch {
            print("failed to save follow data with error \(error.localizedDescription)")
        }
    }
    
    func unfollow(userId: String?) async {
        guard let currentUserId = currentUser?.id else { return }
        guard let userId else { return }
        do {
            // async let -> 두 로직이 순서에 상관없이 동시에 실행되도록.
            async let _ = try await Firestore.firestore()
                .collection("following")
                .document(currentUserId)
                .collection("user-following") // 하위 컬렉션이 만들어진 구조, 팔로잉
                .document(userId)
                .delete()
            
            async let _ = try await Firestore.firestore()
                .collection("follower")
                .document(userId)
                .collection("user-follower") // 상대방의 팔로워에 추가
                .document(currentUserId)
                .delete()
        } catch {
            print("failed to save unfollow data with error \(error.localizedDescription)")
        }
    }
    
    func checkFollow(userId: String?) async -> Bool {
        guard let currentUserId = currentUser?.id else { return false }
        guard let userId else { return false }
        do {
            let isFollowing = try await Firestore.firestore()
                .collection("following")
                .document(currentUserId)
                .collection("user-following")
                .document(userId)
                .getDocument()
                .exists
            return isFollowing
        } catch {
            return false
        }
    }
}
