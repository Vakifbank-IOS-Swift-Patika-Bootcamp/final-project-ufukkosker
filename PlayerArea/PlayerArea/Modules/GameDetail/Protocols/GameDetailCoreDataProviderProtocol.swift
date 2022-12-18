//
//  GameDetailCoreDataProviderProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

protocol GameDetailCoreDataProviderProtocol {
    func saveNote(with note: NoteModel, completion: (Result<NoteModel, Error>) -> Void)
    func updateNote(with id: Int, model: NoteModel, completion: (Result<Bool, Error>) -> Void)
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void)
    func searchNoteById(_ id: Int, completion: (Result<NoteModel?, Error>) -> Void)
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void)
    func noteContains(id: Int, completion: (Result<Bool, Error>) -> Void)
}
