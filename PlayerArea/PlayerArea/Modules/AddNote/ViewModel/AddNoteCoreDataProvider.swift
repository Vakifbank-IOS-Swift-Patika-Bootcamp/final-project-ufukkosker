//
//  AddNoteCoreDataProvider.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class AddNoteCoreDataProvider: AddNoteCoreDataProviderProtocol {

    private let addNoteCoreDataManager: AddNoteFetchable
    
    init(addNoteCoreDataManager: AddNoteFetchable) {
        self.addNoteCoreDataManager = addNoteCoreDataManager
    }
    
    func saveNote(with note: NoteModel, completion: (Result<NoteModel, Error>) -> Void) {
        addNoteCoreDataManager.saveNote(with: note, completion: completion)
    }
    
    func updateNote(with id: Int, model: NoteModel, completion: (Result<Bool, Error>) -> Void) {
        addNoteCoreDataManager.updateNote(with: id, model: model, completion: completion)
    }
    
    func noteContains(id: Int, completion: (Result<Bool, Error>) -> Void) {
        addNoteCoreDataManager.noteContains(id: id, completion: completion)
    }
    
    func searchNoteById(_ id: Int, completion: (Result<NoteModel?, Error>) -> Void) {
        addNoteCoreDataManager.searchNoteById(id, completion: completion)
    }
}
