//
//  MainViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var mainTableView: UITableView!
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        registerMainTableViewCells()
        viewModel?.viewDidLoad()
    }
    
    private func registerMainTableViewCells() {
        let categoryCellName = String(describing: CategoryListCell.self)
        let categoryCellNib = UINib(nibName: categoryCellName, bundle: .main)
        mainTableView.register(categoryCellNib, forCellReuseIdentifier: categoryCellName)
        
        let gameItemCellName = String(describing: GameItemCell.self)
        let gameItemCellNib = UINib(nibName: gameItemCellName, bundle: .main)
        mainTableView.register(gameItemCellNib, forCellReuseIdentifier: gameItemCellName)
    }
}

extension MainViewController: MainViewModelDelegate {
    func handle(output: MainViewModelOutput) {
        switch output {
        case .fetchedCategories:
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        case .fetchedGames:
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableViewTypes = viewModel?.mainTableViewTypes.count
        else { return 0 }
        return tableViewTypes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[section],
              let gameList = viewModel?.gameList
        else { return 0 }
        switch mainTableViewSection {
        case .categories:
            return 1
        case .games:
            return gameList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[indexPath.section],
              let categoryList = viewModel?.categoryList,
              let gameList = viewModel?.gameList
        else { return UITableViewCell() }
        
        switch mainTableViewSection {
        case .categories:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryListCell.self)) as? CategoryListCell {
                cell.delegate = self
                cell.categoryItems = categoryList
                return cell
            }
        case .games:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GameItemCell.self)) as? GameItemCell {
                cell.config(with: gameList[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[section]
        else { return "" }
        
        switch mainTableViewSection {
        case .categories:
            return "Categories"
        case .games:
            return "Games"
        }
    }
}

extension MainViewController: CategoryListCellProtocol {
    func update(genre: CategoryListResult) {
        viewModel?.prepareSelected(genre)
    }
    func clearGenreSearch() {
        viewModel?.fetchGames(genres: nil)
    }
}


