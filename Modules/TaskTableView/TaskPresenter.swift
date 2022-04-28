//
//  TaskPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 26.04.2022.
//

import Foundation

// MARK: - TaskPresenterProtocol
protocol TaskPresenterProtocol: AnyObject {

}

// MARK: - TaskPresenter
final class TaskPresenter {

    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
    
}

// MARK: - TaskPresenterProtocol Impl
extension TaskPresenter: TaskPresenterProtocol {

}