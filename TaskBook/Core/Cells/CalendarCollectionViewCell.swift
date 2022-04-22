//
//  CalendarCollectionViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

// MARK: - CalenderViewCell
final class CalenderViewCell: UICollectionViewCell {
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
}

// MARK: - publick Methods
extension CalenderViewCell {
    
    func setupCell() {
        backgroundColor = .systemGray6
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
        myAddSubView(date)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            date.centerXAnchor.constraint(equalTo: centerXAnchor),
            date.centerYAnchor.constraint(equalTo: centerYAnchor),
//            date.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0.5)
        ])
    }
}
