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
    var gameList: GameListResponseModel?
    private let dataProvider: MainDataProviderProtocol?
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        fetchCategories()
        fetchGames()
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
            case .failure(let error):
                print("foo: \(error)")
            }
        })
    }
    
    func fetchGames(genres id: String? = nil) {
        dataProvider?.fetchGameList(request: .init(paths: [ApiConstant.gamesPath.rawValue], genresId: id), completion: { result in
            switch result {
            case .success(let response):
                self.gameList = response
                if !self.mainTableViewTypes.contains(where: { $0 == .games }) && !self.mainTableViewTypes.contains(where: { $0 == .navigation }) {
                    self.mainTableViewTypes.append(.games)
                    self.mainTableViewTypes.append(.navigation)
                }
                self.notify(.fetchedGames)
            case .failure(let error):
                print("foo: \(error)")
            }
        })
    }
    
    func fetchNavigation(with link: String) {
        let pageParameter = getQueryStringParameter(url: link, param: "page")
        let genresParameter = getQueryStringParameter(url: link, param: "genres")
        
        dataProvider?.fetchGameList(request: .init(paths: [ApiConstant.gamesPath.rawValue], genresId: genresParameter, page: pageParameter), completion: { result in
            switch result {
            case .success(let response):
                self.gameList = response
                if !self.mainTableViewTypes.contains(where: { $0 == .games }) && !self.mainTableViewTypes.contains(where: { $0 == .navigation }) {
                    self.mainTableViewTypes.append(.games)
                    self.mainTableViewTypes.append(.navigation)
                }
                self.notify(.fetchedGames)
            case .failure(let error):
                print("foo: \(error)")
            }
        })
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func selectedGenre(_ genre: CategoryListResult) {
        guard let genreId = genre.id
        else { return }
        if let index = categoryList.firstIndex(where: { $0.id == genreId }) {
            categoryList[index] = genre
        }
        if genre.isSelected {
            fetchGames(genres: String(genreId))
        }
    }
    
    private func notify(_ output: MainViewModelOutput) {
        delegate?.handle(output: output)
    }
}
