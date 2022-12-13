//
//  CategoryListResponseModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

struct CategoryListResponseModel: Codable {
    let results: [CategoryListResult]?
}

struct CategoryListResult: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
    }
}
