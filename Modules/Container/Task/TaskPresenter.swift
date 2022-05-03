//
//  TaskPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 03.05.2022.
//

import Foundation

// MARK: - TaskPresenterProtocol
protocol TaskPresenterProtocol: AnyObject {
    
}

// MARK: - TaskPresenter
final class TaskPresenter {
    
    weak var viewController: TaskViewController?
    private var moduleBuilder: Buildable?
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - TaskPresenterProtocol Impl
extension TaskPresenter: TaskPresenterProtocol {
   
}

// MARK: - Private Methods
private extension TaskPresenter {
    
}
