//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarCellProtocol
protocol CalendarCellProtocol: AnyObject {
    func showCurrentMonth(with date: String)
    func display(with squares: [String])
}

// MARK: - CalendarViewCell
class CalendarViewCell: UITableViewCell {
    
    var presenter: CalendarPresenter?
    
    private var totalSquares = [String]()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()

    private lazy var rightButton: UIButton = {
        var button = UIButton()
        let boldConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: Arrow.right.rawValue, withConfiguration: boldConfiguration), for: .normal)
        button.addTarget(self, action: #selector(changeToNextMonth), for: .touchUpInside)
        return button
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
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
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    @objc func changeToNextMonth() {
        presenter?.changeToNextMonth()
    }

    @objc func changeToPreviousMonth() {
        presenter?.changeToPreviousMonth()
    }
}

// MARK: - Public Methods
extension CalendarViewCell {
    
    func setupCellConfiguration() {
        self.backgroundColor = .white
        setupCell()
    }
}

// MARK: - CalendarCellProtocol Impl
extension CalendarViewCell: CalendarCellProtocol {

    func display(with squares: [String]) {
        totalSquares = squares
        collectionView.reloadData()
    }

    func showCurrentMonth(with date: String) {
        dateLabel.text = date
    }
}

// MARK: - UICollectionViewDelegate Impl
extension CalendarViewCell: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource Impl
extension CalendarViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.myDequeueReusableCell(type: CalenderViewCell.self, indePath: indexPath)
        myCell.setupCell(with: totalSquares[indexPath.item])
        return myCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension CalendarViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 9
        let height = (collectionView.frame.size.height - 2) / 7
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private Methods
private extension CalendarViewCell {

    func setupCell() {
        addSubViews()
        addDaysToStackView()
        addConstraints()
        presenter?.setMonthView()
    }

    func addDaysToStackView() {
        let weekDay = [
            WeekDay.monday, WeekDay.tuesday,
            WeekDay.wednesday, WeekDay.thursday, WeekDay.friday,
            WeekDay.saturday, WeekDay.sunday
        ]
        for day in weekDay {
            let label = UILabel()
            label.text = day.rawValue
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }

    func addSubViews() {
        let arraySubViews = [leftButton, dateLabel, rightButton, stackView, collectionView]
        contentView.myAddSubViews(from: arraySubViews)
    }

    func addConstraints() {
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),

            leftButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -7),

            rightButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 7),

            stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
