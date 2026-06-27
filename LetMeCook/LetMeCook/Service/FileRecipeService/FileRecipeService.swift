//
//  FileRecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

final class FileRecipeService: RecipeService {
    
    func fetchAll() async throws -> [Recipe] {
        let response = try JSONDecoder().decode(RecipeListResponse.self, from: StubRecipes.data)
        return response.recipes.map { Recipe.init(from: $0) }
    }
    
}
