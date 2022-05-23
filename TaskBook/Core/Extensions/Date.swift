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
        dateComponents.timeZone = NSTimeZone.local
        return calender.date(from: dateComponents) ?? Date()
    }
    
    func stripTime() -> Date {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
            let date = Calendar.current.date(from: components)
            return date!
        }
    
    func localDate() -> Date {
        let nowUTC = Date().onlyDate
            let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
            return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC)!
        }
}
