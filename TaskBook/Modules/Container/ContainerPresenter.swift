//
//  ContainerPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import UIKit

// MARK: - ContainerPresenterProtocol
protocol ContainerPresenterProtocol: AnyObject {
    func viewIsReady()
    func didTapNextMonthButton()
    func didTapPreviousMonthButton()
    func selectedSquere(index: Int)
    func didCreateTask(model: TaskModel)
    func didTapCreateNewTaskButton()
    func didTapTask(with index: Int)
    func deleteTask(with index: Int)
}

// MARK: - ContainerPresenter
final class ContainerPresenter {

    weak var viewController: ContainerViewControllerProtocol?

    private let moduleBuilder: Buildable
    private let calendarHelper: CalendarHelperProtocol
    private let dateHelper: DateHelperProtocol
    private let realmService: RealmServiceProtocol

    private var currentDate = Date().onlyDate
    private var selectedDate = Date().onlyDate
    private var daysOfMonth = [Date?]()
    private var squares = [(dateString: String, isSelected: Bool)]()
    private var tasks = [TaskModel]()
    private var taskModel = [TaskModel]()

    init(moduleBuilder: Buildable,
         calendarHelper: CalendarHelperProtocol,
         dateHelper: DateHelperProtocol,
         realmService: RealmServiceProtocol) {
        self.moduleBuilder = moduleBuilder
        self.calendarHelper = calendarHelper
        self.dateHelper = dateHelper
        self.realmService = realmService
    }
}

// MARK: - ContainerPresenterProtocol Impl
extension ContainerPresenter: ContainerPresenterProtocol {

    func viewIsReady() {
        updateViewController()
    }

    func didTapNextMonthButton() {
        currentDate = calendarHelper.plusMonth(date: currentDate)
        updateViewController()
    }

    func didTapPreviousMonthButton() {
        currentDate = calendarHelper.minusMonth(date: currentDate)
        updateViewController()
    }

    func selectedSquere(index: Int) {
        guard let date = daysOfMonth[index] else {
            return
        }
        selectedDate = date
        updateViewController()
    }

    func didCreateTask(model: TaskModel) {
        var index: Int?
        tasks.enumerated().forEach {
            if $1.id == model.id {
                index = $0
            }
        }
        if let index = index {
            tasks[index] = model
            updateViewController()
        } else {
            tasks.append(model)
            updateViewController()
        }
    }

    func didTapCreateNewTaskButton() {
        let taskViewController = moduleBuilder.buildTaskModule(state: .create,
                                                               taskModel: nil,
                                                               selectedDate: selectedDate)
        viewController?.routeTo(taskViewController)
    }

    func didTapTask(with index: Int) {
        let taskViewController = moduleBuilder.buildTaskModule(state: .read,
                                                               taskModel: taskModel[index],
                                                               selectedDate: selectedDate)
        viewController?.routeTo(taskViewController)
    }

    func deleteTask(with index: Int) {
        tasks.remove(at: index)
        updateViewController()
    }
}

// MARK: - Private Methods
private extension ContainerPresenter {

    func updateViewController() {
        let calendarViewModel = fetchCalendarViewModel()
        let taskViewModel = fetchTaskModel()
        let sections: [Section] = [
            .init(type: .calendar, rows: [.calendar(viewModel: calendarViewModel)]),
            .init(type: .newTask, rows: [.newTask]),
            .init(type: .tasks, rows: taskViewModel)
        ]
        viewController?.updateTableView(sections: sections)
    }

    func fetchCalendarViewModel() -> CalendarViewModel {
        fetchDaysOfMonth()
        let month = calendarHelper.monthString(date: currentDate)
        let year = calendarHelper.yearString(date: currentDate)
        let title = month + " " + year
        viewController?.updateDateLabel(with: title)
        self.squares = fetchArrayDateString(daysOfMonth, .dayFormatToOneDay, .localeIdentifireRU, 0)
        let squares = squares.enumerated().map { index, square -> CollectionViewCellViewModel in
            let isWeekend = isWeekend(index: index)
            let item = CollectionViewCellViewModel(value: square.dateString,
                                                   isWeekend: isWeekend,
                                                   isSelected: square.isSelected)
            return item
        }
        let viewModel = CalendarViewModel(squares: squares)
        return viewModel
    }

    func fetchTaskModel() -> [RowType] {
        let filteredTasks = tasks.filter { $0.date == selectedDate }
        taskModel = filteredTasks
        return filteredTasks.map { task -> RowType in
            let viewModel = ShortTaskViewModel(name: task.name,
                                               // TODO: - хелпер для перевода даты во премя
                                               time: "")
            let item = RowType.task(viewModel: viewModel)
            return item
        }
    }

    func fetchDaysOfMonth() {
        daysOfMonth.removeAll()
        let daysInMonth = calendarHelper.daysInMonth(date: currentDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: currentDate)
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
                              _ localIdentifire: DateHelperElements,
                              _ timeZoneSeconds: Int) -> [(dateString: String, isSelected: Bool)] {
        let squares = daysOfMonth.map { date -> (dateString: String, isSelected: Bool) in
            guard let date = date else {
                return ("", false)
            }
            let selectedDateString = dateHelper.formateDateToString(DateHelperElements.dayFormateFulDate.rawValue,
                                                                    localIdentifire.rawValue,
                                                                    timeZoneSeconds, selectedDate)
            let dateString = dateHelper.formateDateToString(DateHelperElements.dayFormateFulDate.rawValue,
                                                           localIdentifire.rawValue,
                                                           timeZoneSeconds, date)
            let isSelectedDay = selectedDateString == dateString
            let dayString = dateHelper.formateDateToString(dayFormat.rawValue,
                                                           localIdentifire.rawValue,
                                                           timeZoneSeconds,
                                                           date)
            return (dayString, isSelectedDay)
        }
        return squares
    }

    func isWeekend(index: Int) -> Bool {
        if Weekends.arrayWekends.contains(index) {
            return true
        }
        return false
    }
}
