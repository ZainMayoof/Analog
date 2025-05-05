//
//  RootView.swift
//  Analog
//
//  Created by Zain Mayoof on 18/04/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashView()
                    .onAppear {
                        // Simulate a delay for the splash screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false // Hide splash screen after delay
                        }
                    }
            } else if auth.user != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
