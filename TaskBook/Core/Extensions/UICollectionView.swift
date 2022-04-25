//
//  UICollectionView.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

extension UICollectionView {

    func myRegister(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.myReuseId)
    }

    func myDequeueReusableCell<T: UICollectionViewCell>(type: T.Type, indePath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.myReuseId, for: indePath) as? T else {
            fatalError("\(String(describing: type)) not found")
        }
        return cell
    }
}
