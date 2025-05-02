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

            StoreMapListView() // NEW view combining Map + list
                .tabItem {
                    Label("Stores", systemImage: "map")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
    }
}
