//
//  CalendarViewModel.swift
//  TaskBook
//
//  Created by Сергей Штейман on 28.04.2022.
//

// MARK: - CalendarViewModel
struct CalendarViewModel {
    let squares: [CollectionViewCellViewModel]
}

struct CollectionViewCellViewModel {
    let value: String
    let isWeekend: Bool
    let isSelected: Bool
}
