//
//  RecipeDetailsViewModel.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

@MainActor
@Observable
final class RecipeDetailsViewModel {
    
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
}

extension RecipeDetailsViewModel {
    
    var imageURL: URL? { recipe.thumbnailURL }
    
    var title: String { recipe.title }
    
    var description: String? { recipe.description }
    
    var ingredients: [String] { recipe.ingredients }
    
    var serves: (title: String, value: String) {
        (recipe.details.serves.label, String(recipe.details.serves.value))
    }
    
    var prep: (title: String, value: String) {
        (recipe.details.prep.label, recipe.details.prep.value)
    }
    
    var cooking: (title: String, value: String) {
        (recipe.details.cooking.label, recipe.details.cooking.value)
    }
    
}
