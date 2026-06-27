//
//  RecipesListViewModel.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

@Observable
final class RecipesListViewModel {
    
    // MARK: - Injected
    
    private let service: RecipeService
    
    init(service: RecipeService) {
        self.service = service
    }
    
    // MARK: - Public APIs
    
    func fetchRecipes() async {
        do {
            let recipes = try await service.fetchAll(forceRefresh: true)
            print(recipes)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
