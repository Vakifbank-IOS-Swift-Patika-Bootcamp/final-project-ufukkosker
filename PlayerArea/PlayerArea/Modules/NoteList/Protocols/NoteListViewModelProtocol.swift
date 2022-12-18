//
//  NoteListViewModelProtocol.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import Foundation

protocol NoteListViewModelProtocol: AnyObject {
    var delegate: NoteListViewModelDelegate? { get set }
    var notes: [Note]? { get set }
    
    func viewDidLoad()
    func noteDelete()
    func getAllNotes()
}

enum NoteListViewModelOutput {
    case fetchedNotes
    case didDelete
}

protocol NoteListViewModelDelegate: AnyObject {
    func handle(output: NoteListViewModelOutput)
}
