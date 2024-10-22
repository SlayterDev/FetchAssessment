//
//  RecipeAPI.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

protocol RecipeAPI {
    func fetchRecipes() async throws -> RecipeResponse
}

enum RecipeError: Error {
    case badURL
    case invalidResponse
    case malformedResponse
    case emptyResponse
}

class DefaultRecipeAPI: RecipeAPI {

    enum Endpoints: String {
        case api = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case malformedApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case emptyApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }

    var currentEndpoint: String = Endpoints.api.rawValue

    func decodeResponse(_ data: Data) throws -> RecipeResponse {
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }

    func fetchRecipes() async throws -> RecipeResponse {
        guard let url = URL(string: currentEndpoint) else {
            throw RecipeError.badURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeResponse(data)
    }

    func setEndpoint(to endpoint: Endpoints) {
        currentEndpoint = endpoint.rawValue
    }
}

struct PreviewRecipeAPI: RecipeAPI {
    func fetchRecipes() async throws -> RecipeResponse {
        return RecipeResponse.previewData
    }
}
