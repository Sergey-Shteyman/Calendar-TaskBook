//
//  TaskViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: AnyObject {
    
}

// MARK: - TaskViewController
final class TaskViewCell: UITableViewCell {
    
    var presenter: TaskPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.myRegister(TaskCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

// MARK: - TaskViewController Impl
extension TaskViewCell: TaskViewControllerProtocol {
    
}

// MARK: - Public Methods
extension TaskViewCell {
    func setupCellConfiguration() {
        setupCell()
    }
}

// MARK: - UITableViewDelegate Impl
extension TaskViewCell: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource Impl
extension TaskViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.myDequeueReusableCell(type: TaskCell.self, indePath: indexPath)
        return myCell
    }
}

// MARK: - Private Methods
private extension TaskViewCell {
    
    func setupCell() {
        contentView.myAddSubView(tableView)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
