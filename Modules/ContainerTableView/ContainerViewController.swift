//
//  ContainerViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - ContainerViewControllerProtocol
protocol ContainerViewControllerProtocol: AnyObject {
    
}

// MARK: - ContainerViewController
final class ContainerViewController: UIViewController {
    
    var presenter: ContainerPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.myRegister(ContainerViewCell.self)
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - ContainerViewControllerProtocol Impl
extension ContainerViewController: ContainerViewControllerProtocol {
    
}

// MARK: - UITableViewDataSource Impl
extension ContainerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Private Methods
private extension ContainerViewController {
    func setupViewController() {
        view.myAddSubView(tableView)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([])
    }
}
