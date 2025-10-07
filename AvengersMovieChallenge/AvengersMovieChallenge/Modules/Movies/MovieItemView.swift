//
//  MovieItemView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct MovieItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                    Rectangle()
                    .frame(height: 180)
                    
                    Text("Prueba" ?? "")
                        .font(.body)
                        .bold()
                    
                    HStack {
                        Text("ReleaseDate" ?? "")
                            .font(.caption)
                        Spacer()
                        Image(systemName: "star.fill")
                        Text(String("5.2"))
                            .font(.caption)
                    }
                    
                    Text("Very bad movie" ?? "")
                        .font(.caption)
                }
                .padding()
                .foregroundStyle(.white)
                .background(Color.darkGunmetal)
                .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    MovieItemView()
}
