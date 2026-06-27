//
//  RecipeCardView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct RecipeCardView: View {
    
    @State var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: recipe.thumbnailURL) { image in
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

            Text("RECIPE")
                .foregroundStyle(.red)
                .font(.caption)
                .fontWeight(.bold)

            Text(recipe.title)
                .foregroundStyle(.primary)
                .font(.subheadline)
        }
    }
}

