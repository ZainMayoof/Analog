//
//  HomeView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//


// The SwiftUI view that lists all sample albums
import SwiftUI

struct HomeView: View {
    let featuredAlbums = [
        Album(id: "1", title: "Abbey Road", artist: "The Beatles", genre: "Rock", format: "Vinyl", price: 29.99, coverURL: "abbey_road", storeID: "store1"),
        Album(id: "2", title: "Thriller", artist: "Michael Jackson", genre: "Pop", format: "CD", price: 14.99, coverURL: "thriller", storeID: "store2"),
        Album(id: "3", title: "Random Access Memories", artist: "Daft Punk", genre: "Electronic", format: "Cassette", price: 11.99, coverURL: "ram", storeID: "store3")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Featured Section
                    VStack(alignment: .leading) {
                        Text("Featured Albums")
                            .font(.title2).bold()
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredAlbums) { album in
                                    NavigationLink(destination: AlbumDetailView(album: album)) {
                                        VStack(alignment: .leading) {
                                            Image(album.coverURL)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 140, height: 140)
                                                .cornerRadius(10)

                                            Text(album.title)
                                                .font(.headline)
                                                .lineLimit(1)
                                            Text(album.artist)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(width: 140)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Shop by Store
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Shop by Store")
                                .font(.title2).bold()
                            Spacer()
                            NavigationLink("View All", destination: StoreListView())
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(mockStores) { store in
                                    NavigationLink(destination: StoreDetailView(store: store)) {
                                        VStack {
                                            Image(store.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))

                                            Text(store.name)
                                                .font(.caption)
                                                .lineLimit(1)
                                                .frame(width: 100)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Welcome to Analog")
        }
    }
}
