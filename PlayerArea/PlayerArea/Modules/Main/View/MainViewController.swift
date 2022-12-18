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
        setupTableView()
        viewModel?.viewDidLoad()
    }
    
    private func setupTableView() {
        let categoryCellName = String(describing: CategoryListCell.self)
        let categoryCellNib = UINib(nibName: categoryCellName, bundle: .main)
        mainTableView.register(categoryCellNib, forCellReuseIdentifier: categoryCellName)
        
        let gameItemCellName = String(describing: GameItemCell.self)
        let gameItemCellNib = UINib(nibName: gameItemCellName, bundle: .main)
        mainTableView.register(gameItemCellNib, forCellReuseIdentifier: gameItemCellName)
        
        let navigationCellName = String(describing: NavigationCell.self)
        let navigationCellNib = UINib(nibName: navigationCellName, bundle: .main)
        mainTableView.register(navigationCellNib, forCellReuseIdentifier: navigationCellName)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
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
              let gameList = viewModel?.gameList?.results
        else { return 0 }
        switch mainTableViewSection {
        case .categories:
            return 1
        case .games:
            return gameList.count
        case .navigation:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[indexPath.section],
              let categoryList = viewModel?.categoryList,
              let navigation = viewModel?.gameList,
              let gameList = viewModel?.gameList?.results
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
        case .navigation:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NavigationCell.self)) as? NavigationCell {
                cell.delegate = self
                cell.config(with: navigation)
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
        case .navigation:
            return "Navigation"
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gamesSection = viewModel?.mainTableViewTypes[indexPath.section],
              let selectedGame = viewModel?.gameList?.results?[indexPath.row]
        else { return }
        
        if case .games = gamesSection {
            let networkManager = UrlSessionManager(session: .shared)
            let gameDetailNetworkManager = GameDetailNetworkManager(gameDetailNetworkManager: networkManager)
            let gameDetailDataProvider = GameDetailDataProvider(gameDetailNetworkManager: gameDetailNetworkManager)
            let gameDetailViewModel = GameDetailViewModel(dataProvider: gameDetailDataProvider)
            let gameViewController = GameDetailViewController(nibName: String(describing: GameDetailViewController.self), bundle: .main)
            gameDetailViewModel.selectedGameId = selectedGame.id
            gameViewController.viewModel = gameDetailViewModel
            UIApplication.getTopViewController()?.navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
}

extension MainViewController: CategoryListCellProtocol {
    func update(genre: CategoryListResult) {
        viewModel?.selectedGenre(genre)
    }
    func clearGenreSearch() {
        viewModel?.fetchGames(genres: nil)
    }
}

extension MainViewController: NavigationCellProtocol {
    func didTappedBackButton(with link: String) {
        mainTableView.setContentOffset(.zero, animated: true)
        viewModel?.fetchNavigation(with: link)
    }
    
    func didTappedNextButton(with link: String) {
        mainTableView.setContentOffset(.zero, animated: true)
        viewModel?.fetchNavigation(with: link)
    }
}


