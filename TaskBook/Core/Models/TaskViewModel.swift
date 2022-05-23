//
//  TaskViewModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 28.04.2022.
//

// MARK: - TaskViewModel
/// ViewModel для отображения данных на TaskViewController
struct TaskViewModel {
    let id: String
    var name: String
    var time: String
    let date: String
    var description: String
    
    init(id: String,
         name: String,
         time: String,
         date: String,
         description: String) {
        self.id = id
        self.name = name
        self.time = time
        self.date = date
        self.description = description
    }
    
    init(taskModel: TaskModel) {
        id = taskModel.id
        name = taskModel.name
        time = taskModel.time
        date = ""
        description = taskModel.description
    }
}
