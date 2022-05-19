//
//  TaskModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.05.2022.
//

import Foundation

// MARK: - TaskModel
/// Это модель с которой нужно работать в презенторе для работы с сырыми данными 
struct TaskModel {
    let id: String
    let date: Date
    let name: String
    let description: String
    
    init(id: String, date: Date, name: String, description: String) {
        self.id = id
        self.date = date
        self.name = name
        self.description = description
    }
    
    init(taskRealmModel: TaskRealmModel) {
        self.id = taskRealmModel.taskId
        self.date = taskRealmModel.date
        self.name = taskRealmModel.taskName
        self.description = taskRealmModel.descriptionTask
    }
}
