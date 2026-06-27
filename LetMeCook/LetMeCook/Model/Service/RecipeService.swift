//
//  RecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

public protocol RecipeService {
    
    func fetchAll() async throws -> [RecipesList]
    
    func fetchRecipe(id: Int) async throws -> RecipeDetails
    
}
