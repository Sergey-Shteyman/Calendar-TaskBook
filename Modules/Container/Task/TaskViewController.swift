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
        view.backgroundColor = .green
    }
}
