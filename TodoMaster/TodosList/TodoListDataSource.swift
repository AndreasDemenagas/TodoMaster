//
//  TodoListDataSource.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 27/8/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

enum Section {
    case main
    case completed
}

class TodoListDataSource: UITableViewDiffableDataSource<Section, Todo> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
