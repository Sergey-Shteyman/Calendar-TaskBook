//
//  TaskCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 27.04.2022.
//

import UIKit

// MARK: - TaskViewCell
final class TaskCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
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
        titleLabel.text = viewModel.title
    }
}

// MARK: - Private Methods
private extension TaskCell {
    func setupCell() {
        addSubViews()
        addConstraints()
    }
    
    func addSubViews() {
        let arraySubViews = [titleLabel]
        myAddSubViews(from: arraySubViews)

    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
