//
//  StoreListView.swift
//  Analog
//
//  Created by zain Mayoof on 16/04/2025.
//

import SwiftUI

struct StoreListView: View {
    @StateObject private var viewModel = StoreListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by name or type", text: $viewModel.searchText)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.filterStores()
                    }

                List(viewModel.filteredStores) { store in
                    NavigationLink(destination: StoreDetailView(store: store)) {
                        HStack {
                            Image(store.imageName) // replace with AsyncImage if from URL
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(store.name)
                                    .font(.headline)
                                Text(store.type)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                if let userLoc = viewModel.userLocation {
                                    Text("\(String(format: "%.2f", store.distance(from: userLoc))) km away")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }

                            Spacer()
                            Text("⭐️ \(String(format: "%.1f", store.rating))")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Browse Shops")
        }
    }
}
