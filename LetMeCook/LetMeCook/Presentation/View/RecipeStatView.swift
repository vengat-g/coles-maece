//
//  RecipeStatView.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 29/6/2026.
//

import SwiftUI

struct RecipeStatView: View {
    
    let title, value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .foregroundStyle(.secondary)
            
            Text(value)
                .foregroundStyle(.primary)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
