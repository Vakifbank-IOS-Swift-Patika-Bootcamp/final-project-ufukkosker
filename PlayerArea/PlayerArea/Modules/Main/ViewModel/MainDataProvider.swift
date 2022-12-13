//
//  MainDataProvider.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

final class MainDataProvider: MainDataProviderProtocol {

    

    private let mainNetworkManager: MainFetchable
    
    init(mainNetworkManager: MainNetworkManager) {
        self.mainNetworkManager = mainNetworkManager
    }
    
    func fetchCategoryList(request: CategoryListRequestModel, completion: @escaping (Result<CategoryListResponseModel, ApiError>) -> Void) {
        mainNetworkManager.categoryList(request: request, completion: completion)
    }
    
    func fetchGameList(request: GameListRequestModel, completion: @escaping (Result<GameListResponseModel, ApiError>) -> Void) {
        mainNetworkManager.gameList(request: request, completion: completion)
    }
}
