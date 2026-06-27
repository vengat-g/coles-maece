//
//  RecipeResponseMapper.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

extension Recipe {
    
    nonisolated init(from response: RecipeResponse) {
        self.id = UUID()
        self.title = response.dynamicTitle
        self.description = response.dynamicDescription
        self.thumbnail = response.dynamicThumbnail
        self.thumbnailAlt = response.dynamicThumbnailAlt
        self.ingredients = response.ingredients.map(\.ingredient)
        self.details = Recipe.Details(from: response.recipeDetails)
    }
    
}

extension Recipe.Details {
    
    nonisolated init(from response: RecipeResponse.DetailsResponse) {
        self.serves = Recipe.ServesDetail(label: response.amountLabel, value: response.amountNumber)
        self.prep = Recipe.PrepDetail(label: response.prepLabel ?? "", value: response.prepTime, notes: response.prepNote)
        self.cooking = Recipe.CookingDetail(label: response.cookingLabel, value: response.cookingTime)
    }
    
}
