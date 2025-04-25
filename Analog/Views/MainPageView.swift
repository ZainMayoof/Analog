//
//  MainPageView.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var cartManager: CartManager

    let featuredAlbums = [
        Album(id: "1", title: "Abbey Road", artist: "The Beatles", genre: "Rock", format: "Vinyl", price: 29.99, coverURL: "abbey_road", storeID: "store1"),
        Album(id: "2", title: "Thriller", artist: "Michael Jackson", genre: "Pop", format: "CD", price: 14.99, coverURL: "thriller", storeID: "store2"),
        Album(id: "3", title: "Random Access Memories", artist: "Daft Punk", genre: "Electronic", format: "Cassette", price: 11.99, coverURL: "ram", storeID: "store3")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🎶 Featured Albums")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(featuredAlbums) { album in
                                NavigationLink(destination: AlbumDetailView(album: album)) {
                                    VStack {
                                        Image(album.coverURL)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 140, height: 140)
                                            .cornerRadius(12)

                                        Text(album.title)
                                            .font(.headline)
                                            .lineLimit(1)
                                        Text(album.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                    .frame(width: 140)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Divider().padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("🧃 Shop by Format")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack(spacing: 12) {
                            formatTag("CD")
                            formatTag("Vinyl")
                            formatTag("Cassette")
                        }
                        .padding(.horizontal)
                    }

                    Divider().padding(.horizontal)

                    NavigationLink(destination: CartView()) {
                        Label("View Cart", systemImage: "cart.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Welcome to Analog")
        }
    }

    func formatTag(_ format: String) -> some View {
        Text(format)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}
