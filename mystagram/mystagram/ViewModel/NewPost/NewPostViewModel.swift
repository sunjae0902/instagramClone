//
//  NewPostViewMoel.swift
//  mystagram
//
//  Created by sunjae on 11/2/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import FirebaseFirestore

@Observable
class NewPostViewModel {
    var caption = ""
    var selectedItem: PhotosPickerItem?
    var postImage: Image?
    var uiImage: UIImage? // uikit의 이미지
    
    func uploadPost() async {
        // guard let uiImage = self.uiImage else { return } 과 동일
        guard let uiImage else { return } // 옵셔널 바인딩
        guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: ImagePath.post) else { return }
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
        let postReference = Firestore.firestore().collection("posts").document() // posts 라는 collection에 한 document 단위로 저장
        let post = Post(id: postReference.documentID, userId: userId, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
        do{
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("failed to upload post with error \(error.localizedDescription)")
        }
    
    }
   
    func convertImage(item: PhotosPickerItem?) async { // 이미지 변경
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.postImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func clearData(){
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
}
