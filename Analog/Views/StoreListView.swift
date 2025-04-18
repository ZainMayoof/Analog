//
//  StoreListView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import SwiftUI

struct StoreListView: View {
    let stores: [Store] = [
        Store(id: "store1", name: "Vinyl Vault", imageName: "store1", location: "New York"),
        Store(id: "store2", name: "Cassette Corner", imageName: "store2", location: "Los Angeles"),
        Store(id: "store3", name: "CD Central", imageName: "store3", location: "Chicago")
    ]

    var body: some View {
        List(stores) { store in
            NavigationLink(destination: StoreDetailView(store: store)) {
                HStack(spacing: 12) {
                    Image(store.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(store.name)
                            .font(.headline)
                        Text(store.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Browse Stores")
    }
}
