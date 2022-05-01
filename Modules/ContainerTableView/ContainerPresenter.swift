//
//  ContainerPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import Foundation

// MARK: - ContainerPresenterProtocol
protocol ContainerPresenterProtocol: AnyObject {
    func viewIsReady()
    func didTapNextMonthButton()
    func didTapPreviousMonthButton()
    func didTapDay(index: Int)
}

// MARK: - ContainerPresenter
final class ContainerPresenter {
    
    var viewController: ContainerViewControllerProtocol?
    private var moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    private var selectedDate = Date()
    private var daysOfMonth = [Date?]()
    
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
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)]),
            .init(type: .tasks, rows: [
                .task(viewModel: .init(title: "Task1")),
                .task(viewModel: .init(title: "Task2")),
                .task(viewModel: .init(title: "Task3"))
            ])
        ]
        viewController?.updateTableView(sections: sections)
    }
    
    func didTapNextMonthButton() {
        selectedDate = calendarHelper.plusMonth(date: selectedDate)
        viewIsReady()
    }
    
    func didTapPreviousMonthButton() {
        selectedDate = calendarHelper.minusMonth(date: selectedDate)
        viewIsReady()
    }
    
    func didTapDay(index: Int) {
        guard let date = daysOfMonth[index] else {
            return
        }
        print(date)
    }
}

// MARK: - Private Methods
private extension ContainerPresenter {
    
    func fetchCalendarViewModel() -> CalendarViewModel {
        fetchDaysOfMonth()
        let month = calendarHelper.monthString(date: selectedDate)
        let year = calendarHelper.yearString(date: selectedDate)
        let title = month + " " + year
        let squares = daysOfMonth.map { date -> String in
            guard let date = date else {
                return ""
            }
            // ---------
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            // ---------
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        let viewModel = CalendarViewModel(squares: squares, title: title)
        return viewModel
    }
    
    func fetchDaysOfMonth() {

        daysOfMonth.removeAll()
        let daysInMonth = calendarHelper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)

        // TODO: - убрать магические числа. Count - startElement, 42 - колличество элементов. Вынести в enum константы И сделать satic let чего то там аха, крч по уму)
        
        var count: Int = 1

        while count <= 42 {
            if count <= startingSpaces || count - startingSpaces > daysInMonth {
                daysOfMonth.append(nil)
            } else {
                let value = count - startingSpaces
                let date = Calendar.current.date(byAdding: .day, value: value, to: firstDayOfMonth)
                daysOfMonth.append(date)
            }
            count += 1
        }
    }
}
