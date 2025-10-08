//
//  MovieItemView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct MovieItemView: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: K.imageBasePath + (movie.posterPath ?? ""))) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .frame(height: 235)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title ?? "")
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.body)
                    .foregroundStyle(Color(.pacificBlue))
                    .bold()
                
                
                HStack {
                    let releaseDate = (movie.releaseDate?.isEmpty == false ? movie.releaseDate : nil) ?? "No disponible"
                    Text(releaseDate)
                        .font(.caption)
                    Spacer()
                    Text(String(format: "⭑ %.1f", movie.voteAverage ?? 0))
                        .foregroundStyle(Color(.pacificBlue))
                        .font(.caption)
                        .bold()
                }
                
                Text(movie.overview ?? "")
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .frame(maxHeight: 96)
        }
        .foregroundStyle(.white)
        .background(Color(.darkGunmetal))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    MovieItemView(movie: Movie(
        id: 1,
        title: "Title",
        overview: "Overview: Avengers was first released in 2012",
        releaseDate: "2024-05-02",
        posterPath: nil,
        originalLanguage: nil,
        voteAverage: 5)
    )
}
