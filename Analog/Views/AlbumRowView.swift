//
//  AlbumRowView.swift
//  Analog
//
//  Created by zain Mayoof on 02/05/2025.
//
import SwiftUI

struct AlbumRowView: View {
    let title: String
    let albums: [Album]
    let seeAllDestination: AnyView

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.title2.bold())
                Spacer()
                NavigationLink(destination: seeAllDestination) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(albums.prefix(10)) { album in
                        NavigationLink(destination: AlbumDetailView(album: album)) {
                            VStack(alignment: .leading) {
                                Image(album.coverURL)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)

                                Text(album.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(album.artist)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 120)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
