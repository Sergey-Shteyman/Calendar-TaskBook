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
    func buildTaskModule() -> TaskViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {

    private let calendarHelper: CalendarHelperProtocol
    private let dateHelper: DateHelperProtocol
    private let userDefaults: UserDefaultsManagerProtocol

    init() {
        calendarHelper = CalendarHelper()
        dateHelper = DateHelper()
        userDefaults = UserDefaultsManager()
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {

    func buildContainerModule() -> ContainerViewController {
        let viewController = ContainerViewController()
        let presenter = ContainerPresenter(moduleBuilder: self,
                                           calendarHelper: calendarHelper,
                                           dateHelper: dateHelper)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildTaskModule() -> TaskViewController {
        let viewController = TaskViewController()
        let presenter = TaskPresenter(moduleBuilder: self, userDefaults: userDefaults)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
