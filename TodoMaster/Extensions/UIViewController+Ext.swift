//
//  UIViewController+Ext.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 25/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addchildViewController(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildViewController() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: self)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
