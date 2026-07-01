//
//  LetMeCookApp.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

@main
struct LetMeCookApp: App {
    
    var body: some Scene {
        WindowGroup {
            LetMeCookRootView()
        }
    }
    
}

// MARK: - Root View

struct LetMeCookRootView: View {
    
    @State private var viewModel = RecipesListViewModel(service: DefaultRecipeService())
    
    var body: some View {
        RecipeListView(viewModel: viewModel)
    }
    
}
