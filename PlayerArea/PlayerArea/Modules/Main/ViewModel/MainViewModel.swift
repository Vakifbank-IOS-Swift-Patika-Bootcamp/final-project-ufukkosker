//
//  MainViewModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    
    

    var delegate: MainViewModelDelegate?
    var mainTableViewTypes: [MainTableViewType] = []
    var categoryList: [CategoryListResult] = []
    var gameList: [GameListResult] = []
    private let dataProvider: MainDataProviderProtocol?
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        fetchCategories()
        fetchGames(genres: nil)
    }
    
    func fetchCategories() {
        dataProvider?.fetchCategoryList(request: .init(paths: [ApiConstant.genresPath.rawValue]), completion: { result in
            switch result {
            case .success(let response):
                guard let categories = response.results
                else { return }
                self.categoryList = categories
                self.mainTableViewTypes.append(.categories)
                self.notify(.fetchedCategories)
            case .failure(_):
                break
            }
        })
    }
    
    func fetchGames(genres id: Int?) {
        dataProvider?.fetchGameList(request: .init(paths: [ApiConstant.games.rawValue], genresId: id), completion: { result in
            switch result {
            case .success(let response):
                guard let games = response.results
                else { return }
                self.gameList = games
                self.mainTableViewTypes.append(.games)
                self.notify(.fetchedGames)
            case .failure(_):
                break
            }
        })
    }
    
    func prepareSelected(_ genre: CategoryListResult) {
        guard let genreId = genre.id
        else { return }
        if let index = categoryList.firstIndex(where: { $0.id == genreId }) {
            categoryList[index] = genre
        }
        if genre.isSelected {
            fetchGames(genres: genreId)
        }
    }
    
    private func notify(_ output: MainViewModelOutput) {
        delegate?.handle(output: output)
    }
}
