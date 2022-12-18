//
//  GameDetailRequestModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

struct GameDetailRequestModel: Requestable {
    var paths: [String]?
    
    init(paths: [String]) {
        self.paths = paths
    }
}
