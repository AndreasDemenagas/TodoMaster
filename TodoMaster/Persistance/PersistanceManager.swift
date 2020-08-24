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
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Context SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> Result<[T], Error> {
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
    
}
