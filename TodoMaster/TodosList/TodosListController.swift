//
//  ViewController.swift
//  TodoMaster
//
//  Created by Andrew Demenagas on 22/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class TodosListController: UIViewController {
    
    let addTodoBtn = AddTodoButton(type: .system)
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.fillSuperView()
        
        setupNavigationBar()
        setupAddTodoButton()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Today"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupAddTodoButton() {
        view.addSubview(addTodoBtn)
        addTodoBtn.delegate = self
        addTodoBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 50, right: 50), size: .init(width: 70, height: 70))
    }
    
}

extension TodosListController: AddTodoDelegate {
    
    func didTapAddButton() {
        let createController = UINavigationController(rootViewController: CreateTodoController())
        createController.modalPresentationStyle = .fullScreen
        present(createController, animated: true, completion: nil)
    }
    
}

