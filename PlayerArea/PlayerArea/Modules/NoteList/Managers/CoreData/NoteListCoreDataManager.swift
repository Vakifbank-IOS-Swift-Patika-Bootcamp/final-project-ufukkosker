//
//  NoteListCoreDataManager.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class NoteListCoreDataManager: NoteListFetchable {
    
    private let noteListCoreDataManager: CoreDataProviderProtocol
    
    init(noteListCoreDataManager: CoreDataProviderProtocol) {
        self.noteListCoreDataManager = noteListCoreDataManager
    }
    
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void) {
        noteListCoreDataManager.getAllNotes(completion: completion)
    }
    
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void) {
        noteListCoreDataManager.deleteNote(with: id, completion: completion)
    }
}
