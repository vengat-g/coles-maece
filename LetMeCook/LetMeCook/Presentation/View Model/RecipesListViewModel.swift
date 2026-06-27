//
//  RecipesListViewModel.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

@MainActor
@Observable
final class RecipesListViewModel {
    
    // MARK: States
    
    private(set) var isLoading = false
    private(set) var recipes: [Recipe] = []
    
    
    // MARK: - Injected
    
    private let service: RecipeService
    
    init(service: RecipeService) {
        self.service = service
    }
    
    // MARK: - Public APIs
    
    func fetchRecipes() async {
        isLoading = true
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            recipes = try await service.fetchAll()
            isLoading = false
        } catch {
            isLoading = false
            // log
            print(error.localizedDescription)
        }
    }
    
    func selectedRecipeDetails(for recipeID: Recipe.ID) throws -> RecipeDetailsViewModel {
        guard let selectedRecipe = recipes.first(where: { $0.id == recipeID }) else {
            throw Failure.recipeNotFound
        }
        return RecipeDetailsViewModel(recipe: selectedRecipe)
    }
    
}

// MARK: - Helpers

extension RecipesListViewModel {
    
    enum Failure: Error {
        case recipeNotFound
        case unableToFetchRecipes
    }
    
}
