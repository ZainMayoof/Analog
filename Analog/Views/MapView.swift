//
//  MapView.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = StoreListViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 26.2, longitude: 50.5),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    @State private var selectedStore: Store?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: viewModel.filteredStores) { store in
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
            .onAppear {
                viewModel.fetchStores()
            }

            // Show overlay only if a store is selected
            if let store = selectedStore {
                VStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Text(store.name)
                            .font(.headline)

                        Text("⭐️ \(String(format: "%.1f", store.rating)) • \(store.type)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Button("Open in Maps") {
                            openInMaps(store: store)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding(.bottom, 30)
                    .onTapGesture {
                        selectedStore = nil
                    }
                }
            }
        }
        .navigationTitle("Store Map")
    }

    func openInMaps(store: Store) {
        let coordinate = CLLocationCoordinate2D(latitude: store.latitude, longitude: store.longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = store.name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

