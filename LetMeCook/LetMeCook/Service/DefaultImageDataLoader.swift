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
    
    func loadImages<Request: ImageRequest, Response: ImageResponse>(_ requests: [Request]) async throws -> [Response] where Request.ID == Response.ID {
        try await withThrowingTaskGroup(returning: [Response].self) { group in
            
            for request in requests {
                group.addTask {
                    let response: Response = try await self.loadImage(request)
                    return response
                }
            }
            
            var results = [Response]()
            for try await response in group {
                results.append(response)
            }
            
            return results
        }
    }
    
    func loadImage<Request: ImageRequest, Response: ImageResponse>(_ request: Request) async throws -> Response where Request.ID == Response.ID {
        let requestURL = try makeRequestURL(request.url)
        let (data, urlResponse) = try await session.data(from: requestURL)
        try validate(urlResponse: urlResponse)
        return Response(id: request.id, data: data)
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
