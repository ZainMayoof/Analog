//
//  CartManager.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []

    func addToCart(album: Album) {
        if let index = items.firstIndex(where: { $0.album.id == album.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(album: album, quantity: 1))
        }
    }

    func updateQuantity(for item: CartItem, change: Int) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        let newQuantity = items[index].quantity + change
        if newQuantity > 0 {
            items[index].quantity = newQuantity
        } else {
            items.remove(at: index)
        }
    }

    func removeFromCart(item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    func clearCart() {
        items.removeAll()
    }

    func totalCost() -> Double {
        items.reduce(0) { $0 + ($1.album.price * Double($1.quantity)) }
    }
}
