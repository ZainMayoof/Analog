//
//  SignupView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Sign Up").font(.largeTitle).bold()

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
                auth.signUp(email: email, password: password)
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if !auth.errorMessage.isEmpty {
                Text(auth.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
