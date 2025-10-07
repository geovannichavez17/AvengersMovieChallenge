//
//  ContentView.swift
//  AvengersMovieChallenge
//
//  Created by Geovanni Chavez Escalante on 6/10/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        /*UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]*/
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.init(.darkGunmetal))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        //UINavigationBar.appearance().tintColor = .white
    }
    var body: some View {
        NavigationStack {
            MoviesView()
        }
    }
}

#Preview {
    ContentView()
}
