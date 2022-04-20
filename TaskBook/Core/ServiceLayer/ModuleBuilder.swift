//
//  ModuleBuilder.swift
//  TaskBook
//
//  Created by Сергей Штейман on 20.04.2022.
//

import Foundation

// MARK: - Buildable
protocol Buildable {
    func buildMainModule() -> CalendarViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildMainModule() -> CalendarViewController {
        let viewController = CalendarViewController()
        let presenter = CalendarPresenter(moduleBuilder: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
