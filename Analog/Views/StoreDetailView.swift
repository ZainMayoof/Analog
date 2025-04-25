//
//  StoreDetailView.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

//
//  StoreDetailView.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import SwiftUI

struct StoreDetailView: View {
    let store: Store
    @StateObject private var reviewManager = ReviewManager()
    @State private var rating = 4
    @State private var comment = ""

    // Filter albums by this store
    var storeAlbums: [Album] {
        mockAlbums.filter { $0.storeID == (store.id ?? "") }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 🖼 Store Image
                Image(store.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 6) {
                    Text(store.name)
                        .font(.title)
                        .bold()
                    Text("📍 \(store.location)")
                        .font(.subheadline)
                    Text("⭐️ \(String(format: "%.1f", store.rating)) • \(store.type)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Divider().padding(.horizontal)

                // 🎧 Albums
                VStack(alignment: .leading, spacing: 10) {
                    Text("Albums")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(storeAlbums) { album in
                        NavigationLink(destination: AlbumDetailView(album: album)) {
                            HStack(spacing: 12) {
                                Image(album.coverURL)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(album.title)
                                        .font(.headline)
                                    Text(album.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }

                    if storeAlbums.isEmpty {
                        Text("No albums available.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }

                Divider().padding(.horizontal)

                // ✍️ Review Form
                VStack(alignment: .leading, spacing: 8) {
                    Text("Write a Review")
                        .font(.headline)

                    Stepper("Rating: \(rating)", value: $rating, in: 1...5)

                    TextField("Your comment...", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Submit Review") {
                        reviewManager.submitReview(for: store.id ?? "", rating: rating, comment: comment) { success in
                            if success {
                                comment = ""
                                rating = 4
                            }
                        }
                    }
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()

                Divider().padding(.horizontal)

                // 💬 Reviews
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
            reviewManager.fetchReviews(for: store.id ?? "")
        }
        .navigationTitle(store.name)
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStore = Store(
            id: "store1",
            name: "Virgin Megastore City Centre",
            imageName: "store1",
            location: "Manama, Bahrain",
            type: "Music Retail",
            rating: 4.8,
            latitude: 26.2336,
            longitude: 50.5875
        )
        StoreDetailView(store: sampleStore)
    }
}
