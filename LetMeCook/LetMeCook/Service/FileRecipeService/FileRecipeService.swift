//
//  FileRecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

enum FileRecipeServiceError: Error {
    case failedToLoadData(String)
}

final class FileRecipeService: RecipeService {
    
    private let data: Data
    
    init(data: Data = StubRecipes.data) {
        self.data = data
    }
    
    func fetchAll() async throws -> [Recipe] {
        do {
            let response = try JSONDecoder().decode(RecipeListResponse.self, from: data)
            return response.recipes.map { Recipe.init(from: $0) }
        } catch {
            throw FileRecipeServiceError.failedToLoadData(error.localizedDescription)
        }
    }
    
}

extension FileRecipeServiceError: Equatable {}
