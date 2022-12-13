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
    }
}

extension MainViewController: MainViewModelDelegate {
    func handle(output: MainViewModelOutput) {
        switch output {
        case .fetchedCategories:
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
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[section]
        else { return 0 }
        switch mainTableViewSection {
        case .categories:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[indexPath.section]
        else { return UITableViewCell() }
        
        switch mainTableViewSection {
        case .categories(let categories):
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryListCell.self)) as? CategoryListCell {
                cell.categoryItems = categories
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let mainTableViewSection = viewModel?.mainTableViewTypes[section]
        else { return "" }
        
        switch mainTableViewSection {
        case .categories(_):
            return "Categories"
        }
    }
}


