//
//  ImageDataLoader.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 1/7/2026.
//

import Foundation

protocol ImageRequest: Sendable {
    associatedtype ID: Hashable
    var id: ID { get }
    var url: URL? { get }
}

protocol ImageResponse: Sendable {
    associatedtype ID: Hashable
    var id: ID { get }
    var data: Data { get }
    
    init(id: ID, data: Data)
}

protocol ImageDataLoader: Sendable {
    
    func loadImage<Request: ImageRequest, Response: ImageResponse>(_ request: Request) async throws -> Response where Request.ID == Response.ID
    
    func loadImages<Request: ImageRequest, Response: ImageResponse>(_ requests: [Request]) async throws -> [Response] where Request.ID == Response.ID
    
}
