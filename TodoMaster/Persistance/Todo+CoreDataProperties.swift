//
//  Todo+CoreDataProperties.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 23/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String

}
