//
//  CoreDataManager.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import CoreData

protocol CoreDataProviderProtocol {
    func saveNote(with note: NoteModel, completion: (Result<NoteModel, Error>) -> Void)
    func updateNote(with id: Int, model: NoteModel, completion: (Result<Bool, Error>) -> Void)
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void)
    func searchNoteById(_ id: Int, completion: (Result<NoteModel?, Error>) -> Void)
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void)
    func noteContains(id: Int, completion: (Result<Bool, Error>) -> Void)
}

class NoteCoreDataManager: CoreDataProviderProtocol {

//    static let shared = NoteCoreDataManager()
//
//    private init() { }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlayerArea")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveNote(with note: NoteModel, completion: (Result<NoteModel, Error>) -> Void) {
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        let noteEntity = Note(entity: entityDescription, insertInto: context)

        noteEntity.id = note.id
        noteEntity.note = note.note
        noteEntity.title = note.title
        noteEntity.isFavorite = note.isFavorite

        do {
            try context.save()
            let noteModel = NoteModel(id: noteEntity.id, title: noteEntity.title, note: noteEntity.note, isFavorite: noteEntity.isFavorite)
            completion(.success(noteModel))
        } catch {
            print("Error saving note entity")
            completion(.failure(error))
        }
    }
    
    func updateNote(with id: Int, model: NoteModel, completion: (Result<Bool, Error>) -> Void) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let notes = try context.fetch(request)
            guard let note = notes.first else {
                completion(.failure(NSError(domain: "Error fetching note with id: \(id)", code: 0, userInfo: nil)))
                return
            }
            note.title = model.title
            note.note = model.note
            note.isFavorite = model.isFavorite
            
            do {
                try context.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteNote(with id: Int, completion: (Result<Bool, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let notes = try context.fetch(fetchRequest)
            for note in notes {
                context.delete(note as! NSManagedObject)
            }
            try context.save()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func searchNoteById(_ id: Int, completion: (Result<NoteModel?, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note>
        fetchRequest = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format : "id == %d", id)
        do{
            let result: [Note]?
            result = try context.fetch(fetchRequest)
            guard let note = result?.first else { return }
            let noteModel = NoteModel(id: note.id, title: note.title, note: note.note, isFavorite: note.isFavorite)
            completion(.success(noteModel))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getAllNotes(completion: (Result<[Note]?, Error>) -> Void) {
        var notes:[Note]?
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")
        
        do{
             notes = try context.fetch(fetchRequest) as? [Note]
            completion(.success(notes))
         } catch {
             print("Error while fetching data")
             completion(.failure(error))
         }
    }
    
    func noteContains(id: Int, completion: (Result<Bool, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let notes = try context.fetch(request)
            if notes.count > 0 {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

