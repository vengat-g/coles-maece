//
//  AppConfiguration+RecipesListViewModel.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

extension AppConfiguration {
    
    func makeRecipeListViewModel() -> RecipesListViewModel {
        RecipesListViewModel(service: recipeService)
    }
    
}
