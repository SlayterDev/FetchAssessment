//
//  RecipeAPI.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

protocol RecipeAPI {
    func fetchRecipes() async throws -> RecipeRespnse
}

enum RecipeError: Error {
    case badURL
    case invalidResponse
    case malformedResponse
    case emptyResponse
}

struct DefaultRecipeAPI: RecipeAPI {

    enum Constants {
        static let apiEndpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        static let malformedApiEndpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        static let emptyApiEndpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }

    func fetchRecipes() async throws -> RecipeRespnse {
        guard let url = URL(string: Constants.apiEndpoint) else {
            throw RecipeError.badURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RecipeRespnse.self, from: data)
        return response
    }
}
