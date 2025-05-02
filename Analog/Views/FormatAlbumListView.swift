//
//  FormatAlbumListView.swift
//  Analog
//
//  Created by Zain Mayoof on 02/05/2025.
//

import SwiftUI

struct FormatAlbumListView: View {
    let format: String
    @EnvironmentObject var albumManager: AlbumManager

    var filteredAlbums: [Album] {
        albumManager.albums.filter { $0.format.lowercased() == format.lowercased() }
    }

    var body: some View {
        List(filteredAlbums) { album in
            NavigationLink(destination: AlbumDetailView(album: album)) {
                HStack {
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
        .navigationTitle("\(format.capitalized) Albums")
    }
}
