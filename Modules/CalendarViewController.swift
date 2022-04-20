//
//  CalendarViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.04.2022.
//

import UIKit

// MARK: - CalendarViewProtocol
protocol CalendarViewProtocol: AnyObject {
    
}

// MARK: - CalendarViewController
class CalendarViewController: UIViewController {
    
    var presenter: CalendarPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
}

// MARK: - CalendarViewProtocol Impl
extension CalendarViewController: CalendarViewProtocol {
    
}

