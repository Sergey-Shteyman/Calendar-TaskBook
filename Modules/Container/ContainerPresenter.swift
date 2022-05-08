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
    func isWeekend(indexPath: IndexPath) -> Bool
    func currentDay() -> Int?
    func selectedSquere(index: Int)
    func fetchTaskViewController(with indexPath: IndexPath)
    func firstFetchTaskViewController(with indexPath: IndexPath)
}

// MARK: - ContainerPresenter
final class ContainerPresenter {
    
    weak var viewController: ContainerViewControllerProtocol?
    
    private let moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    private let dateHelper: DateHelperProtocol
    
    private var today: String
    private var selectedDate = Date()
    private var daysOfMonth = [Date?]()
    private var squares = [String]()
    
    init(moduleBuilder: Buildable,
         calendarHelper: CalendarHelperProtocol, dateHelper: DateHelperProtocol) {
        self.moduleBuilder = moduleBuilder
        self.calendarHelper = calendarHelper
        self.dateHelper = dateHelper
        self.today = calendarHelper.currentDateString(date: calendarHelper.currentDate())
    }
}

// MARK: - ContainerPresenterProtocol Impl
extension ContainerPresenter: ContainerPresenterProtocol {
    func firstFetchTaskViewController(with indexPath: IndexPath) {
        let taskViewController = moduleBuilder.buildTaskModule()
        viewController?.routeTo(taskViewController)
        taskViewController.presenter?.firstOpen()
    }
    
    func fetchTaskViewController(with indexPath: IndexPath) {
        let taskViewController = moduleBuilder.buildTaskModule()
        viewController?.routeTo(taskViewController)
    }
    
    func selectedSquere(index: Int) {
        if squares[index] != "" {
            self.today = squares[index]
        }
    }
    
    func currentDay() -> Int? {
        self.squares = fetchArrayDateString(daysOfMonth, .dayFormateFulDate, .localeIdentifireRU, 0)
        let currentDay = squares.firstIndex(of: today)
        guard let currentDay = currentDay else {
            return nil
        }
        return currentDay
    }
    
    func isWeekend(indexPath: IndexPath) -> Bool {
        if Weekends.arrayWekends.contains(indexPath.row) {
            return true
        }
        return false
    }
    
    func viewIsReady() {
        let calendarViewModel = fetchCalendarViewModel()
        let sections: [Section] = [
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)]),
            .init(type: .newTask, rows: [.newTask]),
            .init(type: .tasks, rows: [
                .task(viewModel: .init(nameTask: "N E W  T A S K",
                                       time: "22-00-00",
                                       date: "3-мая-2022",
                                       description: "Some Desctription"))
//                .task(viewModel: .init(title: "Task2",
//                                       time: "11-00-00",
//                                       date: "3-мая-2022",
//                                       description: "Some New Desctription"))
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
        viewController?.updateDateLabel(with: title)
        self.squares = fetchArrayDateString(daysOfMonth, .dayFormatToOneDay, .localeIdentifireRU, 0)
        let viewModel = CalendarViewModel(squares: squares)
        return viewModel
    }
    
    func fetchDaysOfMonth() {
        daysOfMonth.removeAll()
        let daysInMonth = calendarHelper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)
        
        var startElement = CalendarElements.startElement

        while startElement <= CalendarElements.numberOfElements {
            if startElement <= startingSpaces || startElement - startingSpaces > daysInMonth {
                daysOfMonth.append(nil)
            } else {
                let value = startElement - startingSpaces
                let date = Calendar.current.date(byAdding: .day, value: value, to: firstDayOfMonth)
                daysOfMonth.append(date)
            }
            startElement += 1
        }
    }
    
    func fetchArrayDateString(_ daysOfMonth: [Date?], _ dayFormat: DateHelperElements,
                              _ localIdentifire: DateHelperElements, _ timeZoneSeconds: Int) -> [String] {
        let squares = daysOfMonth.map { date -> String in
            guard let date = date else {
                return ""
            }
            let dateString = dateHelper.formateDateToString(dayFormat.rawValue,
                                                            localIdentifire.rawValue,
                                                            timeZoneSeconds,
                                                            date)
            return dateString
        }
        return squares
    }
}
