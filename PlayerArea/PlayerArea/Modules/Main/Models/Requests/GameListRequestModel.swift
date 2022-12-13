//
//  GameListRequestModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import Foundation

struct GameListRequestModel: Requestable {
    
    var paths: [String]?
    
    private var genresId: Int? = nil
    var parameters: [String: Any] = [:]
    
    init(paths: [String], genresId: Int? = nil) {
        self.paths = paths
        self.genresId = genresId
        prepareRequest()
    }
    
    mutating func prepareRequest() {
        self.parameters["key"] = "6b4fab3e88ec48aab19933b2c153c7c9"
        guard let genresId = genresId
        else { return }
        let stringGenresId = String(genresId)
        self.parameters["genres"] = stringGenresId
    }
}
