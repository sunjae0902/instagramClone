//
//  ProfileViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/5/24.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseStorage

@Observable
class ProfileViewModel {
    var user: User? // user 내부 프로퍼티는 자동 감지가 안됨.
    
    // profileViewmodel 바로 내부에 있어야 함
    var name: String
    var nickname: String
    var bio: String
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage? // uikit의 이미지
    
    var posts: [Post] = []
    
    var postCount: Int? {
        user?.userCountInfo?.postCount
    }
    var followingCount: Int? {
        user?.userCountInfo?.followingCount
    }
    var followerCount: Int? {
        user?.userCountInfo?.followerCount
    }
   
    init() {
        let tempUser = AuthManager.shared.currentUser
        self.user = tempUser
        self.name = tempUser?.name ?? ""
        self.nickname = tempUser?.nickname ?? ""
        self.bio = tempUser?.bio ?? ""
        
        Task {
            await loadUserCountInfo()
        }
    }
    
    init(user: User) {
        self.user = user
        self.name = user.name
        self.nickname = user.nickname
        self.bio = user.bio ?? ""
        
        Task {
            await checkFollow()
            await loadUserCountInfo()
        }
    }
    
    // onChange 콜백
    func convertImage(item: PhotosPickerItem?) async { // 이미지 변경
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func updateUser() async {
        do {
            // 데이터 일관성 (서버에 업로드 성공 시에만 로컬 업데이트 -> 업로드만 성공하면 즉각적으로 ui 업데이트 가능)
            try await updateUserServer()
            updateUserLocal()
        } catch {
            print("failed to upload user data with error \(error.localizedDescription)")
        }
    }
    
    func updateUserLocal(){
        if !name.isEmpty, name != user?.name {
            user?.name = name
        }
        if !nickname.isEmpty, nickname != user?.nickname {
            user?.nickname = nickname
        }
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    func updateUserServer() async throws {
        var editedData: [String:Any] = [:] // dictionary
        if !name.isEmpty, name != user?.name {
            editedData["name"] = name
        }
        if !nickname.isEmpty, nickname != user?.nickname {
            editedData["nickname"] = nickname
            
        }
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        
        if let uiImage = self.uiImage {
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: ImagePath.profile) else { return }
            editedData["profileImageUrl"] = imageUrl
        }
        
        if !editedData.isEmpty, let userId = user?.id {
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData)
        }
    }
    
    func loadUserPosts() async {
        guard let userId = user?.id else { return }
        guard let posts = await PostManager.loadUserPosts(userId: userId) else { return }
        self.posts = posts
        
    }
}


    extension ProfileViewModel {
        func follow() {
            Task {
                await AuthManager.shared.follow(userId: user?.id)
                user?.isFollowing = true
                await loadUserCountInfo()
            }
        }
        
        func unfollow() {
            Task {
                await AuthManager.shared.unfollow(userId: user?.id)
                user?.isFollowing = false
                await loadUserCountInfo()
            }
        }
        
        func checkFollow() async {
            let userId = user?.id // 동시 접근으로 인한 오류 해결: 값을 복사해서 할당
            self.user?.isFollowing = await AuthManager.shared.checkFollow(userId: userId)
        }
    }

extension ProfileViewModel {
    func loadUserCountInfo() async {
        let userId = user?.id
        self.user?.userCountInfo = await UserCountManager.loadUserCountInfo(userId: userId)
    }
}
