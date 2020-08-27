//
//  AddTodoButton.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 24/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class AddTodoButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    weak var delegate: AddTodoDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "plus-white")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 35).cgPath
            shadowLayer.fillColor = UIColor.mainGreen.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 5

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handleButtonPressed() {
        delegate?.didTapAddButton()
    }
    
    
}
