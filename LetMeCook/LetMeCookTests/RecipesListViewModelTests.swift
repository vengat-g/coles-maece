//
//  RecipesListViewModelTests.swift
//  LetMeCookTests
//
//  Created by Vengatesan Ganesan on 28/6/2026.
//

import Foundation
import Testing
@testable import LetMeCook

@MainActor
struct RecipesListViewModelTests {

    @Test func viewModelFetchedRecipes() async throws {
        let service = MockRecipeService()
        service.useFileRecipeService = true
        let vm = RecipesListViewModel(service: service)
        
        #expect(vm.cardLabel == "RECIPE")
        #expect(vm.recipes.count == 0)
        #expect(vm.isLoading == false)
        
        await vm.fetchRecipes()
        
        #expect(vm.isLoading == false) // testing `isLoading` should be observing the emitted values
        #expect(vm.recipes.count == 8)
        // add tests/asserts for checking the presentation model `Recipe`
        
        #expect(vm.groupedRecipes.keys.count == 4)
        #expect(vm.errorMessage == nil)
    }
    
    @Test func viewModelUnableToFetchRecipes() async throws {
        enum TestError: Error {
            case test
        }
        let service = MockRecipeService()
        service.throwError = TestError.test
        let vm = RecipesListViewModel(service: service)
        
        #expect(vm.recipes.count == 0)
        #expect(vm.isLoading == false)
        #expect(vm.errorMessage == nil)
        
        await vm.fetchRecipes()
        
        #expect(vm.recipes.count == 0)
        #expect(vm.errorMessage == "Something went wrong. Please try again.")
    }
    
    @Test func whenARecipeIsSelected() async throws {
        let vm = RecipesListViewModel(service: MockRecipeService())
        await vm.fetchRecipes()
        
        let id = try #require(vm.recipes.first?.id)
        let detailsViewModel = try vm.selectedRecipeDetails(for: id)
        let expectedDetailsViewModel = RecipeDetailsViewModel(recipe: StubRecipes.mockOne)
        #expect(detailsViewModel.imageURL == expectedDetailsViewModel.imageURL)
        #expect(detailsViewModel.title == expectedDetailsViewModel.title)
        #expect(detailsViewModel.description == expectedDetailsViewModel.description)
        #expect(detailsViewModel.ingredients == expectedDetailsViewModel.ingredients)
        // Add asserts for remaining public APIs
        // Ideally, this should be handled in it's own ViewModelTests
    }
    
    @Test func whenASelectedRecipeIsNotFound() async throws {
        let vm = RecipesListViewModel(service: MockRecipeService())
        let error = await #expect(throws: RecipesListViewModel.Failure.self) {
            try await vm.selectedRecipeDetails(for: UUID())
        }
        #expect(error == .recipeNotFound)
    }
    
    @Test func recipesForServeSize() async {
        let service = MockRecipeService()
        service.useFileRecipeService = true
        let vm = RecipesListViewModel(service: service)
        
        await vm.fetchRecipes()
        let recipesServesFour = vm.recipes(for: "4")
        #expect(recipesServesFour.count == 4)
        
        let recipesServesThree = vm.recipes(for: "3")
        #expect(recipesServesThree.count == 0)
    }

}

// MARK: - Mocks

final class MockRecipeService: RecipeService {
    
    var throwError: Error? = nil
    var useFileRecipeService = false
    
    func fetchAll() async throws -> [Recipe] {
        if let throwError {
            throw throwError
        } else if useFileRecipeService {
            // it's a dirty impl, for demo and other use cases in VM keeping as it is.
            return try await FileRecipeService().fetchAll()
        } else {
            return [StubRecipes.mockOne]
        }
    }
    
}
