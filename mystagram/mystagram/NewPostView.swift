//
//  NewPostView.swift
//  mystagram
//
//  Created by sunjae on 10/30/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var caption = ""
    @Binding var tabIndex: Int
    @State var selectedItem: PhotosPickerItem?
    @State var photoImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async { // 이미지 변경
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.photoImage = Image(uiImage: uiImage)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    tabIndex = 0
                } label: {
                    Image(systemName: "chevron.left").tint(Color.black)
                }
                Spacer()
                Text("새 게시물").font(.titleLarge)
                Spacer()
            }.padding(.horizontal)
        
            PhotosPicker(selection: $selectedItem) {
                if let image = self.photoImage {
                    // self.photoImage != nil이면, 장착한 후.
                    image.resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 400)
                } else {
                    Image(systemName: "photo.on.rectangle").resizable().aspectRatio(1, contentMode: .fit).frame(width: 200, height: 200).padding().tint(.black)
                }
            }
            .onChange(of: selectedItem) { // selectedItem이 변하면 실행
                oldValue, newValue in
                Task {
                    await convertImage(item: newValue)
                }
            }
            // (하위 뷰에서)@State 변수에 $를 넣어주면, 수정이 가능하다.
            // 커스텀 뷰에서는, @Binding을 사용해서 받는다.
            TextField("문구를 작성하거나 설명을 추가하세요...", text: $caption).font(.titleMedium).padding()
            Spacer()
            Button {
                print("공유하기")
            } label: {
                Text("공유").font(.titleMedium).frame(width: 363, height: 45).foregroundStyle(.white).background(.blue ).clipShape(RoundedRectangle(cornerRadius: 12)).padding(.vertical)
            }
        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2)) // Binding type
}
