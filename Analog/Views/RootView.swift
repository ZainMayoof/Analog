//
//  RootView.swift
//  Analog
//
//  Created by Zain Mayoof on 18/04/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        Group {
            if auth.user != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
