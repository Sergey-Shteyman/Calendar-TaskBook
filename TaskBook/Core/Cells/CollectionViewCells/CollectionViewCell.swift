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
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
}

// MARK: - publick Methods
extension CollectionViewCell {

    func setupCell(with dayOfMonth: String, color: UIColor) {
        self.dayOfMonth.text = dayOfMonth
        self.dayOfMonth.textColor = color
        setupCellConfiguration()
    }
}

// MARK: - Private Methods
private extension CollectionViewCell {

    func setupCellConfiguration() {
        addSubViews()
        addConstraints()
    }

    func addSubViews() {
        contentView.myAddSubView(dayOfMonth)
    }

    func addConstraints() {
        let frameHeight = frame.height
        let padding = frameHeight * 0.25
        NSLayoutConstraint.activate([
            dayOfMonth.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfMonth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -padding)
        ])
    }
}
