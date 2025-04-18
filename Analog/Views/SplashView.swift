//
//  SplashView.swift
//  Analog
//
//  Created by zain Mayoof on 17/04/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                NavigationView {
                    LoginView()
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "opticaldisc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)

                    Text("Analog")
                        .font(.system(size: 40, weight: .bold))

                    Text("Where music lives offline.")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
