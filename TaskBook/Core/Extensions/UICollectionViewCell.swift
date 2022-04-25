//
//  UICollectionViewCell.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

extension UICollectionViewCell {

    class var myReuseId: String {
        return String(describing: Self.self)
    }
}
