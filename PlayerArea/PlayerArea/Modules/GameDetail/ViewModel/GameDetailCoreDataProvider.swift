//
//  GameDetailCoreDataProvider.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class GameDetailCoreDataProvider: GameDetailCoreDataProviderProtocol {

    private let gameDetailCoreDataManager: GameDetailCoreDataFetchable
    
    init(gameDetailCoreDataManager: GameDetailCoreDataManager) {
        self.gameDetailCoreDataManager = gameDetailCoreDataManager
    }
    
    func saveNote(with note: NoteModel, completion: (Result<NoteModel, Error>) -> Void) {
        gameDetailCoreDataManager.saveNote(with: note, completion: completion)
    }
    
    func updateNote(with id: Int, model: NoteModel, completion: (Result<Bool, Error>) -> Void) {
        gameDetailCoreDataManager.updateNote(with: id, model: model, completion: completion)
    }
    
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void) {
        gameDetailCoreDataManager.deleteNote(with: id, completion: completion)
    }
    
    func searchNoteById(_ id: Int, completion: (Result<NoteModel?, Error>) -> Void) {
        gameDetailCoreDataManager.searchNoteById(id, completion: completion)
    }
    
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void) {
        gameDetailCoreDataManager.getAllNotes(completion: completion)
    }
    
    func noteContains(id: Int, completion: (Result<Bool, Error>) -> Void) {
        gameDetailCoreDataManager.noteContains(id: id, completion: completion)
    }
}
