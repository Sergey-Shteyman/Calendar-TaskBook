//
//  DateHelper.swift
//  TaskBook
//
//  Created by Сергей Штейман on 01.05.2022.
//

import Foundation

// MARK: - DateHelperProtocol
protocol DateHelperProtocol: AnyObject {
    func formateDateToString(dateFormat: String,
                             localeIdentifire: String,
                             timeZoneSeconds: Int, date: Date) -> String
}

// MARK: - DateHelper
final class DateHelper {
    
    let dateFormater = DateFormatter()
}

// MARK: - DateHelperProtocol Impl
extension DateHelper: DateHelperProtocol {
    
    func formateDateToString(dateFormat: String,
                             localeIdentifire: String,
                             timeZoneSeconds: Int, date: Date) -> String {
        dateFormater.dateFormat = dateFormat
        dateFormater.locale = Locale(identifier: localeIdentifire)
        dateFormater.timeZone = TimeZone(secondsFromGMT: timeZoneSeconds)
        return dateFormater.string(from: date)
    }
}
