//
//  mystagramApp.swift
//  mystagram
//
//  Created by sunjae on 10/30/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate { // App 구조체 내부에서 호출됨
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main // App 구조체에 붙임, 앱의 시작점
struct mystagramApp: App {
     // SwiftUI에서 AppDelegate(UIKit)를 사용할 수 있게 연결하는 속성 래퍼(UIApplicationDelegateAdaptor)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
