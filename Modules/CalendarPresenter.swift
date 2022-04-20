//
//  CalendarPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 20.04.2022.
//

import Foundation
import UIKit

// MARK: - CalendarPresenterProtocol
protocol CalendarPresenterProtocol: AnyObject {
    
}
// MARK: - CalendarPresenter
final class CalendarPresenter {
    
    var viewController: CalendarViewController?
    
    private let moduleBuilder: Buildable
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var weekDayStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - CalendarPresenterProtocol Impl
extension CalendarPresenter: CalendarPresenterProtocol {
    
}
