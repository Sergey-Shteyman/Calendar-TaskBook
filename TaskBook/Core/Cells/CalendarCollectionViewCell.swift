//
//  CalendarCollectionViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

// MARK: - CalenderViewCell
final class CalenderViewCell: UICollectionViewCell {
    
    private lazy var dayOfMonth: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
}

// MARK: - publick Methods
extension CalenderViewCell {

    func setupCell(with dayOfMonth: String) {
        self.dayOfMonth.text = dayOfMonth
        setupCellConfiguration()
    }
}

// MARK: - Private Methods
private extension CalenderViewCell {

    func setupCellConfiguration() {
        addSubViews()
        addConstraints()
    }

    func addSubViews() {
        myAddSubView(dayOfMonth)
    }

    func addConstraints() {
        let frameHeight = frame.height
        let padding = frameHeight * 0.25
        NSLayoutConstraint.activate([
            dayOfMonth.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfMonth.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -padding)
        ])
    }
}
