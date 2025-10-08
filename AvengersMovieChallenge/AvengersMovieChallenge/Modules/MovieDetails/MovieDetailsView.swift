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
                .background(Color.ufoGreen)
                .clipShape(Circle())
                .offset(y: -25)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var summary: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Summary")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .bold()
                Text(viewModel.movieDetail?.title ?? "-")
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .bold()
            }
            
            Spacer()
            
            Button {
                print("Pressed fav…")
            } label: {
                Image(systemName: "heart")
                    .foregroundStyle(Color.white)
                    .font(.title)
            }

        }
        
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Overview")
                .font(.headline)
                .foregroundStyle(Color.white)
                .bold()
            Text(viewModel.movieDetail?.overview ?? "-")
                .font(.body)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailViewModel(movieId: 1011985))
}
