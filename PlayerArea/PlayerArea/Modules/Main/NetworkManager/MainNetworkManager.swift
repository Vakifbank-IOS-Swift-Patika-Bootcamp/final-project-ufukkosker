//
//  MainNetworkManager.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

final class MainNetworkManager: MainFetchable {
    
    private let mainNetworkManager: Networking
    
    init(mainNetworkManager: Networking) {
        self.mainNetworkManager = mainNetworkManager
    }
    
    func categoryList(request: CategoryListRequestModel, completion: @escaping (Result<CategoryListResponseModel, ApiError>) -> Void) {
        mainNetworkManager.request(request: request, completion: completion)
    }
}
