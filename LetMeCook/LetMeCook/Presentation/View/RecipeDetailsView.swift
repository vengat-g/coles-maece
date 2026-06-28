//
//  RecipeDetailsView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(viewModel.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                if let description = viewModel.description {
                    Text(description)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                }
                
                AsyncImage(url: viewModel.imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color(.systemGray5)
                        .overlay {
                            ProgressView()
                        }
                }
                .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Divider()
                
                HStack(alignment: .center) {
                    RecipeStatView(title: viewModel.serves.title, value: viewModel.serves.value)
                    Divider()
                    RecipeStatView(title: viewModel.prep.title, value: viewModel.prep.value)
                    Divider()
                    RecipeStatView(title: viewModel.cooking.title, value: viewModel.cooking.value)
                }
                .padding(.horizontal, 24)
                
                Divider()
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(viewModel.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Image(systemName: "chevron.right")
                                .font(.caption)
                            Text(ingredient)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
}

#Preview {
    RecipeDetailsView(
        viewModel: RecipeDetailsViewModel(
            recipe: StubRecipes.mockOne
        )
    )
}
