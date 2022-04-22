//
//  CalendarHelper.swift
//  TaskBook
//
//  Created by Сергей Штейман on 22.04.2022.
//

import UIKit

// MARK: - protocol CalendarHelperProtocol {
protocol CalendarHelperProtocol {
    
    func plusMonth(date: Date) -> Date
    func minusMonth(date: Date) -> Date
    func monthString(date: Date) -> String
    func yearString(date: Date) -> String
    func daysInMonth(date: Date) -> Int
    func daysOfMonth(date: Date) -> Int
    func firstOfMonth(date: Date) -> Date
    func weekDay(date: Date) -> Int
}

// MARK: - CalendarHelper
final class CalendarHelper {
    
    let calendar = Calendar.current
}

// MARK: - CalendarHelperProtocol Impl
extension CalendarHelper: CalendarHelperProtocol{
    
    func plusMonth(date: Date) -> Date {
        guard let plusMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
            return Date()
        }
        return plusMonth
    }
    
    func minusMonth(date: Date) -> Date {
        guard let minusMonth = calendar.date(byAdding: .month, value: -1, to: date) else {
            return Date()
        }
        return minusMonth
    }
    
    func monthString(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "LLLL"
        return dateFormater.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy"
        return dateFormater.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        guard let range = range else {
            return Int()
        }
        return range.count
    }
    
    func daysOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        guard let days = components.day else {
            return Int()
        }
        return days
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let date = calendar.date(from: components) else {
            return Date()
        }
        return date
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        guard let days = components.weekday else {
            return Int()
        }
        return days - 1
    }
}
