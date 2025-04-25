//
//  AnalogApp.swift
//  Analog
//
//  Created by Zain Mayoof on 16/04/2025.
//

import SwiftUI
import Firebase

@main
struct AnalogApp: App {
    @StateObject var auth = AuthViewModel()
    @StateObject var cartManager = CartManager()
    @StateObject var favoritesManager = FavoritesManager()

    init() {
        FirebaseApp.configure()
        // Force logout on launch — for testing login/signup screens
        // Remove this line for production:
        // try? Auth.auth().signOut()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
                .environmentObject(cartManager)
                .environmentObject(favoritesManager)
        }
    }
}
