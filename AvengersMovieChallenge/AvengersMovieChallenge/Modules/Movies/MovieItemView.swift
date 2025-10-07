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
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: K.imageBasePath + (movie.posterPath ?? ""))) { image in
                    image
                        .resizable()
                        .aspectRatio(163/180, contentMode: .fit)
                } placeholder: {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                .frame(height: 180)
                
                Text(movie.title ?? "")
                    .font(.body)
                    .bold()
                
                HStack {
                    Text(movie.releaseDate ?? "")
                        .font(.caption)
                    Spacer()
                    Image(systemName: "star.fill")
                    Text(String(movie.voteAverage ?? 0))
                        .font(.caption)
                }
                
                Text(movie.overview ?? "")
                    .font(.caption)
            }
            .padding()
            .foregroundStyle(.white)
            .background(Color(.darkGunmetal))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
}

#Preview {
    MovieItemView(movie: Movie(id: 1, title: "Title", overview: "Overview", releaseDate: nil, posterPath: nil, originalLanguage: nil, voteAverage: 5))
}
