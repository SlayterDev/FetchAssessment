//
//  RecipeModel.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

struct RecipeModel: Codable, Identifiable {
    var id: String { uuid }

    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let sourceUrl: String?
    let youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [RecipeModel]

    static let previewData: RecipeResponse = .init(recipes: [
        RecipeModel(
            cuisine: "French",
            name: "White Chocolate Crème Brûlée",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg",
            uuid: "ef7d81b7-07ba-4fab-a791-ae10e2817e66",
            sourceUrl: "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle",
            youtubeUrl: "https://www.youtube.com/watch?v=LmJ0lsPLHDc"
        ),
        RecipeModel(
            cuisine: "Tunisian",
            name: "Tunisian Orange Cake",
            photoUrlLarge: nil,
            photoUrlSmall: nil,
            uuid: "a1bedde3-2bc6-46f9-ab3c-0d98a2b11b64",
            sourceUrl: nil,
            youtubeUrl: "https://www.youtube.com/watch?v=rCUxg866Ea4"
        ),
        RecipeModel(
            cuisine: "Croatian",
            name: "Walnut Roll Gužvara",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/small.jpg",
            uuid: "7d6a2c69-f0ef-459a-abf5-c2e90b6555ff",
            sourceUrl: "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle",
            youtubeUrl: nil
        )
    ])
}
