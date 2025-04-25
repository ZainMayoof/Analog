//
//  StoreListViewModel.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class StoreListViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var stores: [Store] = []
    @Published var filteredStores: [Store] = []
    @Published var searchText: String = ""
    @Published var userLocation: CLLocation?

    private let db = Firestore.firestore()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        fetchStores()
        configureLocation()
    }

    private func configureLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.userLocation = location
            filterStores()
        }
    }

    func fetchStores() {
        db.collection("stores").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching stores: \(error.localizedDescription)")
                return
            }

            self.stores = snapshot?.documents.compactMap {
                try? $0.data(as: Store.self)
            } ?? []

            self.filterStores()
        }
    }

    func filterStores() {
        guard let location = userLocation else {
            filteredStores = stores
            return
        }

        filteredStores = stores.filter {
            searchText.isEmpty ||
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.type.lowercased().contains(searchText.lowercased())
        }.sorted {
            $0.distance(from: location) < $1.distance(from: location)
        }
    }
}
