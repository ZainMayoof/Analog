//
//  AlbumDetailView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import SwiftUI

struct AlbumDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    let album: Album

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(album.coverURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 8) {
                    Text(album.title)
                        .font(.title)
                        .bold()

                    Text("by \(album.artist)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(album.genre)
                        .font(.subheadline)

                    Text("Format: \(album.format)")
                        .font(.caption)

                    Text("Price: $\(album.price, specifier: "%.2f")")
                        .font(.headline)
                        .padding(.top, 8)

                    Divider()

                    Button(action: {
                        cartManager.addToCart(album: album)
                    }) {
                        Text("Add to Cart")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("Album Details", displayMode: .inline)
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album(
            id: "1",
            title: "Abbey Road",
            artist: "The Beatles",
            genre: "Rock",
            format: "Vinyl",
            price: 29.99,
            coverURL: "abbey_road",
            storeID: "store1"
        ))
        .environmentObject(CartManager())
    }
}
