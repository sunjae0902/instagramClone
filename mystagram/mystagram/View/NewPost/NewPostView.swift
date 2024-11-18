//
//  NewPostView.swift
//  mystagram
//
//  Created by sunjae on 10/30/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Binding var tabIndex: Int
    @State var viewModel = NewPostViewModel() // 바인딩
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    tabIndex = 0
                    viewModel.clearData()
                } label: {
                    Image(systemName: "chevron.left").tint(Color.black)
                }
                Spacer()
                Text("새 게시물").font(.titleLarge)
                Spacer()
            }.padding(.horizontal)
        
            PhotosPicker(selection: $viewModel.selectedItem) {
                if let image = viewModel.postImage {
                    // self.postImage != nil이면, 장착한 후.
                    image.resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 400)
                } else {
                    Image(systemName: "photo.on.rectangle").resizable().aspectRatio(1, contentMode: .fit).frame(width: 200, height: 200).padding().tint(.black)
                }
            }
            .onChange(of: viewModel.selectedItem) { // selectedItem이 변하면 실행
                oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            // (하위 뷰에서)@State 변수에 $를 넣어주면, 수정이 가능하다.
            // 커스텀 뷰에서는, @Binding을 사용해서 받는다.
            TextField("문구를 작성하거나 설명을 추가하세요...", text: $viewModel.caption).font(.titleSmall).padding()
            Spacer()
            Button {
                Task{ // 비동기
                    await viewModel.uploadPost()
                    viewModel.clearData()
                    tabIndex = 0
                }
            } label: {
                Text("공유").font(.titleMedium).frame(width: 363, height: 45).foregroundStyle(.white).background(.blue ).clipShape(RoundedRectangle(cornerRadius: 12)).padding(.vertical)
            }
            // 업로드 중 표시
            if viewModel.isLoading {
                CustomProgressView(text: "업로드 중...")
            }
        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2)) // Binding type
}
