//
//  MainViewModelProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var delegate: MainViewModelDelegate? { get set }
    var mainTableViewTypes: [MainTableViewType] { get set }
    var categoryList: [CategoryListResult] { get set }
    var gameList: [GameListResult] { get set }
    
    func viewDidLoad()
    func fetchCategories()
    func fetchGames(genres id: Int?)
    func prepareSelected(_ genre: CategoryListResult)
}

enum MainViewModelOutput {
    case fetchedCategories
    case fetchedGames
}

protocol MainViewModelDelegate: AnyObject {
    func handle(output: MainViewModelOutput)
}
