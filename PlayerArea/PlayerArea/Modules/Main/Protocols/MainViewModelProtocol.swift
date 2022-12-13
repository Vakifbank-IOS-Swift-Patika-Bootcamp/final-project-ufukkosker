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
    
    func viewDidLoad()
    func fetchCategories()
}

enum MainViewModelOutput {
    case fetchedCategories
}

protocol MainViewModelDelegate: AnyObject {
    func handle(output: MainViewModelOutput)
}
