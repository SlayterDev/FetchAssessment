//
//  ContentView.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import SwiftUI

struct RecipesView: View {

    @ObservedObject var viewModel: RecipesViewModel

    func loadRecipes() async {
        await viewModel.fetchRecipes()
    }

    var listView: some View {
        LazyVStack {
            ForEach(viewModel.recipes) { recipe in
                RecipeView(recipe: recipe)
            }
        }
    }

    var body: some View {
        ScrollView {
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
        .refreshable {
            await loadRecipes()
        }
        .padding([.horizontal, .bottom])
        .ignoresSafeArea(.container, edges: [.bottom])
        .navigationTitle("Recipes")
        .onAppear {
            Task {
                await loadRecipes()
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
