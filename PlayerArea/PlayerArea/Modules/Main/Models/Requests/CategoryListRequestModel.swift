//
//  CategoryListRequestModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

struct CategoryListRequestModel: Requestable {
    var parameters: [String : Any] = [:]
    var paths: [String]?
    
    init(paths: [String]) {
        self.paths = paths
        prepareRequest()
    }
    
    mutating func prepareRequest() {
        self.parameters = [
            "key": "6b4fab3e88ec48aab19933b2c153c7c9"
        ]
    }
}
