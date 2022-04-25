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
    var selectedDate = Date()

    private let moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    private var totalSquares = [String]()

    init(calendarHelper: CalendarHelperProtocol,
         moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
        self.calendarHelper = calendarHelper
    }
}

// MARK: - CalendarPresenterProtocol Impl
extension CalendarPresenter: CalendarPresenterProtocol {

    func setMonthView() {
        totalSquares.removeAll()

        let daysInMonth = calendarHelper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)

        var count: Int = 1

        while count <= 42 {
            if count <= startingSpaces || count - startingSpaces > daysInMonth {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        viewController?.display(with: totalSquares)
        let dateString = calendarHelper.monthString(date: selectedDate) + " " + calendarHelper.yearString(date: selectedDate)
        viewController?.showCurrentMonth(with: dateString)
    }

    func changeToNextMonth() {
        selectedDate = calendarHelper.plusMonth(date: selectedDate)
        setMonthView()
    }

    func changeToPreviousMonth() {
        selectedDate = calendarHelper.minusMonth(date: selectedDate)
        setMonthView()
    }
}
