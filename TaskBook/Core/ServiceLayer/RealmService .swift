//
//  RealmService .swift
//  TaskBook
//
//  Created by Сергей Штейман on 18.05.2022.
//

import RealmSwift

// MARK: - RealmServiceProtocol
protocol RealmServiceProtocol {
    func create<T: Object>(_ object: T, complition: @escaping (Result<Void, Error>) -> Void)
    func read<T: Object>(_ objectType: T.Type) -> Results<T>
    func update<T: Object>(_ object: T, with dictionary: [String: Any?],
                           complition: @escaping (Result<Void, Error>) -> Void)
    func delete<T: Object>(_ object: T, complition: @escaping (Result<Void, Error>) -> Void)
//    func delete<T: Object>(type: T.Type, primaryKey: String, complition: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - RealmService
final class RealmService {
    
    var realm: Realm {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            return realm
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// MARK: - RealmServiceProtocol Impl
extension RealmService: RealmServiceProtocol {
    
    func create<T: Object>(_ object: T, complition: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(object)
                complition(.success(Void()))
            }
        } catch {
            print(error.localizedDescription)
            complition(.failure(error))
        }
    }
    
    func read<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?],
                           complition: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write({
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
                complition(.success(Void()))
            })
        } catch {
            complition(.failure(error))
        }
    }
    
    func delete<T: Object>(_ object: T, complition: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write({
                realm.delete(object)
                complition(.success(Void()))
            })
        } catch {
            complition(.failure(error))
        }
    }
    
//    func delete<T: Object>(type: T.Type, primaryKey: String, complition: @escaping (Result<Void, Error>) -> Void) {
//        do {
//            try realm.write({
//                guard let item = realm.object(ofType: type, forPrimaryKey: primaryKey) else {
//                    return
//                }
//                realm.delete(item)
//            })
//        } catch {
//            complition(.failure(error))
//        }
//    }
}
