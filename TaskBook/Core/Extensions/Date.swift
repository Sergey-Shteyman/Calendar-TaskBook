//
//  Date.swift
//  TaskBook
//
//  Created by Сергей Штейман on 21.05.2022.
//

import Foundation

extension Date {

    var onlyDate: Date {
        let calendar = Calendar.current
        guard let currentDay = calendar.date(byAdding: .day, value: 0, to: self) else {
            return Date()
        }
        let components = Calendar.current.dateComponents([.year, .month, .day], from: currentDay)
        guard let date = Calendar.current.date(from: components) else {
            return Date()
        }
        return date
    }
    
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        guard let date = date else {
            return Date()
        }
        return date
    }
    
    func localDate() -> Date {
        let nowUTC = Date().stripTime()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC)!
    }
    
    func toCurrentTimezone() -> Date {
        let timeZoneDifference =
        TimeInterval(TimeZone.current.secondsFromGMT())
        return self.addingTimeInterval(timeZoneDifference)
    }
    
    func getOnlyDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: self)
        guard let date = dateFormatter.date(from: stringDate) else {
            return Date()
        }
        return date
    }
}
