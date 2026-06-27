//
//  FileRecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

enum FileRecipeServiceError: Error {
    case recipeNotFound
}

actor FileRecipeService: RecipeService {
    
    private let decoder: JSONDecoder
    
    private var cachedRecipes: [Recipe] = [] // can be moved to a repository layer
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func fetchAll(forceRefresh: Bool) async throws -> [Recipe] {
        guard forceRefresh, cachedRecipes.isEmpty else {
            return cachedRecipes
        }
        let response = try await decoder.decode(RecipeListResponse.self, from: StubRecipes.data)
        print(response)
        cachedRecipes = response.recipes.map { Recipe.init(from: $0) }
        return cachedRecipes
    }
    
    func fetchRecipe(_ id: Recipe.ID) async throws -> Recipe.Details {
//        guard let recipe = cachedRecipes.first(where: { recipe in recipe.id == id }) else { //}, let details = recipe.details else {
            throw FileRecipeServiceError.recipeNotFound
//        }
//        return recipe.details
    }
    
}
