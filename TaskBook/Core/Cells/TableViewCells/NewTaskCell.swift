//
//  NewTaskCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 04.05.2022.
//

import UIKit

// MARK: - NewTaskCell
final class NewTaskCell: UITableViewCell {
    
    let newTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "N  E  W   T  A  S  K"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
}

// MARK: - Public Methods
extension NewTaskCell {
    
    func setupCellConfiguration() {
        setupCell()
    }
}

// MARK: - Private Methods
private extension NewTaskCell {
    func setupCell() {
        backgroundColor = .systemRed
        setupSubViews()
        setupConstraints()
    }
    
    func setupSubViews() {
        myAddSubView(newTaskLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newTaskLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            newTaskLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
