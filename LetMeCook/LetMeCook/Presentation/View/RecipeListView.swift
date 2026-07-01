//
//  RecipeListView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct RecipeListView: View {
    
    var viewModel: RecipesListViewModel
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.recipesByServeSize, id: \.self) { serveSize in
                            Section {
                                let recipes = viewModel.recipes(for: serveSize)
                                ForEach(recipes, id: \.id) { recipe in
                                    NavigationLink(value: recipe.id) {
                                        RecipeCardView(
                                            cardTitle: viewModel.cardLabel,
                                            recipeTitle: recipe.title,
                                            recipeImagePhase: viewModel.imageData(for: recipe.id)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            } header: {
                                Text("Serves: \(serveSize)")
                                    .font(.headline)
                            }
                        }
                        
                    }
                    .padding()
                    .navigationTitle("Recipe List")
                    .navigationDestination(for: Recipe.ID.self) { recipeID in
                        if let vm = try? viewModel.selectedRecipeDetails(for: recipeID) {
                            RecipeDetailsView(viewModel: vm)
                        } else {
                            Text("Recipe not found alert")
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

private extension RecipeListView {

    var columns: [GridItem] {
        if verticalSizeClass == .compact {
            // iPhone landscape
            return [GridItem(.flexible()), GridItem(.flexible())]
        } else if horizontalSizeClass == .regular {
            // iPad (portrait or landscape)
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            // iPhone portrait
            return [GridItem(.flexible())]
        }
    }

}

#Preview {
    let viewModel = RecipesListViewModel(service: FileRecipeService())
    RecipeListView(viewModel: viewModel)
}
