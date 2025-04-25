//
//  Store.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift

struct Store: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let imageName: String
    let location: String       // e.g. "London"
    let type: String           // e.g. "Vinyl", "Cassette"
    let rating: Double         // average rating (0.0–5.0)
    let latitude: Double
    let longitude: Double

    func distance(from userLocation: CLLocation) -> Double {
        let storeLocation = CLLocation(latitude: latitude, longitude: longitude)
        return userLocation.distance(from: storeLocation) / 1000 // km
    }
}
