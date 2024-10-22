//
//  RecipeView.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import SwiftUI
import Kingfisher

/// Single recipe view. A "cell" in the recipe list
struct RecipeView: View {

    let recipe: RecipeModel

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // KFImage from the Kingfisher library for image caching
                KFImage(URL(string: recipe.photoUrlLarge ?? ""))
                    .placeholder {
                        // Fallback if no image
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        }
                        .frame(maxWidth: 100, maxHeight: 100)
                        .background(Color.gray.opacity(0.33))
                    }
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.title2.weight(.semibold))
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundStyle(Color(UIColor.secondaryLabel))
                }

                Spacer()
            }

            // Add buttons for YouTube or recipe link if the URLs exist
            HStack {
                if let youtubeUrlStr = recipe.youtubeUrl,
                   let youtubeUrl = URL(string: youtubeUrlStr) {
                    LinkButton(type: .youtube, url: youtubeUrl)
                }
                if let sourceUrlStr = recipe.sourceUrl,
                   let sourceUrl = URL(string: sourceUrlStr) {
                    LinkButton(type: .recipeLink, url: sourceUrl)
                }
            }
        }
    }
}

#Preview {
    RecipeView(
        recipe: RecipeResponse.previewData.recipes[0]
    )
}
