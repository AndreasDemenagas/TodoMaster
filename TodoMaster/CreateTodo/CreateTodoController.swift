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
    
    lazy var createTodoView = CreateTodoView(todoFunction: self.handleCreate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlueBackground
        setupNavigationBar()
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
    
    fileprivate func setupNavigationBar() {
        title = "New"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
