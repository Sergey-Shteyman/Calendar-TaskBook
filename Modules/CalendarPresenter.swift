//
//  CalendarPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 20.04.2022.
//

import Foundation

// MARK: - CalendarPresenterProtocol
protocol CalendarPresenterProtocol: AnyObject {
    
}

// MARK: - CalendarPresenter
final class CalendarPresenter {
    
    var viewController: CalendarViewController?
    
    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - CalendarPresenterProtocol Impl
extension CalendarPresenter: CalendarPresenterProtocol {
    
}
