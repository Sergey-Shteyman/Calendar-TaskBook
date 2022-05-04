//
//  TaskViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 03.05.2022.
//

import UIKit

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: AnyObject {

}

// MARK: - TaskViewController
final class TaskViewController: UIViewController {
    
    var presenter: TaskPresenter?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldSystemFont(ofSize: 30)
        textField.textAlignment = .center
        textField.placeholder = "New task"
        textField.text = "Task 1"
        return textField
    }()
    
    private lazy var dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        return dataPicker
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - TaskViewControllerProtocol Impl
extension TaskViewController: TaskViewControllerProtocol {

}

// MARK: Private Methods
private extension TaskViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        addSubViews()
        addConstraints()
    }
    
    func addSubViews() {
        let arraySubViews = [titleTextField]
        view.myAddSubViews(from: arraySubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
