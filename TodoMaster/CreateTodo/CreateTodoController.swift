//
//  CreateTodoController.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 25/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class CreateTodoController: UIViewController {
    
    weak var createDelegate: CreateTodoDelegate?
    
    lazy var createTodoView = CreateTodoView(didFinishMakingTodo: self.handleCreate, didFinishEditingTodo: self.handleEdit)
    
    var todo: Todo? {
        didSet {
            self.createTodoView.todo = todo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlueBackground
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = todo == nil ? "New" : "Edit"
    }
    
    override func loadView() {
        view = createTodoView
    }
    
    fileprivate func handleCreate(text: String, priority: String) {
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
    
    fileprivate func handleEdit(text: String, priority: String) {
        guard let todo = self.todo else { return }
        PersistanceManager.shared.editTodo(todo: todo, with: text, priority: priority) { (result) in
            switch result {
            case .failure(let error):
                print("Error editing todo - ", error)
            case .success(let todo):
                self.dismiss(animated: true) {
                    self.createDelegate?.didEditTodo(todo: todo)
                }
            }
        }
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
