//
//  SearchViewModel.swift
//  mystagram
//
//  Created by sunjae on 11/15/24.
//

import Foundation

@Observable
class SearchViewModel {
    var users: [User] = []
    
    init() {
        Task {
           await loadAllUsersData()
        }
    }
    
    func loadAllUsersData() async {
        self.users = await AuthManager.shared.loadAllUsersData() ?? [] // 없다면 빈 리스트
    }
}
