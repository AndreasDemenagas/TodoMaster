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
    
    private let addedAtLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.text = "Added: Jul 13, 2020"
        lbl.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 15))
        return lbl
    }()
    
    private let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    var todo: Todo? {
        didSet {
            titleLabel.text = todo?.title
            setPriority(priority: todo?.priority)
            addedAtLabel.text = "Added: " + formatAddedDate(date: todo?.addedAt)
            
            if todo!.completed {
                completedTodo()
            } else {
                print("\(todo!.title!) is NOT completed....")
            }
        }
    }
    
    private func completedTodo() {
        accessoryType = .checkmark
        titleLabel.textColor = .lightGray
        titleLabel.alpha = 0.5
        priorityLabel.alpha = 0.5
        addedAtLabel.alpha = 0.5
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
    
    private func formatAddedDate(date: Date?) -> String {
        guard let date = date else {
            return "nil"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(addedAtLabel)
        addedAtLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 16, bottom: 0, right: 0))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: addedAtLabel.bottomAnchor, leading: addedAtLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addSubview(priorityLabel)
        priorityLabel.anchor(top: titleLabel.bottomAnchor, leading: addedAtLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        addSubview(separator)
        separator.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: .zero, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
