//
//  Album.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Album: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var artist: String
    var genre: String
    var format: String
    var price: Double
    var coverURL: String
    var storeID: String   //  Lowercase here
    var featured: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artist
        case genre
        case format
        case price
        case coverURL
        case storeID = "storeID"   //  Map the Firestore field to this property
        case featured
    }
}

