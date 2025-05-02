//
//  FavoritesView.swift
//  Analog
//
//  Created by zain Mayoof on 25/04/2025.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @EnvironmentObject var albumManager: AlbumManager

    var favoriteAlbums: [Album] {
        albumManager.albums.filter {
            if let id = $0.id {
                return favoritesManager.favoriteAlbumIDs.contains(id)
            }
            return false
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if favoriteAlbums.isEmpty {
                    Text("You have no favorites yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(favoriteAlbums) { album in
                        NavigationLink(destination: AlbumDetailView(album: album)) {
                            HStack(spacing: 16) {
                                Image(album.coverURL)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(album.title)
                                        .font(.headline)
                                    Text(album.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            .padding(.vertical, 4)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("My Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesManager())
            .environmentObject(AlbumManager())
    }
}
