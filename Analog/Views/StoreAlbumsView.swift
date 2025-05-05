//
//  StoreAlbumsView.swift
//  Analog
//
//  Created by zain Mayoof on 05/05/2025.
//

import SwiftUI

struct StoreAlbumsView: View {
    let store: Store
    @EnvironmentObject var albumManager: AlbumManager
    @EnvironmentObject var cartManager: CartManager

    var storeAlbums: [Album] {
        albumManager.albums.filter { $0.storeID == store.id }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Albums Available at \(store.name)")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top)

                if storeAlbums.isEmpty {
                    Text("No albums available.")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                } else {
                    // Grid layout for albums
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        ForEach(storeAlbums) { album in
                            VStack {
                                NavigationLink(destination: AlbumDetailView(album: album)) {
                                    VStack {
                                        ZStack(alignment: .bottom) {
                                            Image(album.coverURL ?? "placeholder") // Placeholder image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 180)
                                                .cornerRadius(12)
                                                .clipped()
                                                .shadow(radius: 4)

                                            Text(album.title ?? "Unknown Title")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding(5)
                                                .background(Color.black.opacity(0.7))
                                                .cornerRadius(8)
                                        }

                                        Text(album.artist ?? "Unknown Artist")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .padding(.top, 5)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                }

                                Button(action: {
                                    cartManager.addToCart(album: album)
                                }) {
                                    Text("Add to Cart")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                                }
                                .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(store.name)
    }
}
