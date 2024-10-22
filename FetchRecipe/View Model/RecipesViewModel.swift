//
//  RecipesViewModel.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

class RecipesViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var recipes: [RecipeModel] = []
    @Published var error: Error?

    let recipesApi: RecipeAPI

    init(recipesApi: RecipeAPI = DefaultRecipeAPI()) {
        self.recipesApi = recipesApi
    }

    @MainActor
    func fetchRecipes() async {
        isLoading = true
        error = nil
        defer { isLoading = false }

        do {
            recipes = try await recipesApi.fetchRecipes().recipes
        } catch {
            print("Error fetching recipes: \(error)")
            recipes = []
            self.error = error
        }
    }

    func changeApiEndpoint(to newEndpoint: DefaultRecipeAPI.Endpoints) {
        (recipesApi as? DefaultRecipeAPI)?.setEndpoint(to: newEndpoint)
    }

}
