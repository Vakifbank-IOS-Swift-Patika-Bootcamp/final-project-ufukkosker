//
//  NoteListViewModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class NoteListViewModel: NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate?
    var notes: [Note]?
    
    private let coreDataProvider: NoteListCoreDataProviderProtocol?
    
    init(coreDataProvider: NoteListCoreDataProviderProtocol) {
        self.coreDataProvider = coreDataProvider
    }
    
    func viewDidLoad() {
        getAllNotes()
    }
    
    func noteDelete() {
        
    }
    
    func getAllNotes() {
        coreDataProvider?.getAllNotes(completion: { result in
            switch result {
            case .success(let response):
                notes = response
                notify(.fetchedNotes)
            case .failure(_):
                break
            }
        })
    }

    private func notify(_ output: NoteListViewModelOutput) {
        delegate?.handle(output: output)
    }
}
