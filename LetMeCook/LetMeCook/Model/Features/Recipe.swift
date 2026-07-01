//
//  RecipeItem.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

struct Recipe: Sendable {
    
    let title: String
    let description: String?
    let thumbnail: String
    let thumbnailAlt: String
    
    let ingredients: [String]
    let details: Details
    
}

extension Recipe: Hashable, Identifiable {
    
    struct ID: Hashable, Sendable {
        let rawValue: String
        init(title: String, thumbnail: String) {
            self.rawValue = "\(title)-\(thumbnail)-identifier"
        }
    }
    
    var id: ID {
        Recipe.ID(title: title, thumbnail: thumbnail)
    }
    
}

extension Recipe {
    
    struct Details: Hashable {
        let serves: ServesDetail
        let prep: PrepDetail
        let cooking: CookingDetail
    }
    
    struct ServesDetail: Hashable {
        let label: String
        let value: String
    }
    
    struct PrepDetail: Hashable {
        let label: String
        let value: String
        let notes: String?
    }
    
    struct CookingDetail: Hashable {
        let label: String
        let value: String
    }
    
}
