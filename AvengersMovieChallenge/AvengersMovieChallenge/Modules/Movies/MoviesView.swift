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
            Color.yellow.ignoresSafeArea(.all)
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.nowPlaying) { item in
                            MovieItemView(movie: item)
                                .frame(height: 350)
                                .onTapGesture {
                                    viewModel.movieDetailId = item.id
                                }
                        }
                    }
                    
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
            .padding()
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.darkGunmetal), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
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
