//
//  RecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

protocol RecipeService {
    
    func fetchAll(forceRefresh: Bool) async throws -> [Recipe]
    
    func fetchRecipe(_ id: Recipe.ID) async throws -> Recipe.Details
    
}
