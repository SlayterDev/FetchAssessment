//
//  ContentView.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import SwiftUI

struct RecipesView: View {

    @ObservedObject var viewModel: RecipesViewModel

    var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes) { recipe in
                    RecipeView(recipe: recipe)
                }
            }
        }
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if viewModel.error != nil {
                    // Show error state
                    EmptyView()
                } else if !viewModel.recipes.isEmpty {
                    listView
                } else {
                    Text("No recipes found. Come back later! 🍳")
                }
            }
        }
        .padding()
        .navigationTitle("Recipes")
        .onAppear {
            Task { @MainActor in
                await viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipesView(
            viewModel: RecipesViewModel(recipesApi: PreviewRecipeAPI())
        )
    }
}
