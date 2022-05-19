//
//  RealmModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 18.05.2022.
//

import RealmSwift

// MARK: - TaskRealmModel
final class TaskRealmModel: Object {
    @objc dynamic var taskId = ""
    @objc dynamic var date = Date()
    @objc dynamic var taskName = ""
//    @objc dynamic var taskTime = ""
    @objc dynamic var descriptionTask = ""
    
    convenience init(taskId: String,
                     date: Date,
                     taskName: String,
//                     taskTime: String,
                     descriptionTask: String) {
        self.init()
        self.taskId = taskId
        self.date = date
        self.taskName = taskName
//        self.taskTime = taskTime
        self.descriptionTask = descriptionTask
    }
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
}
