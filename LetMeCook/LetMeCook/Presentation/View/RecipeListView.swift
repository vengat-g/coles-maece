//
//  RecipeListView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct RecipeListView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                RecipeCardView(imageURL: imageURL)
                RecipeCardView(imageURL: imageURL)
                RecipeCardView(imageURL: imageURL)
                RecipeCardView(imageURL: imageURL)
            }
            .padding()
        }
    }
}

private extension RecipeListView {

    var imageURL: URL? {
        URL(string: "https://coles.com.au/content/dam/coles/inspire-create/thumbnails/Lamb-and-hasselback-pumpkin-480x288.jpg")
    }
    
    var columns: [GridItem] {
        if verticalSizeClass == .compact {
            // iPhone landscape
            return [GridItem(.flexible()), GridItem(.flexible())]
        } else if horizontalSizeClass == .regular {
            // iPad (portrait or landscape)
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            // iPhone portrait
            return [GridItem(.flexible())]
        }
    }

}

#Preview {
    RecipeListView()
}
