//
//  ContainerViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - ContainerViewControllerProtocol
protocol ContainerViewControllerProtocol: AnyObject {
    func updateTableView (sections: [Section])
}

// MARK: - ContainerViewController
final class ContainerViewController: UIViewController {
    
    var presenter: ContainerPresenterProtocol?
    
    private var sections: [Section] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.myRegister(CalendarViewCell.self)
        tableView.myRegister(TaskCell.self)
        tableView.dataSource = self
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
    
    func updateTableView(sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource Impl
extension ContainerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let type = sections[section].rows[row]
        
        switch type {
        case .calendar(let viewModel):
            let cell = tableView.myDequeueReusableCell(type: CalendarViewCell.self, indePath: indexPath)
            cell.delegate = self
            cell.setupCellConfiguration(viewModel: viewModel)
            return cell
        case .task(let viewModel):
            let cell = tableView.myDequeueReusableCell(type: TaskCell.self, indePath: indexPath)
            cell.setupCellConfiguration(viewModel)
            cell.backgroundColor = .red
            return cell
        }
    }
}

// MARK: - CalendarViewCellDelegate Impl
extension ContainerViewController: CalendarViewCellDelegate {
    
    func calendarViewDidTapNextMonthButton() {
        presenter?.didTapNextMonthButton()
    }
    
    func calendarViewDidTapPreviousMonthButton() {
        presenter?.didTapPreviousMonthButton()
    }
}

// MARK: - Private Methods
private extension ContainerViewController {
    func setupViewController() {
        view.myAddSubView(tableView)
        view.backgroundColor = .white
        addConstraints()
        presenter?.viewIsReady()
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
