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
        tableView.myRegister(CalendarViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
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

// MARK: - UITableViewDelegate Impl
extension ContainerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height / 2 - 60
    }
}

// MARK: - UITableViewDataSource Impl
extension ContainerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < 1 {
//            guard let myCell = presenter?.moduleBuilder.buildCalendarModule() else {
//                return UITableViewCell()
//            }
//            myCell.setupCellConfiguration()
//            return myCell
//        }
        guard let cell = presenter?.moduleBuilder.buildTaskModule() else {
            return UITableViewCell()
        }
        cell.setupCellConfiguration()
        return cell
    }
}

// MARK: - Private Methods
private extension ContainerViewController {
    func setupViewController() {
        view.myAddSubView(tableView)
        view.backgroundColor = .white
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
