//
//  LoginView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Log In")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            Button(action: {
                auth.logIn(email: email, password: password)
            }) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button("Don't have an account? Sign Up") {
                showSignup = true
            }

            NavigationLink(destination: SignupView(), isActive: $showSignup) {
                EmptyView()
            }

            if !auth.errorMessage.isEmpty {
                Text(auth.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding()
    }
}

