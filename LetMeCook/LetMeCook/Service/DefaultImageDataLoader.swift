//
//  DefaultImageDataLoader.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 1/7/2026.
//

import Foundation

final class DefaultImageDataLoader: ImageDataLoader {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL?) async throws -> Data {
        let requestURL = try makeRequestURL(url)
        let (data, urlResponse) = try await session.data(from: requestURL)
        try validate(urlResponse: urlResponse)
        return data
    }
    
}

private extension DefaultImageDataLoader {
    
    func makeRequestURL(_ url: URL?) throws(URLError) -> URL {
        guard let url else {
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
