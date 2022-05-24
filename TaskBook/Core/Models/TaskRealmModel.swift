//
//  RealmModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 18.05.2022.
//

import RealmSwift

// MARK: - TaskRealmModel
/// Модель для работы с REALM
final class TaskRealmModel: Object {
    @objc dynamic var taskId = ""
    @objc dynamic var date = Date()
    @objc dynamic var taskName = ""
    @objc dynamic var taskTime = ""
    @objc dynamic var descriptionTask = ""
    
    convenience init(taskId: String,
                     date: Date,
                     taskName: String,
                     taskTime: String,
                     descriptionTask: String) {
        self.init()
        self.taskId = taskId
        self.date = date
        self.taskName = taskName
        self.taskTime = taskTime
        self.descriptionTask = descriptionTask
    }
    
    convenience init(taskModel: TaskModel) {
        self.init()
        self.taskId = taskModel.id
        self.date = taskModel.date
        self.taskName = taskModel.name
        self.taskTime = taskModel.time
        self.descriptionTask = taskModel.description
    }
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
}
