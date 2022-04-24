//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarViewProtocol
protocol CalendarViewProtocol: AnyObject {
    func showCurrentMonth(with date: String)
    func display(with squares: [String])
}

// MARK: - CalendarViewController
class CalendarViewController: UIViewController {
    
    var presenter: CalendarPresenter?
    
    private var totalSquares = [String]()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemRed
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()

    private lazy var rightButton: UIButton = {
        var button = UIButton()
        button.tintColor = .systemRed
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: Arrow.right.rawValue, withConfiguration: boldConfiguration), for: .normal)
        button.addTarget(self, action: #selector(changeToNextMonth), for: .touchUpInside)
        return button
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: Arrow.left.rawValue, withConfiguration: boldConfiguration), for: .normal)
        button.addTarget(self, action: #selector(changeToPreviousMonth), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.myRegister(CalenderViewCell.self)
        collectionView.backgroundColor = .darkGray
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc func changeToNextMonth() {
        presenter?.changeToNextMonth()
    }

    @objc func changeToPreviousMonth() {
        presenter?.changeToPreviousMonth()
    }
}

// MARK: - CalendarViewProtocol Impl
extension CalendarViewController: CalendarViewProtocol {
    
    func display(with squares: [String]) {
        totalSquares = squares
        collectionView.reloadData()
    }

    func showCurrentMonth(with date: String) {
        dateLabel.text = date
    }
}

// MARK: - UICollectionViewDelegate Impl
extension CalendarViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource Impl
extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.myDequeueReusableCell(type: CalenderViewCell.self, indePath: indexPath)
        myCell.setupCell(with: totalSquares[indexPath.item])
        return myCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 9
        let height = (collectionView.frame.size.height - 2) / 15
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private Methods
private extension CalendarViewController {
    
    func setupViewController() {
        addSubViews()
        addDaysToStackView()
        addConstraints()
        view.backgroundColor = .darkGray
        presenter?.setMonthView()
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
            label.textColor = .white
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
    
    func addSubViews() {
        let arraySubViews = [leftButton, dateLabel, rightButton, stackView, collectionView]
        view.myAddSubViews(from: arraySubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            
            leftButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -7),
            
            rightButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 7),
            
            stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

