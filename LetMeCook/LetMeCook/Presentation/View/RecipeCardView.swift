//
//  RecipeCardView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct RecipeCardView: View {
    
    let cardTitle: String
    let recipeTitle: String
    let recipeImageURL: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: recipeImageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color(.systemGray5)
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(cardTitle)
                .foregroundStyle(.red)
                .font(.caption)
                .fontWeight(.bold)

            Text(recipeTitle)
                .foregroundStyle(.primary)
                .font(.subheadline)
        }
    }
}

#Preview {
    RecipeCardView(
        cardTitle: "RECIPE",
        recipeTitle: StubRecipes.mockOne.title,
        recipeImageURL: URL(string: "https://coles.com.au/\(StubRecipes.mockOne.thumbnail)")
    )
}
