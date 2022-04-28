//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

protocol CalendarViewCellDelegate: AnyObject {
    func calendarViewDidTapNextMonthButton()
    func calendarViewDidTapPreviousMonthButton()
}

// MARK: - CalendarViewCell
final class CalendarViewCell: UITableViewCell {
    
    weak var delegate: CalendarViewCellDelegate?
    
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
    
    @objc func changeToNextMonth() {
        delegate?.calendarViewDidTapNextMonthButton()
    }

    @objc func changeToPreviousMonth() {
        delegate?.calendarViewDidTapPreviousMonthButton()
    }
}

// MARK: - Public Methods
extension CalendarViewCell {
    
    func setupCellConfiguration(viewModel: CalendarViewModel) {
        dateLabel.text = viewModel.title
        totalSquares = viewModel.squares
        collectionView.reloadData()
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
        let myCell = collectionView.myDequeueReusableCell(type: CollectionViewCell.self, indePath: indexPath)
        myCell.setupCell(with: totalSquares[indexPath.item])
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
        for day in weekDay {
            let label = UILabel()
            label.text = day.rawValue
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }

    func addSubViews() {
        let arraySubViews = [leftButton, dateLabel,
                             rightButton, stackView, collectionView]
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
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: fetchCallendarViewHeight())
        ])
    }
}
