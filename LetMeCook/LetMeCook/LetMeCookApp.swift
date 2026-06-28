//
//  LetMeCookApp.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

@main
struct LetMeCookApp: App {
    
    private let configuration = AppConfiguration(recipeService: FileRecipeService())
    
    var body: some Scene {
        WindowGroup {
            LetMeCookRootView()
                .environment(configuration)
        }
    }
    
}

// MARK: - Root View

struct LetMeCookRootView: View {
    
    @Environment(AppConfiguration.self) private var configuration
    @State private var viewModel: RecipesListViewModel?
    
    var body: some View {
        Group {
            if let viewModel {
                RecipeListView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel = configuration.makeRecipeListViewModel()
        }
    }
    
}
