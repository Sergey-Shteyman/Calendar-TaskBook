//
//  ContainerViewModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 28.04.2022.
//

struct Section {
    let type: SectionType
    let rows: [RowType]
}

enum SectionType {
    case calendar
    case tasks
}

enum RowType {
    case calendar(viewModel: CalendarViewModel)
    case task(viewModel: TaskViewModel)
}
