//
//  ContainerViewModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 28.04.2022.
//

// MARK: - Section
struct Section {
    let type: SectionType
    let rows: [RowType]
}

// MARK: - SectionType
enum SectionType {
    case calendar
    case newTask
    case tasks
}

// MARK: - RowType
enum RowType {
    case calendar(viewModel: CalendarViewModel)
    case newTask
    case task(viewModel: TaskViewModel)
}
