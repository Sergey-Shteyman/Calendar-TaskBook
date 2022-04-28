//
//  ContainerPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import Foundation

// MARK: - ContainerPresenterProtocol
protocol ContainerPresenterProtocol: AnyObject {
    func didTapNextMonthButton()
    func didTapPreviousMonthButton()
    func viewIsReady()
}

// MARK: - ContainerPresenter
final class ContainerPresenter {
    
    var viewController: ContainerViewControllerProtocol?
    private var moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    private var totalSquares = [String]()
    private var selectedDate = Date()
    
    init(moduleBuilder: Buildable,
         calendarHelper: CalendarHelperProtocol) {
        self.moduleBuilder = moduleBuilder
        self.calendarHelper = calendarHelper
    }
}

// MARK: - ContainerPresenterProtocol Impl
extension ContainerPresenter: ContainerPresenterProtocol {
    
    func viewIsReady() {
        let calendarViewModel = fetchCalendarViewModel()
        let sections: [Section] = [
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)])
        ]
        viewController?.updateTableView(sections: sections)
    }
    
    func didTapNextMonthButton() {
        selectedDate = calendarHelper.plusMonth(date: selectedDate)
        let calendarViewModel = fetchCalendarViewModel()
        let sections: [Section] = [
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)])
        ]
        viewController?.updateTableView(sections: sections)
    }
    
    func didTapPreviousMonthButton() {
        selectedDate = calendarHelper.minusMonth(date: selectedDate)
        let calendarViewModel = fetchCalendarViewModel()
        let sections: [Section] = [
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)])
        ]
        viewController?.updateTableView(sections: sections)
    }
}

// MARK: - Private Methods
private extension ContainerPresenter {
    
    func fetchCalendarViewModel() -> CalendarViewModel {
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
        let dateString = calendarHelper.monthString(date: selectedDate) + " " + calendarHelper.yearString(date: selectedDate)
        let result = CalendarViewModel(squares: totalSquares, title: dateString)
        return result
    }
}

struct Section {
    let type: SectionType
    let rows: [RowType]
}

enum SectionType {
    case calendar
    case tasks
}

enum RowType {
    case calendar(viewModel: CalendarViewModel)
    case task(viewModel: TaskViewModel)
}
