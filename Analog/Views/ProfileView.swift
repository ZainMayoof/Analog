//
//  ProfileView.swift
//  Analog
//
//  Created by zain Mayoof on 25/04/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        Form {
            Section(header: Text("Account")) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.blue)
                    Text(auth.user?.email ?? "Not logged in")
                }
            }

            Section(header: Text("Settings")) {
                NavigationLink(destination: Text("Preferences (Coming Soon)")) {
                    Label("Preferences", systemImage: "slider.horizontal.3")
                }

                NavigationLink(destination: Text("Terms & Conditions (Coming Soon)")) {
                    Label("Terms & Conditions", systemImage: "doc.text")
                }

                NavigationLink(destination: Text("Help & Support (Coming Soon)")) {
                    Label("Help & Support", systemImage: "questionmark.circle")
                }
            }

            Section {
                Button(action: {
                    auth.logOut()
                }) {
                    Label("Log Out", systemImage: "arrow.backward.circle.fill")
                        .foregroundColor(.red)
                }
            }

            Section(footer: Text("App Version 1.0.0")) {
                EmptyView()
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(AuthViewModel())
        }
    }
}
