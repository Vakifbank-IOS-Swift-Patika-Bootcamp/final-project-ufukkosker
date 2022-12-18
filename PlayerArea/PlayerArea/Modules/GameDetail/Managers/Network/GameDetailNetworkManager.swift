//
//  GameDetailNetworkManager.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

final class GameDetailNetworkManager: GameDetailFetchable {
    
    private let gameDetailNetworkManager: Networking
    
    init(gameDetailNetworkManager: Networking) {
        self.gameDetailNetworkManager = gameDetailNetworkManager
    }
    
    func gameDetail(request: GameDetailRequestModel, completion: @escaping (Result<GameDetailResponseModel, ApiError>) -> Void) {
        gameDetailNetworkManager.request(request: request, completion: completion)
    }
}

