//
//  HomeView.swift
//  Analog
//
//  Created by Zain Mayoof on 16/04/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var albumManager = AlbumManager()

    var cds: [Album] {
        albumManager.albums.filter { $0.format.lowercased() == "cd" }
    }

    var vinyls: [Album] {
        albumManager.albums.filter { $0.format.lowercased() == "vinyl" }
    }

    var cassettes: [Album] {
        albumManager.albums.filter { $0.format.lowercased() == "cassette" }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // 🏠 Welcome Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome to")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Analog")
                            .font(.largeTitle.bold())
                    }
                    .padding(.horizontal)

                    // 💿 CD Section
                    AlbumRowView(
                        title: "CDs",
                        albums: cds,
                        seeAllDestination: AnyView(FormatAlbumListView(format: "CD"))
                    )

                    // 🎵 Vinyl Section
                    AlbumRowView(
                        title: "Vinyls",
                        albums: vinyls,
                        seeAllDestination: AnyView(FormatAlbumListView(format: "Vinyl"))
                    )

                    // 📼 Cassette Section
                    AlbumRowView(
                        title: "Cassettes",
                        albums: cassettes,
                        seeAllDestination: AnyView(FormatAlbumListView(format: "Cassette"))
                    )
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing:
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle")
                        .font(.title2)
                }
            )
        }
        .onAppear {
            albumManager.fetchAllAlbums()
        }
        .environmentObject(albumManager)
    }
}
