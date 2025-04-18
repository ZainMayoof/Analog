//
//  AuthViewModel.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String = ""

    init() {
        self.user = Auth.auth().currentUser
    }

    func logIn(email: String, password: String) {
        print("📡 Attempting to log in with email:", email)

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("❌ Firebase Auth Error:", error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.user = nil
                }
                return
            }

            guard let firebaseUser = result?.user else {
                print("❌ No user object returned")
                DispatchQueue.main.async {
                    self.errorMessage = "Unexpected error"
                    self.user = nil
                }
                return
            }

            print("✅ Login successful! UID:", firebaseUser.uid)
            DispatchQueue.main.async {
                self.user = firebaseUser
                self.errorMessage = ""
            }
        }
    }

    func signUp(email: String, password: String) {
        print("📡 Attempting to sign up with email:", email)

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("❌ Firebase Sign-Up Error:", error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.user = nil
                }
                return
            }

            guard let firebaseUser = result?.user else {
                print("❌ No user object returned on sign up")
                DispatchQueue.main.async {
                    self.errorMessage = "Unexpected error"
                    self.user = nil
                }
                return
            }

            print("✅ Sign-up successful! UID:", firebaseUser.uid)
            DispatchQueue.main.async {
                self.user = firebaseUser
                self.errorMessage = ""
            }
        }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
            print("👋 Logged out")
            self.user = nil
        } catch {
            print("❌ Logout error:", error.localizedDescription)
        }
    }
}
