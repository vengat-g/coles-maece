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
    let recipeImagePhase: RecipesListViewModel.ImagePhase?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            switch recipeImagePhase {
            case .some:
                if case let .fetched(data) = recipeImagePhase,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                } else {
                    Image(systemName: "fork.knife.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            case .none:
                Color(.systemGray)
                    .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay {
                        ProgressView()
                    }
            }

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
        recipeImagePhase: .failed
    )
}
