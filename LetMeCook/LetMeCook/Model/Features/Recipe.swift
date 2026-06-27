//
//  RecipeItem.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import Foundation

struct Recipe {
    
    let id: UUID
    
    let title: String
    let description: String?
    let thumbnail: String
    let thumbnailAlt: String
    
    let ingredients: [String]
    let details: Details
    
}

extension Recipe: Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
    
}

extension Recipe {
    
    struct Details {
        let serves: ServesDetail
        let prep: PrepDetail
        let cooking: CookingDetail
    }
    
    struct ServesDetail {
        let label: String
        let value: String
    }
    
    struct PrepDetail {
        let label: String
        let value: String
        let notes: String?
    }
    
    struct CookingDetail {
        let label: String
        let value: String
    }
    
}

extension Recipe {
    
    var thumbnailURL: URL? {
        URL(string: "https://coles.com.au/\(thumbnail)")
    }
    
}
