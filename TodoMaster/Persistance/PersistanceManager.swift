//
//  PersistanceManager.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 23/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceManager {
    
    private init() {}
    
    static let shared = PersistanceManager()
    
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoMaster")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func editTodoItem(todo: Todo, title: String, priority: String, completion: @escaping (Result<Todo, Error>) -> () ) {
        todo.title = title
        todo.priority = priority
        
        saveContext { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(todo))
        }
    }
    
    func createTodo(with title: String, priority: String, completion: @escaping (Result<Todo, Error>) -> () ) {
        let todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo
        todo.title = title
        todo.priority = priority
        todo.addedAt = Date()
        saveContext { (error) in
            if error == nil {
                completion(.success(todo))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func removeTodo(todo: Todo, completion: @escaping (Error?) -> () ) {
        self.context.delete(todo)
        saveContext { (error) in
            if error == nil {
                completion(nil)
                return
            }
            completion(error)
        }
    }
    
    func saveContext(didComplete: @escaping (Error?) -> () ) {
        if context.hasChanges {
            do {
                try context.save()
                didComplete(nil)
            } catch {
                let nserror = error as NSError
                didComplete(error)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchTodos() -> [Todo] {
        let result = fetch(Todo.self)
        switch result {
        case .success(let todos):
            return todos
        case .failure:
            return []
        }
    }
    
    
    fileprivate func fetch<T: NSManagedObject>(_ type: T.Type) -> Result<[T], Error> {
        let entityName = String(describing: type)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let objects = try context.fetch(fetchRequest) as? [T]
            return .success(objects ?? [])
        }
        
        catch {
            print("Error in fetching type \(T.Type.self)", error)
            return .failure(error)
        }
    }
    
    func batchDeleteTodos(completion: @escaping (Error?) -> ()) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Todo.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            completion(nil)
        }
        catch {
            completion(error)
        }
    }
    
}
