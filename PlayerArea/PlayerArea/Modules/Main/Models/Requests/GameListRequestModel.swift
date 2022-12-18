//
//  GameListRequestModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import Foundation

struct GameListRequestModel: Requestable {
    
    var paths: [String]?
    private var genresId: String? = nil
    private var page: String? = nil
    
    init(paths: [String], genresId: String? = nil, page: String? = nil) {
        self.paths = paths
        self.genresId = genresId
        self.page = page
    }
    
    var parameters: [String : Any] {
        var defaultParams = defaultParameters
        if let genresId = genresId {
            let stringGenresId = String(genresId)
            defaultParams["genres"] = stringGenresId
        }
        if let page = page {
            defaultParams["page"] = page
        }
        return defaultParams
    } 
}
