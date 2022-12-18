//
//  NoteListViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import UIKit

class NoteListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: NoteListViewModelProtocol? {
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
        let noteCellName = String(describing: NoteItemCell.self)
        let noteCellNib = UINib(nibName: noteCellName, bundle: .main)
        tableView.register(noteCellNib, forCellReuseIdentifier: noteCellName)
        
        tableView.dataSource = self
    }
}
extension NoteListViewController: NoteListViewModelDelegate {
    func handle(output: NoteListViewModelOutput) {
        switch output {
        case .fetchedNotes:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .didDelete:
            break
        }
    }
}

extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notesCount = viewModel?.notes?.count
        else { return 0 }
        return notesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let notes = viewModel?.notes
        else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteItemCell.self)) as? NoteItemCell {
            cell.setupCell(title: notes[indexPath.row].title ?? "")
            return cell
        }
        return UITableViewCell()
    }
}
