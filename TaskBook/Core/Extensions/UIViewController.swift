//
//  UIViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.05.2022.
//

import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    func updateConstraints(deactivateConstraint: NSLayoutConstraint?,
                           activateConstraint: NSLayoutConstraint?) {
        guard let deactivateConstraint = deactivateConstraint,
              let activateConstraint = activateConstraint else {
            return
        }
        NSLayoutConstraint.deactivate([
            deactivateConstraint
        ])
        NSLayoutConstraint.activate([
            activateConstraint
        ])
        view.layoutIfNeeded()
    }
}
