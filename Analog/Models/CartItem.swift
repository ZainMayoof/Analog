//
//  CartItem.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let album: Album
    var quantity: Int
}
