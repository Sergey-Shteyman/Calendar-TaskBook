//
//  Date.swift
//  TaskBook
//
//  Created by Сергей Штейман on 21.05.2022.
//

import Foundation

extension Date {

    var onlyDate: Date {
        let calender = Calendar.current
        var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = NSTimeZone.system
        return calender.date(from: dateComponents) ?? Date()
    }
}
