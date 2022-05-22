//
//  CalendarCollectionViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

// MARK: - CalenderViewCell
final class CollectionViewCell: UICollectionViewCell {
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - publick Methods
extension CollectionViewCell {
    
    func setupCellWith(viewModel: CollectionViewCellViewModel) {
        dayLabel.text = viewModel.value
        if viewModel.isSelected {
            setupLayer()
            backgroundColor = .systemRed
            dayLabel.textColor = .white
        } else {
            backgroundColor = .white
            if viewModel.isWeekend {
                dayLabel.textColor = .gray
            } else {
                dayLabel.textColor = .black
            }
        }
    }
}

// MARK: - Private Methods
private extension CollectionViewCell {

    func setupCellConfiguration() {
        addSubViews()
        addConstraints()
    }
    
    func setupLayer() {
        let cornerMultiplire: CGFloat = 2
        self.layer.cornerRadius = frame.width / cornerMultiplire
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 7
        self.layer.masksToBounds = true
    }

    func addSubViews() {
        contentView.myAddSubView(dayLabel)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
