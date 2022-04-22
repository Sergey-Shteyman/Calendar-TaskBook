//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarViewProtocol
protocol CalendarViewProtocol: AnyObject {
    func showCurrentMonth()
}

// MARK: - CalendarViewController
class CalendarViewController: UIViewController {
    
    var presenter: CalendarPresenter?
    
    var sectedDate = Date()
    var totalSquares = [String]()
    
    // TODO: -
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Marth 2022"  //
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
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.myRegister(CalenderViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    func showCurrentMonth() {
        print(#function)
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

// MARK: - Private Methods
private extension CalendarViewController {
    
    func setupViewController() {
        setCellsView()
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
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
    
    func setCellsView() {
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let height = (collectionView.frame.size.height - 2) / 8
        let width = (collectionView.frame.size.width - 2) / 8
        guard let flowLayout = flowLayout else {
            return
        }
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func addSubViews() {
        let arraySubViews = [leftButton, dateLabel, rightButton, stackView, collectionView]
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
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

