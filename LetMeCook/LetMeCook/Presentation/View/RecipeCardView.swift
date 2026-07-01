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
    
    @State private var image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            } else {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Text(cardTitle)
                .foregroundStyle(.red)
                .font(.caption)
                .fontWeight(.bold)
            
            Text(recipeTitle)
                .foregroundStyle(.primary)
                .font(.subheadline)
        }
        .task(id: recipeImagePhase) {
            guard case let .fetched(data) = recipeImagePhase else {
                image = nil
                return
            }
            image = await decodeImage(from: data)
        }
    }
    
    private func decodeImage(from data: Data) async -> UIImage? {
        await Task.detached(priority: .userInitiated) {
            UIImage(data: data)
        }.value
    }
}

#Preview {
    RecipeCardView(
        cardTitle: "RECIPE",
        recipeTitle: StubRecipes.mockOne.title,
        recipeImagePhase: .failed
    )
}
