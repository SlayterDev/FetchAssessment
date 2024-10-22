//
//  RecipeModel.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import Foundation

struct RecipeModel: Codable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String
    let photoUrlSmall: String
    let uuid: String
    let sourceUrl: String
    let youtubeUrl: String

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

struct RecipeRespnse: Codable {
    let recipes: [RecipeModel]
}
