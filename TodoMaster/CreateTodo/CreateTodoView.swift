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
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Title"
        l.textColor = .black
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    private let priorityLabel: UILabel = {
        let l = UILabel()
        l.text = "Set Priority"
        l.textColor = .black
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    
    private let prioritySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Small", "Medium", "High"])
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        return sc
    }()
    
    private let createTodoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create Todo", for: .normal)
        btn.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        btn.backgroundColor = .viewBackground
        btn.setTitleColor(.label, for: .normal)
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
    
    var didCreateTodo: ((String, String) -> ())
    var didEditTodo: ((String, String) -> ())
    
    init(didFinishMakingTodo: @escaping ((String, String) -> ()), didFinishEditingTodo: @escaping ((String, String) -> ()) ) {
        self.didCreateTodo = didFinishMakingTodo
        self.didEditTodo = didFinishEditingTodo
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        setupViewsForDevice()
    }
    
    fileprivate func setupViewsForDevice() {
        if traitCollection.horizontalSizeClass.rawValue == 1 {
            setupViewsForSmallWidth()
        } else {
            setupViewsForNormalWidth()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureView(with todo: Todo) {
        titleTextField.text = todo.title
        createTodoButton.setTitle("Save Todo", for: .normal)
        switch todo.priority {
        case "Small":
            prioritySegmentedControl.selectedSegmentIndex = 0
        case "Medium":
            prioritySegmentedControl.selectedSegmentIndex = 1
        default:
            prioritySegmentedControl.selectedSegmentIndex = 2
        }
    }
    
    fileprivate func setupViewsForNormalWidth() {
        addSubview(backgroundView)
        let height: CGFloat = 20 + 30 + 8 + 35 + 20 + 30 + 8 + 35 + 20
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: frame.width * 0.65),
            backgroundView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        addSubview(titleLabel)
        titleLabel.anchor(top: backgroundView.topAnchor, leading: backgroundView.leadingAnchor, bottom: nil, trailing: backgroundView.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: .zero, height: 30))
        
        addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        addSubview(priorityLabel)
        priorityLabel.anchor(top: titleTextField.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 30))
        
        addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: priorityLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        addSubview(createTodoButton)
        createTodoButton.anchor(top: backgroundView.bottomAnchor, leading: backgroundView.leadingAnchor, bottom: nil, trailing: backgroundView.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 50))
    }
    
    fileprivate func setupViewsForSmallWidth() {
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
            return
        }
        guard let priority = prioritySegmentedControl.titleForSegment(at: prioritySegmentedControl.selectedSegmentIndex) else { return }
        if todo == nil {
            createNewTodo(with: text, and: priority)
            return
        }
        saveEditedTodo(with: text, and: priority)
    }
    
    func createNewTodo(with text: String, and priority: String) {
        didCreateTodo(text, priority)
    }
    
    func saveEditedTodo(with text: String, and priority: String) {
        didEditTodo(text, priority)
    }
    
}
