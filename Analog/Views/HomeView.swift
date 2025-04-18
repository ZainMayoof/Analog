//
//  HomeView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//


// The SwiftUI view that lists all sample albums

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Welcome to Analog 🎵")
                    .font(.largeTitle)
                    .bold()

                Text("Where music lives offline.")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                NavigationLink(destination: CartView()) {
                    Text("🛒 View Cart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // 🔓 Logout Button
                Button(action: {
                    auth.logOut()
                }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Analog")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(CartManager())
    }
}

