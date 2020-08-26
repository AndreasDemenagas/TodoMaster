//
//  TodoListCell.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 24/8/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell, ReusableView {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFontMetrics.default.scaledFont(for: .boldSystemFont(ofSize: 18))
        return lbl
    }()
    
    private let priorityLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemRed
        lbl.text = "High"
        lbl.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 15))
        return lbl
    }()
    
    var todo: Todo? {
        didSet {
            titleLabel.text = todo?.title
            setPriority(priority: todo?.priority)
        }
    }
    
    private func setPriority(priority: String?) {
        guard let prior = priority else {
            priorityLabel.text = "Undefined"
            return
        }
        priorityLabel.text = prior
        switch priority {
        case "High":
            priorityLabel.textColor = .systemRed
        case "Medium":
            priorityLabel.textColor = .systemBlue
        case "Small":
            priorityLabel.textColor = .systemGreen
        default:
            priorityLabel.textColor = .red
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 16, bottom: 0, right: 0))
        
        addSubview(priorityLabel)
        priorityLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}