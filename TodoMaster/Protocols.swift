//
//  Protocols.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 24/8/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol AddTodoDelegate: AnyObject {
    func didTapAddButton()
}

protocol CreateTodoDelegate: AnyObject {
    func didTapCreateTodo(with title: String)
}

protocol ReusableView {
    static var id: String { get }
}

extension ReusableView {
    static var id: String {
        return String(describing: self)
    }
}
