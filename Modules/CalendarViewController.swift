//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarViewProtocol
protocol CalendarViewProtocol: AnyObject {
    
}

// MARK: - CalendarViewController
class CalendarViewController: UIViewController {
    
    var presenter: CalendarPresenter?
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Marth 2022"
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()

    private lazy var rightButton: UIButton = {
        var button = UIButton()
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: boldConfiguration), for: .normal)
        return button
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: "arrow.left", withConfiguration: boldConfiguration), for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewController()
    }
}

// MARK: - CalendarViewProtocol Impl
extension CalendarViewController: CalendarViewProtocol {
    
}

// MARK: - Private Methods
private extension CalendarViewController {
    
    func setupViewController() {
        addSubViews()
        addDaysToStackView()
        addConstraints()
    }
    
    func addDaysToStackView() {
        let weekDay = [
            WeekDay.sunday, WeekDay.monday, WeekDay.tuesday,
            WeekDay.wednesday, WeekDay.thursday, WeekDay.friday,
            WeekDay.saturday
        ]
        for day in weekDay {
            let label = UILabel()
            label.text = day.rawValue
            stackView.addArrangedSubview(label)
        }
    }
    
    func addSubViews() {
        let arraySubViews = [leftButton, dateLabel, rightButton, stackView]
        view.myAddSubViews(from: arraySubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            leftButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -38),
            
            rightButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 38),
            
            stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

