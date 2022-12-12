//
//  MainViewModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    var delegate: MainViewModelDelegate?
    var tableViewItems: [Any] = []
    private let dataProvider: MainDataProviderProtocol?
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func fetchCategories() {
        dataProvider?.categoryList(request: .init(paths: [ApiConstant.genresPath.rawValue]), completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        })
    }
    
    private func notify(_ output: MainViewModelOutput) {
        delegate?.handle(output: output)
    }
}
