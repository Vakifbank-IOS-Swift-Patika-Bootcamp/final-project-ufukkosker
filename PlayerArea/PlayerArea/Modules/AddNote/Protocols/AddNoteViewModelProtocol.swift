//
//  AddNoteViewModelProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

protocol AddNoteViewModelProtocol: AnyObject {
    var delegate: AddNoteViewModelDelegate? { get set }
    var coreDataNoteModel: NoteModel? { get set }
    var gameId: Int? { get set }
    var gameName: String? { get set }
    
    func viewDidLoad()
    func saveNote()
    func noteContains()
    func updateNote()
}

enum AddNoteViewModelOutput {
    case didSave
}

protocol AddNoteViewModelDelegate: AnyObject {
    func handle(output: AddNoteViewModelOutput)
}
