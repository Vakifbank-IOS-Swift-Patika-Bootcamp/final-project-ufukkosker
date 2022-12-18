//
//  AddNoteViewModel.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    var delegate: AddNoteViewModelDelegate?
    var gameId: Int?
    var gameName: String?
    var coreDataNoteModel: NoteModel?
    private let coreDataProvider: AddNoteCoreDataProviderProtocol?
    
    init(coreDataProvider: AddNoteCoreDataProviderProtocol) {
        self.coreDataProvider = coreDataProvider
    }
    
    func viewDidLoad() {
        
    }
    
    func saveNote() {
        guard let noteModel = coreDataNoteModel
        else { return }
        coreDataProvider?.saveNote(with: noteModel, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        })
    }
    
    func noteContains() {
        guard let noteModel = coreDataNoteModel
        else { return }
        coreDataProvider?.noteContains(id: Int(noteModel.id), completion: { result in
            switch result {
            case .success(let response):
                if response {
                    updateNote()
                    notify(.didSave)
                } else {
                    saveNote()
                    notify(.didSave)
                }
            case .failure(_):
                break
            }
        })
    }
    
    func updateNote() {
        guard let noteModel = coreDataNoteModel
        else { return }
        coreDataProvider?.updateNote(with: Int(noteModel.id), model: noteModel, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        })
    }
    
    
    private func notify(_ output: AddNoteViewModelOutput) {
        delegate?.handle(output: output)
    }
}
