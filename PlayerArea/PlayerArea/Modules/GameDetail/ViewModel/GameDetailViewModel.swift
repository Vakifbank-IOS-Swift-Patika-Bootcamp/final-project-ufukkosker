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
    var coreDataNoteModel: NoteModel?
    weak var delegate: GameDetailViewModelDelegate?
    private let dataProvider: GameDetailDataProviderProtocol?
    private let coreDataProvider: GameDetailCoreDataProviderProtocol?
    
    init(dataProvider: GameDetailDataProviderProtocol, coreDataProvider: GameDetailCoreDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.coreDataProvider = coreDataProvider
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
                self.searchNote()
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
    
    func addFavorite() {
        guard let gameId = gameDetailResponse?.id
        else { return }
        let noteModel = NoteModel(id: Int64(gameId), isFavorite: true)
        coreDataProvider?.saveNote(with: noteModel, completion: { result in
            switch result {
            case .success(let model):
                self.coreDataNoteModel = model
                self.notify(.changedIsFavorite)
            case .failure(_):
                break
            }
        })
    }
    
    func removeFavorite() {
        guard let gameId = gameDetailResponse?.id
        else { return }
        coreDataProvider?.deleteNote(with: gameId, completion: { result in
            switch result {
            case .success(_):
                self.coreDataNoteModel = nil
                self.notify(.changedIsFavorite)
            case .failure(_):
                break
            }
        })
    }
    
    func searchNote() {
        guard let gameId = gameDetailResponse?.id
        else { return }
        
        coreDataProvider?.searchNoteById(gameId, completion: { result in
            switch result {
            case .success(let model):
                self.coreDataNoteModel = model
                self.notify(.changedIsFavorite)
            case .failure(_):
                break
            }
        })
    }
    
    private func setupTableViewTypes() {
        gameDetailTableViewTypes = GameDetailTableViewType.allCases
    }
    
    private func notify(_ output: GameDetailViewModelOutput) {
        delegate?.handle(output: output)
    }
}
