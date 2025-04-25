//
//  ReviewManager.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewManager: ObservableObject {
    private let db = Firestore.firestore()

    @Published var reviews: [Review] = []

    // MARK: - Store Reviews

    func fetchReviews(for storeID: String) {
        db.collection("reviews")
            .whereField("storeID", isEqualTo: storeID)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Error fetching store reviews:", error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    self.reviews = []
                    return
                }

                self.reviews = documents.compactMap { doc in
                    try? doc.data(as: Review.self)
                }
            }
    }

    func submitReview(for storeID: String, rating: Int, comment: String, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("❌ User not logged in")
            completion(false)
            return
        }

        let review = Review(
            storeID: storeID,
            albumID: nil,
            userID: user.uid,
            userEmail: user.email ?? "Unknown",
            rating: rating,
            comment: comment,
            timestamp: Date()
        )

        do {
            try db.collection("reviews").addDocument(from: review)
            print("✅ Store review submitted!")
            completion(true)
        } catch {
            print("❌ Error saving store review:", error.localizedDescription)
            completion(false)
        }
    }

    // MARK: - Album Reviews

    func fetchReviewsForAlbum(albumID: String) {
        db.collection("reviews")
            .whereField("albumID", isEqualTo: albumID)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Error fetching album reviews:", error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    self.reviews = []
                    return
                }

                self.reviews = documents.compactMap { doc in
                    try? doc.data(as: Review.self)
                }
            }
    }

    func submitAlbumReview(albumID: String, rating: Int, comment: String, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("❌ User not logged in")
            completion(false)
            return
        }

        let review = Review(
            storeID: nil,
            albumID: albumID,
            userID: user.uid,
            userEmail: user.email ?? "Unknown",
            rating: rating,
            comment: comment,
            timestamp: Date()
        )

        do {
            try db.collection("reviews").addDocument(from: review)
            print("✅ Album review submitted!")
            completion(true)
        } catch {
            print("❌ Error saving album review:", error.localizedDescription)
            completion(false)
        }
    }
}
