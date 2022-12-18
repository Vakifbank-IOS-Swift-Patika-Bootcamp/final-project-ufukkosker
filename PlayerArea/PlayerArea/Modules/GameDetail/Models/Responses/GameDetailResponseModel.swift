//
//  GameDetailResponseModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

struct GameDetailResponseModel: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let website: String?
    let rating: Double?
    let genres: [GenresModel]?
    var platforms: [PlatformsModel]?
    let stores: [StoresModel]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case description = "description_raw"
        case released
        case backgroundImage = "background_image"
        case website
        case rating
        case genres
        case platforms
        case stores
    }
}

struct GenresModel: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct PlatformsModel: Codable {
    let platform: PlatformModel?
    let requirements: RequirementsModel?
    var isShown: Bool = false
    
    enum CodingKeys: CodingKey {
        case platform
        case requirements
    }
}

struct PlatformModel: Codable {
    let id: Int?
    let name: String?
    let slug: PlatformIconType?
}

struct RequirementsModel: Codable {
    var minimum: String?
    var recommended: String?
}

struct StoresModel: Codable {
    let id: Int?
    let store: StoreModel?
}

struct StoreModel: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}
