//
//  NoteListCoreDataProvider.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

final class NoteListCoreDataProvider: NoteListCoreDataProviderProtocol {
    private let noteLİstCoreDataManager: NoteListFetchable
    
    init(noteLİstCoreDataManager: NoteListFetchable) {
        self.noteLİstCoreDataManager = noteLİstCoreDataManager
    }
    
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void) {
        noteLİstCoreDataManager.getAllNotes(completion: completion)
    }
    
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void) {
        noteLİstCoreDataManager.deleteNote(with: id, completion: completion)
    }
}
