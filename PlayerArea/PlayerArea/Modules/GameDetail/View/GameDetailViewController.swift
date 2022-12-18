//
//  GameDetailViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 15.12.2022.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet private weak var gameDetailTableView: UITableView!
    
    lazy var starButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: .star, style: .plain, target: self, action: #selector(didTappedStarButton))
        return barButton
    }()
    
    var viewModel: GameDetailViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaivgationBarButton()
        setupGameDetailTableView()
        viewModel?.viewDidLoad()
    }
    
    private func setupTitle() {
        title = viewModel?.setupTitle()
    }
    
    private func setupGameDetailTableView() {
        let headerCellName = String(describing: HeaderCell.self)
        let headerCellNib = UINib(nibName: headerCellName, bundle: .main)
        gameDetailTableView.register(headerCellNib, forCellReuseIdentifier: headerCellName)
        
        let genresCellName = String(describing: GenresCell.self)
        let genresCellNib = UINib(nibName: genresCellName, bundle: .main)
        gameDetailTableView.register(genresCellNib, forCellReuseIdentifier: genresCellName)
        
        let descriptionCellName = String(describing: DescriptionCell.self)
        let descriptionCellNib = UINib(nibName: descriptionCellName, bundle: .main)
        gameDetailTableView.register(descriptionCellNib, forCellReuseIdentifier: descriptionCellName)
        
        let platformCellName = String(describing: PlatformCell.self)
        let platformCellNib = UINib(nibName: platformCellName, bundle: .main)
        gameDetailTableView.register(platformCellNib, forCellReuseIdentifier: platformCellName)
        
        let storeCellName = String(describing: StoreCell.self)
        let storeCellNib = UINib(nibName: storeCellName, bundle: .main)
        gameDetailTableView.register(storeCellNib, forCellReuseIdentifier: storeCellName)
        
        gameDetailTableView.delegate = self
        gameDetailTableView.dataSource = self
    }
    
    private func setupNaivgationBarButton() {
        navigationItem.rightBarButtonItem = starButton
    }
    
    private func updateNavigationBarButton() {
        if viewModel?.coreDataNoteModel == nil {
            starButton.image = .star
        } else {
            if let isFavorite =  viewModel?.coreDataNoteModel?.isFavorite {
                starButton.image = isFavorite ? .starFill : .star
            } else {
                starButton.image = .star
            }
        }
    }
    
    @objc func didTappedStarButton() {
        if viewModel?.coreDataNoteModel == nil {
            viewModel?.addFavorite()
        } else {
            viewModel?.removeFavorite()
        }
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func handle(output: GameDetailViewModelOutput) {
        switch output {
        case .fetchedGameDetail:
            DispatchQueue.main.async {
                self.gameDetailTableView.reloadData()
                self.setupTitle()
            }
        case .changedIsFavorite:
            DispatchQueue.main.async {
                self.updateNavigationBarButton()
            }
        }
    }
}
 
extension GameDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel?.gameDetailTableViewTypes
        else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let gameDetailSection = viewModel?.gameDetailTableViewTypes[section],
              let platformsCount = viewModel?.gameDetailResponse?.platforms?.count
        else { return 0 }
        switch gameDetailSection {
        case .header:
            return 1
        case .genres:
            return 1
        case .description:
            return 1
        case .platforms:
            return platformsCount
        case .stores:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gameDetailSection = viewModel?.gameDetailTableViewTypes[indexPath.section],
              let gameDetail = viewModel?.gameDetailResponse,
              let genres = gameDetail.genres,
              let platforms = gameDetail.platforms,
              let stores = gameDetail.stores
        else { return UITableViewCell() }
        
        switch gameDetailSection {
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self)) as? HeaderCell {
                cell.config(with: gameDetail)
                return cell
            }
        case .genres:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GenresCell.self)) as? GenresCell {
                cell.genres = genres
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionCell.self)) as? DescriptionCell {
                cell.config(with: gameDetail.description)
                return cell
            }
        case .platforms:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlatformCell.self)) as? PlatformCell {
                cell.config(with: platforms[indexPath.row])
                return cell
            }
        case .stores:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoreCell.self)) as? StoreCell {
                cell.stores = stores
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let gameDetailSection = viewModel?.gameDetailTableViewTypes[section]
        else { return "" }
        
        switch gameDetailSection {
        case .header:
            return "Header"
        case .genres:
            return "Genres"
        case .description:
            return "Description"
        case .platforms:
            return "Platforms"
        case .stores:
            return "Stores"
        }
    }
}

extension GameDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.gameDetailResponse?.platforms?[indexPath.row].isShown.toggle()
        gameDetailTableView.reloadRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
    }
}
