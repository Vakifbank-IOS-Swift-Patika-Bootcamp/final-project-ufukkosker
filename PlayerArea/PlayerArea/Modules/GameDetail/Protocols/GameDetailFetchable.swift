//
//  GameDetailFetchable.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

protocol GameDetailFetchable {
    func gameDetail(request: GameDetailRequestModel, completion: @escaping (Result<GameDetailResponseModel, ApiError>) -> Void)
}
