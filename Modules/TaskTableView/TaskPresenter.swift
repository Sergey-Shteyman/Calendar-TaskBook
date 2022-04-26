//
//  TaskPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import Foundation

// MARK: - TaskPresenterProtocol
protocol TaskPresenterProtocol: AnyObject {
    func colorView()
}

// MARK: - TaskPresenter
final class TaskPresenter {
    
    var viewController: TaskViewControllerProtocol?
    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
    
}

// MARK: - TaskPresenterProtocol Impl
extension TaskPresenter: TaskPresenterProtocol {
    func colorView() {
        viewController?.display()
    }
}
