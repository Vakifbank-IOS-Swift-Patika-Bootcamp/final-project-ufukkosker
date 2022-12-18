//
//  CategoryListRequestModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

struct CategoryListRequestModel: Requestable {
    var paths: [String]?
    
    init(paths: [String]) {
        self.paths = paths
    }
}
