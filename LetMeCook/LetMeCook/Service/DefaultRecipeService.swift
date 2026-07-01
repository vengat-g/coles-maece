//
//  DefaultRecipeService.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 30/6/2026.
//

import Foundation

final class DefaultRecipeService: RecipeService, Sendable {
    
    private let session: URLSession
    private let endpoint: String
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, endpoint: String = "recipes", decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.endpoint = endpoint
        self.decoder = decoder
    }
    
    func fetchAll() async throws -> [Recipe] {
        let requestURL = try makeRequestURL()
        let (data, urlResponse) = try await session.data(from: requestURL)
        
        try validate(urlResponse: urlResponse)
        
        let response = try decoder.decode(RecipeListResponse.self, from: data)
        return response.recipes.map { Recipe(from: $0) }
    }
    
}

// MARK: - Private Helpers

private extension DefaultRecipeService {
    
    func makeRequestURL() throws(URLError) -> URL {
        guard let url = URL(string: "https://coles.com.au/\(endpoint)") else {
            throw URLError(.badURL)
        }
        return url
    }
    
    func validate(urlResponse: URLResponse) throws(URLError) {
        guard
            let httpResponse = urlResponse as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
    
}
