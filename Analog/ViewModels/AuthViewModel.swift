//
//  AuthViewModel.swift
//  Analog
//
//  Created by Zain Mayoof on 16/04/2025.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User? = nil
    @Published var errorMessage: String = ""

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.user = user
                print("🔁 Auth state changed — user is:", user?.email ?? "nil")
            }
        }
    }

    func logIn(email: String, password: String) {
        print("📡 Attempting to log in with email:", email)

        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("❌ Login error:", error.localizedDescription)
                } else {
                    self.errorMessage = ""
                    print("✅ Login successful!")
                }
            }
        }
    }

    func signUp(email: String, password: String) {
        print("📡 Attempting to sign up with email:", email)

        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("❌ Sign-up error:", error.localizedDescription)
                } else {
                    self.errorMessage = ""
                    print("✅ Sign-up successful!")
                }
            }
        }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            print("👋 Logged out")
        } catch {
            print("❌ Logout error:", error.localizedDescription)
        }
    }
}
