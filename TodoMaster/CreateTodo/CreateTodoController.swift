//
//  CreateTodoController.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 25/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class CreateTodoController: UIViewController {
    
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
    
    private let locationLabel: UILabel = {
        let l = UILabel()
        l.text = "Location"
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
    
    private let locationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Location"
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
            titleTextField.text = todo?.title
            createTodoButton.setTitle("Save Todo", for: .normal)
        }
    }
    
    weak var createDelegate: CreateTodoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlueBackground
        setupNavigationBar()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = todo == nil ? "New" : "Edit"
    }
    
    @objc fileprivate func handleButtonPressed() {
        if todo == nil {
            print("Creating new todo")
            handleCreate()
        } else {
            print("editing todo")
            handleSaveEditedTodo()
        }
    }
    
    fileprivate func handleSaveEditedTodo() {
        guard let todo = self.todo else { return }
        guard titleTextField.text != "", let text = titleTextField.text else { return }
        guard let priority = prioritySegmentedControl.titleForSegment(at: prioritySegmentedControl.selectedSegmentIndex) else { return }
        
        PersistanceManager.shared.editTodoItem(todo: todo, title: text, priority: priority) { (result) in
            switch result {
            case .failure(let error):
                print("Error editing todo item ", error)
            case .success(let todo):
                self.dismiss(animated: true) {
                    self.createDelegate?.didEditTodo(todo: todo)
                }
            }
        }
    }
    
    fileprivate func handleCreate() {
        guard titleTextField.text != "", let text = titleTextField.text else {
            print("Empty text field...")
            return
        }
        
        guard let priority = prioritySegmentedControl.titleForSegment(at: prioritySegmentedControl.selectedSegmentIndex) else { return }
        
        PersistanceManager.shared.createTodo(with: text, priority: priority) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("Error creating todo ", error)
            case .success(let todo):
                self.dismiss(animated: true) {
                    self.createDelegate?.didCreateTodo(todo: todo)
                }
            }
        }
        
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    fileprivate func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: .zero, height: 300))
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: backgroundView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: .zero, height: 30))
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        view.addSubview(locationLabel)
        locationLabel.anchor(top: titleTextField.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 30))
        
        view.addSubview(locationTextField)
        locationTextField.anchor(top: locationLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        view.addSubview(priorityLabel)
        priorityLabel.anchor(top: locationTextField.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 30))
        
        view.addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: priorityLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 35))
        
        view.addSubview(createTodoButton)
        createTodoButton.anchor(top: backgroundView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 40, bottom: 0, right: 40), size: .init(width: .zero, height: 50))
    }
    
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
