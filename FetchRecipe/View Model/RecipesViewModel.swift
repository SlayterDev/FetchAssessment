//
//  RecipesViewModel.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

class RecipesViewModel: ObservableObject {

    // State variables
    @Published var isLoading: Bool = false
    @Published var recipes: [RecipeModel] = []
    @Published var error: Error?

    let recipesApi: RecipeAPI

    init(recipesApi: RecipeAPI = DefaultRecipeAPI()) {
        self.recipesApi = recipesApi
    }

    /// Fetch recipes from the API. Tag with @MainActor to ensure its run on the main thread
    @MainActor
    func fetchRecipes() async {
        isLoading = true // Show loading spinner
        error = nil
        defer { isLoading = false } // Hide spinner at the end of this context

        do {
            recipes = try await recipesApi.fetchRecipes().recipes
        } catch {
            print("Error fetching recipes: \(error)")
            recipes = []
            self.error = error
        }
    }

    /// Allow us to change the endpoint for debug purposes
    func changeApiEndpoint(to newEndpoint: DefaultRecipeAPI.Endpoints) {
        // Since `recipesApi` is a protocol for dependency injection
        // We need to try to cast it to `DefaultRecipeAPI` to change the endpoint
        // This will have no effect if using a different implementation of `RecipeAPI`
        (recipesApi as? DefaultRecipeAPI)?.setEndpoint(to: newEndpoint)
    }

}
