//
//  NoteListFetchable.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

protocol NoteListFetchable {
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void)
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void)
}
