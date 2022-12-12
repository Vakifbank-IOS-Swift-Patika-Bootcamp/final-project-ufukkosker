//
//  TabBarViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = UrlSessionManager(session: .shared)
        let mainNetworkManager = MainNetworkManager(mainNetworkManager: networkManager)
        let mainDataProvider = MainDataProvider(mainNetworkManager: mainNetworkManager)
        let mainViewModel = MainViewModel(dataProvider: mainDataProvider)
        let mainViewController = MainViewController(nibName: String(describing: MainViewController.self), bundle: .main)
        mainViewController.viewModel = mainViewModel
        mainViewController.tabBarItem.title = "Main"
        mainViewController.tabBarItem.image = UIImage(systemName: "dpad")
        mainViewController.tabBarItem.selectedImage = UIImage(systemName: "dpad.fill")
        
        self.viewControllers = [mainViewController
    }
}
