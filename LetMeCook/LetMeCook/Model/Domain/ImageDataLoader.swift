//
//  ImageDataLoader.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 1/7/2026.
//

import Foundation

protocol ImageDataLoader: Sendable {
    
    func fetchImage(from url: URL?) async throws -> Data
    
}
