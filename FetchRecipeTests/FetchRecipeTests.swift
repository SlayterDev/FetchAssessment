//
//  FetchRecipeTests.swift
//  FetchRecipeTests
//
//  Created by Brad Slayter on 10/22/24.
//

import Testing
@testable import FetchRecipe

class MockRecipeAPI: RecipeAPI {

    var mockResponse: (() async throws -> FetchRecipe.RecipeResponse)?

    func fetchRecipes() async throws -> FetchRecipe.RecipeResponse {
        if let response = mockResponse {
            return try await response()
        }

        return .init(recipes: [])
    }
}

struct FetchRecipeTests {

    let mockAPI = MockRecipeAPI()

    @Test func whenRecipesAreFetchedDataIsReturned() async throws {
        let viewModel = RecipesViewModel(recipesApi: mockAPI)
        mockAPI.mockResponse = {
            return .previewData
        }
        await viewModel.fetchRecipes()

        #expect(viewModel.recipes.isEmpty == false)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.error == nil)
    }

    @Test func whenErrorOccursDataIsNotReturned() async throws {
        let viewModel = RecipesViewModel(recipesApi: mockAPI)
        mockAPI.mockResponse = {
            throw RecipeError.badURL
        }
        await viewModel.fetchRecipes()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.error != nil)
    }

    @Test func whenNoDataIsReturnedRecipesIsEmpty() async throws {
        let viewModel = RecipesViewModel(recipesApi: mockAPI)
        mockAPI.mockResponse = {
            return .init(recipes: [])
        }
        await viewModel.fetchRecipes()

        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.error == nil)
    }

    @Test func whenJSONIsDecodedValidDataIsReturned() async throws {
        let data = """
{
    "recipes": [
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        },
        {
            "cuisine": "British",
            "name": "Apple & Blackberry Crumble",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
            "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
        },
        {
            "cuisine": "British",
            "name": "Apple Frangipan Tart",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
            "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
            "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
        },
    ]
}
""".data(using: .utf8)!

        let api = DefaultRecipeAPI()
        let response = try api.decodeResponse(data)
        #expect(!response.recipes.isEmpty)
        #expect(response.recipes.count == 3)
        #expect(response.recipes.last?.sourceUrl == nil)
        #expect(response.recipes.first?.cuisine == "Malaysian")
    }

}
