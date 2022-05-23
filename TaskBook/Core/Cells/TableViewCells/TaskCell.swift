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
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 7
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.textAlignment = .center
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
    func setupCellConfiguration(_ viewModel: ShortTaskViewModel) {
        titleLabel.text = viewModel.name
        setupTime(viewModel: viewModel)
    }
}

// MARK: - Private Methods
private extension TaskCell {
    func setupCell() {
        backgroundColor = .white
        addSubViews()
        addConstraints()
    }
    
    func setupTime(viewModel: ShortTaskViewModel) {
        if viewModel.time == TaskElements.timeTitle {
            timeLabel.text = "Time"
        } else {
            timeLabel.text = viewModel.time
        }
    }
    
    func addSubViews() {
        let arraySubViews = [titleLabel, timeLabel]
        myAddSubViews(from: arraySubViews)

    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 55),
            timeLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
