//
//  UIColor+Theme.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 26/6/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit
 
extension UIColor {

    static let mainGreen = UIColor.rgb(r: 14, g: 190, b: 190)
    static let darkBlueBackground = UIColor.rgb(r: 9, g: 45, b: 64)
    static let lightBlueBackground = UIColor.rgb(r: 218, g: 235, b: 243)
    
    static let viewBackground = UIColor.secondarySystemBackground
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
