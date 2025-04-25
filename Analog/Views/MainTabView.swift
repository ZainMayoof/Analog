//
//  MainTabView.swift
//  Analog
//
//  Created by zain Mayoof on 25/04/2025.
//
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            StoreListView()
                .tabItem {
                    Label("Stores", systemImage: "building.2")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}
