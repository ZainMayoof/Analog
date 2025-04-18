//
//  AnalogApp.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//


import SwiftUI
import Firebase

@main
struct AnalogApp: App {
    @StateObject var auth = AuthViewModel()
    @StateObject var cartManager = CartManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if auth.user != nil {
                // 👇 This will show the main page after login
                MainPageView()
                    .environmentObject(auth)
                    .environmentObject(cartManager)
            } else {
                // 👇 This is the login screen for new/unauthenticated users
                NavigationView {
                    LoginView()
                }
                .environmentObject(auth)
            }
        }
    }
}
