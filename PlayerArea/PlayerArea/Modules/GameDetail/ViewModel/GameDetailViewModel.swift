//
//  GameDetailViewModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import Foundation

final class GameDetailViewModel: GameDetailViewModelProtocol {
    var selectedGameId: Int?
    var gameDetailResponse: GameDetailResponseModel?
    var gameDetailTableViewTypes: [GameDetailTableViewType] = []
    var gameDetailTableViewTypesAny: [Any] = []
    weak var delegate: GameDetailViewModelDelegate?
    private let dataProvider: GameDetailDataProviderProtocol?
    
    init(dataProvider: GameDetailDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        fetchGameDetail()
    }
    
    func fetchGameDetail() {
        guard let gameId = selectedGameId
        else { return }
        dataProvider?.fetchGameDetail(request: .init(paths: [ApiConstant.gameDetailPath.rawValue, String(gameId)]), completion: { result in
            switch result {
            case .success(let response):
                self.gameDetailResponse = response
                self.setupTableViewTypes()
                self.notify(.fetchedGameDetail)
            case .failure(let failure):
                print("foo error: \(failure)")
            }
        })
    }
    
    func setupTitle() -> String {
        guard let title = gameDetailResponse?.name
        else { return "" }
        return title
    }
    
    private func setupTableViewTypes() {
//        gameDetailTableViewTypesAny.append(String(describing: HeaderCell.self))
//        gameDetailTableViewTypesAny.append(String(describing: GenresCell.self))
//        gameDetailTableViewTypesAny.append(String(describing: DescriptionCell.self))
//        gameDetailTableViewTypesAny.append(String(describing: PlatformCell.self))
//        gameDetailTableViewTypesAny.append(String(describing: StoreCell.self))
        gameDetailTableViewTypes = GameDetailTableViewType.allCases
    }
    
    private func notify(_ output: GameDetailViewModelOutput) {
        delegate?.handle(output: output)
    }
}
