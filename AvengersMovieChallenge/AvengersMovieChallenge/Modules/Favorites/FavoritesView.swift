//
//  FavoritesView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0..<10) { _ in
                            FavoriteItemView(favorite: Movie(id: 1, title: "The Avengers: The Age of Ultron", overview: "Overview: Avengers was first released in 2012. Connection has no local endpoint", releaseDate: "2024-05-02", posterPath: nil, originalLanguage: nil, voteAverage: 5))
                        }
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("My Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    FavoritesView()
}
