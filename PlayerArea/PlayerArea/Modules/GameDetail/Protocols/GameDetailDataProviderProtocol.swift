//
//  GameDetailDataProviderProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

protocol GameDetailDataProviderProtocol {
    func fetchGameDetail(request: GameDetailRequestModel, completion: @escaping (Result<GameDetailResponseModel, ApiError>) -> Void)
}
