//
//  RecipesList.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

public struct RecipesList: Codable {
    public let dynamicTitle: String
    public let dynamicDescription: String
    public let dynamicThumbnail: String
    public let dynamicThumnailAlt: String
    public let ingredients: [Ingredients]
    public let recipeDetails: RecipeDetails
}

public struct RecipeDetails: Codable {
    public let amountLabel: String
    public let amountNumber: Int32
    public let prepLabel: String
    public let prepTime: String
    public let prepNote: String
    public let cookingLabel: String
    public let cookingTime: String
    public let cookTimeAsMinutes: Int32
    public let prepTimeAsMinutes: Int32
}

public struct Ingredients: Codable {
    public let ingredient: String
}
