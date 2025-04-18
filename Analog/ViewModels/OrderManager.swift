//
//  OrderManager.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class OrderManager {
    let db = Firestore.firestore()

    func placeOrder(cartItems: [CartItem], total: Double, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("❌ User not logged in")
            completion(false)
            return
        }

        let items = cartItems.map { item in
            Order.CartItemData(albumID: item.album.id, quantity: item.quantity)
        }

        let order = Order(userID: userID, items: items, total: total, timestamp: Date())

        do {
            print("📤 Saving order for userID:", userID)
            try db.collection("orders").document(order.id ?? UUID().uuidString).setData(from: order)
            print("✅ Order saved")
            completion(true)
        } catch {
            print("🔥 Firestore error:", error.localizedDescription)
            completion(false)
        }
    }

    func fetchOrders(for userID: String, completion: @escaping ([Order]) -> Void) {
        db.collection("orders")
            .whereField("userID", isEqualTo: userID)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Failed to fetch orders: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let orders: [Order] = documents.compactMap { doc in
                    try? doc.data(as: Order.self)
                }

                print("📦 Loaded \(orders.count) orders")
                completion(orders)
            }
    }
}
