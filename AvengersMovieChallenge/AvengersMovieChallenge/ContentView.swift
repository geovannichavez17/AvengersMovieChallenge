//
//  ContentView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct ContentView: View {
    /*init() {
        //UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.init(.darkGunmetal))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        //UINavigationBar.appearance().tintColor = .white
    }*/
    var body: some View {
        NavigationStack {
            MoviesView()
        }
        .navigationBarTitleDisplayMode(.inline) // opcional: evita título grande
        .toolbarBackground(.hidden, for: .navigationBar) // fondo de la barra transparente
        .toolbarColorScheme(.dark, for: .navigationBar)  // espera contenido claro (mejora contraste)
        .tint(.white) // color del chevron y texto “Back”
        
        
    }
}

#Preview {
    ContentView()
}
