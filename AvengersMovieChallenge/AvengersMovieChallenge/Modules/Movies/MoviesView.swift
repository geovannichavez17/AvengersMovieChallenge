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
                                    viewModel.movieDetailId = item.id
                                }
                        }
                    }
                    .padding()
                    
                    LazyVStack {
                        if !viewModel.isFinished {
                            ProgressView()
                                .onAppear {
                                    viewModel.fetchNowPlaying()
                                }
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $viewModel.movieDetailId) { id in
            MovieDetailsView(viewModel: MovieDetailViewModel(movieId: id))
        }
        .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    //isFavorite.toggle()
                } label: {
                    //Image(systemName: isFavorite ? "heart.fill" : "heart")
                    Image(systemName: "heart")
                }
                /*Menu {
                    Button("Compartir", systemImage: "square.and.arrow.up") { /* … */ }
                    Button("Reportar", systemImage: "exclamationmark.bubble") { /* … */ }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }*/
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        MoviesView()
            /*.tint(.white)
            .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)*/
            
    }
    
}
