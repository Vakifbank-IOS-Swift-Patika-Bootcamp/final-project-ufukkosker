//
//  NoteListCoreDataProviderProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

protocol NoteListCoreDataProviderProtocol {
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void)
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void)
}
