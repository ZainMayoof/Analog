//
//  StoreManager.swift
//  Analog
//
//  Created by zain Mayoof on 25/04/2025.
//

// StoreManager.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class StoreManager: ObservableObject {
    @Published var stores: [Store] = []

    private let db = Firestore.firestore()

    func fetchStores() {
        db.collection("stores").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching stores: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                self.stores = []
                return
            }

            self.stores = documents.compactMap { doc in
                try? doc.data(as: Store.self)
            }

            print("✅ Loaded \(self.stores.count) stores from Firestore")
        }
    }
}
