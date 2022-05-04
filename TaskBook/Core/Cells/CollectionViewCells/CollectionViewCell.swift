//
//  CalendarCollectionViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

// MARK: - CalenderViewCell
final class CollectionViewCell: UICollectionViewCell {
    
    private lazy var dayOfMonth: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        return label
    }()
}

// MARK: - publick Methods
extension CollectionViewCell {

    func setupCell(with dayOfMonth: String, color: UIColor, isSelected: Bool) {
        self.dayOfMonth.text = dayOfMonth
        self.dayOfMonth.textColor = color
        if isSelected {
            setupLayer()
            self.backgroundColor = .systemRed
        } else {
            self.backgroundColor = .white
        }
        setupCellConfiguration()
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
        contentView.myAddSubView(dayOfMonth)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            dayOfMonth.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfMonth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
