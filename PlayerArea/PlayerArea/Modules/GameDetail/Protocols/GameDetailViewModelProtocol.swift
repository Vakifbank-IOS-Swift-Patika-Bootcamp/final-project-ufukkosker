//
//  GameDetailViewModelProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol: AnyObject {
    var delegate: GameDetailViewModelDelegate? { get set }
    var selectedGameId: Int? { get set }
    var gameDetailResponse: GameDetailResponseModel? { get set }
    var gameDetailTableViewTypes: [GameDetailTableViewType] { get set }
    var gameDetailTableViewTypesAny: [Any] { get set }
    
    
    func viewDidLoad()
    func fetchGameDetail()
    func setupTitle() -> String
}

enum GameDetailViewModelOutput {
    case fetchedGameDetail
}

protocol GameDetailViewModelDelegate: AnyObject {
    func handle(output: GameDetailViewModelOutput)
}
