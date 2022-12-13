//
//  GameListResponseModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import Foundation

struct GameListResponseModel: Codable {
    var next: String?
    var previous: String?
    var results: [GameListResult]?
}

struct GameListResult: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var backgroundImage: String?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case backgroundImage = "background_image"
        case rating
    }
}
