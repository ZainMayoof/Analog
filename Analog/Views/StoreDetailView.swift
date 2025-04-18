//
//  StoreDetailView.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

// TEMPORARY

import SwiftUI

struct StoreDetailView: View {
    let store: Store

    // Filter albums by this store
    var storeAlbums: [Album] {
        mockAlbums.filter { $0.storeID == store.id }
    }

    var body: some View {
        List(storeAlbums) { album in
            NavigationLink(destination: AlbumDetailView(album: album)) {
                HStack(spacing: 16) {
                    Image(album.coverURL)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(album.title)
                            .font(.headline)
                        Text(album.artist)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(store.name)
    }
}
