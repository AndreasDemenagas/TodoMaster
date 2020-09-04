//
//  CreateTodoView.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 31/8/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class CreateTodoView: UIView {
    
    private let backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightBlueBackground
        return v
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Title"
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Title"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    private let priorityLabel: UILabel = {
        let l = UILabel()
        l.text = "Set Priority"
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let prioritySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Small", "Medium", "High"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let createTodoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create Todo", for: .normal)
        btn.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    var todo: Todo? {
        didSet {
            guard let todo = todo else { return }
            configureView(with: todo)
        }
    }
    
    var didCreateTodo: ((String, String) -> Void)
    
    init(didFinishMakingTodo: @escaping ((String, String) -> Void) ) {
        self.didCreateTodo = didFinishMakingTodo
    
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureView(with todo: Todo) {
        
    }
    
    fileprivate func setupViews() {
        addSubview(backgroundView)
        backgroundView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: .zero, height: 210))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: backgroundView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: .zero, height: 30))
        
        addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        addSubview(priorityLabel)
        priorityLabel.anchor(top: titleTextField.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 30))
        
        addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: priorityLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        addSubview(createTodoButton)
        createTodoButton.anchor(top: backgroundView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 40, bottom: 0, right: 40), size: .init(width: .zero, height: 50))
    }
    
    @objc func handleButtonPressed() {
        guard titleTextField.text != "", let text = titleTextField.text else {
            print("Empty text field...")
            return
        }
        guard let priority = prioritySegmentedControl.titleForSegment(at: prioritySegmentedControl.selectedSegmentIndex) else { return }
        
        didCreateTodo(text, priority)
    }
    
}
