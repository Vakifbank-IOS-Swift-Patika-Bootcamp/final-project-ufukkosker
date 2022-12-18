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
        
        let coreDataManager = NoteCoreDataManager()
        let noteListCoreDataManager = NoteListCoreDataManager(noteListCoreDataManager: coreDataManager)
        let noteListCoreDataProvider = NoteListCoreDataProvider(noteLİstCoreDataManager: noteListCoreDataManager)
        let noteListViewModel = NoteListViewModel(coreDataProvider: noteListCoreDataProvider)
        let noteListViewController = NoteListViewController(nibName: String(describing: NoteListViewController.self), bundle: .main)
        noteListViewController.viewModel = noteListViewModel
        noteListViewController.tabBarItem.title = "Note List"
        noteListViewController.tabBarItem.image = UIImage(systemName: "list.clipboard")
        noteListViewController.tabBarItem.selectedImage = UIImage(systemName: "list.clipboard.fill")
        
        self.viewControllers = [mainViewController, noteListViewController]
    }
}
