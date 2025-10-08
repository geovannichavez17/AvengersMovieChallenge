//
//  FavoriteItemView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 8/10/25.
//

import SwiftUI

struct FavoriteItemView: View {
    var favorite: Movie
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: K.imageBasePath + (favorite.posterPath ?? ""))) { image in
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
            .frame(maxWidth: 175)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(favorite.title ?? "")
                    .lineLimit(2)
                    .font(.body)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String(format: "Vote average: ⭑ %.1f", favorite.voteAverage ?? 0))
                    .font(.caption)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Release:")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    let releaseDate = (favorite.releaseDate?.isEmpty == false ? favorite.releaseDate?.prefix(4) : nil) ?? "Not available"
                    Text(releaseDate)
                        .font(.caption)
                        .foregroundStyle(((favorite.releaseDate?.isEmpty) != nil) ? .ufoGreen : .white)
                }
                
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
            .frame(maxWidth: .infinity, maxHeight: 96)
        }
        .frame(height: 110)
        .foregroundStyle(.white)
        .background(Color(.darkGunmetal))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    FavoriteItemView(favorite: Movie(id: 1, title: "The Avengers: The Age of Ultron", overview: "Overview: Avengers was first released in 2012. Connection has no local endpoint", releaseDate: "2024-05-02", posterPath: nil, originalLanguage: nil, voteAverage: 5))
}
