//
//  AlbumDetailView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//


import SwiftUI

struct AlbumDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favoritesManager: FavoritesManager
    let album: Album

    @StateObject private var reviewManager = ReviewManager()
    @State private var rating = 4
    @State private var comment = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 🎨 Album Cover
                Image(album.coverURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .cornerRadius(10)

                // 📀 Album Details
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(album.title)
                            .font(.title)
                            .bold()

                        Spacer()

                        Button(action: {
                            favoritesManager.toggleFavorite(for: album.id)
                        }) {
                            Image(systemName: favoritesManager.isFavorite(album.id) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        .padding(.trailing, 8)
                    }

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

                Divider().padding(.top)

                // ✍️ Review Form
                VStack(alignment: .leading, spacing: 8) {
                    Text("Write a Review")
                        .font(.headline)

                    Stepper("Rating: \(rating)", value: $rating, in: 1...5)

                    TextField("Your thoughts...", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Submit Review") {
                        reviewManager.submitAlbumReview(albumID: album.id, rating: rating, comment: comment) { success in
                            if success {
                                comment = ""
                                rating = 4
                            }
                        }
                    }
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()

                Divider().padding(.horizontal)

                // 💬 Review List
                VStack(alignment: .leading, spacing: 10) {
                    Text("Reviews")
                        .font(.headline)
                        .padding(.horizontal)

                    if reviewManager.reviews.isEmpty {
                        Text("No reviews yet.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        ForEach(reviewManager.reviews) { review in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("⭐️ \(review.rating) by \(review.userEmail)")
                                    .font(.subheadline)
                                    .bold()
                                Text(review.comment)
                                    .font(.body)
                                Text(review.timestamp.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            reviewManager.fetchReviewsForAlbum(albumID: album.id)
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
        .environmentObject(FavoritesManager())
    }
}
