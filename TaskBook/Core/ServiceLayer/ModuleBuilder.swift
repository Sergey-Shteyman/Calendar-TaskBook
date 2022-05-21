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
    func buildTaskModule(state: TaskViewControllerState,
                         taskModel: TaskModel?,
                         selectedDate: Date) -> TaskViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {

    private let calendarHelper: CalendarHelperProtocol
    private let dateHelper: DateHelperProtocol
    private let userDefaults: UserDefaultsManagerProtocol
    private let realmService: RealmServiceProtocol

    init() {
        calendarHelper = CalendarHelper()
        dateHelper = DateHelper()
        userDefaults = UserDefaultsManager()
        realmService = RealmService()
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {

    func buildContainerModule() -> ContainerViewController {
        let viewController = ContainerViewController()
        let presenter = ContainerPresenter(moduleBuilder: self,
                                           calendarHelper: calendarHelper,
                                           dateHelper: dateHelper,
                                           realmService: realmService)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildTaskModule(state: TaskViewControllerState,
                         taskModel: TaskModel? = nil,
                         selectedDate: Date) -> TaskViewController {
        let viewController = TaskViewController()
        viewController.setupScreenState(state)
         let presenter = TaskPresenter(moduleBuilder: self, userDefaults: userDefaults, taskModel: taskModel, selectedDate: selectedDate)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
