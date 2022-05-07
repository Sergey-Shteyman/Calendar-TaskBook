//
//  ContainerViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - ContainerViewControllerProtocol
protocol ContainerViewControllerProtocol: AnyObject {
    func updateDateLabel(with title: String)
    func updateTableView (sections: [Section])
    func routeTo(_ viewController: UIViewController)
}

// MARK: - ContainerViewController
final class ContainerViewController: UIViewController {
    
    var presenter: ContainerPresenterProtocol?
    
    private var sections: [Section] = []
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: Arrow.left.rawValue, withConfiguration: boldConfiguration), for: .normal)
        button.addTarget(self, action: #selector(changeToPreviousMonth), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        var button = UIButton()
        button.tintColor = .red
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: Arrow.right.rawValue, withConfiguration: boldConfiguration), for: .normal)
        button.addTarget(self, action: #selector(changeToNextMonth), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.myRegister(CalendarViewCell.self)
        tableView.myRegister(NewTaskCell.self)
        tableView.myRegister(TaskCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc func changeToPreviousMonth() {
        presenter?.didTapPreviousMonthButton()
    }
    
    @objc func changeToNextMonth() {
        presenter?.didTapNextMonthButton()
    }
}

// MARK: - ContainerViewControllerProtocol Impl
extension ContainerViewController: ContainerViewControllerProtocol {
    
    func updateDateLabel(with title: String) {
        dateLabel.text = title
    }
    
    func routeTo(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func updateTableView(sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ContainerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            presenter?.firstFetchTaskViewController(with: indexPath)
        }
        if indexPath.section > 1 {
            presenter?.fetchTaskViewController(with: indexPath)
        }
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
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.delegate = self
            cell.setupCellConfiguration(viewModel: viewModel)
            return cell
        case .newTask:
            let cell = tableView.myDequeueReusableCell(type: NewTaskCell.self, indePath: indexPath)
            cell.setupCellConfiguration()
            return cell
        case .task(let viewModel):
            let cell = tableView.myDequeueReusableCell(type: TaskCell.self, indePath: indexPath)
            cell.setupCellConfiguration(viewModel)
            return cell
        }
    }
}

// MARK: - CalendarViewCellDelegate Impl
extension ContainerViewController: CalendarViewCellDelegate {
    
    func selectedSquere(numberOfSqueres: Int) {
        presenter?.selectedSquere(index: numberOfSqueres)
    }
    
    func currentSquere() -> Int? {
        guard let currentDay = presenter?.currentDay() else {
            return nil
        }
        return currentDay
    }
    
    func calendarViewDidTapItem(index: Int) {
        presenter?.didTapDay(index: index)
    }
    
    func searchWeekend(indexPath: IndexPath) -> Bool {
        guard let isWeekend = presenter?.isWeekend(indexPath: indexPath) else {
            return Bool()
        }
        return isWeekend
    }
}

// MARK: - Private Methods
private extension ContainerViewController {
    
    func setupViewController() {
        view.myAddSubView(tableView)
        view.backgroundColor = .white
        addConstraints()
        setupBarNavigationItems()
        presenter?.viewIsReady()
    }
    
    func setupBarNavigationItems() {
        addSubViewsOnNavigationBar()
        addConstraintsForNavigationItems()
    }
    
    func addSubViewsOnNavigationBar() {
        let arrayNavigationBarSubviews = [leftButton, dateLabel, rightButton]
        self.navigationController?.navigationBar.myAddSubViews(from: arrayNavigationBarSubviews)
    }
    
    func addConstraintsForNavigationItems() {
        guard let titleView = self.navigationController?.navigationBar else {
            return
        }
        NSLayoutConstraint.activate([
            
            leftButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -7),
            
            dateLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -7),
            dateLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            
            rightButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 7)
        ])
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
