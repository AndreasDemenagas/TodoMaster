//
//  ReusableView.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 27/8/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol ReusableView {
    static var id: String { get }
}

extension ReusableView {
    static var id: String {
        return String(describing: self)
    }
}
