//
//  MoviesView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    private let columns = [
        GridItem(.flexible(minimum: 16)),
        GridItem(.flexible(minimum: 16)),
    ]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.movies) { item in
                            MovieItemView(movie: item)
                                .frame(height: 350)
                                .onTapGesture {
                                    viewModel.selectedMovie = item
                                }
                        }
                    }
                    .padding()
                    .alert(K.errorTitle, isPresented: $viewModel.showError) {
                        Button("Aceptar", role: .cancel) { }
                    } message: {
                        Text(viewModel.errorMessage)
                    }
                    
                    LazyVStack {
                        if !viewModel.isFinished {
                            ProgressView()
                                .onAppear {
                                    guard !viewModel.isLoading, !viewModel.isFinished else { return }
                                    viewModel.fetchMovies()
                                }
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $viewModel.selectedMovie) { movie in
            MovieDetailsView(viewModel: MovieDetailViewModel(movie: movie))
        }
        .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    FavoritesView()
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .accessibilityLabel("Favoritos")
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        MoviesView()
            
    }
    
}
