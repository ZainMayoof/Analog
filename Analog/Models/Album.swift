//
//  Album.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//


// The Album model struct with properties like title, artist, price, etc.

struct Album: Identifiable, Codable {
    var id: String
    var title: String
    var artist: String
    var genre: String
    var format: String
    var price: Double
    var coverURL: String
    var storeID: String
    var description: String? // Add this if using it
}

