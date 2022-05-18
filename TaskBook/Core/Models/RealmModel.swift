//
//  RealmModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 18.05.2022.
//

import RealmSwift

final class RealModel: Object {
    @objc dynamic var taskId = ""
    @objc dynamic var taskName = ""
    
    convenience init(taskId: String, taskName: String) {
        self.init()
        self.taskId = taskId
        self.taskName = taskName
    }
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
}
