//
//  AlbumViewModel.swift
//  Analog
//
//  Created by zain Mayoof on 25/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class AlbumViewModel: ObservableObject {
    @Published var albums: [Album] = []
    
    private var db = Firestore.firestore()
    
    func fetchAlbums() {
        db.collection("albums").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching albums:", error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("❌ No documents found")
                return
            }
            
            self.albums = documents.compactMap { doc in
                try? doc.data(as: Album.self)
            }
            print("✅ Loaded \(self.albums.count) albums from Firestore")
        }
    }
}

