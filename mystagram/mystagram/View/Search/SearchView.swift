//
//  SearchView.swift
//  mystagram
//
//  Created by sunjae on 11/15/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @State var searchText = ""
    
    // computed property
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter{ user in
                return user.nickname.contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredUsers) { user in
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label:{
                    HStack {
                        if let imageUrl = user.profileImageUrl {
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .frame(width: 53, height: 53)
                                .clipShape(Circle())
                            
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 53, height: 53)
                                .opacity(0.5)
                        }
                        VStack(alignment: .leading) {
                            Text(user.nickname).font(.titleMedium)
                            Text(user.bio ?? "").font(.titleMedium).foregroundStyle(Color.gray)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "검색")
        }
    }
}

//#Preview {
//    SearchView()
//}
