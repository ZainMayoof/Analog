//
//  Order.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//



import Foundation
import FirebaseFirestoreSwift

struct Order: Codable, Identifiable {
    @DocumentID var id: String? //  Optional, Firestore auto-generates if nil
    var userID: String
    var items: [CartItemData]
    var total: Double
    var timestamp: Date

    struct CartItemData: Codable {
        var albumID: String
        var quantity: Int
    }
}
