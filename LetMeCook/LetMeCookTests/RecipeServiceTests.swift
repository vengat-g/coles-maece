//
//  RecipeServiceTests.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 28/6/2026.
//

import Foundation
import Testing
@testable import LetMeCook

struct RecipeServiceTests {

    @Test func fetchesAllRecipes() async throws {
        let service = await makeService(data: StubRecipes.data)
        let recipes = try await service.fetchAll()
        #expect(recipes.count == 8)
    }
    
    @Test func fetchesFailedByDataCorrupted() async throws {
        let service = await makeService(data: Data())
        /**
         DecodingError.dataCorrupted: Data was corrupted. Debug description: The given data was not valid JSON.. Underlying error: Error Domain=NSCocoaErrorDomain Code=3840 "Unexpected end of file" UserInfo={NSDebugDescription=Unexpected end of file}
         */
        let error = try await #require(throws: FileRecipeServiceError.self) {
            try await service.fetchAll()
        }
        #expect(error == .failedToLoadData("The data couldn’t be read because it isn’t in the correct format."))
        
    }

}

// MARK: - Helpers

private extension RecipeServiceTests {
    
    func makeService(data: Data) async -> RecipeService {
        await FileRecipeService(data: data)
    }
    
}
