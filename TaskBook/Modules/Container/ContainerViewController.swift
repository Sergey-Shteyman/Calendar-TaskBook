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
        DispatchQueue.main.async {
            self.dateLabel.text = title
        }
    }

    func routeTo(_ viewController: UIViewController) {
        if let viewController = viewController as? TaskViewController {
            viewController.delegate = self
        }
        DispatchQueue.main.async {
            self.present(viewController, animated: true)
        }
    }

    func updateTableView(sections: [Section]) {
        self.sections = sections
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension ContainerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let type = sections[section].type

        switch type {
        case .calendar:
            break
        case .newTask:
            presenter?.didTapCreateNewTaskButton()
        case .tasks:
            presenter?.didTapTask(with: indexPath.row)
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
            cell.delegate = self
            cell.setupCellConfiguration(viewModel: viewModel, delegate: self)
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

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let section = indexPath.section
        let type = sections[section].type
        switch type {
        case .calendar:
            return .none
        case .newTask:
            return .none
        case .tasks:
            return .delete
        }
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteTask(with: indexPath.row)
        }
    }
}

// MARK: - CalendarViewCellDelegate Impl
extension ContainerViewController: CalendarViewCellDelegate {

    func didTapSelectedSquare(index: Int) {
        presenter?.selectedSquere(index: index)
    }
}

// MARK: - TaskViewControllerDelegate Impl
extension ContainerViewController: TaskViewControllerDelegate {

    func didCreateTask(model: TaskModel) {
        presenter?.didCreateTask(model: model)
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
