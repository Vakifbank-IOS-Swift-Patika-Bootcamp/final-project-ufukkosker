//
//  MainViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
}

extension MainViewController: MainViewModelDelegate {
    func handle(output: MainViewModelOutput) {
        switch output {
        case .fetchedCategories:
            break
        }
    }
}
