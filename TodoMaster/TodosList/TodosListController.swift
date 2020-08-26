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
    
    enum Section {
        case main
    }
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Todo>?
    
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        setupNavigationBar()
        setupAddTodoButton()
        
        fetchTodos()
    }
    
    fileprivate func fetchTodos() {
        todos = PersistanceManager.shared.fetchTodos()
        createSnapshot(with: todos)
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.fillSuperView()
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.id)
        tableView.delegate = self
        setupDataSource()
    }
    
    fileprivate func createSnapshot(with todos: [Todo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Todo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(todos)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        print("Applied Snapshot")
    }
    
    fileprivate func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Todo>(tableView: tableView, cellProvider: { (tableView, indexPath, todo) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.id, for: indexPath) as! TodoListCell
            cell.titleLabel.text = todo.title
            return cell
        })
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Today"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "RESET", style: .plain, target: self, action: #selector(handleResetList))
    }
    
    fileprivate func setupAddTodoButton() {
        view.addSubview(addTodoBtn)
        addTodoBtn.delegate = self
        addTodoBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 50, right: 50), size: .init(width: 70, height: 70))
    }
    
    @objc fileprivate func handleResetList() {
        PersistanceManager.shared.batchDeleteTodos { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                print("Failed to batch delete todos ", error)
                return
            }
            
            self.todos.removeAll()
            self.createSnapshot(with: self.todos)
        }
    }
    
    
    
}

extension TodosListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension TodosListController: AddTodoDelegate {
    
    func didTapAddButton() {
        let todoController = CreateTodoController()
        todoController.createDelegate = self
        let createController = UINavigationController(rootViewController: todoController)
        createController.modalPresentationStyle = .fullScreen
        present(createController, animated: true, completion: nil)
    }
    
}

extension TodosListController: CreateTodoDelegate {
    
    func didCreateTodo(todo: Todo) {
        self.todos.append(todo)
        createSnapshot(with: self.todos)
    }
    
}

