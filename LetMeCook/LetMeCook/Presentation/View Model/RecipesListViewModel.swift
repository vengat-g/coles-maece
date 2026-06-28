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
    private(set) var cardLabel = "RECIPE"
    private(set) var errorMessage: String?
    
    // MARK: Data
    
    private(set) var recipes: [Recipe] = []
    
    var groupedRecipes: [String: [Recipe]] { recipes.groupByServes() }
    
    var recipesByServeSize: [String] { groupedRecipes.keys.sorted() }
    
    // MARK: - Injected
    
    private let service: RecipeService
    
    init(service: RecipeService) {
        self.service = service
    }
    
    // MARK: - Public APIs
    
    func fetchRecipes() async {
        isLoading = true
        do {
            recipes = try await service.fetchAll()
            isLoading = false
        } catch {
            isLoading = false
            // log
            errorMessage = "Something went wrong. Please try again."
        }
    }
    
    func selectedRecipeDetails(for recipeID: Recipe.ID) throws -> RecipeDetailsViewModel {
        guard let selectedRecipe = recipes.first(where: { $0.id == recipeID }) else {
            throw Failure.recipeNotFound
        }
        return RecipeDetailsViewModel(recipe: selectedRecipe)
    }
    
    func recipes(for serveSize: String) -> [Recipe] {
        guard let recipes = groupedRecipes[serveSize] else {
            // log error, no need to disrupt UI.
            return []
        }
        return recipes
    }
    
}

// MARK: - Helpers

extension RecipesListViewModel {
    
    enum Failure: Error, Equatable {
        case recipeNotFound
        case unableToFetchRecipes
    }
    
}


private extension Array where Element == Recipe {
    func groupByServes() -> [String: [Recipe]] {
        Dictionary(grouping: self, by: \.details.serves.value)
    }
}
