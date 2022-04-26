//
//  TaskViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: AnyObject {
    func display()
}

// MARK: - TaskViewController
final class TaskViewController: UIViewController {
    
    var presenter: TaskPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.colorView()
    }
}

// MARK: - TaskViewController Impl
extension TaskViewController: TaskViewControllerProtocol {
    func display() {
        view.backgroundColor = .green
    }
}
