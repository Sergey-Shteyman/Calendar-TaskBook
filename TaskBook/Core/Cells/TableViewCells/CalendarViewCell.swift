//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarViewCellDelegate
protocol CalendarViewCellDelegate: AnyObject {
    func didTapSelectedSquare(index: Int)
}

// MARK: - CalendarViewCell
final class CalendarViewCell: UITableViewCell {
    
    weak var delegate: CalendarViewCellDelegate?
    
    private var totalSquares = [CollectionViewCellViewModel]()
    private var selectedDate: Int?
    
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
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.myRegister(CollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension CalendarViewCell {
    
    func setupCellConfiguration(viewModel: CalendarViewModel) {
        totalSquares = viewModel.squares
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate Impl
extension CalendarViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        delegate?.didTapSelectedSquare(index: index)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource Impl
extension CalendarViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.myDequeueReusableCell(type: CollectionViewCell.self, indePath: indexPath)
        let viewModel = totalSquares[indexPath.item]
        myCell.setupCellWith(viewModel: viewModel)
        return myCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension CalendarViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 20) / 9
        let height = width
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private Methods
private extension CalendarViewCell {

    func setupCell() {
        addSubViews()
        addDaysToStackView()
        addConstraints()
    }

    func addDaysToStackView() {
        let weekDay = [
            WeekDay.monday, WeekDay.tuesday,
            WeekDay.wednesday, WeekDay.thursday, WeekDay.friday,
            WeekDay.saturday, WeekDay.sunday
        ]
        
        var countDays = 0
        for day in weekDay {
            let label = UILabel()
            label.text = day.rawValue
            label.font = .systemFont(ofSize: 19)
            label.textAlignment = .center
            if countDays > 4 {
                label.textColor = .gray
            }
            countDays += 1
            stackView.addArrangedSubview(label)
        }
    }

    func addSubViews() {
        let arraySubViews = [stackView, collectionView]
        contentView.myAddSubViews(from: arraySubViews)
    }
    
    func fetchCallendarViewHeight() -> CGFloat {
        let heightCollectionView: CGFloat = 10 * 5
        let heightCell = (UIScreen.main.bounds.width - 20) / 9
        let result = (heightCell * 6) + heightCollectionView
        return result 
    }

    func addConstraints() {
        
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: fetchCallendarViewHeight())
        ])
    }
}
