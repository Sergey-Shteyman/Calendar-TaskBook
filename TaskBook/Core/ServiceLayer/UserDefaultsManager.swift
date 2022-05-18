//
//  UserDefaultsManager.swift
//  TaskBook
//
//  Created by Сергей Штейман on 08.05.2022.
//

import Foundation

// MARK: - UserDefaultsKey
enum UserDefaultsKey: String {
    case userDate = "userDate"
    case userTaskName = "taskName"
    case userTime = "time"
    case userDescription = "description"
}

// MARK: - UserDefaultsManagerProtocol
protocol UserDefaultsManagerProtocol: AnyObject {
    func save(_ value: Any, for key: UserDefaultsKey)
    func fetch<T: Decodable>(type: T.Type, for key: UserDefaultsKey) -> T?
}

// MARK: - UserDefaultsManager
final class UserDefaultsManager {
    
}

// MARK: - UserDefaultsManagerProtocol
extension UserDefaultsManager: UserDefaultsManagerProtocol {
    
    func save(_ value: Any, for key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func fetch<T: Decodable>(type: T.Type, for key: UserDefaultsKey) -> T? {
        UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
}
