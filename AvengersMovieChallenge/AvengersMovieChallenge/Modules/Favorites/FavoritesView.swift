//
//  FavoritesView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.favorites, id: \.id) { movie in
                            FavoriteItemView(favorite: movie)
                        }
                    }
                    .padding()
                    
                    LazyVStack {
                        if viewModel.isLoading {
                            ProgressView("Loading favorites…")
                        } else if viewModel.favorites.isEmpty {
                            Text("No saved favorites (yet)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("My Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

#Preview {
    FavoritesView()
}
