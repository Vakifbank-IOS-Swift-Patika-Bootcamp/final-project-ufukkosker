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
    private let dataProvider: MainDataProviderProtocol?
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func fetchCategories() {
        dataProvider?.fetchCategoryList(request: .init(paths: [ApiConstant.genresPath.rawValue]), completion: { result in
            switch result {
            case .success(let response):
                guard let categories = response.results
                else { return }
                self.mainTableViewTypes.append(.categories(categories))
                self.notify(.fetchedCategories)
            case .failure(_):
                break
            }
        })
    }
    
    private func notify(_ output: MainViewModelOutput) {
        delegate?.handle(output: output)
    }
}
