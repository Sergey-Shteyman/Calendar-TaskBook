//
//  TableViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 21.04.2022.
//

import UIKit

extension UITableViewCell {

    class var myReuseId: String {
        return String(describing: Self.self)
    }
}
