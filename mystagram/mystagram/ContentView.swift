//
//  ContentView.swift
//  mystagram
//
//  Created by sunjae on 10/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser != nil {
            MainTabView()
        } else {
            SignInView().environment(signUpViewModel)// 공부
        }
    }
}

#Preview {
    ContentView()
}
