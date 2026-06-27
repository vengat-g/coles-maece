//
//  ContentView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct ContentView: View {
    var viewModel = RecipesListViewModel(service: FileRecipeService(decoder: JSONDecoder()))
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    ContentView()
}
