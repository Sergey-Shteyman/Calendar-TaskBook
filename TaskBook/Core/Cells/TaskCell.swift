//
//  TaskCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 27.04.2022.
//

import UIKit

// MARK: - TaskViewCell
final class TaskCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publick Methods
extension TaskCell {
    func setupCellConfiguration(_ viewModel: TaskViewModel) {
        
    }
}

// MARK: - Private Methods
private extension TaskCell {
    func setupCell() {
        addSubViews()
        addConstraints()
    }
    
    func addSubViews() {
        let arraySubViews = [label]
        contentView.myAddSubViews(from: arraySubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}