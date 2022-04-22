//
//  CalendarPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 20.04.2022.
//

import Foundation

// MARK: - CalendarPresenterProtocol
protocol CalendarPresenterProtocol: AnyObject {
    func changeToNextMonth()
    func changeToPreviousMonth()
}
// MARK: - CalendarPresenter
final class CalendarPresenter {
    
    var viewController: CalendarViewController?
    
    private let moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    
    init(calendarHelper: CalendarHelperProtocol,
         moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
        self.calendarHelper = calendarHelper
    }
}

// MARK: - CalendarPresenterProtocol Impl
extension CalendarPresenter: CalendarPresenterProtocol {
    func changeToNextMonth() {
        viewController?.showCurrentMonth()
    }
    
    func changeToPreviousMonth() {
        viewController?.showCurrentMonth()
    }
}
