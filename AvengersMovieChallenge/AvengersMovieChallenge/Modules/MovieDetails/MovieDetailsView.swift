//
//  MovieDetailsView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct MovieDetailsView: View {
    /*@State private var previousStandard: UINavigationBarAppearance?
    @State private var previousScroll: UINavigationBarAppearance?
    @State private var previousTint: UIColor?*/
    
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
                            
                            /*Spacer()
                                .frame(height: 16)
                            
                            videos
                            
                            Spacer()
                                .frame(height: 16)
                            
                            crewList*/
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
            .navigationBarTitleDisplayMode(.inline) // evita la apariencia de scroll edge
                    .toolbarBackground(.hidden, for: .navigationBar)
            /*
            .navigationBarTitleDisplayMode(.inline) // opcional: evita título grande
            .toolbarBackground(.hidden, for: .navigationBar) // fondo de la barra transparente
            .toolbarColorScheme(.dark, for: .navigationBar)  // espera contenido claro (mejora contraste)
            .tint(.white) // color del chevron y texto “Back”
            */
            
            /*.onAppear {
                let navBar = UINavigationBar.appearance()
                
                // Guardar estado previo para restaurar
                previousStandard = navBar.standardAppearance
                previousScroll   = navBar.scrollEdgeAppearance
                previousTint     = navBar.tintColor
                
                // Crear apariencia transparente
                let transparent = UINavigationBarAppearance()
                transparent.configureWithTransparentBackground()
                transparent.backgroundColor = .clear
                transparent.backgroundEffect = nil
                transparent.shadowColor = .clear // sin línea inferior
                transparent.titleTextAttributes = [.foregroundColor: UIColor.white]
                transparent.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
                navBar.standardAppearance = transparent
                navBar.scrollEdgeAppearance = transparent
                navBar.compactAppearance = transparent
                navBar.tintColor = .white // chevron y texto “Back”
            }
            .onDisappear {
                // Restaurar estado previo
                let navBar = UINavigationBar.appearance()
                if let prev = previousStandard { navBar.standardAppearance = prev }
                if let prev = previousScroll   { navBar.scrollEdgeAppearance = prev }
                navBar.tintColor = previousTint
            }*/
            
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
                
                Image(systemName: "heart")
                    .foregroundStyle(Color.white)
                    .font(.title)
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
        
        /*@ViewBuilder
        private var videos: some View {
            VStack(alignment: .leading, spacing:16) {
                Text("Trailer")
                    .font(.title2)
                    .foregroundStyle(Color.tertiaryFixed)
                    .bold()
                
                GeometryReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.movieVideos) { video in
                                YouTubeView(videoId: video.key)
                                    .frame(width: proxy.size.width, height: 200)
                            }
                        }
                    }
                }
                .frame(height: 200)
            }
        }
        
        @ViewBuilder
        private var crewList: some View {
            VStack(alignment: .leading, spacing:16) {
                Text("Crew")
                    .font(.title2)
                    .foregroundStyle(Color.tertiaryFixed)
                    .bold()
                
                GeometryReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.crewList) { crew in
                                CrewView(crew: crew)
                                    .frame(width: 150, height: 150)
                            }
                        }
                    }
                }
                .frame(height: 200)
            }
        }*/
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailViewModel(movieId: 1011985))
}
