//
//  ShortTaskViewModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 11.05.2022.
//

// MARK: - ShortTaskViewModel
///  ViewModel для ячейки с задачей
struct ShortTaskViewModel {
    let name: String
    let time: String
    
    init(name: String,
         time: String) {
        self.name = name
        self.time = time
    }
    
    init(taskModel: TaskModel) {
        name = taskModel.name
        time = taskModel.time
    }
}
