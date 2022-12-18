//
//  GameDetailDataProvider.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

final class GameDetailDataProvider: GameDetailDataProviderProtocol {
    
    private let gameDetailNetworkManager: GameDetailFetchable
    
    init(gameDetailNetworkManager: GameDetailNetworkManager) {
        self.gameDetailNetworkManager = gameDetailNetworkManager
    }
    
    func fetchGameDetail(request: GameDetailRequestModel, completion: @escaping (Result<GameDetailResponseModel, ApiError>) -> Void) {
        gameDetailNetworkManager.gameDetail(request: request, completion: completion)
    }
}
