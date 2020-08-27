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
    var dataSource: TodoListDataSource?
    
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
        dataSource = TodoListDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, todo) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.id, for: indexPath) as! TodoListCell
            cell.todo = todo
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteTodo(at: indexPath)
        let editAction = editTodo(at: indexPath)
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func editTodo(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, _) in
            if let todoToEdit = self.dataSource?.itemIdentifier(for: indexPath) {
                let editController = CreateTodoController()
                editController.createDelegate = self
                editController.todo = todoToEdit
                let navController = UINavigationController(rootViewController: editController)
                self.present(navController, animated: true, completion: nil)
            }
        }
        action.backgroundColor = .mainGreen
        return action
    }
    
    func deleteTodo(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, _) in
            if let todoToDelete = self.dataSource?.itemIdentifier(for: indexPath) {
                PersistanceManager.shared.removeTodo(todo: todoToDelete) { (error) in
                    if let error = error {
                        print("Failed to delete todo...", error)
                        return
                    }
                    self.todos.remove(at: indexPath.row)
                    self.createSnapshot(with: self.todos)
                }
            }
        }
        action.backgroundColor = .systemRed
        return action
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
    
    func didEditTodo(todo: Todo) {
      
    }
    
}

