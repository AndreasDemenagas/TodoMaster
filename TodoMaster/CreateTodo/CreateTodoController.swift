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
    
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    private let prioritySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Small", "Medium", "High"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlueBackground
        setupNavigationBar()
        
        setupViews()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "New"
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
    }
    
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
