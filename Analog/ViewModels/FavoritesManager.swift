//
//  FavoritesManager.swift
//  Analog
//
//  Created by Zain Mayoof on 18/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FavoritesManager: ObservableObject {
    @Published var favoriteAlbumIDs: Set<String> = []

    private var db = Firestore.firestore()
    private var userID: String? {
        Auth.auth().currentUser?.uid
    }

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        guard let userID = userID else { return }
        db.collection("users").document(userID).collection("favorites").getDocuments { snapshot, error in
            if let docs = snapshot?.documents {
                let ids = docs.map { $0.documentID }
                DispatchQueue.main.async {
                    self.favoriteAlbumIDs = Set(ids)
                    print("❤️ Loaded favorites: \(ids)")
                }
            }
        }
    }

    func toggleFavorite(for albumID: String) {
        guard let userID = userID else { return }

        let ref = db.collection("users").document(userID).collection("favorites").document(albumID)

        if favoriteAlbumIDs.contains(albumID) {
            ref.delete()
            favoriteAlbumIDs.remove(albumID)
            print("💔 Removed favorite:", albumID)
        } else {
            ref.setData([:]) // Empty doc just to store ID
            favoriteAlbumIDs.insert(albumID)
            print("❤️ Added favorite:", albumID)
        }
    }

    func isFavorite(_ albumID: String) -> Bool {
        return favoriteAlbumIDs.contains(albumID)
    }
}
