//
//  MainTabView.swift
//  mystagram
//
//  Created by sunjae on 10/30/24.
//

import SwiftUI

struct MainTabView: View {
    @State var tabIndex = 0
    var body: some View {
        // tabIndex -> tag 속성에 의해 페이지 업데이트됨
        TabView(selection: $tabIndex) {
            Text("Feed").tabItem {
                Image(systemName: "house")
            }.tag(0)
            Text("Search").tabItem {
                Image(systemName: "magnifyingglass")
            }.tag(1)
            NewPostView(tabIndex: $tabIndex).tabItem {
                Image(systemName: "plus.square")
            }.tag(2)
            Text("Reels").tabItem {
                Image(systemName: "movieclapper")
            }.tag(3)
            Text("Profile").tabItem {
                Image(systemName: "person.circle")
            }.tag(4)
        }.tint(.black) // 하위 뷰 tint 모두 블랙으로.
    }
}

#Preview {
    MainTabView()
}
