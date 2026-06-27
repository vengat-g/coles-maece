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
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                        ForEach(viewModel.recipesByServeSize, id: \.self) { serveSize in
                            Section {
                                let recipes = viewModel.recipes(for: serveSize)
                                ForEach(recipes, id: \.id) { recipe in
                                    NavigationLink(value: recipe.id) {
                                        RecipeCardView(cardTitle: viewModel.cardLabel, recipe: recipe)
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
                }
                .navigationTitle("Recipe List")
                .navigationDestination(for: Recipe.ID.self) { recipieID in
                    if let vm = try? viewModel.selectedRecipeDetails(for: recipieID) {
                        RecipeDetailsView(viewModel: vm)
                    } else {
                        Text("Recipe not found alert")
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRecipes()
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchRecipes()
            }
        }
    }
}

private extension RecipeListView {

    var imageURL: URL? {
        URL(string: "https://coles.com.au/content/dam/coles/inspire-create/thumbnails/Lamb-and-hasselback-pumpkin-480x288.jpg")
    }
    
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
