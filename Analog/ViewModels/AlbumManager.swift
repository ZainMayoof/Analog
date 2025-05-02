//
//  AlbumManager.swift
//  Analog
//
//  Created by Zain Mayoof on 25/04/2025.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class AlbumManager: ObservableObject {
    private let db = Firestore.firestore()

    @Published var albums: [Album] = []

    func fetchAllAlbums() {
        db.collection("albums").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching albums: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                self.albums = []
                return
            }

            var loadedAlbums: [Album] = []

            for doc in documents {
                print("📄 Raw Firestore doc: \(doc.documentID) => \(doc.data())")

                do {
                    let album = try doc.data(as: Album.self)
                    loadedAlbums.append(album)
                } catch {
                    print("❌ Failed to decode album document: \(doc.documentID) — \(error.localizedDescription)")
                }
            }

            DispatchQueue.main.async {
                self.albums = loadedAlbums
                print("✅ Loaded \(loadedAlbums.count) album(s) successfully")
            }
        }
    }
}
