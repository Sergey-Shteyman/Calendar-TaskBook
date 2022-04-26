//
//  ModuleBuilder.swift
//  TaskBook
//
//  Created by Сергей Штейман on 20.04.2022.
//

import Foundation

// MARK: - Buildable
protocol Buildable {
    func buildContainerModule() -> ContainerViewController
    func buildCalendarModule() -> CalendarViewCell
}

// MARK: - ModuleBuilder
final class ModuleBuilder {

    private let calendarHelper: CalendarHelperProtocol

    init() {
        calendarHelper = CalendarHelper()
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {

    func buildContainerModule() -> ContainerViewController {
        let viewController = ContainerViewController()
        let presenter = ContainerPresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildCalendarModule() -> CalendarViewCell {
        let viewController = CalendarViewCell()
        let presenter = CalendarPresenter(calendarHelper: calendarHelper,
                                          moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildTaskModule() -> TaskViewController {
        let viewController = TaskViewController()
        let presenter = TaskPresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
