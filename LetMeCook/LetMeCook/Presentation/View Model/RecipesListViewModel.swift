//
//  RecipesListViewModel.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

@MainActor
@Observable
final class RecipesListViewModel {
    
    // MARK: States
    
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    let cardLabel = "RECIPE"
    
    // MARK: Data
    
    private(set) var recipes: [Recipe] = []
    private(set) var groupedRecipes: [String: [Recipe]] = [:]
    private(set) var recipesByServeSize: [String] = []
    private(set) var imageDataLookup: [Recipe.ID: ImagePhase] = [:]
    
    // MARK: - Injected
    
    private let service: RecipeService
    private let imageLoader: ImageDataLoader
    
    init(service: RecipeService, imageLoader: ImageDataLoader = DefaultImageDataLoader()) {
        self.service = service
        self.imageLoader = imageLoader
    }
    
    // MARK: - Public APIs
    
    func fetchRecipes() async {
        guard recipes.isEmpty else { return }
        
        isLoading = true
        do {
            recipes = try await service.fetchAll()
            groupedRecipes = recipes.groupByServes()
            recipesByServeSize = groupedRecipes.keys.sorted()
        } catch {
            // log
            errorMessage = "Something went wrong. Please try again."
        }
        isLoading = false
        await fetchImages()
    }
    
    func imageData(for id: Recipe.ID) -> ImagePhase? {
        imageDataLookup[id]
    }
    
    func selectedRecipeDetails(for recipeID: Recipe.ID) throws -> RecipeDetailsViewModel {
        guard let selectedRecipe = recipes.first(where: { $0.id == recipeID }) else {
            throw Failure.recipeNotFound
        }
        return RecipeDetailsViewModel(recipe: selectedRecipe)
    }
    
    func recipes(for serveSize: String) -> [Recipe] {
        guard let recipes = groupedRecipes[serveSize] else {
            // log error, no need to disrupt UI.
            return []
        }
        return recipes
    }
    
}

// MARK: - Helpers

extension RecipesListViewModel {
    
    enum Failure: Error, Equatable {
        case recipeNotFound
        case unableToFetchRecipes
    }
    
    enum ImagePhase: Equatable {
        case failed
        case fetched(Data)
    }
    
    func fetchImages() async {
        typealias ImageResponse = (id: Recipe.ID, data: Data?)
        await withTaskGroup(of: ImageResponse.self) { group in
            
            for recipe in recipes {
                group.addTask {
                    let data = try? await self.imageLoader.fetchImage(from: recipe.thumbnailURL)
                    return await (id: recipe.id, data: data)
                }
            }
            
            for await response in group {
                if let data = response.data {
                    imageDataLookup[response.id] = .fetched(data)
                } else {
                    imageDataLookup[response.id] = .failed
                }
            }
        }
    }
    
}

extension Recipe {
    
    var thumbnailURL: URL? {
        URL(string: "https://coles.com.au/\(thumbnail)")
    }
    
}


private extension Array where Element == Recipe {
    func groupByServes() -> [String: [Recipe]] {
        Dictionary(grouping: self, by: \.details.serves.value)
    }
}
