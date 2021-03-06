//
//  TaskModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 19.05.2022.
//

import Foundation

// MARK: - TaskModel
/// Модель работы с сырыми данными в презенторе 
struct TaskModel {
    let id: String
    var date: Date
    var name: String
    var time: String
    var description: String
    
    init(id: String, date: Date, name: String, time: String, description: String) {
        self.id = id
        self.date = date
        self.time = time
        self.name = name
        self.description = description
    }
    
    init(taskRealmModel: TaskRealmModel) {
        self.id = taskRealmModel.taskId
        self.date = taskRealmModel.date
        self.name = taskRealmModel.taskName
        self.time = taskRealmModel.taskTime
        self.description = taskRealmModel.descriptionTask
    }
}
