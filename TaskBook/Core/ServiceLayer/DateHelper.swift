//
//  DateHelper.swift
//  TaskBook
//
//  Created by Сергей Штейман on 01.05.2022.
//

import Foundation

// MARK: - DateHelperProtocol
protocol DateHelperProtocol: AnyObject {
    func formateDateToString(_ dateFormat: String,
                             _ localeIdentifire: String,
                             _ timeZoneSeconds: Int, _ date: Date) -> String
}

// MARK: - DateHelper
final class DateHelper {
    
    let dateFormater = DateFormatter()
}

// MARK: - DateHelperProtocol Impl
extension DateHelper: DateHelperProtocol {
    
    func formateDateToString(_ dateFormat: String,
                             _ localeIdentifire: String,
                             _ timeZoneSeconds: Int, _ date: Date) -> String {
        dateFormater.dateFormat = dateFormat
        dateFormater.locale = Locale(identifier: localeIdentifire)
        dateFormater.timeZone = TimeZone(secondsFromGMT: timeZoneSeconds)
        return dateFormater.string(from: date)
    }
}
