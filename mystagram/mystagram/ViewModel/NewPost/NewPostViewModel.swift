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
    var photoImage: Image?
    var uiImage: UIImage? // uikit의 이미지
    
    func uploadPost() async {
        // guard let uiImage = self.uiImage else { return } 과 동일
        guard let uiImage else { return } // 옵셔널 바인딩
        guard let imageUrl = await uploadImage(uiImage: uiImage) else { return }
       
        let postReference = Firestore.firestore().collection("posts").document() // posts 라는 collection에 한 document 단위로 저장
        print(postReference)
        let post = Post(id: postReference.documentID, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
        do{
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("failed to upload post with error \(error.localizedDescription)")
        }
    
    }
    
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString // uuid 생성 -> 파일 이름이 됨
        print("fileName: \(fileName)")
        let reference = Storage.storage().reference(withPath: "/images/\(fileName)")
        
        do {
            let metaData = try await reference.putDataAsync(imageData)
            print("metaData: \(metaData)")
            let url = try await reference.downloadURL()
            return url.absoluteString
        } catch {
            print("failed to upload image with error \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func convertImage(item: PhotosPickerItem?) async { // 이미지 변경
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return } // uiimage 객체 생성
        self.photoImage = Image(uiImage: uiImage) // 뷰에 보여줄 이미지
        self.uiImage = uiImage // 파이어베이스에 업로드하기 위해 UIkit의 uiimage에 저장
    }
    
    func clearData(){
        caption = ""
        selectedItem = nil
        photoImage = nil
        uiImage = nil
    }
}
