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
                            ProgressView("Cargando favoritos…")
                        } else if viewModel.favorites.isEmpty {
                            Text("Sin favoritos aún")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .alert(K.errorTitle, isPresented: $viewModel.showError) {
                        Button("Aceptar", role: .cancel) { }
                    } message: {
                        Text(viewModel.errorMessage)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Mis Favoritos")
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
