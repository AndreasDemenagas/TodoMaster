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
    
    private let createItemLabel: UILabel = {
        let l = UILabel()
        l.text = "Please enter an item \nusing the button below."
        l.numberOfLines = 0
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        setupNavigationBar()
        setupAddTodoButton()
        
        view.addSubview(createItemLabel)
        createItemLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 88, left: 16, bottom: 0, right: 0), size: .init(width: view.frame.width - 32, height: 50))
        
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
        tableView.separatorStyle = .none
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.id)
        tableView.delegate = self
        setupDataSource()
    }
    
    fileprivate func createSnapshot(with todos: [Todo]) {
        createItemLabel.isHidden = todos.isEmpty ? false : true
        
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
    
    func completeTodo(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, _) in
           print("Completing Todo item")
        }
        action.backgroundColor = .systemBlue
        return action
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = completeTodo(at: indexPath)
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteTodo(at: indexPath)
        let editAction = editTodo(at: indexPath)
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func editTodo(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, _) in
           
        }
        action.backgroundColor = .mainGreen
        return action
    }
    
    func deleteTodo(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, _) in
            guard let todoToDelete = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            PersistanceManager.shared.removeTodo(todo: todoToDelete) { (error) in
                if let error = error {
                    print("Failed to delete todo...", error)
                    return
                }
                guard var snapshot = self.dataSource?.snapshot() else { return }
                snapshot.deleteItems([todoToDelete])
                self.dataSource?.apply(snapshot, animatingDifferences: true)
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
        self.todos.insert(todo, at: 0)
        createSnapshot(with: self.todos)
    }
    
    func didEditTodo(todo: Todo) {
      
    }
    
}

