//
//  Recipe.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

// MARK: - Domain Responses

struct RecipeListResponse: Decodable {
    let recipes: [RecipeResponse]
}

struct RecipeResponse: Decodable {
    
    let dynamicTitle: String
    
    @LossyField
    var dynamicDescription: String?
    
    let dynamicThumbnail: String
    let dynamicThumbnailAlt: String
    
    let ingredients: [IngredientsResponse]
    let recipeDetails: DetailsResponse
}

extension RecipeResponse {
    
    struct DetailsResponse: Decodable {
        let amountLabel: String
        let amountNumber: Int32
        let prepLabel: String?
        let prepTime: String
        let prepNote: String?
        let cookingLabel: String
        let cookingTime: String
        let cookTimeAsMinutes: Int32
        let prepTimeAsMinutes: Int32
    }
    
    struct IngredientsResponse: Decodable {
        let ingredient: String
    }
    
}
