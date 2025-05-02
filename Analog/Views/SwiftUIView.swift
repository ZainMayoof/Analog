//
//  SwiftUIView.swift
//  Analog
//
//  Created by zain Mayoof on 02/05/2025.
//

import SwiftUI
import MapKit

struct StoreMapListView: View {
    @EnvironmentObject var storeManager: StoreManager
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 26.2, longitude: 50.5),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @State private var selectedStore: Store?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Map with annotations
                Map(coordinateRegion: $region, annotationItems: storeManager.stores) { store in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: store.latitude, longitude: store.longitude)) {
                        Button(action: {
                            selectedStore = store
                        }) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(height: 300)
                .cornerRadius(12)
                .padding(.bottom, 8)

                // Store list below map
                ScrollView {
                    ForEach(storeManager.stores) { store in
                        NavigationLink(destination: StoreDetailView(store: store)) {
                            HStack {
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

                                Spacer()

                                Text("\(store.rating, specifier: "%.1f") ★")
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .navigationTitle("Browse Stores")
            .onAppear {
                storeManager.fetchStores()
            }
        }
    }
}
