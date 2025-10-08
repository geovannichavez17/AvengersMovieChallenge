//
//  MovieDetailsView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailViewModel
        
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    movieHeader
                    
                    VStack(alignment: .leading, spacing: 16) {
                        summary
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .alert(K.errorTitle, isPresented: $viewModel.showError) {
                    Button("Aceptar", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage)
                }
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                viewModel.fetchMovieInformation()
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    private var movieHeader: some View {
        AsyncImage(url: URL(string: K.imageBasePath + (viewModel.movieDetail?.backgroundImage ?? ""))) { image in
            image
                .resizable()
        } placeholder: {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .frame(height: 200)
        
        HStack {
            Spacer()
            Text(String(format: "%.1f", viewModel.movieDetail?.voteAverage ?? 0))
                .padding()
                .background(Color.pacificBlue)
                .clipShape(Circle())
                .offset(y: -25)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var summary: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sinópsis")
                    .font(.title2)
                    .foregroundStyle(Color(.pacificBlue))
                    .bold()
                Text(viewModel.movieDetail?.title ?? "-")
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .bold()
            }
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(Color(.pacificBlue))
                    .font(.title)
            }

        }
        
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Trama")
                .font(.headline)
                .foregroundStyle(Color(.lightGray))
                .bold()
            Text(viewModel.movieDetail?.overview ?? "-")
                .font(.body)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailViewModel(
        movie: Movie(id: 1, title: "The Avengers: The Age of Ultron", overview: "Overview: Avengers was first released in 2012. Connection has no local endpoint", releaseDate: "2024-05-02", posterPath: nil, originalLanguage: nil, voteAverage: 5)))
}
