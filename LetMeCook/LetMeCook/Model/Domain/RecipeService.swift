//
//  RecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

protocol RecipeService {
    
    func fetchAll() async throws -> [Recipe]
    
}
