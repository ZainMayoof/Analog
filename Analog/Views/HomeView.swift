//
//  HomeView.swift
//  Analog
//
//  Created by Zain Mayoof on 16/04/2025.
//


import SwiftUI

struct HomeView: View {
    @StateObject private var albumManager = AlbumManager()
    @State private var searchText: String = ""

    // Filtered albums based on search input
    var filteredAlbums: [Album] {
        if searchText.isEmpty {
            return albumManager.albums
        } else {
            return albumManager.albums.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.artist.localizedCaseInsensitiveContains(searchText) ||
                $0.genre.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var cds: [Album] {
        filteredAlbums.filter { $0.format.lowercased() == "cd" }
    }

    var vinyls: [Album] {
        filteredAlbums.filter { $0.format.lowercased() == "vinyl" }
    }

    var cassettes: [Album] {
        filteredAlbums.filter { $0.format.lowercased() == "cassette" }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // 🏠 Welcome Header
                    Text("🎵 Welcome to Analog")
                        .font(.title.bold())
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
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
            .searchable(text: $searchText, prompt: "Search albums...")
        }
        .onAppear {
            albumManager.fetchAllAlbums()
        }
        .environmentObject(albumManager)
    }
}
