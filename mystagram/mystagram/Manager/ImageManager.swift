//
//  ImageManager.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

enum ImagePath {
    case post
    case profile
}

struct ImageSelection {
    let image: Image
    let uiImage: UIImage
}

class ImageManager {
    // sigleton vs static : sigleton은 값을 저장하는 등 상태를 유지해야할 때 사용, static은 단순 기능만 제공하되 어디에서나 접근하기 위해 사용
    static func convertImage(item: PhotosPickerItem?) async -> ImageSelection? { // 이미지 변경
        guard let item = item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil } // uiimage 객체 생성
        let image = Image(uiImage: uiImage) // 뷰에 보여줄 이미지
        
        let imageSelection = ImageSelection(image: image, uiImage: uiImage)
        return imageSelection
    }
    
    static func uploadImage(uiImage: UIImage, path: ImagePath) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString // uuid 생성 -> 파일 이름이 됨
        
        var imagePath: String = ""
        switch path {
        case .post:
            imagePath = "images"
        case .profile:
            imagePath = "profiles"
        }
        
        let reference = Storage.storage().reference(withPath: "/\(imagePath)/\(fileName)")
        
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
}
