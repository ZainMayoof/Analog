//
//  CartView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//
import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            List {
                ForEach(cartManager.items) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.album.title)
                            .font(.headline)

                        HStack {
                            Button(action: {
                                if item.quantity > 1 {
                                    cartManager.updateQuantity(for: item, change: -1)
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }

                            Text("Qty: \(item.quantity)")
                                .font(.subheadline)
                                .frame(minWidth: 40)

                            Button(action: {
                                cartManager.updateQuantity(for: item, change: 1)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                            }

                            Spacer()

                            Text("$\(item.album.price * Double(item.quantity), specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                    .padding(.vertical, 6)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let item = cartManager.items[index]
                        cartManager.removeFromCart(item: item)
                    }
                }

                // ✅ Total and Checkout
                if !cartManager.items.isEmpty {
                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            Text("Total: $\(cartManager.totalCost(), specifier: "%.2f")")
                                .font(.headline)
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                let orderManager = OrderManager()
                                orderManager.placeOrder(cartItems: cartManager.items, total: cartManager.totalCost()) { success in
                                    if success {
                                        cartManager.clearCart()
                                    } else {
                                        print("❌ Order failed to save")
                                    }
                                }
                            }) {
                                Text("Checkout")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Your Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear") {
                        cartManager.clearCart()
                    }
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
