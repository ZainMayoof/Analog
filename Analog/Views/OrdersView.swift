//
//  OrdersView.swift
//  Analog
//
//  Created by zain Mayoof on 17/04/2025.
//

import SwiftUI
import FirebaseAuth

struct OrdersView: View {
    @State private var orders: [Order] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading orders...")
                } else if orders.isEmpty {
                    Text("You haven't placed any orders yet.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(orders) { order in
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Order Total: $\(order.total, specifier: "%.2f")")
                                .font(.headline)
                            Text("Placed on \(formattedDate(order.timestamp))")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Items: \(order.items.count)")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("My Orders")
            .onAppear(perform: fetchOrders)
        }
    }

    func fetchOrders() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("❌ User not logged in")
            isLoading = false
            return
        }

        OrderManager().fetchOrders(for: userID) { fetchedOrders in
            DispatchQueue.main.async {
                self.orders = fetchedOrders
                self.isLoading = false
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
